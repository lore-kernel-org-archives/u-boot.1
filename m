Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE56C54764
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD87A87DBE;
	Mon, 19 Feb 2024 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="w/WiE4N0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB2D87CED; Mon, 19 Feb 2024 10:50:16 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1904087F25
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4c8979d847cso95605e0c.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1708336180; x=1708940980;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2n6o/cV/RQ4nmWQjLwSF2eSsaQT/UACK458FQdbm8Y=;
 b=w/WiE4N0zcJRZgit2DMO2zUG8hnAxcf3mFdJJ1owhe5GI9a7PV6szl9Lap893qPbob
 Ed7AsXmGGxX20KL9jD8sqLieele2JwDnWj4S6IiOG9xxMbz1Qy53pW2S+DIdFPvq2WxZ
 SsgqO5fku98LU/FVZ7vSDrvkeXVIIMtIc1W1YsJmlM/bi369UQWf2L5SPxzFi0CpW/uH
 jj+uwWoHuAIZqkjpNKa1EGiVmg05CCVvB6DTT8Q4NUiIti+1Kt/Q9C3jlHReFBCTHFIj
 Isf0/Kwt494ebp7g02lD2p8CCy0qbbtC9FLIarT0LKsx+0ubx3U1rJnhpPGpaB2z7oyP
 G2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336180; x=1708940980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2n6o/cV/RQ4nmWQjLwSF2eSsaQT/UACK458FQdbm8Y=;
 b=ISxrRjzFWd2lB4DtUmvy4uyvxpRG0Ucf7f2jT9osxukOrQbju9SkDKyaqdTcyo5uHH
 LzUtDF9NpYSL0IFLBZr97gYVeJPY4WeY1LpzYNwytwJPqOtph7JkLvX174k8fOl5v85Q
 v+55jSxahici+AWcxIVtm9t9Jl2bRuSKPSxFORuJXuQithoH2oYJ/5XDx7usAepL3+5u
 aVt5J0i7DaRLg5G5nvQhuxL24AdZ1Y8kgRLAJQXLhmESd0pqrdofjKt9L/zNJGRn/YLw
 u898v3EJbQu2gg0SkFddc0RretLH7Kbx1m+jzLMM+JOhaN8YZvxrqNdANsqG0mteLEME
 FxIw==
X-Gm-Message-State: AOJu0YzwnTVP4nLgYgha7BQO/i1htMqKUW4UPfwTayGG33b6QyucPHXP
 GhqvkRDnZxLa3Z9G2xD90fVgz9s9ggs7lkHdeYzvdeNFBys+O1buNqFd3lpyURSH0Ua/5lMuXfR
 u6cJ6U2C8AhOBOqAjLChV/JWCb4FfrkLCQ0k5DH6mSfBypQbh
X-Google-Smtp-Source: AGHT+IHDDcJ2t109Zx9fIDdiFY/6yl06d4Rr2sJRMhHNr5ANujFvWT0aDp2wkD9mYiOueWY8Y77yKKCGM+yoDRapklo=
X-Received: by 2002:a1f:4f02:0:b0:4c0:2d32:612f with SMTP id
 d2-20020a1f4f02000000b004c02d32612fmr6386710vkb.15.1708336180555; Mon, 19 Feb
 2024 01:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20240214095403.53051-1-i@shantur.com>
In-Reply-To: <20240214095403.53051-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 19 Feb 2024 09:49:29 +0000
Message-ID: <CABEcMwWK8_rKE6xPmqwGznau6aadL7gVsiCktsxg+-u+eb1umQ@mail.gmail.com>
Subject: Re: [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
To: u-boot@lists.denx.de
Cc: dsimic@manjaro.org, andre.przywara@arm.com, 
 Hector Martin <marcan@marcan.st>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Wed, Feb 14, 2024 at 9:55=E2=80=AFAM Shantur Rathore <i@shantur.com> wro=
te:
>
> Additional testing of the changes introduced in commit 33e06dcbe57a "comm=
on:
> usb-hub: Reset hub port before scanning") revealed that some USB 2.0 and =
3.0
> flash drives didn't work in U-Boot on some Allwinner SoCs that support US=
B
> 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.0
> flash drives failed to be detected and work on an OrangePi Zero 3, based =
on
> the Allwinner H616 SoC that supports USB 2.0 only, while the same USB fla=
sh
> drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC th=
at
> supports both USB 2.0 and USB 3.0 interfaces.
>
> The USB ID of the above-mentioned USB 3.0 flash drive that failed to work=
 is
> 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 32 =
GB
> in size and sold under the PNY brand.  The mentioned USB 2.0 drive is som=
e
> inexpensive no-name drive with an invalid USB ID.
>
> Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
> resets, has been tested to work as expected, resolving the identified iss=
ues
> on the Allwinner H616, while not introducing any new issues on other test=
ed
> Allwinner SoCs.  Thus, let's fix it that way.
>
> According to the USB 3.0 specification, resetting a USB 3.0 port is requi=
red
> when an attached USB device transitions between different states, such as
> when it resumes from suspend.  Though, the Linux kernel performs addition=
al
> USB 3.0 port resets upon initial USB device attachment, as visible in com=
mit
> 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the kerne=
l
> source, to ensure proper state of the USB 3.0 hub port and proper USB mod=
e
> negotiation during the initial USB device attachment and enumeration.
>
> These additional types of USB port resets don't exist for USB 2.0 hubs,
> according the USB 2.0 specification.  The resets seem to be added to the =
USB
> 3.0 specification as part of the port and device mode negotiation.
>
> The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible i=
n
> commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm reset.=
")
> in the kernel source.  The check for SuperSpeed hubs is performed in a wa=
y
> that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as well,
> which hopefully makes it future proof.
>
> Fixes: commit 33e06dcbe57a ("common: usb-hub: Reset hub port before scann=
ing")
>
> Link:
> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
> Link:
> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.mancheste=
r.arm.com/T/#u
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Helped-by: Dragan Simic <dsimic@manjaro.org>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>
> ---
>
> (no changes since v1)
>
>  common/usb_hub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 3fb7e14d10..2e054eb935 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *=
hub)
>
>         debug("enabling power on all ports\n");
>         for (i =3D 0; i < dev->maxchild; i++) {
> -               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> -               debug("Reset : port %d returns %lX\n", i + 1, dev->status=
);
> +               if (usb_hub_is_superspeed(dev)) {
> +                       usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RE=
SET);
> +                       debug("Reset : port %d returns %lX\n", i + 1, dev=
->status);
> +               }
>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>                 debug("PowerOn : port %d returns %lX\n", i + 1, dev->stat=
us);
>         }
> --
> 2.40.1
>

Is it possible to get this in before the next RC?

Regards,
Shantur
