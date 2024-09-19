Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FDCE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA97890B9;
	Thu, 19 Sep 2024 05:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HhfSNx2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0227A89098; Thu, 19 Sep 2024 05:56:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F67890C6
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718190; x=1758254190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QVNPvwUL7ywwmHomdJxpIkAmH7BFWJQVi5sRCQOZhnA=;
 b=HhfSNx2PedynHvkbSHRzOkuJzhX8cZFNYa3ObzAj+CM/JxiEhAlJULGa
 S2+K4bpfh8lsmIOYzh49FRb8vjyAcQcGtvoPV97VA4Cmy7VwlEJ1ywnGb
 85DwyGasiSEyK3PgPdVxur2OPaw3zA/xBZyRwnnGxgOwkIAgOI85GmNbR
 11MmSuDmlXjSiA4W/nfdEUf7cmW6NUcDDe4uZAyXmYzjUUC36bE3gXToE
 RHgf6fvPrRGWAYEPreNgRdVXtXE/EN5m0qKN6SK2/rEfjBWZeot7U0UIZ
 xHfwS/MmweDC/yHgXVHKoaoa16JnUi897/IL/lwi+qTCwc2ljEwuyEybY g==;
X-CSE-ConnectionGUID: gPgo5gjGTuOmlTfQ2yCcRA==
X-CSE-MsgGUID: n7ikk1twSR6LzUrVudm/OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178065"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178065"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:28 -0700
X-CSE-ConnectionGUID: JuanI8CWR8CTbnBQNFyaZA==
X-CSE-MsgGUID: VsfJ0gxCRu2X7MroUvq8Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253867"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:23 -0700
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
Subject: [PATCH 12/19] drivers: mtd: nand: cadence: Use bounce buffer
Date: Thu, 19 Sep 2024 11:55:05 +0800
Message-Id: <20240919035512.13854-13-dinesh.maniyam@intel.com>
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

The patch is to enable nand to use bounce buffer. In bounce buffer,
read/write buf will use cadence->buf which has been allocated
using malloc. This will align the memory and avoid memory to be
allocated in different addresses.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 33e8b79520..9a26bdba8c 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -965,7 +965,7 @@ static int cadence_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	cadence_nand_prepare_data_size(mtd, TT_MAIN_OOB_AREA_EXT);
 
 	if (cadence_nand_dma_buf_ok(cadence, buf, mtd->writesize) &&
-	    cadence->caps2.data_control_supp) {
+	    cadence->caps2.data_control_supp && !(chip->options & NAND_USE_BOUNCE_BUFFER) {
 		u8 *oob;
 
 		if (oob_required)
@@ -1132,7 +1132,7 @@ static int cadence_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	 * is supported then transfer data and oob directly.
 	 */
 	if (cadence_nand_dma_buf_ok(cadence, buf, mtd->writesize) &&
-	    cadence->caps2.data_control_supp) {
+	    cadence->caps2.data_control_supp && !(chip->options & NAND_USE_BOUNCE_BUFFER)) {
 		u8 *oob;
 
 		if (oob_required)
@@ -1824,6 +1824,7 @@ static int cadence_nand_attach_chip(struct mtd_info *mtd, struct nand_chip *chip
 			return ret;
 	}
 
+	chip->options |= NAND_USE_BOUNCE_BUFFER;
 	chip->bbt_options |= NAND_BBT_USE_FLASH;
 	chip->bbt_options |= NAND_BBT_NO_OOB;
 	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
-- 
2.26.2

