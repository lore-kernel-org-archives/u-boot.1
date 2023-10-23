Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47D8C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF18586FED;
	Mon, 23 Oct 2023 19:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oor8JeTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9915E86F44; Mon, 23 Oct 2023 19:45:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9910876EF
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a8628e54d4so30171717b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698083130; x=1698687930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IsikrwVFr9mvBDAkYlMQwteu5ewj1HA5vz5Am2jwNTA=;
 b=Oor8JeTGqzNzBEzd0O27izWKRUpFvAP4axnP1RTb2J3Dxdaeo8PptxrVcWIGaqVydK
 Qe1MOYS60qlvSviTkl7PiIMQqAsxYoGtUC9IKs2ogO1XyOq30p4Qo1OiJCBhjSikJAJt
 tEQWE0qvojawkVHZJsUWReH73KBnzKk31o5GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698083130; x=1698687930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsikrwVFr9mvBDAkYlMQwteu5ewj1HA5vz5Am2jwNTA=;
 b=jNbI1a3TlO8/1ijOaBgIU5voK12bYYtfMnzCdW30DEIyrTTuf5zfMCRhcjS7Yp9wLF
 swNRocFmIPykUQoPa5qUn5c5W0qDFw1CAYSXbx5o/jtk9PCuYgmpNcy2XSqT4hVXdZR8
 KaBHGW0TcEwWFid8G8M4kLAA2oXu14nVPmwWW+JRYJAFav79wAfL1QL301MP/VTQSs2k
 lEAxjQdZsPgevPN5dPyr1W860TokfKSyY1OiMtcfJihdTSyUtA08OPlN/XzhwhvacLmj
 MipWihWfKlfvsypqrt25ZOMbBeYBVeuk2iqe2PGrbKc9VuwBSlszMkPbxOXwep7os70G
 4XeQ==
X-Gm-Message-State: AOJu0YxSFcIT4Y9kOid2dytUauNaLUCccshGt7JIlkwsOx5nBurAuwVh
 01YnBBqXR6H4OGhZeaHr4zRsggSyJtucZ+4tAWWuDg==
X-Google-Smtp-Source: AGHT+IEhxb6Knq0/qYFzdFDgok4xKoJlBzLlLy/REqUVNGjuHsUu+3v6umF5qd69zmAc7OSmnRuh7A==
X-Received: by 2002:a0d:eb4a:0:b0:5a8:1767:1fef with SMTP id
 u71-20020a0deb4a000000b005a817671fefmr9971736ywe.9.1698083130301; 
 Mon, 23 Oct 2023 10:45:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 j63-20020a0df942000000b0059bcadded9dsm3303980ywf.116.2023.10.23.10.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 10:45:29 -0700 (PDT)
Date: Mon, 23 Oct 2023 13:45:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231023174527.GW496310@bill-the-cat>
References: <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat>
 <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
 <20231022234507.GE496310@bill-the-cat>
 <CAPnjgZ14he2OtnvfEXsbN1FxGz34twDwAMROM=61kcOJpGvDXw@mail.gmail.com>
 <20231023131623.GG496310@bill-the-cat>
 <CAPnjgZ1x7PyTe=nr5jguRjLbCeKqEBsV8EpQ-yC=sAx_bwt0SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zRPMSCsYf9uem8iX"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1x7PyTe=nr5jguRjLbCeKqEBsV8EpQ-yC=sAx_bwt0SA@mail.gmail.com>
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


--zRPMSCsYf9uem8iX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:13:54AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 23 Oct 2023 at 06:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 12:05:28AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 22 Oct 2023 at 16:45, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Oct 22, 2023 at 02:55:32PM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > > > > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt=
 wrote:
> > > > > > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <=
xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon=
 Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() a=
nd assumes that Ethernet is
> > > > > > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > (no changes since v2)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > - Add new patch to update EFI_LOADER to depen=
d on DM_ETH
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi=
_loader/Kconfig
> > > > > > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x=
86_32 with EFI_STUB
> > > > > > > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 =
|| EFI_STUB_32BIT
> > > > > > > > > > > > > > >       depends on BLK
> > > > > > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > > > > > > >       default y if !ARM || SYS_CPU =3D armv7 =
|| SYS_CPU =3D armv8
> > > > > > > > > > > > > > >       select CHARSET
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Does this work for you Heinrich, or do you want=
 to clarify the
> > > > > > > > > > > > > > dependencies (and re-organize the code as neede=
d) around networking?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > We should be able to boot via EFI on devices with=
out U-Boot network support.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to a=
void invoking
> > > > > > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETD=
EVICES=3Dy selects
> > > > > > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Why is this not sufficient?
> > > > > > > > > > > > > Is there a configuration that does not build?
> > > > > > > > > > > >
> > > > > > > > > > > > The point of this series is to disable CMDLINE and =
fix up what breaks.
> > > > > > > > > > > >
> > > > > > > > > > > > In this case we have some sort of breakage...perhap=
s Tom has already
> > > > > > > > > > > > found it, but otherwise could you take a look?
> > > > > > > > > > > >
> > > > > > > > > > > > We should be able to disable NET and LTO in sandbox=
 and still build.
