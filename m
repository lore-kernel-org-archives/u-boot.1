Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F26C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821BB8494B;
	Wed,  1 Jul 2026 00:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mlox8WkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DA58498C; Wed,  1 Jul 2026 00:41:45 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6EB848EB
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a18eab71bfso19911eaf.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782859302; x=1783464102; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t2EArvHuxPN23bMjR2k+WutVVIFxP5RUIvzXWl3iNYI=;
 b=mlox8WkVGRtbAG3w+GJdlZ4xonAx3tWFRKbd8pjxYmAExRC3cB43DXOnjaoMIRFlJM
 XrFfxkoukOjGO07u9I9UHZ+ELfwtbJpzdEn9xsf8/xwn1hIRisJAKw4+++URqvobTH9v
 Ms0xO4SP8Ea86aYvQekYTLUA0AfNdBHeWXFGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782859302; x=1783464102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2EArvHuxPN23bMjR2k+WutVVIFxP5RUIvzXWl3iNYI=;
 b=CMYWjkqSe7rhQqObqUjbjCXtAO0KrE6EBPSNzx9aQreYYKiWidBejn2vWIIAx2Xwu7
 /zdcRkd9SuwD/4XpgW6lFV5hNQY8BI9QXVRoqwYzpwopZAKIIOW1O6bL83qslX56k5rq
 DPfutVm15O8+H11MkWvvlVpNs8whaGwcpvA9vDpYzNnGEN/qQ2n8gcOyySSxbvNOtKxX
 0AygQIXuCl/1s4dn+4fdnl9Zfob2Kw8xQz0sQTtQ1SzEGR169eiTnoTgadMIOhI80p7q
 R0GKpUv26b1heWZbVLphFpXSSLWFfoRwbpozjVW1lN5U+9yfpy8KWrasm0NHk/tOD+An
 pq2g==
X-Gm-Message-State: AOJu0YwaFKgy0hUkG/rDY5VYQC8GGe2FmnyjZxoJLkiEFLtwe28KOS8R
 u/OyD7QS6VottOz+s87yh2Bz2A6czqQxze0qbe5rwi/mgX6l8xaAibpTrW9qFoshBiA=
X-Gm-Gg: AfdE7cm3Z7bxsO/x+ef9KiSaLcy7ajJKjrSj3FKGH+Pu6cmCfl/fWBngRhPCHmLQSos
 v9UaeiUViTniBwR6lN2TL0Z0Ze3ztMp8osGB69ienD/+yHvcBtTGLfCDvZu9B+P2eJxto3kVXXH
 LYRnzoL13dhb2mm4SIYJel01xm08cXqWnWyv3i303x+Z//DjklnelPdHi/Qb/nT1ZbjtcfOllKb
 k31xD8kXOMVu5gtgULByuz5QgmKwtyW8UiiHNKVFFTRUC6eRKOdkAyfMZjpGBYuA6dLBtsJ8M95
 1RoVqVQVWcse/dbzFEex/JiDav06Z17TXrz/kDM5IqBfBAF88sv2+c0DqK/yEtXmQJLqg6/UvCS
 k+qoMHaqXGZ3nJ1b51XtrrzGAWDSHZhy0mzsJ328UxqUbnWRsxyY2jeS9+fh7oWvKAfwuNOx87S
 KLTHV2bQR7M6qLfbNyeSBFEZ0yWtDK7mec5vISsFYlOZT7mb/nQem6/bBs3vr6tYDjPNT5f0KbA
 Tfpys79+Io0rKTXkWzw9HwmjEmWO8lggpZ1pTNTf4d6wO09DjM=
X-Received: by 2002:a4a:ee0a:0:b0:694:9ea7:7aa1 with SMTP id
 006d021491bc7-6a196b34303mr1701238eaf.5.1782859301880; 
 Tue, 30 Jun 2026 15:41:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44c62028b7bsm173136fac.10.2026.06.30.15.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 15:41:40 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:41:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>,
	Ahmad Fatoum <a.fatoum@barebox.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, dlechner@baylibre.com,
 jstephan@baylibre.com, baylibre-upstreaming@groups.io
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
Message-ID: <20260630224137.GF749385@bill-the-cat>
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HnaaZUSvfZYtdyXs"
Content-Disposition: inline
In-Reply-To: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
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


--HnaaZUSvfZYtdyXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 09:20:13PM +0200, Carlo Caione wrote:
> Hi all,
>=20
> This is a design RFC, not a patch series. I would like to agree the appro=
ach
> and the devicetree binding on the list before posting code, because the
> mechanism touches both bootstd and the EFI loader and introduces a new bi=
nding.
>=20
> A working implementation exists and has been validated on hardware (detai=
ls at
> the end); I will post it as patches once the design here is acceptable.
>=20
>=20
> 1. The problem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Platforms that follow EBBR / Arm SystemReady IR treat the OS devicetree a=
s part
> of the firmware rather than part of the OS: the base DTB and its overlays=
 live
> on a firmware-owned partition and are updated independently of the operat=
ing
> system, instead of being shipped in the OS image or on the EFI System Par=
tition
> (ESP). The firmware is expected to load that devicetree and hand it to th=
e OS
> (via the EFI configuration table).
>=20
> U-Boot today can source the OS devicetree from its own control DT, from t=
he ESP,
> or from an EFI Boot#### load option, but it has no generic way to assembl=
e it
> from a firmware-owned partition. As a result vendors carry out-of-tree ma=
chinery
> for exactly this. For example, MediaTek ships downstream `dtbprobe` (asse=
mble the
> DT from a partition) and `fdt authndtb` (authenticate it) commands. The g=
oal of
> this work is to provide one reusable, vendor-neutral mechanism in mainlin=
e so
> those downstream commands can be dropped.
>=20
>=20
> 2. What a solution has to do
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
>   - Assemble the OS devicetree (a base DTB plus a list of overlays) from a
>     firmware-owned partition and install it for the OS.
>   - Install it on *every* EFI launch path, not just one. SystemReady IR b=
oots
>     through the UEFI boot manager, which in U-Boot does not go through the
>     per-device EFI bootmeth, so a per-device-only hook is not enough.
>   - Support secure boot: when the firmware devicetree is signed, verify i=
t, and
>     never silently fall back to an unverified devicetree.
>   - Support A/B firmware partitions.
>=20
>=20
> 3. Proposed design
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> A new bootstd helper, `firmware_fdt_load()` (`CONFIG_BOOTSTD_FIRMWARE_FDT=
`),
> assembles the devicetree and returns it; the EFI launch paths install it =
via
> `efi_install_fdt()`, exactly like any other devicetree source.
>=20
> 3.1 Where the source is described (new binding)
> -----------------------------------------------
>=20
> The *location* is described in the control devicetree. The bootstd node c=
arries
> a `firmware-fdt-source` phandle to a node that is a child of the media de=
vice
> that owns the partition, and identifies the partition by GPT type UUID an=
d/or
> name:
>=20
> 	bootstd {
> 		compatible =3D "u-boot,boot-std";
> 		firmware-fdt-source =3D <&fw_fdt>;
> 	};
>=20
> 	&mmc0 {
> 		fw_fdt: firmware-fdt {
> 			compatible =3D "u-boot,firmware-fdt-block";
> 			partition-type-uuid =3D "....";	/* GPT type UUID */
> 			partition-name =3D "firmware";	/* optional */
> 			extra-size =3D <0x3000>;		/* overlay headroom */
> 		};
> 	};
>=20
> 3.2 The dynamic parameters (environment) and board defaults
> -----------------------------------------------------------
>=20
> The source and its partition policy stay in the control devicetree (secti=
on
> 3.1). The values that change with the OS image rather than with the hardw=
are are
> layered:
>=20
>   - the control DT describes the source and the partition policy;
>   - the board default environment carries factory defaults for the static=
 values
>     (`fdtfile` and `dtb_path` for the base DTB, and the `fdt_addr_r` /
>     `fdtoverlay_addr_r` working addresses), so a from-source build boots =
and
>     `env default` restores a loadable configuration;
>   - the (firmware-owned) stored environment overrides those at runtime, a=
nd
>     carries the genuinely dynamic values: the overlay list (`list_dtbo`) =
and the
>     A/B partition pin (`boot_dtb`).
>=20
> As an alternative, the stable defaults (`fdtfile` and the path) could ins=
tead be
> expressed as optional properties on the source node, keeping them in the =
control
> devicetree rather than in the board default environment. See the open que=
stions.
>=20
> 3.3 Where it is installed (both EFI paths)
> ------------------------------------------
>=20
> The helper is consumed by both:
>=20
>   - the per-device EFI bootmeth (`bootmeth_efi`), and
>   - the EFI boot manager (`efi_bootmgr_run()`),
>=20
> each installing the result through `efi_install_fdt()`. That is the conve=
rgence
> point all EFI launches pass through, so the firmware devicetree is instal=
led
> regardless of how the EFI application was started, including the boot-man=
ager
> autoboot path that SystemReady IR uses.
>=20
> 3.4 Fail-closed error semantics
> -------------------------------
>=20
> Once a source is configured (the node is present), the result must be
> deterministic. `-ENOENT` means *only* that no source is configured, in wh=
ich
> case the caller falls back to its normal devicetree. Any other failure to
> assemble a configured source (unresolvable device, no matching partition,=
 read
> error, invalid blob, failed signature) is fatal for that EFI launch path:=
 a
