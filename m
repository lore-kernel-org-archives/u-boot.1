Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0224CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DB186A28;
	Sat, 23 Sep 2023 21:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RY+Cbq63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6161D86B09; Sat, 23 Sep 2023 21:53:42 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8A086A08
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c02e232c48so67553211fa.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498819; x=1696103619; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtszwVn3y6stsgCF5+pVd7T47c+gJ39tdRwf7lFPzRw=;
 b=RY+Cbq639b79NIlrfgrlQeHVtsxt9tPSllw0qARW3F3IT5i7JnjO2Fhcx9VPn1mJBh
 moA/TvMIAG1V1S4GsTGIhtDv7JNpoRS7auD6zRwTO3XFpRQ91BoLooC1EpT7vAQ/cCPI
 bsV5I2H6zRxZIl7VZoGqtdvKFD7YUAVf+bHhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498819; x=1696103619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtszwVn3y6stsgCF5+pVd7T47c+gJ39tdRwf7lFPzRw=;
 b=ebGxCWQVk4lg1bjd9Imzhx+wP02+7TSGaQIpVAr/Xi8gOfIrvKIeGDA0tWAk4q5JMd
 u1ADNy2aLzSVwKd4+LY4y7q7YO+g/TzCMLnOAjfPVk6n6IMsKRknbwHEvanWab+FT4/O
 GQ8xmRdpHxhoK2ZSwoiHavMIF3Usbw6kYAZT2ylZT51JkDeSJxqGTGb9u1vqlJMq1e15
 2aQ+R+ZA99jbKJj3N6025dOd3RBgNx3qpIyw6JmpwtJUwinUgdH4k8BYaSMvGx7HbHjn
 +5C+SoOsNuy30Yxw+5RINlIjwf00wd8/if18fvfw4VjyvuIywnjrxQ1S2Kq/kZC1OpqA
 /Qvg==
X-Gm-Message-State: AOJu0Yzw9pImMLLQAx35fnGto2vfFXiTrbP2jKzITedLcsAR4rqyUwRu
 XQJoW5NJ9IMKaQV7pAyDVECDrPKz6kb3M1jiAUgSUyeYlrftj3Eo2VE=
X-Google-Smtp-Source: AGHT+IE48Hh8beps8Ug319g2SrYWPr7BOPNd55bA9JBlkDVOPgUFC/3fc84gJLd4JCgx6PMfCDG+go4VBb1AxO8QBpY=
X-Received: by 2002:a2e:2c12:0:b0:2bf:fae0:5cef with SMTP id
 s18-20020a2e2c12000000b002bffae05cefmr2300226ljs.21.1695498819209; Sat, 23
 Sep 2023 12:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230405150458.890460-1-vincent.stehle@arm.com>
 <CAPnjgZ1PZJqLdRW691nCgtsTtxcvvQ-EbGpQTHhxRLpyGqeaAQ@mail.gmail.com>
 <ZC6ZTsF/P9bItCxb@debian>
 <CAPnjgZ2FkU_wKLd1djMdArvqPaX3-jvA=p-ZHbhnKgSpx+KULw@mail.gmail.com>
 <ZDVL2Ac7uz19ARzl@debian>
In-Reply-To: <ZDVL2Ac7uz19ARzl@debian>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 13:53:26 -0600
Message-ID: <CAPnjgZ0oQTuG4qT4ZFfDewzNOJriD0rAmYimJSU9va6GZxASbw@mail.gmail.com>
Subject: Re: [BUG] issues with new bootflow, uefi and virtio
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de
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

Hi Vincent,

On Tue, 11 Apr 2023 at 06:00, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> On Fri, Apr 07, 2023 at 05:31:06PM +1200, Simon Glass wrote:
> ..
> > > When combined with the patch from Mathew[1], it does indeed repair th=
e case of
> > > efi boot with two virtio disks, specifically when the first virtio di=
sk is the
> > > one we want to boot from.
> > > FWIW, the system will not boot when I invert the two virtio disks.
> >
> > Is this because it only uses the first virtio device? You could check
> > your boot_targets variable. With standard boot you can use 'virtio'
> > instead of 'vritio0' and it will find any virtio devices.
>
> Hi Simon,
>
> Thank you for the tips; I did not know that you could use a generic `virt=
io' or
> a more specific `virtio0' specification in boot_targets.
> By default the boot_targets variable does indeed contain the generic `vir=
tio' in
> my case.
>
> Quick tests matrix:
>
>                 disk image virtio
>                 (#num) blk index
>   boot_targets  (#30) 0  (#31) 1
>   ------------  -------  -------
>         virtio     ok      FAIL
>        virtio0     ok     (fail)
>        virtio1   (fail)     ok
>
> This is with both patches, on Qemu.
> The fails between () are expected.
>
> I find it interesting that specifying `virtio1' does work when the bootab=
le
> image is on the second virtio disk, while auto-detection with `virtio' do=
es not
> seem to:
>
>   virtio1
>   ~~~~~~~
>
>   =3D> setenv boot_targets virtio1
>   =3D> boot
>   Scanning for bootflows in all bootdevs
>   Seq Method State Uclass Part Name Filename
>   --- ------ ----- ------ ---- ---- --------
>   Scanning global bootmeth 'efi_mgr':
>   Scanning bootdev 'virtio-blk#31.bootdev':
>     0 efi    ready virtio    1 virtio-blk#31.bootdev.par efi/boot/bootaa6=
4.efi
>   ** Booting bootflow 'virtio-blk#31.bootdev.part_1' with efi
>   Using prior-stage device tree
>   Missing TPMv2 device for EFI_TCG_PROTOCOL
>   Booting /efi\boot\bootaa64.efi
>
>   virtio
>   ~~~~~~
>
>   =3D> setenv boot_targets virtio
>   =3D> boot
>   Scanning for bootflows in all bootdevs
>   Seq Method State Uclass Part Name Filename
>   --- ------ ----- ------ ---- ---- --------
>   Scanning global bootmeth 'efi_mgr':
>   Scanning bootdev 'virtio-blk#30.bootdev':
>   No more bootdevs
>   --- ------ ----- ------ ---- ---- --------
>   (0 bootflows, 0 valid)
>
> The messages seem to indicate that virtio #31 / 1 was not even considered=
 when
> specifying `virtio'.
> (Note that I have edited the logs a bit to avoid wrapping lines.)
>

Apart from the out-of-memory problem that has been fixed, there is
another problem that it only looks at the first of the virtio devices
when boot_targets=3D"virtio", as you have found.

I believe I have a fix for this so will send a patch.

Thank you for testing this.

Regards,
Simon



> Best regards,
> Vincent.
>
> >
> > >
> > > Best regards,
> > > Vincent.
> > >
> > > [1]: https://lists.denx.de/pipermail/u-boot/2023-April/514527.html
> >
> > Regards,
> > Simon
