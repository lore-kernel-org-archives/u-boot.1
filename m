Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE8ECE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A134C8909B;
	Thu, 19 Sep 2024 05:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S7nL9Ex4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837158904E; Thu, 19 Sep 2024 05:56:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597B68901A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718161; x=1758254161;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rI5GmtRZL57cEU+XQ47zIsv3lb1MJoI0qBmWDQz12Rs=;
 b=S7nL9Ex4Q0pRiwUks8GoZjPsq3vsNOz11WSD067Tcvq5e/17z3OIrojR
 WssPN0YkujKduevMRmjArgmIgnvdnI47zCnusqV23Yn1TaC0W0rSBiZvT
 Rq+VHdDXNn0jyU4/hirzeZSVa52vJ3GA4vZJ1yaIqvVhIcwSMWZ3eb7EG
 Ktt2V/bsZXGbZUzSccuhRmv8zv2W2kEpW9wyXHJqBT5DRGjTeRYBZfZxy
 uzIcPfIEIwN7pyMZNSf0y9asulwwcwxam3lPTvQLBDX1mQfpXXkQOvpCt
 mK/9ZBAEqoKNMV6ckNqyKqJ18bZUTuekAbHt5MV0Iag0i7dtF3u9MvpPi Q==;
X-CSE-ConnectionGUID: xLvc54HiRnGhVSOgCMoTTw==
X-CSE-MsgGUID: zi1g95GZRnebcGpjpEiX3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178016"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178016"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:00 -0700
X-CSE-ConnectionGUID: vD4BPJbFS2aD/OS4VaH5kw==
X-CSE-MsgGUID: g1BkiwsBRVG964jqFLiXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253744"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:55 -0700
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
Subject: [PATCH 07/19] drivers: mtd: nand: cadence: Add support for
 NAND_CMD_PARAM
Date: Thu, 19 Sep 2024 11:55:00 +0800
Message-Id: <20240919035512.13854-8-dinesh.maniyam@intel.com>
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

This patch is to add support for reading param page of NAND device.
These paramaters are unique and used for identification purpose.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 55fd3dfdb3..1b5cda1955 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -1940,6 +1940,31 @@ static int cadence_nand_readid(struct mtd_info *mtd, int offset_in_page, unsigne
 	return 0;
 }
 
+static int cadence_nand_param(struct mtd_info *mtd, u8 offset_in_page, unsigned int command)
+{
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
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
+	ret = cadence_nand_waitfunc(mtd, chip);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(cadence, sizeof(struct nand_jedec_params), GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
@@ -1956,6 +1981,9 @@ static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		ret = cadence_nand_readid(mtd, offset_in_page, command);
 		break;
 
+	case NAND_CMD_PARAM:
+		ret = cadence_nand_param(mtd, offset_in_page, command);
+		break;
 	/*
 	 * ecc will override other command for read, write and erase
 	 */
@@ -1988,6 +2016,8 @@ static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 	if (cadence->buf_index == 0) {
 		if (cadence->cmd == NAND_CMD_READID)
 			size = 8;
+		else if (cadence->cmd == NAND_CMD_PARAM)
+			size = sizeof(struct nand_jedec_params);
 
 		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
 	}
-- 
2.26.2