> > > > > > > > > > > > But this fails at present[1]. You can try it on -ma=
ster
> > > > > > > > > > >
> > > > > > > > > > > Obviously, it would be necessary to enclose efi_dp_fr=
om_eth()
> > > > > > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > > > > > >
> > > > > > > > > > Strange that it only happens on the non-LTO board, thou=
gh?
> > > > > > > > >
> > > > > > > > > There's two issues. The first of which is that I think yo=
u need to
> > > > > > > > > re-check your error exactly? With my series, and LTO also=
 disabled the
> > > > > > > > > problem is a call to efi_get_image_parameters() as that's=
 defined in
> > > > > > > > > cmd/bootefi.c, but also only used with cmdline invocation=
s. So we can
> > > > > > > > > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CO=
NFIG_CMDLINE)
> > > > > > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > > > > > >
> > > > > > > > > The second issue is that with LTO we more completely find=
 the cases
> > > > > > > > > where if x() calls y() and y() is undefined but nothing c=
alls x() we can
> > > > > > > > > just discard x() and not care that y() is undefined.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I will send a patch for function efi_dp_from_eth().
> > > > > > >
> > > > > > > There's no problem with efi_dp_from_eth as far as I can tell.
> > > > > > >
> > > > > > > > @Simon
> > > > > > > >
> > > > > > > > One thing that I don't understand is why we don't let the l=
inker
> > > > > > > > eliminate the unused functions on the sandbox.
> > > > > > > >
> > > > > > > > On other architectures we put each function into a separate=
 text section
> > > > > > > > and let the linker eliminate the unused text sections:
> > > > > > > >
> > > > > > > > arch/riscv/config.mk:29:
> > > > > > > > PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-section=
s -fdata-sections
> > > > > > > > LDFLAGS_u-boot          +=3D --gc-sections -static -pie
> > > > > > > >
> > > > > > > > Shouldn't we keep the sandbox close to what other architect=
ures do?
> > > > > > >
> > > > > > > Oh my, I didn't realize that sandbox was missing the garbage =
collection
> > > > > > > stuff.  Yes, that needs to be fixed first, then we can see wh=
at's next
> > > > > > > to change, as there are some issues (my series first fixed CM=
DLINE=3Dn on
> > > > > > > qemu_arm64).
> > > > > >
> > > > > > My super quick pass at enabling
> > > > > > function-sections/data-sections/gc-sections shows there's nothi=
ng
> > > > > > further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even=
 the part I
