Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C4E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7363A892F0;
	Thu,  5 Dec 2024 10:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OCzTlOVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3EC38940D; Thu,  5 Dec 2024 10:24:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587F489361
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390657; x=1764926657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pb+MxktatSNPQtDqa7JHsn2RB/N5AGJBVg4C4ZzSu80=;
 b=OCzTlOVIDmpJ9fC30mhtWYf5CApOmuM6QdRO9du0McMJdEuE05zbCtEP
 i46urwv7/HMu1QvWZI0099+Eh7QuFbDDRVHxmX5WeDkMUO7EvxU6cc6ND
 wxX+NbQN3mfbkt5rwLF1U+y/d+6KO2Sz8O8nG1XwK5TE+7MxNRWIZgI+n
 l02hrf+pFMB9iyjbPAZuSvb4Yua8ccok4IsQ81BDpWg1jqbSMff7LLKTr
 OlQd6I/OR+lW55ooESyM11TEtGaSxL2uGEBEj+7Mh74mJbLd8KCFKSrDL
 GU6rF1DbCRMBFARwZyKS41BYILIBTr9Is6XVeEPH051NI7J9eq4c+c1VB g==;
X-CSE-ConnectionGUID: VyvA2zSuQzCBockd3UpAtw==
X-CSE-MsgGUID: klpAkZhYS/mWEYtLQoUFhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610285"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610285"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:17 -0800
X-CSE-ConnectionGUID: OHMjkKLrStiWKY/cIKJz3A==
X-CSE-MsgGUID: iQJ7zDptQOG1N8WtLu9+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121887"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:12 -0800
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
Subject: [resend v2 09/19] drivers: mtd: nand: cadence: Support cmd
 SET_FEATURES & GET_FEATURES
Date: Thu,  5 Dec 2024 17:23:05 +0800
Message-Id: <20241205092315.25060-10-dinesh.maniyam@intel.com>
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

Support NAND_CMD_SET_FEATURES & NAND_CMD_GET_FEATURES.
These commands is one of the basic commands of NAND. The parameters get
from these commands will be used to set timing mode
of NAND data interface.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 74926560ad..895ee77320 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -2010,6 +2010,29 @@ static int cadence_nand_reset(struct mtd_info *mtd, unsigned int command)
 	return 0;
 }
 
+static int cadence_nand_features(struct mtd_info *mtd, u8 offset_in_page, u32 command)
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
+	if (command == NAND_CMD_GET_FEATURES)
+		ret = cadence_nand_cmd_data(chip, ONFI_SUBFEATURE_PARAM_LEN,
+					    GCMD_DIR_READ);
+	else
+		ret = cadence_nand_cmd_data(chip, ONFI_SUBFEATURE_PARAM_LEN,
+					    GCMD_DIR_WRITE);
+
+	return ret;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -2034,6 +2057,11 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
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
@@ -2076,6 +2104,8 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 			size = 8;
 		else if (cadence->cmd == NAND_CMD_PARAM)
 			size = sizeof(struct nand_jedec_params);
+		else if (cadence->cmd == NAND_CMD_GET_FEATURES)
+			size = ONFI_SUBFEATURE_PARAM_LEN;
 
 		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
 	}
-- 
2.19.0

