Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF37E93709
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECCE286CA7;
	Thu,  5 Oct 2023 14:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B5286C6E; Thu,  5 Oct 2023 14:08:48 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 423B986C26
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 14:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,202,1694703600"; 
 d="asc'?scan'208";a="178294267"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2023 21:08:40 +0900
Received: from [10.226.93.50] (unknown [10.226.93.50])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id C14A94841A46;
 Thu,  5 Oct 2023 21:08:38 +0900 (JST)
Message-ID: <6514beaa-6584-84de-883a-69933e0f54db@bp.renesas.com>
Date: Thu, 5 Oct 2023 13:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <20231004134308.oaeqeolblr4ex2l5@GBR-5CG2373LKG.adwin.renesas.com>
 <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
 <20231004163858.zeuxy64olun5iini@GBR-5CG2373LKG.adwin.renesas.com>
 <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gpiqR3m5FpgGx93xow6UOvb0"
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
--------------gpiqR3m5FpgGx93xow6UOvb0
Content-Type: multipart/mixed; boundary="------------hqDjhuN9i2bA0Rc3X0GpeJfB";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <6514beaa-6584-84de-883a-69933e0f54db@bp.renesas.com>
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <20231004134308.oaeqeolblr4ex2l5@GBR-5CG2373LKG.adwin.renesas.com>
 <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
 <20231004163858.zeuxy64olun5iini@GBR-5CG2373LKG.adwin.renesas.com>
 <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>
In-Reply-To: <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>

--------------hqDjhuN9i2bA0Rc3X0GpeJfB
Content-Type: multipart/mixed; boundary="------------TnNyltD0aIXJzWQNqw0AnJPR"