> > > > > > was looking at before.
> > > > >
> > > > > I am not sure about the original reason, but sandbox probably
> > > > > pre-dates wholesale enabling of gc-sections (I haven't looked). T=
here
> > > > > is also the issue of whether the host toolchain supports it. Sand=
box
> > > > > is supposed to run on a variety of OS types.
> > > >
> > > > It doesn't predate gc-sections, we've just never moved it to the
> > > > top-level Makefiles (and disabled on LTO) like we should have a long
> > > > time ago.  It's supported by all the compilers we support, and it's=
 a
> > > > required feature (or, LTO) for U-Boot.
> > >
> > > Remember that the sandbox linker script is special in that it adds to
> > > the existing default one provided by the toolchain
> >
> > Yes, and we've also been using gc-sections since 2008, from a quick look
> > at the logs.
>=20
> Right, I just mean that sandbox does not use a standalone linker
> script.

Yes it does, arch/sandbox/cpu/u-boot.lds.

> It is not common to garbage-collect sections in executables,
> so far as I know.

I'm not sure how that's relevant here, honestly. And we didn't ask the
toolchain community to invent this for us, it's a standard feature that
we've found helpful for a number of reasons.

> > > > > I am also not sure of the point ot it...since it is normally pret=
ty
> > > > > easy to use Kconfig to control features.
> > > >
> > > > That's not the point of the feature.  The point is that we can disc=
ard
> > > > unused code without having to rely on #ifdef and __maybe_unused.
> > >
> > > That doesn't match with my understanding. An unused static will still
> > > produce a warning if it is unused.
> >
> > Yes, you're misunderstanding how this feature works and why it's
> > required.  With v4 of my series, on sandbox and CMDLINE=3Dn and LTO=3Dn:
> > /usr/bin/ld: boot/scene_textline.o: in function `scene_textline_send_ke=
y':
> > /home/trini/work/u-boot/u-boot/boot/scene_textline.c:157: undefined ref=
erence to `cread_line_process_ch'
> > /usr/bin/ld: boot/scene_textline.o: in function `scene_textline_open':
> > /home/trini/work/u-boot/u-boot/boot/scene_textline.c:222: undefined ref=
erence to `cli_cread_init'
> > /usr/bin/ld: common/bootstage.o: in function `bootstage_fdt_add_report':
> > /home/trini/work/u-boot/u-boot/common/bootstage.c:323: undefined refere=
nce to `working_fdt'
> > /usr/bin/ld: common/cli.o: in function `run_commandf':
> > /home/trini/work/u-boot/u-boot/common/cli.c:154: undefined reference to=
 `run_command'
> > /usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
> > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefi=
ned reference to `run_command'
> > /usr/bin/ld: drivers/fastboot/fb_command.o: in function `fastboot_acmd_=
complete':
> > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_command.c:350: undef=
ined reference to `run_command'
> > /usr/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from=
_name':
> > /home/trini/work/u-boot/u-boot/lib/efi_loader/efi_device_path.c:1095: u=
ndefined reference to `efi_get_image_parameters'
> > /usr/bin/ld: net/net.o: in function `net_auto_load':
> > /home/trini/work/u-boot/u-boot/net/net.c:349: undefined reference to `t=
ftp_start'
> > collect2: error: ld returned 1 exit status
> >
> > And with re-enabling gc-sections:
> > /usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
> > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefi=
ned reference to `run_command'
> > collect2: error: ld returned 1 exit status
> >
> > Because all of those other link failures are in unreachable code and the
> > rest of the code base is already setup to know that x() can call y() and
> > y() can just be undefined at link time if x() is never called and ends
> > up discarded.
>=20
> All of those problems were corrected by my series. Perhaps that
> accounts for the difference between them?

All of these are not real problems at this point in time is my point.

> Just to take one example, working_fdt, while it might seem convenient
> to leave it in cmd/fdt.c it doesn't actually make sense, since the var
> is set when booting. Without that var DT fixups can't happen. So why
> not pick up my patch that moves it to boot/fdt_support.c where it
> belongs?

And the issue is that when the command line is disabled NOTHING uses
"working_fdt". We don't need it. It would be discarded by real
platforms, if we moved it.

To rephrase things another way, skimming the code, that
bootm_find_images() does:
	if (IS_ENABLED(CONFIG_CMD_FDT))
		set_working_fdt_addr(map_to_sysmem(images.ft_addr));

And so we never set "working_fdt" when CMDLINE is off (since CMD_FDT is
off) IS the bug, and that needs to be fixed. That's when you should
figure out where "working_fdt" should be (and also maybe re-name it or
the local variable named "working_fdt" that the pxe_utils.c code uses)
and not before then.

> Looking at the list of errors, we should just fix them. They all
> indicate real problems with the structure of the code.

No, they do not. The codebase assume that we discard unreachable
functions. This allows us to NOT have to use #ifdefs and also not have
to make otherwise unreasonable code splits.

> Another example
> is fastboot which needs a condition for CMDLINE.

This is an example where yes, the functionality requires CMDLINE.
Because reading the code shows that fastboot will literally run
"bootcmd", and so requires that to be available.

> > I honestly didn't realize sandbox hadn't had this critical feature
> > enabled and I hope we haven't been doing too many odd shuffles of the
> > codebase because of it.
>=20
> I'm a bit unsure where you are heading with this. Ultimate we don't
> want to disable all the functionality when CMDLINE is disabled. I
> think with the addition of 5-6 patches in your series you can fix it.

Where I'm heading with this is to say that sandbox must work like a real
platform does and discard unreachable code. You don't know what code
is or is not really needed for functionality X and needs to be moved for
it to not rely on what's in the command file vs elsewhere until you act
like other platforms do.

--=20
Tom

--zRPMSCsYf9uem8iX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2sTQACgkQFHw5/5Y0
tyw8qgv8DI/XQe19UkL/BE2SxLCXoPlZYMG9pKezLWrIJE1gcVgD8IvU2D04/hKM
sgGMCrUepXt7FDwWDFLtZplHR+Nj2z0aHpCC0QSG7pQ82NTapu4evrzsUibU8CLQ
h3GFME8cSowKyIxeAg5zSxkxcxK4xJ5Byq8osVqKQYzGvaAP4frg8QNBhB4wHfPq
8QlRrImfLpJejTvtX7OQOBNi3XbJQCN06AKz9BGp/dwS9v5XeQ93AqZX9TNQGjA+
liMcf7sZSwIAmKVh3tqcXEyfaGYLndlZW4GP/qF2/YioYM304gJ7cupTVe1HQizL
cQH6EvQNUNYWJUqfrWPlw5g/gxsB8QetgblI2dTFLhrJLcPcFFQvpLEegKX0UiZp
Farx/kUCAfMuiuQiUgww+XK5vHzD+u9dDPkEgSpj3NLQ8Z50ezN7t7kGfSaRJYRK
2ifsDpHYTH6tcR8KcQhNss8J3ldfMxMCne/6Fsns+tJl0DuCPIP0gFxWwBEYZNep
JJU197E9
=H2cK
-----END PGP SIGNATURE-----

--zRPMSCsYf9uem8iX--
