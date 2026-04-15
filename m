Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD94F43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E468425F;
	Wed, 15 Apr 2026 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BkTirJ01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299878424E; Wed, 15 Apr 2026 18:04:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EDFD84262
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso84706315e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269036; x=1776873836;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=BkTirJ01UEDFfqZYQPIj14vp7c5PjVtQz8mwFA7XbwwUVmJkRZO93pdZqt89TQulBw
 c/Y1EeaaT71HX4B6nvHjLeJTBbhPyYEt6QF3RSWYrgVXoeNIF/gisDd+QVvv5jiUiwkF
 kRIop1g4ZelHdZeQN3KqTcmsOdXFKrQ9aMnr0uP7vVPPkpwPCtxeQkJveeejb4bXPSbw
 ngpnbRDdod7uq7rm3Y7nzX+83kYk8AJfpZthqqnGHe4aA0pXjMKmOBSgZrXC2HMOpXvN
 ntlKGhMEtqRWA0qwWSYWc1DejUuxBG2lQhzyIvONjU6oOqWUIpGyzf1GrKcao8A7CRzx
 AN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269036; x=1776873836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=lfhjKyPIiqrlI985I5nk9NlTtKZPSBAGi97dhmkut3L0Pz+CKdrG/uWsa0Nj5kcsBW
 4QBv4djUhSxX36SJi45cYSdGIZIdASys0tvrhN82Qwjg5u24kJlIFKCAMOLwTCQbrHNT
 BJ+DLfs/BbhXhJxRbEU56wVEy6waQPkxyyz6B2FV3vdq0/DTS36g6ahYzNvc2nqafKVB
 +TDH6oP8TtzKxB2Euu4UdMezwN5klJX45FRw2Tp7QtEzyWzsmEQoeH4gaA2uXm52BB2A
 VMrVocEmqdzIW4oo9/oz/u1bRfiscfXdlhNZzd3VqWQf2rDOG+dWvhtompihwR3qWvbO
 5GMA==
X-Gm-Message-State: AOJu0YwfW/QokO+Is1ieehaN2AUB98Yg1zq7t+eF30F9oONkFXdOj8T2
 V0Ik0CZLGtASSMNoQXmEyhiR/muRooLCQCmO/ExoevtTWysiKYQv8m626mpJ9dFgoV8=
X-Gm-Gg: AeBDievitC1lMHAs2a+uf4FIDjP12NQlDwaWKF8/8lxjFyXik5/lti3wG0SYyOIEhqU
 4J1cQNpRVNvjZumA0N15G+EjSJaTfitZ154KfXzDIRVrPT3mXCGi/+uELLRwx+eOZ2OaJUTgD1x
 CKNbi0ziDsw1g/OIpOMcyrZ8roFRSWFaNgYj1HKa6tpsljkgrTuzlumGsq3EOXEBPR25fDg4BqB
 UUouDsGIhWzcq9nYu92JYIKcJNZhLOl7V5WKMsJMHwQZA1/JzTqek4obt518ZC+Cvlxje57/xmw
 cMIPFG9QaNXEjepYM7oQP0E9Q+Wz6xUqXkJEBKckT11v5PlEY8jzJCnsYHgp/Op7eUNANeQyVCy
 uJXMO8zzZvgrrV+UlQXwODWXgyU/m8LQcWv2PBI6S1PhFaBRf8vPQEvM5O7gkPmiga2DSj/N5NZ
 LAHNw1PNlGg2CdefzZOXj1hcv/cnfLC1A=
X-Received: by 2002:a05:600c:4215:b0:488:d9ea:3da7 with SMTP id
 5b1f17b1804b1-488d9ea3e0cmr178266545e9.10.1776269036027; 
 Wed, 15 Apr 2026 09:03:56 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f08bdadbsm26396545e9.0.2026.04.15.09.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:55 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:27 +0200
Subject: [PATCH v6 06/14] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-6-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
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
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=msp@baylibre.com;
 h=from:subject:message-id; bh=a9mNtkme71PbyJwqoxXU2jtKAgHiQS6mJbF3mtWckVE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72zadY+RVNX55Lt3r+r1Ws2umvy+fcBD8Ipjib75ly
 oz9QecLOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiHOaMDFN2NxV8co8Pybw7
 +2x2q/6zS1zXKi6+2rV2Gvs3idc+PcqMDFdNrVXYNi2fuj789+Q1NYGnnmqwr7iqXvpI5synCeV
 +EswA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

