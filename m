Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68CAC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 12:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1489E88A6B;
	Thu,  8 Aug 2024 14:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bt.com header.i=@bt.com header.b="mlXYsAYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F9688A63; Thu,  8 Aug 2024 10:21:20 +0200 (CEST)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:261b::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FD7889E6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 10:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eden.hamilton@bt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD7bfYBDJ20gkbV9QvVWjKQKIOlk+ltsDW8EdZlWn/WiDeVv7mvvScNXbapuypY8nXVT7mH8lbBukd/jl3HmgyjCX+yrjtbIpUkwPYv27j/5F2v+DNM3RbN5C7Wot5lFU1lHvC93mzke9lRfpx53xMKIqEwgqQuUaPoubn8RmUIbJQh0na4ZS+5PKQjRFZ0T8BAF6cLXnWFPHEIpF4i4JiaggACawrB2lCQJNEOjyz25sXt6OweBiTugeLhEFCqwHZsbeK9xJNXljq0F1OrDwRzAXQ+TV6vynUyhoUWUWtanD5XIpx9q5X2uPMO93RWtybE13ZKuJ1peC+NKnPmVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA8L8awVR1hUc0XH9pZ7VobzbweqmGvYspwCkzs0sU4=;
 b=Sl7JFA2dQykNuxIs9ndTxz2UQMwqM61kqx+o11vnQ+aQmy1Kc6Cnj8i4nmMJ3UOkU9ZAwDcW/rS5mfP5UN+fgPavq0BLY5VvPEg4ljW2syKrwdb2+rjMxE4dqNA8j+oFn6auV/hEqKJ+hgcOoEX5qs+e4EgVfaS6i8cm819OHQS5L74kHW1VdfndO1u2vU6EiZo1FAGwUCcSPt1o0QhZhSNvPFuci0cbTqWdY0dmTzWLc7PhimBM5OjmAU067R9fsX6kqL6CpJ+fAb/xti+zlSv37tIEayy8qW67NfurnAdJSKn0rbeXoyeZTXeAIf1uX5Zn9pVinfE1qG011UT4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA8L8awVR1hUc0XH9pZ7VobzbweqmGvYspwCkzs0sU4=;
 b=mlXYsAYZNCNxgA4O+EYqAyVN17nond0v6iTOnBC1sRawNYlkWjaPixzPxWRck2tXETzhMSQBw1raod9Co49u0biVdbWd2QWSAX1Pu7Eprk32qcwx8BBIe/tN+cKMmOggfMlkhTdnyubIgL+LIJNdZ79JckIzZ145prANJoufFo0=
Received: from LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:14f::6)
 by LOYP123MB3469.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 08:21:15 +0000
Received: from LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e504:ed2:39ee:a95d]) by LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e504:ed2:39ee:a95d%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 08:21:15 +0000
From: <eden.hamilton@bt.com>
To: <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: Re: Fw: ECDSA for FIT Files in U-Boot
Thread-Topic: Fw: ECDSA for FIT Files in U-Boot
Thread-Index: AQHa6ArVh6Up0olr7kOc/dTRhifFmbIaxG8AgACwTRaAAF9EgIAACmsAgAEo64w=
Date: Thu, 8 Aug 2024 08:21:15 +0000
Message-ID: <LO0P123MB392903F163E5206F4A26D3D193B92@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
References: <LO0P123MB3929703FEE3D03E962D7E6E193BF2@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
 <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
 <CAFLszTjBR=qKnQEC607rZG_wOWr=FuiTP7AHkzNBRf6HjEfEAg@mail.gmail.com>
In-Reply-To: <CAFLszTjBR=qKnQEC607rZG_wOWr=FuiTP7AHkzNBRf6HjEfEAg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Enabled=True;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SiteId=a7f35688-9c00-4d5e-ba41-29f146377ab0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_SetDate=2024-08-08T08:21:12.391Z;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Name=General;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_ContentBits=0;
 MSIP_Label_55818d02-8d25-4bb9-b27c-e4db64670887_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB3929:EE_|LOYP123MB3469:EE_
