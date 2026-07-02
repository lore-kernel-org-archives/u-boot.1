Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D8DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412C084A06;
	Thu,  2 Jul 2026 16:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gX5RPvO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD01584A12; Thu,  2 Jul 2026 16:27:36 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D994849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a198cdc4e4so831091eaf.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783002453; cv=none;
 d=google.com; s=arc-20260327;
 b=Qj+9tCPrEXOofh7al107hWwBNQ1sbnoa7ocDH5xHT6HMFG/BlXTgQj8M0Kl11ARJzw
 u3bjfooNtopKlyOpcd7co43FfwT/qItigP1xSv+oZi/akeHwAYCBwM136ZZc6yX+p80/
 jKJnbCCljC4sTnIj5u38JS2vi+6R3HbhYgo0AvfAsYi1w9UrJ24cxbsYPqSMxHOx8d3l
 vwcPVjXoI1zTUnRh+n94J9mnBejbsrjJUoHR1nTO5PypvoiMGlYEP8yz2+mUBkbOIu+t
 DdEwy6UJBqXhxeMj7EOwlP5rvfTc1WTFH7qYDnle8MRf/eak6bah3N4ZGgjm2N6zLJo7
 J2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rYv+V3QuYOAZk8OUZbIg4Hi6/wUTaaMBnhvhQQo/DbI=;
 fh=C6xnfQ1THzxBkbO1mwuSmr6MsDo3j05m6QG7Am6Dchw=;
 b=dgbLdhbxL6HDg4IHyNxT4OaqQclkCZGqMH32sujgRXibBeulajPE4UNkLdgAY67WxB
 sOtgV1vww7ubEkNqnkFtb0HNb5LUhX8BV4bmAYvSo6fNmXFcXR6xn+MxP6FVQ8sHsFze
 tAewA50UpP8JpTEiLkI0M7pOzosLGicoTPq66oJB+lrIimXgiZR2L+o8F2kcDyXCg2en
 JC+cr0ITxER3x+1fJKJv4Xv2fb0X8Nm45JypCV17PpqUgtfiK1g2P3aGbKphRbqsWEX2
 0wW0W1Vyro8nV953M3tCmTHJMzXcxgBHG6ETk21V3G2YHKBaJGZAAAUvcM1Vqw2j4huX
 VoQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783002453; x=1783607253; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYv+V3QuYOAZk8OUZbIg4Hi6/wUTaaMBnhvhQQo/DbI=;
 b=gX5RPvO9YLVaWWJ7XrZDp5hOTdr692OuZpZIafOmsw5K0hxDlyorHiLBhhLboeQd6Z
 TxJwMeN6GjklofrW+RyW4vkYi3DesYd4tIrYTGB4OZ9woiYovoLuxFle5HmUlFAdm59m
 VeDt7ubS20xmforYx/p7WLLAOljdezZT/w9/t61kYGJtfliN57czX5t3u4G1AKbYWN9E
 wzMhwLEo+L3hFuBzQCnPQkMH8mw9UAS4qtLDJP1FwAk7YqBtXeXZIEDI6xXg+6kUCFDY
 TEn0ae3Ta0IjFfm8VOy2s/SgPnPk+MRJIEDU9+Ez7NmwWUsj4yt3LYU54RMOpEmgwu8n
 ud9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783002453; x=1783607253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rYv+V3QuYOAZk8OUZbIg4Hi6/wUTaaMBnhvhQQo/DbI=;
 b=SeNWrs72F905drdOV4tJQqLWiyWLYRGRJrm1FFpkm+LirZv4YH8T2RvP80ZBEPqx/R
 0B6rkOR/n7yKQdck+2B4mibkl/WZIbwqOXzqQ5pSq6v29Py5HkR0VV8izYiCGOQl0/Uk
 xZIev736SNQbz4d7J/8R2Dy9tcRxyrpQXHrXdkyvxynfaQBbDuhFvlL3hgfz4FsvZDZY
 AhM0A2fHTqYcR4VKtzG+zJ1piZNBR4z0J2yld/L8sIDH397hJtXjLREOEzBLEzilWGfz
 isDqwakjQQUIBX0BcFTsIrwbMFdPiM6ZALgs/aQKr5WGFRmDAEmOMUVmA70+erZ23fSh
 y3WA==
X-Gm-Message-State: AOJu0Yw9hwwceXJltlCwVI5NmDL8jYRXmf4d1qQXpKxBU4qYxHG+fVqQ
 t6KA/Cw8lXpvOFQZQvCEnCG+OifSNycSVIcr7Ykl1Nb+KgPVPTIKuyyMvJ7J/oD74kJvA1Xk+SE
 AciiSzrU7tl1U4pPsWRyxeuSXCu1zzN7xD86Q67bSwjg/yNi0xSBjcr7l2Jd/Huc=
