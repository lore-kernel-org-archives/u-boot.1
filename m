Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09377CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4762584A2C;
	Mon,  1 Jun 2026 14:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="THDetxQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E468284837; Mon,  1 Jun 2026 11:32:43 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCB584851
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49068493267so54226925e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306361; x=1780911161; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iuPXryHQ/bryXRGNBdZ0Jz9I+zP5bRyqNidfHkGhsWM=;
 b=THDetxQLBSV/Xd+U4D/vxfXFDYNIepj9f05RpvusDKvvvGRrfwMMKbUadCSCuC6vjl
 kfufR0/RJulScwBWADTFtE1D5lhtQ8bH5LMdBkFCrtyvJ9HcMI877BZaD0J8pGaL2GxR
 kwA4fv/ZHOZbnW7W+QZXzJ2dUPeRkU2qZ5EGycj9loeU3j/yRXf8WmsX6haR1SVbiZPw
 ispdT0ev1gIqw4J3SblGdNsCyoW/R1UjoaoL/zEQyIuhOPDQWz8SEW8X8Rphou225mxk
 17WalU5uEPA2PrOAgeHtjUu6ZlFw8VA+HV8lxf4NqcKDvqqGdtaUyWT0MoGQVqt+ALX7
 N++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306361; x=1780911161;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iuPXryHQ/bryXRGNBdZ0Jz9I+zP5bRyqNidfHkGhsWM=;
 b=s5cScuQlwG+wEWnj882W49xMA+/iFPZjH/dBsx0Ge6Ykp4UikjvY7UxixNsNP/uSKT
 jMPBh0B6EoROU4g7aWaJ99yLaW1BW7J+Wfl5VnhEVCMDEIdIYc8JWwlaUM7VeEYNmGwz
 IEhszuKAlXBYJ1zAa4EPw+E/8GNLfhmtsfRIduAey1TxGjG7QbqqSg1313Vx7NwCuZ4P
 sXnI0fiNOffGYsWWU7bpoM3H8GNTPgHdPxtPQIo2LRXPwJpGmhms+/bWy3cj3lSyKWNY
 Cd+GtElP509nh6AiDnTZ5wWH9FINpXg0Awb2XuQ0Av1hKZvXP4hUF57RfurOKol9rUwV
 ViKQ==
X-Gm-Message-State: AOJu0YyLjSmikojw7cjbV2fO3rDVAcLHSYqvIvhbS7pf+MwJNlVYzB90
 VBVA3ei8qbr8Dj8mnAFmA7Yf/MerL3OiMJY2E6VyNZ4OhM/l70BD/R0v4YSqYBbwD1Y=
X-Gm-Gg: Acq92OFV1s031oBvmdBM00ftATxpiVb/x1Gm0xHLc0uqYpprWG2s3SrvHzqM4SOSVaS
 DiJ0O9KCPB2U/oVlgqltiyWDsaloU4zGn41elB2NpcXxx+tpkCV3PqDF5TKcN4Sg1MPxu/jivXx
 QtAOKkE47iyj6MFZzIC59kbkO+Mfgn9GEjbbapWJBf9IADNJWjh3WI/ZwzbBhYI/L06h/zR6mwv
 JXTzYaJf5q5D0/UwzzH7tsmxoTR45ua49NQFpcSWs08QjPT/oy77APh1SIWqFd6h3iv9j1rftKN
 Z8/o2PP4aQxRWf7icFSTpLXRPweoQuYbg0X0K1qYq79JpHKtRLzxliG1hMJJ4iITm/A2zPXXVGD
 bkKG9Np/Lppf5zO5kylLgU8c1geg/OzxjYSqfotUgyht+YtItDq/zS2d8BVKCkl2QHwg8Qe5dWn
 wDXsVS0b268B4SEiTaQHZmDT9kio7pVKmdPM6wk5POeg==
X-Received: by 2002:a05:600d:8654:10b0:490:3b87:be0e with SMTP id
 5b1f17b1804b1-490a29438d5mr132282115e9.29.1780306361270; 
 Mon, 01 Jun 2026 02:32:41 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0495fcsm113503655e9.0.2026.06.01.02.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:40 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:51 +0200
Subject: [PATCH v8 16/17] arm: mach-omap2: Use dt_dir for devicetree paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-16-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
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
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+q5Ald8bXCDlV/C13PQKx+BCzn8ZOXalN45Tkz8cwi0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwMkOYhfNu7uNxQoXGS8/MmWD3Db1/w9vfuD+7sRxO
 lOM00yyo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaS1sjIcKbk0m+B9deuXNfW
 j/gYy3uvelbYTSaG2TeOdATL3X2WxMfIsGrp7Xe9Lilf1Nm75h3JPswZ8et7ZUut6IXbDXHXYtl
 b+AE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

Use dt_dir for the substitution of the DT paths to get the correct paths
even when switching to OF_UPSTREAM.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/config_secure.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
index c83ba77066951ef680c849bde7a724b967e2e196..ba57c7ecac4de36db2e040a3c25987c2af768c0a 100644
--- a/arch/arm/mach-omap2/config_secure.mk
+++ b/arch/arm/mach-omap2/config_secure.mk
@@ -104,9 +104,9 @@ ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot_HS.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
+	$(patsubst %,-b $(dt_dir)/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
 
-OF_LIST_TARGETS = $(patsubst %,arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST)))
+OF_LIST_TARGETS = $(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST)))
 $(OF_LIST_TARGETS): dtbs
 
 %.dtb_HS: %.dtb FORCE

-- 
2.53.0

