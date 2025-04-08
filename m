Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D50EC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 11:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7737882E86;
	Tue,  8 Apr 2025 13:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="TIQqrM7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD71882F4D; Tue,  8 Apr 2025 13:00:32 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FEC982B63
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 13:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxTDhrjR0c/C4MlVHPoT0iUl6DtsRo6zNrWLBmFEVyH1+1z9RDqOik8GsJl5ngpf9DEn4Dvz5sqzC7Z5hfI/aqtmMD9J6WjXBC4+69zhZy5qEu7RKdXj3zfGaqtDs8RMxOgH9XQDH5Yo40Kb2gBeHZB+Ydln67Y7zMWfsctdXdd07sbormkSd4pQug++o71ejKjzoMia874W+rq+VR2zg2xfS0J5BVxGQdDPw6NG53F9RCAiMMIUD5aGV6Os1WOXj+SjhrzH2arNYsJLWuNNrlZZ5csoxKEeWTLv6x6dbUoQjYMCIIhF10Hvvk7NVjAkKBBarolqiGQVDw//DYiMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwehBSUUyImH75946R+P5UIQWOloRWiU5lqhi2PsSO8=;
 b=xUT86vdln3JxdK6aA+sdltA3IO/M5u2eRadPH6KYcP0MOsVpkyC5cnASMKCUKhAunO2Jc4V3otsD54yOqEEkcqxiy9sPivUdKW9+BSbqXSZsTutumUWSojKCaoo85pmEKLH0GdddIgPRYzqoag/CaCuQxVwLDq4CTSpz75fYf7fuu9Fw4X2T6GfZktE7uUO2xiIJkXfOPCJIRNj2+MclUaNvFZhtzyz9YXJBaB0wNKrQUKQcYfoFArH2hpdVAkfhL3MxfKwugei4kgZVloG5DYh3lu8E8xdpu0qFZmZ684SMh61slCMgy2jaTTgmGAek2qHukd2Bim4M/OIiNiuLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwehBSUUyImH75946R+P5UIQWOloRWiU5lqhi2PsSO8=;
 b=TIQqrM7Gq1zGBGbVg5sbykFuwqZzU6uu5JFZvPYKV+ze2xZXxIvVGCuNGTBZ664y7zp2qavrICyn6qlQRrOUFwzyGb49kZ+QKT6tgzBsDNpsB19ZdEdBpGxIl3SP2MjgdE2dSGOZgayBYeegW9+Z2jqcgV1B843BjNtRgTrYH3QHW5yYvuLwyfe0HZiTL8mUo/kpKzmC7m4lGB3bbqKURq8VJhyp3TXwzSXowWHJGoygX6zW45eLIefT5n69D87na5rNScFIrPpX0HiRaRSJI1OlOcaq8IGFdSfpO1NaVtuunFVGFHZsnpxHYq39HnidOKT7qXUVdJIrh40pbG5YbQ==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by AM8P191MB1169.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 11:00:28 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 11:00:28 +0000
From: =?iso-8859-2?Q?Pawe=B3_Kochanowski?= <pkochanowski@sii.pl>
To: Gaurav Jain <gaurav.jain@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta
 <horia.geanta@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vYj/H+qJ2ybk2H3sZmwaA1kLOZjPCAgAAKHaA=
