Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C784FCEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BA584016;
	Tue,  6 Jan 2026 23:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hmMfwj7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCBB83B9D; Tue,  6 Jan 2026 23:10:44 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBA383936
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3f551ad50d1so572699fac.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 14:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767737441; x=1768342241;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PLZYYLT2oxqrQ0fNwujg933sQjY2TkZVV106QV/BPfw=;
 b=hmMfwj7RcPNpeICXNpgA+yhfeZBg9TZHeP8HH07DgQm/MGil0MXkTkgtSqV7+5qLI3
 0MG9p3A5Fjvxv9/kZnELn6GAodxq7vElusIxliEYwwMNTkRg9J2r3ceeaOhhYRu2VN1g
 klys3OTX0mKTi6M/V/5TgxmjN1aOAe9USPz0RAIsFqc/nqC/UQck1NIReuGBiq37PKdh
 cF1XYNey510N67J0NJedZeBprP0/U8M34LN5+JNEFQDLPnKi/rwSG9cdLnvEHFYJNUZs
 pV42lcS6BM7WdpsE8fjI7R18v/Jve/gTY6KOIbiEzs/pnIPn09/p341GgwC29mA2eOWC
 Y9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767737441; x=1768342241;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLZYYLT2oxqrQ0fNwujg933sQjY2TkZVV106QV/BPfw=;
 b=OP7HzBwamT+8VezrxRUv5hwX9nSDHhWW3v+qufw+Szy6j1mNNS+sYYM8FJ7sQkeJdi
 ezQ9xLIl4NPfYSCPztpS3wNecIXcYnSn8KW0gK6FjYFCva12Ei8PhTseFUiKzDAhOFLm
 +t3eC5W+ExqZHp5B40jlQdvj5o4bf1XiPCNSTByarXf2YJ6nZ9amT3AKYqGMA6YmvpVY
 5vsfwmHNSGNbqcp386m5ASQdEws47mmfhpmDBQ1WnptjNwcja+fU3GMso0DlQ8fcEeKg
 SK+rCusyOCxxBK9uI789DW1a12mzzevaVRFswK7tLMMYwewjCO0ya0SUFNoovZrnweG9
 M2xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7N9R/xYAzHQ0ALDz8mg+7DLwfIWw3Fvv8EOyp9he4L+L859SE9XIcEY3uekSmd7QOZdFRXxU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8AzNy757wtsP7iDWb0JtbsJ9S4T6xvAjvqVg6LFD8xUevidFr
 JR1A9dhh5+M6wqKva10i9Q8QZrewVR5EbgEf4+t8Vv1kN1q9SOyDa1r4T0h7wcBs1dk=
X-Gm-Gg: AY/fxX5YUJXHzRwX1TIHEId/VXnFRAtPL6+yADLWaI7fGSMeKTxt7qZbcqAGC4QCgnV
 nnRYzBZQN+sW4UeFDL2lvEeDO3Kic/dFkZv9pVqKTa1iPkg3GLyqxgAmtmp9UsAuzC0AVpYUT/D
 NxhU0b/w0zuQQp5daTT+IuX8IT3zbJXW6oOT0rTRUflWr5xiBnhlS8ckAZzvio4WFmNVPNdAPJg
 9DArIddiBkh8OoYgROQNa24WkNurkq1/+V1ShXsbtYvGb9tVCeu+XgqfNqNoRwkLPTugIkC1L+o
 HMGoi3kGqqh3dqDBYr+3eL+AXiE0YMzdNVuLR8tknIdaoKLN8p2ZClCso6ZMRct0757B1KO9F3r
 ihhIMEK1nPmuLsk15MGVG0shW5vgPSa4Pzcbk1Zs3ZxDyjPOklDk6fuyKkrPa7cnuxMg7b7UXFF
 TKbAY7OpUekUHDN/o=
X-Google-Smtp-Source: AGHT+IFdvFb3/BS/sruNkNF0yFwQNLb4JkndRQrylIZVG7zxAPb01WgbjU6yv/xRYHMpdKwShcjdLA==
X-Received: by 2002:a05:6871:338c:b0:374:bdaa:47f9 with SMTP id
 586e51a60fabf-3ffc0af6b20mr214857fac.34.1767737441053; 
 Tue, 06 Jan 2026 14:10:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f98:2205:4ba4:3e65])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm2042560fac.11.2026.01.06.14.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:10:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Jan 2026 16:10:31 -0600
Subject: [PATCH] cmd/Kconfig: fix type in CMD_PINMUX description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswIamuEi1Ep5qFJlphSHdPW
 j74/AKJIlOCqSkQ6ebEh6/o2gbMrv1GyLYapJBKdELhyhnPJxzIHo2zGNi7K6OlZLCXpJWS60C
 jhnoIkWr+3+flfT/+UzMfbQAAAA==
X-Change-ID: 20260106-fix-typo-in-cmd-pinmux-desc-52ea662f8e9a
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l2xcezIEiNaDYjrOZgi0pMsjGT587BMXNJ0g2QDkhM8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXYhYCseGylnkbN5QBbFZCeqpscr7zW/ivklzf
 yvifD3XdCiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV2IWBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AewwH/3TIMwmbk1GXhPUTtuP/jO4vhGdTPz0BirCWy/X
 lpRude/gHUjEDzwa9VDwoF6bIFS7H4WDt33LeEmZF55qZwCnea89FSEQRaJsOU3256vZHWv4U/C
 bRP76uEY+1i9agJOLP8W/EC9ttjvAOR4UAH3TENkDYi1RvkEid/qWozYuZWsAsp5bni7HnXnvBt
 raKFm53nXl/l+bFUby9y8QAQU/F/VSyDwROM2fWbbLPJBZ3qQjZT190jVTl4w3C3m2Nj5Wh8Cvt
 /ugI791AQOD2C9Jd67yOSSdlODPT7gqoGV8D9PfS+aZu886waCW2f5VXJmekZxlMUpgxvn2S3S/
 jX2Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 06 Jan 2026 23:57:11 +0100
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

Fix typo with correct spelling of "purposes".

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0b..94f3e75ca6a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1679,7 +1679,7 @@ config CMD_PINMUX
 	default y if PINCTRL
 	help
 	  Parse all available pin-controllers and show pins muxing. This
-	  is useful for debug purpoer to check the pin muxing and to know if
+	  is useful for debug purposes to check the pin muxing and to know if
 	  a pin is configured as a GPIO or as an alternate function.
 
 config CMD_POWEROFF

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260106-fix-typo-in-cmd-pinmux-desc-52ea662f8e9a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

