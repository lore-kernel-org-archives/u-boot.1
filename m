Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936A2D38FF1
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 17:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2111C8063E;
	Wed, 14 Jan 2026 18:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="mZ1f9po9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2682283015; Wed, 14 Jan 2026 18:09:28 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF8580325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=QrJGctzQs9oqNG6J6j9VPRMIYG4zfkwbAQoM9buF5Mo=;
 b=mZ1f9po9/U4DAhvOwSLJdxo9YOngvGJ5GXyvvE3zF/hu2qoqKrS3JhqPXxthtAaulseiTKCvHtVqxtvny+QNxs2TNRfQaRL+ajKT51l7/xOifjZaFuDqAv5zuWD6N/VS09Fd7xrhc2tV8Hyoj1gbXCb0bQ9ZD31t/adG+fXLdfI=
Received: from dummy.faircode.eu (046124137030.public.t-mobile.at
 [46.124.137.30]) by mail.netcube.li with ESMTPSA
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128)
 ; Wed, 14 Jan 2026 18:09:25 +0100
Date: Wed, 14 Jan 2026 18:09:22 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Message-ID: <6cad4f1d-381e-489c-a7d3-1cd098e8fcdc@netcube.li>
In-Reply-To: <20260114001534.6062abaf@minigeek.lan>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
 <20250610053856.1873969-2-lukas.schmid@netcube.li>
 <20260114001534.6062abaf@minigeek.lan>
Subject: Re: [PATCH v2 1/2] sunxi: setup_environment: do not generate a MAC
 address when one is set using nvmem-cells
MIME-Version: 1.0
X-Correlation-ID: <6cad4f1d-381e-489c-a7d3-1cd098e8fcdc@netcube.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

14.01.2026 00:16:37 Andre Przywara <andre.przywara@arm.com>:

> On Tue, 10 Jun 2025 07:38:54 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi Andre,
>=20
> Hi Lukas,
>=20
>> Boards using MAC addresses stored in EEPROM via the device tree's
>> `nvmem-cells` mechanism may already have a valid MAC loaded by the
>> device model. However, setup_environment() currently ignores this
>> and generates a fallback address from the SoC SID if no environment
>> variable is set.
>>=20
>> This leads to a mismatch warning during boot when the kernel or U-Boot
>> detects the MAC from nvmem and compares it to the environment.
>>=20
>> This patch checks whether the corresponding ethernet device node
>> has a `nvmem-cells` property and skips generating a fallback MAC
>> if it does, thus avoiding redundant or incorrect ethaddr setup.
>=20
> So while this seems like a pragmatic solution, I feel it's not the
> right one: This "peeking into the DT to skip something" sounds
> backwards. You have probably investigated this more thoroughly, but how
> does this work here? Did the generic code already parse the MAC address
> and put it somewhere, and our code here was about to overwrite it? Or
> will the generic code later fill the gap, if the sunxi code didn't set a
> MAC address based on the SID?

At the time of running setup_environment is not yet set as a environment va=
riable and U-Boot will also not try to set it later since sunxi already set=
 one. I did not find a way in setup_env to check otherwise if there already=
 is a valid Mac somewhere.

U-Boot does know however that there is a different mac intended for the int=
erface as it throws a Mac address mismatch warning.

>=20
> I feel like the sunxi code is to blame here for doing it at the wrong
> time or using its own method instead of coordinating with the generic
> code, so I'd rather fix this properly than papering over it here.
>=20
> I will help you find a better solution, but if you can dump here what
> you learned, I'd be grateful, as I am too lazy atm to chase down the
> code ;-)
>=20
> Cheers,
> Andre
>=20
>> This improves compatibility with nvmem-based MAC provisioning and
>> aligns U-Boot behavior with Linux.
>>=20
>> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
>> ---
>> board/sunxi/board.c | 15 ++++++++++++++-
>> 1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
>> index ac9cefc6..41b85c66 100644
>> --- a/board/sunxi/board.c
>> +++ b/board/sunxi/board.c
>> @@ -774,10 +774,23 @@ static void setup_environment(const void *fdt)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>=20
>> =C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 4; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *alias;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nodeoffset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const fdt32_t *prop;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(ethaddr, "ethernet%d"=
, i);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fdt_get_alias(fdt, ethaddr))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alias =3D fdt_get_alias(fdt, ethad=
dr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!alias)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
>>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodeoffset =3D fdt_path_offset(fdt=
, alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nodeoffset >=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop =3D f=
dt_getprop(fdt, nodeoffset, "nvmem-cells", &len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prop &=
& len > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcp=
y(ethaddr, "ethaddr");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
