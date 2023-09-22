Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3177CD4F46
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 09:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2775386504;
	Fri, 22 Sep 2023 11:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UyxjQLyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B7C86660; Fri, 22 Sep 2023 11:49:42 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0529863F8
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 0D2BDCE1D2D
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401CBC433C9
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695376175;
 bh=4Uy1GTAMwg0r2eKZrwAmBVYM9bWyCBsnlsIqtJl/VA0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UyxjQLyoqtsokhDK0Cj6VlXGzJUMWvqRn9w6gWdwxG1dHHX5L8TVtYydzXUojoGSd
 PcFPMTPde6VJTuk0u8yLbexCAsYuQ8Res1SS0dDihbKdRZDDAZv0e4RYxmYOe+m7sj
 ncbMZAv1t1Oritkn3ThijZ0y50vvmZA9xbNDWVUv2OLIhiBTdk9kQCefhvA9xaDurr
 gSp5V2GRQLl7EDPnndTzuhVU65tU4W40KdeTXAqNSmz0vuy5Q89aqOusGaLVShBq11
 qyBSVrYpOoO2NygzdxAjDweo5HH4EdJ5vDfFgRqiPirzHOOlN9CJEi04y9SChiIHC2
 rpVIwuiACKWhg==
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-3ae214a077cso139971b6e.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 02:49:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhsX5C5k9nG9q428d0w01FnEhmRIkEFqOLIedsWDPPI5FwklF7
 2ovFL2Ee2PxnnhnUwc3S/siZ4SRDj94SfGyvlYg=
X-Google-Smtp-Source: AGHT+IFhwsQqmgkgjONh8y1iDHEnPyTwHwiQRDx5QfqVMhxNk6oW7a53ScVT0bc027AqXAZcdeeFlHqlb8r58EGnleo=
X-Received: by 2002:a05:6870:2109:b0:1c0:d0e8:8ff0 with SMTP id
 f9-20020a056870210900b001c0d0e88ff0mr9385547oae.17.1695376174607; Fri, 22 Sep
 2023 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
 <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
 <93be618e-b095-32f6-9bc6-e1bb5d8c24e6@ti.com>
In-Reply-To: <93be618e-b095-32f6-9bc6-e1bb5d8c24e6@ti.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Sep 2023 18:48:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQT-WxXT-PaoDPw-8iVXdn1prkTfnovM9DqkB7UWen_BA@mail.gmail.com>
Message-ID: <CAK7LNAQT-WxXT-PaoDPw-8iVXdn1prkTfnovM9DqkB7UWen_BA@mail.gmail.com>
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

On Fri, Sep 22, 2023 at 5:04=E2=80=AFPM Neha Malcom Francis <n-francis@ti.c=
om> wrote:
>
> Hi Masahiro
>
> On 22/09/23 12:48, Masahiro Yamada wrote:
> > On Fri, Sep 22, 2023 at 2:27=E2=80=AFPM Neha Malcom Francis <n-francis@=
ti.com> wrote:
> >>
> >> Hi Masahiro
> >>
> >> On 21/09/23 21:06, Masahiro Yamada wrote:
> >>> Hi.
> >>>
> >>> Since the TI platform migrated to binman,
> >>> u-boot.img is built twice.
> >>>
> >>> It is created by "mkimage -E",
> >>> then overwritten by binman.
> >>>
> >>>
> >>> So, the data are embedded in the FIT structure
> >>> instead of being appended.
> >>>
> >>> Is this intentional?
> >>>
> >>> To me, it looks weird.
> >>>
> >>>
> >>
> >> I haven't added the fit,external-offset property in the binman.dtsi so=
 it was
