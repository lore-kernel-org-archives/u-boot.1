Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988B4C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A8284E34;
	Fri, 17 Jul 2026 15:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QylYmt7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDAF84E37; Fri, 17 Jul 2026 15:45:49 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4EC84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c7c8accffso11221910a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295947; cv=none;
 d=google.com; s=arc-20260327;
 b=WgCsrlnbfq1HsmvyOSKg6xBY/ZTF/6KsncW1KEgEN5EOVaYjJoLNMScqPaCDngHTlB
 zgv9F+2AYENS+IVtvpVU8snbiOF96g9B1Qz7cTwF77Di0SdiH9QM14uOTXf+tEMHOocF
 cLEYUJzhEPKF6OQMxolEHBQ6ObZ8o1eUpZIpDdPavE9ZE8wS2kY8hGRL7HlKAL3azinF
 RmF584bIUXrg/KgEciVjq7zvsDUGDWBOJkEy/PTLp1jARdlsOUC5r3fGCpfjEGi5VKqM
 jwBaPoRLVhcU1hnOrbMo4NxPQQUFoBGVEaSz/ZhIVbgAOWpNPMxOJAe5HuUh/9niAzEg
 D+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lrh0O7Z/XXfl1XlHdPUpVSB++UzVKMXLzV8uD28fxNI=;
 fh=RjrOloAlRaatDJGZC+avu9o5bJcMoMkqKRD10Z1QTkA=;
 b=eM0huRyYa26JRVfMeeedxkjzcv9NMzdKTWYD4ZSsTP5ndhnLXViSojv3pIK+Z5XTFt
 CcDVRjm9SB5fVOrbRQfPuMWcerWqKZLKmoZDDZPt5NfVEBHpNAVhs0DAl0qRn4f6TpLF
 FIsGs+Ax+Rt3Rd23/Mk87qffEKipqjtkilvFSqWaWWG+7K3uZ1q+QV5+T+dDknx8+/rC
 dlm7rIx4XAxhlmR6m2+v1W7CXS+0CCTdHeLgJoqx72/oD5fykOQkAvB3d82bO7lXXL/k
 M37xYBbelKLPvInPtSqioSU0TPOjyny1mT0EYrsXHIyPlq4P29FC8zw+50+S7fRxqZGC
 Opcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295947; x=1784900747; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lrh0O7Z/XXfl1XlHdPUpVSB++UzVKMXLzV8uD28fxNI=;
 b=QylYmt7t6wFJx2Imk8EGsMYONCFsBssFUnH4aAkKgJbRzfoNLC1u1istYU75W7uccm
 PHgqsE+97d6+9LzqXHySiVGrZoNS636zWMzkcK4/S+4Zf4rFpQVoaynfSlTjBH5LqBK6
 lwPyD+6A0kuKtVh3GXCjBA9edBKW0Nvb7HHps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295947; x=1784900747;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lrh0O7Z/XXfl1XlHdPUpVSB++UzVKMXLzV8uD28fxNI=;
 b=aotaYLxaqwBUAGyL4RYoPLWhmuSpKb1KTDJu+jj1tBwGLfgoeu+LaRIIY7hziLU0pW
 mh2tQSi4TmKrjCgiRMFeTBgrEW8aKb58j9Pu9xBmcEKfcXBWegIe18R0GbVHBZt5Hn+W
 dfLilj9zxkqGVrQV8tPM6N5lPphI/k1Oyuz+GT6dw4ivqhoPzJs20ECIEkZkZOyyKV//
 KB3sVKoMl0Dy3jFMrbdoQ2EsM12ZytlEAosQREw3DjK+cbexsVwz4Lvo32NauWqE3Xeo
 oqTUe6Lzu9L95GvbcKbtSXa5kQSNIWiGzWb0dBWSffSwu0X7ufI1bkh/pYrS6yk+rHaR
 nlbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdWuyjK7IqBlhbwOQX/UWQaqnv/7FTZcRSwXEDz7NdFsUqtELiLF2wy4diplsTqc+ilitHCyw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+0t0SjLPn+pGek2oLD7/s4VndBFkq076YgJEWqhqT4S7F3t5M
 kRYPqKd/bUmas4ZpFjbjU2npOEEgaN4L8ji0GDHHgNAaLR4VOr00T/4YxvSmjOiWSq8bfZyeZHZ
 pRdW30DOhVmVHw4Q+PBJxHso1ZEySm6phTl+SNCv5
X-Gm-Gg: AfdE7cl81Up+tJvgH6C+/rVCWPI6rvYhb04wyA5eSiXa06fstKrQauDETFN4ZSuQiL9
 hBIraCZ++JHrn2Fd8mPthwtLJcGmytEq+3A0XZRSFccwt3j2aZtCK0v5jz+mlQ1FTm37EQ0gcim
 G2RZykIl2Ai+DisVb0m6VgmvRqN/gkp8TtfjHIBYXi+PPAANJSSJL8D6yLr+eTsfyq78aiP+tE/
 8/SmR8rykaV5q5niDZNIm+NEywCZARD+vOHx1kyIVJyjTW8aPstrdS1Jome
