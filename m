Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611B8E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7874989475;
	Thu,  5 Dec 2024 10:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BsYtXn/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82259894A3; Thu,  5 Dec 2024 10:24:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B5F89440
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390672; x=1764926672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NR9uh7ZKBPcyGiXL4QWZ9aIWLgNTmeRl8Ut0k/cTFn0=;
 b=BsYtXn/BN5XSpjrr5KI/0nNvipEhAkRV+U5sqMTuE6qzZ1ZMKE4RJUkx
 RqjTIS8/jqlTaG7hKSkJDMFjBIFrQtZxvEtfbmBpE4vYgnGnCeDUKf314
 V6LcXbDoh3o+N7G9OJUwVTp+j53RpuzwF4xqU/JQrF7AQFi5ZwdlI3ppm
 Cb9mtHXbOFRD/AwHfPG9hHUH64mXVOZ767NqEtUgV1D0SPTLs6xRWdNwV
 DlXJZlUit7gxNwuIOtvmFyYVoZFmGGDFyJeooKVhvSG3uJsjHT0bZzu0i
 ou0w8jbiXh+fsqXHJOSDM2TR2zb5+wXslemnI7w9FtU0ozSQbCtM4RzzQ Q==;
X-CSE-ConnectionGUID: HUo/xyLwQayCtuQhOJ6n8A==
X-CSE-MsgGUID: 4e+XdIQ3S+OtQZIKchScrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610333"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610333"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:31 -0800
X-CSE-ConnectionGUID: dCLZb/CoRiy+Z16VxhvT4w==
X-CSE-MsgGUID: asDqj/obSJGkxHfHPePNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121957"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:27 -0800
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
Subject: [resend v2 12/19] drivers: mtd: nand: cadence: Use bounce buffer
Date: Thu,  5 Dec 2024 17:23:08 +0800
Message-Id: <20241205092315.25060-13-dinesh.maniyam@intel.com>
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

Enable nand to use bounce buffer. In bounce buffer,
read/write buf will use cadence->buf which has been allocated
using malloc. This will align the memory and avoid memory to be
allocated in different addresses.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index c1bfa46daf..71a9ea17dd 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -980,7 +980,7 @@ static int cadence_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	cadence_nand_prepare_data_size(mtd, TT_MAIN_OOB_AREA_EXT);
 
 	if (cadence_nand_dma_buf_ok(cadence, buf, mtd->writesize) &&
-	    cadence->caps2.data_control_supp) {
+	    cadence->caps2.data_control_supp && !(chip->options & NAND_USE_BOUNCE_BUFFER) {
 		u8 *oob;
 
 		if (oob_required)
@@ -1156,7 +1156,7 @@ static int cadence_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	 * is supported then transfer data and oob directly.
 	 */
 	if (cadence_nand_dma_buf_ok(cadence, buf, mtd->writesize) &&
-	    cadence->caps2.data_control_supp) {
+	    cadence->caps2.data_control_supp && !(chip->options & NAND_USE_BOUNCE_BUFFER)) {
 		u8 *oob;
 
 		if (oob_required)
@@ -1859,6 +1859,7 @@ static int cadence_nand_attach_chip(struct nand_chip *chip)
 			return ret;
 	}
 
+	chip->options |= NAND_USE_BOUNCE_BUFFER;
 	chip->bbt_options |= NAND_BBT_USE_FLASH;
 	chip->bbt_options |= NAND_BBT_NO_OOB;
 	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
-- 
2.19.0

