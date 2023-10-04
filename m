Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568CFE8FDDA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 08:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7092886BF7;
	Wed,  4 Oct 2023 10:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBBB86BF7; Wed,  4 Oct 2023 10:48:24 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9E8E586BE1
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 10:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,199,1694703600"; 
 d="asc'?scan'208";a="181887167"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 17:48:17 +0900
Received: from [10.226.93.90] (unknown [10.226.93.90])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6BF864009F6E;
 Wed,  4 Oct 2023 17:48:15 +0900 (JST)
Message-ID: <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
Date: Wed, 4 Oct 2023 09:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qt9110ewRkU00Hvms6005wjL"
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
--------------qt9110ewRkU00Hvms6005wjL
Content-Type: multipart/mixed; boundary="------------Njg10eEimM5KFtysTXt9Mm0l";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
In-Reply-To: <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>

--------------Njg10eEimM5KFtysTXt9Mm0l
Content-Type: multipart/mixed; boundary="------------P7fy5kiwpDD1h8DPb6R41myr"

--------------P7fy5kiwpDD1h8DPb6R41myr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2023 14:23, Marek Vasut wrote:
> On 9/20/23 14:42, Paul Barker wrote:
>> Extend the existing driver to support the SCIF serial ports on the
>> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that t=
he
>> relevant reset signal is de-asserted before we try to talk to the SCIF=

>> module.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>   arch/arm/mach-rmobile/Kconfig |  1 +
>>   drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++++++++--
>>   drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>>   3 files changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kco=
nfig
>> index 973e84fcf7ba..0ab22356aee5 100644
>> --- a/arch/arm/mach-rmobile/Kconfig
>> +++ b/arch/arm/mach-rmobile/Kconfig
>> @@ -77,6 +77,7 @@ config RZG2L
>>   	imply RENESAS_SDHI
>>   	imply CLK_RZG2L
>>   	imply PINCTRL_RZG2L
>> +	imply SCIF_CONSOLE
>>   	help
>>   	  Enable support for the Renesas RZ/G2L family of SoCs, including t=
he
>>   	  the RZ/G2L itself (based on the R9A07G044 SoC).
>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>> index 5e543dbf3d58..a2e9a57137a6 100644
>> --- a/drivers/serial/serial_sh.c
>> +++ b/drivers/serial/serial_sh.c
>> @@ -17,6 +17,8 @@
>>   #include <linux/compiler.h>
>>   #include <dm/platform_data/serial_sh.h>
>>   #include <linux/delay.h>
>> +#include <dm/device_compat.h>
>> +#include <reset.h>
>>   #include "serial_sh.h"
>>  =20
>>   DECLARE_GLOBAL_DATA_PTR;
>> @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *port, in=
t clk, int baudrate)
>>  =20
>>   static void handle_error(struct uart_port *port)
>>   {
>> -	sci_in(port, SCxSR);
>> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>> +	/* The RZ/G2L datasheet says that error conditions are cleared by
>> +	 * resetting the error bits in the FSR register to zero.
>=20
> Can you be more specific here ?
>=20
> It doesn't seem Linux sh-sci.c driver does anything special for G2L, so=
=20
> is this special case really needed ?

On page 1268 of the datasheet (R01UH0914EJ0130 Rev.1.30):

"DR is cleared to 0 when DR =3D 1 is read and then 0 is written to the DR=

flag."

On page 1270:

"[Clearing condition]
=E2=97=8F When 0 is written to ER after it has been read as 1"

So zeros must be written to clear these errors, not ones.

We have an open task to investigate the issue in the Linux driver and
fix it.

>=20
>> +	 */
>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>> +		unsigned short status =3D sci_in(port, SCxSR);
>> +		sci_out(port, SCxSR, status & ~SCIF_ERRORS);
>> +	} else {
>> +		sci_in(port, SCxSR);
>> +		sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>> +	}
>>   	sci_in(port, SCLSR);
>>   	sci_out(port, SCLSR, 0x00);
>>   }
>> @@ -193,6 +203,23 @@ static int sh_serial_probe(struct udevice *dev)
>>   	priv->type	=3D plat->type;
>>   	priv->clk_mode	=3D plat->clk_mode;
>>  =20
>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>> +		struct reset_ctl rst;
>> +		int ret;
>> +
>> +		ret =3D reset_get_by_index(dev, 0, &rst);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to get reset line\n");
>> +			return ret;
>> +		}
>> +
>> +		ret =3D reset_deassert(&rst);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to de-assert reset line\n");
>> +			return ret;
>> +		}
>> +	}
>=20
> devm_reset_control_get_optional() or something should do here too , rig=
ht ?
>=20
> Note that R-Car does have SCIF reset too, so this can be generic code.

For R-Car systems the current behaviour is working and well tested, we
concluded that we shouldn't change it so this reset de-assert was made
RZ/G2L specific.

For RZ/G2L, de-asserting the reset is not optional.

Thanks,
Paul
--------------P7fy5kiwpDD1h8DPb6R41myr
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------P7fy5kiwpDD1h8DPb6R41myr--

--------------Njg10eEimM5KFtysTXt9Mm0l--

--------------qt9110ewRkU00Hvms6005wjL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR0mzgUDAAAAAAAKCRDbaV4Vf/JGvUWk
AQC+XZTip+V6DJ7Cmx2bTFwPm3pV1S0o/kon4gBYDMQaCwD8DUlihS18tmlnF3Jx9zVmESsqneS9
VT3hgx/PQxSXSQ4=
=3XlM
-----END PGP SIGNATURE-----

--------------qt9110ewRkU00Hvms6005wjL--