X-Gm-Gg: AfdE7clACRq4W0iKDr7eNYZMFi5ofTRcnnKaPO/oj8tetoq/U5yTVa2HIPvl6PSXp1l
 J/GuujAojIPEfsJ9wHSjgZcEsPPCqrfCq8sy2PmatPL1iEDMAyL4yUkm9wxgIVoJjKHOwkD3A93
 /C0QFx4bBb/izyIUwhr9pLhmPpxPq2DQA0F18kQoP68nrlFa/B/wTV76JuILOMWsa14tB4Ni3le
 c3kxmO+e6rEfnrk+aobZFkt4Db26N7EsDcT0Cr7bBvkTflUlq2KUlH/yHBqCirDWfxqErD28A==
X-Received: by 2002:a05:6820:1524:b0:6a1:50eb:d510 with SMTP id
 006d021491bc7-6a309bdf8f9mr3951052eaf.65.1783002452726; Thu, 02 Jul 2026
 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
 <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
In-Reply-To: <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 2 Jul 2026 16:27:21 +0200
X-Gm-Features: AVVi8CeilfNeIL34rpruwuosCEUe8R-vhCvQphX5O3M4XvJr7cMn-Pce91IgxHk
Message-ID: <CADh8LscDis-pfMK26usYEfS-cfRRSwvcm5hg_akXr287oDXQ=A@mail.gmail.com>
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io
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

On Thu, Jul 2, 2026 at 3:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:

> For Mediatek specifically, I am hoping to eventually upstream support
> for a load-only FIT (the spec supports it) so that you can load the DT
> from a firmware partition, then still boot the OS (without a DT). This
> works with FIT, but would need adjustment if the OS is actually an EFI
> app.
>
> I wrote a post about this challenge:
>
> https://www-concept.deinde.dev/blog/devicetree-in-firmware-or-packaged-wi=
th-the-os/

Well, this is convenient because your suggestion converges nicely with
where this work has gone since I posted the RFC (I was ready to send
out a V2 soon-ish).

v2 of this design replaces the environment-described file set with a
FIT manifest carried on the firmware partition itself: the FIT images
hold the base DTB and the overlays, and each FIT configuration names
one bootable combination through the standard 'fdt' property.

Not exactly sure what you mean with =E2=80=9Cload-only=E2=80=9D but there n=
o kernel in
it, the assembled devicetree is handed to the EFI app via the
configuration table.

v2 is implemented and validated on (my) hardware; I will post the
updated RFC shortly. Some of your comments below are already addressed
by it, noted inline.

> > The *location* is described in the control devicetree. The bootstd node=
 carries
> > a `firmware-fdt-source` phandle to a node that is a child of the media =
device
> > that owns the partition, and identifies the partition by GPT type UUID =
and/or
> > name:
> >
> >         bootstd {
> >                 compatible =3D "u-boot,boot-std";
> >                 firmware-fdt-source =3D <&fw_fdt>;
> >         };
> >
> >         &mmc0 {
> >                 fw_fdt: firmware-fdt {
> >                         compatible =3D "u-boot,firmware-fdt-block";
>
> Does the -block suffix indicate that it is a block device, rather than
> a filesystem? How does this cope with the fast where multiple DTs are
> provided for different models?

The suffix names the backend: this one is a block device with a GPT
partition holding a filesystem. It leaves room for sibling backends
later, e.g. an UBI/MTD variant for NOR-based boards, which some
MediaTek platforms would need. I will spell that out in the binding
text.

Multiple models are the manifest's job in v2: one FIT configuration
per model/SKU, so the per-model knowledge lives with the devicetrees
it describes and is updated atomically with them.

> >                         partition-type-uuid =3D "....";   /* GPT type U=
UID */
> >                         partition-name =3D "firmware";    /* optional *=
/
> >                         extra-size =3D <0x3000>;          /* overlay he=
adroom */
>
> This seems like a parameter which would be better handled by U-Boot itsel=
f?

Yup, and it is gone in v2.

> >   - the control DT describes the source and the partition policy;
> >   - the board default environment carries factory defaults for the stat=
ic values
> >     (`fdtfile` and `dtb_path` for the base DTB, and the `fdt_addr_r` /
> >     `fdtoverlay_addr_r` working addresses), so a from-source build boot=
s and
> >     `env default` restores a loadable configuration;
>
> I wish we could move away from filenames and use compatible strings
> instead, as FIT does - this is how the FDT spec is written.

v2 does this. 'fdtfile' and 'dtb_path' are gone leveraging
FIT_BEST_MATCH. The only filename left is the manifest container
itself (fdt.itb by default), which is a fixed convention (we can
change it of course, I don't have a strong imagination).

> > each installing the result through `efi_install_fdt()`. That is the con=
vergence
> > point all EFI launches pass through, so the firmware devicetree is inst=
alled
> > regardless of how the EFI application was started, including the boot-m=
anager
> > autoboot path that SystemReady IR uses.
>
> What if you run GRUB?

Not sure I 100% got this objection but it is not very special I guess,
the firmware devicetree is installed into the EFI configuration table
before the EFI app starts, GRUB does not touch it, and the kernel's
EFI stub picks it up
from the table (as long as GRUB does not install a different DTB at that po=
int).

> >   5. Should the signed-FIT verification be part of this series or a fol=
low-up?
>
> You likely get this for free, so I suggest including it.

Indeed, since now the manifest is a FIT.

I will post the v2 RFC as a follow-up to this thread.

thanks for the review,

--
Carlo Caione
