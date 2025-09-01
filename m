Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA061CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59948399C;
	Mon,  1 Sep 2025 11:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKan69dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A0E839A1; Mon,  1 Sep 2025 11:00:47 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD8B833E9
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61cb4370e7bso6122548a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756717244; x=1757322044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSMMfpsNgiLfAFrAc+gdlRH9sEDPCLbgyUapSOqkMjA=;
 b=OKan69ddMxFmeutPq0KHFguvSZCdb9hJVarCNBbLkU3W7JIcdrclBXBXQHbSSix+IL
 3v1gouHt264/orWU3zQYynKBUfqCFNB9UdCABxbqmVlBaQEj0l9kG085lprxIJ8wu/IR
 GHuFE/vObAnOc43gmAXn8Py/tcail2v1MvfdCyCFeBijwifqj0DN5A4UCTF2bp/uOPQZ
 odIpqdqgcg6saP05AXGkC4ACtyx5xu2q1IsuQMVWX3p7RZ6un6xwtRHRwfMcdKbmWaXR
 DrLEctKeHzNV2K5jtuCwtUt0AeN3H52qcHU70e/+0ALSg+tvcMRx0HPQeKG+d2kqLHJ3
 Lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756717244; x=1757322044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSMMfpsNgiLfAFrAc+gdlRH9sEDPCLbgyUapSOqkMjA=;
 b=nHafahWviB/wdVKxXXU/hZ1zHTfvFu7T4xMK0dwD3MolJOQN8q0V9BQeBlCqggXkYb
 j4J7D47jmwbAzDsmogvXCFavDrK7oUjxg7FoYbRHqlrk9ukvB77gDr8LkpVfEp/F7GhM
 f9S4ndNLyC7Q0DqQzpv0BQiCIWA1tVg2mRAq3YCc/VlbhFo+Hp03s53siKAe5WTNZX3T
 WHiViHZB1TZBKKTAqetExsM2uayb+06OIXGvAgbhNICUQsCMqlcHMc6ffWUroOQLXIJQ
 OfraDuovqpZhxS1FMPiyzxX1h803EKcRHPXfJBLglZHclWLdrHH+W9i5rm7gP7lcUr5F
 gynA==
X-Gm-Message-State: AOJu0Yx6YBLRI7v3Pz/ZAUr3z4NHSPEi4jts9/MlvjF21lEdNPRkk4M/
 4EVH86CrCg3lzGmkPXTiG/+JGuszOarX65tCvAWETULOn8YdHv2J5v+G
X-Gm-Gg: ASbGnctrgR3mfX09b/s/uH42HGjADkCYCXryoZtp39j5KvyqGs7LaUc8pTrWTiuW3ym
 VKkpivkbFmXHtT80Yaf8N9ygAtZACN7Tqxo76vj5LldYCo808avTNc11TBWQo825fUdwSeyVZ9f
 Bi5KocEaeLtJFQVM7blWTHQxeWtz3YZ2AdhwNLLip+FVCV/yG/rCebxW/qVmk54/0fGNoWPvbix
 2uQ3TIkaruJ+5jJBTNmLAh39bQdXXhRibFQj2pbaca8KGgsVM4mc1pq/sm9pJfVlq8UKjx9l7kr
 CmxyJQwqJEhvbndcqXMFHFXfYsRQslr95dQlPpbKH4FPt3FCoz66lYox8H5CogIno7GMfy/6Fz0
 5RYBOCbAkRelc/UgMxWIxG/Nh
X-Google-Smtp-Source: AGHT+IGLZseQ8uUrZ7dRe+SZxplWHx2t3GT5+LDhRdgZTPm1aDWM6pehVfDpsUN6T/SEf4riSQ6yPQ==
X-Received: by 2002:a17:907:e916:b0:afe:ae6c:411c with SMTP id
 a640c23a62f3a-b01f2113c64mr628381866b.64.1756717244330; 
 Mon, 01 Sep 2025 02:00:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0428f88a61sm215152566b.70.2025.09.01.02.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 02:00:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] ARM: tegra20: transformer: fix Hall sensor behavior
Date: Mon,  1 Sep 2025 12:00:18 +0300
Message-ID: <20250901090019.11930-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250901090019.11930-1-clamor95@gmail.com>
References: <20250901090019.11930-1-clamor95@gmail.com>
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

Hall sensor found in SL101 is not used for closed dock detection as on
TF101 or TF101G, it is used to detect if keyboard slider is out. To address
this, lets move Lid sensor switch into TF101/G trees and add Tablet mode
switch into SL101 tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra20-asus-sl101.dts        | 10 ++++++++++
 arch/arm/dts/tegra20-asus-tf101.dts        | 10 ++++++++++
 arch/arm/dts/tegra20-asus-tf101g.dts       | 10 ++++++++++
 arch/arm/dts/tegra20-asus-transformer.dtsi |  6 ------
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/tegra20-asus-sl101.dts b/arch/arm/dts/tegra20-asus-sl101.dts
index b4709c3e9a4..9f78b0febf3 100644
--- a/arch/arm/dts/tegra20-asus-sl101.dts
+++ b/arch/arm/dts/tegra20-asus-sl101.dts
@@ -6,4 +6,14 @@
 / {
 	model = "ASUS EeePad Slider SL101";
 	compatible = "asus,sl101", "nvidia,tegra20";
+
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-tablet-mode {
+			label = "Tablet Mode";
+			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_TABLET_MODE>;
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra20-asus-tf101.dts b/arch/arm/dts/tegra20-asus-tf101.dts
index 7c734fb5b19..03ba78c5dc2 100644
--- a/arch/arm/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/dts/tegra20-asus-tf101.dts
@@ -6,4 +6,14 @@
 / {
 	model = "ASUS EeePad Transformer TF101";
 	compatible = "asus,tf101", "nvidia,tegra20";
+
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-dock-hall-sensor {
+			label = "Lid sensor";
+			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra20-asus-tf101g.dts b/arch/arm/dts/tegra20-asus-tf101g.dts
index f49a358a267..44d5fdfc2b5 100644
--- a/arch/arm/dts/tegra20-asus-tf101g.dts
+++ b/arch/arm/dts/tegra20-asus-tf101g.dts
@@ -6,4 +6,14 @@
 / {
 	model = "ASUS EeePad Transformer TF101G";
 	compatible = "asus,tf101g", "nvidia,tegra20";
+
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-dock-hall-sensor {
+			label = "Lid sensor";
+			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
index 61b1cea6e90..df078a6fcdc 100644
--- a/arch/arm/dts/tegra20-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
@@ -497,12 +497,6 @@
 			gpios = <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_UP>;
 		};
-
-		switch-dock-hall-sensor {
-			label = "Lid sensor";
-			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
-			linux,code = <SW_LID>;
-		};
 	};
 
 	panel: panel {
-- 
2.48.1

