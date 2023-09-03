Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6970CC83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B7C868D7;
	Sun,  3 Sep 2023 22:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BwkTqJj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D46868B8; Sun,  3 Sep 2023 22:48:59 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84FBE867E2
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bd0bc8b429so12710991fa.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774135; x=1694378935;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSfjxtQCmq0VaRg1MRMvJGczP51v56zG9MGuctvIOOo=;
 b=BwkTqJj+/UyCCW/guXkZTzBoWR4T+0f5Yg0DEufT8Z5xXzpRHp3lQ1M8++OC2tl48w
 xRvcPOf48qbSeZM7h1m4avHcGd/ad+prnhnXwgFl3WBjN3mwanUjJ+eeU6qNQHUYy6rw
 9ywQ1RtBhIdCgm/YkERBBVbzGHQpzkcNHpgyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774135; x=1694378935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSfjxtQCmq0VaRg1MRMvJGczP51v56zG9MGuctvIOOo=;
 b=KGgCEAkUVnsSzD3Kk9dXG2bydyke276JKVlgx6SzheObwlAxQiQ5ThLDwY7pNPfogF
 jIwB9AW2puLHw+s4Ot18ksPx3pu9ysWKObqCUEd7voCuDLAnPPh2Jj+4525AeQXeGbZ0
 QNyCwUmFKP8Nkz6vGef/O8WpPgtUjDLS3r44rxWIoEJW0+VXEC2rWsBVzZHXTEjOki+l
 0Dn7vxO2hZ7MGa2kXMdYeDDhrniifNgHcuUVp03uqhXC99yzG6Abrb4G+HfXcZm9iosU
 UgFyoUdS85ZrDSqA5DbUDL65bnASromFzFTsKkiHlYZhQoqreqDiwJuU77H4pivFWs9d
 YkqQ==
X-Gm-Message-State: AOJu0YxBpiQ2v6bj6pE1MFcm1sW2mX/m4eOyxDf+CDIcefH1JZ13Ltbc
 t12hmiLt7JrNLCNv0JSzb8QN7TmSTSweYskcoo6yjQ==
X-Google-Smtp-Source: AGHT+IFXx75DROO6rbQSVzTAyUg06Gn23A7nd/USAD48Vs/rGAuMferDo3ujJNd68UcRAAd/sUS1eQ==
X-Received: by 2002:a05:6512:3a8f:b0:500:ba39:f0c1 with SMTP id
 q15-20020a0565123a8f00b00500ba39f0c1mr6458180lfu.20.1693774135345; 
 Sun, 03 Sep 2023 13:48:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 =?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 02/10] ARM: dts: stm32: add pin map for CAN controller on
 stm32f7
Date: Sun,  3 Sep 2023 22:48:41 +0200
Message-Id: <20230903204849.660722-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit 011644249686f2675e142519cd59e81e04cfc231 Linux upstream.

Add pin configurations for using CAN controller on stm32f7.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230427204540.3126234-4-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

 arch/arm/dts/stm32f7-pinctrl.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/dts/stm32f7-pinctrl.dtsi b/arch/arm/dts/stm32f7-pinctrl.dtsi
index 8f37aefa7315..000278ec2c58 100644
--- a/arch/arm/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/dts/stm32f7-pinctrl.dtsi
@@ -284,6 +284,88 @@
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 11, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_b: can1-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_c: can1-2 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can1_pins_d: can1-3 {
+				pins1 {
+					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('H', 14, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 6, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_b: can2-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_a: can3-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 15, AF11)>; /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 8, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_b: can3-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 4, AF11)>;  /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 3, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
 		};
 	};
 };
-- 
2.34.1

