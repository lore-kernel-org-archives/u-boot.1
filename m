Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EA1CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 17:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B8E86FE9;
	Wed, 18 Oct 2023 19:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTwjEGWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97C586FF7; Wed, 18 Oct 2023 19:21:31 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A507386F8B
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 19:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9d132d92cso17765425ad.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697649687; x=1698254487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=81hdfF7G20OpylybowfHBGeQwv0pao71kYtOIaYPAGk=;
 b=UTwjEGWD47XhIxJ8ewfBoCd7VoPB2b5Wm1VE8/GvNSZwEFsDYeYBDI7sdCSZ9gaLzw
 QogabmRbVclezjqoWLa9NF+9e4m8girJNwyUwFgIcVgEQ2LMYVD22StHwm8F2e3BTfok
 k0Oxrq22Evrvrp8oUYyFGvjSNjQ120Hev4rkQhOrA+WQA/RXlDInx6yB2IjfNeUSskUA
 p3XQYMMJSBBHyAxyx4EGMJV4vmfK89iPeJwe5ZJmd7svbr78uN6tXI3PhKgiU8ZTPH3J
 gygVLdhMpFf/PnwbHpo303thflz4u6Ovw9eTIBdD/+gQioYGOKs7gX2DjwLW8oMhilBa
 ttPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697649687; x=1698254487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81hdfF7G20OpylybowfHBGeQwv0pao71kYtOIaYPAGk=;
 b=pAjgH7WpCJu12wqwha+DRU8yqdhXcyPXOpHbE0ZxAbuqDSSDFkG8csrMrnOJufqZlq
 zE8CKJNk9HaaP83JL1uto+dHbCekjI9mtZSsHIV/LziXRQQ0nKAumqZ5a08DVu+AWbIJ
 Nt2y7lZxj0EZQ4MwcEA0R5F2Pt1Oy1Fp+nH4mC1ljdArPbnPRG6SO26+J1G+vo4C8pwz
 vgrWWwBDuBs5vSbC31TYwAI1G/nOEot+75ALDBrX1YIR8DdSDtDAMxPX23y3nG/lottZ
 tgrnSB4ScDUxwrKlfP6XzWu+p4Y112x9c0HY3Op6xRlqNLcBNRj70JpQCkaQJR626Ccz
 gC4Q==
X-Gm-Message-State: AOJu0YyvOOaT1Q4SlV999DmEBji2How+GbPVWlMSHSSNcia/tbd2IoA9
 bbsHBNUBunGETEnZJZCVy6VbNUjc4HI=
X-Google-Smtp-Source: AGHT+IENyLrxi+6YAkbjdfy5x+tP2bbB2Q8ROJgzE4DVa7CCpJaUYB/6W0KpPdYX3j8gRnVLXx+Ggw==
X-Received: by 2002:a17:903:27cd:b0:1bf:349f:b85c with SMTP id
 km13-20020a17090327cd00b001bf349fb85cmr1773plb.1.1697649686856; 
 Wed, 18 Oct 2023 10:21:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 jc13-20020a17090325cd00b001b898595be7sm164636plb.291.2023.10.18.10.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 10:21:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Date: Wed, 18 Oct 2023 14:21:03 -0300
Message-Id: <20231018172103.1197671-1-festevam@gmail.com>
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

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
index f27e6429ab..94bee3c508 100644
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
+		ethphy0g: ethernet-phy@7 {
+			reg = <7>;
+		};
+	};
 };
-- 
2.34.1

