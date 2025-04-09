Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE0C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BCE8367F;
	Wed,  9 Apr 2025 13:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="A6Ni52mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3C883689; Wed,  9 Apr 2025 13:29:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8424A8327A
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGQjQpN9uEz56tFSvaQSypyLBMNQZVVstl4dWdqelWJI1lcpAoHpaTt+xWPXMIiqzYJoqRkLGvPpCbHITZzbj03h+5IVGcuB+JQMyo9xa5lrTnS69ta4NLhczrYMQgVZXwWLfwlrzPKW2tgfpO18yfrNDogsNw7cKT2rAzZfj/iZkcEY7fWNlnZ4UDpid5EtoPq+b63GizsSL7DN5XtYHGUFIs8pxArpnI0daITAukRFxtZIo3GctPF+KnW9fND3TAnG+7+leA+5oOFkaFnwQm97oRSWHyhyw6pu3sqizXRlE5BPApmoBCUefHNflBjdbniLzaZC9daUWcxh+d5XLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlqY2J7TNkcwhYq8MxvqxGLsBroQqq0i9LKeYXE1A6Y=;
 b=wKTh2D+R8DDIOLuvdjU6aUmDXZWDB3c3NhE9iLVjYLka7XwA4fqX5KNQLDsnsxHE/BQXuIuo9VdmALhcsmkPSGTcgL5r9ksFDyhEiznGhyleKD8gl0RSkHQ1Rqp1UX13QCDhNvMwJtrv4Rhgu1Ib4Ked2O/PhOhgtku/46CmBB/TKEUzIfbQxPG1TrXS6MbZTd2fkbIWLul6o5+MTQs+WLUKBIm2gQ3Ls8qaxA0XkL+kHYRc/D9ljVdusr3Url1bLyyOolJi6QtMHN/JPQUkvYyqXG9zdF+WyKETFH1ASQ10qdtapbibuEG7w8G62DwHIIpzcUbXhayxrjW7WRt4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlqY2J7TNkcwhYq8MxvqxGLsBroQqq0i9LKeYXE1A6Y=;
 b=A6Ni52mXdWbe+94xims1k4TEBiYcChgKnv8f/iVe1oOsIyoLTAQyGdwuA4PnsYEvp9OGyEoitHjNm0MLryblmBq2zqHUpZc+/PqbECO0wNLbbtUn0WtJYZQNLzjiJeLdgRjYvhrtPdf7k3VBRmvJwm9JXvJv/xcKWfM8ZXx8bt72Z2/49Z5XI+oGmVPgt0vLPgGtD6HwW+ZBq6fcQ2hdE8QGwSOsrnxhUHOXlUmLbSm5Sl3sHTq9vQRp2KxkURg41uHZXrrS0qRJFli1SCZQJStyTgqrXfVmvUTUgQOus31WgU6JRYAOz4uxfI5i2CDFDKq3KwwzWwY5fVxwdu6HaA==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by DB8P191MB0821.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 11:29:18 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 11:29:18 +0000
From: =?iso-8859-2?Q?Pawe=B3_Kochanowski?= <pkochanowski@sii.pl>
To: Gaurav Jain <gaurav.jain@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta
 <horia.geanta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vYj/H+qJ2ybk2H3sZmwaA1kLOZjPCAgAAKHaCAAUgJAIAAU4yQ
