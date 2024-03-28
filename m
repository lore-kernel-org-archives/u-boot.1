Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE74C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93497880B2;
	Thu, 28 Mar 2024 12:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ffnTZYPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4C587DE6; Thu, 28 Mar 2024 12:17:35 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0259B880B2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8F5136147D;
 Thu, 28 Mar 2024 11:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923CBC433C7;
 Thu, 28 Mar 2024 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711624650;
 bh=pPrFwXbQJ33qJaLhBXcc0rL9iaE08ZcTvuFQ14y3RgM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ffnTZYPCREKgrhTBgRzQRA5parfUBBbd8p2t9hTG2p2yYtX7NXA+RfmD6nBmxzyg1
 Apd+VXLpuDXZDhC2wdHRLOFPipSD1GT7ncOHgzprHUpMIi/twiHcXQA8wYq2Qxzh/Q
 D/pFtc3rD2V6D9DklwjkGS/vWrfRBwBnlAxr/XjbujR20lh32cFJtxY69iNElyh9l7
 Bexv7fV92aMzNuJsVoWDjQlSHj0VIxBIg4ISOSFjSOIKyfXpPVPWc4ouUBPvPmfiBQ
 FOD2+TsMwTWpKjUwT/2Sd/1SyCf2mW1JEXmogdTxfLxG5LVqtNgJvn5cXDItHrEA7u
 gxzHMXRdXGomA==
Date: Thu, 28 Mar 2024 12:17:26 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v3 05/18] arm: mvebu: turris_omnia:
 Implement getting board information from MCU
Message-ID: <20240328121726.2a2f360f@dellmb>
In-Reply-To: <aa285a06-7fcd-42b9-9a85-29608162e2c3@denx.de>
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-6-kabel@kernel.org>
 <aa285a06-7fcd-42b9-9a85-29608162e2c3@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 28 Mar 2024 10:56:01 +0100
Stefan Roese <sr@denx.de> wrote:

