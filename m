Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC43C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808BD84B2B;
	Thu,  9 Jul 2026 03:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="nr8gNyuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F4C84A3A; Wed,  8 Jul 2026 23:22:21 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7255884A1F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 23:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-497d3e4460aso363454b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783545738; x=1784150538; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JaUUjoAghyH6Fr1Rkcn9lywIuMB2fOj4UkdEP+2MgFU=;
 b=nr8gNyuSymvaOHy9aG4OMuvRswuyMd2n1VuTn2sZOyjZ5jh6ouofKGliAB3fudtjCq
 Rr+CITxmm8xMg0W4lU0XcXTXaFepinZuECQa6Q5Dpue3TbOISypnTTVFDujir7kqOkYg
 GnGL+1u2IRWcqdZzIpKKVuOQjKuRCgt/hIYRwhxaWQlqrUyH9mVYH/OHDfai/C2rWlat
 uhh/11uSZQc++IcoJ8hw0dAEClPTgslxw+WK3n3+GlHTTJCqEIWj1oqbCygqDE4iJJeg
 lGva8YeF3uFxw3o1Xr+tzVc/uOTNnk9OGXbvrTTvOjjXRabF0mWCB29TMUh7L+nuhLqQ
 O4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783545738; x=1784150538;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JaUUjoAghyH6Fr1Rkcn9lywIuMB2fOj4UkdEP+2MgFU=;
 b=oBv3UKt/WXGn4FtxxZkrJXzks5Yx10y0QkU/YTAFVQy+f5iDpKkfhA/1ZQcyNjyFys
 SciEaXFTFZCM5nDGLX+zv7riSF1u7cAOJc8iVlGkyKD2szSZy7dMWcL/8xiBa7iTUYgz
 YEfP0yNqqiNoeTbFgl3vYl7hyz7TC7TNJ3nNXCe34xHRh7ETxOQM5Ivm+Wcc23Jh+j/P
 rHjmfiPpAvgBpaZsiKtKWXgIBctCi1CqSSVdZaaDVEW+qyg3WS1jkr/2kJfz4wJadeik
 SM8A+LtVoLti/DSia6M6RZUTQ83LU6tqAqvr7HHOQoGjQPrvbj9+8W0fRppkjlWWMYc4
 8geA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lbez4BygkLtUIn4xVeI2PQgD3PTvUXg0bR43a+FiQ2p/r+/1Tw4MGuNQSAYplGhlRFARSxFs=@lists.denx.de
X-Gm-Message-State: AOJu0YxGSRBH4k07jK6xlPwNm09fgUOLzEVIkqyQ0GWI8NU5bebJcN0r
 eObSp8k+MN3l28KCeEs053wJQXRs8gyrC1U+4LkLNH27MXxzJgv/B0TrV5InViWHafw=
X-Gm-Gg: AfdE7cmIFo9l/f5RtyR1lQKOHRpSFutB6jFQ27kY/aZyTZtxtS8EEj1hs3LM+c/FRqk
 uny4jWEamWhm8GWbeBL/PBqCSpu4ZjxjTQqSItbUewyOwQ+6M4CSkjHRD48NWltiWWF1+B+su0z
 Oz+LMiYcHLDcE2ogjKKOotjFSK2WgW8zVphUcUtLDg8d7bfDhz0ILes1vvDGPKdDfCaMfhq0esD
 +sqPOAfKNnxvTkF96/gDIhwftlHDuvRHBQa+pjzsHKBmtkmwJABR2OtYK7qQu8QOEHu/HdFv4K9
 4LytwHKqBy0FVk6tFoIE789kWbqQY0wQFF9FVnVk0TuVXX7JBNsKTjNyJ7Ob75QYrNroOrtKTiY
 qBIj1jidlr4V+/j3XLh2hoUOPP+OfA5iBprPHalE+MPDM1cnUBhZbaf0xRIgXXc5ZWx/Oy8LIG2
 5opDDY8GVA0PfhO/iEKOy/THIq0Owu3PLOOGBtLVVI5zYvm5qseYWQBRWds2StYwrv+KeBuVUyV
 A==
