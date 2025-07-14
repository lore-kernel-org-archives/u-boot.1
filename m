Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D1C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62D082F49;
	Mon, 14 Jul 2025 17:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="Pwsm8Xfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69ED82FC7; Mon, 14 Jul 2025 17:27:36 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C530282E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg3AFqXf1WoQ6Y3X+M5M1C7a4HTD5a1ufAxcczh6EOWDNbv2vPZyyyGacoqb2p+CKEkUG3/7BiXa1Vri4G+wcpwvsRMkw8eHe+HXB/8+W4ckr3DLYQXG17UykA+t+lJemnmHvpr2g7+c+JLLUwIU4KLM8xYtPe0KPhClTFkkJEI6GTVHUGYWRk2HJ3igmvqBpw0A7DfSWJcSm5LQwey87MfmBcIf4cxgbeMmQhLdWuKxoX1qKcGxxMkOhxLqYGaX3AnbfDHBHH5V+XlZMiAu1BGTyKhKVNBN8suPpVbFPqPNMYLr6mDv68QCWwMabysPBCQ84awFSBx0vTtl1xZwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12VU31WmXtTl49H5fkENGg6E3TCSWHbLd2JfE0CnZ3U=;
 b=MdBSh80gMCEA2Cqwp+tmWeChmo5uftxLsWAn+8G0zEJRQ5tK4W/9SSoYPA9EPDNQORzvQpHeFcPJNekkx1h2dLtXp0+/08s5Kgy6LMcUosk0EO5jbscdrPuIgSq1aXot1dBB1pAnoPaLMXG8kYaKwVNT3uPD9iDLd18Njyttdr4gVS4+1tOKvfXfu3p4RUhcgmm3gyNtJJwZK0TxXh/LYDF4iYUVN3wV/UivIfrofG3Z/MlybBQmq1SbtERQtpVJnwD7lJ8/xoV7YYoEMU7FCvOQqeVcgwoIJeub8YxpefaV9YSbSxgzNO9A7MoRjkOFq3YDVfDcxvNYixdQaq1cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12VU31WmXtTl49H5fkENGg6E3TCSWHbLd2JfE0CnZ3U=;
 b=Pwsm8XfkU0R/CJzJCIdJ5lBa3mEhoZTVLWXOH3+otaVwi7icvMHZ2GmpBgD6sv8t5n8qj0R6uAh4SLeEFWbY8f4EYxdOWaFwthtqkv6PCZo+KICidyEB/nQA0kX9cfhMIBa1rcQRYZ1fje5yMleg9dt8QhqnPu/BJ3WQavSBZHczkWBwxcWJYQxaLJ2MD6827dEzFexBFTNxM8PTWdYfq4DWgwdsju0ROgRJQN+a0aHrx/zzTP+SZKG2QdEmieQTt+OiNCJLAuWgNRs7ZP8sfqHA08NcxI62Ou0PV7akYduNo/iRwh33NrG6ewNVvPUEZteBVn9IgcXkUExbEOzz0Q==
