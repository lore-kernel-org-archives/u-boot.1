Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAF9E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF748948D;
	Thu,  5 Dec 2024 10:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RvIkKvV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48A689282; Thu,  5 Dec 2024 10:24:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672DF8940C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390652; x=1764926652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eeKdRVJO4kGIYBecgq9E1gLqTgjGREcOPnJEXs2KnRg=;
 b=RvIkKvV0hA4/Uu3lDdziuOoXn4LUVLOQ7pf3C1pKmYQmQUAnYIIFnE/M
 05Px0/UtSPu5OxZwr3qoMD6I4qTAxvSZqu+a6aqJN5r1XAI5tub7IJcpf
 inXluvj6cOSgP226LXnd/wvCvEnnPmNx3rMZYc0gyqNySmVIhfQvjqEv0
 tTww50bcBcHAXAWTz03hpQepN7IRoKi00NwPuILO6YnL4bsf0pUexHCpW
 eP9JB/AAzdyK1G68m3Wi/fldyKUPBQvZdrVzoL8QDbfj1mVPV2PdZwHRV
 rGBEsQbBWnaN9vjL8OwYEc1kd4pJd3XEmpwsyru+DLUqJhNzhEv1jCQQP w==;
X-CSE-ConnectionGUID: vpO4isYKRfqUe9mmkGZk/Q==
X-CSE-MsgGUID: fqG1v2FMR2aBeF27nTq2iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610255"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610255"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:12 -0800
X-CSE-ConnectionGUID: z8bVWy2jRJ6tbfX9gqMvpQ==
X-CSE-MsgGUID: YHzTZfg9SJ26cIdLB2oipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121874"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:08 -0800
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
Subject: [resend v2 08/19] drivers: mtd: nand: cadence: Add support for
 NAND_CMD_RESET
Date: Thu,  5 Dec 2024 17:23:04 +0800
Message-Id: <20241205092315.25060-9-dinesh.maniyam@intel.com>
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

Support nand reset command for Cadence Nand Driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 0775a8a0ce..74926560ad 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1994,6 +1994,22 @@ static int cadence_nand_param(struct mtd_info *mtd, u8 offset_in_page, unsigned
 	return 0;
 }
 
+static int cadence_nand_reset(struct mtd_info *mtd, unsigned int command)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(chip, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_waitfunc(mtd, chip);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -2014,6 +2030,10 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	case NAND_CMD_PARAM:
 		ret = cadence_nand_param(mtd, offset_in_page, command);
 		break;
+
+	case NAND_CMD_RESET:
+		ret = cadence_nand_reset(mtd, command);
+		break;
 	/*
 	 * ecc will override other command for read, write and erase
 	 */
@@ -2021,6 +2041,12 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		break;
 	}
 
+	if (cadence->cmd == NAND_CMD_RESET) {
+		ret = cadence_nand_select_target(chip);
+		if (ret)
+			dev_err(cadence->dev, "Chip select failure after reset\n");
+	}
+
 	if (ret != 0)
 		printf("ERROR:%s:command:0x%x\n", __func__, cadence->cmd);
 }
-- 
2.19.0

