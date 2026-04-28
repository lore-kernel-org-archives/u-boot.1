Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD6FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338C08460B;
	Tue, 28 Apr 2026 17:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Yd6e+S6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC1C84119; Tue, 28 Apr 2026 15:17:34 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A0184150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso85793445e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382252; x=1777987052;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qQEmXp6qXUCvvn116a+QPA/U24ZJCdS1jQoE/q4Z+/Y=;
 b=Yd6e+S6geHT69tw/JP7d/XXwlhdtzoCfTTsGbjQ2Z4AplbcBPxjlOSILagO/AOhLKe
 3Q/8wy4NVQlO9qvpdc+mz7wKhN6WsqpJTCDNtrKNQ0iNSYqKiRWFZ7RKbWD3FrLZzsPy
 45JT0qQx82x1H+dflh4Oduf3CciEr4o3hq+Gqhtxv//gOfTiNrNguI5OhMAKZkdBrFiE
 1i/N2Uxk3XqXHz6TwGuDIH1jl0wnrGgnHZtgTN8Sn71Q12vnDwytwEQ0xFjx0Di9hvJv
 EM14ohule6ZHLUV5UpRUAXQwAep/9LjqAmoB8yxHJJXSIE1frv9UDEi7KElTtPMgs04o
 i9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382252; x=1777987052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qQEmXp6qXUCvvn116a+QPA/U24ZJCdS1jQoE/q4Z+/Y=;
 b=FaVUeXDKGxnxBpg2CU+yklAqu493o/ed+Fm3gaxdWGPq/zVsvOw/JUMvKoTlemrFHY
 u8xLYR0UoPkwf1v67993+BDVhwe06yR688C50a/Ab2v0V8n3tmw2D0SNacaH5Psrd96z
 fZqiBL0wQrT+pcm+ALCHw+SrQ842gay1FFUIYQ8V2IQL8j0YkNlAEghAu9M+ZXroVQP1
 vniNcLtmABMOK1yF0JPVFEjH646P8GWo8v9l1+FO0qas/MRIVs0Qz8Fzo2syUdqGJiNX
 ZA777NlTGfBJYe3CPFCiIUee1tMaymp8Zfk7ZPedUOel1GBYv/bUEvcSVgu5gASHveTf
 J02A==
X-Gm-Message-State: AOJu0YxX6wucqd7BNLtrYbayz4k+gg2sk7jNp16M1LNAxkJAxwTWq/MH
 jKDoJ38DnkvJ5HSLOHF7XeMZ/UYPNQ6vEES9VgLz440BnaqWy/o88+ZwEU8tdWY3YSg=
X-Gm-Gg: AeBDieuYYtcxg6i/Hzq6nHmYpIrjdn+02jO0xjBIFOT+6UkCfmzNYnL+KHjAnJEiPfk
 U/RDhItI2Tiz46JiFIh847xp4HEp3asmlk49URcr4iPUBHGUGxoKEKu2IHW/Y3lGGUxxznxrqt2
 KDSw1nZbWQjNKRqzXUvjU65kcyDFYDNVle8dS7UXry3cG95lqAr35yjn0hPqU49LJ30g2p4jh0v
 vhcp9WoQwWIiNqUvv6VrnEwnS6W907r54AegBmvPbl2uICpslqRhvMi2nqm5vzsxpIVlA/wzesv
 hm5mV1+sBtsA6lLL9LZGsnR5YAsJ2rPJXvp01Bmp4UBbXKeSe8D+FrYBmmv52c9K+9fvr9ffwu1
 JfstYSj4080CIrYxPfFklTyhPJ3trwE7JCSRTykP/VSqumNkl6iNWfHm71hGAidisy35+nMY6/o
 /PM15aKMEdH9yzamm+MoLn+lLLn3wx4XtroRVTdF0zXM+EMIoEC9XLopwKhVahOPC62C3wJDxUT
 xvq5H6g34trMMGfVWcRyyP7Uc5oL0ICMQxQtE/Q4dlh0jWZuKyTJNr8FoILgszqqJi4L9zvKp5w
 +R+KP9Uo1K7l/mjSVg==
X-Received: by 2002:a05:600c:5299:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48a77b24d7fmr49690815e9.28.1777382251580; 
 Tue, 28 Apr 2026 06:17:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:11 +0200
Subject: [PATCH v2 4/9] net: Fix alphabetical ordering in drivers/net/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-4-9cf2f0884bd8@baylibre.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
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
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 17:00:38 +0200
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
index ed07e286676..81d6e7cc2b1 100644
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