Date: Wed, 9 Apr 2025 11:29:18 +0000
Message-ID: <AM8P191MB1394A686536ACEA333CCF47FA2B42@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|DB8P191MB0821:EE_
x-ms-office365-filtering-correlation-id: 51c30a37-6b29-44c0-29f1-08dd7759c448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-2?Q?B3d5LHEqCPCqSlv8AAaNFvHF8Ld1Irl9smeBNZcBGFrz7bjTr8go2wHmsQ?=
 =?iso-8859-2?Q?il2WtkNdPsEZM+vDr+bfVtz/TnYBf8GtdyCbwjFC7a2Jn62+YIBB9RrSAi?=
 =?iso-8859-2?Q?ul5K5z+bnL/ga0Ckd665f9Vqn3RBR/BHiGza9+cAKwQrIhLFsyr2yFD+xk?=
 =?iso-8859-2?Q?8F4jmejNtXRAD+lA6O3nNuh/11W5F22/XLD4bSyKC0ctE4gszVm+y/J6aY?=
 =?iso-8859-2?Q?5/35LzrZ24Qr1QIXmeh2kI0Ey4oJmWdEPPKI0zCRjp82ADOEjRapOQSJ74?=
 =?iso-8859-2?Q?2+ZSfpf/GOHcfXwRA92jb9FBuV2GLx8vEecHzI7ToMTGj75S+hrcvR19np?=
 =?iso-8859-2?Q?mNdkcsrMIMZiloaNyK3VGTcpTxPVgvMuO0C3Eh01rbmNVmTgjWw094zroF?=
 =?iso-8859-2?Q?HEc8UsDdkOu6m4W47wlGjJWbPMGMSPotrREHhzsEs4LOJvxeXbjS2qfF/a?=
 =?iso-8859-2?Q?p9IXc4TJ+iOdtSQop2mUEN9x+LKdDG6APXCL/g45jX807TEbqlwxRZbgEt?=
 =?iso-8859-2?Q?AgLbv+KnAjZHW8UJx1IFxXnlmgZSreIIK3ApZ/Q5zkljtZU/zQL2QPL/Kk?=
 =?iso-8859-2?Q?1Zq+6KWDDLtZnT6+gL/xM7vTYHjOtKk57dCoQFQxGy0tc2aQCggWY4gTO0?=
 =?iso-8859-2?Q?IEYGsZQx9fbvsvnyHb+lIJ11orIhYfQqeuv+43y/WFbqCS9/nEIR4WgOFS?=
 =?iso-8859-2?Q?QvDdMb6wEeOLrXwCtu0NVyXMO/mylPxQW0a8VtYsGRD7bI8ozNBkyPKqNX?=
 =?iso-8859-2?Q?3ueMASwa9z6kIB350AkTptai4kDxyfR9OruTzyB9YUx9d2CzsVrLJeRPC2?=
 =?iso-8859-2?Q?njUunDLOmyYCn4KXDZiLphBPue0uRwHlGIWMgE5+LpQrZ+T0vbkZYVo2OX?=
 =?iso-8859-2?Q?Ql6BYMo1g2tYolaT0+aefk3DNdPV+j1xdiENl+0wuGVC8Y6P8ca+od8Vof?=
 =?iso-8859-2?Q?Gh+5yjoeCy+N7qrgJXDd/BMiyfd/pi/UNRaiG822QCZpLgBNgIiEP4Virq?=
 =?iso-8859-2?Q?5TdNam0d6Hlysv0BKG2aCFX/YXkCErMXGx96iJ5rYocbkcKeypq7cPJ/Ql?=
 =?iso-8859-2?Q?fMCHpa27Asa+k2aFGXmNz3zbuTXPBcKoROEnBl7BbKL+3yQxx2tEIJreC/?=
 =?iso-8859-2?Q?VxqoyMIwpXO+1FFMrtNq3ZC4rgkF/TC+OakpX0Qvi8XqMpaUPSjsYtNQnC?=
 =?iso-8859-2?Q?YwWYwyGO+fOEQE0BHKMrFUHezUJdpIrBrpaUK7t7WZy1aA7WbHk33wDPCQ?=
 =?iso-8859-2?Q?0/kD9134wnEr7kSQLXf8lghHzG6WWkCTsk5WM6IXFuhlqDbx3hfO2WywZx?=
 =?iso-8859-2?Q?Diyjm6MAFajLic1DLM2Eb0gB8RDXDCBDgeYCa3lYEobsByAsK96HXwTKKa?=
 =?iso-8859-2?Q?BJqc5R+x84coNBZLDbcW3Aa1Zhe1PoytR5CoUYm8oWTtl9pldj8j8yxXUT?=
 =?iso-8859-2?Q?GSvTUGFZYdBsSL4k7ng/0z+w1YpzhXudJGGkMecVG8jslC/HvPkT66YI6l?=
 =?iso-8859-2?Q?fxKoyt+7Suuu1pgZ486XMH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?sSDldgrd6Q78A6ZXqq4A0Ek/dbHycAb90N1H8R9k88QS7BNx95fw8zCdzA?=
 =?iso-8859-2?Q?3SUfp3ps9Ez8eVQcJ+B/PCA3oenPluZ/a+4USPrNdbdEpQuDqwXnzXIT/L?=
 =?iso-8859-2?Q?kcP2S4/BD01SOGXN2fmthIvf4XlXjQhRX0w6SLxK4ssCM/cpBk7lMTrvi9?=
 =?iso-8859-2?Q?hWKe9xUo9CAbz6ke9RZhcaziKud+Ts2HItLsCV4+fKSrj6yN5iHjxjSaZu?=
 =?iso-8859-2?Q?cC96q8yb7OZZXUuA5CBTA5LOjqyjjN/MLh602fxyd2iYSWLMbb16ToS5hB?=
 =?iso-8859-2?Q?M5mD+tOVBBL4xOOFQiyZsf6hp8Aw6m9mV8GcMOR/S1fbec7kkzCiFCBadn?=
 =?iso-8859-2?Q?gKAa9ullbAlr9Dm8dNsJJhNZd7CPB2xhFNWbUQk39hj/9k6kfey+9nGQZd?=
 =?iso-8859-2?Q?tqF6OGR2hXSgk5sGfb2rSxCJFFmD0VXGTsNCjBI2PQvThgfvARs4Ua0moN?=
 =?iso-8859-2?Q?/Kpdd+8eo+UaOurYf6W0et0pgND3yQECo+9Z8QwX1opS5LrT4sejLqNj00?=
 =?iso-8859-2?Q?K9pno/1D78H5Iziwi16Hsob/j2UnAq1ok+5JK/PtBuiKejz2vIHFEUk59e?=
 =?iso-8859-2?Q?9IVuuKar8gs84vZHWmZnTxPNC8ZOdJSUXXJa+ll1dbemscldTOXqtDNEQi?=
 =?iso-8859-2?Q?654zzQa16zKGBuannm8h7+WTLkfua1FosDMxOmgXSaN0xoIPfm8s7firOv?=
 =?iso-8859-2?Q?i+C4y13OQR+8Lxqu/UiayViWdTOvWTBHc/8gNJLZSET9qYiJBzoSE+DL7K?=
 =?iso-8859-2?Q?MV+eYekN3xaWkNjNvt2FwV+cDFxW2QWWWWCAipBcjTnJQIVT3eAGBTzD0j?=
 =?iso-8859-2?Q?DtFAiMbwpHWih8hacmaYaKwGP4zG6XLoEWpuVfz9YDV54XMBYIg0sF2lxd?=
 =?iso-8859-2?Q?77HZ61jAuwMdur4puRjjwxcq5+NUjBTsPjUvOAdlLuM0EHDP8Kbtp1c+CF?=
 =?iso-8859-2?Q?kZegQ3ew8ZfliTUHy+hexqP/LYCd1oiX9BS2cLJCpa7DYyEf4O6wfOdDPS?=
 =?iso-8859-2?Q?sODiLpi0kDw+YSmX9gQWlhMekxMlpYJmUQf9yFBiyGgVW1mcIJqBTHaUeq?=
 =?iso-8859-2?Q?m8Y91a5nAF8JYnURJeiGnkxtl45tU8qe985KCdl2Ke4v6pccYSn914RsNY?=
 =?iso-8859-2?Q?gZR/KOetz8CnLuiFedGJudjwQerzSagolEhArP4FG0aHyobAT2SxT4KiC/?=
 =?iso-8859-2?Q?rC9pyDJHfD78E/Ck1vCZvJV4SGxN+S/A/T9RcNn+EK6hT+UKnKXcp3DvuO?=
 =?iso-8859-2?Q?sRRPVhls5UxA19fMWWcWrl2BfjcW3f7m4+Qz03vs8Xb3qrDp1IEolsgioG?=
 =?iso-8859-2?Q?PxAiu3yCcP2Wubwq8dlAXW9xqAaSaiI383vZIUzUKwpx+evvqsRGyrNH88?=
 =?iso-8859-2?Q?N4pFcZNQCk4WgKRftHLstIDLiYGwgJ/7MdumLbqOIKgiQeHUMxGhBEbGNP?=
 =?iso-8859-2?Q?0E95uMa7AlBSZjOtKjDytI9O5Ww3x6Lr5lqEyGCz50YWVLGQiwFnBPoqB9?=
 =?iso-8859-2?Q?DZ6d5m57/6ZbPK8egii+BhCj+2KEzyJ6b9HaeYEbVHiymASbjFeGY/Kv0s?=
 =?iso-8859-2?Q?jH2ncrSPsXqBKsgiLjJ/XmZFlMjHVr4SNWImFgQv8cnZ0miRMbBT1VD6eK?=
 =?iso-8859-2?Q?Z3aA1Wo/2u/cOw0TMxWlSnQXwPtWfiZw/t?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c30a37-6b29-44c0-29f1-08dd7759c448
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 11:29:18.5025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1L5eHe0iXEYcrYjhdSxfSsqMMZZ7T3tmmuyu2OFzgx5JBSIfhog13wQbO4Juu0HDPnl5vXDNGW19qntcSqPt5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P191MB0821
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

