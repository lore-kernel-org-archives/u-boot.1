Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F901FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6BA846EA;
	Wed, 29 Apr 2026 00:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xbZz7cXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB6484698; Tue, 28 Apr 2026 23:27:14 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207B684682
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-463f00cda04so6354233b6e.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777411631; x=1778016431;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oTZu0Opk5gTGI/Wtze70l4B1HMihigLLpD/Z8QoU28=;
 b=xbZz7cXT8KTRKGv6r79E2Z0WvB+Ew5Pt+4Qhu3lZINrw7XEywnah2UQHaydirQBLkJ
 sTgEhWKgkrWq5Md8rK6WjOiSqu5CpVDcLtSrMdZOH3c8n3i39Ww321gO5unE8A8CzHuI
 EX9RJBIcQ+NaVHI3Lz1TTO7zE19GSk599cPAGyAJnZcBJcIJIfvKeGYpHstplThv67I2
 TKwFzeE2Y4EIbvbcVX6oK/Pmy0IfflSvQ5ZGQpdWjku2IVdPmZfoIf1KQzDw24Zwp3zE
 96EAlJBXrHKxm1W4fvwsjITHNN8J7HyrwKZFZdYl+dM007q2bnosHYu+RVoNE67DQciJ
 5yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777411631; x=1778016431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9oTZu0Opk5gTGI/Wtze70l4B1HMihigLLpD/Z8QoU28=;
 b=OH2xiiJHlvP0TM3VfcqdtYSaJEtKdscWWi6OU+GV7LfRTAxj7itspOx5JG/rOA1lhe
 l6BZcPas4oIYglEQzt3XeME84NKKNlWogWuNf/JRUPMylzzgXIy/Du83CLAtyr5NkoZi
 rmiwKr3Avy43Xi4Y5uIbFfcyyXBrmyIrOJArBACkIXcyPcRDwdb/vwzOgg2Jo9BaVv9e
 I+SMQJ64LevzRdfteADwVKKGTZVJkq1sbeoMfzsQ3DLnu2pyxgYtrOZhA8pMeTSKlWql
 temWeElvPpqF2g3IsBgH5hVMexR22HdWBYsUXhy9o7Yk5v8shcZSXVwMuWyxec1W7PZy
 Nflg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zUU5BEt9UKLEiPIvvANHucLko5V48ZSgErx6vPcA37/wdZ0srwpIP5Ixc9tGjim5ysLmjSPw=@lists.denx.de
X-Gm-Message-State: AOJu0YyFWqdCDp6NHoEKuqZ6ddL/iQf5rf2H7F6uIA4p/QHr8fxI+G9y
 qbJXTF0G1YMhXT457ZMppjuNTE/gY20sU+rusJEVY99CRcdv19ug6sH29vPeSpch1uw=
X-Gm-Gg: AeBDiesdthf9Recztcvj9Oq5plvk+8NQ3X0zrUSDAKadokX/1m8oiUahwrkApjkCiZS
 vYswcspJwp+yoQEjx4cufCyrF2HPC4IIQI5XTZ5jPS7Xl0MJt+uXfXdWlhSrgOK20En/37FFXJM
 0GZtGdBYyMskL2aHbgfg7FM4fY8T9I1I87ob9qJ150qngAcE93JgjaM0XzQ/wt3ctGj0GaQT/qz
 GI8koRM6lAB/RIS9/iMuq1hzLnghA23ZR5eYNskt8HpunvgdcvOvkennXMbvL9qoippwm9K2gMt
 47kcWOZNwRl71Lnb+W5zA391XUm5i6QCnA2HDsw0VQtkLbcNAgFLAkDZSqmAPg27NgO1DPfePCg
 RB9QQQO/CXbbDdiFvMRP44mSTrutYi9U4hFQX2UmFVuBLuuP/5XA4TqYoccZvOcUWfZPAX7aage
 smIHu52smGtHQu0azzUQ6Qn2JGhjkrDFsGstFRPygZ8bqy2GNDq3ChNm7MrB9ZFmGpxVI0OsicF
 c7Ac+2Q2II+
X-Received: by 2002:a05:6808:4f11:b0:46a:72dc:28c9 with SMTP id
 5614622812f47-47c3d973dc4mr724958b6e.15.1777411630782; 
 Tue, 28 Apr 2026 14:27:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43a43f6esm7370b6e.10.2026.04.28.14.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 14:27:10 -0700 (PDT)
Message-ID: <c4bd7a22-dc02-4a00-9d7b-36a6ee694eee@baylibre.com>
Date: Tue, 28 Apr 2026 16:27:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] configs: mt8189: Enable ethernet support
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
 <20260428-add-ethernet-support-for-genio-520-720-v2-9-9cf2f0884bd8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-9-9cf2f0884bd8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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

On 4/28/26 8:17 AM, Julien Stephan wrote:
> Enable configs needed to support ethernet on MT8189-based boards.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  configs/mt8189.config | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index 55c2ccfc01f..8bb25863687 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -22,6 +22,11 @@ CONFIG_CLK=y
>  # CONFIG_MMC_QUIRKS is not set
>  CONFIG_MMC_HS200_SUPPORT=y
>  CONFIG_MMC_MTK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_MTK=y
> +CONFIG_PHY_AIROHA=y
> +CONFIG_PHY_AIROHA_AN8801=y
> +CONFIG_PHY_ETHERNET_ID=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
>  CONFIG_PINCTRL_MT8189=y
> 

This does not apply cleanly. Conflicts with USB and very recent
SPI flash changes.
