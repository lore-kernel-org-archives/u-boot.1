Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262CC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6218A8667B;
	Thu, 24 Aug 2023 20:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YI8J97UM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01D78082A; Thu, 24 Aug 2023 20:54:37 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CA283F7B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so9587666b.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692903275; x=1693508075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=YI8J97UMtR/Bwlu08V822cruWewf7ihNzDxoTh1h7aFqQRPVTFLPzsVlbk+iw4RlCR
 Zabrs5BCDiUf722XcIjecGv8383JtUEIq3887cje3bImQQuD6A9n87LHkurRjef4ws26
 jPPWg4AKU+emAr7BU4F3MW7WODufhbri5nH1L1IAzSsd/lWGNTvOyScmzp6nanlTEDV2
 qoJcn40OlEkYCj1gh7AWAhFQExoMKXaqxZ64LwkMXrb/Z7aP1YSIKDcQEruUD9Aahz+I
 Tdbp3aQ0aN9cfoK9JMi8NCCqekj9HazU7nwabG+vlbGN0MFOZ+nIcem+lCUFFAjsMl8N
 udVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692903275; x=1693508075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=jzFEWL/QXN7czbpjFfgOB+g+qNbXCKPYOBiAiGyCugRySQHl7dNuvg3V6eVJoaX1IV
 9SeHdhAbctyCurYA2bQUgOUWSou5AFU1IM7GxqDQXfGZE3tfz+RInKFk/jkwxohvOijx
 NfFB/6/Bb1PXS1vCNfxeItDmTkd4/thHp+hkYwY4XVo6MSM3wMqDYdIrRXDVcbYFmTu8
 g4W6LYrH+z4QnyBnBYY9LVwtGyiSBQxcKvWp95JKEd8/ZA9xHrygSE0esgrIqP1fcsSF
 aoixT2Xkntk7jauCTkU3xDGx4HIMDyEqQcQ4kkXO6LW0jdL7TZTF5C68fyfD38BQzFIe
 j0Mg==
X-Gm-Message-State: AOJu0Yz7ZZlcebpY2pUkq121ensUkyP4FqEDrJH2lqixr0Tp5eUHokVJ
 hExtMCi8ThIMrF9XmggoHTI=
X-Google-Smtp-Source: AGHT+IFtJC+K3HpT2Rfn3lNJzI3iWPaI1+o9aDJQTduM3IKTq2LyPiIiXfn3XAFPrBFelTstPEdV8A==
X-Received: by 2002:a17:906:5195:b0:99b:e243:9ecc with SMTP id
 y21-20020a170906519500b0099be2439eccmr12545440ejk.36.1692903274576; 
 Thu, 24 Aug 2023 11:54:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 jp23-20020a170906f75700b00989828a42e8sm11166780ejb.154.2023.08.24.11.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:54:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] ARM: tegra210: set default-tap and default-trim values
 in sdhci nodes
Date: Thu, 24 Aug 2023 21:53:31 +0300
Message-Id: <20230824185332.50176-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824185332.50176-1-clamor95@gmail.com>
References: <20230824185332.50176-1-clamor95@gmail.com>
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

Tegra MMC driver has hardcoded tap and trim values as for now.
Set default-tap and default-trim values in sdhci nodes to avoid
regressions in case Tegra MMC driver is upated to use dts values.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra210.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/tegra210.dtsi b/arch/arm/dts/tegra210.dtsi
index a521a43d6c..28ecd2b467 100644
--- a/arch/arm/dts/tegra210.dtsi
+++ b/arch/arm/dts/tegra210.dtsi
@@ -704,6 +704,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
+		nvidia,default-tap = <0x2>;
+		nvidia,default-trim = <0x4>;
 		status = "disabled";
 	};
 
@@ -715,6 +717,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
@@ -726,6 +730,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
+		nvidia,default-tap = <0x3>;
+		nvidia,default-trim = <0x3>;
 		status = "disabled";
 	};
 
@@ -737,6 +743,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.39.2

