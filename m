Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006CEC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833EA84A63;
	Wed,  8 Jul 2026 19:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Q2wRr5Fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A469849F6; Wed,  8 Jul 2026 15:07:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F0784A04
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so580147f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516059; x=1784120859; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FRN6ZVt1VbqnQo6FTJcJAFgDeQFfWM2FOpxwD5VJyyE=;
 b=Q2wRr5FyJXwL9MlHbpmA/m5qjtUo/rF6Yh1HdtxWVBjTn3PjoGpz+Pb8nX38MeoEh9
 HI1GAYsae26X+kDm3CCvdDzWcY8O2Kt1d7hLm/B/ci8SOD8/aegV9o/MuON6bbys48zN
 DIE6MrStpavnvz1G86TIb5gzl4LfcQOeZ0+BaO3NwKwU4HdcAGHeII0dHNwY9w0qG3Ib
 I/1bkGvV2C5eM2bSg5kT2/RJ8DiZrNW5KS+AXQ6T1aomS68QDhIFYybDKRGWUv2XG/uW
 /U+AvHmBo9k03ON+IOsCRpCjkThrQIFvPiViMrWeBYgNqDusUz68HcEBOPQ8ZSLyka0R
 NVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516059; x=1784120859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FRN6ZVt1VbqnQo6FTJcJAFgDeQFfWM2FOpxwD5VJyyE=;
 b=ovK/vQbpnrwbMS2OFJ3jaWjHSbWjL2k+wfdq51L/CpYAfX2WHvhN//azKJEtFg2eiZ
 btmjV1boVRA2heEpF+6BAUrKwgUCIpjWCXnRUSTnX6qDidflESKb4t2qEUoUIAzhHPPR
 0zinM2g2Q4mzNnphBhp3Epf+CZEIvJyd/HZ+e0rrHDXm6gTrYdocYy9rhr6kDw9NUiFr
 K68Mb+rQufCUmEC8B74gdxkqfVrqskhnyoTBg6GnRZI72UBUaiigTa0G/G+rE7xIsFXW
 gzHD1OIs3iBsW9TXS5E5jSAqQB5fBYzLy3HcW2fVIdwYpQYrZyeGO84uV/DE1/iykTPw
 FfdA==
X-Gm-Message-State: AOJu0Yw15F8xd1zw/YiKbksYH/u1crzD9JN4Pj1/J/NjBFQ1pSSWFWVL
 rKqLF0+97z//dCiAQ2zV3UK4Ze9mdyQ9/FjHuX7ZrrhZjPosykMMPDnYiVpH4WSId44=
X-Gm-Gg: AfdE7cmu8J8uavdJ7zH4b91MNo1E88oatdMHOX3/ICfRY7eOl90do7IMuwndWibVC7b
 GOJdK7lK3zHWSdriCoEFf+cZQ7KYPlfI/fIjQGBi79fxNUH9UpmcN2Cp3Vh9eZTSxqWfgVM5j9K
 29hEVonmZb9PxfFd5V6fu84KGh4KUGXkCNjk6bmarLQbdUL2wmzKz4us6qDMiZelv6X5M5az60m
 JJu0MScxq9xHlkKs0tEqDC3OxLqgHFzhhO0otLIQ7l1c+9qcDiwRsg/W33g7dYeK1c+5jRlGPpp
 frBz1qaPsxWCb/4B3S31Xy3oE2oZm7AR2by0hxq9y21RqYRAxMSHMkKD0XsbNmxjWUt1D8MR4ZM
 7eMfcrO5aQXf0ttG74jlWvzVifrmmKOgf8gBJ5cBIf5mz8tu5A98x2M08W6Aah/gUX2HPVFGY88
 +G2QnliJb/OcD17k4a8McafExr4Ms8wPzeF6N1RePJ9qqty1agzB/E1zi4orc4bY4KGWfq7yVwa
 yS860OJSMqsMNmcBV2D8T+AhgLJKvRi6gWj2KwDHLowzNwRMEhrTynSNHnA1O2xb1Ngj98=
X-Received: by 2002:a5d:5d10:0:b0:475:f0d1:eb6d with SMTP id
 ffacd0b85a97d-47df07d2d32mr3022057f8f.58.1783516059119; 
 Wed, 08 Jul 2026 06:07:39 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:18 +0200
Subject: [PATCH 12/12] configs: mediatek: enable MT8188 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-12-0e930b4f714e@baylibre.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

Enable the MT8188 power domain driver.

CONFIG_POWER_DOMAIN is required as CONFIG_MT8188_POWER_DOMAIN depends
on it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index ece4e60f1ee..29e2b3db878 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -19,6 +19,8 @@ CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8188=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y

-- 
2.54.0

