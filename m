Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB57EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66828864A8;
	Tue, 22 Aug 2023 13:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hd+nkMGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9F7864AE; Tue, 22 Aug 2023 13:22:51 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053DC864B6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a1869f2c06so528613966b.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703368; x=1693308168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=hd+nkMGr/6jD6IX/FxQBKVWl0+Ryj8yO09Qpwq2GLaXlCkTDgumtNXqrjfQcR4y+Mn
 c+9/aSdMcCEQxHPXAjLN6SBIotWPYLOB5zIV7M/43aOi0FVYBjNoVfqEchb2zr47CqBS
 kWoxshL7JIrKyr3Gh4Xxg0ExwiqhLzrVFdf9s/IHUnNZkwr2Q9DdPkCMjXjVzwM4e84z
 6e4jy6Y80Wf/PrSbRPWt1CVhuJGjhxXzNIPEvck7UHq0At1n8Qc7vRgXBFRbDVWPN69R
 A54bB6qPPq8RwEt8/q6G/ZcUsNnj2mS+rOHT5ECvJ+g18Bepo15meCcDN3bvBwYV3hE0
 Al0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703368; x=1693308168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=EWZcDdsw1lWF9oyR293pU/xAjh0cg7gAXnhqkW2WFV39/MRCm4ApYgefxitzZhqwZg
 9CjchytU7h64fRDysI/kHkSL/UCYh7Z1c3bFdzSP7/tqAy63DBbsFJx/yRhKE0HP0+YZ
 xmaA9eFwcaDzqxQcKNYdxmuPOgjGSXXiRvyvz413bHo0XyFM5bY0G2Q6BxKICTlYa2bh
 5k0ywKvJxTNU72dWqd2KTygVMXAeP3wzZLu8O7ws2N8NWKSScbU5CthmmiDuJ8LxPKRw
 GJPjO+z3u6P4HP5zRy8Bwhx6OVFFYPvePmQ0tzaXxygl2+B9EjHKH3tSGjS+PuiQfuBP
 OtZA==
X-Gm-Message-State: AOJu0YybJTai4h3yL5vtDuYgKS1ZLFyFgqlH83FuhcNLhaxXqOs+kpz0
 GCJ5QfrSI8Qpwg8EX+au2cs=
X-Google-Smtp-Source: AGHT+IFyRnb7jfzByIslwlDMgOGXewQMN4oW5Bi/2Fd+MXHohdvtvjqGS1B5HHf3tmTLqxgypDAbrw==
X-Received: by 2002:a17:906:538e:b0:99c:602b:6a6d with SMTP id
 g14-20020a170906538e00b0099c602b6a6dmr10605838ejo.11.1692703368485; 
 Tue, 22 Aug 2023 04:22:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 09/19] ARM: dts: lg-x3: complete missing bindings
Date: Tue, 22 Aug 2023 14:22:07 +0300
Message-Id: <20230822112217.4646-10-clamor95@gmail.com>
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
 arch/arm/dts/tegra30-lg-x3.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 922e39915e..6e52fc5a53 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -91,6 +90,14 @@
 					regulator-boot-on;
 				};
 
+				avdd_3v3_periph: ldo2 {
+					regulator-name = "avdd_usb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				vdd_usd: ldo3 {
 					regulator-name = "vdd_sdmmc3";
 					regulator-min-microvolt = <3000000>;
@@ -103,8 +110,6 @@
 					regulator-name = "vdd_ddr_rx";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-					regulator-boot-on;
 				};
 			};
 		};
-- 
2.39.2

