Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86227CE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9572588D28;
	Thu, 19 Sep 2024 05:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PY9endj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B3E89082; Thu, 19 Sep 2024 05:56:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E36088902
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718172; x=1758254172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HEFWI5itvTrbdR1/91okmG+assFI47kE3IqfkECalfY=;
 b=PY9endj7o/Sr2pb+FMp5155AuSocYQ9Q50E6pj3CvZfB0gbpkz8K1V3w
 aMuTRZD389eCwE1N86/X/xMQbJpr4SGXoOnCd0HWIv8POAJD4N5O/sxhg
 camMUI/f8/8G4/Nm6DPbNYrCorF+zeKMpHig3Nv301Lfm4bQI7DAx3Jqf
 qGXDtAEfBc2c/+JjKbOZQRxUmm2epVZ691rES5Lw4T7iFgGDB3hZbdMQj
 60sBPJnfeMln2jDqqKlUaHOd61sdl0y4umYQw3KqPdyQoJG4EWVuypcxL
 JfkINaK4I99TapEHOFM4Zyd74Yc7rq1yN8rNtwltwjjbCisKDzMZGWboJ Q==;
X-CSE-ConnectionGUID: oOko2sMQQQCaYBoLOEksjw==
X-CSE-MsgGUID: mrBh4lgGR+GEyPG68K+R5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178033"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:11 -0700
X-CSE-ConnectionGUID: xJKAdiPtRXae/opiENKFIg==
X-CSE-MsgGUID: 2KDbtwMPS2mNmqmfZTAjwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253771"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:06 -0700
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
Subject: [PATCH 09/19] drivers: mtd: nand: cadence: Support cmd SET_FEATURES &
 GET_FEATURES
Date: Thu, 19 Sep 2024 11:55:02 +0800
Message-Id: <20240919035512.13854-10-dinesh.maniyam@intel.com>
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

This patch is to support NAND_CMD_SET_FEATURES & NAND_CMD_GET_FEATURES.
These commands is one of the basic commands of NAND. Params get from
these commands will be used to set timing mode of NAND data interface.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 1b1335af68..108e1fa965 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1982,6 +1982,29 @@ static int cadence_nand_reset(struct mtd_info *mtd, unsigned int command)
 	return 0;
 }
 
+static int cadence_nand_features(struct mtd_info *mtd, u8 offset_in_page, u32 command)
+{
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(cadence, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_address(cadence, ONE_CYCLE, &offset_in_page);
+	if (ret)
+		return ret;
+
+	if (command == NAND_CMD_GET_FEATURES)
+		ret = cadence_nand_cmd_data(cadence, ONFI_SUBFEATURE_PARAM_LEN,
+					    GCMD_DIR_READ);
+	else
+		ret = cadence_nand_cmd_data(cadence, ONFI_SUBFEATURE_PARAM_LEN,
+					    GCMD_DIR_WRITE);
+
+	return ret;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -2006,6 +2029,11 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	case NAND_CMD_RESET:
 		ret = cadence_nand_reset(mtd, command);
 		break;
+
+	case NAND_CMD_SET_FEATURES:
+	case NAND_CMD_GET_FEATURES:
+		ret = cadence_nand_features(mtd, offset_in_page, command);
+		break;
 	/*
 	 * ecc will override other command for read, write and erase
 	 */
@@ -2046,6 +2074,8 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 			size = 8;
 		else if (cadence->cmd == NAND_CMD_PARAM)
 			size = sizeof(struct nand_jedec_params);
+		else if (cadence->cmd == NAND_CMD_GET_FEATURES)
+			size = ONFI_SUBFEATURE_PARAM_LEN;
 
 		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
 	}
-- 
2.26.2