Hi,

> From: Gaurav Jain <gaurav.jain@nxp.com>
> Sent: Wednesday, April 9, 2025 8:19 AM
>=20
> Hi Pawel
>=20
> > -----Original Message-----
> > From: Pawe=B3 Kochanowski <pkochanowski@sii.pl>
> > Sent: Tuesday, April 8, 2025 4:30 PM
> > To: Gaurav Jain <gaurav.jain@nxp.com>; u-boot@lists.denx.de
> > Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gabriel Nesteruk
> > <gnesteruk@sii.pl>; Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
> > <horia.geanta@nxp.com>
> > Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for
> > lengths greater than 16 bytes
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
> > Hi Gaurav,
> >
> > What we see is that the jr_enqueue() called by run_descriptor_jr()
> > swaps the endianness of the descriptor in place (by modifying the data
> > pointed by
> > desc_add):
> >
> >         /* The descriptor must be submitted to SEC block as per endiann=
ess
> >          * of the SEC Block.
> >          * So, if the endianness of Core and SEC block is different, ea=
ch word
> >          * of the descriptor will be byte-swapped.
> >          */
> >         for (i =3D 0; i < length; i++) {
> >                 desc_word =3D desc_addr[i];
> >                 sec_out32((uint32_t *)&desc_addr[i], desc_word);
> >         }
> >
> > So the sequence looks like this:
> > 1. caam_rng_probe sets correct descriptor in ` caam_rng_priv *priv` 2.
> > caam_rng_read is called with 32B 3.
> > caam_rng_read_one->run_descriptor_jr() is called to generate 16B with
> > `priv->desc` containing valid descriptor 4. The descriptor is swapped
> > in jr_enqueue() before passing it to job ring
>=20
> I see you are right. In Linux, caam endianness is handled at the time of =
creating
> the descriptor.
> But In Uboot, caam endianness is not handled at the time of descriptor
> creation.
>=20
> 5. The loop in
> > caam_rng_read is called second time, this time the `priv->desc`
> > contain swapped data.
> >
> > Interesting thing is that the job still succeeds and that some data
> > are present in the buffers, but maybe swapped descriptor can also be a =
valid
> one?
> I agree that the descriptor should be reinitialized for each RNG job.
> I am also not sure how the swapped descriptor worked second time.
>=20

