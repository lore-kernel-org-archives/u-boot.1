Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223E9C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 18:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671D687E89;
	Mon, 18 Mar 2024 19:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8CC87E95; Mon, 18 Mar 2024 19:08:18 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 817BE8744F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 19:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,134,1708354800"; 
 d="asc'?scan'208";a="202169240"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 19 Mar 2024 03:08:11 +0900
Received: from [10.226.92.78] (unknown [10.226.92.78])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id E869C4003ECA;
 Tue, 19 Mar 2024 03:08:09 +0900 (JST)
Message-ID: <a3872c69-c447-4ed8-b9ed-9b4031ad70aa@bp.renesas.com>
Date: Mon, 18 Mar 2024 18:08:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: devicetree: Lets avoid short reference link names
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
References: <20240301132454.3492762-1-sumit.garg@linaro.org>
 <ce51eabf-e3a6-4822-a920-4846d5898f09@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <ce51eabf-e3a6-4822-a920-4846d5898f09@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QEP8Mp9Lp254ZfijPa0wUsei"
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
--------------QEP8Mp9Lp254ZfijPa0wUsei
Content-Type: multipart/mixed; boundary="------------S064uW105EAQo01aNuyjXfJJ";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Message-ID: <a3872c69-c447-4ed8-b9ed-9b4031ad70aa@bp.renesas.com>
Subject: Re: [PATCH] doc: devicetree: Lets avoid short reference link names
References: <20240301132454.3492762-1-sumit.garg@linaro.org>
 <ce51eabf-e3a6-4822-a920-4846d5898f09@bp.renesas.com>
In-Reply-To: <ce51eabf-e3a6-4822-a920-4846d5898f09@bp.renesas.com>

--------------S064uW105EAQo01aNuyjXfJJ
Content-Type: multipart/mixed; boundary="------------osSpvGRI8WL4II6cyr3o8rQX"

--------------osSpvGRI8WL4II6cyr3o8rQX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2024 07:39, Paul Barker wrote:
> On 01/03/2024 13:24, Sumit Garg wrote:
>> Short reference link names like "dtspec", "dtrepo", "dttweaks" etc.
>> interrupt the flow of the document text. Lets avoid them and instead
>> expand in place for better readability.
>>
>> Suggested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  doc/develop/devicetree/control.rst | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetr=
ee/control.rst
>> index c94d84192b71..4cc1457d4ea8 100644
>> --- a/doc/develop/devicetree/control.rst
>> +++ b/doc/develop/devicetree/control.rst
>> @@ -36,10 +36,10 @@ What is a Flattened Devicetree?
>>  -------------------------------
>> =20
>>  An fdt can be specified in source format as a text file. To read abou=
t
>> -the fdt syntax, take a look at the specification (dtspec_).
>> +the fdt syntax, take a look at `the devicetree specification`_.
>> =20
>> -There is also a mailing list (dtlist_) for the compiler and associate=
d
>> -tools.
>> +There is also a `devicetree compiler mailing list`_ for the compiler =
and
>> +associated tools.
>> =20
>>  In case you are wondering, OF stands for Open Firmware. This follows =
the
>>  convention used in Linux.
>> @@ -89,7 +89,7 @@ Failing that, you could write one from scratch yours=
elf!
>>  Resyncing with devicetree-rebasing
>>  ----------------------------------
>> =20
>> -The devicetee-rebasing repository (dtrepo_) maintains a fork cum mirr=
or copy of
>> +The `devicetree-rebasing repository`_ maintains a fork cum mirror cop=
y of
>>  devicetree files along with the bindings synced at every Linux kernel=
 major
>>  release or intermediate release candidates. The U-Boot maintainers re=
gularly
>>  sync the `dts/upstream/` subtree from the devicetree-rebasing repo wh=
enever
>> @@ -118,7 +118,7 @@ as `arch/<arch>/dts/<name>.dts`. To select that ad=
d `# CONFIG_OF_UPSTREAM is not
>>  set` and set `DEFAULT_DEVICE_TREE=3D<name>` when prompted by Kconfig.=

>> =20
>>  This should include your CPU or SoC's devicetree file. On top of that=
 any U-Boot
>> -specific tweaks (see: dttweaks_) can be made for your board.
>> +specific tweaks (see: :ref:`dttweaks`) can be made for your board.
>> =20
>>  If `OF_EMBED` is selected by Kconfig, then it will be picked up and b=
uilt into
>>  the U-Boot image (including u-boot.bin). This is suitable for debuggi=
ng
>> @@ -243,7 +243,7 @@ Dependencies
>> =20
>>  The DT schema project must be installed in order to validate the DT s=
chema
>>  binding documents and validate DTS files using the DT schema. For ins=
tallation
>> -instructions, refer to the DT schema project page (dtschema_).
>> +instructions, refer to the `DT schema project page`_.
>> =20
>>  Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will=
 be
>>  installed. Ensure they are in your PATH (~/.local/bin by default).
>> @@ -333,10 +333,10 @@ used it before Linux (e.g. snow). The two projec=
ts developed in parallel
>>  and there are still some differences in the bindings for certain boar=
ds.
>>  While there has been discussion of having a separate repository for d=
evicetree
>>  files, in practice the Linux kernel Git repository has become the pla=
ce where
>> -these are stored, with U-Boot taking copies via devicetree-rebasing r=
epo
>> -(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
>> +these are stored, with U-Boot taking copies via
>> +`devicetree-rebasing repository`_ and adding tweaks with u-boot.dtsi =
files.
>> =20
>> -.. _dtspec: https://www.devicetree.org/specifications/
>> -.. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
>> -.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetre=
e/devicetree-rebasing.git
>> -.. _dtschema: https://github.com/devicetree-org/dt-schema/tree/main
>> +.. _the devicetree specification: https://www.devicetree.org/specific=
ations/
>> +.. _devicetree compiler mailing list: https://www.spinics.net/lists/d=
evicetree-compiler/
>> +.. _devicetree-rebasing repository: https://git.kernel.org/pub/scm/li=
nux/kernel/git/devicetree/devicetree-rebasing.git
>> +.. _DT schema project page: https://github.com/devicetree-org/dt-sche=
ma/tree/main
>=20
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>=20

There are no comments from anyone else, but this hasn't hit the next
branch yet so I'm sending a gentle ping.

--=20
Paul Barker
--------------osSpvGRI8WL4II6cyr3o8rQX
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------osSpvGRI8WL4II6cyr3o8rQX--

--------------S064uW105EAQo01aNuyjXfJJ--

--------------QEP8Mp9Lp254ZfijPa0wUsei
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZfiDCAUDAAAAAAAKCRDbaV4Vf/JGve/J
AQCk1lAwArbAPnF3MwIUxCFUsnJ8GesT2E5ByxcNYiw7VQD/cyc4n2ybu5eSG0I7++MzqHIWClfH
Y8DhzGQPLxqa3ww=
=6ohD
-----END PGP SIGNATURE-----

--------------QEP8Mp9Lp254ZfijPa0wUsei--
