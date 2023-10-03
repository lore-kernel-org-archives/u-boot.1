Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA34E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7058C87211;
	Tue,  3 Oct 2023 08:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2lv9CbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A8787206; Tue,  3 Oct 2023 08:34:05 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F0887206
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50306b2920dso627130e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314841; x=1696919641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=C2lv9CbBfAYG2VrqCNXsyW97AG+3ziRlROxeecfqSKt9MD6CUuO46m2LqUAXE6qUWm
 4FxNJ2Ngt2DPKHq5cnOKRc98JyykgOWqkNNGRVIyiWdAsiF545tdczwwJpaijQhu1Mnd
 UULOcUpj57GBDtpwyDwH2JISqHxuaX71EKY0IAJFu8ZD21MWnY/am5Apw3l96qyCFiit
 qaXF+cnR58CnMcnZM6g6JUvZUpUAIazKgVuUv6ccQdfBUh5gBOsJvItxL0nrwIPfcFSa
 avvSau8GGhTdsGjJXyxkD8TEElgx3osO+tKAfNnKvEXAKWljCMIdZPJW5QJXRWlF3Cvb
 vrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314841; x=1696919641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPtXOOiwEFwSldlz/wVEYOL86VQ0DtI+RVkc2puDFQI=;
 b=dy6Bnzip8JS1oCdraQQgpY8yy6Vgyc2rUe8ir35LJ8R87v7M936O6XH6csuz3ypzrS
 PwV9uFeOlDTVP+zFdHpgBRppY+zZIAqREj9n96BCmO1axqVmiOkdWErMHn4on1vLj9fh
 4y6T/5qa/ioD67KQ0l6ueed2Hyu3bSp1dvBkUu/mIxUAqOOe3615K13uvYnhv2NViu5R
 ILPDzUvFo9lnY957zw06sb/36a5vhswyPDJHgRoUDW6u4P3e9kDLtGBLNOlUP73SoZoK
 E0XeMTf+34sifTGn4wOVKYXWSB1ienzZ8u0NflPvynp5rI6y+Ps3rzxL7BKrX00Q3Sjf
 u25A==
X-Gm-Message-State: AOJu0YyFGelDUVcofT/UCUScIOlcE0XCWvZpt45+4T2gGbgrslBLb6Kv
 VslvRMrWUhK+GGZCIdrG3kc=
X-Google-Smtp-Source: AGHT+IE9p2wnEVzJ2vfW6CVY4Le7kmDKptf35dV8gVATRmBOrsQB3awjo3/KzuIlKdOZZWC4vQ072g==
X-Received: by 2002:ac2:4a65:0:b0:504:7d7e:78dd with SMTP id
 q5-20020ac24a65000000b005047d7e78ddmr1288828lfp.23.1696314841336; 
 Mon, 02 Oct 2023 23:34:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac2520a000000b0050309ea3a62sm75769lfl.277.2023.10.02.23.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:34:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/2] ARM: tegra210: set default-tap and default-trim values
 in sdhci nodes
Date: Tue,  3 Oct 2023 09:33:51 +0300
Message-Id: <20231003063352.42660-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063352.42660-1-clamor95@gmail.com>
References: <20231003063352.42660-1-clamor95@gmail.com>
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

