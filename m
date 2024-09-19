Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5A7CE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E35B8904B;
	Thu, 19 Sep 2024 05:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CcYUjp7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F58A89021; Thu, 19 Sep 2024 05:56:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DE18908F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718156; x=1758254156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UDt5iMSVp2B1mAhf/uYVPLiFTEjdOAiIcO9yL4iN7h0=;
 b=CcYUjp7YyCV1ujudLZ6TFFV60sUHCFDKNSKIxd80Q0m46CWXoHH9vzzq
 ONgAaw3Udn4ROp/J4QZUBcHtPWe3pEKMXqgN/Cu/n/WyhL3uXW0tt5Shh
 szkdO6oyrbBuyxlyWkCMWrMYBkZs/lEM1XahZijI8TCbuJCAQPmV9H3Po
 uuxvQ8cF3mext2lSDIepqTvg0KyqmGaRr9y5/JH63cBk3bricvVh1PvPb
 BcUZu/Mjj2pJW6m08TXfOKdceBfUbuUsjbqNI5Q97YbLFnWUKz9YevrmE
 4btifoDIU8gk805YSsHwM5rfSrgwVR9xSFqV2HfJh+qcqqHiyM0jVr6v8 g==;
X-CSE-ConnectionGUID: h/zvKljESu2XQZn+BTj8cA==
X-CSE-MsgGUID: VQO0j65ZT/uCFYhQyszB1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178003"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178003"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:55 -0700
X-CSE-ConnectionGUID: OvuEdghaTha5X49BCe/13Q==
X-CSE-MsgGUID: CraECE+WS7y1T/z7EtdsHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253741"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:50 -0700
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 06/19] drivers: mtd: nand: cadence: Add support for readid
 command
Date: Thu, 19 Sep 2024 11:54:59 +0800
Message-Id: <20240919035512.13854-7-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patch will add support for readid command in Cadence NAND driver.
The id is unique and used for flash identification.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 32 ++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 670f5ca184..55fd3dfdb3 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1919,6 +1919,27 @@ static int cadence_nand_status(struct mtd_info *mtd, unsigned int command)
 	return 0;
 }
 
+static int cadence_nand_readid(struct mtd_info *mtd, int offset_in_page, unsigned int command)
+{
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	u8 addrs = (u8)offset_in_page;
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(cadence, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_address(cadence, ONE_CYCLE, &addrs);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(cadence, 8, GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -1930,6 +1951,11 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	case NAND_CMD_STATUS:
 		ret = cadence_nand_status(mtd, command);
 		break;
+
+	case NAND_CMD_READID:
+		ret = cadence_nand_readid(mtd, offset_in_page, command);
+		break;
+
 	/*
 	 * ecc will override other command for read, write and erase
 	 */
@@ -1959,8 +1985,12 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 	u32 size = 1;
 	u8 val;
 
-	if (cadence->buf_index == 0)
+	if (cadence->buf_index == 0) {
+		if (cadence->cmd == NAND_CMD_READID)
+			size = 8;
+
 		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
+	}
 
 	val = *(&cadence->buf[0] + cadence->buf_index);
 	cadence->buf_index++;
-- 
2.26.2