> >> not appended as external data and I did not find reason to. Is there a=
ny benefit
> >> in having the data appended than embedded?
> >
> >
> >
> > Placing payload data outside the FIT structure is a U-Boot hack.
> >
> >
> > The motivation was explained in the commit log of
> > 722ebc8f84d5bccd2e70fad1079a0dd40cceddec
> >
> >
>
> Thanks for this! Makes sense, I think we should make it appended again in
> binman. Can reduce boot time.
> >
> > Before TI migrated to binman,
> > u-boot.img was the "payload outside" structure
> > but it is not any more.
> >
> > I do not mind the implementation details as long as
> > U-Boot is able to boot the Linux kernel.
> >
> >
> > I was just suffering from the AM64-SK boot failure
> > (as I asked in another thread) and just noticed
> > something odd when I was poking the SPL code.
> >
> >
> > At least, .u-boot.img.cmd is not telling the truth.
> >
> > Usually, the build command is saved in a *.cmd file
> > but this does not reflect the reality, because
> > it is binman that created the final u-boot.img
> >
> >
> > $ cat .u-boot.img.cmd
> > cmd_u-boot.img :=3D ./tools/mkimage -f auto -A arm -T firmware -C none
> > -O u-boot -a 0x80800000 -e 0x80800000 -p 0x0 -n "U-Boot
> > 2023.10-rc4-00047-gb9b83a86f0-dirty for am64x board" -E  -b
> > arch/arm/dts/k3-am642-evm.dtb -b arch/arm/dts/k3-am642-sk.dtb  -d
> > u-boot-nodtb.bin u-boot.img >/dev/null
> >
> >
> > I will not track it down any further, though.
> > It is too complicated.
> >
> >
> >
>
> I am not too sure about the .cmd files but looks like its misleading prob=
ably
> because the replacing of the binman generated image takes under cmd_binma=
n and
> not directly from the Makefile (just a guess).



From my view as a user, building images without k3-image-gen
seems like a benefit, but binman is not mandatory for u-boot.img.

With line 255-339 of arch/arm/dts/k3-am64x-binman.dtsi deleted,
u-boot.img was still generated in the same structure as before.
(payload appended)


The confusion came from u-boot.img being first created by
line 1439 of the top Makefile  (mkimage),
then overwritten by line 1113 (binman).

If you use binman for u-boot.img, the line 1439 does not need to run,
but it runs because u-boot.img is added to INPUTS-y.


Perhaps, you may want to hack line 978 because
IMX is doing something there.


ifeq ($(CONFIG_MX7)$(CONFIG_IMX_HAB), yy)
INPUTS-$(CONFIG_SPL_FRAMEWORK) +=3D u-boot-ivt.img
else
INPUTS-$(CONFIG_SPL_FRAMEWORK) +=3D u-boot.img
endif





For the *.cmd files, the mkimage command is
saved in .u-boot.img.cmd and the binman command
is saved in ..binman_stamp.cmd




$ cat  .u-boot.img.cmd
cmd_u-boot.img :=3D ./tools/mkimage -f auto -A arm -T firmware -C none
-O u-boot -a 0x80800000 -e 0x80800000 -p 0x0 -n "U-Boot
2023.10-rc4-00047-gb9b83a86f0-dirty for am64x board" -E  -b
arch/arm/dts/k3-am642-evm.dtb -b arch/arm/dts/k3-am642-sk.dtb  -d
u-boot-nodtb.bin u-boot.img >/dev/null

$ cat ..binman_stamp.cmd
cmd_.binman_stamp :=3D ./tools/binman/binman   --toolpath ./tools  build
-u -d u-boot.dtb -O . -m --allow-missing  -I . -I . -I
./board/ti/am64x -I arch/arm/dts -a of-list=3D"k3-am642-evm k3-am642-sk"
-I /home/masahiro/ref/ti-linux-firmware -a
atf-bl31-path=3D/home/masahiro/ref/trusted-firmware-a/build/k3/lite/release=
/bl31.bin
-a tee-os-path=3D/home/masahiro/ref/OP-TEE/optee_os/out/arm-plat-k3/core/te=
e-raw.bin
-a opensbi-path=3D -a default-dt=3D"k3-am642-evm" -a scp-path=3D -a
rockchip-tpl-path=3D -a spl-bss-pad=3D -a tpl-bss-pad=3D1 -a spl-dtb=3Dy -a
tpl-dtb=3D -a pre-load-key-path=3D






--
Best Regards
Masahiro Yamada
