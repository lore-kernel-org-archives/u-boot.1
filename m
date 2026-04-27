Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA5FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FDE84314;
	Mon, 27 Apr 2026 14:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Crs0iDIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF78839D9; Mon, 27 Apr 2026 11:03:30 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828AF8416F
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso67262895e9.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280607; x=1777885407;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=Crs0iDIGU8t9di02BPnfEcMOlu9GMZTZ+uNWwjKE7snkwBln7IuZNKwupQx8FW+zjE
 Zv1fbvtF49DNQRtSvo+c8mC5DHEUm1SKIpKKDIdb07+moM9QwITfpzk+6fbaxwC7i6My
 z3CmynnQf8YurJxldP7oS//Ocg5sFHd2lHgjx2tWGzFUjoBmpKZ2EyHgLFwl+KvBEV8M
 Cvtfjmhdq0mXgJxhd3k0bIS42IblcwHFrbqhZ13xu/51oVZ84gcHC3yQdi2Ny/U5uOY8
 It2DQS7+CZMd38JwV7CqDawKGEylzGC3j5FnnPXFHInxo4zYs6eBGDE5XMTCu5UR8p/a
 nc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280607; x=1777885407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=B0iinyR2oJ9gz+C7IvkaSGFHEHeC7dDOXd6+wv1pNjHubNSikCi6JjYJ4xHS2xgox4
 7lopEmx6memNTvxr3JCwU5qaqhMYOTnN0wi+ahVuxf/IGLC9RH7Tjwi5BHS08TTJOWS3
 lBNvKsoKitRWHNR28PYJtegVddNrcnXbS5cy4cq1qraB85l9uHH/abdU1qyQkC3q/DQL
 kRNwfp7FNvvLDgx2Bw8UT4qMW5iT2hPk4Sqk4gxcKBgv0pfHSLqUcy4hrg/AxTxMBAwu
 s7dpnyMj+AEPUYgUrvOPwr0MJ8x2ws/EpR5jRBUgSSgNrV9DdMhO0XSXCMFk5ANVQRYU
 xIVA==
X-Gm-Message-State: AOJu0YxyxGzW+hJI9qSFWuRStvHjo79iIIkrJBqd9CRCfrwUdtO2VLj2
 HW7xKFL08lNCZVC/H41vGZ3uiklSRMMrCfN1esk68z+YszYnlfTaO2e8nNA8d7Vo2WU=
X-Gm-Gg: AeBDievI5Cjaqn0JiUP4kgCjMptZehD6V0Di1Szuw/kyQNHQMjiz1yEFABhd5g8bp4v
 wpPIwWhv0xh5PYuC5zDfR5x0SpKkH3lYxSpHLrA4rOIaxVBlVMFNcLo8Ann8dm22S+QxC3c+kEW
 UmanA2ufs8V04RnSHVReaJDGIhFmur+G5TnK9cXWqKWjbTUfVqi2ZDJTHR6rN+FycFRJ5rBXIlt
 jcNSLKzHEx/R0wB3xNVVSBx5iz1x4s5/An6t5w3d4KmC0njcbq0R74rJVyDp+157YadtoaO4TYf
 TtgXKDIYSWVSwXKaMdk6G6ZaL19xcvXR9L2IJ9tC1PNGNAb3ix9DyRBD5ZWQWT7Fm5pKp8oBaNP
 kldR3MdeWIbdFBmzKxd1DTpDTVLLN23C/9yJecN+dKQyREXsiA1qEgyTS2pS2dWlqX26+IzAjnk
 jVA8leTIJLujAX+L1+TnQ6zweXeuEjqPc=
X-Received: by 2002:a05:600c:4f8c:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48a58ae9faemr389375935e9.16.1777280606790; 
 Mon, 27 Apr 2026 02:03:26 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm73744244f8f.22.2026.04.27.02.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:26 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:25 +0200
Subject: [PATCH v7 09/14] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-9-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5Yykrkd1oSnyX7pm49x9FHg9Z9WPawInbezFIX1wlQU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3amZT9/dmTL3CtsdVfcqtzh7V/wtNXxmveDOX+fiF6
 qkrd+hHdZSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBElksy/K/kny2296e8KueV
 oh97PxteLyzcfppb5K5Hv/bxrdtesx5gZFjw3vPm49mzA9KElthO3zTrW1vsyTXPlEvfmQXq2sk
 L7+cCAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 90b341303c7309dc21b34cc01020db997f53c8f3..c3931900622957a5499fe6483473c61e3a62fff0 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -282,7 +282,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.53.0