We do not see any error code (run_descriptor_jr returns 0) although the des=
criptor header is wrong so I assume that no real action should be done by t=
he CAAM?

> > The effect that we see is that when leaving the command executing this
> > sequence we get an exception in "unrelated" place..
> After your change you stop seeing this exception? Are you sure it is rela=
ted to
> rng descriptor?
>=20
> >
> > This is what we see when printing descriptor in the caam_rng_read_one
> > on
> > LS1046A:
> >
> > First iteration:
> > 0: B0800005
> > 1: 82500002
> > 2: 60340010
> > 3: 0
> > 4: FBC94DC0
> 4th word is seqoutptr: sgf pre ext (ews). Have you also modified the
> descriptor ?
>=20

No we did not change the descriptor although this log was from older code..=
 I have rerun this with code like this:

	printf("caam_rng_read_one() priv->desc:\n");
	int desc_size =3D desc_len(priv->desc);
	for (int i =3D 0; i < desc_size; i++)
		printf("%i: 0x%08x\n", i, priv->desc[i]);

	...
=09
	printf("caam_rng_read_one() priv->data:\n");
	for (int i =3D 0; i < CAAM_RNG_MAX_FIFO_STORE_SIZE; i++)
		printf("%02x ", priv->data[i]);


First iteration:
caam_rng_read_one() priv->desc:
0: 0xb0800005
1: 0x82500002
2: 0x60340010
3: 0x00000000
4: 0xfbc6ec80
caam_rng_read_one() priv->data:
a9 82 98 2e 7a ef da eb bd 0d a3 f4 e8 db 68 43

