Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D3AC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8457584E23;
	Fri, 17 Jul 2026 15:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cp3+wLCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EB984E2E; Fri, 17 Jul 2026 15:45:24 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9294684DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so484661766b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295922; cv=none;
 d=google.com; s=arc-20260327;
 b=EbwRh6l/NvqH6atwtX1h2FMH07/74v98SrfthckwMnK5fUWWroTndv9X3viA24Mx1u
 1gL6edi5JbFbSDZzOpLXHB5dzJXojh1XylELRGhcMjsmp1T2j4ClISCnsivlATfgu0cX
 JXmmdZcFNBalIi6NdI+vdc4R1/ghU9mpWeSIXAqhOFCv6OxHiQ+jbQG1pdI504c+sLHM
 HgvvGIM4c0C7R4nzdt4H3Z1szq2xYg/VWDLww+hNIPG488oTQsQub6x5hE7L/LWdMCvt
 9YwXcmDWvcDjVEnPo6SCRpvnmIhaOHHxu/9LaKCvvJuDaSsLLeDMMsP3L2rTTjyjrxJy
 W5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PuPHGYNuRJJQIE+UG1gWl/EKuW2DzJ4NrR0CRIO6C88=;
 fh=of8ZGfO/quwI3Zl5OAHSMOkElCFSSYQ5UpwsifBviBY=;
 b=d+rytcTuIfc89g81KmBI4k3pfgPD1EPZqDRU3HOMN6U9sXe3cOSxR52VJMg33Uy18p
 Q6rWhV62ZaC9dGKT9uI4tiF27RkURL/AVyqT4WauvGZLnW52zFe2nI3/kGhlsCz4v2xY
 fq5cy6PJhx1yd0S7nCyXBq702ST8nHJ0wUWKX+/sxCq3Yjjr1qZtO3kBagjBi0KV3+28
 kHCrfFP10YNNya40hvoLWUO8qTd/PAVprw1D4szAL1yY/zZQTENxlZImx/XLDj0uSPAA
 jbGhs0KrASreOQpdVVLkICuvg0T0ol6cdDau1pQ3JUSqHmqpEaST4qVNmcRKx3xgC5W6
 717Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295922; x=1784900722; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PuPHGYNuRJJQIE+UG1gWl/EKuW2DzJ4NrR0CRIO6C88=;
 b=Cp3+wLCk9+TP7J3n2MX5l3H1BRBFytYvejvouiSr0q/aCrQaAOJQSrKvi4vtHBXJZa
 zphfE+7i+OQFXXaiJ2sjLdPTmJbnZIf8aQAyAAV8tGxofn3qhdBFFz/4akQsKqH2ddmT
 pvx9aPVyoJuBBeLL7muyDYzUrNWenMVfJjWks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295922; x=1784900722;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PuPHGYNuRJJQIE+UG1gWl/EKuW2DzJ4NrR0CRIO6C88=;
 b=NUpUyV4QPEEu5MdAS+/zCpkm+UBrytR1g5PP4XfiFW7gsmx2yrzWcMLiB8TS4RUFTB
 d9MH8iUJ3d/ctDByhjnrNy3H8SmZRfPM7Xbmy6rgLLz+c8l9oFk6sCBO5CUW65Vy/xDj
 ecXrYurBLFxgLMnVfyu7SPdikdp3tUE19k2Zpk0/w6v2M9dEoc0INvo6klZA+Ss+rpfl
 5OspojjS8dp7E0MZpn4Cvq0AL/G3PGtVfvnDYK1KgtqeJjGGgzUomgae1zRJvtFOym8s
 /xk1ulD+Ricq6yhdNdqMTa29sDpP0aGAQZptIvEe5M0iWi/A9q3c+KSoO7atGqoJNUMc
 iLtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEwfbn4m76gfyzuhJ0GAN+DWBL6Zd7/vPSZwg0GTXPduOXXRJ9k8MuyZO376myZyfT5z8FjUk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1WC6SIczqs6KMVplvKugPxq65WDBTdX/8Q6gQTWABXpWEzDMm
 rYB8Q6kyu5+Qo+BXKVQkI3vCkB1IacoUUTyR4Sb7rNNDSlCs/i4X5a6UaBpaol0234P0Qd/R4Sw
 aTmZr3hlXCJWztOPGAPiMJySz4V3aIVnwwfRjYk0U
X-Gm-Gg: AfdE7cm/PfEJZ4tkg/mR/ybMsncQFjlDCDlj15JWKx/HdrpoQbLIROjnYeOPfROrSov
 aCRJkTsxhiSZ4D3EOhoIzSvvLofLBa5QyaVBT2WPoo2oXdKH0se1o7BY0UTOdY2ZR5sR/Owsq8/
 ljcl3ThLX3Xs0MHni7va6Pvf+5tp2sf+/GaYUUvrsS/lY7OAjKDHzHO15e2szUT3Upwo1JkRWKH
 JNqykkMvxpHDKP5E/xlB3TWsiISrxNjOmyUe9pnfypUZ9gsjFCQ9HD3ogNn