X-Received: by 2002:a05:6808:178d:b0:491:3c9a:c486 with SMTP id
 5614622812f47-4a07a953d54mr6836961b6e.27.1783545738111; 
 Wed, 08 Jul 2026 14:22:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1adca6bedsm2557304b6e.8.2026.07.08.14.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 14:22:16 -0700 (PDT)
Message-ID: <dd017493-cd35-4358-8f1a-500b7c303770@baylibre.com>
Date: Wed, 8 Jul 2026 16:22:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] power: domain: mediatek: refactor driver and add
 MT8188 support
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, Sam Shih
 <sam.shih@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:32 +0200
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

On 7/8/26 8:07 AM, Julien Stephan wrote:
> This series adds power domain support for the MediaTek MT8188 SoC, used
> by the Genio 510 (mt8370) and Genio 700 (mt8390) EVKs.
> 

...

> The new files added by this series are not listed in MAINTAINERS: they
> will be covered by the pending "MAINTAINERS: Replace Mediatek with N:"
> patch from Marek [2].

Are we still going to need drivers/power/domain/mt*.c for the new
files in "power: domain: mediatek: split into per-SoC drivers"?

> 
> [2]: https://lore.kernel.org/all/20260617024105.152655-1-marek.vasut%2Brenesas@mailbox.org/
> 
> [1]: https://lore.kernel.org/all/20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com/
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Julien Stephan (12):
>       power: domain: keep Makefile and Kconfig sorted
>       configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
>       power: domain: mediatek: remove enum scp_domain_type
>       power: domain: mediatek: prefix internal identifiers with mtk_
>       power: domain: mediatek: constify scp_domain_data instances
>       power: domain: mediatek: split into per-SoC drivers
>       power: domain: mediatek: wrap domain tables in struct scp_soc_data
>       power: domain: mediatek: rename mtk_power_domain_probe to mtk_scpsys_probe
>       power: domain: mediatek: rename struct mtk_scp_domain to mtk_scpsys
>       power: domain: mediatek: add support for the power-controller model
>       power: domain: mediatek: add MT8188 power domain driver
>       configs: mediatek: enable MT8188 power domain
> 
>  MAINTAINERS                                |   1 +
>  configs/mt7622_rfb_defconfig               |   2 +-
>  configs/mt7623a_unielec_u7623_02_defconfig |   2 +-
>  configs/mt7623n_bpir2_defconfig            |   2 +-
>  configs/mt7629_rfb_defconfig               |   2 +-
>  configs/mt7981_emmc_rfb_defconfig          |   2 -
>  configs/mt7981_rfb_defconfig               |   2 -
>  configs/mt7981_sd_rfb_defconfig            |   2 -
>  configs/mt7986_rfb_defconfig               |   2 -
>  configs/mt7986a_bpir3_emmc_defconfig       |   2 -
>  configs/mt7986a_bpir3_sd_defconfig         |   2 -
>  configs/mt7987_emmc_rfb_defconfig          |   2 -
>  configs/mt7987_rfb_defconfig               |   2 -
>  configs/mt7987_sd_rfb_defconfig            |   2 -
>  configs/mt7988_rfb_defconfig               |   2 -
>  configs/mt7988_sd_rfb_defconfig            |   2 -
>  configs/mt8188.config                      |   2 +
>  drivers/power/domain/Kconfig               |  89 ++--
>  drivers/power/domain/Makefile              |  15 +-
>  drivers/power/domain/mt7623-power-domain.c |  85 ++++
>  drivers/power/domain/mt7629-power-domain.c |  60 +++
>  drivers/power/domain/mt8188-power-domain.c | 665 +++++++++++++++++++++++++++++
>  drivers/power/domain/mtk-power-domain.c    | 576 ++++++++++++++-----------
>  drivers/power/domain/mtk-power-domain.h    | 131 ++++++
>  24 files changed, 1352 insertions(+), 302 deletions(-)
> ---
> base-commit: 8101ed2547180109903e9c7a2ecc8e0679c7ec35
> change-id: 20260702-mt8188-add-power-domain-488f0c2daaed
> prerequisite-message-id: 20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com
> prerequisite-patch-id: be920ef2f5c93fb8111072d8fb30411d227a52de
> 
> Best regards,
> --  
> Julien Stephan <jstephan@baylibre.com>
> 