> missing or bad firmware devicetree is never silently replaced by another =
source.
> Missing environment metadata for a configured source is treated as a
> configuration error (fail closed, or satisfied from the board default), n=
ever as
> "no source".
>=20
> 3.5 Optional secure boot
> ------------------------
>=20
> With `CONFIG_BOOTSTD_FIRMWARE_FDT_FIT` the base DTB and overlays are sign=
ed FIT
> images. Each is verified by reusing U-Boot's existing verified-boot policy
> (`fit_image_load()` with verification enabled and a required key in the c=
ontrol
> FDT), and the verified flat devicetree is extracted in place. A non-FIT f=
ile is
> rejected so an unsigned devicetree cannot be installed. This reuses the e=
xisting
> trust model rather than adding new crypto, and replaces the downstream
> `fdt authndtb`.
>=20
>=20
> 4. Why these choices
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   - Describing the source in the control DT, as a child of the media devi=
ce,
>     follows the existing bootstd guidance ("if a bootdev needs configurat=
ion,
>     add it to the DT as a child of the media device") and the VBE precede=
nt. It
>     keeps the mechanism generic: no GPT UUID or board constant in the C c=
ode.
>   - Splitting identity (control DT) from dynamic values (environment) and=
 static
>     defaults (board default env) keeps the firmware in control of what ch=
anges
>     per OS image, while still letting a plain `make <board>_defconfig` bu=
ild
>     boot.
>   - Installing at `efi_install_fdt()` rather than in one bootmeth is what=
 makes
>     this SystemReady-IR-grade: the boot-manager path carries the firmware
>     devicetree too. A per-device-only hook leaves the autoboot path on the
>     control DT.
>   - Fail-closed is required for secure boot: there must be no path where a
>     configured, signed devicetree silently degrades to an unverified one.
>   - Reusing `fit_image_load()` keeps a single, reviewed verified-boot pat=
h.
>=20
>=20
> 5. Alternatives considered
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
>   - A global bootmeth ordered ahead of the EFI boot manager (a structure =
used in
>     an earlier proof of concept). It works for autoboot but does not conv=
erge
>     all launch paths; `efi_install_fdt()` is the real single point.
>   - A per-device bootmeth hook only. Simpler, but misses the boot-manager
>     autoboot path, which is the one SystemReady IR uses.
>   - Keeping the mechanism vendor-specific (the status quo). Does not help=
 anyone
>     else and keeps the command out of tree.
>=20
>=20
> 6. Open questions for the list
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
>   1. Binding naming: are `firmware-fdt-source` and the `u-boot,firmware-f=
dt-block`
>      compatible acceptable, and is the control-DT-described-source shape =
the one
>      you want?

It probably shouldn't be "u-boot," because it's a more generic thing.

>   2. The configuration boundary. The proposal keeps the source and partit=
ion
>      policy in the control DT, puts factory defaults for the filenames an=
d the
>      working addresses in the board default environment, and lets the
>      firmware-owned stored environment override at runtime (and hold the =
dynamic
>      `list_dtbo` / `boot_dtb`). An alternative is to express the stable d=
efaults
>      (`fdtfile`, a path) as optional properties on the source node, so th=
ey live
>      in the control DT rather than the board environment. Which does the =
project
>      prefer?
>   3. The `efi_bootmgr_run()` hook: is installing the firmware devicetree =
on the
>      boot-manager path acceptable to the EFI maintainers, and is that the=
 right
>      place?
>   4. The fail-closed semantics: a configured source that cannot be assemb=
led is
>      fatal; only an absent source falls back. Agree?
>   5. Should the signed-FIT verification be part of this series or a follo=
w-up?
>=20
> Thanks for any feedback. I will follow up with the patch series once the =
binding
> and approach are agreed.

I've added in Ahmad Fatoum from the barebox side, as this is a problem
that while the implementation will be bootloader specific, the details
will be generic.

--=20
Tom

--HnaaZUSvfZYtdyXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakRGHQAKCRAr4qD1Cr/k
ChnHAP0ZNgeRkiyqRMXrWj3BsCVCIxpJUxOysTU7mYDPEqRYzQD+KIGnr9ePQaZA
hlnzPk43Hn6OTFPTyWXMzWg9iyjACAQ=
=Z5HU
-----END PGP SIGNATURE-----

--HnaaZUSvfZYtdyXs--
