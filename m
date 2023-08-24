Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06D6C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C0986926;
	Thu, 24 Aug 2023 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neLF1pOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A6A869A0; Thu, 24 Aug 2023 21:26:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC64686900
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ff9b389677so219464e87.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905212; x=1693510012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=neLF1pOxVJ+MwOq76hE3pYsyFWPw5bSU8MOD4v06J8cPEpNuMmNH47OUjcXvbo63fl
 WN17DpAbL6TEH009zCDdQ1TB/JCeqVXJeWcCuluYZ10nV6XiQIaScRDFEPkkdSYXQ3DI
 GmXgncRE/OBCpZ0l/ed2FM3IJFx9JaVumavv9qaidj2bnFM/RAhqr2roYFb87Os5VaLR
 oVi+oAk01uP4hiIi3jpO1FLcWLGtlnTb47qeOUCP9Ti+p4aR32OvIMlmAY57zSublHYu
 BLAhfI9LmPpjcql3nN7pPNU72xxAO3G/INl4xRvICgkNUkl2B54u1npJ68dXns120EZ7
 dk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905212; x=1693510012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTekSEOIV3j+ZTlF30eg6yHH9f51XSbpuCY0WmT3Fm8=;
 b=JrzKkDS0FENSmoxZTNPqI7kzzkVWvUd9Oxdai7u8GHi9LgyPA4tKYkXIoGhwiH4XWT
 lLI05SUfbkGOQNsnybEFwudpRE+o+erv1m6Wi9Y82vm00BWWDljM0rNcOHWozVmu621X
 2sol85DwWECj+eXtvEpdiNHa0jad35y6qWYnZ5NGa7j4K2SE5eEeABz6hXkHZJ8zmAym
 y5jgpTvBDyuobsz8KnRHO8hklISqjYuYgAQivbgiCvgfFYc/IvlEWr85gtmemTtL1iji
 hrcQKKswNBTrssCuVri7x1nPgsJHPfS8T+wLbyeyrWvTpsE39M1XgoC2iIHPSf8p5+an
 B+Fw==
X-Gm-Message-State: AOJu0YzkXNxM0qY2+p+PjORl0Nl/lSn5GmV3zweTLFOR2NHYTJ/W/3Ol
 /hy2Qkv2TuR07CaOcXYbc/Y=
X-Google-Smtp-Source: AGHT+IGw/BkAp+/BDktGfbEN2AIOc1C2WampXdUrxG8kUHPvTewv2x5koQyftKo7sLfFJ4P4b2YKBA==
X-Received: by 2002:a05:6512:33c5:b0:4fe:3a57:7c98 with SMTP id
 d5-20020a05651233c500b004fe3a577c98mr14709970lfg.32.1692905211973; 
 Thu, 24 Aug 2023 12:26:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 04/16] ARM: dts: tf201: configure dock USB phy
Date: Thu, 24 Aug 2023 22:25:51 +0300
Message-Id: <20230824192603.240104-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

