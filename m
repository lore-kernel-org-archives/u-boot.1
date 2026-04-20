Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F104F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C6884419;
	Mon, 20 Apr 2026 21:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vzo5k6+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA93E84424; Mon, 20 Apr 2026 21:35:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA9084376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so613022066b.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713747; cv=none;
 d=google.com; s=arc-20240605;
 b=YRSg8dRxHHQVv3XkP/gwVwa7SOLk3FEWyPKVH1DsCeXa0AGmHURFj7YgeVLEvdcewC
 Lr8dFujyazheQ3X6oOs//FHrJn+XbPwpj7kHhyzgwi8PtCSsv46WCT2NtoOIQPq2BJ0n
 ndYWFCiGre/j7CLrJS1pO8icyAIMa0OasS6KXfk/zqy5RvbY30QpK6Zk0NVwPCnOBP82
 lLqFhOGTCWyf1UgTCYjZrLO4Ct9oMaoeqwcw5oeirOolqAMCZauffP6M+8wG0OdVtNuZ
 UhbZY6sfCo/Rnvx2USpfuMjIYtAYhvpScpkLLcXi5lGsWzfSz/TnLLpt5lTLOsNEKWhG
 8Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4NzsEX+OGug1BsAttVPi+0jOCNWugKB9AYjEvvgTo44=;
 fh=S+A4YzKCfD3UjIXSY+6PWjemUPsmCfihjKd3tkBpr6w=;
 b=AbgzB5OugLefS1nVURdtv/v5cWJ89NQlo3zQENSrKujnYYeqCyVvDV3+pgQYSKpP2U
 S0wcX4SB/NlVIXeiiDXpvaX0oNaV9O50C28g02hCeX+nMpdh8uNqVYzKsTCy7PULeNFN
 dVFqUfP6LOJjffX8ZfyTbbvfTgW8GZLDPwWFgo0Ryk0k01RJf2OKW+diQcJM5D3Xzk+6
 Oxvu1IvRkRZRL5IhDbdZn2POn33wKlzGsH54NZfBdl3Rel7n/qJA0wtiGIY/RqqDGouY
 xc6Dts4TFVpLgq406FIxcTA/TrBEU7n35fRKH1ASOLvT6z4/TVBecVxVMpGS1Da5+Ygz
 YLhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713747; x=1777318547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4NzsEX+OGug1BsAttVPi+0jOCNWugKB9AYjEvvgTo44=;
 b=Vzo5k6+aMW+J6xcoxuwAWITM7HV8putRNcI3XjcR78o2SzSMA67VBZ6yTfAvTmk3Fj
 X9uALoszuLKCYY+wY0903sqlf1XkhZXFPTY8hiYDYNlyZyhrOkVPCQuh7A4fbIdlrAbJ
 XdDoS8V6Ew43ZYQFEyJZ321rjOm4+X3d1rwBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713747; x=1777318547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NzsEX+OGug1BsAttVPi+0jOCNWugKB9AYjEvvgTo44=;
 b=hAPgEBWJ8Z4mlXTkadSyqlmXqnqgC3OoPUiOxEnuHgVG9JGi1UFj3nJ2Kn8OF+0yRn
 DU1w4ltnBcwJ9ArRqL1B7d7owwMQs85VyNynfKkK8rt8cTjd5kH+Vl04V3vQ2UDevwHZ
 Dnus1CVzdpa22HuZzdpTkJL+fb5t7toas1PLU4OGGHCQW5OUDKnRk/0QSN99CUSwo3mY
 FHgnDGaliSXp2L6HbEEb9CMOFFqBi63/vWUNT3SDuXNJU6jHD9Iym4cJWzbeS/NfYkj/
 F2AvErLSQinoDbDofDZodYAaA6qFxtd/xYxzEvl/9cgos+4ER3C33KovAILh2e70Yhm3
 8O+g==
X-Gm-Message-State: AOJu0YwRdoJMInJEIfdIfwt/V0jF/aXyrPTHZUVTX403bgZJj6z9GYsK
 McGx4ezCkTBM4TRHSzV8doFgi05LvQPCsNWRSZSIGfrAbyvQKcxuBRlz/e28g4aBxVu7Zukf7iV
 iwrzPyuHoWGi6ltZoW4bvubi0tkJUokJhSrYz/IVAXMIH8PiqRYwhLgN2
