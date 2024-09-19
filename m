Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D60CE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E838902D;
	Thu, 19 Sep 2024 05:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XQAwV6KT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5048900B; Thu, 19 Sep 2024 05:56:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B3E89094
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718167; x=1758254167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SNKn0PIvWUj8ZkfSVGosqMerpY5WTU80p0GfhnI29tA=;
 b=XQAwV6KTw+a70ShxEFYVJfiSmKURsZdOzJQjx6VtxdiUnWTBTRQktYtW
 RTrAnqBvYUQ47h7lm1CzthcIgT8SUDfSXmrYYNpqPmpwHxf3JptfjJRrW
 WK23OCUoig0hR+/B9n0SBJpfp2scN17lBfy9BUhvjNBZCIdxE0DiqnQfz
 Oo/uet0HR32YN46hjWmDA1daHRtj14xoJJHfAB6VNoAqQL5B7TWfnIC1+
 6Gm1056CEWkCh8dF+WKpwuYdkX2lH77TT/UO0BuKU2KoJ83yWp2SD5k8f
 2eJRdnd32xFyFEgtwtAOZb6vgqsPTDN6h0FHkVPzP9I65O+QrmH4r4WpD Q==;
X-CSE-ConnectionGUID: MCQHB7O7Rt+vLoCOsKFtEw==
X-CSE-MsgGUID: B4cJlPDPQp+1YPuH2knNjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178019"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:06 -0700
X-CSE-ConnectionGUID: m0t1kQagTFS8s5Ka9a0zPw==
X-CSE-MsgGUID: RM15bO0CSNOYB8EI0O3koA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253747"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:01 -0700
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
Subject: [PATCH 08/19] drivers: mtd: nand: cadence: Support NAND_CMD_RESET
Date: Thu, 19 Sep 2024 11:55:01 +0800
Message-Id: <20240919035512.13854-9-dinesh.maniyam@intel.com>
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

The patch is to support nand reset command for Cadence Nand Driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 1b5cda1955..1b1335af68 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1965,10 +1965,28 @@ static int cadence_nand_param(struct mtd_info *mtd, u8 offset_in_page, unsigned
 	return 0;
 }
 
+static int cadence_nand_reset(struct mtd_info *mtd, unsigned int command)
+{
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(cadence, command);
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
 	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret = 0;
 
 	cadence->cmd = command;
@@ -1984,6 +2002,10 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
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
@@ -1991,6 +2013,12 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		break;
 	}
 
+	if (cadence->cmd == NAND_CMD_RESET) {
+		ret = cadence_nand_select_target(cadence, chip);
+		if (ret)
+			dev_err(cadence->dev, "Chip select failure after reset\n");
+	}
+
 	if (ret != 0)
 		printf("ERROR:%s:command:0x%x\n", __func__, cadence->cmd);
 }
-- 
2.26.2

