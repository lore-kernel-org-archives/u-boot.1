Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05280C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5495180805;
	Wed, 26 Feb 2025 17:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bR6+Qdnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E055F80FDD; Wed, 26 Feb 2025 17:19:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E3481115
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586757; x=1772122757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=46TaIbnNuoiUEHGWsjREbCerZmka9HXXXIGqsltMhlU=;
 b=bR6+Qdnp3bor5F+MjJLZcv5YIRNaehMIPmgx5FokKSm2FagAXs5usrXH
 FuNn8TCS6nebEhSzclyf6TmTzIP0Nu8ABjrM48hi4PqzOfSrrhYKrnevR
 VWTvOtX4aOWye7tjRYYzQALuyAE40us7EOK3EOKx39rBqWWQ30I31uc9c
 n+pAQx5Q/fKEB0ToPddI4MXECbtnotAO2wEonhcx59eZC6K7bLygNoVt0
 1k4ntZmBLt+jVmdsP+ziQKqS3S795dgyZS+G7d7GqaUEeG2Nd5NN79hy/
 PsvOvlPvLDc1C1+2njcTylOGY/zGLJPocCUi3tKBJkBaO1QbktBNrGXiC w==;
X-CSE-ConnectionGUID: kTiZ8UC9Rr6TvxM/YhnXsg==
X-CSE-MsgGUID: bPRlTpXNTROOlbZAJSh7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640018"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640018"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:16 -0800
X-CSE-ConnectionGUID: OrJs3RmrTtCDEZXX/76LvQ==
X-CSE-MsgGUID: QxLQtl5gRd21Khn55HpQ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602659"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:11 -0800
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
Subject: [resend v3 05/19] drivers: mtd: nand: cadence: Add support for readid
 command
Date: Thu, 27 Feb 2025 00:18:19 +0800
Message-Id: <20250226161833.53689-6-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

Add support for readid command in Cadence NAND driver.
The id is unique and used for flash identification.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 32 ++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 6baf06def4..218fd3959f 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1949,6 +1949,27 @@ static int cadence_nand_status(struct mtd_info *mtd, unsigned int command)
 	return 0;
 }
 
+static int cadence_nand_readid(struct mtd_info *mtd, int offset_in_page, unsigned int command)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 addrs = (u8)offset_in_page;
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(chip, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_address(chip, ONE_CYCLE, &addrs);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(chip, 8, GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -1961,6 +1982,11 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
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
@@ -1992,8 +2018,12 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
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
2.19.0

