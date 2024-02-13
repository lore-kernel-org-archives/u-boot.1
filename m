Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1EFC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 21:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE6187D84;
	Tue, 13 Feb 2024 22:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D606387D06; Tue, 13 Feb 2024 22:31:25 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9512387CF9;
 Tue, 13 Feb 2024 22:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,158,1705330800"; 
 d="asc'?scan'208";a="197730659"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 14 Feb 2024 06:31:08 +0900
Received: from [10.226.92.44] (unknown [10.226.92.44])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CFA440BE5AE;
 Wed, 14 Feb 2024 06:30:58 +0900 (JST)
Message-ID: <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
Date: Tue, 13 Feb 2024 21:30:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing
 subtree
Content-Language: en-GB
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240202130534.1051438-9-sumit.garg@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PI9rjElydAANIVAPkvj2g4ds"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PI9rjElydAANIVAPkvj2g4ds
Content-Type: multipart/mixed; boundary="------------VnTKgz0evCwuPVJROqJGNvfh";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com
Message-ID: <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing
 subtree
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org>
In-Reply-To: <20240202130534.1051438-9-sumit.garg@linaro.org>

--------------VnTKgz0evCwuPVJROqJGNvfh
Content-Type: multipart/mixed; boundary="------------6XscWqzd02lfBELlbmS2CKT8"

--------------6XscWqzd02lfBELlbmS2CKT8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2024 13:05, Sumit Garg wrote:
> Encourage SoC/board maintainers to migrate to using devicetree-rebasing=

> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>=20
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>=20
> Changes in v5:
> - Document how to cherry-pick fixes from devicetree-rebasing tree.
>=20
> Changes in v4:
> - Switched subtree to be imported as dts/upstream sub-directory rather
>   than devicetree-rebasing sub-directory to better suite U-Boot
>   directory structure.
> - Since we now have v6.7-dts tag available now, so switch subtree to
>   that from its beginning.
> - Clarify subtree uprev schedule as a separate documentation section.
>   Also, fixed documentation typos.
>=20
> Changes in v3:
> - Replace CONFIG_* with Kconfig options
>=20
> Changes in v2:
> - s/U-boot/U-Boot/
>=20
>  doc/develop/devicetree/control.rst | 117 ++++++++++++++++++++++++-----=

>  1 file changed, 97 insertions(+), 20 deletions(-)
>=20
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetre=
e/control.rst
> index 9a0cb90336df..4440d4b82c6a 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> +.. Copyright 2023-2024 Linaro Ltd.
> =20
>  Devicetree Control in U-Boot
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> @@ -22,12 +23,11 @@ for three reasons:
>    hierarchical format
>  - It is fairly efficient to read incrementally
> =20
> -The arch/<arch>/dts directories contains a Makefile for building the d=
evicetree
> -blob and embedding it in the U-Boot image. This is useful since it all=
ows
> -U-Boot to configure itself according to what it finds there. If you ha=
ve
> -a number of similar boards with different peripherals, you can describ=
e
> -the features of each board in the devicetree file, and have a single
> -generic source base.
> +The U-Boot Makefile infrastructure allows for building the devicetree =
blob
> +and embedding it in the U-Boot image. This is useful since it allows U=
-Boot
> +to configure itself according to what it finds there. If you have a nu=
mber
> +of similar boards with different peripherals, you can describe the fea=
tures
> +of each board in the devicetree file, and have a single generic source=
 base.
> =20
>  To enable this feature, select `OF_CONTROL` via Kconfig.
> =20
> @@ -68,8 +68,14 @@ a binary file. U-Boot adds its own `fdtgrep` for cre=
ating subsets of the file.
>  Where do I get a devicetree file for my board?
>  ----------------------------------------------
> =20
> -You may find that the Linux kernel has a suitable file. Look in the
> -kernel source in arch/<arch>/boot/dts.
> +Linux kernel Git repository has been the place where devicetree files =
along
> +with devicetree bindings are stored and maintained. There is devicetee=
-rebasing
> +(dtrepo_) which maintains a forked copy of devicetree files along with=
 bindings
> +at every Linux kernel major release or intermediate release candidates=
=2E

This can be written more clearly, we can steal what you wrote later and
expand it to say what was wrong with the previous situation:

"The devicetree files and devicetree bindings are maintained as part of
the Linux kernel git repository. Traditionally, U-Boot placed copies of
devicetree source files from the Linux kernel into
`arch/<arch>/dts/<name>.dts`. However, this required each board
maintainer to manually keep their device tree in sync with Linux and
often led to divergence between these copies."

We can then introduce the `dts/upstream` directory and tell developers
why it is a better solution.

