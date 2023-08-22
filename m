Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3289EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8B3864E3;
	Tue, 22 Aug 2023 13:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMTJ23M8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4428C864A3; Tue, 22 Aug 2023 13:22:55 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E62864AE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so73320081fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703371; x=1693308171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=oMTJ23M8G3ajOp13ReIa7sFJ+uSUfXPty3UJ3XC66fZTnsaEYciLwTndE2u4KDadNo
 yB1YriKvMNJd7fRfwGTNsjAP2D41KXfUpxS6XlrKCpqdA57WqltDxoe1wMi9DNt4v+jf
 jNtqKaLcNoRzXbJSQYpTgSXwavQr3RAPCmNmAgn4YnvW6pvl24W9A4OPlJobpgT8SyXM
 KwFIP4iF73oEc8eknMgeF9O85abm0JRGIjXuPSMrGZmypZQXotvTdUH9txhePFRlZfCO
 B5OYfWt6xUi8MvEQUzJVA68atogEdvzfgfi5FE4+iVYeCChrAfKV3WKhdgJ53yf+PQGv
 48lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703371; x=1693308171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=aZknY2+YlAZJ1OihPjlKKPAEdO464hsVsfeW5QTuKp+Yg2GSM9ABK3zX0bXiYQFprT
 uDoUIWj4eFxz7oLDcpPGgfVnlvJw3NAzCrAzUXW++07SvS284f/XrKcC2jBxGQSMFq3P
 qTcsNQdg7LUUSZohWE8w5fHvetTD3MQ51h6ZsypEEaEUb7G3myZoIpH/lPQLU55Yb2Ea
 ukadtvZ5dts7Ms5fvf4VxRUHV5rMoTtko2r6bTSjGC2/8eQyadRvOe1BKFnaz3k45q/P
 wCrkjF2z79mOD0R0ZnC57kz5QEFycL+lUpefIVMmJSRcB36KYpz0R/eb2rxa3kiLaXeL
 V8+A==
X-Gm-Message-State: AOJu0YxjCFDNNh1RAvIB9/jl+/tzJBgeEqBKXu33MOfXkFF6maBtfQkf
 8Vv4hgI87jpIMDdM5+2NCRo=
X-Google-Smtp-Source: AGHT+IGj8hfbXajM27njP+erov4/gCYmFH9OrY4UWZbDD8swtO1EhBQMrwRPgnpLw/b1dgaKAof4IQ==
X-Received: by 2002:a2e:b603:0:b0:2bc:ba71:ddf2 with SMTP id
 r3-20020a2eb603000000b002bcba71ddf2mr4962144ljn.15.1692703371137; 
 Tue, 22 Aug 2023 04:22:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 13/19] ARM: tegra210: set default-tap and default-trim
 values in sdhci nodes
Date: Tue, 22 Aug 2023 14:22:11 +0300
Message-Id: <20230822112217.4646-14-clamor95@gmail.com>
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

