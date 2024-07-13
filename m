Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB9C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14BD388817;
	Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z6hYR8ZZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OJadhqO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA45887E3; Sat, 13 Jul 2024 15:21:14 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5498880C
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy06Dz8z9sWq;
 Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FA7LldlKi8bmLVQE9CjqHVMmrZw0UnLMx9xiMeBegc=;
 b=Z6hYR8ZZatIlmiodQiNRq+JhVl9qkNRY8s8jb3bHKPascgwTp6aujYB/Rek+YsDP7+kHc9
 +F1OPeMFZtzHmIA2PevT6B4aueHBiOy73K2DnTqFONMll46v7FF5/QjtJWL/lmuFUEmCN/
 /EEMjSejuqo2PqqGkNBJ7/yUeGl/9z+5zG8Q7RovpjZMgtzRhDS2sO0rXH7WjT5UoHBslf
 ePxQWnQNeGW+r+fJP6jCswwOpyJpl/B7OKCk4QQGc2h4gM9KsoHVKF2kW1Q6GRIa2RM4u7
 VmcD7bihtrusQvFETg1yeIA9QXPXx4SDquqX/M3pcEuD8QYTpSQLJbTdiy3nqg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FA7LldlKi8bmLVQE9CjqHVMmrZw0UnLMx9xiMeBegc=;
 b=OJadhqO17Oxe34UxlIb1X43C13oJibQxHKyh8YuJsrVgvq0cN6OgbzaPNU7qfq7WkRY/Pr
 baC0klKGsAP1WlQxhqFnL731EkZUCQmF7PhfpLr/lqrI3Bl5VtX4J61MZsvdUrxoyeT6xk
 vDkxVjrCmy0l1yYYa9le629UFEctNbI6GW4BdNT/1/SGSIGBpadAmrabyNzFgzxf/yb4ow
 /KrctwLwc3UiiypOyHWy7WXktH+fQtLk/jkOAFZ4YjiXEOZkTLD4PcIKsVp3+/XAok3voa
 +e4QEOxwfmCiT8CI9CvxaCFiwzZ9Er/7dCVhAVK8Z6803rU21R7q867Ztvg9iQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/45] arm: include: hisilicon: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:57 +0200
Message-ID: <20240713132021.57650-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c679ac2cfb223b2059f
X-MBO-RS-META: mrpg1otigos5gjfrg66pmxgyg7o4apz5
X-Rspamd-Queue-Id: 4WLpy06Dz8z9sWq
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-hi3798cv200/hi3798cv200.h | 1 -
 arch/arm/include/asm/arch-hi6220/hi6220.h           | 2 --
 arch/arm/include/asm/arch-hi6220/pinmux.h           | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-hi3798cv200/hi3798cv200.h b/arch/arm/include/asm/arch-hi3798cv200/hi3798cv200.h
index b98b45cc817..bcde48e4737 100644
--- a/arch/arm/include/asm/arch-hi3798cv200/hi3798cv200.h
+++ b/arch/arm/include/asm/arch-hi3798cv200/hi3798cv200.h
@@ -49,5 +49,4 @@
 #define USB2_PHY01_REFCLK_SEL		(1 << 12)
 #define USB2_PHY2_REFCLK_SEL		(1 << 14)
 
-
 #endif
diff --git a/arch/arm/include/asm/arch-hi6220/hi6220.h b/arch/arm/include/asm/arch-hi6220/hi6220.h
index 55729e306e4..6d8bba6f7eb 100644
--- a/arch/arm/include/asm/arch-hi6220/hi6220.h
+++ b/arch/arm/include/asm/arch-hi6220/hi6220.h
@@ -133,7 +133,6 @@ struct peri_sc_periph_regs {
 	u32 reserved8_addr;	/*0xd04*/
 };
 
-
 /* CTRL1 bit definitions */
 
 #define PERI_CTRL1_ETR_AXI_CSYSREQ_N			(1 << 0)
@@ -143,7 +142,6 @@ struct peri_sc_periph_regs {
 #define PERI_CTRL1_HIFI_INT_MASK_MSK			(1 << 17)
 #define PERI_CTRL1_HIFI_ALL_INT_MASK_MSK		(1 << 18)
 
-
 /* CTRL2 bit definitions */
 
 #define PERI_CTRL2_MMC_CLK_PHASE_BYPASS_EN_MMC0		(1 << 0)
diff --git a/arch/arm/include/asm/arch-hi6220/pinmux.h b/arch/arm/include/asm/arch-hi6220/pinmux.h
index d18d2142f6a..7ee51000d69 100644
--- a/arch/arm/include/asm/arch-hi6220/pinmux.h
+++ b/arch/arm/include/asm/arch-hi6220/pinmux.h
@@ -9,7 +9,6 @@
 
 #include "periph.h"
 
-
 /* iomg bit definition */
 #define MUX_M0          0
 #define MUX_M1          1
-- 
2.43.0

