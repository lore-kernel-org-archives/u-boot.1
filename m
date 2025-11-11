Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E50CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56C183B95;
	Tue, 11 Nov 2025 15:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="A3rktila";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8073783B97; Tue, 11 Nov 2025 15:49:28 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6E683B87
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgIg4TTFessGb0Vv2GgD7qAVgsIfKMzOmzK2BQv1SS5quinmsPNI1e3wRiDFHe/HWzDRMyype8CW2d3imj9ngOArL3GIOgFXJ+rSpbRfS5kszYHow69YG9zyFs9keCOGa0xqp7Z8l//2fTPTBoMdy1gmlX1/FuBqFDvHlhOeT+oWgzI/jteoju8YenWuEWtNslhXJEVz+PxdU5R5KxGxc2ZZtwh77anm3j3BHuxI3TBPlEnPpBv+KgIMxoLc82IhW3ircGmPBeASYDXIYEu0AJMxlcfV59kJZyeg6GkqWsWLjM4QxmWF89oew3HTK0Deqocq1j90yfixxNWBd8A6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnHKCj+HZo5QamDIeEOqsCJR3eeE2iwKY/X8DR3bYlo=;
 b=FWvg0wyVVzqaTS3Rnbf74WpP02P6aGHJclSu9m8FbtK7jFh7W1TGsHAf16VQad7dw3NIDZM9PhuCZI+PVA72NAxVxdSypWnPL7uiUJKFbAmE+psSdk/X9PSF6qM/MdyasEJ6gOQ+dIRXNZvbLzhtA0+TTy1iCs/lFzvxjudEeRuxKNZd5uW1t4Z2WXRzbF/hZxLca7xOvVO3jdhuisbH+MNet2Y69LQJ+lwieByCIEvIF0vzNLaTKP+GZHGH6LMntZia35Pmf1B0tgz/9s8MSsqIllKr5CtI6d0ME4nV+NzVv7/cIjcrJdwry1+57mYhunlhcEB8GwSx3cWODqoXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnHKCj+HZo5QamDIeEOqsCJR3eeE2iwKY/X8DR3bYlo=;
 b=A3rktila1doTEOwB1RCbGLDGCNegQ1PkzY7GcTwmMF82//e24tOlpH8FwqqZCkWj0IKM1XED7Xbthob2umGG3YxzOfi6xO3TEIzT9/JDTkMjjhNQRO/2k3YNVUxxG1wm0yiuPzGt0Ockv7AoHYoG7hk7v7H4Pu4W2clzVhmawG0yQBJ19roGWXMZzcbRzYmS7pxWB8IWwstrV+FkvjtV7wq3mLERLHPIYa1UfcTRVUL5V0Emes2GVb0SNDVoFORSQENslYnF8L90Ey4KhgV05vCT8NewiJW1b1Sd/0t9drhpoXBjGwLhMrqnw0Jvf8VdTOm0o+LGQgZzLykElrD17g==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by GV4PR06MB10085.eurprd06.prod.outlook.com (2603:10a6:150:29b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:49:24 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:49:23 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <foss+uboot@0leil.net>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 0/3] fit: allow signing with only an engine_id
Thread-Topic: [PATCH 0/3] fit: allow signing with only an engine_id
Thread-Index: AQHcSnpYr4kc498d7k6V/7PX2nvgyrTtUAz2gAAV8YCAADl8Vw==
Date: Tue, 11 Nov 2025 14:49:23 +0000
Message-ID: <DB9PR06MB8512A8D1CD156E480B828FEBCBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <DB9PR06MB851219BF2BFB0D28C7211A0CCBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
 <99660d82-6b18-453e-a693-6c02f5eb168f@cherry.de>
