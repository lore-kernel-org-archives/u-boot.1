Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E228E7D0DB
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B53863DE;
	Fri, 22 Sep 2023 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQeTyqDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70978863C8; Fri, 22 Sep 2023 09:19:40 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F4F8655F
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0F288B8225B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 07:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11D2C433C8
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695367176;
 bh=k1X30oImErY0if4gTFNiKk29lBEhdrsY4fdhPWJjGjA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YQeTyqDIUbCF+bD/z6S9hi6v89aKtXWnZHvuV5VxtnxHTxgNJP7UKzRHhaWT0H0eU
 mrjtf8z+qrK8bcRY5dSNFFIoiXUaofwiRDKQZWVvy0zd8bIkemCry/xUmN4hOjV2mU
 Pts5sxun1sHSwA/KQddiQ7EfiwPF9nHoicyjg6jJGXcyM9UdyhduQmHspOCyO8oww2
 le8pMLhQYbyManciI5k/9G9AYqRhefQQV4HiSrrkJpSnG60iqpPc3P3kkpZVLl86XJ
 P9IOs0ji213W7K/HkbS0IvCDK94AoTVbcdpKLy3H1McVi4LYi/AjtuZir2jq03r36S
 ekmRdfhp7M5Gg==
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-1dc89741cedso624386fac.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:19:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzbmnukg4QSCC+rHSGTsx/tJ3V+l12v2CzAsvI8N4BBjVReNV8N
 ogBRjxbOwtkvWePn5m6kmbIBWcwR/n3j+RVe+Es=
X-Google-Smtp-Source: AGHT+IHbKTG4ojHQDEcNvsKHozisvvERsdukq28wMSJPsfPl28LUjV3E2CeBOycdco+KDSmF/GIs5kKn+xcIxueFumw=
X-Received: by 2002:a05:6870:2155:b0:1d0:eaa6:82cd with SMTP id
 g21-20020a056870215500b001d0eaa682cdmr8686164oae.25.1695367176137; Fri, 22
 Sep 2023 00:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
In-Reply-To: <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Sep 2023 16:18:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
Message-ID: <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
Subject: Re: [Question] TI's u-boot.img is built twice
To: Neha Malcom Francis <n-francis@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, srk@ti.com, 
 s-vadapalli@ti.com, m-chawdhry@ti.com
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

On Fri, Sep 22, 2023 at 2:27=E2=80=AFPM Neha Malcom Francis <n-francis@ti.c=
om> wrote:
>
> Hi Masahiro
>
> On 21/09/23 21:06, Masahiro Yamada wrote:
> > Hi.
> >
> > Since the TI platform migrated to binman,
> > u-boot.img is built twice.
> >
> > It is created by "mkimage -E",
> > then overwritten by binman.
> >
> >
> > So, the data are embedded in the FIT structure
> > instead of being appended.
> >
> > Is this intentional?
> >
> > To me, it looks weird.
> >
> >
>
> I haven't added the fit,external-offset property in the binman.dtsi so it=
 was
> not appended as external data and I did not find reason to. Is there any =
benefit
> in having the data appended than embedded?



Placing payload data outside the FIT structure is a U-Boot hack.


The motivation was explained in the commit log of
722ebc8f84d5bccd2e70fad1079a0dd40cceddec



Before TI migrated to binman,
u-boot.img was the "payload outside" structure
but it is not any more.

I do not mind the implementation details as long as
U-Boot is able to boot the Linux kernel.


I was just suffering from the AM64-SK boot failure
(as I asked in another thread) and just noticed
something odd when I was poking the SPL code.


At least, .u-boot.img.cmd is not telling the truth.

Usually, the build command is saved in a *.cmd file
but this does not reflect the reality, because
it is binman that created the final u-boot.img


$ cat .u-boot.img.cmd
cmd_u-boot.img :=3D ./tools/mkimage -f auto -A arm -T firmware -C none
-O u-boot -a 0x80800000 -e 0x80800000 -p 0x0 -n "U-Boot
2023.10-rc4-00047-gb9b83a86f0-dirty for am64x board" -E  -b
arch/arm/dts/k3-am642-evm.dtb -b arch/arm/dts/k3-am642-sk.dtb  -d
u-boot-nodtb.bin u-boot.img >/dev/null


I will not track it down any further, though.
It is too complicated.






> >
> >
> > To confirm it, apply the following hack.
> >
> > Since u-boot.img is overwritten by binman,
> > copy it to u-boot.img.backup.
> >
> >
> >
> >
> > diff --git a/Makefile b/Makefile
> > index 87f9fc786e..4cffa8a061 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1112,6 +1112,7 @@ endef
> >   # Timestamp file to make sure that binman always runs
> >   .binman_stamp: $(INPUTS-y) FORCE
> >   ifeq ($(CONFIG_BINMAN),y)
> > +       cp u-boot.img u-boot.img.backup
> >          $(call if_changed,binman)
> >   endif
> >          @touch $@
> >
> >
> >
> > Then, build it for the main core.
> >
> >
> > make -j$(nproc) CROSS_COMPILE=3Daarch64-linux-gnu-
> >     am64x_evm_a53_defconfig all
> >     TEE=3D~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
> >     BL31=3D~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
> >     BINMAN_INDIRS=3D~/ref/ti-linux-firmware
> >
> >
> >
> >
> > Compare the two files.
> > Run fdtdump to see what happened to them.
> >
> >
> > $ diff -u u-boot.img  u-boot.img.backup
> > Binary files u-boot.img and u-boot.img.backup differ
> >
> >
> > $ fdtdump u-boot.img
> >      =3D> u-boot and dt are embedded.
> >
> > $ fdtdump u-boot.img.backup
> >      =3D> u-boot and dt are appended after the
> >         FIT structure
> >
> >
> >
>
> --
> Thanking You
> Neha Malcom Francis



--=20
Best Regards
Masahiro Yamada
