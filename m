Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928E9C54E5D
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D46DC87E87;
	Sat, 16 Mar 2024 14:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OHY0so6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB5687F88; Sat, 16 Mar 2024 14:54:42 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB70787DDD
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 14:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41409dc5becso1059275e9.3
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710597276; x=1711202076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
 b=OHY0so6nqd9SiGYd41EVrlgdcz8EN/Q/FTOGVbIV02rJGsOrHqe3AFopPUmVb81yDT
 ryO1z55OQm8S48xrck6Q6IuZseNmMwHmvZ2Hj65maevlqiDXg6FhUBVedxSXOxOlTrcJ
 zm0ZCWi7EVY+Jh5dgl4WZuGeZTExbUYvxA5BVaMWuR85XMifjRxQY4U2xejhLL1a0tBa
 gPooyExcxfkJHfs/vK4zcC5Qqg035Lws8YbwFsG2WnozqcwfndhqGyB/KPrZDrncaUa9
 qs6ZshNKzI7DAaW2Dq6Xip9kU/tb1nC7YhlXBvnwVAPGJKn1ShyG0KvMelMPVwtXt0xi
 c23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710597276; x=1711202076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
 b=DliDnrE9eqLqXsaFxAYsx+M7WQN+HX1Fz1EiZP3Ic0qs2xjKo0gXrRd5VDzvYJQvVK
 4KomUOVEIS+JhgJvw0nVRvUgMsXuGljPjBBHbMu50Ba5Do85JGL3TON6UeItqS3W2CNY
 R3AZtYK/x09vgeX7I6fQIxqO3mvr/rIm+c9DtwBZYpx12LHebEtikwGx1J1U6zS6T0yI
 2xkykEcuYjy0/ETPTd3xW7YNtNPI/lPe1l2LbkzmKF664V7U+PwZSVgyYuLt6SjXPHSd
 Tw+ET9GT3QFUo1Q1hPQbCZQs+xwMvADrNE0j3iUCyU+bujJnk62yC2ai1IIwS4BjnPem
 EHmA==
X-Gm-Message-State: AOJu0Yx3MtjMoXFcE+SV9SCene0/ISS8dIqd3w/V/g0qWuL4gNdDnm7m
 SHjIrEcGMS2oySxQhv0FHbZv/MuFM4goGsvvi1AsO0MwlOfM20ujia5luwkLjb0=
X-Google-Smtp-Source: AGHT+IEBXJ+LDSb8yez8jw+oMX7DHpcrqiZApeJ2kmzGEWKJQ5sNvM+K+W2hgSajgULIqDUK/wrA+A==
X-Received: by 2002:a05:600c:1f8c:b0:413:f2c6:df3d with SMTP id
 je12-20020a05600c1f8c00b00413f2c6df3dmr4290047wmb.13.1710597276625; 
 Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] ARM: dts: fix Ethernet on WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:28 +0000
Message-Id: <20240316135430.826898-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
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

Placing the snps,reset content needed for Ethernet to probe in a common
uboot.dtsi results in the content not being used and broken Ethernet. Fix
this by creating two board specific dtsi files with the right content.

Fixes: 67d5128df950 ("ARM: dts: add support for WeTek Hub and WeTek Play2")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
 2 files changed, 13 insertions(+)
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
rename to arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
new file mode 100644
index 00000000000..3743053eb9c
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
-- 
2.34.1

