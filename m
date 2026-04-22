Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B17F94CB2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 03:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2717A83936;
	Wed, 22 Apr 2026 05:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kQvMQIi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F4883AC5; Wed, 22 Apr 2026 05:54:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB168352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9lJ9GnOWqrHrILGZJB2nDx+m86HFqz5Wd3PNeV2TmfBUSCQJbApM4aPq4HQa0ZJj2gnYnzsBct3sGOn8Vhl0/mb6M/GF6Dm9EJZHbSD7MR96yQT/ZM+ocECnOyypP32p8bEUt6e4LJG9jR7pT430GSIIRbQmquFEl4iQ87JfNfIoQGXtq5BRSsLLwf2MgbDwo3yrNFcwV2rvUXdZjplaLS70sp7iNeSJhCWKwRADdzasiXrG6KkoagyBOeHtPKRtGjhqyffX1AIScrOQHLkrThZaOrZF8GUtPQ3DihIwarz0f1xkTaSnP5LvKgU8HiG8RQotPZFk+h4wRknw5NPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwG/6hfTpBH0KrKXb3RCo+GJ4rtIm5YIw63RGR2cYPw=;
 b=cLfZmGc0SrInL4B3Ztj+dV7yTPq5oUmSXxanzcEI35DSwwS8JpjTIfqD3jSZGXX1HW3l5o41/+Vw19knxpuXhM5wH+RCEekGkdRY7/I/YBcfeVFsPlkF6qnZbyhj/T8nAFhuC1jinOzDtmbI16FP7n1mtO2bf3oE/GMIvzdcAHEZqZBTWrDRDJN22FC2wSpjq4wdEgAFS404uZNuqDXqEFlLA5REzI/WQILQ4bd9lHomF1lwa6ZIse4yMX2KcYUVLTuG7OixcYCSI/CX+nzEw5JLWVmg8g9nha8l5HEATbJ51FT2kWJuNiTmVMycLlF9OJ293CB50WlCAH+kqYNNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwG/6hfTpBH0KrKXb3RCo+GJ4rtIm5YIw63RGR2cYPw=;
 b=kQvMQIi6O8PzrLe0TqVAmN/COgsSJtwSMQxJk1sXLA898EGQs7rL14rR4jLqBrGUb6oAECwmDs1T8Rj6I4Gf59qiO8QYW+ZfPl51M9TPd+/dnHl40Dgt0Zc20D+iXVLR7ZmV3ZnHjnZwSIHteqDt7TpzPV+SJQvRI4tnwNJ8JsQ8EC/7BnrP3vejgPJCWdnP67FWCVGAZLLDHxiF+2xk+rAHbpVmnPc4Pmj6AjWH4lUSM5NNgwhur1s4gCT5iY+TiyZFZnIU5cNKK64Mkg/VCPfczvbpNJF9RQtXHW9rv+1L/6+binES72FPF9lbwscfUaH6XsIQ4miYCzIKJOMisg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB11940.eurprd04.prod.outlook.com (2603:10a6:800:307::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:54:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Wed, 22 Apr 2026
 03:54:44 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@nabladev.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Beiyan Yun <root@infi.wang>, Bo-Cun Chen
 <bc-bocun.chen@mediatek.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <mwalle@kernel.org>,
 =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?= <thomas.schaefer@kontron.com>, Marek Vasut
 <marex@denx.de>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8yXSBuZXQ6IHBoeTogYXF1YW50aWE6IElu?=
 =?utf-8?Q?crease_timeout_for_out_of_reset?=
Thread-Topic: [PATCH v1 1/2] net: phy: aquantia: Increase timeout for out of
 reset
Thread-Index: AQHc0gvB21sT5AV5Q02fVL1wLGoPXw==
Date: Wed, 22 Apr 2026 03:54:43 +0000
Message-ID: <PAXPR04MB96442DF7A37A8055214DA528E22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
 <20260415-10g-v1-1-f6809a31c2b2@nxp.com>
 <CAJ+vNU3+rN1hVZQRTHEQmi+uo5o1ak9epLL=VFqNRMGNT-iNSg@mail.gmail.com>
In-Reply-To: <CAJ+vNU3+rN1hVZQRTHEQmi+uo5o1ak9epLL=VFqNRMGNT-iNSg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI0PR04MB11940:EE_
x-ms-office365-filtering-correlation-id: 752b6572-3914-4303-1798-08dea022e38f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: tA1FaGlQxDsYCaMFU8qKnMZlYmvWIh7NivoavhVimos7400+yiP51iR1sugMaMbVcLc2uP8u1UHxoltWrYtGJRnzPK3F5WHc/JMTNHhwqP9lzkdb5RfqN36wCz6pzP7MtmiFnvjF2AeW6ZbhoFlU92CP+kR7DuB6hBGR0jzt/F3VIf5TvSrDZI41oBHJM55+ACN9rgH7gtoi/ZH1O2uR6RM9EZH6VywacmNvrEJlPQhmZpuCUX41V1sT5JXEjwIqGeDgvpqxME9DitUByDZ5YhMXcIqe6QPODe+Kq9QaA/CSrtDC+yEcbsCRO/En/lorHBL63XZEQBunqnhPhhEX3GKkvsbXQa/rSaOIouatXMzlWai+Bxf/7erIXnBPJtf3qgwIFEjdnMayhZ+gKeAmhak98AgWGCyUdKakuZxz7IXGbTV5bVjyUZ7Wz9z32xgEyKyxlkUUZFS8fN6nMwDKrZG9juPa+d19vTk488/W0oeEQW/iOquqa353TejOLnvMyhzDd20RkGEKN1aBe2TgHyrIpzvKtj6j42Y3fiBWshJ0Q6j9Sk4vC0cp3mrSlsuQ9xHenMU1IrY7BrlG2Tdt/MF49LU0ppQG6ncT1gGlR8yLYWZXka7IbBVLJKjTWHln576Doaxg7i3CAEz8uSNHgF/Cx3tffhJXX5fAMJXswUPrMTTXlyKC/psC1HVEq4ZC0lUnUKJow0eb5tZOSm2JQ+HYL9m+M2qXanNpN1YXHOJ3cMvTD8BqT5Ir0xTtCthc8PsCp1ESj2aDMvfjDdigmndbl51zjOVTlSuFpjIzk0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3FLNUtOVklJY0ZTZWdZKzJrUkh2eUNaaFdoVEdpelhnV0RYTk4wSnU1UE5X?=
 =?utf-8?B?MHErRGFkMDVyU3pjeExnT2xyMFJHU0lRcm1kRWFLdi80c2lOQWZkRDB5WFRC?=
 =?utf-8?B?cjZJclArMS9sWndXR0F1UVJUdU91TmRrajB0ei9kbnA0RzRFdXowaGFZVDFU?=
 =?utf-8?B?RGtEVG1lVCtaVTJkZ3pnVGd1bG1UaHplRDhUSm5TVlVoQXErejRBU040Q0o3?=
 =?utf-8?B?QTNkUVg3S1dJK1Q5bEtqZk45cy9kYlBpRjlWRVd2Z3NkaTYrU1diTUs4OHRN?=
 =?utf-8?B?c00rcnVxc3ZqQUZHV1BHWFloMldRTmVqTGJWUEtRcW9VanluWnhheU5DaWli?=
 =?utf-8?B?WWt6Vy9XYjlubTdZNmhybkFpdzhyNlRqYlhNNVhNZlgvd2pwVHlMSFpxdXpQ?=
 =?utf-8?B?dVVkMSthTFVVRi9BT2FITzVEVHd3d2tuTUYwQWxXTmsxS2tPSTd0S1JBKzA3?=
 =?utf-8?B?b1JLWDJxN0lSalVIUTU3YjcybFBrVHZIZWozOUVpemtCZmFQYzVLZHZlUC91?=
 =?utf-8?B?cGEwMGtRS29jVmEwK3JEbHZwUlhYUGJYWXZhNWZBOTFYQXJaN0FjWUlxaUpK?=
 =?utf-8?B?U3RuZzZSVHl6YVAxUlpFR0hDOTgwMzdqLzRsSTA0d3Z5bjY0ci9ROStQdDhQ?=
 =?utf-8?B?anlzTllrTkVYaU1VVWwrMGdodUwrKzF1MVN5ZEJ0UkNiRWNYbVBsSUVNZ2tM?=
 =?utf-8?B?WTdWMEFmTEN3RmphNWw3U2ZpeWx1dDFxWWZJMmxScDh1cVBSSlBjRjY4VTlo?=
 =?utf-8?B?b1hxZTM3MjJIeEFoQzZRMWU5Wnk3YTlUaUZJWDg0RUxhYmZlcktEY3BtN1Bh?=
 =?utf-8?B?Nkp2ZC9rRkg2RFdxc291TGd6cmlvblR0dkw1V2M5UEZMNTgvWFREWEZsVnRO?=
 =?utf-8?B?ZnNSamZOZzFGR1ZFanhkUTliaEJtT0ZzWGdyK2QxdngzR2s4RWVEd3I2ZVZn?=
 =?utf-8?B?cFJLVmF2SzdqalYyTU1DWnlISE03VVI5UFozUVA2bm1lcXhxR05XVXVFMU52?=
 =?utf-8?B?b1FVcjA1TjVnZVpXcTRXdytPa3hWd0YxNHNsc0hHMlcyL29FUDFTREpQamNI?=
 =?utf-8?B?QTYzSUp1Qm5XMG8vU2JreEowUC9QT2xWQWNRamxvdjN1dkYrTUR5STcyKytp?=
 =?utf-8?B?UWFScUxHYUR4RWs0RHpnU0UvQ3hKUHZmVnpOQWJ2TkVrT0g0RFlKdzU2WTJM?=
 =?utf-8?B?Ry9OMnNmZlZPNG4weVIreWF0cVdIZWxCWTFLcno2M1VxTmtxUHNLaTYweVh5?=
 =?utf-8?B?L2lmeUk0ZDNEbzQzNndQbHdsbnV0TVZGU2RQbXAzWTJ1WEVKekVCWnhCN1Bq?=
 =?utf-8?B?c09UK0hWeWxoWU5oMVBGdzNpOGgxc0d5TzlRTDBTS25PejlVY3lqK3lmbHpk?=
 =?utf-8?B?dThSN1pKdjJsdCt3QnFRQ05nNUNMczVXK3NFb2NuenZpVlBXM3VqQU1uMVov?=
 =?utf-8?B?cThOK3pMS29PbXRhSEN0VU8yMWMraVhMWHlQcmduc1E1VXBoTVJlZ2Q2NGg4?=
 =?utf-8?B?dDhabDZ1R0p0N21kSmZmMnN6c204aFhPQkQyaElTOXNGMm1mVDE2NThheWRy?=
 =?utf-8?B?UjBUNDZhekJDejhQZmdrNi9YM1dwMHY3eitoNGdDZGVtZ3NWaXplMk51TXRz?=
 =?utf-8?B?TmwrU2hpa2g2NTRzTEVwV2sxRHVBb25uWHNRRHRrdFM2TG1hbERiRFdFZnQx?=
 =?utf-8?B?WEFrOVhHSmI2N1RMUHNNbGI1cUxTZkdiNndvNmRSaFZ5N2tQVjM4OEF5TWtN?=
 =?utf-8?B?Mi8vYWcrcGZkSjdsT2FvN29wRFpiYzJDWE4yclRML2xvZEhPeEgyZGZaWDBZ?=
 =?utf-8?B?SFFKT2xEMGNNK1MxNjZna3JZNGJwRGJTVXpETkxoZm54UUIwZzNTeGFLcnRk?=
 =?utf-8?B?ekFaTzgyTUYrRXRFUHJxNko2TWxTbXQ1S2hOZll0WWg3SWxzODV3anE3Y21x?=
 =?utf-8?B?dzZIYWNFcmZwT3NrV2NkNlhhTDdrTC92ZDRMaml3VnpSNGExVjdyN2FhZUVK?=
 =?utf-8?B?OFdTeThNcXVTSHRqRW5EdTM5MEkrN2pQRjJNMjVHdll3U1AzNGcwaC9sZ1JF?=
 =?utf-8?B?ZW96N2VYLzVvRVdnNG9jaEhZL016QzN2VG1RbVd5OG5sR0ZVNkxyc0NWQWg5?=
 =?utf-8?B?RUxNQ2MwZ2tSSmlMTlpxSWN4cUZLQWRnZUdsSGpGeHptZ1RHazdZU3JtZnZM?=
 =?utf-8?B?YnFpZUN0b1A4c3RBL3hoR2tKcWJLb1doL3VmQThLOWhZV0FTa1o4QmVUOVlC?=
 =?utf-8?B?RnVHTlVuWWRmWEtvQ0c5VktXMjBpY1JLajJNQlFObnN3NXJsdXowcWtvY0VH?=
 =?utf-8?Q?SjEwlvrF0oiif93afT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b6572-3914-4303-1798-08dea022e38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 03:54:44.0160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5g5ZwI0qvZwNJNfWXcQm7k4drby6CPqXDauc07KD2c38/t8qHUtmD3+iCWSEQpVs6ZFjN/p7jJU/gOXbjY8xbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQ05pyIMjHml6UgMjM6NDUN
Cj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2
LmNvbT47IEplcm9tZQ0KPiBGb3Jpc3NpZXIgPGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT47IFRv
bSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBCZWl5YW4NCj4gWXVuIDxyb290QGluZmkud2Fu
Zz47IEJvLUN1biBDaGVuIDxiYy1ib2N1bi5jaGVuQG1lZGlhdGVrLmNvbT47DQo+IFNpZGRoYXJ0
aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT47IFdlaWppZSBHYW8NCj4gPHdlaWppZS5n
YW9AbWVkaWF0ZWsuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4N
Cj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5l
bC5vcmc+OyBUaG9tYXMNCj4gU2Now6RmZXIgPHRob21hcy5zY2hhZWZlckBrb250cm9uLmNvbT47
IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsNCj4gQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYxIDEvMl0gbmV0OiBwaHk6IGFxdWFudGlhOiBJ
bmNyZWFzZSB0aW1lb3V0IGZvciBvdXQgb2YgcmVzZXQNCj4gDQo+IE9uIFdlZCwgQXByIDE1LCAy
MDI2IGF0IDE6NTTigK9BTSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+ID4gQ3VycmVudCB0aW1lb3V0IGZv
ciBQSFkgb3V0IG9mIHJlc2V0IGlzIDUwbXMgd2hpY2ggaXMgdG9vIHNob3J0Lg0KPiA+IEluY3Jl
YXNlIGl0IHRvIDJzIHRvIGFsaWduIHdpdGgga2VybmVsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogWWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxh
bGljZS5ndW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvcGh5L2FxdWFudGlh
LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9hcXVhbnRpYS5jIGIv
ZHJpdmVycy9uZXQvcGh5L2FxdWFudGlhLmMNCj4gPiBpbmRleCAxMGI4N2RmYjhhYi4uODNkYTNl
MWNjNzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L2FxdWFudGlhLmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvYXF1YW50aWEuYw0KPiA+IEBAIC00MDAsNyArNDAwLDcgQEAg
aW50IGFxdWFudGlhX2NvbmZpZyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICAgICAg
ICAgaW50IGludGVyZmFjZSA9IHBoeWRldi0+aW50ZXJmYWNlOw0KPiA+ICAgICAgICAgdTMyIHZh
bCwgaWQsIHJzdGF0dXMsIGZhdWx0Ow0KPiA+ICAgICAgICAgdTMyIHJlZ192YWwxID0gMDsNCj4g
PiAtICAgICAgIGludCBudW1fcmV0cmllcyA9IDU7DQo+ID4gKyAgICAgICBpbnQgbnVtX3JldHJp
ZXMgPSAyMDA7DQo+ID4gICAgICAgICBpbnQgdXN4X2FuID0gMDsNCj4gPg0KPiA+ICAgICAgICAg
LyoNCj4gPg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gDQo+IEhpIEFsaWNlLA0KPiANCj4g
SSByYW4gaW50byB0aGlzIGFzIHdlbGwgb24gYSBuZXcgYm9hcmQgSSdtIGJyaW5naW5nIHVwLiBJ
IGZvdW5kIEkgbmVlZGVkIDEwMA0KPiByZXRyaWVzIGluIG15IHNpdHVhdGlvbi4NCj4gDQo+IEFj
a2VkLWJ5OiBUaW0gSGFydmV5IDx0aGFydmV5QGdhdGV3b3Jrcy5jb20+DQo+IA0KPiBCZXN0IFJl
Z2FyZHMsDQo+IA0KPiBUaW0NCg0KSGkgVGltLA0KDQpUaGFua3MgZm9yIGNvbmZpcm1pbmcgYW5k
IGZvciB0aGUgQWNrLiBJIHByZWZlciB0byBrZWVwIHRoZSBjdXJyZW50IHJldHJ5IGNvdW50IGZv
ciBub3cuDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlDQo=