x-ms-office365-filtering-correlation-id: 5ca85f80-ab4c-48f2-8b0e-08dcb7831277
x-antispam-2: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7093399012|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J4rPiDCwGwciVffaDsCMaELUPBgUuxQeYW26e2YfetBs97P0/HIVEjKf6jRc?=
 =?us-ascii?Q?LtmbiX/vzySvv7OplIdI8mMZyaDiZHr7YQtRlSMpFrxDDf31mTZKK2V7Q1Ig?=
 =?us-ascii?Q?NZxMd9SEc04eOLDEru4yphbwXX4jqc/bCSI36ZqWgJ/I0RpMX4SFYuBve35i?=
 =?us-ascii?Q?0UymgoOt3svwoVv7II6Z+MoEGSDWd7lnJGqPqUfGriqoEYiFd4U8FrmI+sfQ?=
 =?us-ascii?Q?xfqDB+pE2jZcP+cUAwo//YhNdOcRabeLU9eT0CrK8jmr6XGHTm9XHR0+jt+0?=
 =?us-ascii?Q?5FgnnllFqhVjHeFrAKJfqKJF8OsaVpC5ANvllVCDS6Biu2GbtTRQWMmR+Bvm?=
 =?us-ascii?Q?W16evD1Coyo5m9ZkaAXszXx2mD/tE0qwPq3JQBoVoOVEuy6JEf0bNFzt1xl3?=
 =?us-ascii?Q?/sl9m6CCfxqdccK8eOf/ntCDGxstVruEFqD7h5CGFzmk71Tz00HEMcz3U8SO?=
 =?us-ascii?Q?aTTNDOSi5N4CCxJ7qZtD/mt6RegerGc8yk5Tz8e0SCNJFAqXiEIa4luYr/0q?=
 =?us-ascii?Q?bdLMy7omA4MJCZXM3RG6rmc6NjkccEZdTyonz/Mn+9l1ECGXpa7XjgKUczT6?=
 =?us-ascii?Q?ejYr2JYwgB36bUcl8CBLW7EnSJmKlasAGJNlAHLXqcY/RECGWaMvrbKhJ6c4?=
 =?us-ascii?Q?gBzxLjvxl7mcaWQqOtZowNURdAkf0Sq8WbBT6NBJUBN3FrZJO3LYwWF/pHBX?=
 =?us-ascii?Q?bj+lNgN+h6hyzd+azsbVTOvV1DUzZGa8tH7dKy7We6r0ZjpCfqHCxjDeqcYf?=
 =?us-ascii?Q?Cv8tTEv5B7WBo7VHcTnI1/nFFBthG/2vCE57p5w2WyZwqM9Yu89no6j2VDMM?=
 =?us-ascii?Q?QuspWF6v7RFzsMeaT+TyEESyLIElxvVpJSV1mKc0dAvAc13501t9EYjIaLX9?=
 =?us-ascii?Q?F0O9Mp6kqD5OJibpwSwY/vXkt+LvHEM+F2wvdb5lTVI+7GxdX79kVeuNkcjf?=
 =?us-ascii?Q?m/gwmwwc1ciqr11Qf5BCrt0eiJY0NslnnycH5ITcwwDArW12WtpNm68NgNRh?=
 =?us-ascii?Q?yBVMK8+c6NZBMDUW2nI0LJnEZqp0nCulAYhSk1Rq7XVtBQZGYE8Y0syueh18?=
 =?us-ascii?Q?YD/JRYTGVFFv0VFKvodr01LQX2B6rPOEL5IolAK6z2Mctgtwu9DPrwLv3+n7?=
 =?us-ascii?Q?9QYMUEKcvN/qd428cX/TwmFc9ud0LLLT9aZrDxaRygeEvCrbumyKsEm5oicO?=
 =?us-ascii?Q?NmWdnzvHAtXP4TsDhi2GFugpVBoikiifhuOD16D665hyf36+11mf+gv38Tpu?=
 =?us-ascii?Q?7/7MnYPgB7kZvlc2glLebfIsLfeApZxcsQevQ9xYwEQ9hpr9CXsS2/1/kE0v?=
 =?us-ascii?Q?9fLJYLZHhwzkIPsLHPYdtfLJG+KHbX2iTrzGjAzjutk6CMcKy5UyyfGcYIL+?=
 =?us-ascii?Q?trGlmbLoGLgomh3ys3+ZrY9ATe+u?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7093399012)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqmMAMtT44y4Nf3r6uAcebQWEwdVxga1FP1bxVTek09mCryouzvSqa/E+/gb?=
 =?us-ascii?Q?7/MiWZTDJcT0yXm9xuVYBn+BDXnWnyxy6d8UJbsdJwz/LC0h1Kx3Fo476lmF?=
 =?us-ascii?Q?jHg2qWWj/PVIvxsdWXnR9M0khTFXVuHnlB+tw/IV502uAY8HdsbGrICGot6L?=
 =?us-ascii?Q?vYxhVgZG42AYqXMzoAme63ZvmAtcVCGIk3/OXQ8CC3qnKc6VM8PtzlhRM4Al?=
 =?us-ascii?Q?DuPFS2UiWfNsZi5Ot/Sc/NBE2IWJfiexIRB44Ry9ATwxwW6K0k92KXLwJFhC?=
 =?us-ascii?Q?B6n7dhgdTVB368cwwfO7w04pqxWxTxPcK1xbj8zBkVB/dsLtYCgMRgvY6FLn?=
 =?us-ascii?Q?K5pCo+XuYCOiB5LcCdn6wy3ccHf2QmqNa3whzjpWhl4ACl5IZ/n+ym1QXEeP?=
 =?us-ascii?Q?T18mYZl9ALTXApFw3OGZVxmak0pJEh8zLUm0X2UIrOuKvKHSx87Wpp9hCXNy?=
 =?us-ascii?Q?mpLRfKhHcK3Ga3ovFC7OBkDKHOnrWCgtnpND4L6Blmwr/wAsIY9a96yoZm/O?=
 =?us-ascii?Q?U/9TBNzzcVxLPvwTamEyaWpC2RHPvzjokThwXsY74PSoNediyA/vaOSGYRvi?=
 =?us-ascii?Q?8Ui/QMM0PpH+XpZSJm2mr0AElBlqMpVKDfrBmxRbg//ZHnUxwXdQ5mU0OiBJ?=
 =?us-ascii?Q?OFQmGCBggbzUuMTIXPRYWVXNGRbH4lVIY92U77FQQRfynrlNy++dvdt/eHsq?=
 =?us-ascii?Q?7ZrHcPl4oYNwVUPaTBx1W1tWoiymN8PeO8dEWrSfuan3IpXJEEjcE1CsPJKq?=
 =?us-ascii?Q?qabZl9fw7kfUhW7cBXdYHkcyge4k9wXulGmisxwWMWdHhAogVP6JCVtfuPj6?=
 =?us-ascii?Q?plxj3MQlENO3T7tXchZiT7XFkHPmCUONoq8n+A3YKhAcjkervWmnHxHiH9PT?=
 =?us-ascii?Q?rnAOlC8+pA5oUE9NfPwtRV0GkfZSkNhwIhSuGy3nkDwvB43wXH1thQa4IK9d?=
 =?us-ascii?Q?eBje5h14tjCb4yL1i3WPnMFYEQ96ycwavxOKWKwYa7sFHTSGXfyW3DYbR8Ba?=
 =?us-ascii?Q?0R232tAT0A78KgMtB7c4g259Yii36ISc7pCAkaXcKckQL2W+T6pjo3ts/D99?=
 =?us-ascii?Q?U1mqzkA5Qb9vo1lZkRoY+CtNaO/brjvkXk1tt+XvS8UR6+U8jAV3dYqFKrT1?=
 =?us-ascii?Q?EPZyggJFZbBbzJy4et5JF5BVEp1Iql/Y0Tjw8bYp+unvFc4k/eh4M11iZJN8?=
 =?us-ascii?Q?RLCcoUrFO7rCPIQ4mmpFfem8sASxLkHACUPv4ADQlxXW9xKt10T5n0WeSizH?=
 =?us-ascii?Q?dnDkoqRGD04pwOC1UNWw1mKr+KHRhJ8zY8FMmuR/t1ZQdYpjPh2i6oImhGgS?=
 =?us-ascii?Q?gAqvrnSXVU1qbxi+T26db84AtNmMOW/2UK5kZCz9TzxP8+cSYUkSRd8atktQ?=
 =?us-ascii?Q?WWoUxouKzrR4RnhyzP4gD1ysQ3fnp1QMWVK/jgMwWK8IrU3D/emjASCZ+QtC?=
 =?us-ascii?Q?jQf2QacZ4KF1kpSNeutqllURNF5Iw5zxGYYMQRUMUcTGlQMf8KYX1wQSwqfB?=
 =?us-ascii?Q?Ub9uYXdA4aDZCVHMCxjpnbR/lTodZYGxxTgfAyrccgYa+o9TL4ni8RSOtgsj?=
 =?us-ascii?Q?/Hezoc3bnBUn1IWeE4y+kT1BmAz2utHaIUuOlEC2?=
