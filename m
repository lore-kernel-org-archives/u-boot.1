Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA6ECF34CB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD8A83F69;
	Wed, 19 Nov 2025 16:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="Sk+jJJMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D9183F6E; Wed, 19 Nov 2025 16:06:23 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B0983F62
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGHRdJDSvy5JDOQOoqz7XtgJ/pxuAbT2jvHclHVekrZDh7c+ZlTOBCX+ejdu174qU1twAxfW4JXb9VpnPo7t73ugqvTGsmbd1EFmQrkTNpT3iKSuRXZ2ANSGwgMe3yLCv/Tq+dJssoS4GhSmpLZBKPbmyJqCRxmO25fn/nMKedOGiR9241mFZ20XaoMTD17jIvYktP4HqO1SEVTSh8A4zTKAGSs4frYVipXcnuqdaoHn0frVhqQdBqCWV0d+JDhAXvt94a98wVLsGBZAo1N7ucfGRMH0GxagAJ8D2q++Vi0LUC98DenP+T8e9NdkCw0f8EVqc46y3vvmZEyen8YRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJh0ZYN/q0JQ3ldDsadO29zYflSqx80GiRHgUpOOKJQ=;
 b=LtO70HSQQlT7zPc4vU8IKW3n4INNymptgGJIk7H9x3Nbh5Tu6CD+TC0MZPeelMJ5CX821v7xWKd8m4ucuFmXdU4t/Fm7LcXvRzE8clWmu3YttxOelqR8sea3rvMAaTIWFmIpTmNgtB9izh3F+oX8Wn4skqIm5rOAOwS6oGXbAsZj5YLWc+hjWQUsysik2qrrX8QJQ+w6+o1E3VBKkdU74dd+JcOgrlQ/wuNC+aluCbHZFt/w+dul8hEp90GF/dK5TJmUGoEkw2vR+GSpcO81jzsDHW7i8RyAfg4HOlu1zhsTDX2XrS/jVhn8ZlhpLyh2udC68nqCQCxFErWk6t0a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJh0ZYN/q0JQ3ldDsadO29zYflSqx80GiRHgUpOOKJQ=;
 b=Sk+jJJMPE9mC7JnsB9iqxzkYGyGVKTHu9NknoACDudVLA8v7ODk+3was+iyJh7jIFU8YuYDdrDZeQU31mI7vsrK6qWjqp5eSrXDm7Lx42/bhnCanHjieLkp8WOkwMiXTUdumRbBjJflEd/Je5Q+nzdARWpRFlmJ/5vgK+6BuG3qPxeZ3xXpuR0U8sHPK630lUXwZrAM7ttaWdtI/ClwIgmx3x1YCOYj0BmrezpE2/p/ltBH422cAuB1Rg7cBpTuLu9ghvWzOhC+s74U5gzweADB8eaWR8K0AmO60+E/WONNiPqg/v/+WHmMQfdPwahzbf5g47GSIQbWwcB/iN8ls+Q==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by GVXPR06MB9228.eurprd06.prod.outlook.com (2603:10a6:150:1c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:18 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:06:18 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <foss+uboot@0leil.net>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Peter Robinson
 <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, Kever Yang
 <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
Thread-Topic: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL
 engines
Thread-Index: AQHcV/qBXpSf0zXQ50e7r41pI+Co6rT5wyUcgAAzH4CAAB++RQ==
Date: Wed, 19 Nov 2025 15:06:18 +0000
Message-ID: <DB9PR06MB8512F93000C1876567D017E0CBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
 <DB9PR06MB8512FD168E1197521BDD445DCBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
 <b4e389fe-024c-4eb7-8c5b-b27188f50b48@cherry.de>
In-Reply-To: <b4e389fe-024c-4eb7-8c5b-b27188f50b48@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-19T15:06:18.221Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|GVXPR06MB9228:EE_
x-ms-office365-filtering-correlation-id: ba79eeeb-31e1-4850-d381-08de277d3188
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LumWR4zWmLaVLorBSiry1LIt+FFxPY9QdtumLkQypYbhvRiZsUOmNIvTW+?=
 =?iso-8859-1?Q?1bPtuliSNoCDrThNULguJBv7Q5XjFJZxhmGmIi81fVFZm1+l5xY3/2QlZj?=
 =?iso-8859-1?Q?5ZrON2FWFfQaVf73pzInlJtJ9cbwuVBDUH6daTLIQ8AodKm6ZhaUnAJNKa?=
 =?iso-8859-1?Q?GR56yqq05zaPsMONIenUjiQVtYjdl2+CgwWBlro/kta/qDlAj+1LIaJG+u?=
 =?iso-8859-1?Q?RnPBiVu9ma11RNg38MmXRTSG3M5Ur9I4j1TdxyPusa0YlgfBIjjRQqihD+?=
 =?iso-8859-1?Q?sPzN9g8TrpFhOoAdYThYbE+N8nbOt1/Yf0z94f42OStdH26+qw889lxvOJ?=
 =?iso-8859-1?Q?ubrzCw1Mqo6URvS3K3Cu++g1DkYLxdarPICcHQoIFs0AYR32d+4Maozmx4?=
 =?iso-8859-1?Q?/oCvv9jx8dc5gGFyyy2592T7eWADSokz1MeNhA0T99/Fw8Um3gWTqTR+Nb?=
 =?iso-8859-1?Q?wlyZjrPzGAi9N46KHjyERHI1LuTPeGwsOuKkGaESpKCq7mYWlA2HawmSIR?=
 =?iso-8859-1?Q?krWKKeS7N88raJ5POWNRf8wtOV5aH0yzMAUKKFM3klXwvnhQTzgxRhu6QY?=
 =?iso-8859-1?Q?RdZOu8R7EC+EOXBx9e+Z+tgvjTYtKMTGteLZ4sjlX0eVIemh+oXs6uI9vf?=
 =?iso-8859-1?Q?z9N2wVIjDAq5fa3v8gm/hvb7jWhgDp6BaVDDx2aOboitKWc5sehY54zQge?=
 =?iso-8859-1?Q?QMY564z0b7OiapNQk1h+d7rAbkt+v9fYdXRWJsJzFxZNLQT8fUlSG7J+tO?=
 =?iso-8859-1?Q?pwqIEPlJqBYJcEhjAQe2oUQirz9anNVxZj6izZvuRGMtIxfTO+ftXoduaK?=
 =?iso-8859-1?Q?wg+I/NoKDMg4ppyeIOyx6ME7Fm5pN5K/0QUXDXghfwPPB5VgU2l5ZGCjW9?=
 =?iso-8859-1?Q?A0zjVSB9brpkKvQtf971Z6aA7g7RrXRHZdhn9LNc548O1IDWh/5GsZd1wd?=
 =?iso-8859-1?Q?2FPpIYEXLhozY7vzQuGz0AwqnacaiXSMkLNr0ztk81Q1hcW2VNzV3TAr28?=
 =?iso-8859-1?Q?sBTT8CBeN/7soXSDwLvagOrkbYUQs/yxXhAs6dZQ0Gn8gf2INcZzt/TIM6?=
 =?iso-8859-1?Q?LM/h6BEpVWvJMOaE9fHVoikBMYNmYzwWxwvbPx7+XdAYbJB+xex5rQ5WsT?=
 =?iso-8859-1?Q?3zmSOkhzQooborwZ5gH89WihZZY6oCBa34x6TfZWIwiQZQpROK9VUYJoKc?=
 =?iso-8859-1?Q?N0NFdrr3+wr6P0aOqXk60Ri5sgaeBkzgj/+KP+MlOuNe3O6T4XNHfEZHm9?=
 =?iso-8859-1?Q?yIqphC4iEBQWYA7IfLoXNUPucZJDM379IqXMtgSXmsKW3ilaKU9mgvF/Xn?=
 =?iso-8859-1?Q?ry91IvhgKsGjSMKMknzwEcXJLRBs768w0NLM59x5j4njjx5YYa/H6+s7LU?=
 =?iso-8859-1?Q?CeAu+dwvcFua5t0GTAx31MrfRS+WdOUgIparFLYnVxSHoI3OHkV1XhcO8F?=
 =?iso-8859-1?Q?j9vTBYu1Cv+FpMlCUyxb1BLj7fFDrZvcSJA40cQXWTiissH2al5ffESgJS?=
 =?iso-8859-1?Q?nw301MsDY+GJurlFRwmK0YzZBRVWvLlmXA6RVZtXJeAg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G0qcYNJEIc3hs1fOm8Gtg2S+aQR7MTy4RESy7qohGfGij7fbwDBBIs0QHa?=
 =?iso-8859-1?Q?chSdo4c7dxZqr87C1XKVFqpq1gmHSQFkwfeSpXvqxh4UhakNdI6ithS9jz?=
 =?iso-8859-1?Q?vMe56wiMWGalHFvM15HeOHMNTtaxZo0RCrcQ1p/qcvCjroEAhbnJa6m+ko?=
 =?iso-8859-1?Q?8CZQL/cBZoI28sn1PR3QEXZze2YW43TrHqgSLSj/yfTbX10pNJICyAAr00?=
 =?iso-8859-1?Q?tfzGc60V8jBOqmqcMOp/WnGgUWUD1fT79dAhAQkrwTXaV/BoPBjtlVC160?=
 =?iso-8859-1?Q?DuOEfx3hIOd4eAEQwh90h/p5YTum38ke+Ta5dgmF3M/vyDTbLg8aQkC/oY?=
 =?iso-8859-1?Q?ES+tTYTRaT37mWKGZh8r/qVCzH36NRTsIHQ5v+YGw9CbEJTGqYnOsItPt0?=
 =?iso-8859-1?Q?6r6kyDgmgwuh0LjCIJyyxJC0yYWFIqTAJoC1DCB6iSW/VGOLTPiEf5uAkp?=
 =?iso-8859-1?Q?k9qCmiLTXtMlyZiy915coWl2csOHB5OBWaoVpOCZTpKahxeJUZQQMUb1tK?=
 =?iso-8859-1?Q?4cJnVoCwq6k/Jp2wpmg9bIS+jfDAvRNa4QrYuzspVlYy8H+t0FUWxdDvXh?=
 =?iso-8859-1?Q?Eryy6M6MUtqqO35+8qRGkkCZ94v9qDmFSR+07xnc1xkKFdjEUGSISzbboT?=
 =?iso-8859-1?Q?qChjfJOhmSyhPAe+rC/GqUCcIrJcqgN4m0cG29qmcuSFAHnsJvWbUIjRds?=
 =?iso-8859-1?Q?huCPby6ZgP2vssTj+SNk7MOP4f+87qQ1Z+G49joMO4mALW62go0cb/hDDX?=
 =?iso-8859-1?Q?VT98YL8mzSASOfKwHSVJFEyE7hh4DjoTSu//nfLui69FY5CGj3P2XidD7X?=
 =?iso-8859-1?Q?2eBip/0eUmNHk3TVzZGzmBUcmm5gTm87lptqJ+cNIN7dHskc9UyfOzbQWN?=
 =?iso-8859-1?Q?srLz3/0Cn0ZaTU1+vmzu18Q/lYgX3+nsqSStm9psk77kIM2h1GeyvIIO92?=
 =?iso-8859-1?Q?tCVM6HGIi7poGiRm6ocp/EYNWLfJfgzApj1stzgtN25gAEH++eo1YuqDYR?=
 =?iso-8859-1?Q?GQwZoSeYG1XiTIeDepZA3GZssOK2O1pWHJPBTVftTKRVzrbd5RtPacYlk7?=
 =?iso-8859-1?Q?7K+0JqZ69lX/YfVbCC0/jqhBb0oeWqkeu/TNxwJEjKpKNT7xuzowtEDcHC?=
 =?iso-8859-1?Q?zT2GjknUjXp6NseEaUozmVehlRM7modwp9CLa5gf7arTmC42YNLrKMKFdz?=
 =?iso-8859-1?Q?upb/IMoazGWpdhVd3nqGGG1143Ys+E0lTxhtlppk2zDghzdfujR5I2A1v2?=
 =?iso-8859-1?Q?YMM5bPGlCGIQ0etzZ4LIis/z43EiyPUYbF3kN9/AVHKzvnoRiCuPv/Ci8Q?=
 =?iso-8859-1?Q?wKteos8l/efNtk4udTlhv74jn88qNBdZINFpT+50rNU9sHCVZL93Vtnt8J?=
 =?iso-8859-1?Q?+4IdpM+uTYd4gE24Dqoovo6mGiAWdyoRyhTpJalZxP4cMllqS8FXVW0ION?=
 =?iso-8859-1?Q?kJSvj2rFeKf6Hw6GxMml+aw7EGzyGX9ls5me6hGUu5DDloYO88Dj4PLBvZ?=
 =?iso-8859-1?Q?9fNiToJOSl0SL+iHZ/dfrVpAW0KVxIDckTokj9jooe3HPME1r2+Opxa3Ho?=
 =?iso-8859-1?Q?ss34yyoK3kRcrwMI4U7Oq62Vhz8HkMiQ5Jqh3OsnIagicHP5+Phn8MXqoM?=
 =?iso-8859-1?Q?K7jIy5vBbJdrk29nTUrxKfhkm4U5A5PrHIX5bPMFj56KVktgoKyqQypQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba79eeeb-31e1-4850-d381-08de277d3188
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:06:18.8043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xWWjSHTHR2/LErFcFBFLmX76rw4w7nbeBP36q0ZVqUD1PsRoYyM/wybXZ2EUL3at3S0e03q23V63xwO6VDZefhX+P4DzRImQKa0eg9xya8in6CCNNifVVFnKz7EVqI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9228
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

Hi Quentin,=0A=
=0A=
From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
>Hi Wolfgang,=0A=
>=0A=
>[...]=0A=
>=0A=
>>=0A=
>> This description is quite convoluted. I would propose to describe it as =
a list,=0A=
>=0A=
>I'm very good at writing convoluted paragraphs, so thanks for suggesting=
=0A=
>something more readable :)=0A=
>=0A=
>> something like the following:=0A=
>>=0A=
>> When `fit,engine` is set to `pkcs11`, the following cases are distinguis=
hed=0A=
>> regarding the value of `fit,engine-keydir`:=0A=
>>=0A=
>>=A0=A0 - If `fit,engine-keydir` is not present, value of `key-name-hint` =
is prefixed=0A=
>>=A0=A0=A0=A0 with `pkcs11:object=3D`, and then passed as-is to the OpenSS=
L engine API.=0A=
>>=0A=
>>=A0=A0=A0=A0 PKCS#11 id: `pkcs11:object=3D<key-name-hint>`=0A=
>=0A=
>I have no experience with PKCS#11, but shouldn't that rather be a=0A=
>"PKCS#11 URI" instead if " PKCS#11 id"?=0A=
=0A=
Yes, of course, my formulation was sloppy here. Please use the term URI.=0A=
=0A=
> c.f.=0A=
>https://urldefense.com/v3/__https://www.rfc-editor.org/rfc/rfc7512__;!!NLW=
3fF9v!Kt-msudWj52ujfJPS_zBSV_Jf8pvI1_WgEK0f17edIPw_o_DMpGzg7pNOQtcBIFfoTYDZ=
oLczC-z4B0OcGBBqqPWDZ5RHT8LGN3kRdkY$=A0 Especially since there is=0A=
>actually a possible id field, see=0A=
>https://urldefense.com/v3/__https://www.rfc-editor.org/rfc/rfc7512*section=
-2.3__;Iw!!NLW3fF9v!Kt-msudWj52ujfJPS_zBSV_Jf8pvI1_WgEK0f17edIPw_o_DMpGzg7p=
NOQtcBIFfoTYDZoLczC-z4B0OcGBBqqPWDZ5RHT8LGPYmW1op$=A0 pk11-id.=0A=
>=0A=
>>=0A=
>>=A0=A0 - If `fit,engine-keydir` is present, and its value contains either=
 `object=3D` or=0A=
