Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB87C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF6F80763;
	Wed, 22 Jan 2025 10:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Jqh/bWSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BFE8078B; Wed, 22 Jan 2025 10:40:23 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922F480586
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737538819; x=1737798019;
 bh=20fCpt2S1X1ZFLOYR4p6YTNVFn44uoSk3L5aOtx6KOE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Jqh/bWSXuen1spEj/AnoheL8evsf7LlN96mlJynpQHSZOqd8bNuqCrUQOxuSWUhke
 sxlHf4ejgEBOAeTDsXV4GLblDxtpWsRJdEth4jujP1UVtpzq+N4YtLKDGdBKRsRv8y
 1hsIFoCF+GE6kqColik4Yhs5grSSpu3Mh7kZhR6l9ARM+mwaxkKHYjcvZtfnhZnhZz
 BLoXllI/vti7wY07/VrskqXa+FdtRzvFh1gT9pDLZV9whbBahQK/Yrmgxi+LcJ755U
 TUbwex11t39K3UPV1CuuNSElwb1uTAMeeQVyVG4pNVLekTmICjCAsf7p/7vOPR+BJt
 T1oAuimtk4fdA==
Date: Wed, 22 Jan 2025 09:40:13 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] mach-snapdragon: support parsing memory info from
 external FDT
Message-ID: <4AZbBPh-iJwmB_GK_Kb53AqyKzVBlzPfqxtZ1SvqIN9Cat3w-M3tnoy__QzT7j-ukaHB4Tb9Qz7fV6WsiEmfmooL7j-9YDVAwxHSdRik5Ck=@samcday.com>
In-Reply-To: <25dee2fd-e021-46cd-bff5-c0ae989a6c08@linaro.org>
References: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
 <20250120-qcom-parse-memory-updates-v1-2-54a7f0550cff@samcday.com>
 <25dee2fd-e021-46cd-bff5-c0ae989a6c08@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 27ce1d0a5b60be7d9e2e5871e641613bdba36a34
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

'Ello Caleb,

