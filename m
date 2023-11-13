Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF95C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B1D8709A;
	Mon, 13 Nov 2023 14:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="xG7QuC6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6319486F40; Mon, 13 Nov 2023 14:28:29 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B568709A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 14:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4ac45927974so1974271e0c.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699882106; x=1700486906;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yULy7/aBubRpzJWJ0hLh1fcPQKUGt9DQ9nvXKurCkI=;
 b=xG7QuC6qAu2MYJNcqf/cHjA63iVm4dNqKn0Mr/SIR0EtcKZaM7A+eZ3NekORufrUoS
 yA2f+n2A8ZaW9IhT2P3ZDZbxc9thPbt2CZmmZ03MQ6kSEzJNZ2CRQo46R94FZrSStpOU
 tAyl61KtpI0MfOGL7aB5JgR4XMOm3Yyzka/JlZ/Kota8pWJ2dP45scOc4CitjBDBAgum
 dAWXGQKxh9airqCwYQM48fbgfW2cgIKB5SUiK5Si1au03ryfFPDJVXaKSab+PX2kv13a
 /O5A0adLuH1UOYI2mOB6kOiB9zbd0efcKzaoW+0jtwb/EiqUIhjVOZJc44dsc+ZPUugX
 ioxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699882106; x=1700486906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yULy7/aBubRpzJWJ0hLh1fcPQKUGt9DQ9nvXKurCkI=;
 b=DbdvaQmjRaIwetvHTQMMVCGLJ270N12jkn0OqxGgH0nkjls3MF8YXWuWI7FhqPTOCR
 SkHnv1nOsX3D3nXcdBLa8n/fRGhnhzKH1bL0V/X391jI/GnvE7+uGlCw1uBiLBj5zauw
 QXj9bYWrR8vareekSyO/6V9yD9/Je0XIjiKAYkPNVmNBbiGEvYrUMlujC0Wd2f/MWfqD
 YD/1azBTNGJEAbPbfmCsKm0yeTUMXJOsQ4QJ2Sdlt3Q85W57kN7Nb8lkVbkXRXAfgsjZ
 caeGKK4FyN6LnREhAtARtZQHjm7b94tsS3PFEnUZqlYotd108/nfa2yLePu3fQ/zn6Tf
 A12Q==
X-Gm-Message-State: AOJu0Yzxw5mz55nHjjqBJczB2bVqMraocu78AMH+cMz1w6rU8x2Gvlsr
 vOF8lGn8E9u8/XwZ9qwuCBCd4gNenIvZbLMQti7GRHUEKW+Qc2HZp0P6GA==
X-Google-Smtp-Source: AGHT+IEYmUc3ujn5mFHNXOUeBsAphpkItWyvFIx2788bE9mnGvVRn/zJGzz+Vmrv2DNCMMznNry/0gnbWVsg5N/Ku1s=
X-Received: by 2002:a05:6122:4e22:b0:4ac:2316:5afa with SMTP id
 ge34-20020a0561224e2200b004ac23165afamr7582921vkb.12.1699882105872; Mon, 13
 Nov 2023 05:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
In-Reply-To: <20231110141311.512334-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 13 Nov 2023 13:28:15 +0000
Message-ID: <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, trini@konsulko.com
Cc: marex@denx.de
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

+Simon +Trini

On Fri, Nov 10, 2023 at 2:13=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
>
> For the hubs without individual power control this has no effect.
> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.
>
> With this patch, we explicitly reset the port while powering up hub
> This resets the port for hubs without port power control and has
> no effect on hubs with port power control as the port is still off.
>
> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> detected as a USB3.0 Mass Storage device but with this it works as
> expected.
>
> Tested working after this patch:
> 1. AMicro AM8180 based NVME to USB Adapter
> 2. Kingston DataTraveler 3.0
> 3. GenesysLogic USB3.0 Hub
>
> The drives were tested while connected directly and via the hub.
> ---
>  common/usb_hub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 85c0822d8b..06fe436add 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *=
hub)
>
>         debug("enabling power on all ports\n");
>         for (i =3D 0; i < dev->maxchild; i++) {
> +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> +               debug("Reset : port %d returns %lX\n", i + 1, dev->status=
);
>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
> -               debug("port %d returns %lX\n", i + 1, dev->status);
> +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->stat=
us);
>         }
>
>  #ifdef CONFIG_SANDBOX
> --
> 2.40.1
>
