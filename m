Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3BC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED5687901;
	Mon, 23 Oct 2023 15:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ShCN0Rlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5DF87902; Mon, 23 Oct 2023 15:16:29 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E4EF878AC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7789cb322deso233341785a.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698066986; x=1698671786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VmjJHnaubfVbKEJGl85a7Rotx9i09TdDkmbRSJa1d5o=;
 b=ShCN0RlunsvVCdVNj1oe0xfIicA+MHRLLf4h6HP+/4T2YszMCTC5IuFbKX8kVihIzS
 wFX1nlpyW6x2EfQSpJbJwQVaj9cRSxa9rhCFsuPyrU156kDyIUVE1gEdLgRBCLyFWBlL
 mMMMusOHIjDAJW2LYsHLcOrJlCQ4DwDmSZ84c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698066986; x=1698671786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmjJHnaubfVbKEJGl85a7Rotx9i09TdDkmbRSJa1d5o=;
 b=rdeYuGuT+A6OrXXTw9lF8qFtu/ZT47ThcsR40O1BtGWE818SrK1klxaJ466ex5UC/d
 7ZstSt/8Mbg2MAAnFeOzIxnSxC6hlBfTvLlaGcI4NsYDstnb8nTFbVjG/SFwQFxncUQO
 BklsR84bG124y0Zd/QBq8z6+GGbVm7ISK9RSbVB6OJMOsTqdvxblBcOdDDRMirWT0VQV
 nO7Wbv1j/staotCye6/74hxxOzt8t3eZBH03+gTnAPuOSgFXj45ctJ8I4OX17W0RZr9T
 jHtNbWWhTA6WULdiIjREzfYOa+Qkqsviv/EgP7W3eyMdtfGMrjXZJ4UlQmJCWE4Hcq+X
 fmNQ==
X-Gm-Message-State: AOJu0YyZk+pJmHSEOw1605+aV3n2/9OSSjSZBywrMyrBzq2milbr587r
 RkPRfyI5o4/3VbBzam2lenctjA==
X-Google-Smtp-Source: AGHT+IGFD6Iu4ifZZsMG8lu9WsDNqRcBN1X7V6EdR0vQxSEvPcRdHab4dWPglM64oIPMGQX9EL8LcA==
X-Received: by 2002:a05:620a:28d6:b0:779:d4ef:5f1f with SMTP id
 l22-20020a05620a28d600b00779d4ef5f1fmr3578142qkp.29.1698066985642; 
 Mon, 23 Oct 2023 06:16:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 pj16-20020a05620a1d9000b00774830b40d4sm2705709qkn.47.2023.10.23.06.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:16:25 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:16:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231023131623.GG496310@bill-the-cat>
References: <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat>
 <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
 <20231022234507.GE496310@bill-the-cat>
 <CAPnjgZ14he2OtnvfEXsbN1FxGz34twDwAMROM=61kcOJpGvDXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WKRXK5v7DS7zsp+O"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ14he2OtnvfEXsbN1FxGz34twDwAMROM=61kcOJpGvDXw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--WKRXK5v7DS7zsp+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:05:28AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 22 Oct 2023 at 16:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 22, 2023 at 02:55:32PM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wro=
te:
> > > > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wro=
te:
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > >
> > > > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypr=
on.glpk@gmx.de> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and a=
ssumes that Ethernet is
> > > > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > (no changes since v2)
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > - Add new patch to update EFI_LOADER to depend on=
 DM_ETH
> > > > > > > > > > > > >
> > > > > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loa=
der/Kconfig
> > > > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_3=
2 with EFI_STUB
> > > > > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || E=
FI_STUB_32BIT
> > > > > > > > > > > > >       depends on BLK
> > > > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > > > > >       default y if !ARM || SYS_CPU =3D armv7 || S=
YS_CPU =3D armv8
> > > > > > > > > > > > >       select CHARSET
> > > > > > > > > > > >
> > > > > > > > > > > > Does this work for you Heinrich, or do you want to =
clarify the
> > > > > > > > > > > > dependencies (and re-organize the code as needed) a=
round networking?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > We should be able to boot via EFI on devices without =
U-Boot network support.
> > > > > > > > > > >
> > > > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid=
 invoking
> > > > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVIC=
ES=3Dy selects
> > > > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > > > >
> > > > > > > > > > > Why is this not sufficient?
> > > > > > > > > > > Is there a configuration that does not build?
> > > > > > > > > >
> > > > > > > > > > The point of this series is to disable CMDLINE and fix =
up what breaks.
> > > > > > > > > >
> > > > > > > > > > In this case we have some sort of breakage...perhaps To=
m has already
> > > > > > > > > > found it, but otherwise could you take a look?
> > > > > > > > > >
> > > > > > > > > > We should be able to disable NET and LTO in sandbox and=
 still build.
> > > > > > > > > > But this fails at present[1]. You can try it on -master
> > > > > > > > >
> > > > > > > > > Obviously, it would be necessary to enclose efi_dp_from_e=
th()
> > > > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > > > >
> > > > > > > > Strange that it only happens on the non-LTO board, though?
> > > > > > >
> > > > > > > There's two issues. The first of which is that I think you ne=
ed to
> > > > > > > re-check your error exactly? With my series, and LTO also dis=
abled the
> > > > > > > problem is a call to efi_get_image_parameters() as that's def=
ined in
> > > > > > > cmd/bootefi.c, but also only used with cmdline invocations. S=
o we can
> > > > > > > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG=
_CMDLINE)
> > > > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > > > >
> > > > > > > The second issue is that with LTO we more completely find the=
 cases
> > > > > > > where if x() calls y() and y() is undefined but nothing calls=
 x() we can
> > > > > > > just discard x() and not care that y() is undefined.
> > > > > > >
> > > > > >
> > > > > > I will send a patch for function efi_dp_from_eth().
> > > > >
> > > > > There's no problem with efi_dp_from_eth as far as I can tell.
> > > > >
> > > > > > @Simon
> > > > > >
> > > > > > One thing that I don't understand is why we don't let the linker
> > > > > > eliminate the unused functions on the sandbox.
> > > > > >
> > > > > > On other architectures we put each function into a separate tex=
t section
> > > > > > and let the linker eliminate the unused text sections:
> > > > > >
> > > > > > arch/riscv/config.mk:29:
> > > > > > PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -f=
data-sections
> > > > > > LDFLAGS_u-boot          +=3D --gc-sections -static -pie
> > > > > >
> > > > > > Shouldn't we keep the sandbox close to what other architectures=
 do?
> > > > >
> > > > > Oh my, I didn't realize that sandbox was missing the garbage coll=
ection
> > > > > stuff.  Yes, that needs to be fixed first, then we can see what's=
 next
> > > > > to change, as there are some issues (my series first fixed CMDLIN=
E=3Dn on
> > > > > qemu_arm64).
> > > >
> > > > My super quick pass at enabling
> > > > function-sections/data-sections/gc-sections shows there's nothing
> > > > further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even the=
 part I
