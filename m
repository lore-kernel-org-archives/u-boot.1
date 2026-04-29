Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26ADFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FBC84872;
	Wed, 29 Apr 2026 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VNHFHOKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47D2847B0; Wed, 29 Apr 2026 11:17:36 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C89D84715
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so88554845e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454253; x=1778059053;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fWhYngX4oKahgqSYcqgqxnr6sDbAxysXYJW0b35SDI8=;
 b=VNHFHOKh9cYDsPawvCDfkm3F93Kl9uCkAhqsOEFRs69+2hD5kfVvCbQjEVoXyyD/L0
 PhyDyRmJRW/EdgTnZxsIU730CYQNTPM3GZydeUP5REcQJNQ5orr56B4XB0lwc2IwRWgd
 v5KVo4Wxs9QD1QKQb+H7Y8Afhx9YDo1BLcKxF016oJ73dqOrUXGYhIOhvijB5PmuQopi
 AjymFPeb8UtET96OHZqnjw9zS77jS2ILPG+UIGxHbf4DKoc0nEuvK6qVJrcswkG/q+fH
 SmTFaNY682JDNr47aQSZFl2DqEkKbq+cXPBCECKBOSWWQX5+ueMixcv+c+BbBzzaCkQ3
 Rj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454253; x=1778059053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fWhYngX4oKahgqSYcqgqxnr6sDbAxysXYJW0b35SDI8=;
 b=ftrDOXZBCRKitnaoiYz9d4zuVJGV7aeJVFLk95zyAEMTAdUJltvMpYePD0r8VG9v+s
 u/l+7Wgn2U+5AOHVNRcmjde1K8Ll9k0KhDTFD6L+2uDzp0v7tD43g68Cl+tGnqaCU1rr
 R7xDbIiCyESSJtP2KTdh2X8EKaEKMwcbLPnQeCcNbbr8la0NgVvbE508cO1wYJey3Bod
 rVEtmUw1JzIPNHb2tlY0Hk1+fNoL90RfYSmTVniOJ3inpTgR5Fmzp1/uTEQKm1R2Z+To
 3QPMih1EGCUAFUoItPsyTElZDe6E0R44PTTeFF5BdegpltJ2t3zXk6YL+ZKKv17Wt44u
 bjlA==
X-Gm-Message-State: AOJu0Yxns+53ES1HA0NZLr5tpYlibkr+iiQ4Y11JwoHfU/DIAEpZmgS8
 ePUbfLyJBdgAaANjtWhVRJ+78UVo8wt9POFrJG7vOy/TN5DqNbhDIMwGJPV/nlXfaVU=
X-Gm-Gg: AeBDieusN+xn4RqtA4maCnz52qEWn8QXolHs+z1v/EyMNPvoeAfeM4VUWmOzO77G6pa
 FCdQ2teaJiTeF+BjpCLNpNdv4V094C0T4LnE7S44m4uCWI0w2jqxuTw7z9D9e8ZVZ8rgl6X0oz/
 eaT+UHLDNeHu6KwVomLtfkQeqxwYHb1EStaxnDD6MgelYoOcQeODVHrpBqjuqdic6FJPC+eboMz
 KIFOBUzgJ4Q7A7GmFnIO7nAkISHcJcQ9um5xTsQOzG+wnWX/p55K8PAcgtgZTG9gq+bOARp22QV
 Cm0ikHT4eUvH2LWoGtXj9xkZb8nhsYjKx6tGw9uGI4MLUnBNkE5c98/iOyG4M/rAt5TPDPVD4ZC
 zlgBaq2PazTWuddMoV+wTXGQ5Hrij8dnPRFSO6jMiXor1+Nu7mmJGFb1pvLPG1C5bMZwaNOsMjw
 Sanv77qDO0Cm8Fw3ABCM2jiltzPqNT9HtpFeTOtudQo/bFkMFCagiyjiK04FVSS1O4+QdizyBM+
 UoJV302MZaQa5bjJjAfZm0gGu1yORCHTw2EbhpVaGi7YUDjK8/puHOFQTZWNWZtWxFErC69H/S3
 b3w+tIzxlhcYP5KR
X-Received: by 2002:a05:600c:a401:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-48a77add991mr80060515e9.5.1777454252502; 
 Wed, 29 Apr 2026 02:17:32 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 11:17:12 +0200
Subject: [PATCH v3 4/9] net: Fix alphabetical ordering in drivers/net/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-4-1f65e18d4f54@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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

