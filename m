Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93648C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C3B81F6B;
	Thu, 27 Mar 2025 16:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C33F81F59; Thu, 27 Mar 2025 16:33:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 220DC81ECD
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C13941655;
 Thu, 27 Mar 2025 08:33:54 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079083F694;
 Thu, 27 Mar 2025 08:33:47 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 15/18] mtd: rawnand: nand_base: annotate switch/case
 fallthrough
Date: Thu, 27 Mar 2025 15:33:10 +0000
Message-Id: <20250327153313.2105227-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
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

The raw NAND flash code uses an implicit switch/case fallthrough to
share code when dealing with different ECC modes, and also when handling
some read command.

Add our "fallthrough;" statement-like macro before the respective labels
in the NAND code, to avoid a warning when GCC's -Wimplicit-fallthrough
warning option is enabled.

This copies the fallthrough annotations that the original kernel code
gained, before this function got refactored there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mtd/nand/raw/nand_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 1b65c6f6443..daf12807c67 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -774,6 +774,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 			       NAND_NCE | NAND_CTRL_CHANGE);
 
 		/* This applies to read commands */
+		fallthrough;
 	default:
 		/*
 		 * If we don't have access to the busy pin, we apply the given
@@ -4974,6 +4975,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 		if (!ecc->read_page)
 			ecc->read_page = nand_read_page_hwecc_oob_first;
 
+		fallthrough;
 	case NAND_ECC_HW:
 		/* Use standard hwecc read page function? */
 		if (!ecc->read_page)
@@ -4993,6 +4995,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
 			ecc->write_subpage = nand_write_subpage_hwecc;
 
+		fallthrough;
 	case NAND_ECC_HW_SYNDROME:
 		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
 		    (!ecc->read_page ||
@@ -5027,6 +5030,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 			ecc->size, mtd->writesize);
 		ecc->mode = NAND_ECC_SOFT;
 
+		fallthrough;
 	case NAND_ECC_SOFT:
 		ecc->calculate = nand_calculate_ecc;
 		ecc->correct = nand_correct_data;
-- 
2.25.1

