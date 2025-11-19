Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4DCF31B5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 12:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBBF83EA9;
	Wed, 19 Nov 2025 13:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="3Lg/v1W+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F7F83968; Wed, 19 Nov 2025 13:19:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44EB83968
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efVHapqHXmICAF3r7r6VFIy8XTadvQO2LqQ0mh2/Rw9gmkAY8vYLCP+gg8qOxR9fhMzsr83yNzM4nZJqnsa7z88YAeOfcPc0lbBbqKyhPti7PDx++MQYGSmC2Q28QjDaK2moa+1+sfI4g2JfU1lT+NYiEdZH7qLCM348cKa9/bQ4LJkysVK38ihMMl+4y99LIlFWyYoCyatku3PVY3UttLngQgI7w+mlIovd4StFBTlJyMvW4x1kVj198B9osVAyFEoNHhHJtTmA4/RoX0S5hcOgz0MIb8gnJphdnt37jBl3nQHXjafvSRbjxPJjlhMNmcu/qNSb1QrCkHvzVCLdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJh+JjCpEaQSywYFYPqM0BYpuPjMOZKOZvqIp6V4vmU=;
 b=S95isHy6w1nsak6Brg1G/SbfNrS7JdobGNTLM264dMa30riG90Mte46oOHO3KyJxLsYnuQtP5iu2i4yHJ3ZOs2ejlz0ZQ7Rwr0NEgVMmQA6QabA8wFIgpGlr4nv608F4jTMZCbAyjpj1epYB02oukdZkm+ETiojtq0HF/gxnuxR+q5WhoW4hjNekBqwUY6IkRPNDMWxeZAa/Hxqen5p3j/tpX+Uusm17bsHJM0bGBm+Ku85nHYKPlHnKfYuk3VTPzIa/YXQUAmY6SjXW0cTSFxR3FnzQWLIToBfbgsdGZ+pAHk5g+VUwuzyI2eFKcZLy12xHL00dbHzWW/Jqn4iYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJh+JjCpEaQSywYFYPqM0BYpuPjMOZKOZvqIp6V4vmU=;
 b=3Lg/v1W+As6bRTmueX4vUcfBy5nsZ+tJf/a0406W18ODhyQGqyiG73mlVDW6iyq6mvYH3gF/cqPimJM5rcd5JV3VE+YzIh5ctjrDoqpRCoCqbOIxZlnF0zApq6qWVVicyO09q93MIfQBzoLjyRdfTGFebiF2oVL9BSUP1uQcWGNDzdiNp7stLohpWh9ntEry1ALO7e7vkOzfEy1m8pOZtEMPsw5bA4TNig0eythvzKUK8cpHV4B1LUwWfKch+rxqPGSjCgJzTPaaN7oh0mSJ8LqN8R1ux74D7Fy04ZeZtVzRi3XcJNLW7Ih62I2PbX6i9GVVffgrGby/Eczlz3KPJw==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by FR8PR06MB10836.eurprd06.prod.outlook.com (2603:10a6:d10:1b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:19:12 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:19:12 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Peter Robinson
 <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, Kever Yang
 <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
Thread-Topic: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL
 engines
Thread-Index: AQHcV/qBXpSf0zXQ50e7r41pI+Co6rT5wyUc
Date: Wed, 19 Nov 2025 12:19:12 +0000
Message-ID: <DB9PR06MB8512FD168E1197521BDD445DCBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-19T12:19:12.126Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|FR8PR06MB10836:EE_
x-ms-office365-filtering-correlation-id: 68ff8cd4-3fa1-4134-af37-08de2765d95e
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fRyouYvikXIHp3xt2r1DCVVsLF47eKtca2RR9hexyd5nC+ComYBfw7vNrE?=
 =?iso-8859-1?Q?2i5pnYADXIIVgysO4utekf9vUzSKjpMJ5RJE68c3S97WhCDMptCJtl3QVY?=
 =?iso-8859-1?Q?bbzUGnbcrzoXHLQux/gSi8rkbraGUPTa/kgw8zbIHbQK+VwN/LuXLlbdOI?=
 =?iso-8859-1?Q?NggVr8psWFcJgNNon9JGPG2ZQxgntWqx/9TdWiZArj2XxB0uIHPEL7S6kn?=
 =?iso-8859-1?Q?7ynKAqOg+/jPjJOsmhaXPzwPKcd+wHL0Mw58FacgMMTbSMoGi0uIEi1jF2?=
 =?iso-8859-1?Q?CtwHF5Fa0PQS9FYCfxgKo2hAQYWkadeC2F4ivIxyMxebXE+clvTiWDgDoK?=
 =?iso-8859-1?Q?mPuPCB2mBd1IAoMmqNblR2K4P7R20Xw6OUGztG37i/q1whrKCq8fxHoJWi?=
 =?iso-8859-1?Q?q5o/igFYbWCHsgDsqcA1k7UpEVvfMI1L+3rNLWqSIDC+28zjgaxGq7LcOd?=
 =?iso-8859-1?Q?L2i1MgOwzNCw/4az6GaTW8XnJUy7Zo70ZjkRfEwJNq1hlIcIM43zD0cLdx?=
 =?iso-8859-1?Q?5DG5pwclNZ52fkoIwEoyL3N76vUDEmKMBRAxkNG/02hffu6Q1n8WKTUCIy?=
 =?iso-8859-1?Q?ZXeMmkarBRH7CmIF6QaIl5kyKtaghtYFncFyirpS37rFfWbOLaGVXi+b8e?=
 =?iso-8859-1?Q?LjyBYHTdaLLsOotvYXmBzsv1zPNQAwZ8v9zNT6FzMAVhrjs3N53c2jGZu6?=
 =?iso-8859-1?Q?6KMjdjn41uVh64m+zzuGaP33hhaesXILACetSpHBDy6TzMXckpczUJiisJ?=
 =?iso-8859-1?Q?EBnJMm4Y6Ox6L8rrYVrdoAeTX/Tg5bxOXhe1OlHNqlHo4oVDG2zcjjpYRv?=
 =?iso-8859-1?Q?Zl2PZ5y4yfQwQ1lcTso/CjmSR8gSdveyGRwl6TCPjasrAnqKJopFprRtr7?=
 =?iso-8859-1?Q?P3TgN5Rts7LD1rAZegjr8AVOpjBKnIlWSTnKKmqkVvp+7JQO0bD+HYdx+A?=
 =?iso-8859-1?Q?QzAK2SmiCliiQfWBXdUAFqjSQFL/PxwWjxS68ps1B+bJAVCr103YVaBZjl?=
 =?iso-8859-1?Q?qIifFpj0xF/P+Lje2ZND7RAeroMKy6DtY2WQB/I2OCVioE3dlwmPDbCy8L?=
 =?iso-8859-1?Q?yhUoIDI3jgDTXlIHMUrHmfeyw/Ifwcup4oxI10jK7BLC/6/2Mhso7feCZ9?=
 =?iso-8859-1?Q?CVk2+YSKm2G/X7ydo5tHr1bdayzqsIfPaDZwV74pZrqGdP7B483jMXxJy3?=
 =?iso-8859-1?Q?luTIQyXmQWv2iifVG6e4Llbqc3tCCSQcCrlFozjKN6hbeb/bpBhOkRMDYS?=
 =?iso-8859-1?Q?M6PdIhQMpEHwNNiFHhblZHxPa1lLn25s0l1Zp8DddIffSvmg10TcdQWfJc?=
 =?iso-8859-1?Q?F9/VX0/+TM9oA0Cd9dA2h4tl+JJjO3QftiCcFVwj5ae+XBrKadjOAX/X7X?=
 =?iso-8859-1?Q?vsoO5MT2yVySry6PunWz48ENhzN885SdGSMlx15Zq1Up9PCl87FspHAA9q?=
 =?iso-8859-1?Q?bcyUWIIzjz8YOUk0H++KYwr8lWV5/3Is2nMcmaZneZORvilqnrSFb9Tibe?=
 =?iso-8859-1?Q?KYj9Y2NoKn4Atb1P+Myjlq9SRr0yKxWXjcTYjrDmyJ7a9Tvs3+MF9lzghX?=
 =?iso-8859-1?Q?PkbjpWRMNed6BQsmf9fUEJ05IVkW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rt73Repoa3g3WGzaQeaLCIVL63H7ItLo37QRrNzUU6o5nWiprQBk4Kl/iy?=
 =?iso-8859-1?Q?jEVFb5evxACpZwgwh/Z4KWtW1U4y8O6p+sg2ethpebfswzZ+iCVBN62Ua4?=
 =?iso-8859-1?Q?KEl1I5XQobLg9bh+zlokI/Azbw1RMNE3Eysr+yWEd8JrPGASv8e8UcZXk8?=
 =?iso-8859-1?Q?xhmKwKJZNIt5rTnf26NWvZIWFR5Djw/IfVNAYXyjUdIRvNVcjXeyNs/XGW?=
 =?iso-8859-1?Q?R5Cdo4lHoUBV3o92MnOSOFdb6XUzxpXqYfBok9XOtK6+C+Ol0c5z12OhhP?=
 =?iso-8859-1?Q?y1yt08/hZ+uDSko0cQTP8sf6dd6kQIvjVupstJb+Z2W/0p7l+ec+NIn7mz?=
 =?iso-8859-1?Q?YzT6U46mBr6ZnDZ/R1P5Ix82OiVgL/4frq9TO0MBWp5OIg0L5BfYQc/lXi?=
 =?iso-8859-1?Q?ln23PQtepHgQ1efSrdHpRXtMOMH+qw+WXia/aWaEq25spDTOiYXMiz42K1?=
 =?iso-8859-1?Q?HFblgKP+LP8C7AYt5SFmdWmKqB/77Ks1Lp3EDPs3kiWNE2mCy0ZjNtlm1H?=
 =?iso-8859-1?Q?jCVOYMcQslKWp9rcKNgYOwPY+cr34Z72Hqu5irqpXgzRwZ/zIlsV5ZtH1q?=
 =?iso-8859-1?Q?Ow07bl/c4+1RZPQK7nox0wpunb0h79PYIWIWiyV8PXmncyZ9YZS7YRPr29?=
 =?iso-8859-1?Q?s1jf2g5rpTAuILpuXAK1B/9eDGlRfLy122pnlnCygkwn0y7kjvgQILi3Az?=
 =?iso-8859-1?Q?ucq0U6XxO47lvrgp0T5dnQ9x9BWnYvOEvBwtR0oT7v31rVP3jSK0cYGcu4?=
 =?iso-8859-1?Q?DhoZCW16+BKCGuriVdDNHawpmjt7aGXN4gPkv1FCu1Crn7kug5KSC1Ml+f?=
 =?iso-8859-1?Q?SP685xZ8CmH3TlQkuqP0fyxwVG3OEZa+PFH789y0CELgv8nIi3P6XMputl?=
 =?iso-8859-1?Q?5WDyc3tF8oOjySStAC7Fo0Y3djv7IcdUnkawF+PkjigwWrPHk9Y93E19yw?=
 =?iso-8859-1?Q?ihrz3mxoTsa5AUFHOZSOTu1BsVV904+nv00KSSx6rWza7YGzC5YFkLubEL?=
 =?iso-8859-1?Q?JXMuLiu9L6oOmTYOmotrIWoEi/6hWX8vstoK/Lwsc4Km1iPVL6j6lCXNiJ?=
 =?iso-8859-1?Q?gcuxPkTuwJ9Z4NpQMWPx5zXcYHll9lFbZSERyIgw5uqKAYUlVbWzyEGNit?=
 =?iso-8859-1?Q?gpoz+sWfJpGtPOn75hhO4hjk6L44zK3ryLGfOl3MZq78QvvrpB5+V9VfvC?=
 =?iso-8859-1?Q?ONmkf9pj32Qvk9fPpRFq6ktFxOJFUfO65hGSckSJBgmt5iykOu5tfe+62K?=
 =?iso-8859-1?Q?q7/wksf5uBz2BTBDiKm3wkC7NJoaubD0v5jzGMtJ04ZOEkW24A9X2eYKZU?=
 =?iso-8859-1?Q?yKsn1xkQk9YH+xEm7rt61xW6eBzZTN3g+HNzDOCBLfFI0P3N0mRGe8a+rK?=
 =?iso-8859-1?Q?5DP+fsm62LtOQRzNgOdIEstw2ckArFbzUDbMX+ma+yPCuUxTDi58jBK7i/?=
 =?iso-8859-1?Q?MXvaBq/NLhShKPwB2YpRkq7FfZ35UiLHu7svv9II0btsfbfo44fltzJbiu?=
 =?iso-8859-1?Q?ZRdshz73SnFTEuPJ7F9LHPruMez34ng+0l1Hqjzoax5O5OHXd2NR0ZiSOc?=
 =?iso-8859-1?Q?nD+tFjADVNwizTZ72REBnhE7LnKK5aHEObtnqIQYWrtE8hIP+ki2zbh6Q3?=
 =?iso-8859-1?Q?e4FgPTx6VqETntPn1EQ6ssz/9sIDUV4pC/GpvOZCtXMzOTbIaJUpW/2w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff8cd4-3fa1-4134-af37-08de2765d95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 12:19:12.4806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRPgyQcee8FjBGdBsR3/bhDrPRL/JVkJYT2vabJA/SGnWYgeZNWn6NXuV7Cpkc5u+CJYfHgeRGI5glcRP/tJeCARxtYFHp2LrbDE1g1MIsnCBMW9g1I879VHVAemTThg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR8PR06MB10836
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
> From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> =0A=
> This adds support for using an OpenSSL engine for signing a FIT image.=0A=
> To use it, one should set the fit,engine property at the FIT node level=
=0A=
> with the engine to use. This will in turn call mkimage with the -N=0A=
> option.=0A=
> =0A=
> The -k argument to mkimage can be specified via fit,engine-keydir. This=
=0A=
> is especially useful for pkcs11 engine to specify slots, token label,=0A=
> etc...=0A=
=0A=
Thanks a lot, v2 of the patch series is really an improvement for the=0A=
PKCS#11 use case. I was not aware that there was already code that=0A=
could automatically prefix 'pkcs11:object=3D' to the key-name-hint.=0A=
(Yes, I know, it is part of the existing documentation, and I have read=0A=
that, but that just shows how much I miss even when the reading docs ...)=
=0A=
=0A=
> The -k argument to mkimage can be specified by setting fit,engine-keydir=
=0A=
> property, if missing no -k argument will be passed=0A=
=0A=
Small nitpick: the above two paragraphs seem repetitive, how about the foll=
owing?=0A=
=0A=
The -k argument to mkimage can be specified via fit,engine-keydir. If =0A=
fit,engine-keydir is not specified, no -k argument will be passed to mkimag=
e.=0A=
The attribute fit,engine-keydir is especially useful for a pkcs11 engine to=
=0A=
specify slots, token label, etc...=0A=
=0A=
> As far as I could tell, mkimage encrypts and signs a FIT in one go, thus=
=0A=
> the -k argument applies to both signing and encrypting. Considering we=0A=
> reuse the -k argument for two different meanings (info to pass to the=0A=
> engine when using an engine otherwise the directory where keys are=0A=
> stored), we cannot reasonably encrypt using local keys and signing with=
=0A=
> an engine, hence the enforced check. I believe it should be possible to=
=0A=
> support encrypting and signing with the same engine (using different=0A=
> key pairs of course, via different key-name-hint likely), but this is=0A=
> left for the next person to implement.=0A=
> This is why the property is named fit,engine and not fit,sign-engine.=0A=
> Ditto for fit,engine-keydir.=0A=
> =0A=
> The public key (with .crt extension) is still required if it needs to be=
=0A=
> embedded in the SPL DTB for example. We could probably support=0A=
> retrieving the public key from an engine, but this is a change to make=0A=
> to fdt_add_pubkey.c.=0A=
> =0A=
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> ---=0A=
> =A0tools/binman/entries.rst=A0 | 45 +++++++++++++++++++++++++++++++---=0A=
> =A0tools/binman/etype/fit.py | 61 +++++++++++++++++++++++++++++++++++++++=
++++----=0A=
> =A02 files changed, 99 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst=0A=
> index 8922d6cd070..fb17157cd79 100644=0A=
> --- a/tools/binman/entries.rst=0A=
> +++ b/tools/binman/entries.rst=0A=
> @@ -885,9 +885,10 @@ The top-level 'fit' node supports the following spec=
ial properties:=0A=
> =0A=
> =A0=A0=A0=A0 fit,sign=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 Enable signing FIT images via mkimage as describ=
ed in=0A=
> -=A0=A0=A0=A0=A0=A0=A0 verified-boot.rst. If the property is found, the p=
rivate keys path=0A=
> -=A0=A0=A0=A0=A0=A0=A0 is detected among binman include directories and p=
assed to mkimage=0A=
> -=A0=A0=A0=A0=A0=A0=A0 via=A0 -k flag. All the keys required for signing =
FIT must be=0A=
> +=A0=A0=A0=A0=A0=A0=A0 verified-boot.rst.=0A=
> +=A0=A0=A0=A0=A0=A0=A0 If the property is found and fit,engine is not set=
, the private=0A=
> +=A0=A0=A0=A0=A0=A0=A0 keys path is detected among binman include directo=
ries and passed to=0A=
> +=A0=A0=A0=A0=A0=A0=A0 mkimage via -k flag. All the keys required for sig=
ning FIT must be=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 available at time of signing and must be located=
 in single include=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 directory.=0A=
> =0A=
> @@ -898,6 +899,44 @@ The top-level 'fit' node supports the following spec=
ial properties:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 required for encrypting the FIT must be availabl=
e at the time of=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 encrypting and must be located in a single inclu=
de directory.=0A=
> =0A=
> +=A0=A0=A0=A0=A0=A0=A0 Incompatible with fit,engine.=0A=
> +=0A=
> +=A0=A0=A0 fit,engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Indicates the OpenSSL engine to use for signing th=
e FIT image. This=0A=
> +=A0=A0=A0=A0=A0=A0=A0 is passed to mkimage via the `-N` flag. Example::=
=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fit,engine =3D "my-engine";=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 A `-k` argument for mkimage may be passed via `fit=
,engine-keydir`.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 When `fit,engine` is set to `pkcs11`, the value of=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 `fit,engine-keydir` (if present) is concatenated w=
ith `;object=3D` and=0A=
> +=A0=A0=A0=A0=A0=A0=A0 the value of `key-name-hint`, and passed as-is to =
the OpenSSL engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0 API. If the value of `fit,engine-keydir` contains =
`object=3D` or=0A=
> +=A0=A0=A0=A0=A0=A0=A0 `id=3D`, only the value of `fit,engine-keydir` is =
passed as-is to the=0A=
> +=A0=A0=A0=A0=A0=A0=A0 OpenSSL engine API. If no `fit,engine-keydir` is p=
resent,=0A=
> +=A0=A0=A0=A0=A0=A0=A0 `pkcs11:object=3D` is concatenated with the value =
of `key-name-hint`,=0A=
> +=A0=A0=A0=A0=A0=A0=A0 and passed as-is to the OpenSSL engine API.=0A=
=0A=
This description is quite convoluted. I would propose to describe it as a l=
ist,=0A=
something like the following:=0A=
=0A=
When `fit,engine` is set to `pkcs11`, the following cases are distinguished=
=0A=
regarding the value of `fit,engine-keydir`:=0A=
=0A=
 - If `fit,engine-keydir` is not present, value of `key-name-hint` is prefi=
xed=0A=
   with `pkcs11:object=3D`, and then passed as-is to the OpenSSL engine API=
.=0A=
   =0A=
   PKCS#11 id: `pkcs11:object=3D<key-name-hint>`=0A=
   =0A=
 - If `fit,engine-keydir` is present, and its value contains either `object=
=3D` or=0A=
   `id=3D`, then the value of `fit,engine-keydir` is passed as-is to theOpe=
nSSL=0A=
   engine API. The value of `fit,engine-keydir` has to start with `pkcs11:`=
.=0A=
   =0A=
   PKCS#11 id: `<fit,engine-keydir>`=0A=
   =0A=
 - If `fit,engine-keydir` is present, but its value does not contain either=
=0A=
   `object=3D` or `id=3D`, then the value of `fit,engine-keydir` is concate=
nated=0A=
   with `;object=3D` and the value of `key-name-hint`, and passed as-is to =
the=0A=
   OpenSSL engine API. The value of `fit,engine-keydir` has to start with=
=0A=
   `pkcs11:`.=0A=
 =0A=
   PKCS#11 id: `<fit,engine-keydir>; object=3D<key-name-hint>`=0A=
=0A=
In all of the above cases, the value of `<key-name-hint>` is used for=0A=
verification to find the matching public key.=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 For all other values of `fit,engine`, the value of=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 `fit,engine-keydir` (if present) is concatenated w=
ith the value of=0A=
> +=A0=A0=A0=A0=A0=A0=A0 `key-name-hint` and passed as-is to the OpenSSL en=
gine API.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Depends on fit,sign.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Incompatible with fit,encrypt.=0A=
> +=0A=
> +=A0=A0=A0 fit,engine-keydir=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Indicates the `-k` argument to pass to mkimage if =
an OpenSSL engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0 is to be used for signing the FIT image. Example::=
=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fit,engine-keydir =3D "pkcs11:model=3D=
xxx;manufacturer=3Dxxx";=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Read `fit,engine` documentation for more info on s=
pecial cases when=0A=
> +=A0=A0=A0=A0=A0=A0=A0 using `pkcs11` as engine.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 Depends on fit,engine.=0A=
> +=0A=
> =A0Substitutions=0A=
> =A0~~~~~~~~~~~~~=0A=
> =0A=
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py=0A=
> index db40479d30e..6547d0314b9 100644=0A=
> --- a/tools/binman/etype/fit.py=0A=
> +++ b/tools/binman/etype/fit.py=0A=
> @@ -104,9 +104,10 @@ class Entry_fit(Entry_section):=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 fit,sign=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Enable signing FIT images via mkimag=
e as described in=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 verified-boot.rst. If the property is =
found, the private keys path=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is detected among binman include direc=
tories and passed to mkimage=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 via=A0 -k flag. All the keys required =
for signing FIT must be=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 verified-boot.rst.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the property is found and fit,engin=
e is not set, the private=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 keys path is detected among binman inc=
lude directories and passed to=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mkimage via -k flag. All the keys requ=
ired for signing FIT must be=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 available at time of signing and mus=
t be located in single include=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 directory.=0A=
> =0A=
> @@ -117,6 +118,44 @@ class Entry_fit(Entry_section):=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 required for encrypting the FIT must=
 be available at the time of=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 encrypting and must be located in a =
single include directory.=0A=
> =0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Incompatible with fit,engine.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 fit,engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Indicates the OpenSSL engine to use fo=
r signing the FIT image. This=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is passed to mkimage via the `-N` flag=
. Example::=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fit,engine =3D "my-engine"=
;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 A `-k` argument for mkimage may be pas=
sed via `fit,engine-keydir`.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 When `fit,engine` is set to `pkcs11`, =
the value of=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `fit,engine-keydir` (if present) is co=
ncatenated with `;object=3D` and=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the value of `key-name-hint`, and pass=
ed as-is to the OpenSSL engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 API. If the value of `fit,engine-keydi=
r` contains `object=3D` or=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `id=3D`, only the value of `fit,engine=
-keydir` is passed as-is to the=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OpenSSL engine API. If no `fit,engine-=
keydir` is present,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `pkcs11:object=3D` is concatenated wit=
h the value of `key-name-hint`,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and passed as-is to the OpenSSL engine=
 API.=0A=
=0A=
Same as above.=0A=
=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 For all other values of `fit,engine`, =
the value of=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `fit,engine-keydir` (if present) is co=
ncatenated with the value of=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `key-name-hint` and passed as-is to th=
e OpenSSL engine API.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Depends on fit,sign.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Incompatible with fit,encrypt.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0 fit,engine-keydir=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Indicates the `-k` argument to pass to=
 mkimage if an OpenSSL engine=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is to be used for signing the FIT imag=
e. Example::=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fit,engine-keydir =3D "pkc=
s11:model=3Dxxx;manufacturer=3Dxxx";=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Read `fit,engine` documentation for mo=
re info on special cases when=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 using `pkcs11` as engine.=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Depends on fit,engine.=0A=
> +=0A=
> =A0=A0=A0=A0 Substitutions=0A=
> =A0=A0=A0=A0 ~~~~~~~~~~~~~=0A=
> =0A=
> @@ -620,7 +659,21 @@ class Entry_fit(Entry_section):=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args.update({'align': fdt_util.fdt32=
_to_cpu(align.value)})=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (self._fit_props.get('fit,sign') is not None =
or=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self._fit_props.get('fit,encrypt') i=
s not None):=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args.update({'keys_dir': self._get_key=
s_dir(data)})=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine =3D None=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if self._fit_props.get('fit,sign') is =
not None:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine_prop =3D self._fit_=
props.get('fit,engine')=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if engine_prop is not None=
:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine =3D eng=
ine_prop.value=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args.update({'=
engine': engine})=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine_keydir_prop =3D sel=
f._fit_props.get('fit,engine-keydir')=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if engine_keydir_prop is n=
ot None:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine_keydir =
=3D engine_keydir_prop.value=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if engine_keyd=
ir:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ar=
gs.update({'keys_dir': engine_keydir})=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if engine is None:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args.update({'keys_dir': s=
elf._get_keys_dir(data)})=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 elif self._fit_props.get('fit,encrypt'=
) is not None:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.Raise('fit,engine cur=
rently does not support encryption')=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if self.mkimage.run(reset_timestamp=3DTrue, outp=
ut_fname=3Doutput_fname,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 **args) is None:=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if not self.GetAllowMissing():=0A=
=0A=
Tested-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
=0A=
I did test the 3 cases listed in the description of fit,engine:=0A=
=0A=
Test 1: No fit,engine-keydir:=0A=
=0A=
    fit,sign;=0A=
    fit,engine =3D "pkcs11";=0A=
    key-name-hint =3D "<object-id-of-my-key>";=0A=
=0A=
Test 2: fit,engine-keydir present, and contains the string 'object=3D':=0A=
=0A=
    fit,sign;=0A=
    fit,engine =3D "pkcs11";=0A=
    fit,engine-keydir =3D "pkcs11:object=3D<object-id-of-my-key>";=0A=
    key-name-hint =3D "MyTestKey";=0A=
=0A=
Test 3: fit,engine-keydir present, but does not contain'object=3D' of 'id=
=3D':=0A=
=0A=
    fit,sign;=0A=
    fit,engine =3D "pkcs11";=0A=
    fit,engine-keydir =3D "pkcs11:serial=3D<serial-of-my-key>";=0A=
    key-name-hint =3D "<object-id-of-my-key>";=0A=
=0A=
I think the suggestions above would improve the clarity, but even if you=0A=
choose to keep the text as is would be fine for me.=0A=
Both code + documentation:=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>  =0A=
=0A=
regards, Wolfgang=0A=
    =
