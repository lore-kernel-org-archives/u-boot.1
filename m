Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B28CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 17:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4AE087005;
	Wed, 18 Oct 2023 19:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdyIFJYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BF88700A; Wed, 18 Oct 2023 19:54:24 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A5587000
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 19:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2739c8862d2so1217113a91.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697651660; x=1698256460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fsTKcC/hWS5HNdNX/nnldK6jYMkQB+IpecpnPfaL1kk=;
 b=OdyIFJYYCJITomg7YqdRrrSkstZp8o1HqZ6kYz5infUrQFvnaXLAmCN/NUPfpcEeJB
 YMck9lICR3U3YCFBXGSWgyaAFAQloMgPZ6QPp3s4d9ORk5pUP4FKa1qs8TYffHUUvhJp
 fGc2DBBgD4mS963bFjSKgElcFlXjpc5XPd1PB6QhTONcVxaIEo3M2v/4exqUraZA5tI3
 A1mLNjahEeviHLJm556Tst3eZBBirT86/alw9Ag8YvVJozknGtijRXvgof7iF2nYJ5qC
 vGdqO0IxWZu4bfxjYxMdc7w1MP6xj4STpUi7FILVcA6Wi52d0YG/9JUwQzgb2WteH3YJ
 Xn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697651660; x=1698256460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsTKcC/hWS5HNdNX/nnldK6jYMkQB+IpecpnPfaL1kk=;
 b=pmLATCAvnHYbAlt1cvvhjsmCnIEJNiZV56x10VXy4VmFufwHw+cZUeQitj8WZnrT3X
 JwGZmMVVCTK9L19DrAiTE7CjnWKMJJSKlT6dz1IpkPLlBQmzlfu7oA6ICJblWZCOukFq
 jxbbC6L6NihG66SGZXRwNZDd4M+EgTvKpVya7pJhXyy3Fm58nN+ZJP8xsyWeWQTe+sDi
 lp6+QOYF+RlIRlDhbXa6kLdJEKSaXjuE9ga8e8Y543vWWLMOXb3aSh0w4d9oEpuSnoMq
 8Z1dYbgN6jqNrDsXAdhKaZdrWiZINrCmXqbdcFo4g92NghDpPzRT1bnXErJdYBv2n5Zh
 DzQg==
X-Gm-Message-State: AOJu0Yxz6PDUkWERD9LiMNS6M56MWoO04Od8emGmPIrHdMmBewpwK6RY
 au9l7BYjlTX8sxhjYoy1WbZbisRF+QI=
X-Google-Smtp-Source: AGHT+IF4GoinBukMwjfM3gyzjXBXyScsj74fBqPR/L/cR9cT3/KIOZf3TfQ6StRavIhJmnHXP7Jyfg==
X-Received: by 2002:a17:90b:4f88:b0:274:99ed:a80c with SMTP id
 qe8-20020a17090b4f8800b0027499eda80cmr6408007pjb.3.1697651660119; 
 Wed, 18 Oct 2023 10:54:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a17090a2e1300b002749a99318csm164958pjd.26.2023.10.18.10.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 10:54:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Date: Wed, 18 Oct 2023 14:54:13 -0300
Message-Id: <20231018175413.1236767-1-festevam@gmail.com>
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
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v1:
- Remove the ethphy0g label. (Marek)

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

