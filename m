Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E818C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6558A87A09;
	Mon,  4 Mar 2024 10:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Kk669kuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB28887D4E; Mon,  4 Mar 2024 10:00:00 +0100 (CET)
Received: from SINPR02CU002.outbound.protection.outlook.com
 (mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c401::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C4183414
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 09:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtl85YdVh0HTpYxunSqc1mBYjYlpi/tHzQDCepqN13Itn5C5UnIvGAd2kbhZb6YASxYNq5H89F/96ANDOUOiQAz4p6Ge99aOG7mGDd+k62m1OjG4p1FlkuWndzVKrBs8BARhbxDMQtjkkc5H+kkxZwNiNyZROoPfTsWdjldU7Zpz1meJRSF1/XZ/8sLBN5jwLOn5KwmlCjhRaH6VowvISMAs07rleIreMfU3RyWjwkVB50whPZtZrjTX3fwileSw1Q86tpeOvT7Wjj4s8rMV7THVLT+zdIcwEw0qGPyEM+XewK/iAQRJUabwe1jufa6AuNnny4Tvs1Vxnb0XPRnE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D/d/2w0gtmKs1LwgFKnIs8PtnlbpqamFJPJrAmx+tI=;
 b=BDuJzbM95/fUh56VsXCz1HassJvLb5eAGzmMUi9bsd7c3eeueEZohcRKvLIIxVKUp/AhYfwkmiblwTYvLI18riz2RVG3s39jtLx02m6cF4eEN/uSLAUqXXmgfchxePPxsbti5NE01jCZvorPFImFs+Vv6h5gUuk5cqrKnxErtAuqlUmGyeLT52HjLxR7qTvr3yu1O9LYZ4Rmv6tC16JQBLRrM8niPofOPyIethx6ZL+x61mwv2IFAvy3YumhN+8KDQar+LGcq81I+AUoaknyimp/fSLVY3dDgfmIEW6FMRxbFkj/Za//bSA72+5/rDvYcgja+uuihrKVo9JZTfNatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D/d/2w0gtmKs1LwgFKnIs8PtnlbpqamFJPJrAmx+tI=;
 b=Kk669kuW2arQITUyGycEIgQ1rNW9GB5yCdfifecLc1ClgeYHir75uRFkaeznOyKp9Rik9PCIREBOKTcTXbON9Iq/46o/9EoFSBvy16abAlOG0qf53+/hNBnT2txzxPWXWTEuqbD7zNrQdtevXumzjjhKOoH7rs0TPnah1zg2ad9tmn+0dh7wh/+x8qvNS4dYBp0nmWevR2I5WZ+ULDVk+7EmB6V2t1lBeruycQcsNGmZ/6nGGpzAKbdEXxJeOLdRl3fSve4G8r3lSm8GWk1k7yJrzsne8vzE2J/E9D4ep76dyUN4EtYmrfml2krvGUM/ySjY6cG/4ZQhaAPcUUvbEw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6413.apcprd06.prod.outlook.com (2603:1096:990:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:59:48 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::8a5:526c:6c7b:d7e2]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::8a5:526c:6c7b:d7e2%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:59:47 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: RE: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Thread-Topic: RE: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Thread-Index: AQHabhJOe4joAMy/7keN2hLpRxzRSg==
Date: Mon, 4 Mar 2024 08:59:47 +0000
Message-ID: <SEYPR06MB5134211DDFB9F9FDB0125F609D232@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
 <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
 <SEYPR06MB513483FE06C897839C5E3E5E9D592@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <901d6849-2e8d-4876-95b6-afdb9696d862@moroto.mountain>
In-Reply-To: <901d6849-2e8d-4876-95b6-afdb9696d862@moroto.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6413:EE_
x-ms-office365-filtering-correlation-id: bb945f66-7de0-4126-7e4e-08dc3c297165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfUrMWm46zs+hQTNs7r7XvUh7hWuQrk6XgSe3QSvTlwUsUJzw+bHEGXfapU/V+lUsUJuxdHf/X+PEt5Qp/xHz1jljSojfF6JTL0rpk4IcqiYc+f56uNTAilOGr6riv69Ey48YiDysuveA954T2aVAdv8HuC5T7TUoTUNSgYoVqX/huDrlAiTj7wHEUr8ujGJB/qKcO/EooueCMAw0aBbcy/reLr4VOFcfJWkiL4X45oNj/pWc7wY53tv6P9aDW2shTkMKm04DPA2zsOoSQM4s3fc2WreucDaxIxdL+iSFn+8enkOG7j386tqKsTTXEJUgQ/X4QVd+Fx+DCG0+tesK1pu0yYOSyfwGQ1AJH6IZhZLWDc6eC6YCp6gjRLt0sUVqILOfxLVz6hcbmETkzukjXtwsqZa1Y3C6HhdvOym45FiBSpFmKlREaJTPG5i6usqEAemdtKUYKNez1pNf6R9p9mV1Yt8UdQgosZcFLQmSSswWIQxhzQwlVE973qzW0jWN0W3ArjDI+3hSbN1LGVOk9CzD7tuiUUmjvljUsv2jkteizjQjMDT0AqjZxOEOBWKBuQuVCsVY0RF4KuAN1kvdG4UytwNgkNZK/GTE8qaaZ9g/Nb+tC8zXlncIRNEX1VZv6VE0715BlYklVG41DuP5FOIPRwQ7RnvOf0SDu5jWqUQYRimEhkqnVbYPEkwVHZv7HwGOr+iNRXkwrluVDYQ5HgolIIa3uFIUf96BaRgslg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB5134.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guXrG6MKL526ZrIUt1fMerFjOriYAHyjQC++RTCo8bAcNPJ2AipdH+8VNSUw?=
 =?us-ascii?Q?exEEJE+Mtdo/pcY1DmtBYFXw2ebnc9nsoJEHXWqGmx++l2WroNcg2tiBuPBP?=
 =?us-ascii?Q?8VuPomGc0c5pUnmx/il76/deBTaQQCBUcgEb2bFAM44fOS0QdTvjTtfQSDKp?=
 =?us-ascii?Q?mYXnUxns++2jAtlRvG+u6wdy34IAftJHhErzcsJpS/Ilp7zaJJHckuRdkSey?=
 =?us-ascii?Q?gDmOx+AGjQAgI90OZ9fzu/P5i+uOFMewxv7vwMZCOBrJ8Jt08AszL5RU+u3I?=
 =?us-ascii?Q?9Shhle4oMCrgnWWlPzvyRn96WDU2lPQJFubNsqLCCdAXHPXftgz2XBCcDy14?=
 =?us-ascii?Q?cm4HqmOt6KulxIF8ulEmUxbxC9VrJFTOBycJtS9bVDzSIysZY24ajmzDiDOl?=
 =?us-ascii?Q?90F4vD5ww28oRWN5Kho0/TjssTy54XQyJiFXz8q/MLiXQ7UE7o0vwbnheK8S?=
 =?us-ascii?Q?dLRzFsA5EDr9MItqsHdRxP8NvrvXujnDN5dBb2YR+6/jQPklHfEF5WL5eDZj?=
 =?us-ascii?Q?aN/nAjF6mjfvl8HTHpkRYC3WYehNSRxxNeW0J6+6O6lziHcv+ZCCULkh5+WH?=
 =?us-ascii?Q?U7YHRqQ6C9T6evRuNP4+iH0lpkUrbFEoI26gmJJ5t+CjF87Kg56I7Un5YqBy?=
 =?us-ascii?Q?F69Nv/Qo9ncWAFISL7pjtYR+hAmdrTDYSDIEn/jG7XtDsF0FBLwPhR/3BsUJ?=
 =?us-ascii?Q?jNfgSuK7pV2vZpAie4IO70R17RNG+dUBi+r/xMcrRwF1m1EZmCx9IEXce4mk?=
 =?us-ascii?Q?jxGeC/ZZA7iQbNKnk7jAE3pyy1Y1yhJK4/x5UHGAm3UTCQBtkW4ROLdFwBro?=
 =?us-ascii?Q?0lpBiJ4C/FQBxps5KGXdOFSGBXObHU60GvZytbdaaFihq+l/PDEQ6f+LBFLT?=
 =?us-ascii?Q?Ng8d6dL7TvxH3B6diRmUMwDtAaUQetBMrniCMEyUC2R8szjg2cqSbNux62Yf?=
 =?us-ascii?Q?/6J67wUiaeUNg+a5XXA7gvVIAgL0sZsVipkO/XCv9jBzSz+ygZMdDO3f18uu?=
 =?us-ascii?Q?uZc4qUPoqZzN2yQm8Q7XMBDkIkWe3ZIDmYjW64IuwyyMUmHAwjUABI3momcD?=
 =?us-ascii?Q?EQm3GgeCTTNEXeATDYEG5dfBPkA+HHrYh+GPvDDr5o76dNem4guQBhygridF?=
 =?us-ascii?Q?+UVy/43RZhbysKWC9QTO3YEPdMrd1YVy0c05m+0rHFPMthUEUTkReo1Qjtga?=
 =?us-ascii?Q?r54bTdwnrUxOUcdmtgBAICYtqPFX4WM5A9VOK2PjHWa2sEVnuxkhAysAcR6Q?=
 =?us-ascii?Q?z1gyCZ4YsrZKvJZj4KJXwfCUA7IG28aemAwQL6R45S4EvuyphNsRlwEkESsp?=
 =?us-ascii?Q?SZSu19+xluoa618Sm7cGJmSZkYKznw3R12Yfcy1HjGzE6IyNoa0V+3KyogBO?=
 =?us-ascii?Q?i6OlvbFJZ2xQCuuKLJiDHY5mLNcvpLQVjSbouiYYZpS4DUFZ6FP5X+DfonFx?=
 =?us-ascii?Q?AltBAIamI1BucwG8F5Pi/FPFm1LUPxQaC4rjtvoErq+12Wi7DFEfNM88lcjq?=
 =?us-ascii?Q?euJDrtAc9Z6eKTXsmNIr0xcEkmy7vpZpx3RX/xBNdrxNfcNkFY24oEuZ63Qu?=
 =?us-ascii?Q?49jCiNUAPzsKPL07G1/OgClCLG7DEKVALFrspTYW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb945f66-7de0-4126-7e4e-08dc3c297165
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 08:59:47.3373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hu/plEUbji+2GaEjsUxDdKNmTlifXQUAoz8qn9ZxerLuIxwFtjqzXNrEArTB7Bo7mMd3u0mSQ1wQq55Ex6GaTgA2NmkHwFnHOw4m6Tpsx9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6413
X-Mailman-Approved-At: Mon, 04 Mar 2024 10:31:30 +0100
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

> On Sun, Mar 03, 2024 at 02:14:43AM +0000, Jacky Chou wrote:
> > Hi Dan Carpenter,
> >
> > I have verified it on the little-endian platform, such as ASPEED AST260=
0.
>=20
> Awesome.  Thanks for this.
>=20
> > I think put_unaligned_be32() and htonl() functions have no effect on
> big-endian platforms.
> > And keep put_unaligned_be32() to help access the unaligned memory, such
> as pchecksum variable.
>=20
> Yes.  I know that.
>=20
> What I'm just puzzled by is how we ever merged this code when it doesn't =
work
> for little endian systems.  How was it tested originally?  How do the err=
ors
> look like?  Perhaps they're not as bad I assume from looking at the code.=
..

I am not sure how it was originally tested.
The first patch was based on Linux NC-SI driver.
I found the code in the Linux kernel where NC-SI calculates the checksum.
	...
	/* Fill with calculated checksum */
	checksum =3D ncsi_calculate_checksum((unsigned char *)h,
					   sizeof(*h) + nca->payload);
	pchecksum =3D (__be32 *)((void *)h + sizeof(struct ncsi_pkt_hdr) +
		    ALIGN(nca->payload, 4));
	*pchecksum =3D htonl(checksum);
	...
It gets the pointer of checksum field and call htonl() to do endian convers=
ion.
Linux NC-IS driver only performs endian conversion.

Thanks,
Jacky
