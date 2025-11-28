Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273FED116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5B083CD2;
	Fri, 28 Nov 2025 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3KhlKI9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378A383B8B; Fri, 28 Nov 2025 21:47:38 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5446D83B85
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso1953013f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362856; x=1764967656;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFYgIn99+P8RmvLjMwZxh1y/IXw7izN5YUZYTkAxMVQ=;
 b=3KhlKI9ILi5ghkKvs6lQ1WQxNFiadnjvWKTLBjXItqkB5Sqd6TE2zwPsleFC7UD8i3
 uN2RMzbEszGGK1ooVgfZ7XtrrZ28Y5rwnb3pKMru6xU7s1F5GHg+6si1vsOseSKyLTMw
 YlLgST9qwAFs+CAbLwiXz5joXTUQDkziuNTSfiM1Bwq2JVcaKTy6cebbNHyJ8yHz5Hmb
 3aPGf7ucSXbJ4iwxHq9GrQkoifHjkLKFw7uavdgGYr1UFQqQfTpTDylnggmP4PafIcBk
 gadNs8FzhFzwTGwvqxkQWNqAKYxIeT9NE33W2TaYt6fZj1POEB+OJiPXjRKIrc9aJ7h1
 Gt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362856; x=1764967656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vFYgIn99+P8RmvLjMwZxh1y/IXw7izN5YUZYTkAxMVQ=;
 b=mahSgxnOvf20btM6oawmXG4jZf02NTeHeahbRgE+VR7MacK6Q7Af1soazZNtiKP6gS
 WTN2tg6ez1nGYWDlG702XmGTow7DIyCiL0s8emU2AEcfDRsYsZsxSNcOFFoEaTkVwf2O
 wBffl4bp+WMzo5CnmvqLTxFym6+hwj0U0QbSvCQIC5DEqN2xdbdjBMcRPJXDcN4fl66Y
 oeiDdTf8YKpTaNQVoP0jLCSDSVvb89xplc9sv/0+MRqG6WDboiVb3CesXTQPAbmS1mwH
 2upkx+2zpEkskx0XT3Qbfk4k7kr+PUQpQTmOqL24PEB60rGDlfmgnHW4+n7Pac7u0FV/
 he4A==
X-Gm-Message-State: AOJu0YzGbogxmYT3xDMfJMIGbQ1o6OGbY+LFUysl+QZ5dSLluQEScnUs
 sq8AqAI29LZ4kEt3vTRuWpyZMlupubvsyn4VHxFmJr2Q4Mfh5v1p/OdYn/ovLH6uOjk=
X-Gm-Gg: ASbGncvgJ7Wr3fVyH7J4YGKyPA4UQg1OM7y+OUsKRBh5MqrA866oKeMqqBgrV8WdE+O
 g87PiaW15GLju3PuWcCZfzBP9sDVEdYZGwwsJ/8kKCnR9u90EMwgK6eaikxqktTwIlGKDs3ZgMv
 wTF8gvvqW2JXl7dRstmCqXhpzCX94N3M+Ff0Xs6DB9Luty56y+u9WFUXE8P+A3rNlkNJVCFT9T/
 yUG1sNYxaJbwtyIBkACKJANqDorH5visNy6QglsHqZBPWvJtq4EC8z+3pKQxxowAofwCtj76ExY
 1ZQrdlTLN4iab7sHVVTVnwZSTtuA6r7OzLkKzpJ1M0HO4VY1G4kebRdl2h5C63yGg14jM3nv+xy
 9u6r4DgABSGepUgkn38Z2nMmp6+eqEOq8qnw/luB/OxEk5lS8Uq26qwegNM88ixRDNPjBaEWR9Z
 2+RlBx7jC77nKeY6sMpQ==
X-Google-Smtp-Source: AGHT+IG1sDULIo0GLkKZQkdsQzVRd8MBe9R++HP48I63wQU8MFMQalv9a1Ivgvh8dcmDwENj5QHp0w==
X-Received: by 2002:a05:6000:381:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-42e0f21e953mr18884726f8f.18.1764362855770; 
 Fri, 28 Nov 2025 12:47:35 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1ca40945sm12208041f8f.30.2025.11.28.12.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:35 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:31 +0100
Subject: [PATCH v2 1/7] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-1-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5hm4VZwDNLwAsQWqgY5VfNyBgT95pC8D5rDwdROe18o=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLqPsnjeOQsw3Pr8Ke5G7deran1dzTM+9PlfBfWIWn
 2KhVd+0jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZiI7V5Ght5XJxSmba1Zku65
 3IlF32HilXBD/dbO5zsLbfex7bSqSWb4p6p+OtlT8Fblsfpkoyre6WxV22ZdytRJi1OZ9YQld+4
 5VgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Add backlight phandle reference to panel node. Without this reference,
the display driver cannot control backlight, leaving the panel dark.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/am335x-evm.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 1b5b627006822a9bb4df1c6433ce7eff114dc029..52ca4ff6809ad24fafbdd515fbcde840715cf20f 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -94,7 +94,7 @@
 		};
 	};
 
-	backlight {
+	pwm_backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -106,6 +106,7 @@
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins_s0>;
+		backlight = <&pwm_backlight>;
 		panel-info {
 			ac-bias           = <255>;
 			ac-bias-intrpt    = <0>;

-- 
2.51.0

