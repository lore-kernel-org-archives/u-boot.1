Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6DFC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E43F811E1;
	Wed, 26 Feb 2025 17:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nm9edD+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787378004F; Wed, 26 Feb 2025 17:19:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AB08118A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586788; x=1772122788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cq1WJvQGnGmz9/e+puLQQ2j6UWUYqZpIgIUvUj2MPg0=;
 b=Nm9edD+Vvc8fcJre8vnsLPYcIrZtE4lhMFZLTSeTDSicxDUB7GRuql76
 kMaGe7+FDe2th7j2F1A9q5omMsHvz9Fbs1AYivQjI5g+KebaRfSjpmmEj
 DQaXeD5uz9EPJ52FxUcWktdo+64JoIilCywCaXTbPfD7L6Jtas6NWmb1X
 ecwN0S/OrIvm5QhVtDIX4fiH9I8B/mf6Mdno8aV9qYS2xBwXk5QD0qJvN
 bH1dYWCtNOndyHrZyTV9ELTeXHqbbI0L76NDXA4HjLLijQ4ECT2ZD1F4C
 9hYlbLrFUdAUrlS2ALQCm/UlVEhOQ/h60U6S9BGyF3Y0ygtwXUl9iHrJR w==;
X-CSE-ConnectionGUID: xoGpQLjfTyyMY38Bi4Gq+g==
X-CSE-MsgGUID: Drvevts7T1KYpqKp4xVIxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640159"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640159"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:47 -0800
X-CSE-ConnectionGUID: vHao0SknSKeW7Uag/1yH0w==
X-CSE-MsgGUID: OtrGvjooQ/CElvsOqLLeww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602795"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:42 -0800
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
Subject: [resend v3 11/19] drivers: mtd: nand: cadence: Use bounce buffer
Date: Thu, 27 Feb 2025 00:18:25 +0800
Message-Id: <20250226161833.53689-12-dinesh.maniyam@intel.com>
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
index e571e5a686..27aa7f97a4 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -980,7 +980,7 @@ static int cadence_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	cadence_nand_prepare_data_size(mtd, TT_MAIN_OOB_AREA_EXT);
 
 	if (cadence_nand_dma_buf_ok(cadence, buf, mtd->writesize) &&
-	    cadence->caps2.data_control_supp) {
+	    cadence->caps2.data_control_supp && !(chip->options & NAND_USE_BOUNCE_BUFFER)) {
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

