Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02466CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B8584A19;
	Mon,  1 Jun 2026 14:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Vv015+bV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598B884851; Mon,  1 Jun 2026 11:32:41 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F95A8484C
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490abf12f0fso2223315e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306359; x=1780911159; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c04I1Fg1PyTrVYWFdT0PFo7EWBMxSI5HknzkCFeliek=;
 b=Vv015+bVoURa/XgIR6xznxNuuNo/iM3mrpS8o7V9QIWLYDWVwa+KBUwvkJIY2g3n/Q
 Dwfk7ndRMsD1UnOYvkwCGSg7QdhYa89IcHYCSAnlPSwipGgz0m/vmZi7Q2l3dpfnvxJy
 yddOGcj5JiypLzhM4qNUR5yK2OB24wdUZwFP+9rDrr0wE5ajS24yP9JGKN4hObj+F4YE
 HH8Hu3cLRZrzkVpUyCZUf03FQCqELNB91I9x1Zx+Ln/gk4Is9spx77phTcV9YH4D6Aav
 Wpv3rWS7SRO8Kgjplb/yzu5gs7dWd/1PBVmauImw1qAzk/pGTz72dSZ59DgVkv1h/S21
 AXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306359; x=1780911159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c04I1Fg1PyTrVYWFdT0PFo7EWBMxSI5HknzkCFeliek=;
 b=dRVlkkniVjUrMEosvc4g+O5K+dOMI7y6uLO+E2SJojGn11xVfFA1dOZ4s5Y0070ud9
 58SlxPUf3z2ZUlYE0v7bdrxIVcf1lqaAGckTjsAR6iA0Uuytc8heaELLkIjK6kzpRYgt
 YZQzqG0F7Xjnj7aaZAt9fWhVSs/oXTFcja70Ienu/57/Tuu6QPYgNJV9GiC/cYsPxWT0
 XwhAS307UXawaGvyCspFNeioixuxnbc6wIA+oBMI2uixMWADVYoQacuSzTs52Tg0iVjB
 rL+awlAk/VKYaDTP45DpAhVWt3PZ0qVzXJohvClcI12pPsI2KSKcCXK9wRqgqkgYkKLv
 b5Hg==
X-Gm-Message-State: AOJu0YwbspdJk6iV05rF8Ch6jqaOP8NmiqRaCol6t3CdwMuWQWqOc17D
 ABYZLnSLtrWajrTQCka7WwVhg5gw6y1noAEGVurd2KWjbjjaWF4T4vIR7LVkp6GiFVg=
X-Gm-Gg: Acq92OHMHpSpsEQzXhZMEyePswEdkOw+0H6N3P8mq1G1+I4QV9KC6NZYuCJTenUaeQw
 ckdQMRaWsCJz3P9o/AvIYfzbcFQ78Q922JN8VwybZ7Ov0wKULZZIIhUlzraNsnb1O+lZ2CYQ5jm
 dOUB2uYTBCXtmoeHT3jZuwUtMgB5BffL3JH6Of2B5R9hWEz+XBMcP294pFFlP1BZB+2LnIVGJTj
 0Qy67KDzSdtKXr2roIq4U5Z54+3RDRBYH5D2s7ERPZKJrDVG8Wlo6/px3vU+jUy6oGqPNurojkU
 7O9qAZ3rAi8m3c1hIKhiahVOnpQ84xP0S4RSGFSaeKgIf05h5qwaGaKXe7ylfvtyi2G8yobZPN9
 EBxkF6DHWSfAb2z/87AImkG2lkAO/F4hK+2ho+yPVT8cQZey5TCcPM8SX6TP296PdGCu1GVpmLo
 KzMglKIXLwgaKIgpc8LW6aDHIbJXGNpRU=
X-Received: by 2002:a05:600c:8b5b:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-490a2a02a43mr150287815e9.2.1780306358783; 
 Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm413581395e9.13.2026.06.01.02.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:49 +0200
Subject: [PATCH v8 14/17] dm: core: Remove dependency on CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-14-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QZ0NsvYTmr9oME3Ajq1bYtC27QyLWWm+Lxbnh29yP7M=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwM5e9Z/rJBcWbcz5kJ125Hf0g/6roQs+TH9f5PPuk
 dd+lsMGHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRTg9Ghu4FVobslUJzrX6q
 9c1K8Lcq+HviUtfV1W5y+oJxP9yFGBn+e3JErbsStGcOY7VI/5l+Kd1NxecjGHbNuK/QvajPvVm
 PHQA=
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

CLK is an optional dependency of simple-pm-bus. Remove the dependency.

Fixes: 447bd8f1e5cf ("simple-pm-bus: Make clocks optional")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index cbefb522e5804fe8f1b674f5db03396b22c45f3a..ae0c346677230900c0bda4d24791c67f6342042f 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -337,7 +337,7 @@ config SIMPLE_BUS_CORRECT_RANGE
 
 config SIMPLE_PM_BUS
 	bool "Support simple-pm-bus driver"
-	depends on DM && OF_CONTROL && CLK && POWER_DOMAIN
+	depends on DM && OF_CONTROL && POWER_DOMAIN
 	help
 	  Supports the 'simple-pm-bus' driver, which is used for busses that
 	  have power domains and/or clocks which need to be enabled before use.

-- 
2.53.0