In-Reply-To: <99660d82-6b18-453e-a693-6c02f5eb168f@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T14:49:23.348Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|GV4PR06MB10085:EE_
x-ms-office365-filtering-correlation-id: 86063381-dc26-4ed5-ea96-08de21318149
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YNL0/tB1xoSKIS10i/lNfCVnOzeAxiiUavSsrdt5LxItcAOsSFbglagJ/W?=
 =?iso-8859-1?Q?hgtYH+JlQGK/OlmF4M4vLFiU1FT56ECzVwf8iFI/kGKcnplodGcehV+3pg?=
 =?iso-8859-1?Q?/FCqzp/66to/riY6sDmQZuVWqq0Jbt7jqF2x66HUdo2O3vq+dqb9t11JpK?=
 =?iso-8859-1?Q?49MoT5eGBjzyo09micunOdJumn3rQmGqUqDpkwjGnsBo3zOFnV0XK4qLyf?=
 =?iso-8859-1?Q?ltYxhMnwbaUquuN75oVQ5k5nxI/WOxbVjlxfVJ1Fv6RBE8OR7usP25937L?=
 =?iso-8859-1?Q?Nneob+OqOqgipvyiiLsK7uXPXkx7hWQ3VK3ABTlz2PTgKFj1pky1JQwWnf?=
 =?iso-8859-1?Q?ASIDiPAML8bCedRlXSVpHb+O++c1RlKsklpzQk3DXvDxY7a+5sm9rtYmbm?=
 =?iso-8859-1?Q?oPHnX7V2TIfz0cJHWJnZ9wWzDNJMJk364nQaifvQNra/cmobJpWXN6ZsIF?=
 =?iso-8859-1?Q?65EBjpmtTn/DnH5Zyvzlsee1VMfhcMNJaE2baS+bJlRcq9xCNdPqRu+Jm2?=
 =?iso-8859-1?Q?et5rZoJwR0WJfc/XMA6iejfyGR7Ev8XYR95YlADBuoY+Ohgre5cdM+rJAw?=
 =?iso-8859-1?Q?39wZ7i2Cfc81dtdh0O/T9AaptvudA2Ncdc/jjlICvpkWVtgBpgcQ/+NLqz?=
 =?iso-8859-1?Q?2unBG8+L5h62R6eah6mBAFVlXE0RLrlYTNcKjLF619XntqQttUk2scMYnW?=
 =?iso-8859-1?Q?gmS6BC1GWMJRbj27qVVUMFILS4UbRnhZLTa3NzP2wFvfaQhQCsgVLbMi/Z?=
 =?iso-8859-1?Q?wQO0f2dpGzd/93eXHeXlJn73ALp10rmtsxjcrK6Kl/x67VPq21S3fnSUo6?=
 =?iso-8859-1?Q?+mge4SK/6LNt15Wo8Jmc9K/T8pPM2hYdIL0/thKITodsKOmoWpKe29e6I0?=
 =?iso-8859-1?Q?vJfFl7678lezp8l3F1qpJzjOt+HSY/qJBjIUluzX7pZAzQp317SGZzXXfA?=
 =?iso-8859-1?Q?DHHvFGx8/S50JS09hCuAsr8JqNXZVmyXixYDirlgCvaCGo9ckpcdXqAy1v?=
 =?iso-8859-1?Q?3YxgnF6SaukD1ue3CogTB9TZChogZuUWdfLk1y2VDr9y3AJJGIsP4jfCU8?=
 =?iso-8859-1?Q?V1eCyJ8EtAghZGk7gQvfziEazXv563HnQOIzdD0DH+l6Mv/ZFRRnhPpL0p?=
 =?iso-8859-1?Q?I+d3J/AUFy/dHU0jws5s3Vew8ZbE+0vfkPGryF7Tc620K9gZ5+Ms2mifpf?=
 =?iso-8859-1?Q?pgwh/iynfwSJwDzNIezUYOUo1wMt2mjZSap3l5tGzYDgGh8wtDIm+UTW35?=
 =?iso-8859-1?Q?sLWKBor8FRDiBe/lp+QUhplfIWmTIWbJ2MknPIAFY7M80b/Pb7kRSIPIqh?=
 =?iso-8859-1?Q?+IWxZXHo8HaP3Egr+zV6PajNlvQwrtgNQ7YT7cQCsF9yfPq5MIm9KcWB+O?=
 =?iso-8859-1?Q?vbZFGLAzMR0Hgo+tkhKc+HWiWaceXXqakX9xXlHQ2oCz4hrxBzHWN9x0mr?=
 =?iso-8859-1?Q?8g7Fw5cdYyZaZ5q8pA52jHMFl+InFurex33ZQj3jx9Kwn5XKRf6gi3NRsG?=
 =?iso-8859-1?Q?VNCnzenthvj/5vCVwDeP8wQAuP5Ga+OxDWpxEzslYRJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n7A+F/WHwQpPQB4lwDadgcQ+Bq5+C634q+lnGLYc5B83i6gYmXjPsltdOt?=
 =?iso-8859-1?Q?hYdjLQrw/ROFw880A0+Y4m3mLzYS2DOLZkQ2XYupKiCY1Ers9Y1S+mTr3U?=
 =?iso-8859-1?Q?LO/jJx54V8nqUpPTeiS9XC9YGCMZh6hhbKtGJ0S0HxZU+TCNz/y9Jtx98u?=
 =?iso-8859-1?Q?OwJ3nf84pW2abetdKrYaXN2NsM7zHqxZT9hJBcrUwLfd8QgVvBUHe95Keh?=
 =?iso-8859-1?Q?Qo+7ZAKKIIWmkG2zJwDZZZolauYBRaEAIZOYfaIvTshmfNqfoDzGhWe4vj?=
 =?iso-8859-1?Q?ABb1lm6Y+DKBZA+MtoI3aCjm+39+USXuhC0DomhaLhxuRUSfrn3JO69fmJ?=
 =?iso-8859-1?Q?p09ZC8VGxYpN22gP8tFJUmO2BtyTtZmYgVjNNn7ntTltQebfcvXiV0/SEz?=
 =?iso-8859-1?Q?RDVM6lt8ZqweOtJgGPqxXRWhd2BqjHzHW4NpIuMzag9bInpWjdgD79/efn?=
 =?iso-8859-1?Q?CmaHzAGcaz6aFDViK47d3vibC6ZL6ReUMf6lOMjJWigVdifTQjodxcsvdj?=
 =?iso-8859-1?Q?BUyOz+zBn/NI9OsCZsFvgXZWfZPQt0Msdl9b8p5CieWyxuQJ+Z2yAYCu7U?=
 =?iso-8859-1?Q?uWY53gLwZz7bSKfcx8alkXWpZ9N5YwnbdHyfiv9HdBa+d0F9jz5V3z1e6u?=
 =?iso-8859-1?Q?Ip8e4Lct8j5gHpGQhvMmiW7mspGIO6KcekQx0W2YgL0Ww2AV9mGVr9XzWO?=
 =?iso-8859-1?Q?BJbk0XP6TlSud1hnQJRo2qzDNXTqSTC1fgOHUnnG/QimzuSdq5mD7iMBix?=
 =?iso-8859-1?Q?toCnbjp/egmEbhVJkw5mLs8EcOHEmQ4jqL1gGI5UhGTz8VLlvQH0Y7FgrD?=
 =?iso-8859-1?Q?wp4IwSoXInxzahU8MbyYBE/WyP5zRFn484ZWmMbvzX7VZ2KLuYVHZqOjvT?=
 =?iso-8859-1?Q?nqlrk9eY5I8MTOIjuwSzrn2gfJWNl9XC0IO7IDKZsoE+u84jPFmdh2XseP?=
 =?iso-8859-1?Q?gLH5LhoOIf9CRtPGMtVbjO8ylD7X5XNK5MoK6l/NcwMxrURtCbpmZILWv7?=
 =?iso-8859-1?Q?nOTvf/7wXsCyiaDoAL0l51IJZ2P3Dpy+C2Put39ZdR1WkerQhV70VTX4HE?=
 =?iso-8859-1?Q?/yIOFR/oqSwTZ5LXC3BnWOAOzYj6kOf2CXRp431vIKQNb70tJZyV7gpDRC?=
 =?iso-8859-1?Q?nIuyIfTVdissmx0ioKyMuHq17jxOxX8yc6Icyc0xQB7168J3maqXdRaWuk?=
 =?iso-8859-1?Q?6Zu9szgq0qMO3Daj1xZwrzfM+jUIVGWRJGGl7mihrOL5I7udQkqEqdlm8O?=
 =?iso-8859-1?Q?kNRBBS+T2JCRG2gSidhIU4932USI4bC3pCOody2Ktnd+PFhriOP4fM5/iV?=
 =?iso-8859-1?Q?79F23a1TfNxQKj+GGZl3kLuzjCGR6cHg5Tf8hgakUYAeisrlNBp7Hfsyim?=
 =?iso-8859-1?Q?trVDCMhg3MDKjlZwv+ls2ehxaTp5YCCbItZJkJ0F2kcqSfXHVgIy7Ha/eH?=
 =?iso-8859-1?Q?1L1/aSXXn694j0vPTSRzML0tFJn9aB/LoZ82kaHtxLbqOf5uR4RUprMwBd?=
 =?iso-8859-1?Q?hrm31FBSrAxsFV6Dq2Bk/0zmkZd+WTj8CXTH0nitroLuPU/BAakdbQUNDn?=
 =?iso-8859-1?Q?VMSKbK36KbhJAHqTAqPnV1Pj2th0ppwm3qC3AX9Fy8OYsRuo4m1vG1r0+v?=
 =?iso-8859-1?Q?JblvB6pqXdWTR2M4oe/bWL21qMC/K8WW9/6wPgbg+sX0tYHV4MK/uesg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86063381-dc26-4ed5-ea96-08de21318149
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:49:23.9245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cROdDIVKX4A99lkcInMQ2OXqMMKQlvePZctKDTuxqPkwP0MhFLHuHX8rxW6v2ZnuTwTCQGT/xEN1DbcPeHIcRnBJYaCRHAiPLunzB0ffKGWTYG/NCfiwnOSLl5bYtn9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10085
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
> On 11/11/25 11:10 AM, Wolfgang Wallner wrote:=0A=
> > Hi Quentin,=0A=
> >=0A=
> >> This series allows to sign a FIT image with mkimage (and binman) with=
=0A=
> >> only an OpenSSL engine and no key-dir. mkimage will read the=0A=
> >> key-name-hint property and pass that verbatim to the OpenSSL engine AP=
I=0A=
> >> via the key_id argument.=0A=
> >=0A=
> > Thanks for implementing this!=0A=
> > I was already looking for a way to implement this myself when I saw you=
r=0A=
> > implementation on the mailing list.=0A=
> >=0A=
> > I have tested your patch series in our environment with our PKI provide=
r.=0A=
> > Our PKI provider supports the OpenSSL engine API with a PKCS#11 library=
.=0A=
> >=0A=
> > Signing and verification with your patch series works fine in our use c=
ase.=0A=
> >=0A=
> > I only stumbled over a small issue, but that has nothing to with your p=
atch=0A=
> > series:=0A=
> > Initially I used the same key-name-hint in the FIT description for=0A=
> > U-Boot proper (which is then used by mkimage for signing) and in the=0A=
> > description for U-Boot SPL (within an u-boot-spl-pubkey-dtb entry).=0A=
> > In my case key-name-hint contains a colon and several equation signs, i=
t looks=0A=
> > something like this:=0A=
> >=0A=
> >      key-name-hint =3D "pkcs11:model=3Dxxx;manufacturer=3Dxxx;serial=3D=
1234;token=3Dxxx;id=3Dxxx;object=3Dxxx";=0A=
> >=0A=
> > But when I do this, I cannot decompile the final SPL devicetree any mor=
e.=0A=
> > Decompiling with dtc gives me a "Bad character '=3D' in node name" erro=
r then.=0A=
> =0A=
> The issue is probably that we use the key-name-hint for the key node in=
=0A=
> SPL DTB, c.f.=0A=
> https://urldefense.com/v3/__https://elixir.bootlin.com/u-boot/v2025.10/so=
urce/lib/rsa/rsa-sign.c*L677__;Iw!!NLW3fF9v!NY3fN9fyh10vF5rVo7-QzKVDnswgoET=
JaGRb-wCmd8mCjtUXscKGXP7DjqRDJt79NEjixr6ATvMFWfY0vppIHVJNggm5SpqGOpnVHenp$=
=0A=
=0A=
Yes, that is the line that includes the value of key-name-hint into the nod=
e=0A=
name.=0A=
=0A=
> We could sanitize the keyname to make sure it's an appropriate name for=
=0A=
> a DT node. According to the standard, allowed characters are=0A=
> =0A=
> [0-9][a-z][A-Z],._+-=0A=
> =0A=
> and the node name shall start with a letter. We could iterate over the=0A=
> string and replace any unsupported character.=0A=
> =0A=
> We shall do the same for when we try to find this key node,=0A=
> https://urldefense.com/v3/__https://elixir.bootlin.com/u-boot/v2025.10/so=
urce/boot/image-fit-sig.c*L87__;Iw!!NLW3fF9v!NY3fN9fyh10vF5rVo7-QzKVDnswgoE=
TJaGRb-wCmd8mCjtUXscKGXP7DjqRDJt79NEjixr6ATvMFWfY0vppIHVJNggm5SpqGOopSJNvU$=
=0A=
> and/or=0A=
> https://urldefense.com/v3/__https://elixir.bootlin.com/u-boot/v2025.10/so=
urce/lib/rsa/rsa-verify.c*L538__;Iw!!NLW3fF9v!NY3fN9fyh10vF5rVo7-QzKVDnswgo=
ETJaGRb-wCmd8mCjtUXscKGXP7DjqRDJt79NEjixr6ATvMFWfY0vppIHVJNggm5SpqGOr9w2Pt_=
$ .=0A=
=0A=
For me this make sense, but Security is not my main area, it would be good =
to=0A=
get more feedback from the U-Boot community on such an approach.=0A=
=0A=
> > As a workaround, I use a different key-name-hint in the SPL description=
 now.=0A=
