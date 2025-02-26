Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50A9C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C06810F2;
	Wed, 26 Feb 2025 17:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DmzalzC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EA581119; Wed, 26 Feb 2025 17:19:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B892181101
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586767; x=1772122767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xZXHMUCfYJH05zQ5025eWvd5Lu9uT/svHtzuzHw0v6I=;
 b=DmzalzC4aGOtJftGhfDpZPldCsb086gqcmFQZKuuEXsl5IVw8bro0+iL
 MQSJzgNS1lJ3LG2xdgR3HH0AXod99Yt0k5eKeztntXkxfDfNqeMCnft7k
 TrAz6PxUoC5HQP6EFnXJBqOVaMmxu3OQla7xOn32Jm/P2vYd1GDsCw1O4
 5cK0xqDX+u60cI/H8owfvPdvoYOQztKSAZ4GcIhNXkxutTGdjJHI4eQAc
 prSA4t8G2hJtdsAr+d/DsbOWx/S2uSyXMwZsWAciy8GVDEJTI8ChlKSJ6
 ZYD2fLFt0eahUlOVLkcPLwh2Hcdka2DKx4UVGb4D7GKLlw+ThaZOfwa7F g==;
X-CSE-ConnectionGUID: oaPNMMUCTw+CnnuWDOuvIw==
X-CSE-MsgGUID: B4hNDytTTnyUg59S0kFshQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640061"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640061"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:26 -0800
X-CSE-ConnectionGUID: UjKpTbKXS+Wxa2ZLDPSp7g==
X-CSE-MsgGUID: MgEzjOymR2O0t+qRaQehBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602724"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:22 -0800
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
Subject: [resend v3 07/19] drivers: mtd: nand: cadence: Add support for
 NAND_CMD_RESET
Date: Thu, 27 Feb 2025 00:18:21 +0800
Message-Id: <20250226161833.53689-8-dinesh.maniyam@intel.com>
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
index 6a9d9393c7..720b0ebd6a 100644
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

