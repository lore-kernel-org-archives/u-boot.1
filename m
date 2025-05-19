Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723BFC3ABD8
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 11:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026CA82AFC;
	Mon, 19 May 2025 13:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="xwbKW3B/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0718781E72; Mon, 19 May 2025 13:33:32 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A10282B0E
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 13:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso129151866b.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747654409; x=1748259209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79nGVIS1PzwNMwuDuru3vasClcuEnvxd2lvVLAnWq5o=;
 b=xwbKW3B/QT+MfTZFvi0a89vraNXZqR/rxnShF4Fn2shtizRg9EDr53CZ6Y6OIOGac5
 ylAttKOC6vGaSM3cUVsXLG68jlUr/qZRFeGPeIMN6M4Gm3TN5Fy7rQVRonqY1Z2Yx2Xd
 gifrqnWtP3JVMMEzO6bC7dfYNUOPmxFk87jgZjTM5dQ1pYjYQAoTGGbkC21KyJlyVeyv
 tW2PZa1dWVeXYeiQCxMyW1MJKdtwkzQ3rKSrQrcvX4VBa1b72Jym9ECDTduPSTMmL1Qi
 XfokgQPKhFjm5RHewmy4aoYhNWcKIVjmrADa+uauPEEX3InrNGEK/RmaSBM6X9p9OAUf
 jnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747654409; x=1748259209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79nGVIS1PzwNMwuDuru3vasClcuEnvxd2lvVLAnWq5o=;
 b=Oqd4xc8Jye5o6CBzsOs36jWoi85xTM4rtPlixp9l8DKfOIcIXzDp+GYOUoWj+e/X4w
 D96pxuuD1r6al0XvbWmRGwJMnA5kfVs9jffkeQ4l1Bs1F8nCPmy7S4Dd0BBw3imAlDGe
 jkafzouzpzMapDBkHMczZ3OJhAIVrISy81uU+K0ZDT7ZXuueqxDiwiyD54h20KWk6820
 Ad3nveLl+rV2NwnseWv5KLwhYTLu37WF+A0OoZ4EVmlNKPj28Pvs9+u8TxpAykTePkY0
 HU+MdDMF9w77Hh08p/PV9gOyi/Hh5a2RSAkaS4CHV+8nrtpMt+gJ3gr07DMK7OuGPooe
 2+9g==
X-Gm-Message-State: AOJu0Yy4ZQfy3IeVBmqG5GR5IxwoAw8RUo7xIXfY1Mt8m/vDUeP6totN
 wzfqwLPTwjdV2V+7Z7e0LE2bJJ9EX2wSEVIqWcj/ryle9vvoX4Pke5505djVYdV9DLxyVImD1wh
 Mpm9byCgZ5JXg6PUUYtVIxxq48PNQsA3fcTY3H/97Kg==
X-Gm-Gg: ASbGnctbwzNEtHEzaLx38vNLUcFoQZ9fzwBl/0dZFMI6UkB8P7uI5C0xOuO5KuZX8YZ
 HbKI2AhDcZSIht155e0W93pFnNDnswjA6HYzHEG8zcbNgWKTFR94hnfFQpkodgFSQwDeH2vDKww
 Y0j8TXZS4fCneYD45pDEUOlRxtyDllepc=
X-Google-Smtp-Source: AGHT+IGxuAiJLoSBUhq35ieUnVvBCZKjec12GjF6fvSmvx69HOK9yL27kdu9vz8doZi7LY3hulMeQvpUna8Ig54AekI=
X-Received: by 2002:a17:906:b750:b0:ad5:3e27:ebc with SMTP id
 a640c23a62f3a-ad53e271fccmr808618066b.57.1747654409475; Mon, 19 May 2025
 04:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
 <3c142aee-f6c2-4313-b743-57d7e7b96d0f@cherry.de>
In-Reply-To: <3c142aee-f6c2-4313-b743-57d7e7b96d0f@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 19 May 2025 13:33:17 +0200
X-Gm-Features: AX0GCFuXrUTWAewU0t4ji_3yjuyidJ2Z_gAMkuya9h4a5iYsWZFUEF6qK6l8gCc
Message-ID: <CABd623tq9fZz32YwOje5+RiZ51y-hp2hjfLG72D5vEHPQCvmGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

pt., 16 maj 2025 o 16:28 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> > Currently the check in usb_onboard_hub_bind is relying on specific
> > compatible string for the Michrochip USB5744. Replace this with
> > more generic approach that will allow to add new types of devices
> > to the of_match table. Because the driver only needs to bind one
> > "half" of the hub, the peer-hub node is used to find out if it
> > was already done. In case peer-hub was bound, -ENODEV is returned.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >   common/usb_onboard_hub.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > index 7fe62b043e6a..9f8c1a304cdf 100644
> > --- a/common/usb_onboard_hub.c
> > +++ b/common/usb_onboard_hub.c
> > @@ -9,6 +9,7 @@
> >
> >   #include <asm/gpio.h>
> >   #include <dm.h>
> > +#include <dm/device.h>
> >   #include <dm/device_compat.h>
> >   #include <i2c.h>
> >   #include <linux/delay.h>
> > @@ -179,8 +180,8 @@ err:
> >   static int usb_onboard_hub_bind(struct udevice *dev)
> >   {
> >       struct ofnode_phandle_args phandle;
> > -     const void *fdt =3D gd->fdt_blob;
> > -     int ret, off;
> > +     struct udevice *peerdev;
> > +     int ret;
> >
> >       ret =3D dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &=
phandle);
> >       if (ret =3D=3D -ENOENT) {
> > @@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *d=
ev)
> >               return ret;
> >       }
> >
> > -     off =3D ofnode_to_offset(phandle.node);
> > -     ret =3D fdt_node_check_compatible(fdt, off, "usb424,5744");
> > -     if (!ret)
> > +     ret =3D device_find_global_by_ofnode(phandle.node, &peerdev);
>
> Wondering if uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node,
> &peerdev) wouldn't be faster/more appropriate here?
>

Thanks for the remark. I'm wondering what are the differences between the
device_find_global_by_ofnode and uclass_find_device_by_ofnode, other than
the additional uclass_id parameter. Knowing that uclass_id is always
UCLASS_USB_HUB it might be good idea indeed to use the
uclass_find_device_by_ofnode that checks only devices within specific uclas=
s.

> Looks good in any case so:
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Just for general information (I assume specifically to Tom since he's
> the maintainer there), I would really appreciate this to be merged
> before we sync the kernel DT with 6.16 (if Heiko manages to squeeze one
> last merge request to Arnd before the cut-off date; or 6.17 failing
> that) otherwise RK3399 Puma will have USB completely broken (I assume we
> could have -u-boot.dtsi hacking the device tree to remove/add nodes to
> keep it as it is today, but better to not do it :) ).
>
> Timeline wise, I assume 2025.10 at the earliest, but maybe 2026.01? It
> depends when 6.16/6.17 will be released and/or if we take -rc1 :)
>
> Cheers,
> Quentin

Best regards,
Lukasz