> > > > was looking at before.
> > >
> > > I am not sure about the original reason, but sandbox probably
> > > pre-dates wholesale enabling of gc-sections (I haven't looked). There
> > > is also the issue of whether the host toolchain supports it. Sandbox
> > > is supposed to run on a variety of OS types.
> >
> > It doesn't predate gc-sections, we've just never moved it to the
> > top-level Makefiles (and disabled on LTO) like we should have a long
> > time ago.  It's supported by all the compilers we support, and it's a
> > required feature (or, LTO) for U-Boot.
>=20
> Remember that the sandbox linker script is special in that it adds to
> the existing default one provided by the toolchain

Yes, and we've also been using gc-sections since 2008, from a quick look
at the logs.

> > > I am also not sure of the point ot it...since it is normally pretty
> > > easy to use Kconfig to control features.
> >
> > That's not the point of the feature.  The point is that we can discard
> > unused code without having to rely on #ifdef and __maybe_unused.
>=20
> That doesn't match with my understanding. An unused static will still
> produce a warning if it is unused.

Yes, you're misunderstanding how this feature works and why it's
required.  With v4 of my series, on sandbox and CMDLINE=3Dn and LTO=3Dn:
/usr/bin/ld: boot/scene_textline.o: in function `scene_textline_send_key':
/home/trini/work/u-boot/u-boot/boot/scene_textline.c:157: undefined referen=
ce to `cread_line_process_ch'
/usr/bin/ld: boot/scene_textline.o: in function `scene_textline_open':
/home/trini/work/u-boot/u-boot/boot/scene_textline.c:222: undefined referen=
ce to `cli_cread_init'
/usr/bin/ld: common/bootstage.o: in function `bootstage_fdt_add_report':
/home/trini/work/u-boot/u-boot/common/bootstage.c:323: undefined reference =
to `working_fdt'
/usr/bin/ld: common/cli.o: in function `run_commandf':
/home/trini/work/u-boot/u-boot/common/cli.c:154: undefined reference to `ru=
n_command'
/usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
/home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefined =
reference to `run_command'
/usr/bin/ld: drivers/fastboot/fb_command.o: in function `fastboot_acmd_comp=
lete':
/home/trini/work/u-boot/u-boot/drivers/fastboot/fb_command.c:350: undefined=
 reference to `run_command'
/usr/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_nam=
e':
/home/trini/work/u-boot/u-boot/lib/efi_loader/efi_device_path.c:1095: undef=
ined reference to `efi_get_image_parameters'
/usr/bin/ld: net/net.o: in function `net_auto_load':
/home/trini/work/u-boot/u-boot/net/net.c:349: undefined reference to `tftp_=
start'
collect2: error: ld returned 1 exit status

And with re-enabling gc-sections:
/usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
/home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefined =
reference to `run_command'
collect2: error: ld returned 1 exit status

Because all of those other link failures are in unreachable code and the
rest of the code base is already setup to know that x() can call y() and
y() can just be undefined at link time if x() is never called and ends
up discarded.

I honestly didn't realize sandbox hadn't had this critical feature
enabled and I hope we haven't been doing too many odd shuffles of the
codebase because of it.

--=20
Tom

--WKRXK5v7DS7zsp+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2ciQACgkQFHw5/5Y0
tyw2tgv/WP4E98JGLy2Os2rFaGMA3mDbEUzferH403Vw+Y4cLbYF2E5o9oZvzSxs
tuHsc5QPd6RX6t6QKn831grVfxL24MuAGzOt4jkAgAsh3u9i0TmZT4zAnOrDRsHM
9LNAgxkB72svm288vIqS3um3PhtWq6sk2YSHUhWjPgLkSxynMn+IsstqqklxMkmK
43NbIgFuVKW02CAKJzkjVyxbsPSGlxHx9lLk51PMiXkzDzkp7FXqHCvDLY0hHwx3
VC+pHJ4hJAZ44MDmF5n8IKhQhMLRj1WrnDtqfdW4BbuBEOij8NyVSngikhT3ib9j
RNiticeAv5fvc4GAv0taDbMLAqAJg8N+cvfTlv3QA0O7MlTEBzv2Bm97HDsCKGjq
veMa0SUpQeR2ZDSUWN4RbM5e5ThIBkoE0YJMaguHCLipH8IGq2qTPevbAozfM0qX
nuPZ5jas2FCGhFk+NjThP6sRdzi5rKBSQz8hSoBOQSirgU7kGoq+jgJndqEb01Xs
/xPfUscS
=wZBK
-----END PGP SIGNATURE-----

--WKRXK5v7DS7zsp+O--
