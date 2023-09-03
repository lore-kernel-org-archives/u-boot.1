Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B9AC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C96868D0;
	Sun,  3 Sep 2023 22:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KN9fdILS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867FA86828; Sun,  3 Sep 2023 22:34:03 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E701F867EF
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso12779001fa.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693773238; x=1694378038;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEeomf7ZPFQybaRfXvdW6XL/l95ik8glYfxOcn+2XI4=;
 b=KN9fdILSHUaDMHZf2P+zPlvqrduoTh7G2PiV6ln2ixhPm0VZgs7rvEgoGkscgdRZ0J
 3dcLboLi/2RT6x1G0BvtyWsCJNSCY7DderJ5dsQoN/U8sM9Ybopded23qc9wuKTNjmU0
 qh6E5DCfpt7wM4FLZIJlz7SmLQjdMYynzw2kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693773238; x=1694378038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEeomf7ZPFQybaRfXvdW6XL/l95ik8glYfxOcn+2XI4=;
 b=ZEjEm8R28T3KcKndxXV1HmY0gaK5eicSgN63GNhjAORdI5YbRP84SWnmcqSYnHCNUI
 EoolYcO0kP6Bm3Q1kIAbh75w+MQt9+nFNPA+2E+pzewKuiDHuc26z2jEJl6SiZGJAYqv
 bnA9C6VuNtoYVwtI8YfTnXCmpWBnl2E2wjRaXipyEuMfnGqjWHH6sWkAdMgLCBF6MTCr
 CNyOC4GgGW8VtjXcsnoRk0zvPJKMVeieJrEFCaFXDW9T+pywNgNOvnm6GuKCQ2BkIE7z
 CqjbdxfCWndUCyeSyIjle08l8Or8orozFXqX/SaDfUvKMJRDQrHDCpWyQwPpZIvU4XUb
 Cn8A==
X-Gm-Message-State: AOJu0YyOxtUSqjuaJfP6igoIba4NJvHQfyalEZlV+7/WMCLtsen/obc4
 r3SB+pFB4oHKnr2btjyNFnaHEqtH3SWGqHr+NsCeuA==
X-Google-Smtp-Source: AGHT+IEoaCH60V/tG+PSeJ1dGrxbWfPcKes0xUV84X+2vQ2YNzEGdX0F4JbShW1vPAmLZSJ/dspgcQ==
X-Received: by 2002:a2e:b70d:0:b0:2bd:133c:58ff with SMTP id
 j13-20020a2eb70d000000b002bd133c58ffmr5294506ljo.48.1693773237816; 
 Sun, 03 Sep 2023 13:33:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 pw9-20020a17090720a900b0098884f86e41sm5103232ejb.123.2023.09.03.13.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:33:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/3] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date: Sun,  3 Sep 2023 22:33:51 +0200
Message-Id: <20230903203352.658691-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
References: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
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

commit 559a6e75b4bcf0fc9e41d34865e72cf742f67d8e Linux upstream.

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230328073328.3949796-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

 arch/arm/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/stm32f4-pinctrl.dtsi b/arch/arm/dts/stm32f4-pinctrl.dtsi
index 46815c965d59..0adc41b2a46c 100644
--- a/arch/arm/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/dts/stm32f4-pinctrl.dtsi
@@ -412,6 +412,36 @@
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
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
 		};
 	};
 };
-- 
2.34.1