Second iteration:
caam_rng_read_one() priv->desc:
0: 0x050080b0
1: 0x02005082
2: 0x10003460
3: 0x00000000
4: 0x80ecc6fb
5: 0x00000000
6: 0x00000000
7: 0x00000000
8: 0x00000000
9: 0x00000000
10: 0x00000000
11: 0x00000000
12: 0x00000000
13: 0x00000000
14: 0x00000000
15: 0x00000000
16: 0x2e9882a9
17: 0xebdaef7a
18: 0xf4a30dbd
19: 0x4368dbe8
20: 0x00000000
...
47: 0x00000000
caam_rng_read_one() priv->data:
2e 98 82 a9 eb da ef 7a f4 a3 0d bd 43 68 db e8

This explain why we see "new" random data generated on second time - it is =
simply swapped old result as it is now treated as part of the descriptor..

BR,
Pawel.

> Regards
> Gaurav
> >
> > Second iteration:
> > 0: 050080B0
> > 1: 02005082
> > 2: 10003460
> > 3: 0
> > 4: C04DC9FB
> >
> > BR,
> > Pawel.
> >
> > > From: Gaurav Jain <gaurav.jain@nxp.com>
> > > Sent: Tuesday, April 8, 2025 12:09 PM
> > >
> > > Can you explain more details about this issue. Where it is being
> > > modified in
> > > run_descriptor_jr() ?
> > > Regards
> > > Gaurav
> > >
> > > > -----Original Message-----
> > > > From: Pawel Kochanowski <pkochanowski@sii.pl>
> > > > Sent: Monday, April 7, 2025 6:17 PM
> > > > To: u-boot@lists.denx.de
> > > > Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gaurav Jain
> > > > <gaurav.jain@nxp.com>; Gabriel Nesteruk <gnesteruk@sii.pl>; Pawe=B3
> > > > Kochanowski <pkochanowski@sii.pl>
> > > > Subject: [EXT] [PATCH] crypto: fsl - Fix RNG generation for
> > > > lengths greater than 16 bytes
> > > >
> > > > [You don't often get email from pkochanowski@sii.pl. Learn why
> > > > this is important at https://aka.ms/LearnAboutSenderIdentification
> > > > ]
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the
> > > 'Report this email'
> > > > button
> > > >
> > > >
> > > > From: Gabriel Nesteruk <gnesteruk@sii.pl>
> > > >
> > > > Reinitialize the descriptor for each RNG job, as it may be
> > > > modified by run_descriptor_jr().
> > > > Failing to do so can result in memory corruption when
> > > > dm_rng_read() is called a second time on NXP devices with
> > > > CONFIG_SYS_FSL_SEC_BE enabled.
> > > >
> > > > Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> > > > Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> > > > ---
> > > >  drivers/crypto/fsl/rng.c | 14 ++++++--------
> > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
> > > > index
> > > > 06364948052..440b26e3c94 100644
> > > > --- a/drivers/crypto/fsl/rng.c
> > > > +++ b/drivers/crypto/fsl/rng.c
> > > > @@ -27,8 +27,14 @@ struct caam_rng_priv {  static int
> > > > caam_rng_read_one(struct caam_rng_priv *priv)  {
> > > >         int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE,
> > > > ARCH_DMA_MINALIGN);
> > > > +       ulong rng_desc_size =3D ALIGN(CAAM_RNG_DESC_LEN,
> > > > + ARCH_DMA_MINALIGN);
> > > >         int ret;
> > > >
> > > > +       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > > > +               CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > > > +       flush_dcache_range((unsigned long)priv->desc,
> > > > +         (unsigned long)priv->desc + rng_desc_size);
> > > > +
> > > >         ret =3D run_descriptor_jr(priv->desc);
> > > >         if (ret < 0)
> > > >                 return -EIO;
> > > > @@ -63,14 +69,6 @@ static int caam_rng_read(struct udevice *dev,
> > > > void *data, size_t len)
> > > >
> > > >  static int caam_rng_probe(struct udevice *dev)  {
> > > > -       struct caam_rng_priv *priv =3D dev_get_priv(dev);
> > > > -       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN,
> ARCH_DMA_MINALIGN);
> > > > -
> > > > -       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> > > > -                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
> > > > -       flush_dcache_range((unsigned long)priv->desc,
> > > > -                          (unsigned long)priv->desc + size);
> > > > -
> > > >         return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.43.0

