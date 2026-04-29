Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D3BFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C298848EE;
	Wed, 29 Apr 2026 23:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tzvUIzl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D89D84832; Wed, 29 Apr 2026 15:59:20 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FC284837
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so166679595e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471157; x=1778075957;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fWhYngX4oKahgqSYcqgqxnr6sDbAxysXYJW0b35SDI8=;
 b=tzvUIzl2132KHuPfs4a4MRj4hBYg86nD8jFnEMqIOBtHmcVYUS2945+8ScIfBRRc5x
 5HKWw6PPQBBtvfwijrNtSWlr02WRKglHzyyxma7WXcLb+Dx7uQN9DmdC3ORTGQ7vra1l
 7NAAsfsTwGyjuxYzW0Zl5gNgd4n2jmjXSinaoHQiCI91Ej5rTgBTNAEXFnVPGcgA8qrm
 EvW/C7f3TIJ7AunptIjbP9ltKUKQ87zNgDBOR63IEQ/l0hDPqnVjEWu9tSZ1MN9TaPd7
 KCE4iFN3iRdkojaMhPe2O95bVFvGieJBV2o+MeO1KdaQ25KIxsKLmnrtgWGBD11V2AgX
 D2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471157; x=1778075957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fWhYngX4oKahgqSYcqgqxnr6sDbAxysXYJW0b35SDI8=;
 b=hIfWMXbwLImcw6+CwkaUWxUIA3Qes6ovZR1mfYsZO3sx7Ri31INSarIiclFfQ4Rkr6
 /+rn0iPJ1tgyBYipjMHc1S9/IU6SLTKyeHHjBE62tom1ej82JKM4ar8nUuK/+Yd7ioLt
 lOFuqwqpHSX+SySZAzfatEBzpruIwQUQJFkzDipgFQ3y5DiTHeIT2aYkoYyH5ljVq+0Z
 g3lm24vqOVcJUH3JX3mMVJLOejmm3ltPGlp3rGlmjXvWCvneMVdiFDFynwUaiENXyXbw
 2xx+HDP7xaWs6/9Vr6Gi0JkbjPyUVTq/ZjmPaUzLD84cRHSX3FFaw9S4JWf7d3dAFtVU
 eqag==
X-Gm-Message-State: AOJu0YxI3KtfwsQ0SZi2JYz8VgUNSMq2uIDGoA2DkBvVQSaMStoxklei
 dVh4EMvGlVVF974ZH4tUEr6dvN/GJI2JRRKjha5FFjP66ZvSQUQxUJO1oLVh23+JGxo=
X-Gm-Gg: AeBDietLagFVx0I4O0PllqRHvVNtPuA7EEXItmQeZdDkRS+bnAZoQ6HtqaZ+Og78jgf
 9PEuc1zXL24JXixqFwJ052kV9NN85lYIhP9GSSvYovMGWYjNwvBvv141c99qPNx5KMGajX9mcJx
 aZDHUFNFjPF0pGZEAWBackQPdXo+k166l6TPNDH77hpzIRmTlnFuwAP11La6e+9l4iF4gG4cXvO
 bR7M4pbdpHRJPeS8m5tSuFETIVLZfRWPuofoicp2el1VQirgZgXqUGiPazLl1cXFIbvg7WA8vhQ
 cH/U/fY9tfgoUvFhF3KZukP08Y3MSr7tt9zva3BU8GbOn6Zm1zvgpkvVzFZuq2lbVWwMZJGFf78
 gs414d3EEXfOktKgArHhoi344tI3zdX/0QW4k889kzujIohxDi+B9n0dJs76onLQ/1uwNzSjL0K
 kaWccXRh5KCFihcGR2mzrwnFvI3u2wyKAcmznAekqmQuVu1F3CYnLv8r6NEHS2u6tGEI1M5y8Ph
 dKaSiArDQ4fj/zZao7Pvw1PDpTowR3oiQQwuKSVb6wZuf7v3K5b1FIkTX8E234L5DgJtU6pNbP/
 nDiZuwSiUaGpwNiDrEo=
X-Received: by 2002:a05:600c:1e8b:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48a77b146e0mr124154275e9.20.1777471156738; 
 Wed, 29 Apr 2026 06:59:16 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:57 +0200
Subject: [PATCH v4 4/9] net: Fix alphabetical ordering in drivers/net/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-4-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

Reorder entries under DWC_ETH_QOS to maintain alphabetical sorting by
CONFIG_ names:
- Move CONFIG_DWC_ETH_QOS_QCOM before CONFIG_DWC_ETH_QOS_ROCKCHIP
- Move CONFIG_DWC_ETH_QOS_STARFIVE after CONFIG_DWC_ETH_QOS_ROCKCHIP

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/net/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 666618681df..15a4b3b7705 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -246,6 +246,13 @@ config DWC_ETH_QOS_INTEL
 	  The Synopsys Designware Ethernet QOS IP block with the specific
 	  configuration used in the Intel Elkhart-Lake soc.
 
+config DWC_ETH_QOS_QCOM
+	bool "Synopsys DWC Ethernet QOS device support for Qcom SoCs"
+	depends on DWC_ETH_QOS
+	help
+	  The Synopsys Designware Ethernet QOS IP block with specific
+	  configuration used in Qcom QCS404 SoC.
+
 config DWC_ETH_QOS_ROCKCHIP
 	bool "Synopsys DWC Ethernet QOS device support for Rockchip SoCs"
 	depends on DWC_ETH_QOS && ARCH_ROCKCHIP
@@ -254,6 +261,13 @@ config DWC_ETH_QOS_ROCKCHIP
 	  The Synopsys Designware Ethernet QOS IP block with specific
 	  configuration used in Rockchip SoCs.
 
+config DWC_ETH_QOS_STARFIVE
+	bool "Synopsys DWC Ethernet QOS device support for STARFIVE"
+	depends on DWC_ETH_QOS
+	help
+	  The Synopsys Designware Ethernet QOS IP block with specific
+	  configuration used in STARFIVE  JH7110 soc.
+
 config DWC_ETH_QOS_STM32
 	bool "Synopsys DWC Ethernet QOS device support for STM32"
 	depends on DWC_ETH_QOS && ARCH_STM32MP
@@ -271,20 +285,6 @@ config DWC_ETH_QOS_TEGRA186
 	  The Synopsys Designware Ethernet QOS IP block with specific
 	  configuration used in NVIDIA's Tegra186 chip.
 
-config DWC_ETH_QOS_QCOM
-	bool "Synopsys DWC Ethernet QOS device support for Qcom SoCs"
-	depends on DWC_ETH_QOS
-	help
-	  The Synopsys Designware Ethernet QOS IP block with specific
-	  configuration used in Qcom QCS404 SoC.
-
-config DWC_ETH_QOS_STARFIVE
-	bool "Synopsys DWC Ethernet QOS device support for STARFIVE"
-	depends on DWC_ETH_QOS
-	help
-	  The Synopsys Designware Ethernet QOS IP block with specific
-	  configuration used in STARFIVE  JH7110 soc.
-
 config E1000
 	bool "Intel PRO/1000 Gigabit Ethernet support"
 	depends on PCI

-- 
2.52.0