Date: Tue, 8 Apr 2025 11:00:28 +0000
Message-ID: <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|AM8P191MB1169:EE_
x-ms-office365-filtering-correlation-id: 73c412a1-b72b-4249-5ef7-08dd768c92db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-2?Q?2lkQHUmJv41bUkPOmI1XhCUa4C4RZ1lgLweFt7dRGw68TnM+9C+agbn2R0?=
 =?iso-8859-2?Q?0TGpH0no1rtuG5GfKtE75h9KuKqlA0mJ9RBBWWD/kssSHOYWAFa92Horg5?=
 =?iso-8859-2?Q?AoqY2yJ+ztCtmYLOQzdlwuP+MdJCx6DlpBVmocnnw/Z22cv+wVmDfB2+mM?=
 =?iso-8859-2?Q?Jjdh1IRQ/P6GPMe4jk63OXecHAdTs9sHcPS3CFHGmw2FPw1wI+VAqnXOMg?=
 =?iso-8859-2?Q?3LxzRa8NJdtjHzoPboxXqsQ5+gR6UZM0afnRSGk1BrF5xw85vi4vVcHyBg?=
 =?iso-8859-2?Q?pFRshLOv7v0q1Lqbf7iJFaA7o3U8sLjfIh/E6pZzYqtz6mek27gmw79Hqz?=
 =?iso-8859-2?Q?h61sAc9RtcBuXY9qmSjh6oJAu4NaUbhJ990isjeDEKhCJRdai8XA5OwIiz?=
 =?iso-8859-2?Q?WfPVNA0oH5kyT8r/L83lz/1NlS9tJ4HmHOUmnNRMWUFAnT9jGkScxyfkzH?=
 =?iso-8859-2?Q?w5fgpS70UUIN8SAr35mWQD3NmXZfWK714FiMpkSTRtZGvVj5Zo+UnC5ZQN?=
 =?iso-8859-2?Q?Jeb5MKDwTreOSG/G4H/TxuIjlKHWHxxDzXUSEBolozJ2T84zJgyBtCTldq?=
 =?iso-8859-2?Q?i46kar71ne87FhvCKOrKhuzT2VQ9FT710sYaXkwhBxifpuw5OXqrAZHKcN?=
 =?iso-8859-2?Q?LL83CCLdhgTLaeTs+Ffz/bTtKbbnmZ3tif6drYAzir+uwLdflxBgCHp/n8?=
 =?iso-8859-2?Q?4Ye+501/2SvKWuXolbyxKbHzG3uhdU40IA2ACo+A52zQxeGk/AfHbLmwqn?=
 =?iso-8859-2?Q?atGk8hI+dke+UiN0TNBvzwH1z0W8iipyBYU3mVL8EcMIpnNFa65i/YzmN9?=
 =?iso-8859-2?Q?WXVIP5VOX9Khiy6SrG6+0h7bTMHkmDIaRltdW+7+9/ugsnATdDXG6pmxP4?=
 =?iso-8859-2?Q?UfrnYmMqh89BADSrFQMYVSwVAu4wB6mR2LjcIeDEKtC3duJ9UrqQyGFL+b?=
 =?iso-8859-2?Q?jh196eT/Qn1WbEbe0z5Tj8ZlPyzQ+tsJO/IcxjJ17BpZ78XR5+MahcVFM9?=
 =?iso-8859-2?Q?VLCODJXsL31o4t8tN0osoG2gokp08jPGsKR2cZCVBYTINAkN7ftUIWWhFM?=
 =?iso-8859-2?Q?azBUbsAdQCQAHvXYe1CRDb7R8+4CLblh6CLV2IcpzY0kP6dgBLou2Z1gPN?=
 =?iso-8859-2?Q?aLwCjPCeTw7arOH4b8JAH8QhXB+oXG/+77CE5EZ/E3Umcec2CwjtakCMAP?=
 =?iso-8859-2?Q?YMm6EjP+yXy5EIbFn/rQjWB7WzeYdgWgbnjaHFq0grkVt7zBdC8cl70OEy?=
 =?iso-8859-2?Q?odcube87S+Dnxr1fJfVq1TR7ELc0q8noKJtUfMiEOuMbxrOit03OE8OT+S?=
 =?iso-8859-2?Q?k/5NQTnEA8quw7obj8DQPWuRUZQxOMxck3LMYmoHrTmycfccNwayn9JkAZ?=
 =?iso-8859-2?Q?FdF/5LzhDGbREiCM5FjiHAjpY8oGaEiOSm9PkBCG9FEjY44hoebNuZ6kXf?=
 =?iso-8859-2?Q?1xKTkg0gaaU9EVqNCkbJl17ZDht70VU9NkrA6AcSlguuXeQjaCYmtcSuBP?=
 =?iso-8859-2?Q?AmaV4QwQrDTZRhMStiXlQ8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?sXrQux5SlHsK4uDzzIoYM2V82sOISDMlwQXeqwGwpN5Er+n9+M5/9t/g3Q?=
 =?iso-8859-2?Q?eNIfPEmp/YVEcdpi5ZDpP3a8CPmydymqqc0bdM5bsfQ/7YUSvjp1NcNZoh?=
 =?iso-8859-2?Q?A03Af1Q/lcxhSTycilgehWtP4FMRevPMXUKAzm6Il6R7ibFsLItaUPmMEA?=
 =?iso-8859-2?Q?d/n4ddVnCcftkdPRy97tcAFejN1oYkmQz6xU5W7CNtrbsLk76PSE561SEy?=
 =?iso-8859-2?Q?QCPl2RWjWJrrewvryFu5MeHnMLH9+gaowKnmCyWS0PgpsoWpt9oC+Y3vdm?=
 =?iso-8859-2?Q?hWmrCgU23JX6itbwBrkejDiWznORwJ0/tLYPJcgywf9eRtJnSf0QFntR5S?=
 =?iso-8859-2?Q?xxoCR6HkuQUs/LvYqAoN87onCKD9I45KrrsWfnYEBeDrlomzs0CNrdJR5Y?=
 =?iso-8859-2?Q?JJb4LC3+er1i3WU/QX8JSmAYtGchmLKJF3imEGqlDEFzD4JpekTyO6fOKL?=
 =?iso-8859-2?Q?ezdBzO9IUTBXj9Gxrua/xMN1c0W32NkppK04fHBywiuC4FwxFSflVlj7ma?=
 =?iso-8859-2?Q?fEx7qHsd7bJaLmDYMMmR53ASND77OZO/1cHCrjIBX+GhUcwHakQwwQt+/n?=
 =?iso-8859-2?Q?rCKK6rq8Ny6w7oGvRqoKKh151tRMALL9cT0ws90DIY1tevKeRqGX+XRCm5?=
 =?iso-8859-2?Q?nJ1xJaXykMQif2gTkFxL2Ze7D29cd55R5WVXjOJimxFuJndYBlrVHbZ5/K?=
 =?iso-8859-2?Q?aYV/WH18QdFy/My1u8Bh4n+QOl2SDlqgDIjSRtnrAlMtlyP9cDlTWwdESY?=
 =?iso-8859-2?Q?Qoer2JJr8qPdtrY4M5C9BxURxAu0J1zGu0eQzLglG5G+/6d8GKIhqWOMjQ?=
 =?iso-8859-2?Q?72pLnGV7Qagk7I68Q1peRq5zOjr5589PNHroc2cCFnB+lVshiiXqo2591g?=
 =?iso-8859-2?Q?U4U83Bg7VQnlsYhgD77W72lA3GQp1BYxpZGX2YLZteHohyvkr0ASo0Fe4K?=
 =?iso-8859-2?Q?NZMSDr+XVgzsxtiTZfBQdNJhV4LexQBsU8rZgEcXNKVhOLqlX2uaDGqpUT?=
 =?iso-8859-2?Q?82FUUr1R0Z23EI6wFqro9TV0usnoLozD2y7R4ypW/0+nRqbH8qXlfxkkFx?=
 =?iso-8859-2?Q?MIh8TQIQ6hXtom9SX88hbkky4X/X5X05h4aFa4o3s7AgIoXELFTQA5OOPp?=
 =?iso-8859-2?Q?P0+tkBFUxg2p/IU7ZjhTj7CnaRwPjnSJgwX6Of29cJEB9+cMOzwP2difu2?=
 =?iso-8859-2?Q?tXovd1hmcAXyGAUJPIf80DUSkIBlnrHT+Bh4dje1zzOYcJwudrA/UXcltf?=
 =?iso-8859-2?Q?8YWBkRbiI2+b1J3ssN55HkSlTKcb7jZtCtwhJBvHzE9y6jpOKg6fBHFPXf?=
 =?iso-8859-2?Q?a0F/2vfsOyhCw+Fy/BOIC5USSbH2IZjjBu/cs9590Y0B5hfq6CsBP0QqmI?=
 =?iso-8859-2?Q?Jj1iHL0wtL7/M/MO6nDfZP2k634f491L58ehpHLwOo53gKcq+Vr68ClwGP?=
 =?iso-8859-2?Q?4v20BxiVpdwR/gt7tH6Z/cfciKw+G3M6mM1xKQgtvZkaz4JsszDaNzVi8Q?=
 =?iso-8859-2?Q?ZxFdddkp3T75pBXV+qjyEFY/La3HfdmCsn+qAsLFSTJZU5IhQ6rC6MdTbW?=
 =?iso-8859-2?Q?gID2pjMazn/1Ps5uWPfQLXXy8kvnU9s/sjnyul6GXmUc9zNRrBUoWq8jfn?=
 =?iso-8859-2?Q?lqFZGzxBaYL8LzHDGZgqhzYD5IgxhiHZ/R?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c412a1-b72b-4249-5ef7-08dd768c92db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 11:00:28.7672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEdmkmuB6dWCU5XG+gkAvG6BY8IOhcdz0hbd0gA/Qw0TZXnAsXvkXfRGtTOSiinPS2uz0hsuYtTB6lhVveMn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P191MB1169
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

