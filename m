Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFEACDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED45686FF6;
	Wed, 18 Oct 2023 20:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nipq4RDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AED58702E; Wed, 18 Oct 2023 20:55:49 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48ED586FE3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b390036045so1168626b3a.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697655345; x=1698260145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hE0HNkTj94IIlpZ1Ogp+guT82KbHw6aI+b/3DFvV25A=;
 b=Nipq4RDMVeG1I/uPdEMpJf6KWeLFK2jM8PvTqIeS+sEv5+vQ51e8MLV8xnkYcWh7yB
 kCCN8CwR7RcdWuG6w5XO4cK9f830orXweTAO2OPK7yWtXqo/hgWayqT71U9BEls0GSPZ
 KfMfojWmOY+rq7Zfkh9EnFeTODoBgmSOi4AMYRfLmsAZr1j8S7BOpSZU3dxldtirw3WJ
 +hO3URNxnSpZjLh2hhY6eALGE8Pw0YH5hvR9WOWzvKSNoZ8aH9PdNCt58M8mY6Z8AN+A
 OdkLbkOldN+0DcxOxbCqMkxrZFu27nJPmA5hYfh+u2Z2q3Djc+WZZr5v7gbR15mC5DVT
 2oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697655345; x=1698260145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hE0HNkTj94IIlpZ1Ogp+guT82KbHw6aI+b/3DFvV25A=;
 b=hPiF4Uykg69p+tCMOg6S9R+bhhMB+XYTNsmrz69DFHG2uVGh2Hxjp6C5r9+Hwi+fXX
 TaY4WdqKWNZF1YB7m3obdLR76cpR2OiIPn6lJbjX4tvoHiY/fJHLsfj1Vl+Q/B7IrpOT
 N9rI/tsaPHrMQzimkwQBbVeytt0vuRBPTxmmFXdz5zlmetCSCDSISdwP4uDbd1GuNo+N
 Cl3UC+FcsaSr+hMpa9fL2+AS+j+oy+EhY0LhcYhc8JHwe3onFYnqRYtSFMkcYFK38ewm
 eiPz4uPmmazDGl8flghA3dlVq3k997wCqVn8QYEfIDkS5oL0n3+1lcish6amlDCPgX+E
 P02w==
X-Gm-Message-State: AOJu0YznYnSwrYcAzz6qcbGrkgJuiGFoZKFUQuBE3TLgiLyIC4YCLo6a
 4oPKrApDY+vS25FJgMAEKNk=
X-Google-Smtp-Source: AGHT+IEkFklRLlALjP2B85Q5EybnsxSHwSxmCeGqyj7/OTsZZXG3sNDd0LoAoSn0RUMHWWs+pW8mOg==
X-Received: by 2002:a05:6a00:1d9b:b0:692:ad93:e852 with SMTP id
 z27-20020a056a001d9b00b00692ad93e852mr6224084pfw.2.1697655345542; 
 Wed, 18 Oct 2023 11:55:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a056a0021cf00b006b2677d3684sm3682302pfj.206.2023.10.18.11.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 11:55:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Date: Wed, 18 Oct 2023 15:55:30 -0300
Message-Id: <20231018185530.1272005-1-festevam@gmail.com>
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
Changes since v3:
- Change the Ethernet PHY address to 5 for good :-). (Marek)

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
+		ethernet-phy@5 {
+			reg = <5>;
+		};
+	};
 };
-- 
2.34.1