X-Gm-Gg: AeBDieslt6RNHvE3C5dBSe7nYl7UtZfXlJHby3FExz5D4bNIAmT8z9xMUWWTXWsq4Jg
 fe6OpzNKgRWscQYRG8bzRoeLHE5kZGNIJkSCjWELGZPYLomB+XmCvcrAlvZtKgWLKrK/feXQYWn
 IYcDMLkY5pobcJhdVR0dgx0hKeuMZUfVlOBHzJ8z/rQbvRyfWa+QJ8aQWb47ro9UZ0vBxTSl8LE
 OBwr6xcowUEFu+dj/lXX8jzUwZ0k5P21sqw+Be4Oiff4Z/uLWBv9kMQxvNotvAFIyVU3b2J0oT5
 FLo1wKtNNCrB9pBqnADffqiXZWXaQj8=
X-Received: by 2002:a17:907:dab:b0:ba9:7898:c0a4 with SMTP id
 a640c23a62f3a-ba97898d65bmr4712266b.21.1776713747008; Mon, 20 Apr 2026
 12:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
 <20260419173541.31592-2-ssrane_b23@ee.vjti.ac.in>
In-Reply-To: <20260419173541.31592-2-ssrane_b23@ee.vjti.ac.in>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:35:33 +1200
X-Gm-Features: AQROBzC8OpZbiOHBqODUzX0Sja9rftcXQPSRe3ksWsUlw9iIe2G3FrSnYDDGp-c
Message-ID: <CAFLszTg0=-MWLCCPKok1N3hGEasNKrzXBjE2oQdSVGjtzCXFkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] video: bridge: add ITE IT66121 DPI-to-HDMI bridge
 driver
To: ssrane_b23@ee.vjti.ac.in
Cc: u-boot@lists.denx.de, jd@denx.de, tl@denx.de, trini@konsulko.com, 
 sjg@chromium.org
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

Hi Shaurya,

On 2026-04-19T17:35:38, Shaurya Rane <ssrane_b23@ee.vjti.ac.in> wrote:
> video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
>
> Add support for the ITE IT66121 DPI-to-HDMI bridge chip. The IT66121
> converts parallel RGB/DPI video input to HDMI output. It is found on
> boards like the BeaglePlay where the TI AM625 SoC's DPI output is
> routed to an HDMI connector through this chip.
>
> The driver is based on the IT66121 Programmer Guide and the Linux
> kernel driver drivers/gpu/drm/bridge/ite-it66121.c.
>
> Tested on BeaglePlay hardware with HDMI output via TI TIDSS.
>
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> drivers/video/bridge/Kconfig   |  10 +
>  drivers/video/bridge/Makefile  |   1 +
>  drivers/video/bridge/it66121.c | 580 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 591 insertions(+)

> diff --git a/drivers/video/bridge/it66121.c b/drivers/video/bridge/it66121.c
> @@ -0,0 +1,580 @@
> +     ret = it66121_reg_set(dev, IT66121_AFE_DRV_REG, BIT(5), 0);
> +     if (ret)
> +             return ret;
> +
> +     ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, BIT(6) | BIT(2), 0);
> +     if (ret)
> +             return ret;
> +
> +     ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, BIT(6), 0);
> +     if (ret)
> +             return ret;
> +
> +     ret = it66121_reg_set(dev, IT66121_AFE_DRV_REG, BIT(4), 0);
> +     if (ret)
> +             return ret;
> +
> +     ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, BIT(3), BIT(3));
> +     if (ret)
> +             return ret;
> +
> +     ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, BIT(2), BIT(2));

Thanks for the named defines for the AFE pclk settings. These
remaining bare BIT() constants in it66121_hw_init() could also benefit
from named defines or a comment explaining what they control.

> diff --git a/drivers/video/bridge/it66121.c b/drivers/video/bridge/it66121.c
> @@ -0,0 +1,580 @@
> +static int it66121_attach(struct udevice *dev)
> +{
> +     struct it66121_priv *priv = dev_get_priv(dev);
> +     struct display_timing timing;
> +     unsigned long pclk_khz;
> +     int bpp;

The bpp variable is retrieved from edid_get_timing() but never used.
Please can you either remove it or add a comment explaining why it is
intentionally unused.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
