Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2278E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE1889335;
	Thu,  5 Dec 2024 10:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xu6v4Y5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3323E89361; Thu,  5 Dec 2024 10:24:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C536989335
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390648; x=1764926648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ew2+TVKpCQLyD1j3qq/BZaH0iietORl9AwC2i8AeAbQ=;
 b=Xu6v4Y5OBLD15flU4HzrDiGzu1eqloNrtajDXqDbdPRiw0zvUr33hZ9l
 paiwLwDRc6j2J/976JttpPeysgP8iTI+CTrP7HioK2x5opmUY/dfL4NGm
 PkcihO9+qiwd1GzlC2oCEdZJqSxR2hZECNNCppF+jpMK6UqOwzs2M8nZz
 Cfi9LyCgaR6IDvJ4xNv2ujhhzx7fKvhcKG8K1q0jGoX7QkIrIpvxc/VPW
 lQaspKG4idnSso7IuiLr9ggOSXioNCyuNVWvXlxy040VGKsInCGOecGg7
 rmQmW+kjLKsWnSrcI6frVbyoDz66o0Q/lqhxFk96fl3nMOTJrpN3yvH0M g==;
X-CSE-ConnectionGUID: VFe6K4p1S1q1eV9Pr1huPQ==
X-CSE-MsgGUID: FgiIti3hThOGquRcq8wu4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610245"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610245"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:07 -0800
X-CSE-ConnectionGUID: 7Fv/F/o1T/qLGi5h0NU8yA==
X-CSE-MsgGUID: wNDiOGimQHilXh/rw42JXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121859"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:03 -0800
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
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v2 07/19] drivers: mtd: nand: cadence: Add support for
 NAND_CMD_PARAM
Date: Thu,  5 Dec 2024 17:23:03 +0800
Message-Id: <20241205092315.25060-8-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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

Add support for reading param page of NAND device.
These paramaters are unique and used for identification purpose.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 83c6b64c1a..0775a8a0ce 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1970,6 +1970,30 @@ static int cadence_nand_readid(struct mtd_info *mtd, int offset_in_page, unsigne
 	return 0;
 }
 
+static int cadence_nand_param(struct mtd_info *mtd, u8 offset_in_page, unsigned int command)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(chip, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_address(chip, ONE_CYCLE, &offset_in_page);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_waitfunc(mtd, chip);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(chip, sizeof(struct nand_jedec_params), GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -1987,6 +2011,9 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		ret = cadence_nand_readid(mtd, offset_in_page, command);
 		break;
 
+	case NAND_CMD_PARAM:
+		ret = cadence_nand_param(mtd, offset_in_page, command);
+		break;
 	/*
 	 * ecc will override other command for read, write and erase
 	 */
@@ -2021,6 +2048,8 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 	if (cadence->buf_index == 0) {
 		if (cadence->cmd == NAND_CMD_READID)
 			size = 8;
+		else if (cadence->cmd == NAND_CMD_PARAM)
+			size = sizeof(struct nand_jedec_params);
 
 		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
 	}
-- 
2.19.0

