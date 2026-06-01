Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C28CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199E2849E9;
	Mon,  1 Jun 2026 14:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iTYMmweV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B2E84851; Mon,  1 Jun 2026 11:32:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2F88485F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso101006555e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306349; x=1780911149; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=iTYMmweVauvRrBLgzbh3Qu4AAPQNljeC85dxyBV7ETZ6PZIaMCsMuJUoNx/IpnDT9k
 FYLdhuKp+0mMTzxkBXDLzvnrrsvjYp2ZZZkk7HrqxB5NB1nmSzUgBV+GkvWz/UAMVLin
 e5/OvTdWeV3BYCnDUjITkbbzmyppCTxhNWSz+XXJO7qJR+rBzvL7a71OmUobw98H1RZo
 0ai8/HEHJL/BbvZx62VWm8YJ00jsSAVMdogaP+F9x026VPru6d9Xs8/2yFLAiLrmnxWA
 PPMD0VStML7IvizwevFtxiDZMQ98EdAptfU4dQdvOJCgNwPjuRipYnvLP2Lg2qWslAJO
 QTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306349; x=1780911149;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=K7vLBpP8phXVQvVh95AiBEGNvt78KnvN0Pt2yfhpAmYnCGzTeGhTOebdIsPe/BVFep
 Gxsz0HBPhgrmD5dm9lw/JThCse9SQz3/QM0r6p/eUK3IxhzQfjqnH3fKkRQgCTEyXdL/
 FIsRDsAovkwcOJLfZc7In54BjKdWX8ngRzq9R9hHa32URjg/6T8CHj8aDv/Z2e9dotDn
 pCOBFQjwuMGswioIJAW+Ewes4Io0gv+Q9vmL9fRCLmejrZjQazlmQN+HoxP/Z34/feXL
 ++EgodBnzw7CZk4vo71AtBBpOJIRvHgKTkxOd4Qp8OX9uV7Mo7VhWh2Kah+z7+iq4nwe
 ClhA==
X-Gm-Message-State: AOJu0Yx2wO1lrLZg+RcpckHV9ggo512CB/CNFUcZXRPkwJSu4oGSfahP
 BfVAOakNPDEeC4x9fyGe60ttUIxVWpcqTEkLNjGNkew7+Bd0hYDM7ztYoTc4BfT2AX0=
X-Gm-Gg: Acq92OF0OaPEGwl2WMoYydfXibB0FeLxARnt+H+SHaepj6wzKjdWY/j+GhH6e2vhE8r
 My7c5skU53gF2HYXbn59OZELocz5tPBHeE5RLjzSKYtPtXXfi3uCXXDkkeUBwS0+NU0jUYLOG96
 zn2de0jwiGTDO6izL9/3TfNv/so6q/QMAgd9SH92WO1On6GK+CtW39upKk66FO33zGLSm2Eo1w+
 46vBc/ltSC8uGXXCqNR9+SlRC6ieVmyOnNvE/abBF971xrAzu6T6LUG0y30lCZJrbGwuESOxyI2
 1VnufTUvIV7DE+BDBxuiC/6GEpas7OtSdn7RmdmKt8NnmNK5ozaVrIBUUA2p1DChzPHChHR0t3e
 0ro2kzBNE2GEUmEH0DxhNXxK0qJQox7qGbn8u2dPqpGVEkOzULMhtoWm7J2YaRFJ8AM/RNNn/zQ
 inyx/XL4S4Pe2NbuoJ90HL8jtP8vktn20=
X-Received: by 2002:a05:600d:8494:10b0:490:47e3:929a with SMTP id
 5b1f17b1804b1-490a29122ffmr135998935e9.6.1780306348860; 
 Mon, 01 Jun 2026 02:32:28 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ae3901cesm6970285e9.7.2026.06.01.02.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:28 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:41 +0200
Subject: [PATCH v8 06/17] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-6-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=msp@baylibre.com;
 h=from:subject:message-id; bh=a9mNtkme71PbyJwqoxXU2jtKAgHiQS6mJbF3mtWckVE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwEQRhui4xW1v7KZ2HGqf3X1xl4OAcPm8x2XHNOMXX
 9hbK7W7o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaStYnhn85RT/HUNz+Zdbv0
 j595f5b75UGLKz/Kmk7fZL2+ep9K2h2G/7kcr0XvNexJEFErzn/dI/FajjXZJ33Bw5aib637PSd
 d4AEA
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

Currently if USB fails to probe, U-Boot does not reach the console.

This patch does not fail if USB fails to probe making it easier to debug
in case of issues.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..90b341303c7309dc21b34cc01020db997f53c8f3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,17 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
+	/*
+	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
+	 * ti-musb-wrapper that handles all usb host and gadget devices.
+	 */
 	ret = uclass_first_device_err(UCLASS_MISC, &dev);
 	if (ret)
-		return ret;
+		printf("Failed probing USB %d, continue without USB\n", ret);
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.53.0