> On 3/27/24 17:23, Marek Beh=C3=BAn wrote:
> > Implement reading board serial number, first MAC address and board
> > version from MCU. MCU supports board information if the FEAT_BOARD_INFO
> > feature bit is set in MCU features.
> >=20
> > Prefer getting board information from MCU if supported, fallback to
> > Atmel SHA chip.
> >=20
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
>=20
> Minor comment below. Other than this:
>=20
> Reviewed-by: Stefan Roese <sr@denx.de>
>=20
> Thanks,
> Stefan
>=20
> > ---
> >   board/CZ.NIC/turris_atsha_otp.c          | 27 +------
> >   board/CZ.NIC/turris_omnia/Makefile       |  2 +-
> >   board/CZ.NIC/turris_omnia/turris_omnia.c | 94 +++++++++++++++++++++++-
> >   3 files changed, 93 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/board/CZ.NIC/turris_atsha_otp.c b/board/CZ.NIC/turris_atsh=
a_otp.c
> > index a29fe36231..85eebcdf18 100644
> > --- a/board/CZ.NIC/turris_atsha_otp.c
> > +++ b/board/CZ.NIC/turris_atsha_otp.c
> > @@ -11,6 +11,7 @@
> >   #include <atsha204a-i2c.h>
> >  =20
> >   #include "turris_atsha_otp.h"
> > +#include "turris_common.h"
> >  =20
> >   #define TURRIS_ATSHA_OTP_VERSION	0
> >   #define TURRIS_ATSHA_OTP_SERIAL		1
> > @@ -32,26 +33,6 @@ static struct udevice *get_atsha204a_dev(void)
> >   	return dev;
> >   }
> >  =20
> > -static void increment_mac(u8 *mac)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 5; i >=3D 3; i--) {
> > -		mac[i] +=3D 1;
> > -		if (mac[i])
> > -			break;
> > -	}
> > -}
> > -
> > -static void set_mac_if_invalid(int i, u8 *mac)
> > -{
> > -	u8 oldmac[6];
> > -
> > -	if (is_valid_ethaddr(mac) &&
> > -	    !eth_env_get_enetaddr_by_index("eth", i, oldmac))
> > -		eth_env_set_enetaddr_by_index("eth", i, mac);
> > -}
> > -
> >   int turris_atsha_otp_init_mac_addresses(int first_idx)
> >   {
> >   	struct udevice *dev =3D get_atsha204a_dev();
> > @@ -84,11 +65,7 @@ int turris_atsha_otp_init_mac_addresses(int first_id=
x)
> >   	mac[4] =3D mac1[2];
> >   	mac[5] =3D mac1[3];
> >  =20
> > -	set_mac_if_invalid((first_idx + 0) % 3, mac);
> > -	increment_mac(mac);
> > -	set_mac_if_invalid((first_idx + 1) % 3, mac);
> > -	increment_mac(mac);
> > -	set_mac_if_invalid((first_idx + 2) % 3, mac);
> > +	turris_init_mac_addresses(first_idx, mac);
> >  =20
> >   	return 0;
> >   }
> > diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_o=
mnia/Makefile
> > index dc39b44ae1..341378b4e5 100644
> > --- a/board/CZ.NIC/turris_omnia/Makefile
> > +++ b/board/CZ.NIC/turris_omnia/Makefile
> > @@ -2,4 +2,4 @@
> >   #
> >   # Copyright (C) 2017 Marek Beh=C3=BAn <kabel@kernel.org>
> >  =20
> > -obj-y	:=3D turris_omnia.o ../turris_atsha_otp.o
> > +obj-y	:=3D turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
> > diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/tu=
rris_omnia/turris_omnia.c
> > index 6dfde5ee7a..f63640ad64 100644
> > --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> > +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> > @@ -18,6 +18,7 @@
> >   #include <asm/io.h>
> >   #include <asm/arch/cpu.h>
> >   #include <asm/arch/soc.h>
> > +#include <asm/unaligned.h>
> >   #include <dm/uclass.h>
> >   #include <dt-bindings/gpio/gpio.h>
> >   #include <fdt_support.h>
> > @@ -25,12 +26,14 @@
> >   #include <time.h>
> >   #include <turris-omnia-mcu-interface.h>
> >   #include <linux/bitops.h>
> > +#include <linux/bitrev.h>
> >   #include <linux/delay.h>
> >   #include <u-boot/crc.h>
> >  =20
> >   #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
> >   #include <../serdes/a38x/high_speed_env_spec.h>
> >   #include "../turris_atsha_otp.h"
> > +#include "../turris_common.h"
> >  =20
> >   DECLARE_GLOBAL_DATA_PTR;
> >  =20
> > @@ -186,6 +189,70 @@ static bool omnia_mcu_has_feature(u32 feature)
> >   	return feature & features;
> >   }
> >  =20
> > +static u32 omnia_mcu_crc32(const void *p, size_t len)
> > +{
> > +	u32 val, crc =3D 0;
> > +
> > +	compiletime_assert(!(len % 4), "length has to be a multiple of 4");
> > +
> > +	while (len) {
> > +		val =3D bitrev32(get_unaligned_le32(p));
> > +		crc =3D crc32(crc, (void *)&val, 4);
> > +		p +=3D 4;
> > +		len -=3D 4;
> > +	}
> > +
> > +	return ~bitrev32(crc);
> > +}
> > +
> > +/* Can only be called after relocation, since it needs cleared BSS */
> > +static int omnia_mcu_board_info(char *serial, u8 *mac, char *version)
> > +{
> > +	static u8 reply[17];
> > +	static bool cached;
> > +
> > +	if (!cached) {
> > +		u8 csum;
> > +		int ret;
> > +
> > +		ret =3D omnia_mcu_read(CMD_BOARD_INFO_GET, reply, sizeof(reply));
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (reply[0] !=3D 16)
> > +			return -EBADMSG;
> > +
> > +		csum =3D reply[16];
> > +		reply[16] =3D 0;
> > +
> > +		if ((omnia_mcu_crc32(&reply[1], 16) & 0xff) !=3D csum)
> > +			return -EBADMSG;
> > +
> > +		cached =3D true;
> > +	}
> > +
> > +	if (serial) {
> > +		const char *serial_env;
> > +
> > +		serial_env =3D env_get("serial#");
> > +		if (serial_env && strlen(serial_env) =3D=3D 16) {
> > +			strcpy(serial, serial_env); =20
>=20
> Usage of strcpy() is discouraged AFAIK.

Yeah, it would make sense to use strncpy, but the potential leak is
prevented by strlen() check.

Marek