--------------TnNyltD0aIXJzWQNqw0AnJPR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2023 20:41, Marek Vasut wrote:
> On 10/4/23 18:38, Paul Barker wrote:
>> On Wed, Oct 04, 2023 at 05:17:55PM +0200, Marek Vasut wrote:
>>> On 10/4/23 15:43, Paul Barker wrote:
>>>> On Wed, Oct 04, 2023 at 02:26:49PM +0200, Marek Vasut wrote:
>>>>> On 10/4/23 10:48, Paul Barker wrote:
>>>>>> On 03/10/2023 14:23, Marek Vasut wrote:
>>>>>>> On 9/20/23 14:42, Paul Barker wrote:
>>>>>>>> Extend the existing driver to support the SCIF serial ports on t=
he
>>>>>>>> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure =
that the
>>>>>>>> relevant reset signal is de-asserted before we try to talk to th=
e SCIF
>>>>>>>> module.
>>>>>>>>
>>>>>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>>>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>>>>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.=
com>
>>>>>>>> ---
>>>>>>>>      arch/arm/mach-rmobile/Kconfig |  1 +
>>>>>>>>      drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++=
++++++--
>>>>>>>>      drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>>>>>>>>      3 files changed, 49 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobi=
le/Kconfig
>>>>>>>> index 973e84fcf7ba..0ab22356aee5 100644
>>>>>>>> --- a/arch/arm/mach-rmobile/Kconfig
>>>>>>>> +++ b/arch/arm/mach-rmobile/Kconfig
>>>>>>>> @@ -77,6 +77,7 @@ config RZG2L
>>>>>>>>      	imply RENESAS_SDHI
>>>>>>>>      	imply CLK_RZG2L
>>>>>>>>      	imply PINCTRL_RZG2L
>>>>>>>> +	imply SCIF_CONSOLE
>>>>>>>>      	help
>>>>>>>>      	  Enable support for the Renesas RZ/G2L family of SoCs, in=
cluding the
>>>>>>>>      	  the RZ/G2L itself (based on the R9A07G044 SoC).
>>>>>>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_=
sh.c
>>>>>>>> index 5e543dbf3d58..a2e9a57137a6 100644
>>>>>>>> --- a/drivers/serial/serial_sh.c
>>>>>>>> +++ b/drivers/serial/serial_sh.c
>>>>>>>> @@ -17,6 +17,8 @@
>>>>>>>>      #include <linux/compiler.h>
>>>>>>>>      #include <dm/platform_data/serial_sh.h>
>>>>>>>>      #include <linux/delay.h>
>>>>>>>> +#include <dm/device_compat.h>
>>>>>>>> +#include <reset.h>
>>>>>>>>      #include "serial_sh.h"
>>>>>>>>      DECLARE_GLOBAL_DATA_PTR;
>>>>>>>> @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *po=
rt, int clk, int baudrate)
>>>>>>>>      static void handle_error(struct uart_port *port)
>>>>>>>>      {
>>>>>>>> -	sci_in(port, SCxSR);
>>>>>>>> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>>>>>>>> +	/* The RZ/G2L datasheet says that error conditions are cleared=
 by
>>>>>>>> +	 * resetting the error bits in the FSR register to zero.
>>>>>>>
>>>>>>> Can you be more specific here ?
>>>>>>>
>>>>>>> It doesn't seem Linux sh-sci.c driver does anything special for G=
2L, so
>>>>>>> is this special case really needed ?
>>>>>>
>>>>>> On page 1268 of the datasheet (R01UH0914EJ0130 Rev.1.30):
>>>>>>
>>>>>> "DR is cleared to 0 when DR =3D 1 is read and then 0 is written to=
 the DR
>>>>>> flag."
>>>>>>
>>>>>> On page 1270:
>>>>>>
>>>>>> "[Clearing condition]
>>>>>> =E2=97=8F When 0 is written to ER after it has been read as 1"
>>>>>>
>>>>>> So zeros must be written to clear these errors, not ones.
>>>>>>
>>>>>> We have an open task to investigate the issue in the Linux driver =
and
>>>>>> fix it.
>>>>>
>>>>> Is the G2L UART broken in Linux ?
>>>>
>>>> Likely yes, but we need to reproduce the issue.
>>>>
>>>>> Does it misbehave in U-Boot ?
>>>>
>>>> Yes, before I changed this, if a framing error occurred it could nev=
er
>>>> be cleared and the serial port stopped sending/receiving data.
>>>>
>>>> The framing error was triggered by accident by unnecessarily re-doin=
g
>>>> pinmuxing for the serial port after TrustedFirmware had already set =
it
>>>> up correctly. Since SCIF0 is wired to an FTDI USB/serial adaptor chi=
p on
>>>> the SMARC carrier board, it seems very difficult to trigger a framin=
g
>>>> error in any other way, the FTDI chip is too well behaved.
>>>
>>> Is it possible to trigger this on RZ/G2<non-L> with SCIF on those pla=
tforms
>>> as well ?
>>
>> It's not been seen or reported to my knowledge, but it's on our list t=
o
>> look into further.
>=20
> Can you give it a quick try ? I'd really like to avoid G2L specific
> behavior here if it can be avoided.
>=20
> Is there a testcase ?


The case we're interested in here is the Receive Error (ER) & Break
Detect (BRK) conditions. I've done some further datasheet digging...

RZ/G2L datasheet says these are cleared by writing zero to the
appropriate bits of the FSR register.

RZ/G2{H,M,N,E} datasheet says the same (pages 50-18 & 50-19 of
R01UH0808EJ0111 Rev.1.11).

The R-Car Gen3 Hardware Manual says the same (pages 55-18 & 55-19 of
R19UH0105EJ0230 Rev.2.30).

For R-Car S4, there is an Excel spreadsheet attached to page 105-5 of
the datasheet (R19UH0161EJ0100 Rev.1.00) which again says the same.

For R-Car V4H, the relevant info is on pages 105-16 & 105-18 of the
datasheet (R19UH0172EJ0081 Rev.0.81) and says the same.

On the RZ/G2L I was able to reproduce a break condition by changing
pinmux settings after the SCIF interface has been configured. You could
try this out on an R-Car system, but I don't think it's guaranteed to
cause a break condition, it may depend on how the port input is
implemented in those SoCs. From my reading, the only guaranteed way to
cause a break condition is to hold the Rx signal low, and you might need
to solder on some extra wires on to a board to be able to do that.

We should still fix the error handling here, even if the boards we have
don't easily cause Receive Errors or Break conditions, other folks may
have their own boards based on these SoCs.

If you're happy I'll go ahead and check IS_ENABLED(CONFIG_RCAR_64) here
instead of IS_ENABLED(CONFIG_RZG2L).

Thanks,
Paul
--------------TnNyltD0aIXJzWQNqw0AnJPR
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------TnNyltD0aIXJzWQNqw0AnJPR--

--------------hqDjhuN9i2bA0Rc3X0GpeJfB--

--------------gpiqR3m5FpgGx93xow6UOvb0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR6nRQUDAAAAAAAKCRDbaV4Vf/JGvfZl
AQCfs5TfkItZgzRWtUEGtI51/V2O3TtIzxiVphb0xk76sgD8Cfl+PLAPcX4XRDoweVOThIdffJ6Y
+M4Qqlwb7RfzxwU=
=48B0
-----END PGP SIGNATURE-----

--------------gpiqR3m5FpgGx93xow6UOvb0--