I think the docs should talk about the `dts/upstream` directory first,
then the devicetree-rebasing repository afterwards. The directory in the
u-boot source tree is what most developers will see and interact with,
use of the devicetree-rebasing repository is an implementation detail of
how that subtree is sync'd with Linux. I don't think we need to mention
the devicetree-rebasing repository until the "Resyncing with
devicetree-rebasing" section below.

Also, is devicetree-rebasing a "forked copy"? A fork would imply some
difference from upstream. I would guess this is more like a mirror.

> +
> +U-Boot maintains a Git subtree for devicetee-rebasing repo as `dts/ups=
tream/`
> +sub-directory. You may find that the `dts/upstream/` sub-directory has=
 a
> +suitable devicetree file for your board. Look in `dts/upstream/src/<ar=
ch>/`.
> =20
>  If not you might find other boards with suitable files that you can
>  modify to your needs. Look in the board directories for files with a
> @@ -78,17 +84,38 @@ modify to your needs. Look in the board directories=
 for files with a
>  Failing that, you could write one from scratch yourself!
> =20
> =20
> +Resyncing with devicetree-rebasing
> +----------------------------------
> +
> +U-Boot regularly sync `dts/upstream/` subtree whenever the next window=
 opens

"The U-Boot maintainers regularly sync the..."

What's the "next window" here? Is this the merge window? Or the period
after the merge window when the next branch is open? There should be a
link here to relevant section of the U-Boot Development Cycle page in
case the reader isn't familiar with the development process.

> +with the next available kernel major release. `dts/update-dts-subtree.=
sh` script

I think this should be "with the latest mainline kernel release."

> +provides a wrapper around git subtree pull command, usage from the top=
 level> +U-Boot source tree, run::

The use of `git subtree pull` is an implementation detail. I think the
docs need to focus on what the script does, not how it does it.

Maybe replace this sentence with something like:

"To sync the `dts/upstream/` subtree, run the following command::"

> +
> +    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>=

> +
> +If required it is also possible to cherry-pick fixes from devicetree-r=
ebasing

"the devicetree-rebasing repository" here and each time it is referenced.=


> +tree prior to next sync, usage::
> +
> +    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> +
> +
>  Configuration
>  -------------
> =20
> -Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Th=
en put
> -your devicetree file into::
> +Traditionally, U-Boot placed copies of devicetree source files from Li=
nux

"the Linux kernel", here and each time "Linux kernel" is used.

> +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via set=
ting
> +"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
> =20
> -   arch/<arch>/dts/<name>.dts
> +However, it has become cumbersome over time for each SoC/board maintai=
ner to
> +keep devicetree files in sync with Linux kernel. Therefore, SoC/board
> +maintainers are encouraged to migrate to use synced copies from
> +`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` fo=
r the
> +SoC being used via Kconfig and set up "<vendor>/<name>" when prompted =
for
> +`DEFAULT_DEVICE_TREE` by Kconfig.

