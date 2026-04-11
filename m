Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A45F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C62841D5;
	Sat, 11 Apr 2026 16:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YcgAPcVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F6183DC9; Sat, 11 Apr 2026 16:38:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B0D841CD
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9bff57cb62so479049666b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918281; cv=none;
 d=google.com; s=arc-20240605;
 b=i6GkDan6yHC6IFgdyxPji3yn3oZjt8AdTvadblthv/72oVXNLYATOh1fnDKNdz3lh2
 zVSMvtfpOYbD+u44OccTS3ft03YN77D1dF6weCvmqzR/iT5UgmbaLI0PtwwRplNxixsx
 ZLnDlxpplVD2VWGeF6u2v5hxrwtP2KABJ0aCVXHzgsyLLJ6Sgc595qBwuIT5mLiJgvDm
 vbLPtyKzwnplAwUr5BETSPWNURA6BoXWI3wU3M81Hxj6WHpzUnvnEmDdr6zl3S8Z+DOi
 brbJ594apgcfGbZDGVaru0P/1Nozm+GVPMZMInnHSd6Q6xKkQq8xSD6qxLLXhbhku5fo
 BcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/a9fayhV553V3QzcdEj+QGSO5J18oJxAL+mWK3CEC0k=;
 fh=j9vcBxmF5lkzW3x86G/7mzB5H9gldgJrp50Nrb3DWZk=;
 b=AABNGCxRJAXiheokqyEq5JFQJx9AwPqcnLt0h35rDfzkr9Jvj+siHE31BYZgoqCtWr
 P14a0dEm/k4lCOC+Q6SmdROosTPzYUIO7xyFx5FKqoVlKt6vsAdu1CjVxYI9gGfFb75Y
 mc+0v1QGPPDl5C6lgxb/ncoCD1iLDCfGg5s9mKDh3/gnO+5t1UM4hPTtLzwj2v10pFkU
 ASWT20/33Vh/33gnlnj8gPJYF3K7AQG5pDLXi4+2qoagPh2GA/b61OUqiyQzqFbFOFh5
 picnkAciQ72bqWbtecgh2uT1hQr03acTMmlrusUS4zeT2mXX+B7fFJkWNdle5//nH2h4
 6X2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918281; x=1776523081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/a9fayhV553V3QzcdEj+QGSO5J18oJxAL+mWK3CEC0k=;
 b=YcgAPcVbi11q72S9jMK9Gdg/R2soCEy/mq7kBZDzJirBX+8N+lG0ykWF2AwoyxLkef
 v49SbdLtA3iWJDxbmhsoZU/ov9teCZWDV4SyMu+0cxwXfkojRJnJysLGskg8NrU+dx0L
 UmEaa6p8qlp+b6hCt59KkfMc4fsyHZ0MExFcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918281; x=1776523081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/a9fayhV553V3QzcdEj+QGSO5J18oJxAL+mWK3CEC0k=;
 b=erEKf1mkfsMZhjjLN2P7efJsZj7mD5WfYjPJPb7t7tGGwgsxuqmOIovQMdeKdu2KbV
 bszCqr5lNLkF5hNCMHMsoT5lQGvcR1FJsFJr5/y7nSZ6PuJiT57aInoVeWnWPCj2tlY/
 AoKoBznZDFwuR0QMZtBK18LjQr9l40PUGF4vgI0pQ5SNCv9XlM3ieI4EqkRQmhgBc5ce
 AVEB54AEWUQsBeuy84CbsUdcOhaV1zCrwe+8fZmSaOHoRiytGKuAKU6XFHmQeO/b3qZ4
 MIBBqfaz6Byctrp6Yt65hrWHSdAG03tLgyRQksWZTA37A6Jh9ByPnzgE9Nq2iRygDedG
 xXxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAmGGzv/pb5iMA3tuSvdPoj+CGWIM3ZhyHip8PEoqWkV70jR6W2vHZhq4HcxqwV9oOutuQ7Us=@lists.denx.de
X-Gm-Message-State: AOJu0YzgfD3e0RezJhbXBtBQI5txptKHrywP/8thGaGTG14GT8+NXW//
 0cDHPBY5m/6JKtAunJvo30dz4uv5u9Cic2G6tdZ7vztNk5l9PVrVI7FQaQQRh1h6JzGXIdtnKvb
 DUJN1z/SoTFSW6+9k5XcDK4uyRWQ1WVb4E4asj/Da
X-Gm-Gg: AeBDiet4nXlxI26dEwiWmdSg5K3ji75kWw6rt9P63+SVG0R3+D2/4bX2aq/7sg2zx34
 Ft2FDqtk42NoPM6uBXOe0EQoBrb3NmRo3RVrRpmnZRcvos8uwebLUg6/o2QzYBtE/wt+NpV6TXM
 b0CsBI05kFNGEekZaAb0/9jHW3d4m55wWt09ZmHiydv532YxGmJH1HrLyIJUvY2crPUimAScfZ1
 9UZwmNkPlx7G27sFY1HW+kCBQxfqcHxaXKb89kF0uXNoZhpd3ECLxZ1brwegGysU1Ab3C6QlcRV
 ujTuILUZeX4RtKNZ
X-Received: by 2002:a17:907:6ea7:b0:b9d:61c7:2343 with SMTP id
 a640c23a62f3a-b9d724ec21cmr404363366b.10.1775918281510; Sat, 11 Apr 2026
 07:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-3-lucienzx159@gmail.com>
In-Reply-To: <20260405144944.41074-3-lucienzx159@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:37:50 -0600
X-Gm-Features: AQROBzAitiRYbMGWBx2opdM4qIXv9EDevaixEWNFC4eONrkGyWtVMRXa8apIbgs
Message-ID: <CAFLszTiL-j=i0AFyoDc8yKFAxoKzdZms6tqiT_ePohYGaGM-RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
To: lucienzx159@gmail.com
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com, ericwouds@gmail.com, 
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org, 
 ansuelsmth@gmail.com, mkorpershoek@kernel.org, skylake.huang@mediatek.com, 
 lucien.jheng@airoha.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Lucien,

On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:
> net: phy: air_en8811h: use standard rx-polarity/tx-polarity properties
>
> Replace the proprietary airoha,pnswap-rx / airoha,pnswap-tx boolean
> device tree properties with the standard rx-polarity and tx-polarity
> properties defined in phy-common-props.yaml.
>
> Backward compatibility is maintained by reading the legacy boolean
> properties first and passing them as the default_pol argument to
> phy_get_rx/tx_polarity(). If the standard properties are absent the
> legacy values are used transparently, so existing device trees remain
> functional without modification.
>
> Link: https://git.kernel.org/linus/66d8a334b57e64e43810623b3d88f0ce9745270b
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>
> drivers/net/phy/airoha/Kconfig      |  1 +
>  drivers/net/phy/airoha/air_en8811.c | 58 ++++++++++++++++++++++++++++---------
>  2 files changed, 45 insertions(+), 14 deletions(-)

> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
> @@ -1046,6 +1047,47 @@ static int air_leds_init(...)
> +     ret = phy_get_rx_polarity(node,
> +                               phy_interface_strings[phydev->interface],

Should you use phy_string_for_interface() here instead of directly indexing?

> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
> @@ -1046,6 +1047,47 @@ static int air_leds_init(...)
> +     ret = phy_get_tx_polarity(node,
> +                               phy_interface_strings[phydev->interface],

Same here.

Regards,
Simon
