Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCFEE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33727894EA;
	Thu,  5 Dec 2024 20:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9513789512; Thu,  5 Dec 2024 20:12:48 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 1F27A894EA
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: /9qjOBG6TTedGL3q58ULYA==
X-CSE-MsgGUID: hAbGChT6Q1qMgwgKZ2wrOQ==
X-IronPort-AV: E=Sophos;i="6.12,211,1728918000"; 
 d="asc'?scan'208";a="227033655"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 04:12:43 +0900
Received: from [10.226.92.29] (unknown [10.226.92.29])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1BD744068419;
 Fri,  6 Dec 2024 04:12:28 +0900 (JST)
Message-ID: <dfffeed9-af65-4739-b01a-361dfed24c10@bp.renesas.com>
Date: Thu, 5 Dec 2024 19:12:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] net: ravb: Support up to two instances
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-10-paul.barker.ct@bp.renesas.com>
 <9bd496f2-7765-4067-bbc6-36b355107af3@mailbox.org>
 <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>
In-Reply-To: <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lTTH0pFN1Hr1cnWvdlnmoHOk"
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
--------------lTTH0pFN1Hr1cnWvdlnmoHOk
Content-Type: multipart/mixed; boundary="------------1QTURhB7tVuTE1G0dERr44Bh";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Message-ID: <dfffeed9-af65-4739-b01a-361dfed24c10@bp.renesas.com>
Subject: Re: [PATCH 09/14] net: ravb: Support up to two instances
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-10-paul.barker.ct@bp.renesas.com>
 <9bd496f2-7765-4067-bbc6-36b355107af3@mailbox.org>
 <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>
In-Reply-To: <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>

--------------1QTURhB7tVuTE1G0dERr44Bh
Content-Type: multipart/mixed; boundary="------------HkwwfT0pUoQIdNCL6UH0n0K4"

--------------HkwwfT0pUoQIdNCL6UH0n0K4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On 28/10/2024 09:50, Paul Barker wrote:
> On 27/10/2024 16:25, Marek Vasut wrote:
>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>>   int ravb_of_to_plat(struct udevice *dev)
>>>   {
>>>   	struct eth_pdata *pdata =3D dev_get_plat(dev);
>>> -	const fdt32_t *cell;
>>> +
>>> +	if (bb_miiphy_index >=3D bb_miiphy_buses_num) {
>>> +		dev_err(dev, "ravb driver supports only 1 or 2 devices!\n");
>> Hmmmm, I really do not like this, can we make this dynamic ?
>>
>> Unless you want to take a look at this yourself, I can add it into my =
todo ?
>=20
> I think the real solution here would be to separate the bb_miiphy
> operations from the bus instance, so we would have something like:
>=20
>     struct bb_miiphy_bus {
>         struct bb_miiphy_ops *ops;
>         void *priv;
>     };
>=20
>     struct bb_miiphy_ops {
>         int (*init)(struct bb_miiphy_bus *bus);
>         int (*mdio_active)(struct bb_miiphy_bus *bus);
>         int (*mdio_tristate)(struct bb_miiphy_bus *bus);
>         int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
>         int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
>         int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
>         int (*delay)(struct bb_miiphy_bus *bus);
>     };
>=20
>     int bb_miiphy_bus_register(const char *name,
>                                struct bb_miiphy_ops *ops,
> 			       void *priv);
>=20
> Where drivers will call `bb_miiphy_bus_register()` from the probe
> function, it will create a `struct bb_miiphy_bus` instance and a
> `struct mii_dev` instance then call `mdio_register()`. The driver can
> then support an arbitrary number of MDIO busses from a single constant
> `struct bb_miiphy_ops` instance.
>=20
> The bb_miiphy_getbus() function should be dropped from miiphy.c.
> Instead, the priv pointer in the `struct mii_dev` instance can point to=

> the appropriate `struct bb_miiphy_bus` instance.
>=20
> It looks like all users of CONFIG_BITBANGMII also set
> CONFIG_BITBANGMII_MULTI, and there don't seem to be any targets that
> define the macros documented in README.bitbangMII (lines 15-22). So, we=

> can drop the non-BITBANGMII_MULTI code from miiphybb.c and simplify
> things a lot.
>=20
> That's non-trivial but it's not a huge set of changes, maybe something
> we could target for v2024.04?

We've got several of the other patches from this series merged now after
v2 so I'm coming back to this one. I think we should take this patch
as-is and then follow up with general improvements to the bb_miiphy
support. Are you happy with that? If so I will re-send it along with a
re-worked version of patch 11 from this series (net: ravb: Add RZ/G2L
Support).

Thanks,

--=20
Paul Barker
--------------HkwwfT0pUoQIdNCL6UH0n0K4
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------HkwwfT0pUoQIdNCL6UH0n0K4--

--------------1QTURhB7tVuTE1G0dERr44Bh--

--------------lTTH0pFN1Hr1cnWvdlnmoHOk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ1H7GwUDAAAAAAAKCRDbaV4Vf/JGvZkq
AP9uJf4aG1SvVIdJAOApizHub3mpBpkVQVGw/YbkwKDuYgEAy8lsusDJgWqoZnMY3UboFqtFm0i5
fDRXcHzhp2ASkQs=
=/W/e
-----END PGP SIGNATURE-----

--------------lTTH0pFN1Hr1cnWvdlnmoHOk--