X-Received: by 2002:a05:6402:354b:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-69e6525b110mr1060444a12.1.1784295947187; Fri, 17 Jul 2026
 06:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-7-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-7-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:45:33 -0600
X-Gm-Features: AUfX_mwYXIPYWKTJcmj4uLWMBFyLVQao0MDG4wFivxBnAy6902gKaxIBD56A2-M
Message-ID: <CAFLszTg+OdWz8iW9v6An68EBwXMdi1RUfK3enQOWgjqwEjpypw@mail.gmail.com>
Subject: Re: [PATCH 6/8] usb: eth: Add CDC NCM driver
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
> usb: eth: Add CDC NCM driver
>
> Add support for CDC NCM (Communications Device Class, Network Control
> Model) devices.
>
> References:
> - [USBNCM11] USB Subclass Specification for Network Control Model 1.1.
> - [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
> - [USBCDC12] USB Class Definitions for Communications Devices 1.2.
> - [USB20] USB Specification 2.0.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> doc/README.usb               |   1 +
>  drivers/usb/eth/Kconfig      |   9 +
>  drivers/usb/eth/Makefile     |   1 +
>  drivers/usb/eth/cdc_common.c | 112 ++++++++++
>  drivers/usb/eth/cdc_common.h |   9 +
>  drivers/usb/eth/cdc_ncm.c    | 480 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 612 insertions(+)

> diff --git a/drivers/usb/eth/cdc_common.c b/drivers/usb/eth/cdc_common.c
> @@ -74,6 +157,35 @@ int cdc_set_interface(struct usb_device *udev, u16 index, u16 value)
> +     return ret == ETH_ALEN ? 0 : ret;

If the transfer is short (ret >= 0 but not ETH_ALEN) this returns a
positive value, which cdc_ncm_write_hwaddr() then propagates out of the
write_hwaddr op. Please can you return -EIO (or similar) for a short
transfer? Same for cdc_set_ntb_input_size() below.

> diff --git a/drivers/usb/eth/cdc_ncm.c b/drivers/usb/eth/cdc_ncm.c
> @@ -0,0 +1,480 @@
> +             /* 7.2.6 SetNtbInputSize [USBNCM11] */
> +             cdc_set_ntb_input_size(udev, priv->control, priv->rx_size);

The return value is ignored here. If this request fails and rx_size has
been reduced below dwNtbInMaxSize (which can happen via the
usb_get_max_xfer_size() path in probe), the device may send NTBs larger
than rx_buffer expects. Please can you check the return value and bail
out, as you do for cdc_set_interface() just below?

> diff --git a/drivers/usb/eth/cdc_ncm.c b/drivers/usb/eth/cdc_ncm.c
> @@ -0,0 +1,480 @@
> +     dpe = (struct usb_cdc_ncm_dpe16 *)ndp->dpe16;
> +     // FIXME: align using wNdpOutDivisor and wNdpOutPayloadRemainder ?
> +     offset += ALIGN(le16_to_cpu(ndp->wLength), 16);

Please can you resolve this FIXME before the driver lands? The device
declares its required payload alignment via wNdpOutDivisor and
wNdpOutPayloadRemainder, and Linux honours these when building the
frame (see cdc_ncm_fill_tx_frame() and the tx_modulus / tx_remainder
handling), so a device is entitled to reject a datagram that is not
placed as requested. Since probe already fetches and validates the NTB
parameters, using them here should be easy enough. If there is a
good reason to hard-code 16, a /* */ comment explaining would be OK.

> diff --git a/drivers/usb/eth/cdc_ncm.c b/drivers/usb/eth/cdc_ncm.c
> @@ -0,0 +1,480 @@
> +     } while (++dpe);

This condition is always true since the pointer can never become NULL,
so the loop only exits via the break or the return above. It does
terminate, because the last DPE has already been verified to be a Null
entry, but it took me a while to convince myself of that. A plain
for (;;) loop, with a comment noting that the Null-entry check above
bounds the walk, would be clearer. What do you think?

> diff --git a/drivers/usb/eth/cdc_ncm.c b/drivers/usb/eth/cdc_ncm.c
> @@ -0,0 +1,480 @@
> +     if (priv->control == U16_MAX || priv->data == U16_MAX ||
> +         !priv->intpipe || !priv->bulkinpipe || !priv->bulkoutpipe)
> +             return -ENODEV;

As with the ECM driver, this does not check that the Ethernet
Networking Functional Descriptor was found. If it is missing,
cdc_ncm_read_rom_hwaddr() will still pass iMACAddress (i.e. string
index 0) to cdc_get_mac_address() when NCAP_NET_ADDRESS is not set.
Since [USBNCM11] requires this descriptor, please can you also check
here that it was found, e.g. that iMACAddress is non-zero?

Regards,
Simon
