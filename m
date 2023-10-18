Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D0CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB278702B;
	Wed, 18 Oct 2023 20:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JelJL70T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E24E8702B; Wed, 18 Oct 2023 20:52:45 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DBA8702C
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ca85ff26afso6313055ad.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697655159; x=1698259959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/lyuC2txCJpOkzt6XbMO1+iy6XmNoJ32RPGrD+vFl2s=;
 b=JelJL70TFZuzfSplDtfBMPFwvZweeSZOBzU1mQpVQEdA2zgy5JtfVKZnedSEjFN980
 3qmJNCABzUdDZcrAc3EFZzrhoC29qFJ83FMPXL6S716G7tIS5820PL52XzhZHLK7/26L
 WO+AUQ6nj2FoQrg2/YQPC93KiNfRpomgu4fhMOuVGDnFvMu/HVx34i7lW9NTg/kYI2/3
 HIA1eJRZZ1orVbZxIMlUDJXWD4NFYEkcUE6i/SBKTtpVElmIbrXHEJ4pjkoftdJb3BcR
 5EXhHQ7r5vEjxke30x3KqgaEPA9MIK9NddeuT0Zx57tBN9PLyCZZMrqneYNhCo+AP744
 FGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697655159; x=1698259959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/lyuC2txCJpOkzt6XbMO1+iy6XmNoJ32RPGrD+vFl2s=;
 b=dEsMlvdk6u4vqAjeFHbrnt8sSlW81C1oygK4p//q0no0lJ10VcDj/qMIkyV+feIPPi
 Hl+zyDeEYc9rbVekb80gmEZccGXTYVJuyUU9TdB7InjXfhX1W7XNdWOWR2zX+IHOu7Yv
 xPwZcD1hyfOrWNdnCtZt6RT+xjK/qpUarWDPGUURb49ViTSK0/hd8it42hHRHGT11EeE
 4HZDXoT3r9GMCbPdf5z1ONMV6GST9eiv6e5kWf8pc+Ngomko28IFroHim9E3xWiS6Yhl
 undInZz+vZLfjfeC/FAlgbuAMImEXSTXj31kJVbMg9Cw7kNcUu4zJDfux0Bg4VjA6I2Q
 RFGQ==
X-Gm-Message-State: AOJu0Yyj4hqL9AAtZFouGXE3py32N9pjRzVb84aOX/YvAPuM8In3mpfJ
 hFhzPgOa61F1/Gx62BjBYwiOa/isyko=
X-Google-Smtp-Source: AGHT+IHjfihtsb7KXPz6qWMq1sYX2JghdUPflpR6dp983DzoSKwF0gokIbA6rl/OtDC80OiVdGpu7A==
X-Received: by 2002:a17:903:27cd:b0:1bf:349f:b85c with SMTP id
 km13-20020a17090327cd00b001bf349fb85cmr223877plb.1.1697655158865; 
 Wed, 18 Oct 2023 11:52:38 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c72f4334afsm272711plb.20.2023.10.18.11.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 11:52:38 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Date: Wed, 18 Oct 2023 15:52:25 -0300
Message-Id: <20231018185225.1269962-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Pass #address-cells/size-cells in the mdio node to avoid the following
DTC warning:

  DTCO    arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo
Warning (reg_format): /fragment@0/__overlay__:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #address-cells value
Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #size-cells value

Also change the Ethernet PHY address to 5, as per Marek's feedback.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Change the Ethernet PHY address to 5. (Marek)

 arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
index f27e6429abe4..bad015536166 100644
--- a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
+++ b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
@@ -5,6 +5,13 @@
 /dts-v1/;
 /plugin/;
 
-&ethphy0g {
-	reg = <7>;
+&eqos {
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet-phy@7 {
+			reg = <7>;
+		};
+	};
 };
-- 
2.34.1

