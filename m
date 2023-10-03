Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6257E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3724C87468;
	Tue,  3 Oct 2023 08:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+MkSxzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852A887281; Tue,  3 Oct 2023 08:37:05 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9738D8726E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so642399e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315022; x=1696919822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=Q+MkSxzLWThD79EFvcbPGukzEvKTZjBj+qxYYWXEW9ejySrDGoBMWrk64K7k0lks2l
 xmcSvr8hnef0lqiTxXwJFGS7WGhbpGGRD/B9nNfaz2YU9n0kntWVTeMBcDvQXbBVuODI
 Jk9lpy0Ad2Fm3NtN+rHNJSjy8ka+ZLWYMeVqioKtCTUp2xXZj1+g5lFscNBC1BIr1eIT
 rW9Dpe7ljFmi0XMRgugmo/oExOGk4WCw2qPfeHYCL9/mzWGTHdgjxO3wEVn2b1Yhpk6y
 c37o5bpSjqtbD1GY3YKFGVxAolaWZtlv6c6J9deirfX8P1VCDnvo024U/QD3CfQ9ij76
 iuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315022; x=1696919822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=SOcmxpSCr0ECBijYvLa8wuCeym3MLDJSge0D5NNxEOKU8G+UMRPemZ0JEV/0kgPp1F
 FtZ4OzSic7LwGuMaVza86tvYrXEHHil9BFE0FTrShNZly91yn3fHzFwwp4FYB5k896Rz
 Uxjuigcgnsb0xotpNLMWwBhMBtiL1JDvOdYMKDT0QCX6J8bDBhDgnNtzARxx/pVNSIgI
 hR5EWss2SovvlsPMGUhFTgBpbF7JqWVW0cyePorMvFaa0TuQyaky6C8lVCWegTRilNX1
 YH45uIWRaxg/MvhTswzCN7iDugcM127FM3XcijHfhp8YdUuE94rMtRR5AZ5c5xn+Jc2l
 Xzdw==
X-Gm-Message-State: AOJu0YwVuFVJCxy5sI+VD43sncLreY1LrOCfZD9Is7aAxWlkSjxGBT5a
 sP5MOR1X5Af7/p1x5X2iWWmdQYwyCVQ=
X-Google-Smtp-Source: AGHT+IHiE3mggARMMLSFjANuO7TUsBH+B+6y1lC3qLgqLWcnEIxETssliYyhKVakgDTIRoYiDaUduw==
X-Received: by 2002:ac2:4f0b:0:b0:500:bb99:69a7 with SMTP id
 k11-20020ac24f0b000000b00500bb9969a7mr13742392lfr.14.1696315021842; 
 Mon, 02 Oct 2023 23:37:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:01 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 08/16] ARM: dts: endeavoru: complete missing bindings
Date: Tue,  3 Oct 2023 09:36:39 +0300
Message-Id: <20231003063647.42770-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

