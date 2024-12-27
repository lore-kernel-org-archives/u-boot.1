Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A5AE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 13:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3DF8036D;
	Fri, 27 Dec 2024 14:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=idtech.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=idtechoffice.onmicrosoft.com header.i=@idtechoffice.onmicrosoft.com header.b="okpdaahX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C6780384; Fri, 27 Dec 2024 11:54:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DAE08036D
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 11:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=idtech.be
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aleyssens@idtech.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRQrXRyecVtlAZAPOsvlaffUxC1YDEgiBAVk3DhWb1iRkPxIxv7Zqf2b7F6uZMZ0uVl/bdyIEFbhHQ0zMeRF+Oo+jLmFtuhYoMolcW8AwLYdM/gLqXTo13GbNdWj70nEqoD89nwf/6lDZC96JET09bdWP9eeLBrx1SXrohCYMRVYYyASsR9hS8kOqAY0feAfF5+EupCkoTJWO4xaqfyNtOqQgFhnFAOZXNdV9envfoSAre5x/FQa/oX2y45BR3cDXDfyjbd/m3eeVadz4U8iRSrfEQTx92PVEbi7fiZV68P7zG9LlT4n41LAgV9WFJkiKx94GM0DdZQ/4Iu6N48AOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8sEzTmer138vmT4WMgF7O6D48t835ZHh2j+iwqlW1A=;
 b=caF7OTn6a5w8CPTUN1VdNXKeIqO7LW6o8oDE+V8rorFO7ct6nk7kcSR9Aw1e073dmDsMtJEOiamRqqScE/DszuSqMKgWU0Ucpcmp5zTJsjlVGeAK4dV2dbmLNUlwsfXpWeDtsTlhtu1sE+YhCHDsHSXdViBCXvK4jdv51dtnBcqrBszSUGhNVrNvRXLf0LiMKzauRtGYe7DG8Z85UFLPtiUzzFVmB3bw1ssPEBoduxPA9yLjecQ8Lc7OJxQcvjoSBitLMDTNHjZuNdZtsg7fj25maAWCXe75tzlyxUEnDzZEn0vZg9gCpDQAPSV+XyDawC6atVi0YXgU8Ym4HINURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=idtech.be; dmarc=pass action=none header.from=idtech.be;
 dkim=pass header.d=idtech.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=idtechoffice.onmicrosoft.com; s=selector1-idtechoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8sEzTmer138vmT4WMgF7O6D48t835ZHh2j+iwqlW1A=;
 b=okpdaahXkDJL8RTkcPdtXK5r3jpWdfrf7V4nr1WJgyjvrJ45tFvnJKBDpqH8fIOUnLaRBSTUtbxi3zBnRRIpzs/fTOjiUJ9Lcnk6kImzQP4lEAqY1Mx7CbZ+DKt5BDFLkCT3nFjPwf3MpqsGL8pNohdSLNFJw9oA0/9+V+tB2GQ=
