Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F2C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 10:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3B681FAA;
	Mon, 24 Mar 2025 11:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCF881FBC; Mon, 24 Mar 2025 11:12:52 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id AA76281F6B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 69IYp1pkQ0eOZ7Dd7NtH+A==
X-CSE-MsgGUID: IcSWvV9mSVKwQkT7wZu4IA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 24 Mar 2025 19:12:46 +0900
Received: from [10.226.93.161] (unknown [10.226.93.161])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id C26334015FB8;
 Mon, 24 Mar 2025 19:12:43 +0900 (JST)
Message-ID: <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
Date: Mon, 24 Mar 2025 10:12:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FynwukstrfVGtXnP042eNvyP"
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
--------------FynwukstrfVGtXnP042eNvyP
Content-Type: multipart/mixed; boundary="------------QR8Gk9BIErFGAd3hkiQnqIik";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Message-ID: <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
In-Reply-To: <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>

--------------QR8Gk9BIErFGAd3hkiQnqIik
Content-Type: multipart/mixed; boundary="------------OrXvczy3lpuDog70YYdZDhWI"

--------------OrXvczy3lpuDog70YYdZDhWI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/03/2025 01:11, Marek Vasut wrote:
> On 3/19/25 1:03 PM, Paul Barker wrote:
>=20
> [...]
>=20
>> +++ b/drivers/net/Kconfig
>> @@ -864,7 +864,7 @@ config RENESAS_RAVB
>>   	select PHY_ETHERNET_ID
>>   	help
>>   	  This driver implements support for the Ethernet AVB block in
>> -	  Renesas M3 and H3 SoCs.
>> +	  several Renesas R-Car and RZ SoCs.
>=20
> RZ/G instead of RZ , right ?

This will also be used for RZ/V2L.

>=20
>>  =20
>>   config MPC8XX_FEC
>>   	bool "Fast Ethernet Controller on MPC8XX"
>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>> index ecf6e05f47eb..86aa5cd5835c 100644
>> --- a/drivers/net/ravb.c
>> +++ b/drivers/net/ravb.c
>> @@ -31,6 +31,7 @@
>>   #define RAVB_REG_CSR		0x00C
>>   #define RAVB_REG_APSR		0x08C
>>   #define RAVB_REG_RCR		0x090
>> +#define RAVB_REG_RTC		0x0B4
>>   #define RAVB_REG_TGC		0x300
>>   #define RAVB_REG_TCCR		0x304
>>   #define RAVB_REG_RIC0		0x360
>> @@ -44,6 +45,7 @@
>>   #define RAVB_REG_GECMR		0x5b0
>>   #define RAVB_REG_MAHR		0x5c0
>>   #define RAVB_REG_MALR		0x5c8
>> +#define RAVB_REG_CSR0		0x800
>>  =20
>>   #define CCC_OPC_CONFIG		BIT(0)
>>   #define CCC_OPC_OPERATION	BIT(1)
>> @@ -65,14 +67,24 @@
>>   #define PIR_MDC			BIT(0)
>>  =20
>>   #define ECMR_TRCCM		BIT(26)
>> +#define ECMR_RCPT		BIT(25)
>>   #define ECMR_RZPF		BIT(20)
>>   #define ECMR_PFR		BIT(18)
>>   #define ECMR_RXF		BIT(17)
>> +#define ECMR_TXF		BIT(16)
>>   #define ECMR_RE			BIT(6)
>>   #define ECMR_TE			BIT(5)
>>   #define ECMR_DM			BIT(1)
>> +#define ECMR_PRM		BIT(0)
>>   #define ECMR_CHG_DM		(ECMR_TRCCM | ECMR_RZPF | ECMR_PFR | ECMR_RXF)
>>  =20
>> +#define CSR0_RPE		BIT(5)
>> +#define CSR0_TPE		BIT(4)
>> +
>> +#define GECMR_SPEED_10M		(0 << 4)
>> +#define GECMR_SPEED_100M	(1 << 4)
>> +#define GECMR_SPEED_1G		(2 << 4)
>> +
>>   /* DMA Descriptors */
>>   #define RAVB_NUM_BASE_DESC		16
>>   #define RAVB_NUM_TX_DESC		8
>> @@ -385,6 +397,16 @@ static void ravb_mac_init_rcar(struct udevice *de=
v)
>>   	writel(0, eth->iobase + RAVB_REG_ECSIPR);
>>   }
>>  =20
>> +static void ravb_mac_init_rzg2l(struct udevice *dev)
>> +{
>> +	struct ravb_priv *eth =3D dev_get_priv(dev);
>> +
>> +	setbits_32(eth->iobase + RAVB_REG_ECMR,
>> +		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
>> +		   ECMR_TE | ECMR_RE | ECMR_RZPF |
>> +		   (eth->phydev->duplex ? ECMR_DM : 0));
>=20
> Can you configure the ECMR extras in ravb_config() just before=20
> writel(mask, eth->iobase + RAVB_REG_ECMR); based on some private data=20
> flag, like '.is_rzg2l' , instead ?

ravb_config() has been split into ravb_config_rcar() &
ravb_config_rzg2l() by this patch series. So there is no longer a common
write to RAVB_REG_ECMR.

>=20
>> +}
>> +
>>   /* AVB-DMAC init function */
>>   static int ravb_dmac_init(struct udevice *dev)
>>   {
>> @@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice *d=
ev)
>>   	writel(mode, eth->iobase + RAVB_REG_APSR);
>>   }
>>  =20
>> +static void ravb_dmac_init_rzg2l(struct udevice *dev)
>> +{
>> +	struct ravb_priv *eth =3D dev_get_priv(dev);
>> +
>> +	/* Set Max Frame Length (RTC) */
>> +	writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);
>=20
> I assume this register is actually RZ/G2L specific ?

