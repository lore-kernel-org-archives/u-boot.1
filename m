Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8905BC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D656810FC;
	Wed, 26 Feb 2025 17:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nzYgG8VV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB95D8004F; Wed, 26 Feb 2025 17:19:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DA780FF4
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586751; x=1772122751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qx+5oYd7BGh4772USy07d0K4cemC7VOV7UEWLqgpyaU=;
 b=nzYgG8VVmiQFudkMlD33ZdUDbkT7Kw5HByCAGzlAmXcrWV+TBBzoYzO3
 kRY4/yaBgvvf1h2Jeu5h7jmdeq6ODfNF/8Hdz6o/CX5ruH1+It9U/ePOE
 18bxU+GBQgnbRuOAbB+01F//QULy0VTYgGeKyDL/7M3VgSPEJt41D+OGw
 /sLDDtfhIAbaDfS4Hf2MWbKsKVbbmOB5ziigaxqmYZ7xENkxCcZ0/EoLy
 qTX+akLYwHGwsg7Lz3MTX44NUFjJNMe8xKxF3jmy7RFOkTVTHszTH3dXA
 R/iVP5phAnAYE8s+a3AjzyBv7zt6G4d3syolf1tT8SaS1RAbU6b/pqsx6 w==;
X-CSE-ConnectionGUID: dd1RbqPVSmOKDfuE6sFZig==
X-CSE-MsgGUID: hXGAl204RmqsXoEIZF+OsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41639985"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41639985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:11 -0800
X-CSE-ConnectionGUID: ablC7y6OSz2VXHWpozmJKA==
X-CSE-MsgGUID: QFwPfUEsRRiDjoS5x0Ov6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602642"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:06 -0800
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
Subject: [resend v3 04/19] drivers: mtd: nand: cadence: Add support for read
 status command
Date: Thu, 27 Feb 2025 00:18:18 +0800
Message-Id: <20250226161833.53689-5-dinesh.maniyam@intel.com>
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

Add support for read status command
in Cadence NAND driver. This status bit is important to check
whether the flash is write-protected.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 48 ++++++++++++++++++++++++++++-
 include/cadence-nand.h              |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 359cfc3b68..6baf06def4 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -344,6 +344,7 @@ static int cadence_nand_generic_cmd_send(struct cadence_nand_info *cadence,
 
 	/* Issue command. */
 	writel_relaxed(reg, cadence->reg + CMD_REG0);
+	cadence->buf_index = 0;
 
 	return 0;
 }
@@ -1932,9 +1933,43 @@ static void cadence_nand_select_chip(struct mtd_info *mtd, int chipnr)
 	}
 }
 
+static int cadence_nand_status(struct mtd_info *mtd, unsigned int command)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(chip, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(chip, 1, GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct cadence_nand_info *cadence = to_cadence_nand_info(chip->controller);
+	int ret = 0;
+
+	cadence->cmd = command;
+	switch (command) {
+	case NAND_CMD_STATUS:
+		ret = cadence_nand_status(mtd, command);
+		break;
+	/*
+	 * ecc will override other command for read, write and erase
+	 */
+	default:
+		break;
+	}
+
+	if (ret != 0)
+		printf("ERROR:%s:command:0x%x\n", __func__, cadence->cmd);
 }
 
 static int cadence_nand_dev_ready(struct mtd_info *mtd)
@@ -1952,7 +1987,18 @@ static int cadence_nand_dev_ready(struct mtd_info *mtd)
 
 static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 {
-	return 0;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct cadence_nand_info *cadence = to_cadence_nand_info(chip->controller);
+	u32 size = 1;
+	u8 val;
+
+	if (cadence->buf_index == 0)
+		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
+
+	val = *(&cadence->buf[0] + cadence->buf_index);
+	cadence->buf_index++;
+
+	return val;
 }
 
 static void cadence_nand_write_byte(struct mtd_info *mtd, u8 byte)
diff --git a/include/cadence-nand.h b/include/cadence-nand.h
index 7973e5b55b..27ed217b1e 100644
--- a/include/cadence-nand.h
+++ b/include/cadence-nand.h
@@ -454,6 +454,8 @@ struct cadence_nand_info {
 	u8 *buf;
 	u32 buf_size;
 	u8 *stat;
+	u8 cmd;
+	u32 buf_index;
 
 	u8 curr_corr_str_idx;
 
-- 
2.19.0

