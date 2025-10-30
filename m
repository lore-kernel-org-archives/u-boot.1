Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BAACCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 06:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E4D83887;
	Thu, 30 Oct 2025 07:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="dbi+jTnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D7E838AB; Thu, 30 Oct 2025 07:00:31 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BC083849
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0TtHiyFZv/yqR8nou87zFrAKCa5cqPW4s7tMRdCsZ2+iJ+64i23s1kbcIZz2Ux8Y4MMDSgchScT8RMlbgFkvUT0IY162WZsx9MCCfUEZQ0Zp53+rDKzLUEe6O6reHb/YxciH4tzeCpwBOcNM0MGeC7eJc9HAXA0MqSOu/QU9oE3O91ohy/HmnubnzlZpISlQVnTty+FUbRCfV2Kp9L2bZIbf5eIRbnBZd9y/OBLdza7j/7E7uhbRFNUjtGBFYPIgZyuJwlFG3P+PV2o8K11DSibXj7wqRnKp3c9wuYw4cjzUkWzTQYNt/e7oOFqcVwqvhbYdLagk7BBCVGpZFwA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VpAm9JnD6XzUc/bh9KD698uVFsvLMwqjLmkQfQ+Xvw=;
 b=NzSXhZsX/DoMQN/8TvwceNTqda+oeBAunVqv+e6ZBWakA8Ww8Yd5DjlnpbOTQGvZSGbSaKAlu8b595tfNmw2zQI9dZX5C2rKwsca0Tg3zDlT4o7UvBFH++6ZXkWl9TZCrnoUpwjTTh7ihmxzsbsz3VssbN0k3J74t+l08BP0toV9cZMdjsrp+kVhg+BYLJBDAb3la/hFlJIcoEtMoa1KyzrnVWV/cKfJ6uiPhDyiXJmn58CaYiGtpdgIvI7/UVvF9PXI+96ymBWlUk/Zc8UUQP7ERKrNcUStxZr6ZIrgFRT43hNfLQlWfLhvNzDnB1h0YFc6ju8m/x+MtYDrrPk9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VpAm9JnD6XzUc/bh9KD698uVFsvLMwqjLmkQfQ+Xvw=;
 b=dbi+jTnE1arV1cQFLhG02yrwBrreM/QleCQH6fmUx05YlTt8nqze2GtCRyJ1v4fJuOkYOe/jEEF5Vi+X2AO0MJAZnGIuPEd8rWYe0o3fxmJE/qciVcrQc0v7ItAHZ5sfk1pVgU5NdYG+weWyq4f45sdJRtatrX+iD9goPK1DW88=
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by JH0PR06MB6603.apcprd06.prod.outlook.com (2603:1096:990:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 06:00:21 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 06:00:21 +0000
From: Vlim <vlim@gigadevice.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tom Rini <trini@konsulko.com>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vignesh R <vigneshr@ti.com>, havish.mutya
 <havish.mutya@amd.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Topic: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Index: AQHcR6R84bCIRBwF0Uan6yynaKMByLTWzOjRgAAdAwCAARTGzYAAUrUAgAAKLMWAAdmIHQ==
Date: Thu, 30 Oct 2025 06:00:21 +0000
Message-ID: <SI6PR06MB78137361B12B205406D76AB3BBFBA@SI6PR06MB7813.apcprd06.prod.outlook.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
 <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <1f163d6d-bd46-4dcf-afa3-2cc246461bfe@mailbox.org>
 <SI6PR06MB78132750D9E159847DA0F798BBFAA@SI6PR06MB7813.apcprd06.prod.outlook.com>
In-Reply-To: <SI6PR06MB78132750D9E159847DA0F798BBFAA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7813:EE_|JH0PR06MB6603:EE_
x-ms-office365-filtering-correlation-id: b271905a-c1a4-4677-8ab9-08de17799c5a
x-ld-processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: =?utf-8?B?dEtxd29vTWRiZUVBQW5pWlVESHBUMkVkNFFYMlBuQ3B6WlNPT1NEYWhaZlRQ?=
 =?utf-8?B?Y2Z5V1F6TFRVQjk1SjREWGlRT040RzNxNWZ0ODZoN0hRdGxXME83TmdmcStS?=
 =?utf-8?B?a3U0eDZ1aUpsalNnSUx6RGVrTVU0TXFXZTgrRVdwMGJuVnJ0US9WeDEvYWpj?=
 =?utf-8?B?ZUxxd1UvOEd0TzhLOW9KU0ZURFVlWTRuYXI2TzlCTDRHL0pkdmdKU1BUcFNU?=
 =?utf-8?B?OWJNdkxMUktDb1p2bFVvY3lmTGtMTkJEd2Q2bENRVlFZVU1wa3pzNyttekNx?=
 =?utf-8?B?RGtyb09CeVhFMEgxTzFXU2ZLczd1dDIzQ3ZEWVFtMFFqYXFZYTU4aEwyaXJS?=
 =?utf-8?B?clRwNlZ5RDdHSmtydW5PSVJLbFNJVkMzMmk5ZGtaMDlBanJnU0VoSUY1c0Jx?=
 =?utf-8?B?cmRoZzBuYllwQzk3ZFY4TG1nLy9SRWZ2OFB1emMrNW9PRU4zQ0ovTzg5LzBR?=
 =?utf-8?B?dCs3K1pKVEZVeWtxamV1MFdpSk1wQ2E4OEZnRUJsZGpqRHQzQloxbXFtUE1E?=
 =?utf-8?B?dCtHYzYxYWJHMHU3Y1lhUSs1RGxQZWMwdmh3ZlBPc3BGZVN3Q2lPUlBVOWlT?=
 =?utf-8?B?SHY0eVUwSnNQcndRbkx1bVdMSnVqNlpBU2VLMWdabnFiYWtZK2V6WklCY2FM?=
 =?utf-8?B?UVZoZlQrbElENVlpU2xWTlJqYU1OK2ZWeWVOOVVVODljTU94WlQxazdjODlV?=
 =?utf-8?B?Y29lQXV0UDVaeWtqTElvb0pPQ0lMem56djlGZ0R2V044bVpyNG1ENkh0UXZ0?=
 =?utf-8?B?SXcxbURyMFgzQUdjenNBbUxVV2ZmTlFQVFJmRGhPNEprcU9jcXY3K0M3SmJh?=
 =?utf-8?B?VFFuZ3dwQWtuMTZldCs5Yk5wK0RSMkF0Yzl2emthUW1Xd3hGRktnUndRaUVh?=
 =?utf-8?B?bWhmUFhtZDRLb0p1MHBodEVUY0p1dGVtTTROd3FlUmQyWFI0aFRoN3YwMlRC?=
 =?utf-8?B?YVFQS2U3T3V5ZTdkaVBnTFRaVjIvc3hPN2hMZjJXd3ZsNk9KUUx6dktkbVcy?=
 =?utf-8?B?Q3JrMkhORmhtVGxtV3FUdjRWYlIxa2h5eUdVSFNEc2FCUUdHY2dBbU1vQ1I1?=
 =?utf-8?B?cTdianhvVEEvQWFZT3NmNUc2dXpTUHVHdmlkMitRT3pudUhaelpMem4vWXJa?=
 =?utf-8?B?bnpCUWFjWElkMGJpTWFhSUErVjNFbU92NjBXL1NJRW50ekFNUFl0RXl4NkRi?=
 =?utf-8?B?UkNwVEs0ZXlCKzNEcW9wWm5GczNHRXdYMGI0TUp2VWxBSzh0V2RlMlhuTnI0?=
 =?utf-8?B?NU5qOFF3by9SU1dUQ0lsUTVhdU1vWVd6a3pXdytnZHY0dVZRTGwrSWhOOTh0?=
 =?utf-8?B?MXBXWG10Z1g2bGtMT3h3RjdkekNISHpPc3V2eG9VTTZDOExibTA5MUNSU3N0?=
 =?utf-8?B?czR6REw0N3FKV0VpN1d2NWZXbThGN2p5N2p1SnRTcWFmNDRiYTF5RDYzTW1x?=
 =?utf-8?B?K0oxS1ZwUEdJTE9BY3R1Z3pRN21HbTZIS3BVT296cklhcEhFajhHNlJSU3FP?=
 =?utf-8?B?aVlmY2krZmVhcW51d1RNQmlCVG8xWjdOU0hMNFpneHhadi9pTlNzb3dOZnR6?=
 =?utf-8?B?Qk5pVk0yblNNN1JnWW9TRFc4VzdnQWRseU1lTVdRRlNpbFpVeGprVWdlaXow?=
 =?utf-8?B?WWpBc1VhZXJ5VEVONG5MRnZHMGczRXNwRkMvQW5SOHhaM3ZCOVp6TlV3Umdz?=
 =?utf-8?B?VGdmcTB1ZTExY3hlNWxPblJ6L21HT0YwZFJ2a3Z5UlVRR3lDT3ZTQ0dkVldS?=
 =?utf-8?B?RU10RzV6Q3IwaXN5bDZEajdNTU9Lc0I5VkZZVzM0Vnp3NFFTc3ZZSW44TnpM?=
 =?utf-8?B?U1hIazNMZHhJK3Jab0kzbmwvMWVlRFoveElWVmpwN3lIRTI0WDNRa3NJTHlk?=
 =?utf-8?B?OXAwWERxWHBTUE80T21LQUhrTENjUFRtS3FneExHOUJQTnVUZlFmakYxdU9y?=
 =?utf-8?B?bEV4TUI4NXJSTjNZT3dpbWVvWUNxRTQ1YUN4UGhWdmxBd01GaUo0NEJCenps?=
 =?utf-8?B?aWFrNE0zWHRQMjZ5UHY1aEt1NVNacVcvd3dUc1VDT0Q2b3JDK1YzdEQxOEFy?=
 =?utf-8?Q?i1ld7N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTY1ZE5CTGtFYm8wd0ZBOGREZEdRRUNSazROVE5iclpseFNnajhhQTFlZjdW?=
 =?utf-8?B?NnNYdlk5ZDNQbG04TUhWbWpnVFZYWjhyRkIyMXlGOFlVdlZITzFBOWYvK1Nx?=
 =?utf-8?B?MXZMYzhWY2RZTHFLYzZrczFPa1lJbnJTblBIdHNzUHlSKytzb2JIbFZ2cTR4?=
 =?utf-8?B?RUQrY1M0NDlwZjg5WEYxd3ZMNC9YYTJSZUdlRG1CV0o1RFB0NDl5VlNjNlhF?=
 =?utf-8?B?bEpsaHhtTU9ISGFpWmxXeXdkSEU5Q0pkbitrSkt3ZmlGWmdiSWJFUHBtSnBN?=
 =?utf-8?B?dkdkSlB4VXRKV1F0Z2hnS1FZOS9aY0UvTDFkN2tTbWlFQlh6M1BWZnBFRStp?=
 =?utf-8?B?Y0RlYjkrUk9hVHpxUzk0U2VJd0pFOGhIVmNiV0h3YjVZWlc1bXFlZ1VNeit1?=
 =?utf-8?B?NENSTnF5ZUNKQjNvblQyRFJ3QnVhL3V1bW1CSnZONjNFSWo4S1hoVjA1V3My?=
 =?utf-8?B?aVlFSUMwYTV2WFhUSGtxQTVuWXVvUENvQzBtdUZYR2R4b3g3TUMvR1pBdFdM?=
 =?utf-8?B?MVZ4anIyaUNQK3ZHTFJwY2t5MVJ4YWNZR3NZZFhkRU9CekNtdHZRMS9NdnE1?=
 =?utf-8?B?SXFnSHJFOENId3VFdXIyN25iSHZWVXFKYkRFQ1I3SE9SSjZWWmtpM1hJR1ZN?=
 =?utf-8?B?Wk5jQ3pJaC81c2pUN1hDemN6eUFTUStnRTY2U0lndUxya2VoZzBiVGdzM2ZV?=
 =?utf-8?B?TGtzRm02NlpNQVFXMXpnQk5uQmxEWUtmUVN6dmRIek0xTzdpL3dpeUhRd1RO?=
 =?utf-8?B?U0Z1ZW1MTGxWNmMyVWUwa1ZoMzA3Wm91MlF6alowVWJtNmJjU0kzU2lGWE1p?=
 =?utf-8?B?TVVIL1EwMnBsRVQxc1AzVm9VTlFwRG1rbW5xUzcyTXczVGs3NmZYTHVlenpW?=
 =?utf-8?B?NFZhczNhcm40MlI0TTJRczc1QWxHY3BsS0RianhDVUJodVNUUEdmdzMxSHZh?=
 =?utf-8?B?OXBvOXJVN2ZUbjQrTXJIcjJKQm1WTzlNWVdvMndkRURqOURCUVk3YmNyOFdy?=
 =?utf-8?B?UjRZZGxybDk1UjRlazBJRTlPQXhjOXZPNHExVkNwSnRjWmNvMmttS0JCRWlR?=
 =?utf-8?B?TnNYNkhRWHFGYmdzTUJXamE3ZWJXaHFacVd0ZlBjbk5HVjhzMFlscjd1dGww?=
 =?utf-8?B?d0ZFN25VdmZlWmQzNEJmVEk0VGxyRnFPakJ1dHpFZXdHZWlxdEtKYXBITWto?=
 =?utf-8?B?SFVubVMzQ3g1N3NpYTJoSXNXV1FGOW1EYzdEQ1RVeW5LMWp3YjZzbk1VTlBF?=
 =?utf-8?B?WHk3dmp2TEhFUkpRbFE2dlBHcE5iMDJSdm0vREhXQllza29leWxjOEQ1dTgr?=
 =?utf-8?B?RjZFdW83SG9BUG41eXdxNjNYWWxZMmJYeG1adU5mbFpSTVV2K0s5bUJkdmhv?=
 =?utf-8?B?eGlGN29XYldOWnp4bHc1aytjODdSMEhheE9rVGxWRW1xa3VmbTlFSVNHcmo4?=
 =?utf-8?B?U25zTVl1UXFXN0NNc05XenJKaWZPbnhnVkEzNmlKcHJqWjhKNGFNQmdYS3Bn?=
 =?utf-8?B?UVNsZUZ0eGlYUkpZZm5YN2xYb1lneG9SZ0JxWFNoSHJaTkxpREFGTDZYeVVU?=
 =?utf-8?B?V25KcXZiZjdVb2pUbVdPQzVsTzZvKzY1OHFkS1F1Ly9kLzN2cDM3OFhjb3VX?=
 =?utf-8?B?SVo4ZHI1bEltVHRVaGlqemxzdkRMdzNuK2pZOUxJU1A4QUtqYzBKd0I1R01w?=
 =?utf-8?B?T3BLRC82WDE4dkI3dGNmSkd3dEFuQmcxTWFLTHlxWGswd0hwQVJvYjI2Y2c2?=
 =?utf-8?B?cVZuNElKMEE3alU3TnVQdy9zQVVvaXhuRHpGejR4dlE5YTdEWlQ4cFVydzBE?=
 =?utf-8?B?VVBhNld1ZDlnN3RpR0VuV2ZYZVBlOFdnZDVKczBXWmJHeE5LZ1EwNU5iRjVt?=
 =?utf-8?B?VU9QYW9Sd3NnMndpVm5DT1BmM3M1TkNPR01UN2ZkMFRhUGcxWGgxeElzME5G?=
 =?utf-8?B?b3krUzh1V3dZVnlmcVV1S2M5ZTZWcnIySWVpY1NRK3BNYW40K3NtdVp0TGNx?=
 =?utf-8?B?VE10S2tCcE5rZHpHZXU4SzlnR1BITTZneXVqK3VFa0tmRUdGV1AzOUxhOFpV?=
 =?utf-8?B?cXBKaStUaU1uV0NPWkZSVVArZk9YQmxLZUlhUEorN1pxVXMzQW9FQ25XbFl3?=
 =?utf-8?B?Q0lna21HZDRFcURYdndHYmdCSnc2VklNSVR4bVp1aW9MbG5NNExOYlJaaS8z?=
 =?utf-8?Q?VsELzO6JikzvlJmYMiEqviYCXLm+/qf5RGFTIxQy34Dn?=
MIME-Version: 1.0
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b271905a-c1a4-4677-8ab9-08de17799c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 06:00:21.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtiP9Zh40pbaRrDW0JgUOjDEUQHqSDtay+7VfEQLhz3N2eAHE/Gh6/mUiuZzzP/fKJ+ook33Z8VX2FibVbHPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6603
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

SGksIE1hcmVrLA0KDQpJIGFtIHJlYWR5IHRvIGFkZCBhIGZldyBuZXcgcGFydCBudW1iZXJzLg0K
DQpEbyB5b3UgaGF2ZSBhIHByZWZlcnJlZCBmb3JtYXQgeWV0IGZvciB0aGUgdGFibGU/DQoNCkkg
Y2FuIHVwbG9hZCB0aGUgcGF0Y2ggZm9yIHRoZSBuZXcgcGFydCBudW1iZXJzIGFuZCBhZGRyZXNz
IHRoZSBmb3JtYXQgaW4gdGhlIGZ1dHVyZS4NCg0KUmVnYXJkcywNCg0KVmljdG9yDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBWbGltIDx2bGltQGdpZ2FkZXZpY2Uu
Y29tPg0KU2VudDogVHVlc2RheSwgT2N0b2JlciAyOCwgMjAyNSAxODo1Mw0KVG86IE1hcmVrIFZh
c3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz47IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJv
b3RAbGlzdHMuZGVueC5kZT4NCkNjOiBKYWdhbiBUZWtpIDxqYWdhbkBhbWFydWxhc29sdXRpb25z
LmNvbT47IFRha2FoaXJvIEt1d2FubyA8VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT47IFRv
bSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QGxpbmFyby5vcmc+OyBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZlbmthdGVzaC5hYmJhcmFw
dUBhbWQuY29tPjsgVmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+OyBoYXZpc2gubXV0eWEgPGhh
dmlzaC5tdXR5YUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gbXRkOiBzcGktbm9yLWlk
czogUmVmb3JtYXQgdGhlIHRhYmxlDQoNClRoYW5rcywgTWFyZWssDQoNCkNhbiB5b3UgcGxlYXNl
IHNob3cgbWUgdGhlIHByZWZlcnJlZCBmb3JtYXQ/DQoNClRoaXMgd2FzIHRoZSBvcmlnaW5hbCBm
b3JtYXQsDQoNCuKAgnsNCiDigILigILigILigILigILigILigILigILigILigILigILigIJJTkZP
KCJnZDI1cTMyIiwgMHhjODQwMTYsIDAsIDY0ICogMTAyNCwgIDY0LA0KIOKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAglNFQ1RfNEsgfCBTUElfTk9S
X0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCiDigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigILigIJTUElfTk9SX0hBU19MT0NLIHwgU1BJX05P
Ul9IQVNfVEIpDQog4oCC4oCC4oCC4oCC4oCC4oCCfSwNCg0KDQpUaGlzIG9uZSBsb29rcyBjbGVh
bmVyLg0KDQrigILigILigILigILigILigIJ7SU5GTygiZ2QyNWIyNTYiLCAweGM4NDAxOSwgMCwg
NjQgKiAxMDI0LCA1MTIs4oCC4oCCU0VDVF80SyB8DQrigILigILigILigILigILigIJTUElfTk9S
X0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwgU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9O
T1JfNEJfT1BDT0RFUynigILigILigILigILigILigIJ9LA0KDQpSZWdhcmRzLA0KDQpWaWN0b3IN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dEBtYWlsYm94Lm9yZz4NClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjgsIDIwMjUg
MTg6MDcNClRvOiBWbGltIDx2bGltQGdpZ2FkZXZpY2UuY29tPjsgdS1ib290QGxpc3RzLmRlbngu
ZGUgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0KQ2M6IEphZ2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFz
b2x1dGlvbnMuY29tPjsgVGFrYWhpcm8gS3V3YW5vIDxUYWthaGlyby5LdXdhbm9AaW5maW5lb24u
Y29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbGluYXJvLm9yZz47IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+OyBWaWduZXNoIFIgPHZpZ25lc2hyQHRpLmNvbT47IGhhdmlzaC5t
dXR5YSA8aGF2aXNoLm11dHlhQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBtdGQ6IHNw
aS1ub3ItaWRzOiBSZWZvcm1hdCB0aGUgdGFibGUNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1h
aWwgZnJvbSBtYXJlay52YXN1dEBtYWlsYm94Lm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoN
CuatpOS4uuWklumDqOmCruS7tu+8jOiwqOmYsumSk+mxvOmCruS7tu+8jOivt+azqOaEj+mCruS7
tuaYr+WQpua2ieWPiuaVj+aEn+S/oeaBrw0KVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbCwgYmV3
YXJlIG9mIHBoaXNoaW5nIGVtYWlscy4gUGxlYXNlIHBheSBjbG9zZSBhdHRlbnRpb24gdG8gd2hl
dGhlciB0aGUgZW1haWwgY29udGFpbnMgc2Vuc2l0aXZlIGluZm9ybWF0aW9uDQoNCk9uIDEwLzI4
LzI1IDk6MzMgUE0sIFZsaW0gd3JvdGU6DQo+IEhpLCBNYXJlaywNCg0KSGVsbG8gVmxpbSwNCg0K
PiAgICAxLg0KPiByZWZvcm1hdCB0aGUgdGFibGUgdG8gZm9sbG93IHRoaXMgZm9ybWF0Lg0KPg0K
PiDigILigILigILigILigILigIJ7DQo+IOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAgklORk8oImdkMjVxMzIiLCAweGM4NDAxNiwgMCwgNjQgKiAxMDI0LCAgNjQsDQo+IOKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAglNFQ1RfNEsg
fCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4g4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCU1BJX05PUl9IQVNfTE9D
SyB8IFNQSV9OT1JfSEFTX1RCKQ0KPiDigILigILigILigILigILigIJ9LA0KDQpXaHkgdGhpcyB3
YXkgPyBEb2VzIGl0IGJyaW5nIGFueSBpbXByb3ZlbWVudCwgYXNpZGUgZnJvbSBiZWluZyBsZXNz
DQpjb25jaXNlID8NCg0KPiAgICAxLg0KPiBSZS1hcnJhbmdlIHRoZSBvcmRlciBvZiB0aGUgdGFi
bGUgYmFzZWQgb24gdGhlIElELCBzbyB0aGF0IEkgY2FuIGdyb3VwIHRoZSBwYXJ0ICNzIGJ5IHBy
b2R1Y3QgZmFtaWx5Lg0KDQpTdXJlLiBJJ2xsIGp1c3Qgd2FpdCBmb3IgdGhlIG1haW50YWluZXIg
YW5kIHdoaWNoZXZlciBwYXRjaCB0aGV5IHBpY2sNCmZpcnN0LCB0aGUgb3RoZXIgd2lsbCBiZSBy
ZWJhc2VkIGFuZCByZXNlbnQuDQoNCj4gICAgMi4NCj4gSSBoYXZlIGEgZmV3IG1vcmUgcGFydCBu
dW1iZXJzIHRvIGFkZCB0byB0aGUgdGFibGUsIGNhbiBJIGFkZCB0aGVtIHdpdGggdGhpcyB1cGRh
dGU/DQoNClN1cmUuDQoNCj4gICAgMy4NCj4gRG8gSSBzdWJtaXQgYXMgYSBuZXcgcGF0Y2g/DQoN
ClllcywgYnV0IHBsZWFzZSwgbGV0J3Mgd2FpdCBmb3IgbWFpbnRhaW5lciBpbnB1dCBmaXJzdC4N
Cg0KLS0NCkJlc3QgcmVnYXJkcywNCk1hcmVrIFZhc3V0DQo=
