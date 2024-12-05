Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A6E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE76A89346;
	Thu,  5 Dec 2024 10:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YB+Hss7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2AF89335; Thu,  5 Dec 2024 10:24:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBFC89346
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390639; x=1764926639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b4m5y1AH6VbM7fWJBz/iJIJlxZhYbLffhoOV3cyOzkc=;
 b=YB+Hss7Kfmn62F1s7kGBpxYc+cwnyUxDnVbwgAtUoKfekxfeyO8zIM0e
 OW9phZRDpQUo7+UKNtJyy8iN4n7Z96C34swpEzxgInl0zNXZ449T5x3mI
 JI0Xm7oRe2kV96s8j8Q67W4AB+kBVbgeXlWcOkljKDnvi8sr7BOb6Ygqu
 YaMZlFsy1yyaf7Gy8gzHa6GeYi5JpVaTRz97+y2a6wY5S9YXyr43xr89g
 kCJsYNlYf4+hFQ+q5nap+G0g31dXN+j8IhBeXwc8LZjMR9udD2QNRlVRn
 tJUVFPpOwD5XTBbAC9fPEM45hSSd1LZNRWPkRBr4M3tDQhxA+AeNnaczR w==;
X-CSE-ConnectionGUID: oe9jBTe7TPiVjImtaZHXkA==
X-CSE-MsgGUID: ZSaGjnJ5SAWFlpOVyh8LwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610202"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:23:57 -0800
X-CSE-ConnectionGUID: KWGaCRe6TaGabugrSQkxUg==
X-CSE-MsgGUID: 51EBle7DRiu2g7tc74rlTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121831"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:23:53 -0800
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
Subject: [resend v2 05/19] drivers: mtd: nand: cadence: Add support for read
 status command
Date: Thu,  5 Dec 2024 17:23:01 +0800
Message-Id: <20241205092315.25060-6-dinesh.maniyam@intel.com>
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
index 0a9e1b1822..261ca6b182 100644
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

