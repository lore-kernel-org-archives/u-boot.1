Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C7BF8D765
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4290884258;
	Thu, 16 Apr 2026 20:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e3lVgawX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA8E84258; Thu, 16 Apr 2026 20:54:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1AC84214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so194296966b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365676; cv=none;
 d=google.com; s=arc-20240605;
 b=B3oSueBJP2LPgd/c+fmUi2ik0AciuCDr0lSvwKx9nJ0cA5xCM+rwBz/5IY9JXJg8/+
 3Tw0rvbFM+wqAesdYRSuFiesDK2zcBt1AIyUbLsa1sq57rqFl5ydEqrf4Tq9zp/lhsWl
 Y26sH48xOvSS7Z1gXoJqpJA9HE3ou5NT9RiMgsqp2DlVjArX8982E0YKI+4oGBrqtStW
 PpaJm42ZoXViuHUbACIT4lSqhayt65kX/KB4f9CNGjBNPyje6z+n4zec0SLSpp5uixe4
 Ee7pjaAXM1nb5HJXXSoGWuWjhm4P48o2wScV3rHhdXSz/f+BrpDUZdPeM7nHaXwwM/fr
 7eEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O87EEr1dp7ZFbzrcS6pYLvni5bcIMoCny/fPFcxfavU=;
 fh=8LbBtn3iNxQRuEgDTUB0nOZtFTCP6XN1/ZQVKWpSzFo=;
 b=lkRh9uRD/cvR+cgh7DQ8cdbFtrO6B/f8XFFuwNKwYceae7Ou8vZbb7noHFe9pkHHzF
 IJRSF+fompGd6LVGaKRaQVgut0jBPWn34GkVYAQkJ5nobCIvlFcgUxgds8J690FyL1Nj
 J9Upm8TbXNAzRCPMvQ3ZxWMxdF9nomUKuyi17SJzljaLNp82muZIkwbjEwwK4tBorSSY
 6rvV8RA+GLUMKyzfe4yFHsCkviWCoPxUFT01gdRAlv7ZmXMk+VUU4DF5xYteXv9QRu8H
 SB4o/7kFRivNt3NuMlNeWjLYsImlo/VGCbM9y2LQYbiftbAPXq56cegk/0QeN77h/cvL
 dRYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776365676; x=1776970476; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O87EEr1dp7ZFbzrcS6pYLvni5bcIMoCny/fPFcxfavU=;
 b=e3lVgawX41DyhaNYHZXuIJ9bnkVYoVT2S3VK89+cX9kmkBnAq6Drv1ASDOW/2sc5/t
 FnqR3jA99tH2XQGgH11fGtv8JMGIMfpAPgJaCH7+FnOzx06aSxLuxKsmOcLPVoPApwFp
 6DOGIsbuCDEsGAgpCt0za4Edu0oT6Bm2yRcO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365676; x=1776970476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O87EEr1dp7ZFbzrcS6pYLvni5bcIMoCny/fPFcxfavU=;
 b=OV1f7UCqqe2QHUkeJ/T7OFGGuUeg///kOEBwnIi+QX0I7owYK+x8q2Hfexq67pR2vY
 XCnfbNgWVEox4VNOzrJRqtDabhi02x+YIbvxf63pfVb8yXRNt7xhVv9kTObYpoFaQK1T
 ahWnzjvfrn9OpVYbMoRIcz37GqBPSiNxU1fCBKo71QW1qB8sC6xNhWp84RZVqEnWN+l7
 gSIEj3WReUWKkI6navY/qQQNB1WuRwQJJi1QpLP4EuORgMf99uON06XTlGJa1BuSspI5
 2MlSWqCcwDfZB0cyb3MZWeY+ZkBahdpw/PmkHNqcYk6Su/exImwi3SEscfbF8N/jCD5P
 We5w==
X-Gm-Message-State: AOJu0YwcfyFoFZIf4gQs5G4gXu7TYxK8FwjG/aBDWNtswwLA4ZsD2AyB
 wDXrxZVRHhxaASmbFkTD6IQ5C89/5qp9FGS7pg70NMPs3kDTOADj9m2m/vn4rex6Jsz/rJqhxYs
 3CJspRf/RbbBWVXq8fSosUZ2TY134IY1Dy1Yy5vOUVglYmQ+t2UChgg==
