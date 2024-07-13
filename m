Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC781C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E3688875;
	Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gD+8QrNl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uHdfrpDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A3D88872; Sat, 13 Jul 2024 15:21:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32509887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyB6Fmlz9scZ;
 Sat, 13 Jul 2024 15:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZnbl5MLFqhRirDgf7MMxu+AKiOk30ZbI21XUdwwD3M=;
 b=gD+8QrNlybUN6/B2BvzdD4COs/WQ8ic+RYLhfflFLxo/UM/csD5hABjrfGznIPc0Y3dHFM
 X07lKIDda5HuSX3w67JbdRfcILg+0/OjRII1ylw0WZXFhupNJsnybon6xJ8LcMyEUjf9WP
 1+0XA2uvzntg1TsOOtDbcsUdhhMUNjsvp7XXqD2dhRPQwNhhXb2rX8ohVQhcV8lv8fbSl6
 wYTG+EGlqjVbNnqB31pkTYXfQDWStp4bxVDIWKqOuXNDhm6vcKhAnxd2yiDLOKGQ2jG+Q+
 OfEmz/vgSVSHUhnRITv+UdNdJwASTAz0Paa74iUXUCvL/LrakgKYl4BV5ZWwNQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZnbl5MLFqhRirDgf7MMxu+AKiOk30ZbI21XUdwwD3M=;
 b=uHdfrpDGKjczaAb1op5DRAO1Fn86N2MWl7ykucr9yqSxOrBSFzIxWU1pzEXo0wFuHLkpl2
 kGDfdl+/AR6zuhEaSpe4dL7/YusColZdvbCATwY1qLrj4VbLeDk8TBTAyZV0DxxvF5E8WJ
 tN9q6xdbTUzN38O2Bgt6ia7mmbBUClpQzFml2q7cho7fMExULmsAYtKCp4EM++7n9MhvMi
 2isz0O6uNCuMzOggVKPfK/iR2HlCSb3TcdApHeCef3Mr/KyilkDdbnVBLC+eRU6K2OoQzU
 r5eqJCXOMUOf98tyiiWh9Xu03p6XEExSMqwqdoW1PwcH4kirtpMt3YVPHshDQQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/45] arm: mach: at91: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:06 +0200
Message-ID: <20240713132021.57650-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db417fc8a5dd00104ad
X-MBO-RS-META: pru8r5ocge5hgbqe4tzakca3ubqgrt8i
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
 arch/arm/mach-at91/include/mach/at91_pio.h     | 1 -
 arch/arm/mach-at91/include/mach/atmel_mpddrc.h | 1 -
 arch/arm/mach-at91/mpddrc.c                    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_pio.h b/arch/arm/mach-at91/include/mach/at91_pio.h
index f51e47e55d5..6ca2c4ae6ff 100644
--- a/arch/arm/mach-at91/include/mach/at91_pio.h
+++ b/arch/arm/mach-at91/include/mach/at91_pio.h
@@ -13,7 +13,6 @@
 #ifndef AT91_PIO_H
 #define AT91_PIO_H
 
-
 #define AT91_ASM_PIO_RANGE	0x200
 #define AT91_ASM_PIOC_ASR	\
 	(ATMEL_BASE_PIO + AT91_PIO_PORTC * AT91_ASM_PIO_RANGE + 0x70)
diff --git a/arch/arm/mach-at91/include/mach/atmel_mpddrc.h b/arch/arm/mach-at91/include/mach/atmel_mpddrc.h
index 40ec87e2ff9..6beab397ae1 100644
--- a/arch/arm/mach-at91/include/mach/atmel_mpddrc.h
+++ b/arch/arm/mach-at91/include/mach/atmel_mpddrc.h
@@ -59,7 +59,6 @@ struct atmel_mpddr {
 	u32 version;		/* 0xfc: IP version */
 };
 
-
 int ddr2_init(const unsigned int base,
 	      const unsigned int ram_address,
 	      const struct atmel_mpddrc_config *mpddr_value);
diff --git a/arch/arm/mach-at91/mpddrc.c b/arch/arm/mach-at91/mpddrc.c
index ac6a719d9c0..acd7cc9301b 100644
--- a/arch/arm/mach-at91/mpddrc.c
+++ b/arch/arm/mach-at91/mpddrc.c
@@ -35,7 +35,6 @@ static int ddr2_decodtype_is_seq(const unsigned int base, u32 cr)
 	return 1;
 }
 
-
 int ddr2_init(const unsigned int base,
 	      const unsigned int ram_address,
 	      const struct atmel_mpddrc_config *mpddr_value)
-- 
2.43.0

