Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6615AFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E460484329;
	Mon, 27 Apr 2026 14:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xcT5yWWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413358416F; Mon, 27 Apr 2026 11:03:34 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D1E841DF
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so49570575e9.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280608; x=1777885408;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfbfH8v4xySYdPtSrwrUYkHcl/53g9TkVInwERrltt4=;
 b=xcT5yWWGiRtmlavruteSDQ40frUWGXp6lr1AyHcr6/KS7/NgyYOOOv8nqT3j0q3jpH
 hbNX0kZlGu9Ly79n5tWySth18whnSAoXHdun93UQOzkdqZnRcZ+1lHObTxuGiOkrEHVV
 PNtn9byB4WNmaexEvuoKEfc699a5vURtMN3h7s5LKGfQXE/cBKkku/467Ql/lxt7luJq
 u2duF9MlsiK9B8ICrQPok4b3or97KIaWrozGe6wSHCAmWNzBqfgk3YgQqBIOMnOkI3R7
 G+vRsjeuHM/lGivswj2q+MqogLzCA02MPptvpPFdMEtMuzR/ae39yZKdchQnNrHoRBUW
 GEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280608; x=1777885408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dfbfH8v4xySYdPtSrwrUYkHcl/53g9TkVInwERrltt4=;
 b=GY3gi4b9C1sT//XmTZwlKCEr2fupNn5qVlXO9AhXfjmHKUs1sAJWsXNH+uZ3ZYqaIh
 HV23SBdH4fTE9t95TD66vrkzNCo0NxMH8uiYLR1t0H1X4Jot//jNrPQ000OlIo4hr1of
 vnKfOOMZ6ZRSFeX48jSCMzTjE6Fm+S0cTyvH4UObwJKIB4dHBvqD71+lDhZZm9yK8eNn
 dPx4c/q743dhh4aWReiqeZsmrrxHixWtlSbHTBvFITGKAsTC41eeUGcDcvrB/7SRCLs/
 d44d3BCmIKivfD1fgMpt05cNeiKqYGkXWdyFaeurSTHnPcsWyTTUU021Ha+yL3TSzSTN
 JYew==
X-Gm-Message-State: AOJu0YxfsW0eIUYb3sYPDhXSYEJzVlo1h9J5fj43g/E+6VFSNOhVx+29
 FoBKyvuAc5VtwA95k8NWphNElgPRSuVicD4g+hltXo8HACUD8HGyhPzLxncuvIfY4RE=
X-Gm-Gg: AeBDieuEFG8XKajGLaB/TIHkUr0o5euaMm1Ij81rma6VX1xARG8lkOc2IY2BbvZ76fH
 Bl4jMAA/YRfp2cGB3Eei2hc26ke/pZw5MsT9bjuyndNraP/8gL4XhbFO/Bae2mG+GZb4qYanB1u
 clDFKHu4bCEX7l5s6fCvz1dxNel+HysC++wEpOKDC8RrOlrLf7uxyGdvkcn/WsARCSudcAA4zhV
 +OpvXOQ7TRafCutCFCsByi4OzOvfXNiUXB4FzNdg33rAXRkyW5+ACz9NhSCYtfBqf+enn87VWP5
 5oG8YGvWU399+GfkfWlXoLhqBSCVakIFqNqHF+wBQNeAR+SHP/yhAF0J6zjD1as5TFDtv5rdAFU
 2puLaix+r02LFg9Sak4zZccVjYmCjojvmhM0OH64z1a44BY94kTiZSHxpICwI4Qina1QOMBGLRc
 5kwfwzK7/m3w3SD9wWIHmxvkCEzTxPmhM=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr558600955e9.2.1777280608079; 
 Mon, 27 Apr 2026 02:03:28 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm329716395e9.0.2026.04.27.02.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:27 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:26 +0200
Subject: [PATCH v7 10/14] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-10-7e6cd1a805a1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=msp@baylibre.com;
 h=from:subject:message-id; bh=oGUl/xSpWiXGTDltDl4GA7ou+PXomTKYifn9AASTqDE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3atZa4cn7tF+mVKxexOP4a9s3NfF8g2PFRXsSQ3nOn
 i4UerKqo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACay+BIjw8Jl/3pc3vQGu9U4
 1O6JOOBQlSS+b3fyMqazd0917/9vfoThr6RxOudqEe9bjxp/s+QUMUrMTHUNdU95n+f8yUHwbN5
 dTgA=
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

Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
This wrapper registered as UCLASS_MISC, which is why it is requested in
this board.c file.

With the new devicetree the wrapper that registers as UCLASS_MISC is
gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
requested.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index c3931900622957a5499fe6483473c61e3a62fff0..5a006cf309b08d0e035faeb675368da73076e7ed 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -264,15 +264,19 @@ int arch_misc_init(void)
 int arch_misc_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret = 0;
 
-	/*
-	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
-	 * ti-musb-wrapper that handles all usb host and gadget devices.
-	 */
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
-	if (ret)
-		printf("Failed probing USB %d, continue without USB\n", ret);
+	if (!IS_ENABLED(CONFIG_OF_UPSTREAM)) {
+		/*
+		 * Trigger probe of the UCLASS_MISC device which is a USB
+		 * wrapper driver ti-musb-wrapper that handles all usb host and
+		 * gadget devices. Note that with OF_UPSTREAM the devices are
+		 * bound directly, no wrapper necessary.
+		 */
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+		if (ret)
+			printf("Failed probing USB %d, continue without USB\n", ret);
+	}
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
 	if (!ret)

-- 
2.53.0