>>=A0=A0=A0=A0 `id=3D`, then the value of `fit,engine-keydir` is passed as-=
is to theOpenSSL=0A=
>>=A0=A0=A0=A0 engine API. The value of `fit,engine-keydir` has to start wi=
th `pkcs11:`.=0A=
>>=0A=
>>=A0=A0=A0=A0 PKCS#11 id: `<fit,engine-keydir>`=0A=
>>=0A=
>>=A0=A0 - If `fit,engine-keydir` is present, but its value does not contai=
n either=0A=
>>=A0=A0=A0=A0 `object=3D` or `id=3D`, then the value of `fit,engine-keydir=
` is concatenated=0A=
>>=A0=A0=A0=A0 with `;object=3D` and the value of `key-name-hint`, and pass=
ed as-is to the=0A=
>>=A0=A0=A0=A0 OpenSSL engine API. The value of `fit,engine-keydir` has to =
start with=0A=
>>=A0=A0=A0=A0 `pkcs11:`.=0A=
>>=0A=
>>=A0=A0=A0=A0 PKCS#11 id: `<fit,engine-keydir>; object=3D<key-name-hint>`=
=0A=
>>=0A=
>=0A=
>*Technically*, pkcs11: prefix isn't required as it'll be automatically=0A=
>added if it's missing (and you'll be warned about it), c.f.=0A=
>https://urldefense.com/v3/__https://elixir.bootlin.com/u-boot/v2025.10/sou=
rce/lib/rsa/rsa-sign.c*L120__;Iw!!NLW3fF9v!Kt-msudWj52ujfJPS_zBSV_Jf8pvI1_W=
gEK0f17edIPw_o_DMpGzg7pNOQtcBIFfoTYDZoLczC-z4B0OcGBBqqPWDZ5RHT8LGL2ft2Fl$=
=0A=
=0A=
Oh, I missed that. Somehow I thought it would warn and then abort.=0A=
=0A=
>But yes, I'll do this rewording in a v3. This is not up for merging=0A=
>until 2026.01 is released as it's not a bugfix, so we've time for some=0A=
>other feedback/review before I send a v3.=0A=
>=0A=
>[...]=0A=
>=0A=
>>=0A=
>> Tested-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
>>=0A=
>> I did test the 3 cases listed in the description of fit,engine:=0A=
>>=0A=
>> Test 1: No fit,engine-keydir:=0A=
>>=0A=
>>=A0=A0=A0=A0=A0 fit,sign;=0A=
>>=A0=A0=A0=A0=A0 fit,engine =3D "pkcs11";=0A=
>>=A0=A0=A0=A0=A0 key-name-hint =3D "<object-id-of-my-key>";=0A=
>>=0A=
>> Test 2: fit,engine-keydir present, and contains the string 'object=3D':=
=0A=
>>=0A=
>>=A0=A0=A0=A0=A0 fit,sign;=0A=
>>=A0=A0=A0=A0=A0 fit,engine =3D "pkcs11";=0A=
>>=A0=A0=A0=A0=A0 fit,engine-keydir =3D "pkcs11:object=3D<object-id-of-my-k=
ey>";=0A=
>>=A0=A0=A0=A0=A0 key-name-hint =3D "MyTestKey";=0A=
>>=0A=
>> Test 3: fit,engine-keydir present, but does not contain'object=3D' of 'i=
d=3D':=0A=
>>=0A=
>>=A0=A0=A0=A0=A0 fit,sign;=0A=
>>=A0=A0=A0=A0=A0 fit,engine =3D "pkcs11";=0A=
>>=A0=A0=A0=A0=A0 fit,engine-keydir =3D "pkcs11:serial=3D<serial-of-my-key>=
";=0A=
>>=A0=A0=A0=A0=A0 key-name-hint =3D "<object-id-of-my-key>";=0A=
>>=0A=
>> I think the suggestions above would improve the clarity, but even if you=
=0A=
>> choose to keep the text as is would be fine for me.=0A=
>> Both code + documentation:=0A=
>> Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
>>=0A=
>=0A=
>Great, thanks!=0A=
>=0A=
>I was wondering if you had experience with using id=3D in the pkcs11 URI?=
=0A=
=0A=
Thanks for pointing that out, I have now additionally tested with 'id=3D%01=
%02%03':=0A=
    fit,sign;=0A=
    fit,engine =3D "pkcs11";=0A=
    fit,engine-keydir =3D "pkcs11:id=3D<id-of-my-key>";=0A=
    key-name-hint =3D "MyTestKey";=0A=
    =0A=
There is one other aspect of the current solution that I'm not sure about:=
=0A=
 * key-name-hint is an attribute per signature=0A=
 * fit,engine-keydir is an attribute once per FIT description=0A=
 =0A=
I don't know wheter this is a use case for anyone, but I think if one would=
=0A=
like to have multiple signature nodes in a FIT description (e.g. multiple=
=0A=
configurations) and would like to have them signed with different keys, the=
n=0A=
it would only be possible to do that via the key-name-hint, and thus only=
=0A=
via "object=3Dxxx", but not via "id=3Dxxx".=0A=
=0A=
>It'd be nice if I could add a test with SoftHSMv2 for that as well but I=
=0A=
>wasn't able to do that fiddling around.=0A=
>=0A=
>See 0707f73a8ba2 ("lib/rsa: allow matching pkcs11 path by object id")=0A=
>for the commit that added support for it.=0A=
=0A=
regards, Wolfgang=0A=
