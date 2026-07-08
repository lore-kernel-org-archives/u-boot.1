Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67CDC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F4684AB5;
	Thu,  9 Jul 2026 03:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RV1psqaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A7D84A3A; Wed,  8 Jul 2026 23:00:29 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0516884A1F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 23:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso447854a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783544425; x=1784149225; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1ao76+VOR8x9gfJ0dhYJuiIPfHv9IFRKEeLTXoWOlvk=;
 b=RV1psqaA5FeltKS0YU1IOkbEa6QP5ynb3zSnhwzjiSd8VY4D629ll3S9nWCKqKFTHT
 cLh2Rx+PpLHWuuEaYbhDpkEieJUzNR1VJLvbpRdq2P24PK3DQ4e4KVfHo53m3oGqVvFj
 2f0jB2q8RHlcrYEshLIWuGWjwtW/o3BV5MV2d5JdfrgUwwMCt/aqwEKsD1M16JxqLtPS
 7hSxaYv+P99PHi1HVYWh0bgzA/z8NdkB0sAT6roB09lt0t6+FoTw7Ffnn3MlBO6uWqaZ
 QYb6QyJJZI2sp5B+vDT9YUhP0RlYEmceLToj05ag+Ab8MP3Hz01JvrvnQfbjUNUpMUxd
 uXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783544426; x=1784149226;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ao76+VOR8x9gfJ0dhYJuiIPfHv9IFRKEeLTXoWOlvk=;
 b=bdinbDC7ZLIlpy4xtsNQ9iXWMp7+A4v9fDyVxf4gIBi51C6IQ5562y/qUdVFBBud3n
 canfaEFJqQvgzVmtpNe1yiKFjZtvHrvRZ6U4EY2gKc7tcOZ4ln+QSXzPcWD8ShjcY4c/
 wOjH76hPPo4Rj9MWmjKIUiTB20weuBDEuDMqTEjErd2jvGQjvyHix1x5BjWKHKNyXtwd
 wp7PoGnfW77DtC/DMeNF8plAssBqGmrR16HTlMTb9iO62ExJyPD48QNAjRGwK1TK7hq6
 X/59PI/7lGog8nernhD78gnLu4tl8iiGyUcjsuIUpveasSAZuMJ7Zl96nLECWwMFivpV
 hffg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96BM67w0YWyzTYq8+JDQG39dACZhmRPuQnxRckej17eA97NYzzG/9Uw0CAIEKBMQUe78rdbIM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1SKf4n9gXiwVfA+4Ev8pxN21TJrlbzYpSrF4QY16Q0MvB4fYB
 GWVsT43ICcvY+/a1EVSORUh7VYm2aYuwDRPHmlNmBjRdniBTNK112d8jToI3k/CZU7o=
X-Gm-Gg: AfdE7cmFfYPylDlZDe5fYhLie7UCmSwjJB85CwketQQ9+n/WPWobG4+rvHUf9IG8Cda
 o+Yg9QZAmhz9TGb3x+2+Lk3QpexvDpdQl5QYTyS2B89Gei8lw+IHZKvKq3YaAfjRd8cZjsyB9Jt
 oLurJy9R0PV9G0IqTOsv+jAOq/8w7eFTBbfQFr5BhKbdoNA5gkrfviXWT/7jaE3QpTWtj722Lbl
 Ensdr2ZD/oT647NZMPh1eTZfYmWMhHD91cNygK+3uBP4aytqiVlLb5rD81mr8CBoP4WOL0A1pLS
 OgshFOV6JiogHmjVmimAqCh3dPNrti5PNNB7ZPvy9l+YNbmdOggPNwNhnafdyJsI2CR64Zbn9ak
 fdrgYFtEHqi+3wJM1t9B6u1mBZrwNRBE6GQkWbv16hYbkd6KviM7LSvBNOewNCEgfVzA74JpX89
 BDhBUXlZczdTnLhnB35Y1TtBgQv0i7tvgKansBccd6q60NerOR2EKeEGjvyMuUTy0=
X-Received: by 2002:a05:6830:380c:b0:7e7:45f:ce3c with SMTP id
 46e09a7af769-7ebcfe968damr3067600a34.14.1783544425560; 
 Wed, 08 Jul 2026 14:00:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bc0d0sm2663830a34.19.2026.07.08.14.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 14:00:24 -0700 (PDT)
Message-ID: <1ffc92a4-f6f2-4146-bb58-d9d763134b13@baylibre.com>
Date: Wed, 8 Jul 2026 16:00:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] power: domain: mediatek: remove enum scp_domain_type
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
 <20260708-mt8188-add-power-domain-v1-3-0e930b4f714e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-3-0e930b4f714e@baylibre.com>
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
> The driver mapped each compatible to an enum scp_domain_type via the
> match data, then used mtk_power_domain_hook() to switch on that enum
> and select the per-SoC domain table. This forces every new SoC to add
> an enum value and a switch case in shared code.
> 
> Store a pointer to the per-SoC table directly in the match data and
> drop the enum, the type field, and mtk_power_domain_hook(). This keeps
> per-SoC information in the match data where it belongs, making it
> possible to later split the SoC-specific tables into standalone drivers.
> 
> No functional change intended.
> 

...

> @@ -379,15 +349,15 @@ static int mtk_power_domain_probe(struct udevice *dev)
>  static const struct udevice_id mtk_power_domain_ids[] = {
>  	{
>  		.compatible = "mediatek,mt7622-scpsys",
> -		.data = SCPSYS_MT7622,
> +		.data = (ulong)&scp_domain_mt7629,
>  	},
>  	{
>  		.compatible = "mediatek,mt7623-scpsys",
> -		.data = SCPSYS_MT7623,
> +		.data = (ulong)&scp_domain_mt7623,
>  	},
>  	{
>  		.compatible = "mediatek,mt7629-scpsys",
> -		.data = SCPSYS_MT7629,
> +		.data = (ulong)&scp_domain_mt7629,
>  	},
>  	{ /* sentinel */ }
>  };
> 

In upstream DT bindings, "mediatek,mt7629-scpsys" has fallback to
"mediatek,mt7622-scpsys" compatible. So scp_domain_mt7629 should really
be named scp_domain_mt7622. And we can drop the last entry with
.compatible = "mediatek,mt7629-scpsys" and just let the fallback
be used.