> > But as mentioned above, this is just something I found while testing yo=
ur=0A=
> > patches, nothing caused by them.=0A=
> >=0A=
> =0A=
> Can you show us a snippet of how this looks like?=0A=
=0A=
Yes. But I'm not sure what exactly you are asking for.=0A=
Please tell me what you are interested in, and I will provide it.=0A=
=0A=
> Because as far as I=0A=
> could tell, the key-name-hint in the SPL pubkey DTB must match the=0A=
> key-name-hint used for each signature node in the U-Boot proper FIT=0A=
> image.=0A=
=0A=
With the workaround I use (full key-name-hint for U-Boot FIT, but simple=0A=
key-name-hint for SPL) the search for a key in rsa_verify_hash() will fail=
=0A=
at first, and then the loop iterates over all keys (in my current test case=
=0A=
the is just key), and the verification then works with the one key that is=
=0A=
found.=0A=
=0A=
> But I assume the key-name-hint for you is used to pass parameters=0A=
> to the engine, so you cannot really NOT have it named this way?=0A=
=0A=
Yes, exactly.=0A=
=0A=
mkimage would support to pass in this information via the key-directory=0A=
parameter (-k or --key-dir). But this has two drawbacks:=0A=
=0A=
1) It feels like a hack to pass key information via a parameter that is=0A=
supposed to be a directory=0A=
2) It is currently not implemented in binman.=0A=
 =0A=
