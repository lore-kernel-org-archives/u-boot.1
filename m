Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA325C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 11:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE0588746;
	Wed, 17 Jul 2024 13:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BsNHN08X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1058874C; Wed, 17 Jul 2024 13:00:06 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38533886E2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 13:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eea8ea8c06so93462841fa.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721214003; x=1721818803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YWTMmSPcCPKkwgDbmYJhy5qbzh7NJgH8RQ7Lw5H66k=;
 b=BsNHN08XXuIxG+aynQgcnLoccEntO3ErKfr6o0BTQ0AC/X3UhvfgTPcw2LGIlL51xi
 zwZhdwOWMveu7seJaZ4AZTJ3FkhzuBGfg3L4pHFe3TGSul/ia9Iydkgdd/lvxg7OEh4S
 Id7zXF+VOvPxD+dTZ0iCIHcx5ewN0yNUkDm5s4j9d9/mGDlIBEfqN8FqVDuj75yV/+uo
 P/xwhBPMgcw6rlK/3ofw/3od7S8BGw7NNd96Liv2p8kuF4TJujo7/+fJc1ylguXQT1Uz
 I2BMHfYr35f6reACgPlNVvSeZx3Tu9bKEtzo2806P+Y5InzHhoprlq1DPE1lqfGUedsb
 WZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721214003; x=1721818803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YWTMmSPcCPKkwgDbmYJhy5qbzh7NJgH8RQ7Lw5H66k=;
 b=Tvjg3fV+NOJgS9P4NlDdeUrsWuViA1mTkyHz75gnaOmOFvKncjy6Ut6ekBvA0N8k3g
 gU9hfoziLyhOLD67/6HFluZxLaaZ/DbNF9syHvdaDG84DeM1dWIE+56aNj3qn3UiXP/8
 n7k4iukuO4oGadwZeSCBeJqK3oUGteychEeK2s72QWrBme+36v7UKAyJq/K9rjuLQ4Ne
 711clKqbYGzbZB0cagjJrkhb0ffA3IL9poSHYOnu/MinBS827AN66IAu/JJjSbil3Zyl
 QZ/XclLEkTs8IQFP6/6kkKxpk3KVGH7+Whw7xt+I+FTtkLf1WlpfwAbj0eoRYQVhxmRh
 QaEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRoLM+goP6kaMN7bUIMSU9lCTA0Q8JyWCBQrGSkDKLHdDXftbTVIduwvsCYpQAVjg+7vMco3Rox6xYbh6lb3vQyZapRw==
X-Gm-Message-State: AOJu0YxdUFireGpVfJL3GqC5JEC3SGfaMhL/qvPwFzmKABxNs11cDPwy
 xJdD/924LS3OO9Myvn7vsuDm9C9KOV7i/TBnXPPjQ9U442DNSoOlgaB86zRq6Pr+DD1xLAyckyg
 LVpAMeGegRf+ec3hrSxP9yG+ivVo=
X-Google-Smtp-Source: AGHT+IGXhmqxCv/TildpXP4JF5f92iE9G4r4SPiYa9dMR2QXY/a6jCBRm0Ae5AfKd5iG21QnU8q2iK3vdTENbHoc95Q=
X-Received: by 2002:a2e:bc13:0:b0:2ee:8e6f:ae01 with SMTP id
 38308e7fff4ca-2eefd1e4959mr10247751fa.48.1721214002494; Wed, 17 Jul 2024
 04:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240716171602.2279766-1-walter.lozano@collabora.com>
 <20240716172113.GG561963@bill-the-cat>
In-Reply-To: <20240716172113.GG561963@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 17 Jul 2024 11:59:50 +0100
Message-ID: <CALeDE9PUF4-oCk+CXB0FiL=Haq9o0MkHa5BS4JTvZw7HbwjjaQ@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Update memory layout for Aarch64
To: Tom Rini <trini@konsulko.com>
Cc: Walter Lozano <walter.lozano@collabora.com>, u-boot@lists.denx.de, 
 Martyn Welch <martyn@collabora.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
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

On Tue, 16 Jul 2024 at 18:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 16, 2024 at 02:16:02PM -0300, Walter Lozano wrote:
>
> > ARM and Aarch64 have different restrictions and trying to accommodate
> > larger kernels like the ones used in distros can be challenging. For this
> > reason, separate the layout and rearrange the map for Aarch64 to support
> > kernels larger than 36 MB.
> >
> > Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> > ---
> >
> >  board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> > index 30228285edd..37c7f6a920e 100644
> > --- a/board/raspberrypi/rpi/rpi.env
> > +++ b/board/raspberrypi/rpi/rpi.env
> > @@ -42,13 +42,19 @@ dfu_alt_info+=zImage fat 0 1
> >   *   For Aarch64, the kernel image is uncompressed and must be loaded at
> >   *   text_offset bytes (specified in the header of the Image) into a 2MB
> >   *   boundary. The 'booti' command relocates the image if necessary. Linux uses
> > - *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> > - *   satisfies all these constraints and reserving memory up to 0x02400000
> > - *   permits fairly large (roughly 36M) kernels.
> > + *   a default text_offset of 0x80000.  However, loading it at 0x80000
> > + *   will allow to reserve only up to 0x02400000 which permits medium size
> > + *   kernels (roughly 36M). This is good enough for customized kernels but
> > + *   not for distros which by default enable drivers for many different
> > + *   boards. Under these circumstances, using 0x00200000 provides room for
> > + *   larger kernels.
> >   *
> >   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
> >   * conflict with something else. Reserving 1M for each of them at
> > - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> > + * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty for ARM.
> > + *
> > + *   For Aarch64, since the kernel is placed in different location,
> > + *   accommodate them to reserver 1M for each of them.
> >   *
> >   * On ARM, both the DTB and any possible initrd must be loaded such that they
> >   * fit inside the lowmem mapping in Linux. In practice, this usually means not
> > @@ -62,16 +68,21 @@ dfu_alt_info+=zImage fat 0 1
> >   * large initrds before they start colliding with U-Boot.
> >   */
> >  #ifdef CONFIG_ARM64
> > +pxefile_addr_r=0x00080000
> > +scriptaddr=0x00100000
> > +kernel_addr_r=0x00200000
> > +fdt_addr_r=0x03400000
> > +ramdisk_addr_r=0x03500000
> >  fdt_high=ffffffffffffffff
> >  initrd_high=ffffffffffffffff
> >  #else
> > -fdt_high=ffffffff
> > -initrd_high=ffffffff
> > -#endif
> >  kernel_addr_r=0x00080000
> >  scriptaddr=0x02400000
> >  pxefile_addr_r=0x02500000
> >  fdt_addr_r=0x02600000
> >  ramdisk_addr_r=0x02700000
> > +fdt_high=ffffffff
> > +initrd_high=ffffffff
> > +#endif
> >
> >  boot_targets=mmc usb pxe dhcp
>
> We need to drop the disabling of device tree / initrd relocation as
> that's sure not going to help matters. What's the minimum amount of
> memory an aarch64 Pi will have? I really prefer reserving 128MiB (even
> if that's not the maximum Linux Kernel Image size anymore) and then
> device tree and then initrd.

512Mb on the Zero2W and RPi3A.

We've not seen an issue here on the very large Fedora kernel, but I
suspect that's because using UEFI mitigates this somewhat because here
we're actually loading shim/grub.

Peter
