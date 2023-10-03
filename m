Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA15E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E4887438;
	Tue,  3 Oct 2023 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYZInnsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C130F8726B; Tue,  3 Oct 2023 08:37:01 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03D48720E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso597199e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315019; x=1696919819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=lYZInnsPVy4v2+WmFDNvPEz4HNDhYUsao1EPFgLlk2utlTMjewM6ZneqwI1Q7CDvWL
 5CCGc4vCFj21dugwHr2RMRvVOyiCWjOYhLO/4ppwV3LFC96Vs46Momf/yK28NNcp0t7K
 LoWaP8kW25LQTuviM1EFwWRmUUf0KqEESGisdhgbsQj4P6EA4kLEoWwcA9NIdh5LTA+k
 NcfUcruOGMBt1NktubntMAZne/PfHt/ynpSjjjfxVrVhX48TScEhqH3WSMOtmqySTBnl
 e3Ek8Rl+Oc1iRftiqwCoyzUI9whAJJMomioxVABvD4otbWo+lAJigIKC35RTcgXLqcAH
 bU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315019; x=1696919819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=gnaNl7FbmfFEQ4Qh63Wm6WnwH1id/maVLhIaO6ZulnRg+7IrULCFeYP8a38mF8mHae
 tN9nLO/CYwqTnvxVyTulPLHxmDg59Ys9UvGAPZi9oXb16F0m6vXWg1IxDrPDMeHkhfJ1
 o2bzs6AuCpzsFaaqubQDszrPHxsYMIiofW1SC4WHcghOHyBJf/fI/8MwP1fPRc6gOCE6
 abPFjqJg+uniLaGJUbPmKrRwQhVrPt2/HAW2UVFGgrwgdO2V5FH6Y6duPWn1MFdzHbLV
 m1lXbQpSDetDfVhB7Y2a1xGHLci+rGWtQlfeGzMso+tHPBHPueLKdy5xd6SfyW1CLhJc
 UmVg==
X-Gm-Message-State: AOJu0YwX6kQkZtzbD7upcOty5NfHonukosSJgsDQR5fA29O0FQqvUmtX
 i56EAAFX0AuuESD5nf22l/E=
X-Google-Smtp-Source: AGHT+IHtE2Z3luslzfYBXBVmtICKe1w/7HRx+l4jAuy410sdiiNESgPWUplh9stbADn6GLRe+J3EBw==
X-Received: by 2002:a05:6512:131b:b0:504:2730:40cc with SMTP id
 x27-20020a056512131b00b00504273040ccmr10407821lfu.49.1696315018973; 
 Mon, 02 Oct 2023 23:36:58 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 04/16] ARM: dts: tf201: configure dock USB phy
Date: Tue,  3 Oct 2023 09:36:35 +0300
Message-Id: <20231003063647.42770-5-clamor95@gmail.com>
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

TF201 unlike other transformers uses non-fused xcvr value for
its dock USB port. With out it dock USB and SD reader will not
work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-tf201.dts        | 5 +++++
 arch/arm/dts/tegra30-asus-transformer.dtsi | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/dts/tegra30-asus-tf201.dts b/arch/arm/dts/tegra30-asus-tf201.dts
index 54f359ef96..59e19f9766 100644
--- a/arch/arm/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/dts/tegra30-asus-tf201.dts
@@ -6,4 +6,9 @@
 / {
 	model = "ASUS Transformer Prime TF201";
 	compatible = "asus,tf201", "nvidia,tegra30";
+
+	usb-phy@7d008000 {
+		/delete-property/ nvidia,xcvr-setup-use-fuses;
+		nvidia,xcvr-setup = <5>;      /* Based on TF201 fuse value - 48 */
+	};
 };
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index 4eee1df084..d144a56445 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -123,6 +123,10 @@
 		status = "okay";
 	};
 
+	usb-phy@7d008000 {
+		status = "okay";
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
-- 
2.39.2

