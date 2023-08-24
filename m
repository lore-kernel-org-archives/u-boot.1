Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D131C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D835869DF;
	Thu, 24 Aug 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6Kk2da1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236AA869C7; Thu, 24 Aug 2023 21:27:00 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551F58698D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a4818db4aso298703a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905217; x=1693510017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=O6Kk2da1MQthDxAAAQgYQpjhDdEWWp7tRqhM+gAh4Qy4c7D6TGkDxnddEsthj/D3th
 PQ3fpuThUH85fDKaVn1hJtSOwCzHFSPbqjhPjCKN1hpW2aNfcsWUypNIuA7eeAw6YiDU
 CSTZbG23K+VT3QnHEiXykPNvb/sNwtQ0NFBvCIH96PwhMXkShtPjILKOoz5VyZe+eSvc
 5pGIC+mTrTNDDJKm1Pl6iF/tZ62Kr/ypMurJmtMTr9m2w8dOWUP+h0mlFtMceR/G0gUJ
 jWs9LUMpZhMfHn/HEqxstXJdKt3n/hPEuQxo2bEViu618fPtOnLlsYvZuuHtaI+Ga8ny
 3WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905217; x=1693510017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwFbiwXgnoNebUKcMaE5CPo9N+pBTPcV90X8EJXYPyk=;
 b=RfeGNw/4G5EAPvCAutakzq8V/Wf5nYkM0ED1Ch3oiSsm2yMZiROyql015B38H4PaST
 LTnimSaXrEIXIrK1TRaOzvE5peHfqqR85QEDM/+4R4Z4GmIsAWUwFdppVREJYIZgMWst
 8LMiNpRv3hbRD+3wMjLa0gc+b0ehRj9cstjFn/ICzu9FgdIh81FeHYlBTPtUE0lsfAGp
 TLtL+ue6xpgHeLmQosjko3NCFKFeLzlPgrBsl5YxHbQVVga2ypGzp1hyphJhiRlKT+c1
 i0abRwrJTUmO1Rd/ftZtBxgRRkgJmmls5IioUWa4t5I/sH+g8sYFvxzkiEl4X2wbXdAv
 MRxQ==
X-Gm-Message-State: AOJu0Yy5LmSLhNNsKswPH8KjAEutGIsL7+o7cPCHqkk/MESxHA1/M9YL
 s4Vl9xUcAFEzK64xtItUKBEpdMXTGvFCcA==
X-Google-Smtp-Source: AGHT+IETO5Doo8o5+55HdInw/vLnABoQ1Yxf4oH4HChuHu2A3iQvXHVY5R5IkK1PNa75LhJ0g4jj0g==
X-Received: by 2002:a05:6402:31f6:b0:523:2df6:396a with SMTP id
 dy22-20020a05640231f600b005232df6396amr13413400edb.37.1692905216864; 
 Thu, 24 Aug 2023 12:26:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 09/16] ARM: dts: lg-x3: complete missing bindings
Date: Thu, 24 Aug 2023 22:25:56 +0300
Message-Id: <20230824192603.240104-10-clamor95@gmail.com>
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

