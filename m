Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84825C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A35282F5D;
	Sun, 29 Jun 2025 13:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJOY+eVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F91281FEE; Sun, 29 Jun 2025 13:02:29 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE8A82F4E
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-555163cd09aso720871e87.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194939; x=1751799739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HpBwb0PVT8m9zKVUItm91iGT44lk4OlLXXB7BaUiE4=;
 b=dJOY+eVZXz26oBWs6TntW+/yo/lTTCte14gmGANl0A64cneAnrun4nI+n7rMphLzil
 TmWUz6v0uYqgRpkY0wDBvK78wY1B1apo9Uu6iWZrgUmTnkLKWJ2UIE4Hv9oFmK3MlKlW
 BidpseonPhel3aDR1JG6kx99mYGthoeUXNcgDKlmdmFhRssIo+nQZYlm692YjX8gp6jZ
 JbjfBqgaqvqRxP1qUMXb6wSfhAtjCEQk3/vKVrEZNcJJ1FXDGaMLwlgH4qMI7ICWy3AM
 XyAxf2bZ/RzZCnniO7p4XZjq3ZyOz77yToNwMzlMv4JWgHZI2Vpwn4nIE7lSiIk9apVR
 6XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194939; x=1751799739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HpBwb0PVT8m9zKVUItm91iGT44lk4OlLXXB7BaUiE4=;
 b=szqRL8+iDc1XOrQtRBlUwrN4sxYhc9AOYJCh1xvJdGIFNvjczq6x57DMsjlgb34RRo
 GJAS+F20z+UnP9k1Svd+JXMaqAKjXuVc9Hsi+7ByStJ0m5i6dwQfL3Z1r+ew7TDQZIa1
 5caOjdN2YD7ojUoJHf4AM0QO/KNyEI+3mAWU6cAF022c4sIuOrCJALQRGYyQOuK4psSG
 hRNOqg2RrRhrONbtZyAX5QxTmtfqUncmYd5laZbRd42Suoh0pddIPbMgrGuIUKjdOyGx
 Cd7gAuNzYrc9+W3t6yNgQpqveJUt2oyR/njwzjAPXrUFHr6C9mOP/AOz87AtMqPdzc5A
 +oWQ==
X-Gm-Message-State: AOJu0Yyh4LS39aR679URR1wywm2zw7s9WFnd+WvbeR4g8wNS05sum0Jh
 5Ul0qoLwvXo3TLRITRYjWIremy1QH7tunCpr8RXyAxhHz1tQGodPSy9y
X-Gm-Gg: ASbGnctGrHBTkmfHNtbs671DKG7e/mFHAr4KIO22i1hajXMQWogr9pybJLbWG0jheqd
 WlQW5g4dFMAm/DX6qOCaSL5SNef7TGsQeGqlRSAnv7NciBlvzi++4kkrv2VJNpdsHIIPai9EHgu
 7cHl8td8qQ7WAfsHkjBEBAQ6Quu0vpTmj4CLmSBc1FYJ9LPH8QDi7JDRlYafVUmIxiR+roi7HTF
 vXN2DBpfABBWqSF4xTEaRGopM1dhyJxzkXozNoloP8G0zFRRyXn3qxneNjuxsuuqzWG+/GKZ7k+
 Mt4iCELgVTCANZww8+eufTyuHogySLij+p3Sq/ueryT7/rf9wLC64JArC8QNu0y0
X-Google-Smtp-Source: AGHT+IFo6JSeyB4cGJV7S09eMQ5lOgLbB+fljXHgLHUy1d6B8F86q7ptHSZudYYpjWtqrkClQRtcxg==
X-Received: by 2002:a05:6512:3c9c:b0:554:f74b:789e with SMTP id
 2adb3069b0e04-5550b8ab21emr3063329e87.43.1751194939212; 
 Sun, 29 Jun 2025 04:02:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/6] ARM: tegra: Add BSE bindings
Date: Sun, 29 Jun 2025 14:02:01 +0300
Message-ID: <20250629110203.25086-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629110203.25086-1-clamor95@gmail.com>
References: <20250629110203.25086-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Add device tree nodes for BSEA and BSEV devices on Tegra20 and Tegra30.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/dts/tegra20.dtsi | 29 +++++++++++++++++++++++++++++
 arch/arm/dts/tegra30.dtsi | 29 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm/dts/tegra20.dtsi b/arch/arm/dts/tegra20.dtsi
index 275b3432bd8..4a40edfdfbe 100644
--- a/arch/arm/dts/tegra20.dtsi
+++ b/arch/arm/dts/tegra20.dtsi
@@ -249,6 +249,35 @@
 		*/
 	};
 
+	/* Audio Bitstream Engine */
+	bsea@60011000 {
+		compatible = "nvidia,tegra20-bsea";
+		reg = <0x60011000 0x1000>, <0x4000c000 0x4000>;
+		reg-names = "bsea", "iram-buffer";
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bsea";
+		clocks = <&tegra_car TEGRA20_CLK_BSEA>;
+		resets = <&tegra_car 62>;
+		reset-names = "bsea";
+		status = "disabled";
+	};
+
+	/* Video Bitstream Engine */
+	bsev@6001b000 {
+		compatible = "nvidia,tegra20-bsev";
+		reg = <0x6001b000 0x1000>, <0x40008000 0x4000>;
+		reg-names = "bsev", "iram-buffer";
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bsev";
+		clocks = <&tegra_car TEGRA20_CLK_BSEV>,
+			 <&tegra_car TEGRA20_CLK_VDE>;
+		clock-names = "bsev", "vde";
+		resets = <&tegra_car 63>,
+			 <&tegra_car 61>;
+		reset-names = "bsev", "vde";
+		status = "disabled";
+	};
+
 	apbmisc@70000800 {
 		compatible = "nvidia,tegra20-apbmisc";
 		reg = <0x70000800 0x64   /* Chip revision */
diff --git a/arch/arm/dts/tegra30.dtsi b/arch/arm/dts/tegra30.dtsi
index d5de1ecaf05..82e843d05be 100644
--- a/arch/arm/dts/tegra30.dtsi
+++ b/arch/arm/dts/tegra30.dtsi
@@ -373,6 +373,35 @@
 		*/
 	};
 
+	/* Audio Bitstream Engine */
+	bsea@60011000 {
+		compatible = "nvidia,tegra30-bsea";
+		reg = <0x60011000 0x1000>, <0x4000c000 0x4000>;
+		reg-names = "bsea", "iram-buffer";
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bsea";
+		clocks = <&tegra_car TEGRA30_CLK_BSEA>;
+		resets = <&tegra_car 62>;
+		reset-names = "bsea";
+		status = "disabled";
+	};
+
+	/* Video Bitstream Engine */
+	bsev@6001b000 {
+		compatible = "nvidia,tegra30-bsev";
+		reg = <0x6001b000 0x1000>, <0x40008000 0x4000>;
+		reg-names = "bsev", "iram-buffer";
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bsev";
+		clocks = <&tegra_car TEGRA30_CLK_BSEV>,
+			 <&tegra_car TEGRA30_CLK_VDE>;
+		clock-names = "bsev", "vde";
+		resets = <&tegra_car 63>,
+			 <&tegra_car 61>;
+		reset-names = "bsev", "vde";
+		status = "disabled";
+	};
+
 	apbmisc@70000800 {
 		compatible = "nvidia,tegra30-apbmisc", "nvidia,tegra20-apbmisc";
 		reg = <0x70000800 0x64   /* Chip revision */
-- 
2.48.1