I'd prefer "set `OF_UPSTREAM=3Dy`" and "set `DEFAULT_DEVICE_TREE=3D<vendo=
r>/<name>`".

> =20
> -This should include your CPU or SOC's devicetree file, placed in
> -`arch/<arch>/dts`, and then make any adjustments required using a u-bo=
ot-dtsi
> -file for your board.
> +This should include your CPU or SOC's devicetree file. On top of that =
any U-Boot

Change "SOC" to "SoC" while this is being modified.

> +specific tweaks (see: dttweaks_) can be made for your board.
> =20
>  If `OF_EMBED` is selected by Kconfig, then it will be picked up and bu=
ilt into
>  the U-Boot image (including u-boot.bin). This is suitable for debuggin=
g
> @@ -155,8 +182,9 @@ ways:
>  Adding tweaks for U-Boot
>  ------------------------
> =20
> -It is strongly recommended that devicetree files in U-Boot are an exac=
t copy of
> -those in Linux, so that it is easy to sync them up from time to time.
> +With `dts/upstream` Git subtree, it is ensured that devicetree files i=
n U-Boot
> +are an exact copy of those in Linux kernel available under
> +`dts/upstream/src/<arch>/<vendor>`.
> =20
>  U-Boot is of course a very different project from Linux, e.g. it opera=
tes under
>  much more restrictive memory and code-size constraints. Where Linux ma=
y use a
> @@ -169,8 +197,8 @@ constraints are even more extreme and the devicetre=
e is shrunk to remove
>  unwanted nodes, or even turned into C code to avoid access overhead.
> =20
>  U-Boot automatically looks for and includes a file with updates to the=
 standard
> -devicetree for your board, searching for them in the same directory as=
 the
> -main file, in this order::
> +devicetree for your board, searching for them in `arch/<arch>/dts/` in=
 this
> +order::
> =20
>     <orig_filename>-u-boot.dtsi
>     <CONFIG_SYS_SOC>-u-boot.dtsi
> @@ -199,6 +227,54 @@ option to specify a list of .dtsi files that will =
also be included when
>  building .dtb files.
> =20
> =20
> +Devicetree bindings schema checks
> +---------------------------------
> +
> +With devicetee-rebasing Git subtree, the devicetree bindings are also =
regularly
> +synced with Linux kernel as `dts/upstream/Bindings/` sub-directory. Th=
is
> +allows U-Boot to run devicetree bindings schema checks which will brin=
g
> +compliance to U-Boot core/drivers regarding usage of devicetree.
> +
> +Dependencies
> +~~~~~~~~~~~~
> +
> +The DT schema project must be installed in order to validate the DT sc=
hema
> +binding documents and validate DTS files using the DT schema. The DT s=
chema
> +project can be installed with pip::
> +
> +    pip3 install dtschema

Unfortunately this won't work on recent distro versions, e.g. on Debian
12 I get:

    error: externally-managed-environment

    =C3=97 This environment is externally managed
    =E2=95=B0=E2=94=80> To install Python packages system-wide, try apt i=
nstall
        python3-xyz, where xyz is the package you are trying to
        install.

        If you wish to install a non-Debian-packaged Python package,
        create a virtual environment using python3 -m venv path/to/venv.
        Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
        sure you have python3-full installed.

        If you wish to install a non-Debian packaged Python application,
        it may be easiest to use pipx install xyz, which will manage a
        virtual environment for you. Make sure you have pipx installed.

        See /usr/share/doc/python3.11/README.venv for more information.

    note: If you believe this is a mistake, please contact your Python
    installation or OS distribution provider. You can override this, at t=
he
    risk of breaking your Python installation or OS, by passing
    --break-system-packages.
    hint: See PEP 668 for the detailed specification.

I don't have a good solution to recommend here - there's no consensus on
how to install Python tools for use in development. You could use
`pipx`, you could create a virtualenv, and I'm sure there are other
options as well. Perhaps we just need to leave it up to the reader to
find out how to install dtschema on their system.

> +
> +Note that 'dtschema' installation requires 'swig' and Python developme=
nt files
> +installed first. Please, refer to the GCC build documentation for inst=
allation
> +instructions :doc:`../../build/gcc`.
> +
> +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will =
be
> +installed. Ensure they are in your PATH (~/.local/bin by default).
> +
> +Recommended is also to install yamllint (used by dtschema when present=
). On

"You should also install yamllint"

> +Debian/Ubuntu systems::
> +
> +    apt install yamllint
> +
> +Running checks
> +~~~~~~~~~~~~~~
> +
> +In order to perform validation of DTB files, use the ``dtbs_check`` ta=
rget::
> +
> +    make dtbs_check
> +
> +It is also possible to run checks with a subset of matching schema fil=
es by
> +setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema =
files or
> +patterns (partial match of a fixed string). Each file or pattern shoul=
d be
> +separated by ':'.
> +
> +::
> +
> +    make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml:rtc.yaml
> +    make dtbs_check DT_SCHEMA_FILES=3D/gpio/
> +    make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml
> +
> +
>  Relocation, SPL and TPL
>  -----------------------
> =20
> @@ -260,8 +336,9 @@ used it before Linux (e.g. snow). The two projects =
developed in parallel
>  and there are still some differences in the bindings for certain board=
s.
>  While there has been discussion of having a separate repository for de=
vicetree
>  files, in practice the Linux kernel Git repository has become the plac=
e where
> -these are stored, with U-Boot taking copies and adding tweaks with u-b=
oot.dtsi
> -files.
> +these are stored, with U-Boot taking copies via devicetree-rebasing re=
po
> +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
> =20
>  .. _dtspec: https://www.devicetree.org/specifications/
>  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree=
/devicetree-rebasing.git

Thanks,

--=20
Paul Barker
--------------6XscWqzd02lfBELlbmS2CKT8
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------6XscWqzd02lfBELlbmS2CKT8--

--------------VnTKgz0evCwuPVJROqJGNvfh--

--------------PI9rjElydAANIVAPkvj2g4ds
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZcvfkQUDAAAAAAAKCRDbaV4Vf/JGvVu+
AP9oQ63AblxOPiaBpa+T8nPZxfPPIsWI+wIbtPPuLf7WfwD+Iu5FUuIqnmP/4gbcfkERrdOE0ZzK
lWNWY18bhKB3dAA=
=sKtX
-----END PGP SIGNATURE-----

--------------PI9rjElydAANIVAPkvj2g4ds--
