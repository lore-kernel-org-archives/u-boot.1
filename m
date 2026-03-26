Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB510A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261B283EAC;
	Thu, 26 Mar 2026 12:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="pxN15TmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385BA83FD3; Thu, 26 Mar 2026 12:29:02 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D933B83FAF
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1271195d2a7so2090945c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524538; x=1775129338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmInk4caV9nYkTUQ5QpKB4vNtsLj1FBdBorW1w5+H0Q=;
 b=pxN15TmH7RtVjjTLi/hTujhGAmMNLGSTB8aXbhfETQ0aVos8qUjPN9uBhCCksQGA/8
 +0Nmn4R8q7/m+yYBLsbscfzlWpHSIhjHKgcyMyHdkiq6oQgIN8pD6bwQxX25U6d8qDz3
 /PbrLEb1j5Py9xdyfUuPklQ3FYUCnY7eXB1B74+eERwnVGaA5VLy4bHIOolHEUQdFwo8
 C1VxTwy1rJp/0bWaKf/t88aYvaug8dxDoUCnVWM9UGXp2XxIVijozxIfACOpvvr/FYdG
 4aqhtclAgaBuooGOY9ZV6t6EFos0k2Km5S5SwNzxNU9rJABbcTZzZdLAxoaDUFWST2Er
 Xrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524538; x=1775129338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tmInk4caV9nYkTUQ5QpKB4vNtsLj1FBdBorW1w5+H0Q=;
 b=huPTcDPl9UxtO0XKINjTkxTlene7bqYRNcBb8y+aykb3ee1h2TBTkH/uUSU3/X2xXt
 rePIWsQpNMjj7jQEjyt5bpHiaXhaW26GyFpvznXCW7RQ77B3ixQJWhlQvHhXacilDUgK
 IfkEUb/f1w1+nS+gn7+QrV4Ci2aU2DjbGj9Ytod1jOONXXTmV85hJ7YUnhThlAIP2leS
 vV+pGmDNR8EAKK8tY/QiCnKbkjyDBGOuLe88fbv8lYhb2o2Y6rdPyc8UvMrGtgBzEiqD
 mRLwCaj65KIdcws94rHRoyU5+2/NEjoTYQKArAz/8FltD2LbvzpOqslGkbJla4BgCdeV
 AXpg==
X-Gm-Message-State: AOJu0YwyZZITDTtxwrJkJOu7BWhSp+zVe/mco0nlPQXXzQDwhNfzIINP
 lLQNAysd1hxS9TO1+YmaOasp9QjYOFaR+NZUPEl0UhiuWrwM+mcJF8eW6JBcXxdP9aZtduBkXOh
 h+KnZMNYod2hNASuJVMG/1S+rdwmAqFDl+l9bddrrnQfBjVMBFkdv7932linZG5uWvf+YyI5e1z
 jQwzIRgHyE4ovj+Dva8TVFacyEOpRhayUtlegh3qtQwoE=
X-Gm-Gg: ATEYQzz6Iy8rn3Kf0ZBEDy5dX7V7c6zWIa9Gmsr04q8VyWB9RTiEXdeCU8DPyzn3gSI
 brEum/McUK0uDyNlpkaqmLajYHnL05S5m29ugLD0Ez+wdqHqzOHfuqLy+WjfI1EnJtznh7+XusJ
 OYaa108cC4n+Y6QE0HFDhnmAYi8qugukY2S+OZXQTu+AHekxGgmPLT9dEKHfAebjqt71HW428Gv
 ttIAR+PwMDE+1ncDCI7PlmpUadUqX+MpOuSganZdIfw14U2NPmeHgGogn3xKFBLYzRqB3TmS/Gd
 qhQZbPUfKVZD/O1ti7y+DxcuK+fRA+E1CgSxv5+dN2r67sCGDm+A4rMIm2fzn6MKMqcJJvSQTUR
 ZOOVmUyT79NNjrSB76qxMu0XNnIh7f89Q30o/+iFBUPoAUU+eeEi3OICS241Dw6RmyQI7KsZag4
 Rrb9zjrAVRS2CEGbuEHXqGijPlMjP6D/59dh+uv6hWyuRcdHBW41q9n1yyFM4r+dnV8UGibQXnP
 Yq2Kc8EUUu7d1xeTzF7QUGkd2uhx7N2OhT8v9S9ceBuzBQkYDo=
X-Received: by 2002:a05:7022:ead1:b0:123:2c98:f65d with SMTP id
 a92af1059eb24-12a96e548ffmr4555463c88.13.1774524537719; 
 Thu, 26 Mar 2026 04:28:57 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:28:57 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 04/14] mmc: atmel: remove duplicate depends on ARCH_AT91
Date: Thu, 26 Mar 2026 12:26:45 +0100
Message-ID: <20260326112830.313874-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Dependency on ARCH_AT91 is duplicated, so drop the extra one.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mmc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 39caf2eff1b..9b77b8c619d 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -566,7 +566,6 @@ config MMC_SDHCI_ASPEED
 config MMC_SDHCI_ATMEL
 	bool "Atmel SDHCI controller support"
 	depends on ARCH_AT91
-	depends on ARCH_AT91
 	depends on MMC_SDHCI
 	help
 	  This enables support for the Atmel SDHCI controller, which supports
-- 
2.53.0