X-Gm-Gg: AeBDievpwc4lKO5+Wpv1900DXkBH/235rb2Y/C+eYW7yQ9i0/s5bU3gW7htj3pZLVuw
 AQ6lXzuEjORd+Z6ekV2vwcisIxjA/Pw55w0SmkX/uZPh/VBLcUWJipkdKQHJsurkrxYUQUQmrJE
 aZDAMYyzvovs+/MrGiM0ty2zWnIdFBPOzxaydLqNZjLMXULnm23FXjADMDeEljwCw2NWfC377sv
 4iW6o78fpxo4nwQRRMUU9XAvVFhw8EdV8NUXDSK5/TfFJWnH/7vUD60NY6NeyPEfIH658sstmNR
 0+dGiGdYjYd/VPqFJhw8
X-Received: by 2002:a17:907:1b08:b0:b88:51cb:fd65 with SMTP id
 a640c23a62f3a-ba3e3503c36mr23927966b.3.1776365676409; Thu, 16 Apr 2026
 11:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260415190321.120706-1-ssrane_b23@ee.vjti.ac.in>
In-Reply-To: <20260415190321.120706-1-ssrane_b23@ee.vjti.ac.in>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:54:23 +1200
X-Gm-Features: AQROBzAnfaDAuM8pVeJqFdVQBlK9DU4qD2jjlCP7li_dbrweKBh-RQUUZsPA9-M
Message-ID: <CAFLszTi-s_XZgoFN4avxDn2sjo8MPGyLmC=stLC1ZGbsgkWOng@mail.gmail.com>
Subject: Re: [PATCH] video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
To: ssrane_b23@ee.vjti.ac.in
Cc: u-boot@lists.denx.de, jd@denx.de, tl@denx.de, trini@konsulko.com
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

On 2026-04-15T19:03:21, Shaurya Rane <ssrane_b23@ee.vjti.ac.in> wrote:
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
>  drivers/video/bridge/it66121.c | 535 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+)

General note: please use lower-case hex consistently.

> diff --git a/drivers/video/bridge/it66121.c b/drivers/video/bridge/it66121.c
> @@ -0,0 +1,535 @@
> +#include <dm.h>
> +#include <i2c.h>
> +#include <edid.h>
> +#include <log.h>

Does this need linux/bitops.h for the BIT() macro?

> +static int it66121_setup_afe(struct udevice *dev, unsigned long pclk_khz)
> +{
> +     int ret;
> +
> +     ret = it66121_reg_write(dev, IT66121_AFE_DRV_REG, IT66121_AFE_DRV_RST);
> +     if (ret)
> +             return ret;
> +
> +     if (pclk_khz > 80000) {
> +             ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, 0x90, 0x80);
> +             if (ret)
> +                     return ret;
> +             ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, 0x89, 0x80);
> +             if (ret)
> +                     return ret;
> +             ret = it66121_reg_set(dev, IT66121_AFE_XP_EC1, 0x10, 0x00);

Please can you add named defines for these bit fields (0x90, 0x89,
0x80, 0x10, 0x09, etc.) so it is clear what each AFE setting does. A
brief comment referencing the programming guide section would also
help.

> +     /* Preferred DTD pixel clock: bytes 54-55, units of 10 kHz. */
> +     pclk_khz = ((unsigned long)priv->edid[55] << 8 |
> +                  priv->edid[54]) * 10;

Please can you use EDID_DETAILED_TIMING_PIXEL_CLOCK() from edid.h (or
edid_get_timing()) rather than open-coding the EDID parsing.

> +static int it66121_attach(struct udevice *dev)
> +{
> +     struct it66121_priv *priv = dev_get_priv(dev);
> +     unsigned long pclk_khz;
> +     u8 status;
> +     int ret;
> +
> +     ret = video_bridge_set_active(dev, true);
> +     if (ret) {
> +             debug("IT66121: set_active failed: %d\n", ret);
> +             return ret;
> +     }

Just to check: video_bridge_set_active() returns 0 if the GPIOs are
not specified in DT. If BeaglePlay does not define reset-gpios, this
returns 0 but does not reset the chip. Is this intentional?

> +     if (pclk_khz > 0) {
> +             debug("IT66121: configuring video for %lu kHz pclk\n",
> +                   pclk_khz);
> +             ret = it66121_setup_video(dev, pclk_khz);
> +             if (ret)
> +                     debug("IT66121: setup_video failed: %d\n", ret);
> +     }
> +
> +     return 0;

If it66121_setup_video() fails you log it but return 0. Should this
return ret instead? If the failure is intentionally non-fatal, please
add a comment.

Regards,
Simon
