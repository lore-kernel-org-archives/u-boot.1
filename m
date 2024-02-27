Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BDBC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 21:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E064187EDF;
	Tue, 27 Feb 2024 22:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A334987DE9; Tue, 27 Feb 2024 22:38:53 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3417987E4D;
 Tue, 27 Feb 2024 22:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,188,1705330800"; 
 d="asc'?scan'208";a="195557345"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2024 06:38:44 +0900
Received: from [10.226.92.31] (unknown [10.226.92.31])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79E0F40C91C8;
 Wed, 28 Feb 2024 06:38:35 +0900 (JST)
Message-ID: <2776f554-c19f-4974-aa9e-87279a6dfbfc@bp.renesas.com>
Date: Tue, 27 Feb 2024 21:38:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] doc: devicetree: Updates for devicetree-rebasing
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
 andre.przywara@arm.com, ijc@hellion.org.uk
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <20240222093607.3085545-9-sumit.garg@linaro.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240222093607.3085545-9-sumit.garg@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1AxIuFTzAghNe0FCZJW0N1vy"
X-Mailman-Approved-At: Tue, 27 Feb 2024 22:39:29 +0100
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
--------------1AxIuFTzAghNe0FCZJW0N1vy
Content-Type: multipart/mixed; boundary="------------aYYzwBQSux7jc1leaN3ey9Wg";
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
 andre.przywara@arm.com, ijc@hellion.org.uk
Message-ID: <2776f554-c19f-4974-aa9e-87279a6dfbfc@bp.renesas.com>
Subject: Re: [PATCH v6 08/11] doc: devicetree: Updates for devicetree-rebasing
 subtree
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <20240222093607.3085545-9-sumit.garg@linaro.org>
In-Reply-To: <20240222093607.3085545-9-sumit.garg@linaro.org>

--------------aYYzwBQSux7jc1leaN3ey9Wg
Content-Type: multipart/mixed; boundary="------------JUhKoiAq02NEUma3D2DbVhDD"

--------------JUhKoiAq02NEUma3D2DbVhDD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On 22/02/2024 09:36, Sumit Garg wrote:
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
> Changes in v6:
> - Incorporate documentation review comments from Paul.
>=20

I have just a couple of tidy up suggestions for the links in this
document - these let us avoid short reference names like `dtrepo` or
`dttweaks` appearing in the document itself where they interrupt the
flow of the text. For each one I've just wrote out what I think the line
above should be, I hope that makes sense.

[...]

> +Resyncing with devicetree-rebasing
> +----------------------------------
> +
> +The devicetee-rebasing repository (dtrepo_) maintains a fork cum mirro=
r copy of

The `devicetree-rebasing repository`_ maintains a fork cum mirror copy of=


> +devicetree files along with the bindings synced at every Linux kernel =
major
> +release or intermediate release candidates. The U-Boot maintainers reg=
ularly
> +sync the `dts/upstream/` subtree from the devicetree-rebasing repo whe=
never
> +the next branch opens (refer: :doc:`../release_cycle`) with the latest=
 mainline
> +Linux kernel release. To sync the `dts/upstream/` subtree, run::
> +
> +    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>=

> +
> +If required it is also possible to cherry-pick fixes from the
> +devicetree-rebasing repository prior to next sync, usage::
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
> +SoC/board maintainers are encouraged to migrate to use synced copies f=
rom
> +`dts/upstream/src/<arch>/<vendor>`. To do that add `imply OF_UPSTREAM`=
 for the
> +SoC being used via Kconfig and set `DEFAULT_DEVICE_TREE=3D<vendor>/<na=
me>` when
> +prompted by Kconfig.
> =20
> -   arch/<arch>/dts/<name>.dts
> +However, if `dts/upstream/` hasn't yet received devicetree source file=
 for your
> +newly added board support then you can add corresponding devicetree so=
urce file
> +as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTR=
EAM is not
> +set` and set `DEFAULT_DEVICE_TREE=3D<name>` when prompted by Kconfig.
> =20
> -This should include your CPU or SOC's devicetree file, placed in
> -`arch/<arch>/dts`, and then make any adjustments required using a u-bo=
ot-dtsi
> -file for your board.
> +This should include your CPU or SoC's devicetree file. On top of that =
any U-Boot
> +specific tweaks (see: dttweaks_) can be made for your board.

specific tweaks (see: :ref:`dttweaks`) can be made for your board.

> =20
>  If `OF_EMBED` is selected by Kconfig, then it will be picked up and bu=
ilt into
>  the U-Boot image (including u-boot.bin). This is suitable for debuggin=
g
> @@ -155,8 +185,9 @@ ways:
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
> @@ -169,8 +200,8 @@ constraints are even more extreme and the devicetre=
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
> @@ -199,6 +230,48 @@ option to specify a list of .dtsi files that will =
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
> +binding documents and validate DTS files using the DT schema. For inst=
allation
> +instructions, refer to the DT schema project page (dtschema_).

instructions, refer to the `DT schema project page`_.

> +
> +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will =
be
> +installed. Ensure they are in your PATH (~/.local/bin by default).
> +
> +You should also install yamllint (used by dtschema when present). On D=
ebian/
> +Ubuntu systems::
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
> @@ -260,8 +333,10 @@ used it before Linux (e.g. snow). The two projects=
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

these are stored, with U-Boot taking copies via the `devicetree-rebasing =
repository`_

> +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.

and adding tweaks with u-boot.dtsi files.

> =20
>  .. _dtspec: https://www.devicetree.org/specifications/
>  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree=
/devicetree-rebasing.git

=2E. _devicetree-rebasing repository: https://git.kernel.org/pub/scm/linu=
x/kernel/git/devicetree/devicetree-rebasing.git

> +.. _dtschema: https://github.com/devicetree-org/dt-schema/tree/main

=2E. _DT schema project page: https://github.com/devicetree-org/dt-schema=
/tree/main

Thanks,

--=20
Paul Barker
--------------JUhKoiAq02NEUma3D2DbVhDD
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------JUhKoiAq02NEUma3D2DbVhDD--

--------------aYYzwBQSux7jc1leaN3ey9Wg--

--------------1AxIuFTzAghNe0FCZJW0N1vy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZd5WWgUDAAAAAAAKCRDbaV4Vf/JGvbDn
AP4oE38gRqvgIVhEsWnH8yfc/X9LzD+zvu6v4WV7taulawEAnweJNpO/+MZ7biDF+focreA5yq1S
meeqLKtzNfMfJQk=
=utEe
-----END PGP SIGNATURE-----

--------------1AxIuFTzAghNe0FCZJW0N1vy--