This register also exists on RZ/G2{H,M,N,E}, but in the Linux kernel
ravb driver it is only modified for RZ/G2L.

>=20
>> +}
>> +
>>   static int ravb_config(struct udevice *dev)
>>   {
>>   	struct ravb_device_ops *device_ops =3D
>> @@ -501,6 +531,22 @@ static void ravb_config_rcar(struct udevice *dev)=

>>   	writel(mask, eth->iobase + RAVB_REG_ECMR);
>>   }
>>  =20
>> +static void ravb_config_rzg2l(struct udevice *dev)
>> +{
>> +	struct ravb_priv *eth =3D dev_get_priv(dev);
>> +	struct phy_device *phy =3D eth->phydev;
>> +
>> +	writel(CSR0_TPE | CSR0_RPE, eth->iobase + RAVB_REG_CSR0);
>> +
>> +	/* Set the transfer speed */
>> +	if (phy->speed =3D=3D 10)
>> +		writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
>=20
> Since this patch adds .has_reset flag, wouldn't it be possible to add=20
> another flag called something like .has_10 flag and simply do:
>=20
> if (eth->has_10 && phy->speed =3D=3D 10)
>    writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
>=20
> ?

The layout of RAVB_REG_GECMR differs between RZ/G2L and RZ/G2{H,M,N,E},
so we can't use the same constants for all platforms. We also need the
additional write to RAVB_REG_CSR0 for RZ/G2L so it's worth having the
ravb_config_rzg2l() function instead of a couple of flags.

Thanks,

--=20
Paul Barker
--------------OrXvczy3lpuDog70YYdZDhWI
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------OrXvczy3lpuDog70YYdZDhWI--

--------------QR8Gk9BIErFGAd3hkiQnqIik--

--------------FynwukstrfVGtXnP042eNvyP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ+EwGgUDAAAAAAAKCRDbaV4Vf/JGvW43
AQCRMHNlVyij9Tp+c+/oa8cZ1g6NkLD8BMx+lP9Upj+XNgEAn849MaVSLIRxyBnU1NZqzTgaMIez
WYdW6ekBzKMx3gI=
=iLGe
-----END PGP SIGNATURE-----

--------------FynwukstrfVGtXnP042eNvyP--