On Tuesday, 21 January 2025 at 13:33, Caleb Connolly <caleb.connolly@linaro=
.org> wrote:
>=20
> On 20/01/2025 20:43, Sam Day wrote:
>=20
> > Prior to this commit, board_fdt_blob_setup would decide which FDT to
> > use, either the external one from the previous bootloader, or the
> > internal one that was compiled into the binary.
> >=20
> > This commit expands that behaviour a bit further, and introduces a
> > (default-enabled) option to always parse the /memory node from the
> > external FDT (if it's present and valid), even if we're going to
> > continue the boot with an internal one.
> >=20
> > The rationale here is that many (all?) of the upstream DTs for the
> > msm8916 + sdm845 (and likely others) socs do not fully specify the /mem=
ory
> > node(s), since it's typically expected that the bootloader has selected
> > one of these from an Android boot.img and then filled in the memory
> > info.
> >=20
> > Caleb's original explanation in the commit that introduced
> > qcom_parse_memory was dropped into a comment above that function, since
> > this part of the early initialization is getting quite nuanced. We don'=
t
> > want uninitiated folks to see that code and run away screaming or give
> > away all their possessions and move to a monastery or something.
>=20
>=20
> Maaaybe this last sentence isn't super necessary :P

No, I suppose not. We wouldn't want folks reading that last sentence to
experience an existential crisis, smear themselves in mud and run through
a supermarket completely naked. So I've removed it from the v2 patch :)

>=20
> > Signed-off-by: Sam Day me@samcday.com
> > ---
> > arch/arm/mach-snapdragon/Kconfig | 13 +++++++++
> > arch/arm/mach-snapdragon/board.c | 57 +++++++++++++++++++++++++++------=
-------
> > 2 files changed, 52 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdrago=
n/Kconfig
> > index 976c0e35fcef29bafecbbd6ea04459de852df275..0feb65a916459160a4da994=
7a6d7224930d507b4 100644
> > --- a/arch/arm/mach-snapdragon/Kconfig
> > +++ b/arch/arm/mach-snapdragon/Kconfig
> > @@ -45,4 +45,17 @@ config SYS_CONFIG_NAME
> > Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
> > will be used for board configuration.
> >=20
> > +config SYS_MEMORY_FROM_EXTERNAL_FDT
> > + bool "Always parse /memory from external device tree, if it's provide=
d"
> > + default y
> > + help
> > + When booting with an internal DT, we'll always use that since it's
> > + expected to be more accurate + up-to-date than whatever the previous
> > + bootloader hands us.
> > +
> > + The notable exception here is the /memory node. With this config opti=
on
> > + enabled, we'll initialize memory based on the information provided in=
 the
> > + external DT from the previous bootloader, even if we use the internal=
 DT
> > + for everything else.
>=20
>=20
> I definitely understand why you made this a config option, but I think
> we can make this make sense at runtime (admittedly with a little bit of
> complexity).
>=20
> What if we adjust qcom_parse_memory() to return an int, 0 on success and
> -ENODATA IFF (If and only if) the memory node has only a single entry
> with a size of 0.
>=20
> Then we can call it first with the internal fdt, if it returns -ENODATA
> and we have a valid external fdt then we can try that next.
>=20
> This way, your usecase with the msm8916 device will still work as
> expected (since it will gracefully fall back to the external fdt), but
> if for some reason we have a device where there needs to be an external
> fdt but we want to override the memory map we can still do so.
>=20
> I think we can live with the small overhead here and optimise it in the
> future if that becomes desirable, and avoid introducing a
> device-specific config option.

Thanks for the suggestion, I like that approach and agree that the overhead
introduced should be minimal, whilst giving us maximum compatibility across
the myriad ways a boot might take place.

I've already implemented and tested the requested changes in v2, which shou=
ld
hit the list shortly.

Cheers,
Sam

>=20
> > +
> > endif
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 2ef936aab757c7045729a2dd91944f4f9bff917e..f637bce18546fb3a9fe389e=
07f457346ad5f95c8 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -88,6 +88,29 @@ int dram_init_banksize(void)
> > return 0;
> > }
> >=20
> > +/**
> > + * The generic memory parsing code in U-Boot lacks a few things that w=
e
> > + * need on Qualcomm:
> > + *
> > + * 1. It sets gd->ram_size and gd->ram_base to represent a single memo=
ry block
> > + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size,=
 the end
> > + * of that first memory block.
> > + *
> > + * This results in all memory beyond U-Boot being unusable in Linux wh=
en booting
> > + * with EFI.
> > + *
> > + * Since the ranges in the memory node may be out of order, the only w=
ay for us
> > + * to correctly determine the relocation address for U-Boot is to pars=
e all
> > + * memory regions and find the highest valid address.
> > + *
> > + * We can't use fdtdec_setup_memory_banksize() since it stores the res=
ult in
> > + * gd->bd, which is not yet allocated.
>=20
>=20
> Thanks for adding this!
>=20
> Kind regards,
>=20
> > + *
> > + * This function requires a pointer to the specific FDT that we should=
 parse
> > + * for its /memory block. This is because when SYS_MEMORY_FROM_EXTERNA=
L_FDT is
> > + * enabled, we might be looking at the FDT provided by the previous bo=
otloader,
> > + * rather than our internal (gd->fdt_blob) one.
> > + */
> > static void qcom_parse_memory(const void *fdt)
> > {
> > int offset;
> > @@ -153,13 +176,13 @@ static void show_psci_version(void)
> > */
> > int board_fdt_blob_setup(void **fdtp)
> > {
> > - struct fdt_header *fdt;
> > + struct fdt_header *external_fdt, *internal_fdt;
> > bool internal_valid, external_valid;
> > - int ret =3D 0;
> >=20
> > - fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
> > - external_valid =3D fdt && !fdt_check_header(fdt);
> > - internal_valid =3D !fdt_check_header(*fdtp);
> > + internal_fdt =3D (struct fdt_header *)*fdtp;
> > + external_fdt =3D (struct fdt_header *)get_prev_bl_fdt_addr();
> > + external_valid =3D external_fdt && !fdt_check_header(external_fdt);
> > + internal_valid =3D !fdt_check_header(internal_fdt);
> >=20
> > /*
> > * There is no point returning an error here, U-Boot can't do anything u=
seful in this situation.
> > @@ -167,24 +190,22 @@ int board_fdt_blob_setup(void **fdtp)
> > /
> > if (!internal_valid && !external_valid)
> > panic("Internal FDT is invalid and no external FDT was provided! (fdt=
=3D%#llx)\n",
> > - (phys_addr_t)fdt);
> > + (phys_addr_t)external_fdt);
> > +
> > + if (IS_ENABLED(CONFIG_SYS_MEMORY_FROM_EXTERNAL_FDT) && external_valid=
)
> > + / Explicitly use the external FDT to configure memory */
> > + qcom_parse_memory(external_fdt);
> > + else
> > + qcom_parse_memory(internal_fdt);
> >=20
> > if (internal_valid) {
> > debug("Using built in FDT\n");
> > - ret =3D -EEXIST;
> > - } else {
> > - debug("Using external FDT\n");
> > - /* So we can use it before returning */
> > - *fdtp =3D fdt;
> > + return -EEXIST;
> > }
> >=20
> > - /*
> > - * Parse the /memory node while we're here,
> > - * this makes it easy to do other things early.
> > - */
> > - qcom_parse_memory(*fdtp);
> > -
> > - return ret;
> > + debug("Using external FDT\n");
> > + *fdtp =3D external_fdt;
> > + return 0;
> > }
> >=20
> > void reset_cpu(void)
>=20
>=20
> --
> // Caleb (they/them)