MIME-Version: 1.0
X-OriginatorOrg: bt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca85f80-ab4c-48f2-8b0e-08dcb7831277
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 08:21:15.7592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crVxkrtf0b+RDoHeEex7g7Oabrswz2ptChb0tYAhsXQ97xvqC6C42GF5rOIJANoFLJ2HNQvgix+1JEXcgK4+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3469
X-Mailman-Approved-At: Thu, 08 Aug 2024 14:47:01 +0200
Content-Type: text/plain; charset="us-ascii"
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

Hi Simon and Alexander,

Thank you both for these resources.

Hopefully they will provide more indication into why I cannot get ECDSA to =
work.

I have seen some of these resources (Admittedly I did only look partially a=
t the one for the beagle bone board), however the patch series for barebox =
is new info for me.

I'll make sure to inspect these two in depth.

Again, thanks to both of you.

Regards,
Eden
________________________________
From: Simon Glass <sjg@chromium.org>
Sent: 07 August 2024 15:36
To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>
Subject: Re: Fw: ECDSA for FIT Files in U-Boot

Hi Eden,

On Wed, 7 Aug 2024 at 07:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Eden,
>
> I don't see it on the mailing list yet[1].
>
> Regards,
> Simon
>
> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.denx.de%2Flistinfo%2Fu-boot&data=3D05%7C02%7Ceden.hamilton%40bt.com%7C=
c7df45e8437a427db8e708dcb6ee6a64%7Ca7f356889c004d5eba4129f146377ab0%7C0%7C0=
%7C638586382302555093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D17yAjpT6FO5NJGfH=
qfBJRvg3K03nqkhW2xnD5kyoP98%3D&reserved=3D0<https://lists.denx.de/listinfo/=
u-boot>
>
> On Wed, 7 Aug 2024 at 02:21, <eden.hamilton@bt.com> wrote:
> >
> > Hi Simon,
> >
> > I have forwarded these emails as requested.
> >
> > Cheers,
> > Eden
> >
> > ________________________________
> > From: Simon Glass <sjg@chromium.org>
> > Sent: 06 August 2024 22:47
> > To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
> > Subject: Re: ECDSA for FIT Files in U-Boot
> >
> > Hi Eden,
> >
> > Would you mind sending this to the U-Boot mailing list and cc me?
> > There are quite a few people involved in the security side.
> >
> > Regards,
> > Simon
> >
> > On Tue, 6 Aug 2024 at 08:24, <eden.hamilton@bt.com> wrote:
> > >
> > > Hi there Simon!
> > >
> > > I am Eden, currently at BT trying to get ECDSA verified boot for FIT =
files working on U-Boot.
> > >
> > > I have observed that you have reviewed many patches/updates surroundi=
ng ECDSA in U-Boot.
> > >
> > > I have been trying to get this working, but it is appearing difficult=
 due to no examples online.
