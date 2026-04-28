Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FEAFF8874
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74EAE8466D;
	Tue, 28 Apr 2026 17:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BOTSoMMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43BFC84119; Tue, 28 Apr 2026 15:17:47 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8924484150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so6103538f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382264; x=1777987064;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3RweLXD/ZJiCygc4L/BhMPJCrBSq4SODmjOB3plrdz8=;
 b=BOTSoMMaAmMJeItHePh5Klre33dGpmLRAjIhvlxDeiLX7lKXTGBj18+AiadKVLgu1L
 yzy5TEx49IZ0nVzwzM+NK1qTtRqOHd22TRgQ2Ik3PozRnLdPdqveyyLwvu9IxvZhKp03
 IxdVMJJ/P5OEnbfaV6p39GONP9ZTGAmrebtZWrAQUEPoaLOXEgmQRxtM2gDIaYSY0QxD
 uVHs+h3LACigZAnGcFz/n3tPvlEEv8t5W2edhtb4TSmA/x2f6cnkOv3Ugl0WmAtwSwY7
 2k+JvQXg/37dcZ3Ipooatpy0Vssb4nKg3T60Vm0m1wuBDz0gtU8V/J6KptPLQHPT3Aks
 zXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382264; x=1777987064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3RweLXD/ZJiCygc4L/BhMPJCrBSq4SODmjOB3plrdz8=;
 b=rjqTHetYszmdtuBotrwMsQVkNqyKRHy7slUFZMNHxzluKVxRU7ffXkL+qTzflgqpk6
 osP/dZY1AXe8mqvauCucvOziGLam68zmC/e10zZqdjanYptqzux1jBkm21079sT8d8fV
 muoP94AmkDg6mDcgyuMuW/RJVpQCW2EW3BMxpECsC0v8gol8B2pxesHIc+USbDH60TPS
 q5wTymImwhSrV0Bzf50KNjPEFQTtdYPs3+wx2v2mD2r+JxqdD4gEOHii0ApBat3aZOD3
 4wA+rrUzhqyRubpAd191sEgxfNF4WaJNkpVec2pMZxVMnsRjW7Eo82EXutwX2dpydCm2
 /l5g==
X-Gm-Message-State: AOJu0YxUZUOVytS28YZdWcE9IDT7vF3ns4Sc/TQ2g3VZfzSi3YAmreW6
 Xgm+lZPi/HTNrZJpMZedomlQ87OpeqI5IGLnZuDeXWKrexqKIYaYvvAfheBY5/U4Vwg=
X-Gm-Gg: AeBDietXAL16TZlH+mooAWFib63GNOGcJLcKHv1Z5LkIHVDjU6QhpuKX4oBoRzXPqvT
 YsnDV5uqos1eAObg5wraylj2Su0BJqBOTkBBomtRKPP45xWBJtp1s5begIOW9FxkiBA1Ikz71mJ
 ZRSBOD7JHNQBQHELQbOamvuKsIUsNponiKNXxVHah+szxDU3/KeQXRygY/6U1ycKShFT40aObCZ
 R4YXCroVpXKzXhifdu2HSu1fWZFQYomqpZUg7vf2OGOWiWLWHlufMiBJXcS/TUrTAre6I80MrJi
 ZyK6tE1DY3cCX4Y827KN+NFxAS/RyTRLPaQFvOiUPjSHtZb5mM3n1VDFnYKTgJPpBbxY+AoOWrx
 b0GLbpdLTvSb/it8XWsIzZ4WoaERU0JFkqVL81szQAyhp9d+WnoKT3Ef1AevqxsAcrnUD0c5K+X
 yn2JIXGVrvgwS0W8BttkZoRM1wDLDiLTzbxWzAOuUG4H4dyaiXFytlYA8Lrd6lcBXQsPpIV8e/Q
 mOdV0uhFRETjVV/28cOqCJf82cyLZJDhDNvM8rRYDdgMxA9xFvKrfQPx9EqVEl8+y0FJtj3I4MI
 bh2vrRhvS+pFrLdIPQ==
X-Received: by 2002:a05:6000:26cd:b0:43d:1c39:593c with SMTP id
 ffacd0b85a97d-446496d7a54mr5837477f8f.30.1777382263821; 
 Tue, 28 Apr 2026 06:17:43 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:16 +0200
Subject: [PATCH v2 9/9] configs: mt8189: Enable ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-9-9cf2f0884bd8@baylibre.com>
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

Enable configs needed to support ethernet on MT8189-based boards.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8189.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 55c2ccfc01f..8bb25863687 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -22,6 +22,11 @@ CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8189=y

-- 
2.52.0