Received: from VI1PR06MB8926.eurprd06.prod.outlook.com (2603:10a6:800:1dd::19)
 by AS5PR06MB9037.eurprd06.prod.outlook.com (2603:10a6:20b:67d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 10:53:55 +0000
Received: from VI1PR06MB8926.eurprd06.prod.outlook.com
 ([fe80::972a:41fb:f85d:e1b4]) by VI1PR06MB8926.eurprd06.prod.outlook.com
 ([fe80::972a:41fb:f85d:e1b4%2]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 10:53:55 +0000
From: Ayrton Leyssens <aleyssens@idtech.be>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: iMX8MN: SPL not starting U-Boot
Thread-Topic: iMX8MN: SPL not starting U-Boot
Thread-Index: AdtYTZxTkxlmuKiETgyZUVUbYInseA==
Date: Fri, 27 Dec 2024 10:53:55 +0000
Message-ID: <VI1PR06MB89261150B5D747962890634DAD0E2@VI1PR06MB8926.eurprd06.prod.outlook.com>
Accept-Language: nl-BE, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=idtech.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR06MB8926:EE_|AS5PR06MB9037:EE_
x-ms-office365-filtering-correlation-id: b78cdadd-d820-4766-b09f-08dd2664c20c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8tSbp3nl0iiLocBGKNULqt00PmV2M5Z5onajk99ivXfqYgrcgdfM6YiOMHke?=
 =?us-ascii?Q?0234Rj2YTlGCwais8YtR5yh5ThjLJT8ZCY55NdcNIundd5t6KFwtu/TNWAJV?=
 =?us-ascii?Q?721xF1bh0R49OZo5vnHI3Ja8x0nGrWNrO5S/evPUMDVrZWcE6h6a7D21MocS?=
 =?us-ascii?Q?tY5xhiIe3W+3GXvO3Qd1v1fsqs8ZIleilowZVDPcaN+51cyl2xdNUPAPMhUM?=
 =?us-ascii?Q?BdkR7CowgSrbU/2uZ0s49+RpWDbzK/SIThrtCqBvTAKAG8QQiX/uv+9OcH+K?=
 =?us-ascii?Q?WVRb79+fCD2WLGpzODxj5O8qhE8TL+dSNWsAJ9TjGb/iiucmDDTqRWdfbCeQ?=
 =?us-ascii?Q?CwOVGYi8m3KuOuyfsY3SXEGxYMx3lLcxPpeuZ0AMd+aOHDMrCr0uJpUDsNIK?=
 =?us-ascii?Q?lObNfqgNkec0W9UWlzhlal5E14Ta3cyGh2+0MG4if8rUdgShhr6sjOKq8V2U?=
 =?us-ascii?Q?O20apBFXt0Vddd2o5R8ao041wDbOxMvJlHd8IKzugZirOZwkjXgIQezzzp4d?=
 =?us-ascii?Q?j8/NhpxhAT5uFknhxfC4EeWNVRMrx4Iqa6P15AHxDCRAQFHSl2uFVC6MTDZj?=
 =?us-ascii?Q?aWohKRVDcUuDkKdLPriTujMO6yM7oZ9Y+ZqL4AtS7coYhbZM6GjZJsAWJ/u0?=
 =?us-ascii?Q?yn/2V3QtXx6mq51UAXYmtPqc/sM+i2yz8O2IuvDP58d/TjKqRhAP0ReNVrdQ?=
 =?us-ascii?Q?ebqwZKnrDWLleGo3QYNwTrwScfSMaszB2dqrkeXhzlT4ZsSxk4BaB4iyk98r?=
 =?us-ascii?Q?IwYSrym1SEnH3IFZ8kg5KWabc9+3CMz8DC6/+pTaPYf47qsAupPITwR4TLQh?=
 =?us-ascii?Q?Zj+O45M623bYoMdmvaxFOl1YMRSRqsZ62vDpA+fH1ZrFuB3JEi9rZNVAVRLr?=
 =?us-ascii?Q?AF6z/Z4WyddxnWb/9HUs+llivkXj16+2abxVcqzLTcSOfkRyysrVCGBZSyDI?=
 =?us-ascii?Q?1BvLsvd26gsPDiqHtpGtNN5flTqKaYQ4XeGRYJXyjWuZ4XeKl2Y8MshjwFih?=
 =?us-ascii?Q?YWmbw1e+Qq6bVPkGsquuSP7Fdie8TklYuO1jymyWs7D9/uuXy5nG+pxmMk/a?=
 =?us-ascii?Q?KoKtMd1B+veuLfTCW40gPvBLxCgjaNu9UrpB0IvhWU8Bz0TjFm6RV7OAf3Kj?=
 =?us-ascii?Q?GyalnphsHk3PNhxP9z+EhBmS7JrmhCjL7KrsAqq6DOaoFCDTeIrQAia7fBsM?=
 =?us-ascii?Q?XjAujPAvvvyFtJ74QG6Wpb9qTewpcZ1xH+H54413LlIHqNs8nnuI1VYOwyzu?=
 =?us-ascii?Q?JABBNewCV7rPSNye2f+7YstZGz8W//FrujNt0+2CSjg9LFysA3vNJuP5m4el?=
 =?us-ascii?Q?LMLQstqOHKqU+5dK7GT/cdKTiV4QozTjGx82fEZlOx2U/qxc69+Tn0HEmebC?=
 =?us-ascii?Q?SM4W1oXU8me1Woede9rpuP8CxiR6fVtYebZd1RsvEb+G7YaoUqjhNPkU6PNH?=
 =?us-ascii?Q?GX7uICBB3xkOcN501NBQFZdV5yamGMi0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR06MB8926.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?79WTDvjzxSoz+YYYYwvJUuO1fJsIcMtveoukyuZ20lIRB1WLmozPz0Zs4wIR?=
 =?us-ascii?Q?CA1y51DWMCyH9INkZNl+wqaeWhy4ovoGaanHqgJrBuwY7DjbLKSWtLwC/2SY?=
 =?us-ascii?Q?QxNOI7s1MpPuYjWOJABxgf+g/y5Ey6CRekF4TaECj+p6F9POAK28PYMjxPUX?=
 =?us-ascii?Q?kWAh5Rb4LXLN9uM44zHiI/bRH+soty/+F3LPczltALcUB/YDHapjcLD/tEiH?=
 =?us-ascii?Q?lKpVbHZuowghEhfOZt90HYQrVT+6biFinKY45TZ5Q3+TlWGeBA1j/V5rkr1m?=
 =?us-ascii?Q?k2Xlzf4jNGhcJtf8fXhPYFAh3/KKXrYiXwe6F4IgfsTjOCIxItUCr9HlyTp2?=
 =?us-ascii?Q?q0ERgN3grfZA70Qr4gxmkePeL0JZ0D8AIqDYm9NLkIxwWYdGkjHdO/6BSrCU?=
 =?us-ascii?Q?PMvPlyW/KoSByHUVmQDJqzm5eJd0zJSXqTht5Ocqpo0Qap8K3/JSaWfIrNY6?=
 =?us-ascii?Q?KMRIDxWc16Iig4XH6RlYSFNKKnji3ekN/3XsBSnpi6EtdVehTDI73hY+bf8u?=
 =?us-ascii?Q?f0I8VdC/Yy6MVmMvPmof2WBrAmCzpD5rAij4nA1t/Wf0l1JqbwtXx/X2R+uk?=
 =?us-ascii?Q?5nHEyfDhYZeFs6IeMRa/22197nhX4UOOklvp3nhJxNEuq9yf5zRa9twzR28P?=
 =?us-ascii?Q?lwtcPRBua0/2+Q88wLZ86jZdVnUjjD5WHO/xSncqn5W8NlSE0XAm1xDhKc6F?=
 =?us-ascii?Q?MUs3X3yxAsfsJQFMerD6emU1SZTNiI8QIamRXMDqmOV5TR/NoJ3wLHHBgGfY?=
 =?us-ascii?Q?z+g4UuOEA+glAHlj275+2Z48CHiytBfAZ1UxIjgm6jsmHbQBZe2yYe9I9AOC?=
 =?us-ascii?Q?k+wNQ1q5AiMG5da5I+kk4kLDg5UAqlecMrFUTYTVWs+iK+czC1KabNWFw8IT?=
 =?us-ascii?Q?1UIab6EJZdUhJslu1u+4y717KbLUX0qQkq+VGoRaGLFAiOzfFg/ouGD0nsrW?=
 =?us-ascii?Q?HqlP0P5SdwEcCLf2C31kVEahLKzPvMytFzGFUZJYbfM0uOTIzig4EWmAZkTO?=
 =?us-ascii?Q?Nwxd6VTk8n2pSL81Le6QybKMrI+nv7O164q3AdtAooqKwpn9jwlfCby29qb8?=
 =?us-ascii?Q?rw2upAUjjJ2EHDGV3qLEMK8Cr+TjhvTeLFMjUrEU1t2fRN+DWl14U38DDofA?=
 =?us-ascii?Q?lFF/HM0PtJf/c1dOnYLyTCbB+Nu2lEwhomWPu/8dulMZtJ47xgbvr0waBrs4?=
 =?us-ascii?Q?DPRQmpZeJ+92kDmHRAt10CUgefI/uEk6Dp8lMdJr45iPf6inFIeRmb3ZO1TL?=
 =?us-ascii?Q?hQcVCkUd195znd+iKGVHAgCuqO8aHHL1/2wVMGW6eQ1BCMhJIiyeKSGMs+iS?=
 =?us-ascii?Q?NCiRL+9Ay1J6I+x8A/qlCORILMPY3LMKN8r9HtAwHWV+2NahKxrQlLmH4E2v?=
 =?us-ascii?Q?j3h0Vm9BJtOBeFFWpIlQrlcwTGKaA6zuS9GL0Fel8O+WnBF6ZM96Bm9/TwHk?=
 =?us-ascii?Q?oHMCms5yXecB1xlfvWgvuIIogtyVc64CRon07zqJGAfsiKOKmvEiz1tCeZ0p?=
 =?us-ascii?Q?z8n7Ctgwa3gRJArEiQwg+qBpxCPowXIlO9HtpNr04gsy5isWZjX/uW2KhrYl?=
 =?us-ascii?Q?SPWV8xv10/0p5gUYoVw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: idtech.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB8926.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78cdadd-d820-4766-b09f-08dd2664c20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 10:53:55.0575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 982732bf-7da9-409c-87ae-889ccf886826
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZTZywDZitMyTLe02iDvCM0+rkq6yLC7nFYcsvnknO/wxXOpUDXRhcQdeZLSWjO12GQZaelD0FiEjiBhb5cJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB9037
X-Mailman-Approved-At: Fri, 27 Dec 2024 14:17:39 +0100
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

Hi

I am having troubles booting an iMX8M Nano board.
I compiled U-Boot and flashed it to an SD-card using Buildroot.

The board starts my SPL, does the DRAM init, goes back to BOOTROM and event=
ually goes to the SPL stage where it should jump to U-Boot (common/spl/spl.=
c - board_init_r  os =3D=3D IH_OS_U_BOOT).
It proceeds to 'spl_board_prepare_for_boot();' and finally to 'jump_to_imag=
e_no_args(&spl_image);'
After which nothing happens.

I added some print statements to see the contents at the address it wants t=
o jump to (0x960000).
The contents of my BL31.bin are showed on that address, is that correct?

Any help would be appreciated.

Ayrton Leyssens
Embedded Software Engineer
