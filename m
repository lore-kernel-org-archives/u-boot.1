Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A46C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A05E889D2;
	Wed, 14 Aug 2024 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/zBrNIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB382889D2; Wed, 14 Aug 2024 14:36:31 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3B9889D2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f0271b0ae9so71402931fa.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723638989; x=1724243789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+NJJKx0eJ1ciDnZRYgovngXaLFp8cwOcFQbXS1Vue0=;
 b=Q/zBrNITThC6sA4NstF9YGpxA/PCYAac0TA4ANvETUYl8QEYAewGo3rb870QA6KiVi
 lz7flhBKHnr8CF/D7bW9/hQcl0tO38Vgwql0glFv3kKpjPZDA897oIUnRFBznA4BLvQa
 2XGKXvoUY+rALUDDfER4PUIUN0nAlUDv8NtAxfqB3r67dkJkc53JTp9V6tfCQZNLWUqx
 PtLJFdj7AL1c7aL4dnTPvNllySfXu8G6JNUjSBuCWoIEh9oCJ0uQGbZGqXtvTqLHBBDm
 Tp5XmLUqVY6xHUW11m5naNJImg+qmiZRPAR1HZ67YI9NtmFHC4YfIDZppTEO21svE2qe
 1JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723638989; x=1724243789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+NJJKx0eJ1ciDnZRYgovngXaLFp8cwOcFQbXS1Vue0=;
 b=q1NbXdRjZtgjfOEf1AbYSROadFmsHvfoWDiXVxhZQ5/db1uscRgcuUuntXBGbe/KG0
 5Q1IHYRnAqEApNPjDgmy5Vr7CD9buUISymRAkgf8G/QWuu2FsBUUhqimwioP72ldYw/U
 +iWDydsm7Ba0KRcE2JeDhlyk4Jc42dJvZldN/mHNJSH4XkyZQuPlGN0gSLMRc6w3FVXG
 pISmRayOjDLbC54peuXWpU3YWMYycejc0JYJWesHsaZCCNhj/wU+emwZMgGfIB2L+gCL
 Yq9ytVa2PHo/VbtsetVADbEZKE+U6akVCDGSlw/Cdf++VkBlXZbEEDMbWEGEVvHNfHC9
 xp7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGL2LAdsXQvWK8CATUJkWH+qciwVaY0R4SU0aH4rrsx0sfH6Bv8areafOcbbuWpEgYelnp5q8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyug3skUzKXV5WNnlAjNPKUu8qNDVcRPkOKKZuvmrngJgB28goZ
 /yL1O7EbdsjHo5DnGULwpSYwBZmXIo4zIfeNpHkgItXH2JFSg+5M4+YAF5kBszgSTle5cca5iJ3
 1GGm94T638vs1JBfvdV5Lg6r+no0=
X-Google-Smtp-Source: AGHT+IFAKKmoaeqBPYpp9rT4gjnr9yjwCFmXR58P7PANMKKbgYzde6iZu6zFzsx+T4eB+VML2CsH/ZcR8YAFh2Vn6Jg=
X-Received: by 2002:a2e:9d09:0:b0:2ef:2f7d:c502 with SMTP id
 38308e7fff4ca-2f3aa1ff339mr16627611fa.49.1723638988152; Wed, 14 Aug 2024
 05:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 14 Aug 2024 19:36:16 +0700
Message-ID: <CAJaLiFwsWZQVT3yi8Y4h+8CNX-F7H-vEuVQR5+G0yPNCnUVc8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
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

On Wed, Aug 14, 2024 at 2:10=E2=80=AFPM Heinrich Schuchardt
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
> v3:
>         continue unbinding and scanning if one device fails
>         write a message if scanning fails
>         add device name to error message
> v2:
>         Scanning for device on an unprobed SATA controller leads
>         to an illegal memory access.
>         Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

> ---
>  drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index 84437d3d346..89cd516f3d6 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -9,9 +9,12 @@
>   *             Dave Liu <daveliu@freescale.com>
>   */
>
> +#define LOG_CATEGORY UCLASS_AHCI
> +
>  #include <ahci.h>
>  #include <blk.h>
>  #include <dm.h>
> +#include <log.h>
>  #include <part.h>
>  #include <sata.h>
>  #include <dm/device-internal.h>
> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
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
> +               if (ret && verbose) {
> +                       log_err("Unbinding from %s failed (%dE)\n",
> +                               dev->name, ret);
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
> +               if (ret && verbose)
> +                       log_err("Scanning %s failed (%dE)\n", dev->name, =
ret);
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
