Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C40C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 06:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0B887D1A;
	Wed, 14 Aug 2024 08:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yq24bxNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2576387873; Wed, 14 Aug 2024 08:02:01 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A9187D1A
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 08:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f149845d81so67983821fa.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723615318; x=1724220118; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nbmdt5wpl8ONmIpzKkA5WvzqXo+0VlhvvTnVHWKhmLE=;
 b=Yq24bxNUQ9OQgEb1yY7uJ3LpVO4CFMZUfmFfP9JT6h2clrXlQp5cp0cC9QZAwSUb2n
 hLZ0ZkCaUu6PelC0gPzGoL33MHcuVWYsXtPBGC92bstkMS3qBCNZgOaKyYg1e2QxM4vc
 xt/NtBT3bmlsNBYyiHVM2Ms3RU3lnsH54jDRGHhmosPOqUowS3wA0YpcJL3tSFu6qzsc
 78mrWI8cHSPvPrqBCbR/brn79io7M7yps2ApAUN406iCOPUMHC0b0T/1bFdLlkotLQzT
 aXmMZD8ZTMXs4wdzly5Y4eI/RZ8uWwf14CSz6V1hFxmgc3OUUEWo3zbjLUyvmB7KUHZz
 wpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723615318; x=1724220118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nbmdt5wpl8ONmIpzKkA5WvzqXo+0VlhvvTnVHWKhmLE=;
 b=a5DrRvAQuv/R27tj7Upp1PUWbokGwlKbh4Cfp+fIAxhFu8f29Qx0K6iCT/wsPvUBQv
 7/5TUuQ1Gksqhfvc+I2eRXwBxcHbBv3mn/Pm30tL8ZHzINsBL9uxjxNvdesLZvkb7sbG
 dBcHjwC3ZMvrBIIP9BHX+w2ozUxjACJVD80TXX4d2khjMTF+0GnhYYm+Tw1xQraey2XF
 smLifuM06zoFvWtoBCPpYjxn1aLjda9PA+lj0vsV6+xdM1xbbW84Dhxq+0Pz/7uOjwNf
 SUZMuAtkvGCCoZFctXCxG0EjVPer0r6xGu6XkjDNFDX+xAibwC+Ne4eovh0EU/Zh3B03
 Lp1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFOu1A++Re9SHS0pkI3HfHgxLC7pt+ied9POP2+SiR0IdvKHBhWVz/z/M+sk2VUg6mkvsLCNEsedVQg4wBlyJEvzi0Bw==
X-Gm-Message-State: AOJu0YxRtvtUCR8zOUKJadU3NQCQVlqaG6nJ2BS5tar0ablFaMojCNP/
 viNU2ILOfLNq6ccmNaIaumJuiyuvtanwoUhOw1e7HckX9NTLg2g1Zg8UknZPSn4FsmX64ACt9zB
 WnN1FCm2XurwTMZ7EcMd1F+cBgmUEOigW
X-Google-Smtp-Source: AGHT+IHvTdNYX1rxPVVMuO2n7K5EVcE4CjfXO5F8aD4y68QXWD/qS2M2vtcP/XiwrPlssvpclcN0fiIDf2nCFfj8iP0=
X-Received: by 2002:a2e:701:0:b0:2f2:9f26:ce96 with SMTP id
 38308e7fff4ca-2f3aa2fc9d8mr7540691fa.40.1723615317863; Tue, 13 Aug 2024
 23:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240808185627.769049-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240808185627.769049-1-heinrich.schuchardt@canonical.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 14 Aug 2024 13:01:46 +0700
Message-ID: <CAJaLiFzrjJf=WzFYmoSJz8TFvctFDASEuWavfaPgO9pes5-CCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ata: sata_rescan must scan for block devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

Hi Heinrich,

Thanks for upgrading this driver to handle multiple SATA controllers.
Please see my comments below.

On Fri, Aug 9, 2024 at 1:56=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A system may have multiple SATA controller. Removing the controller with
> the lowest sequence number before probing all SATA controllers makes no
> sense.
>
> In sata_rescan we remove all block devices which are children of SATA
> controllers. We also have to remove the bootdev devices as they will be
> created when scanning for block devices.
>
> After probing all SATA controllers we must scan for block devices otherwi=
se
> we end up without any SATA block device.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Scanning for device on an unprobed SATA controller leads
>         to an illegal memory access.
>         Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
> ---
>  drivers/ata/sata.c | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index 84437d3d346..2139ae9903e 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -49,38 +49,40 @@ int sata_scan(struct udevice *dev)
>
>  int sata_rescan(bool verbose)
>  {
> +       struct uclass *uc;
> +       struct udevice *dev; /* SATA controller */
>         int ret;
> -       struct udevice *dev;
>
>         if (verbose)
> -               printf("Removing devices on SATA bus...\n");
> -
> -       blk_unbind_all(UCLASS_AHCI);
> -
> -       ret =3D uclass_find_first_device(UCLASS_AHCI, &dev);
> -       if (ret || !dev) {
> -               printf("Cannot find SATA device (err=3D%d)\n", ret);
> -               return -ENOENT;
> -       }
> -
> -       ret =3D device_remove(dev, DM_REMOVE_NORMAL);
> -       if (ret) {
> -               printf("Cannot remove SATA device '%s' (err=3D%d)\n", dev=
->name, ret);
> -               return -ENOSYS;
> +               printf("scanning bus for devices...\n");
> +
> +       ret =3D uclass_get(UCLASS_AHCI, &uc);
> +       if (ret)
> +               return ret;
> +
> +       /* Remove all children of SATA devices (blk and bootdev) */
> +       uclass_foreach_dev(dev, uc) {
> +               log_debug("unbind %s\n", dev->name);
> +               ret =3D device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> +               if (!ret)
> +                       ret =3D device_chld_unbind(dev, NULL);
> +               if (ret) {
> +                       if (verbose)
> +                               printf("unable to unbind devices (%dE)\n"=
, ret);
> +                       return log_msg_ret("unb", ret);

We should not bail out too early here. If the current controller
scanning has any problem, fail loudly and continue with the next
controller. IOW, remove the above "return log_msg_ret("unb", ret)".

> +               }
>         }
>
>         if (verbose)
>                 printf("Rescanning SATA bus for devices...\n");
>
> -       ret =3D uclass_probe_all(UCLASS_AHCI);
> -
> -       if (ret =3D=3D -ENODEV) {
> -               if (verbose)
> -                       printf("No SATA block device found\n");
> -               return 0;
> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
> +               ret =3D sata_scan(dev);
> +               if (ret)
> +                       return ret;

Same comment, are we bailing out too early here? If the current
controller probing has any problem, fail loudly and probe the next
controller. IOW, replace the above "return ret" with printf();

All the best,
Tony

>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
> --
> 2.45.2
>
