Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9656EC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFDF810EA;
	Wed, 26 Feb 2025 17:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Buo4+o8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C56C810EB; Wed, 26 Feb 2025 17:19:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53D48004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586762; x=1772122762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rzaxtGYo6Ms8eTzAOv4kN9CiLMpIq1gljWy7AFXJL0w=;
 b=Buo4+o8NHTHF8PbgHev4JXUwq9YsA5Ob6NnRkEci+E1ezpeTGecqk7GS
 XCOlgO8BbdJAk23OX5mlIhrdzbsGuiRW4XDtgoRT5jySTYiYnr9OeJ30J
 nNyz11z9bFemzMmFpCuYdGRWDPbtjLMEms096eZ+rNbCiVuvVmqeYPf6W
 NBuaFCq516i6lsJO9r/z0hxaFLkVQJLzP4nEgMEwzXHGLlpmqAzihwLag
 9kodcG0OKAsh2uuPtL/XgsGzrELR2oz2d1ppYblTSYKHE3BSmqFL1FIAJ
 Bfu5TZAER8CoCrX7EEyl03Lu8FJUXujD3/ZYagKu7pUhU+i3woNtChQ8F w==;
X-CSE-ConnectionGUID: 2Vd0GzEmTjaLTK5bpS7jHQ==
X-CSE-MsgGUID: mn1nXD9RTRyVivS0/iUalQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640040"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:21 -0800
X-CSE-ConnectionGUID: jGQ+1MQzSJW1C6e5YmIV7w==
X-CSE-MsgGUID: v6qdvBSTSFK1POLCmft6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602688"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:16 -0800
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
Subject: [resend v3 06/19] drivers: mtd: nand: cadence: Add support for
 NAND_CMD_PARAM
Date: Thu, 27 Feb 2025 00:18:20 +0800
Message-Id: <20250226161833.53689-7-dinesh.maniyam@intel.com>
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
index 218fd3959f..6a9d9393c7 100644
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