> Maybe we should split the double meaning of key-name-hint which is both=
=0A=
> for identifying the signature to use and how to sign into two separate=0A=
> properties.=0A=
=0A=
Yes, I think that would make sense.=0A=
=0A=
How about the following?=0A=
   key-name-hint      for a short human readable name=0A=
   key-specification  for a full description for which key to use=0A=
   =0A=
In my case 'key-specification' would then be the long PKCS#11-string which=
=0A=
uniquely identifies the key within the PKI.=0A=
=0A=
It might make sense to also add such a parameter to mkimage, as it does not=
=0A=
really fit the description of a key directory as mentioned above, even if i=
t=0A=
works in the current implementation.=0A=
=0A=
> > This series is useful for us, and I'm happy to assist with further test=
ing and=0A=
> > review. I'm not sure if I can help with creating tests, but I will have=
 a look=0A=
> > at the things Simon listed.=0A=
> >=0A=
> =0A=
> I'll look into mocking the calls to mkimage for testing the binman part=
=0A=
> correctly calls mkimage but I think we should also think about adding=0A=
> test for (engine) signing with mkimage (and maybe even verify that the=0A=
> generated images work with sandbox for example).=0A=
> =0A=
> I would also very much like to have a way to sign Rockchip images with=0A=
> the default binman instructions in rockchip-u-boot.dtsi, but this is=0A=
> currently not possible for multiple reasons.=0A=
> =0A=
> 1) we misuse/abuse SPL_FIT_SIGNATURE without an actual signature/pubkey,=
=0A=
> only for verifying hashes. We should sign the image and add the pubkey=0A=
> if SPL_FIT_SIGNATURE is enabled, and fail if it cannot find a key, but=0A=
> we cannot do that because it would break current users. We would need to=
=0A=
> split the "check hash" from "verify hash with signature" functionality=0A=
> behind another Kconfig symbol for that. I don't think it cannot be done,=
=0A=
> but we need to be careful to avoid forgetting about checking hashes when=
=0A=
> signature is enabled.=0A=
=0A=
Is this behavior specific for the rockchip code, or in the generic part?=0A=
=0A=
> 2) Make most of the signing configurable through environment variables.=
=0A=
> key-name-hint, whether to use an engine and if so which one, the=0A=
> checksum algorithm in algo property, the crypto used (RSA/ECDSA) and its=
=0A=
> key size or whatever other parameter passed to the algo property, the=0A=
> padding type (PSS/PKCS) and salt length.=0A=
=0A=
How would it work with environment variables?=0A=
There could be multiple signature nodes with different key-name-hints in a=
=0A=
FIT description, would you then assume to have different environment variab=
les=0A=
for each?=0A=
=0A=
> I believe we shouldn't make=0A=
> those part of the hardcoded binman configuration in DT or from defconfig=
=0A=
> because there is no reason to patch the tree (DT or defconfig) to change=
=0A=
> signatures for essentially the same binaries. We could have environment=
=0A=
> variables used in the binman node in DT though (but for that to work, we=
=0A=
> need to pass environment variables to dtc via flags, or create Kconfig=0A=
> symbols generated from env variables). This means many environment=0A=
> variables to document and test. Not sure the project wants to go that=0A=
> direction though. I would also want this to be something followed by all=
=0A=
> architectures, not simply Rockchip, otherwise enabling SPL_FIT_SIGNATURE=
=0A=
> simply isn't doing what it says it's doing (I can boot unsigned images=0A=
> without any issue from current master, which kinda breaks what=0A=
> SPL_FIT_SIGNATURE seems to be hinting at "Enable signature verification=
=0A=
> of FIT firmware within SPL").=0A=
> =0A=
> I'm planning on sending a mail in the next few weeks to ask what would=0A=
> be acceptable for 2) but I am not sure this will go anywhere to be honest=
.=0A=
> I think implementing a new feature for checking hashes without signing=0A=
> (1)) makes sense and is unrelated to/not a blocker for 2).=0A=
=0A=
regards, Wolfgang=
