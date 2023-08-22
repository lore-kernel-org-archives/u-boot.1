Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4AEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D85C864D4;
	Tue, 22 Aug 2023 13:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GfAbi/IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAD586489; Tue, 22 Aug 2023 13:22:50 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391238649E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99d937b83efso559982266b.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703368; x=1693308168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=GfAbi/IRpSE9ep/2tnxaHLkUsJ5kZFvLnZTRlpSsJtjslWUYIFdBFzIB1lQDZ//lbW
 n111qDM7BsLodiqr+7dJLPcLCH9aEG6/k9zf97PIqkd42HPXHRCvls6gLaFH87MJQMCU
 hVwxaHYEqDflph8zpzWj4/rga8peXalMB2Ay7egvUEb7AxlQp0av1xm7IJ4lEaxYayFr
 ITe2DVSypu/akMhkLTENg0BA34MvajcdH7LIQbY+1tYzx9H1SRju+gKDfIfp3Rbe7LkZ
 H9b8opI+aJyRm1TrfkR5D7RYlOmHeM7JKozXLbiiYGgLSfD2u3ySNdoCEmpAj7esQRjB
 FIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703368; x=1693308168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=VYwAmHu9h4YAfJkGCOjHGHUh4KV0rDTFAatde8908PpLpHQ3mUhvR2oTWJn8e4mbKE
 QmKpmlrnfDTZJLIu0nHFeU8FnPF6Uhy5DAWeN4SRXsR4uVGNrLe5Md+CYRVjgIusF8yW
 JqB/ddtqNuwZHshpljSXe638G+xCcVJlY1bQKo72SAw6wiYLzNykS5gEq8MjWvZfqvs3
 G4YtjpZARYkGC/gVquQwolP9XOabuDdDk2ufc3413YbaGXxaY98m/DkKsMUpZME7ZcNx
 D61+8nicHnNyqsQPjhmK10ENm6NO2qK2Gw+MF0eHqixtvkHKfj/Ks1L8vYicWpeJ0P3j
 5PkA==
X-Gm-Message-State: AOJu0YySGSnfbqi7HfcYoUGKCaYLZbqTLECzkq5zuG43H0KwEyW77C/q
 rvtb2y7CzCS/rReahdMYpNI=
X-Google-Smtp-Source: AGHT+IEDLduvc+iRHSajVi+wDaIYcVk6YobF5WUXh6ckiBGnkVJQ8FZ9JidcbrD/9RXCPWXIEDChPg==
X-Received: by 2002:a17:906:74c8:b0:99c:f6f7:1796 with SMTP id
 z8-20020a17090674c800b0099cf6f71796mr8143217ejl.42.1692703367782; 
 Tue, 22 Aug 2023 04:22:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 08/19] ARM: dts: endeavoru: complete missing bindings
Date: Tue, 22 Aug 2023 14:22:06 +0300
Message-Id: <20230822112217.4646-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Clean up the tree and prepare for DM PMIC migration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index c55e193d1d..5c7b2deae5 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -5,7 +5,6 @@
 /* CPU Speedo ID 4, Soc Speedo ID 1, CPU Process: 1, Core Process: 0 */
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -66,13 +65,22 @@
 			compatible = "ti,tps80032";
 			reg = <0x48>;
 
+			ti,system-power-controller;
+
 			regulators {
+				vdd_1v8_vio: smps5 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				/* DSI VDD */
 				avdd_dsi_csi: ldo1 {
 					regulator-name = "avdd_dsi_csi";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
 				};
 			};
 		};
@@ -82,6 +90,9 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
 	};
 
 	micro_usb: usb@7d000000 {
-- 
2.39.2