Hi Gaurav,

What we see is that the jr_enqueue() called by run_descriptor_jr() swaps th=
e endianness of the descriptor in place (by modifying the data pointed by d=
esc_add):

	/* The descriptor must be submitted to SEC block as per endianness
	 * of the SEC Block.
	 * So, if the endianness of Core and SEC block is different, each word
	 * of the descriptor will be byte-swapped.
	 */
	for (i =3D 0; i < length; i++) {
		desc_word =3D desc_addr[i];
		sec_out32((uint32_t *)&desc_addr[i], desc_word);
	}

So the sequence looks like this:
1. caam_rng_probe sets correct descriptor in ` caam_rng_priv *priv`
2. caam_rng_read is called with 32B
3. caam_rng_read_one->run_descriptor_jr() is called to generate 16B with `p=
riv->desc` containing valid descriptor
4. The descriptor is swapped in jr_enqueue() before passing it to job ring
5. The loop in caam_rng_read is called second time, this time the `priv->de=
sc` contain swapped data.

Interesting thing is that the job still succeeds and that some data are pre=
sent in the buffers, but maybe swapped descriptor can also be a valid one?
The effect that we see is that when leaving the command executing this sequ=
ence we get an exception in "unrelated" place..

This is what we see when printing descriptor in the caam_rng_read_one on LS=
1046A:

First iteration:
0: B0800005
1: 82500002
2: 60340010
3: 0
4: FBC94DC0

Second iteration:
0: 050080B0
1: 02005082
2: 10003460
3: 0
4: C04DC9FB

BR,
Pawel.

> From: Gaurav Jain <gaurav.jain@nxp.com>
> Sent: Tuesday, April 8, 2025 12:09 PM
>=20
> Can you explain more details about this issue. Where it is being modified=
 in
> run_descriptor_jr() ?
> Regards
> Gaurav
>=20
> > -----Original Message-----
> > From: Pawel Kochanowski <pkochanowski@sii.pl>
> > Sent: Monday, April 7, 2025 6:17 PM
> > To: u-boot@lists.denx.de
> > Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gaurav Jain
> > <gaurav.jain@nxp.com>; Gabriel Nesteruk <gnesteruk@sii.pl>; Pawe=B3
> > Kochanowski <pkochanowski@sii.pl>
> > Subject: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
> > greater than 16 bytes
> >
> > [You don't often get email from pkochanowski@sii.pl. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using t=
he
> 'Report this email'
> > button
> >
> >
> > From: Gabriel Nesteruk <gnesteruk@sii.pl>
> >
> > Reinitialize the descriptor for each RNG job, as it may be modified by
> > run_descriptor_jr().
> > Failing to do so can result in memory corruption when
> > dm_rng_read() is called a second time on NXP devices with
> > CONFIG_SYS_FSL_SEC_BE enabled.
> >
> > Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> > Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> > ---
> >  drivers/crypto/fsl/rng.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c index
> > 06364948052..440b26e3c94 100644
> > --- a/drivers/crypto/fsl/rng.c
> > +++ b/drivers/crypto/fsl/rng.c
> > @@ -27,8 +27,14 @@ struct caam_rng_priv {  static int
> > caam_rng_read_one(struct caam_rng_priv *priv)  {
> >         int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE,
> > ARCH_DMA_MINALIGN);
> > +       ulong rng_desc_size =3D ALIGN(CAAM_RNG_DESC_LEN,
> > + ARCH_DMA_MINALIGN);
> >         int ret;
> >
> > +       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > +               CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > +       flush_dcache_range((unsigned long)priv->desc,
> > +         (unsigned long)priv->desc + rng_desc_size);
> > +
> >         ret =3D run_descriptor_jr(priv->desc);
> >         if (ret < 0)
> >                 return -EIO;
> > @@ -63,14 +69,6 @@ static int caam_rng_read(struct udevice *dev, void
> > *data, size_t len)
> >
> >  static int caam_rng_probe(struct udevice *dev)  {
> > -       struct caam_rng_priv *priv =3D dev_get_priv(dev);
> > -       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
> > -
> > -       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > -                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > -       flush_dcache_range((unsigned long)priv->desc,
> > -                          (unsigned long)priv->desc + size);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.43.0