X-Received: by 2002:a17:907:1c06:b0:c11:efec:6ca9 with SMTP id
 a640c23a62f3a-c16b4699a22mr123018166b.8.1784295921836; Fri, 17 Jul 2026
 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-6-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-6-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:45:10 -0600
X-Gm-Features: AUfX_mxS14J54biaiq2_xW5aNvM_sEZbRP-FGNJOmwpuvgwYOAt_biIG13zzrBo
Message-ID: <CAFLszThd==GttCZR+GvCxpn7mFLkjjOe7aVtjagWzSADkH=wHw@mail.gmail.com>
Subject: Re: [PATCH 5/8] usb: eth: Add CDC ECM support
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: eth: Add CDC ECM support
>
> Add support for CDC ECM (Communications Device Class, Ethernet Control
> Model) devices.
>
> References:
> - [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
> - [USBCDC12] USB Class Definitions for Communications Devices 1.2.
> - [USB20] USB Specification 2.0.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> doc/README.usb               |   1 +
>  drivers/usb/eth/Kconfig      |   9 ++
>  drivers/usb/eth/Makefile     |   1 +
>  drivers/usb/eth/cdc_common.c | 153 +++++++++++++++++++++++
>  drivers/usb/eth/cdc_common.h |  26 ++++
>  drivers/usb/eth/cdc_ecm.c    | 284 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 474 insertions(+)

> diff --git a/drivers/usb/eth/cdc_common.c b/drivers/usb/eth/cdc_common.c
> @@ -0,0 +1,153 @@
> +     maxpacket = usb_maxpacket(udev, pipe);
> +     if (maxpacket < sizeof(struct usb_cdc_notification) || maxpacket > 64)
> +             return -EINVAL;

Just to check, why reject devices with a notification endpoint larger
than 64 bytes? A high-speed interrupt endpoint can be up to 1024 bytes,
so this fails the connection wait (and thus start()) on such a device.
Since ALLOC_CACHE_ALIGN_BUFFER() accepts a runtime size, you could size
tmpbuf from maxpacket and drop the upper limit. What do you think?

> diff --git a/drivers/usb/eth/cdc_common.h b/drivers/usb/eth/cdc_common.h
> @@ -0,0 +1,26 @@
> +int cdc_bulk_xfer(struct usb_device *udev, u32 pipe, void *data, int length,
> +               int *actual_length, int timeout);

Please can you add function comments for the exported functions in this
header, in the normal U-Boot style (see doc/develop/codingstyle.rst)?
For example, it is not obvious that cdc_get_mac_address() zeroes the
data on failure, or that cdc_wait_on_connection() treats a zero pipe as
success.

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -0,0 +1,284 @@
> +     if (length < ETH_HLEN || length > priv->ether_desc.wMaxSegmentSize)
> +             return -EINVAL;
> +
> +     return cdc_bulk_xfer(udev, priv->bulkoutpipe, packet, length,
> +                          &actual_length, USB_BULK_SEND_TIMEOUT);

I suspect this needs to handle a frame length that is an exact multiple
of the bulk-out max packet size. The ECM spec (3.3.1) requires the
segment to be terminated by a short packet, zero-length in that case,
otherwise the device cannot tell where the frame ends. Linux handles
this in usbnet by sending a ZLP (or padding by one byte). A zero-length
usb_bulk_msg() after the transfer when length % maxpacket == 0 should
be enough.

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -0,0 +1,284 @@
> +                     case USB_CDC_ETHERNET_TYPE:
> +                             memcpy(&priv->ether_desc, head, sizeof(priv->ether_desc));

This copies sizeof(priv->ether_desc) bytes but the earlier check only
ensures bLength >= 4, so a malformed descriptor can cause a read past
the end of the config buffer (or pull in bytes from the following
descriptor). Please can you check that bLength matches
sizeof(struct usb_cdc_ether_desc) before copying?

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -0,0 +1,284 @@
> +     if (priv->control == U16_MAX || priv->data == U16_MAX ||
> +         priv->data_default == U16_MAX || priv->data_normal == U16_MAX ||
> +         !priv->bulkinpipe || !priv->bulkoutpipe)
> +             return -ENODEV;

This does not check that the Ethernet Networking Functional Descriptor
was found. If a non-compliant device omits it, probe succeeds but
ether_desc stays zeroed, so cdc_ecm_send() rejects every packet
(wMaxSegmentSize is 0) and read_rom_hwaddr() fails. Since the
descriptor is mandatory per the ECM spec, please can you add it to this
check, e.g. by testing wMaxSegmentSize?

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -0,0 +1,284 @@
> +             /* 9.4.3 Get Descriptor [USB20] */
> +             config = cdc_get_config_descriptor(udev, cfgno);
> +             if (!config)
> +                     return -ENODEV;

If reading one configuration fails, this gives up, whereas a parse
failure moves on to the next one. It seems more consistent to
'continue' here so that a device with a bad first config but a good ECM
config can still work.

> diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
> @@ -0,0 +1,284 @@
> +U_BOOT_DRIVER(usb_cdc_2_ecm) = {
> +     .name = 'cdc_ecm',

The numbering is so NCM gets preference to ECM, right? Could you
please add a comment?

Regards,
Simon
