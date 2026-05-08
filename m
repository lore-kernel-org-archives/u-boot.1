Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E9CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9AA84C3B;
	Fri,  8 May 2026 10:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WjEWnhlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD04E84C88; Fri,  8 May 2026 10:52:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15A084C19
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso15742145e9.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778230342; x=1778835142; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fbk+yc5EOhiDleiJAb/Jjw9JRHPCsSSDSssGzJmTM3U=;
 b=WjEWnhlwsEZ9G4IK9NnGyuY2Fiie5BIbFws2xm4JItW1G5lfmsQYJHBdCoxnRXGbKP
 nPR9DB2qJUduM4qw1s1VwlVW8arOC9ynGaZTAzWabyGcnHfHsSxqGLHBill2GiM/jLil
 10GCrraa/tCWwZNsC0m8su/Qf9BwAxMKz4+vYAO+TIM3c/OhWnrf+QuEeGajJf86GaWR
 9IpiXZJzxVJgTvsMiK7rf2yz2bdkEqvsc6NDPaBC3AIvCUI2oRwSdXvDXJr2OAsz2eUK
 3EUEzhlvjK33gSTL8USd6cwvVqhb30fj9S2BL7IyKz+CAwOkoTbqZdVMJ/NR2bhkDiOg
 +06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778230342; x=1778835142;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fbk+yc5EOhiDleiJAb/Jjw9JRHPCsSSDSssGzJmTM3U=;
 b=hT/8Hp2mgHQ7INKgblEzhl2H0nketM5wm4028yhuE0XrgfPjAcIbWWVHyaqZVicS/2
 G0lyBgkz45zAQVXRCnw+rEyzZgOx/nAZGjiHcDNdsm04Kl/LdjogErzLk9jgFqGvtSd3
 T3upDRUl4GxagQv1nlaQw5w0cLD3dORo9NYnEA586YxQaewyBuyroYi9g2Fyx+W3uFRo
 usr4uBnBW7TXEiX771GoiCwDDYPNJJ+odPO4DtUOl5PPyWorlxXf6gNwgOfQ0dJYCYxJ
 Xi8FyfBFQaQRaA2Ydq+zj1qAmXQTfZesoo8ohZPJe8647sau8PEp+bebez3EXn8dvUo1
 h2Bw==
X-Gm-Message-State: AOJu0YycKfgDkdpbsmlXnZwlQ2OKRXEVsY5jXPthWWshJmjda5PIl7R1
 QqSCvhUBMoCESJHcKQvI2LPm9k78reNORepiqI3ceeXCRE9XWuaNRt+x
X-Gm-Gg: Acq92OHmAyvoIdHirHOsb1KfRm1aMalX1P6BYNMfXzRSafaG4W2eR57C7I2wTpV6UpW
 GHN4C1SdJQBeLRTobPWtvvV3LJMc1BkyQY6nWBM5aiLZIDCmsRX5d5eHEqpoEqKsmT9sEXxraf9
 lv+1MJWmBg2pepzfsAVQqihB1dLsxbEMT9pwXJbSAJG8N2dDzljlznVLSuNKQGuHBj4XoucgD2k
 QlGJGLtbAK0LhO11UE1tKKD5TLPUvfZJh3RVutlhg6xIemJFbMPqG7V6EGW1xJiG/inhcv9qjGd
 u7O/iSkvMnXGYWLIFuq0z/iL60ddRE8yi18v2Ue4CzFGNpffUaamQHGHTFb1nLehcIcIIOjgHB3
 V7LuqJ0clGL4q27vHe0HUorPjN7MGldVnVm9eKDqphpIB46meCjxg/mpHND1hpiXJGSvZO/q0Lb
 8aAt2AXzo0SLQ4MRXRREmM2pqxMn4yly7emRFRG+sDS4FAkt0QUbqnLvkzhNvUqBGaYmSOx07sY
 tGw0QhW6tlT+8AOAF8d4BhlM6Zxy4sLRcN7lg==
X-Received: by 2002:a05:6000:61e:b0:441:2335:ac3f with SMTP id
 ffacd0b85a97d-4515d4d114fmr18921970f8f.31.1778230342070; 
 Fri, 08 May 2026 01:52:22 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm2676777f8f.8.2026.05.08.01.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 01:52:21 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 08 May 2026 10:52:12 +0200
Subject: [PATCH 4/4] arm: dts: k3: k3-am62*5-verdin-binman: Enable
 tifs-rm-cfg in binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-v1-update-rm-cfg-v1-4-ec9d033f8ec1@toradex.com>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
To: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Add rcfg_yaml_tifs node overrides to use tifs-rm-cfg.yaml instead of
the default rm-cfg.yaml for Verdin AM62 and Verdin AM62P platforms.

This enables binman to include the tifs-rm-cfg.yaml configuration when
building tiboot3 images in line with other K3 devices that already use
tifs-rm-cfg.yaml.

This follows the changes done by TI to their am62x/am62px platforms. [1]

[1] commit 41814276f03e ("arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman")

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 4 ++++
 arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 7b6466295876..e72065209f28 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -7,6 +7,10 @@
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62x-hs-verdin.bin {
 		filename = "tiboot3-am62x-hs-verdin.bin";
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
index b46e871ef8ab..2682ba13afb8 100644
--- a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
@@ -7,6 +7,10 @@
 
 #if IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_R5)
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62px-hs-fs-verdin.bin {
 		filename = "tiboot3-am62px-hs-fs-verdin.bin";

-- 
2.43.0

