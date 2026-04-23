Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D223EFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FC7844C7;
	Sat, 25 Apr 2026 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KHcPZq6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7BA84459; Sat, 25 Apr 2026 20:53:37 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6195A84308
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38e7d983f91so92148541fa.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777143214; x=1777748014;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qQEmXp6qXUCvvn116a+QPA/U24ZJCdS1jQoE/q4Z+/Y=;
 b=KHcPZq6G9UY0gJs42S+StBkx8yfVEhFZkT/p3Qrx5BWFzfQeNmQJ6qQsVnSMtBitFb
 lE2x4U+7YzvkE5++q0XwpZxQSGhjQ7LMbDRSmKtEwy4YiOnSYOJcLGfHW92diws78G+n
 M7PJjXHxf3FTc2EUBgH1guIeJD5HMvyWM0ySLuTH7Wtnb9ZcYVDnKjg0jj51Oo0O4P65
 uPNTLLCPoTOORt8j65PzTVrwlVTXjGe/Xk6EbeY+KOd9aj+1laPxpG37497hLwnIOMQ7
 yIEkNqeEQYTUHEbLIogwTHU2dzppRmn/k5LSLPvFTPwB+kPGypwMGAXPvwdJawq5wYhd
 DVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777143214; x=1777748014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qQEmXp6qXUCvvn116a+QPA/U24ZJCdS1jQoE/q4Z+/Y=;
 b=gnLEpcYh/ML8zyzRXMy7H5KqlJ8jCgXGFKp5lmKLbtRzp73LkwVql1TatXBwmdLwbJ
 /A0bWHOZB0L//YaDm2wqEgosU40H0gPFEQQMhoYD117SrtBhLFYnP99+ffEBsAprLvCu
 eCcYpVHhGr+X5+q2f8SUeQT50pPauOj7EGQ2lfHO+iKOs6HtPj7jVBvmbzpoHHA/AgZ5
 XR+PEdsOR7NNFxUXUat5ja3jsocTHOT0LFAHDW0e8Y2DytkLgB5FtDwzo5zlbPI4cBn5
 HHvA+esDua/PbPBegNAGud9mlKTdYus1pMa5RIHu7NbV6eF/r5E4F6LfeaRUsi1DNawR
 eFWg==
X-Gm-Message-State: AOJu0Yz1pP03S8hndPocTvAVYXX2hzGChftlQuSICI32Lqn7b877/gaR
 M1ERsd8rPYLUeZbqwbozyaU4OgWOnyBrnWUDiBLcAd+opWh2gZSMeRtaKOaiKwa7qW5jLp1UTKN
 Qb4RVQ+w=
X-Gm-Gg: AeBDieuPhbEOoHHlZW4BtMXjiyT5GEh+/QGRZEjnWMLlqion8OMSe5GiwSZQ8gQW1U1
 5duBrYdwXuaS9wvvQUe0ZYGsfNxwkX4TYaGtIyCBx3NdbN213y8VoGWK/xQ/5GFDBEM3dHchE2e
 S+VlyhPu29J74qGe+Zm/TggGks2kt6qdgzEwgZVlD+kBcPGpKwdRdQBN8xDf4GTlYZ2y5BWRDMA
 3AKkzEYdmbFSFyWOgQ5FGN2twOFKl9fqg686T0f4zDLImlIBQ8eHIzmthhYsZaM4DmqaG9pa+UH
 8aaKxGsLcIwPp8VO6j9nDPS6yr9UyrWeabYWbnV7f3DJTes/aYtHkgK/Ju0ZNa30Hld/QBLsCOH
 HxQryErtbFyQlLMZYa6xFGCPyA8gZXvsG0qXmeOxkfQnwEnrOXpPDZGwoYuUj7lgIfGIEyoWJnv
 9aU2+qRc+5sY0E1FkJC83tB7vhQRzpxGJXXpn5aL/L3At/JLKa7Oq75W0Bm1JG3NHbRRMImQPrC
 UsZOYKR77ncwZLNPWQRH1jGsML0rbwPrULTDxBZMhVYi4jeOReQ7hGTywtyLURXk40xb4Ngj0HG
 eG1yl043m5Qc8tZEqw==
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-4891ba85dc1mr225485415e9.21.1776950764584; 
 Thu, 23 Apr 2026 06:26:04 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:26:04 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:55 +0200
Subject: [PATCH 4/9] net: Fix alphabetical ordering in drivers/net/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-4-47ca918e0017@baylibre.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
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
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

