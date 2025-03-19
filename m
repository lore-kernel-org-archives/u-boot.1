Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8594FC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EFB81D0B;
	Wed, 19 Mar 2025 21:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMKJFrNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3227C810F4; Wed, 19 Mar 2025 21:25:28 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A475B81B4B
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso948565ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742415924; x=1743020724;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OmsvKDqeU5gvgJi0YGDhPIf2ofw0zSSXy3Dop0VVJ8=;
 b=bMKJFrNI+wiC6nBHQOw1KSJ/ryX9ZpooVIO/jKCrnvRiDNQhEwf9oE2YwPcqjdeBkd
 oki72LIJTeli87Ogs/lEjWwLLNnvU+kYQi95Jo8ZtQ0XcoJfumBjLb+ltXJbn2UhGAZm
 CBRRF3Nj9DUhL/a+FR5uLJlRkUf/sUOTnSJkwns3SUAyamHWF2S+aaj47j9rhUD2Nmy0
 OEfXuOk1Mk69zoolpNG/CVmXmzExuyowcRYnXaiLEQ0woa/GWPfKvRsYwKjciI5Axi0H
 x5wCObEdgEBBnnPDJxP/uPbhXqmnRbNTBpDLhyHDchAW0So3RqJx2L3gxrMdLr25HyQ+
 m+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415924; x=1743020724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OmsvKDqeU5gvgJi0YGDhPIf2ofw0zSSXy3Dop0VVJ8=;
 b=hzH+vwWkRq+WG/yj5OpuRLGivjI1x6U11YiTbUjv9a7FCoEdGuKhfjGMCW/njF5Y/b
 zU/R0iW4spZf1W+IZkFGnNaFr5J7LVYuuyt94kQdRf083eHWm78/3MThk+sS0/PCBlVj
 /zYCrLZkd1D9eYwHoxmdbJQz9J2cpPqkskPk/Gy/77YGr72trhq/WqGAye9Y4DkcVMNt
 ste5dGIH7v99USTNnnFHWZs+BShPz6+DQgdxAmMmJcAFVqrS4br4kSs2QsTkrMwV+7ri
 iiw5dcnx53WzN430NStM7w0fZsHPtqDT8heucqsiQJ+657ML+nWbjT6qThF9HAcTMGj5
 MLeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXmr0w/dZ7BERj6+gBoLFYiaC+c2/Bk3AIa+cTfbxzgBANKE9YKvp7FoQx5LLxnRisWKgqfXU=@lists.denx.de
X-Gm-Message-State: AOJu0YzmGxDhefGogT4f51HnNiwvsDY75rPsmvagvfE4ZhpsHAvYFc0r
 kK0V5UQt6W6K5HignBY2c8qJ1SQV0L1vFBw+OuFbNxglxjL9dgjRXnobjAJCrVTOZDxfwdtOn5a
 o
X-Gm-Gg: ASbGncuCqAcA7/6zYaMcpbSPFq8136k07udn5RI5SH2UGb59cVD66ffQvRPIi3cxCGj
 GR1W/M+In2nq44sZVV9VwJwqTptDpcHD1E+LIt6fdThChb8sxB9rGLtr1gAVYEXuNKjoKcxCZAo
 GH57V0cH2JZaPRyuk5uUBPkuD+rISlB8q8L+r7ehpu/WST7qGr+qMZcuhcgOJhA1PoMGcmlF7r4
 9N+1TKwuHoYeRL7r2w+EwB2tg/U/pZAbCaTLIScvF545O14nuv1lO+Q7Ov+JGYh7iaxbNODG6aG
 65Gem0Z+aR2Zr3cmV6wKEBNOCq7xb1M5X/noMqFYV7U0XmhxyPho2s7MNa6rkQV0lRLEvf8j7XP
 LU8LFiL8=
X-Google-Smtp-Source: AGHT+IHq8y8jrtmND2BhnmIE0f5Gj4j1UXfhcbdwkHAgekT+zGvIBcuBxftT3N9BysU9tD6tkOgorg==
X-Received: by 2002:a17:903:2301:b0:223:fbbe:599c with SMTP id
 d9443c01a7336-2265e743ce3mr13765535ad.19.1742415924191; 
 Wed, 19 Mar 2025 13:25:24 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73730ca057csm8886757b3a.48.2025.03.19.13.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:25:23 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] arm: dts: am335x: Add nodes for lcdc, panel and backlight
Date: Wed, 19 Mar 2025 13:25:16 -0700
Message-Id: <20250319202516.3300444-4-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319202516.3300444-1-sbellary@baylibre.com>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
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

For AM335x EVM[1], enable nodes required to enable the support for LCD
and PWM backlight.
This is required for the splash screen support.

[1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 arch/arm/dts/am335x-evm.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 6e799621678b..d4f93e75ced5 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -98,7 +98,7 @@
 		};
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -110,6 +110,7 @@
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins_s0>;
+		backlight = <&backlight>;
 		panel-info {
 			ac-bias           = <255>;
 			ac-bias-intrpt    = <0>;
@@ -137,6 +138,12 @@
 				vsync-active = <1>;
 			};
 		};
+		port {
+			panel_0: endpoint@0 {
+				remote-endpoint = <&lcdc_0>;
+			};
+		};
+
 	};
 
 	sound {
@@ -478,6 +485,12 @@
 
 &lcdc {
 	status = "okay";
+
+	port {
+		lcdc_0: endpoint@0 {
+			remote-endpoint = <&panel_0>;
+		};
+	};
 };
 
 &elm {
-- 
2.34.1