Received: from AM9PR06MB7843.eurprd06.prod.outlook.com (2603:10a6:20b:3a2::11)
 by PA4PR06MB7216.eurprd06.prod.outlook.com (2603:10a6:102:d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:27:32 +0000
Received: from AM9PR06MB7843.eurprd06.prod.outlook.com
 ([fe80::ccee:fd8e:4e65:1bd2]) by AM9PR06MB7843.eurprd06.prod.outlook.com
 ([fe80::ccee:fd8e:4e65:1bd2%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:27:32 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tomas Alvarez Vanoli
 <tomas.alvarez-vanoli@hitachienergy.com>
Subject: RE: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Thread-Topic: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Thread-Index: AQHb9MJdEQ5YBzZK40WFzT8hfeW5ILQxtD4AgAAAqhCAAAEOgIAABxqQ
Date: Mon, 14 Jul 2025 15:27:32 +0000
Message-ID: <AM9PR06MB78434DBE25572F3CCF32A25DF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
 <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
 <20250714145212.GF13084@bill-the-cat>
 <AM9PR06MB7843D024FB26194DC5AE943CF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
 <20250714145821.GG13084@bill-the-cat>
In-Reply-To: <20250714145821.GG13084@bill-the-cat>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR06MB7843:EE_|PA4PR06MB7216:EE_
x-ms-office365-filtering-correlation-id: 856dbf34-49be-4b9e-1a9d-08ddc2eaf39e
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?58/CjHeUkrqsLq9EANQ2Cf/jvN+GCM3ag2kIkJKMcqqZPe+3Lp2y8TzxSAs7?=
 =?us-ascii?Q?AdOUe+5UcOLiESC0+n6l1bCt1+b8MYOYd9fZBYB7+SvRyk4Z39Q9t8DqvPBy?=
 =?us-ascii?Q?Z0cIXmEGLJ1nfChikXDz9RrwWKhCTMvIjRFDL7tmAO51kz+b28WV9aoeU08n?=
 =?us-ascii?Q?VkgRG4FO2N+FY4KtTvg8ft4g7qXFcuNa3AtTXLEjS0SMPSUSMee74VY78iVe?=
 =?us-ascii?Q?eN5IYOwwxdPZFjDOy6PjJYaPpluUk6QjDpOXbdhlhMfDfjlu14EXuoJtPVTq?=
 =?us-ascii?Q?rtTkcP6+8l40TrvO6iSk69esUeoWCeDfjJCpiR1a+TZD2dJxw1lu3CzSnELr?=
 =?us-ascii?Q?gtkqkA+e6XpscZD8oHl/ale5zjkbdoymgHi0db3kvDDGJmNAyYOKiH+C+kdU?=
 =?us-ascii?Q?O80Zl9UmFvuKqP6lEMDPQvDgX6Uo9RHlJJu+U34DjTnArJXBWNjowHhMBli7?=
 =?us-ascii?Q?DnX3sYreN/8mMxEjrmNulIN0EOARAkeyfBbOHip2PxkRJoTsog4dsR/sPbil?=
 =?us-ascii?Q?GVWPu3OFeg7YGYWL8XpxUZ15TWalcGxh1NezNq3641WKGcGoNDTfjBKOYHAO?=
 =?us-ascii?Q?hnPPSJ5kbCruXYZr16OJRp4398Wmben+hmwpaukQ49UmofPwySJnd1/PhxDX?=
 =?us-ascii?Q?TYWt6e8tcYUMwP4g3yR8wEsSmPJzcmX1OtzrAPQ90gJZ7pr1BgY0v7OXxSb3?=
 =?us-ascii?Q?Omrv+b189+ScKAUvRiNN8wSvLkG9ENRNqgTIxov4xSRM9IYVivTt6i4hGDlR?=
 =?us-ascii?Q?y6WPwJxex7SWy6ekubYzEfGgSr8f3T7vWYkkpz9+mXY7fIItjF2aMmDAl1ke?=
 =?us-ascii?Q?+5xQyKPsE+kah9r8eGbF6cJIxyyUIJCo+NdeM4FBQ38MDoVwJRm1ijfw4yny?=
 =?us-ascii?Q?LcmLtKuORfDZM9izvlAMUZU2yoFc8yzlkzaOC4dhCO4KvZsS/f/kcO9Giuwy?=
 =?us-ascii?Q?RuVB1t7BXKwtnWVT+EC+p8c3MIQlOuDLYLedRvM1Tl9mS2tVDESYXZWswFIl?=
 =?us-ascii?Q?3y5m1Zhc4KU9plqHS1t6OgM3fx2aWbzLfGVh2j42GXiTj97b3E/lxTIrLv9P?=
 =?us-ascii?Q?XtvR/u9EPQlaccHff6XLlTAzJ+slhZeeB4fVGJCT8cRUXK2zgRi0LXe+Nk8C?=
 =?us-ascii?Q?5SeEDB3VaqDfFF1PmgL3kW5vNikKawRMcbqvZRAuhELuRVLCIW0bnAvTmlbU?=
 =?us-ascii?Q?ncjKTHvl9NucFfH1RvJjy2+c4ph1cbk1xUKQEO2db1BiL/H13gL7xrPYYRXG?=
 =?us-ascii?Q?Y54NJHxhj+nZaVnw++3s3tMGgSvXStnNySlSwr+fZrEQTPdZQQvaiQ5cnqRM?=
 =?us-ascii?Q?0FFT63KAXGvTrGRRW1w8TNmEe0Xq4HMKtRU31+6Ma62wCiM0ak7NXm5jce6k?=
 =?us-ascii?Q?/Pn8OwiiEPFlioD0+M6XggFHedPJgo3hw/+pNMMnSWF/sv5fRjtuoa+Yi7Vy?=
 =?us-ascii?Q?RkdkE8HX3Wp3sSZZJYjm/v8o2p9k7gYOqwMByrQbEiiyq43+b8MOIQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR06MB7843.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vbw7VHgJpVm+urCtSosxu5k7T7qNLKnqfI9bI5bhurIuZuNrmui5/MzNBn3O?=
 =?us-ascii?Q?4JJbh13XiLek3fe2+km7dWd40wQs76d2tavXXXXmmO/z7xbbE6uFwFrqB9td?=
 =?us-ascii?Q?VMJruhjQARNHuY3InS3+bKSa8v5yUoWNYUV7r7Ow264SQndIan2pJN7i8Buz?=
 =?us-ascii?Q?E4XVMMSZO2Eiq8tS39gaiVjFHuR4MEYgeBZljCOCEg9yxXIxsM1ST+AUpGKG?=
 =?us-ascii?Q?yetZu4Ms1GtG9vY/yDgXb/E9AbsBG56rZiPxPRFz3ARbMTn5rVydY1qLB7ek?=
 =?us-ascii?Q?9MHoMcolCDgkwXaGEULDKBDSPW/CuQGDDF7G2jlzPTY1fjlz0Am0L+F4O6J3?=
 =?us-ascii?Q?6xEw7/0cysqHEcXOCD5uDzwJ0Y3GU5Ba/z/Iz3s3g2EQlB8P5+lkuUrgvlJI?=
 =?us-ascii?Q?GyUKFSXQovrNmYHipYGu8UPW8fHk9Cwxyv5vzx2cTyHHGp9IPvJ6j+RjM5VH?=
 =?us-ascii?Q?V+bz55hPYhrgSvrw1wcJ1hQJl5HO1wMQBFk6l2UNO/2lrV7uEfYqshlwQSut?=
 =?us-ascii?Q?GIBA/29l/18blvbSeRY5XjHAfEh1rmDyvbrauW7nN/T0Gis76bA7YtRubJYf?=
 =?us-ascii?Q?7PdaEVhB+4/mREx6j2jGd/Uej2umPWsRiqg+OYJFvj8Fv9qe+79hrSuuB7df?=
 =?us-ascii?Q?WSa33YxqEX8J7N3asLL2+ALlG4bY7/osIzUXQuF/PbmdcDgzoDpqkLOe+Ttm?=
 =?us-ascii?Q?jNK2JdaCKSVqw5Un1ek01HjxUCywRqnhKGXl/a+nMPF9YTRun9y6Ca0jfXJy?=
 =?us-ascii?Q?J5e+Vr2IIsYG6jKWKcAol7VAmH/iAg3KBeAZlLorgWaIcX7G6r6W4niktZzq?=
 =?us-ascii?Q?6a0S1KjivZzua2TfZbbEst9MqhytsusP4gWLkMPQr7B6w+jKl4B40RpQUTKg?=
 =?us-ascii?Q?zPXbQqzDxjQh2yASAl4vvIRgVEUQxNhWWC6hkVfeNBqkaD0AId1z6VR+292K?=
 =?us-ascii?Q?aW2LZvWw8vMHmohR0LgC0TdjGSb823Q9yLGZM0z6Pq0DU9H4X4NHfQc3zab0?=
 =?us-ascii?Q?pNtECN5X/stxS7LW1uux+podjTcAnFD6af3H3SmqypiGJX+zsxufEebsHkR+?=
 =?us-ascii?Q?V/9hQJA49+IRXOFqj2nwUZyz4LcMjcQr3RGXm1X/YCo9iRb9Dbgf7vOnIEdX?=
 =?us-ascii?Q?c/fe1f7suEgcLHRUDEzgXyhKX57HUC6QS7TMmeftJ77SWz0pc7ncAfNvGMkW?=
 =?us-ascii?Q?nw7Hto8FMB0g/l8AitN8kVPJIu6dV3n5TikwFri2j07JSnGbdNgiGSZFTpqq?=
 =?us-ascii?Q?af8+LGI+hflRLRVWeLXYVD1nsA2r32vq1cIQLheQ6HPtf6tXYNWLl8xzp3wT?=
 =?us-ascii?Q?+pToWwNwoP6BWTBgeON1w2D2YLt9ReXRu82OcYso5iEMaeT/8RY8Yue4v8EM?=
 =?us-ascii?Q?GzzowjzEVkhIH4++Ynu3oZviXsXsP5ULTZvTtPBXsdpmGOSadXOKWDrqd4GD?=
 =?us-ascii?Q?+s+2UJ9Rf9s/J17GUAuZW0UJLAI2ulwxJHodrsI109mc6b9LfcfBPNfppRRC?=
 =?us-ascii?Q?/IbAoH0COWNTdNT2glT7KWC9ciRlWGCnUQCB5elSflF/o5BdNoEF5O+uO+2B?=
 =?us-ascii?Q?TGq7cceNSZpLPaK3UIBP4tsOtHsvlX1woBNkrXPQYEWfRBUuI91Km33Tap/8?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7843.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856dbf34-49be-4b9e-1a9d-08ddc2eaf39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 15:27:32.1344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUkhTxPlfcqJlj3Yl7JVWtgLIpiFagxj3mtCnFcbwmBuNb6yYO9feqIr9unZOuB9uZYvmkJrKc3Pv66cRPlmz+VP2b+qC7CnmFFhjUJGKbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7216
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

> On Mon, Jul 14, 2025 at 02:57:41PM +0000, Holger Brunck wrote:
> > > On Mon, Jul 14, 2025 at 03:22:17PM +0200, Holger Brunck wrote:
> > >
> > > > This area was used for special purposes on kirkwood. On the
> > > > current designs we don't need this anymore.
> > > >
> > > > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> > > > ---
> > > >  board/keymile/Kconfig | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig index
> > > > 41458813858..3a66b2915ac 100644
> > > > --- a/board/keymile/Kconfig
> > > > +++ b/board/keymile/Kconfig
> > > > @@ -31,8 +31,7 @@ config KM_PHRAM
> > > >
> > > >  config KM_RESERVED_PRAM
> > > >  	hex "Reserved RAM"
> > > > -	default 0x0 if MPC83xx
> > > > -	default 0x1000 if MPC85xx || ARCH_LS1021A
> > > > +	default 0x0
> > > >  	depends on !ARCH_SOCFPGA
> > > >  	help
> > > >  	  Reserved physical RAM area at the end of memory for special
> > > purposes.
> > >
> > > Can the whole thing be removed then? Thanks.
> > >
> >
> > Good point, I can drop it completely. Should I send a v2 for the whole
> > series then or only for this one?
>=20
> Assuming there's no conflicts, v2 of just this patch is fine.
>=20

Ok done. Unfortunately, the patch shows up as a new patch.
I used the message id from patchwork to keep the relation with:
--in-reply-to=3D20250714132221.2471558-2-holger.brunck@hitachienergy.com
=20
Isn't that the right way to do it?

Best regards
Holger