> > >
> > > I was wondering, if you have any examples where you have managed to g=
et this working? Perhaps examples of FIT files, DTBs etc - that you would n=
ot mind sharing with me.
> > >
> > > If you do not, then no worries.

OK, there it is, hidden under my ellipsis, thanks. Here are a few thoughts:

[1] is the general docs which I'm sure you've read
[2] Describes the process for a real board (with RSA, but the idea is simil=
ar)
[3] Is a test for ECDSA so you should be able to follow along with the
steps there to get something working

If you have problems, then a console trace is often useful.

Regards,
SImon

[1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s.u-boot.org%2Fen%2Flatest%2Fusage%2Ffit%2Fsignature.htm&data=3D05%7C02%7Ce=
den.hamilton%40bt.com%7Cc7df45e8437a427db8e708dcb6ee6a64%7Ca7f356889c004d5e=
ba4129f146377ab0%7C0%7C0%7C638586382302567690%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&=
sdata=3DfF9swWqhRl8yzTlT0Y%2FivJ9dqmRHkR98iEoyd6edGjk%3D&reserved=3D0<https=
://docs.u-boot.org/en/latest/usage/fit/signature.htm>
[2] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s.u-boot.org%2Fen%2Flatest%2Fusage%2Ffit%2Fbeaglebone_vboot.html&data=3D05%=
7C02%7Ceden.hamilton%40bt.com%7Cc7df45e8437a427db8e708dcb6ee6a64%7Ca7f35688=
9c004d5eba4129f146377ab0%7C0%7C0%7C638586382302575865%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7=
C%7C%7C&sdata=3DnPtxC0tb9ORxeJOe1cxjx2MUqhj2c2z6kXJ4lFuqgBM%3D&reserved=3D0=
<https://docs.u-boot.org/en/latest/usage/fit/beaglebone_vboot.html>
[3] test/py/tests/test_fit_ecdsa.py
