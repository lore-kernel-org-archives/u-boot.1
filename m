Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E37CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABC282BCD;
	Mon, 18 Aug 2025 12:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KykKjfqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06003803DF; Mon, 18 Aug 2025 12:08:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805F783093
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/xNeXH0GGVnAZNej9VJYywkaYkoDI3HoSj4wT2EWgTfHXLUY2vF1td3xWVy2iW/mpyoyoTy3l1ACdbCeWtBlvN0GNBu26uRfXs4siV7WORrIsFibN//d2U7gmXYUX48/tI5/AFQyxpVPs7iIVyYYbuMPcpEV02iae8DqBjSPYVG75UDlKrYCuRT9CYQif0SHniGCFqwy9iM7JraXu+mlqt7sfrV7FwvyH5a7/jDYFNCfpcQj+X2Xh9kWfA+xpXfKn/G02n8VBppjdehD5viNvWl3d97NWj4fAolXvWfCB13IRsvunqun4mfuDri0g0+ORZ+b2BC1r6uevEty5PANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/RYnhLcg4sJEGABDIRdfuCpv7sQU4+IlKoSpYYvQEI=;
 b=AmNhXBFOpO1QdtWISVZqrFshHLrdoJax7Znj/l+Fwke0x4Xph7FDm3hI98lzWVIWYrYWgc3zdyYP3asPvFkIPj/n4/pZHy+xT5gMtZrOHHuuJmemVAAmOHH9nOdFhoiZnxH8wnn/fZeU3j/c4IY1UnxNrcsJj1VnrWu7Qn0eGnTwH5RoMMg9zghbCYDo7AyawrVm/PNGjE4SqrXBIq6D44HeEt1LpmK2F9+G1Gzb5EYGspUn0EWvJBA5qSNyol0QQEJChpCwOPsK80GXjFDEAfkaKpOwlC876k0xiYiFMoJ6lU0T/IjRRKyj7AVaxAp4UbiawQ2Bj+yvRY16eEFfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/RYnhLcg4sJEGABDIRdfuCpv7sQU4+IlKoSpYYvQEI=;
 b=KykKjfqpN4gkEzxXWSg3mEQ/LdkBdKkBmaM4XCNrJge7b6p8YdIZKWe8W63ZacJk41fXJn81xRASXZoSyYbU8TcRaSeQ2kwQ4Zk+3uRptXodfGz5K4c8tFImY4TRx17Hweyv7RYJc7JmiEf+5DAhEQd/PCZ8xEKtFwdqecsiy2DlCrk2Hi+HwC99HdWLb8M53dUtmxFTCQlNfK6/JRL6jBTCNRILqbNWdHs2TcwZGeodYPrGEkcuKvYpXVmPQ6n9wti0A2I2vSt8dmJF4YZXi16WwvZSVqAiak0+E9z45RLM9nXnvhlfqLqO0dyW+uSFd/xQjUvbk+DBxnALhRN0cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9052.eurprd08.prod.outlook.com (2603:10a6:10:474::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 18 Aug
 2025 10:08:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:08:50 +0000
Message-ID: <d776f4dd-7cbc-433f-9b68-064c0b096488@iopsys.eu>
Date: Mon, 18 Aug 2025 13:08:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/21] mtd: nand: Add a NAND page I/O request type
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-4-mikhail.kshevetskiy@iopsys.eu>
 <db522d58-66e9-464e-8224-0ebf70c415a5@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <db522d58-66e9-464e-8224-0ebf70c415a5@kontron.de>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV2PEPF0000384D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:f) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: c12d93a3-f09d-44e1-ff39-08ddde3f3a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2NqdjdLSjV2K01taDVIODNCaGZOL281a2xlcFFpenh0cEtYU2dGeExhYlht?=
 =?utf-8?B?dWNOUnZpZWU3RE9NdGlMSk13cUhTOGtSdHJDMzN4VGhzbWZCaHhRdllMQVpa?=
 =?utf-8?B?dXBRU3RxRGZJNEJIV2dYUzljL2YvSXdUeGVicE11N1M0aHkyQ01YM2hsY1pI?=
 =?utf-8?B?cTNmcU85MUhxd0pQOEQ5d0YzeU9KQ1dXQ01ST3Uzalo0OXBqZjhBUWxxSUlY?=
 =?utf-8?B?NkZRcTRGZE1qenE5SERXMXI1T0tweUs5cG9GZXdVNSsvdTFSV3pOK2cwMkZJ?=
 =?utf-8?B?N21zRVpTOXZRRGcxZlFKWitraEtqSmIrcHY3Q0p5cks3NWdYU1JoUnAzd2h4?=
 =?utf-8?B?RFVhL3hEcllwTDRKYmJTV2VocjBwaThGOUtaeTI1SEQzZkNjVitwOFB5VXVl?=
 =?utf-8?B?eGlicFlySFBXWnBuS0dzSkFyR3hQUTBHREhCeCtFYzF0ZFU2RUU3SCtQQnVv?=
 =?utf-8?B?YnRQcXZqaFliYUliaWZERllRd09CWWpFdVlvRnhKd1h5ZThLUFpqbmV5aUdG?=
 =?utf-8?B?S3BQZ3lsOWwyVDJCNDJTNW1zNENOMXVaVkxtSFc0RHF0bXZtRVFLNVAwd09S?=
 =?utf-8?B?SVVOWnhqdVp4bXl0ajBCRDB4SGwrd0h0OEs4VnJMTHk2U0tVNVl3ZzlwaitQ?=
 =?utf-8?B?OVNTUVQ4aUxQOU1vbUtpRVM2TnlBVktUVUVvRnVZL09oU3g1T1MwcVpDQWFy?=
 =?utf-8?B?T1JBYnpRVEZJRVVWR1N6M1dFMjRrbHg3aHFlUEl5dGNGUTNUNitpQzFDb01N?=
 =?utf-8?B?cmJpc04zNWZWUDNEOERINmozbkw1RGdtSzJ4S3F0cW1QbWwwODg4dHlHTUpi?=
 =?utf-8?B?Ulg3UU84SEcvT0VwcmVSb0tGbWdtUzFIUVhsWDFweHV2WnVwS0RHVmxFS1FH?=
 =?utf-8?B?c0dWT2hqc2pjbFUyRlcvS0h5U0NmVk1abDF2eElvNi8yWUZPUmt6cURCemU1?=
 =?utf-8?B?WlIzOXM4Yi9JSjBxL3FSSkRuOWJIM1FmejcxdXh0YnVNcEl6QS9oTmxoeld3?=
 =?utf-8?B?MkVZc243V0EyalJrbjdna2R5a0dCWGZEMnBlT1gweTJYQXg5b1dCQ0o2Q0p3?=
 =?utf-8?B?SUJuRWFnWHRuZTFGaGpzWlVGVVRudFl5Tm5iUjdhT1pXc2MrdWk5UUtxeUg1?=
 =?utf-8?B?andXdWlJMlRFaGNCbzNLK0UzYVdMbVNleXVqN2NKdVN2ZzRSSUExOUQvaXFJ?=
 =?utf-8?B?UkltUlZHRWJrMDVIM0dveUluZ0pVOXpkOS82ekJHVlduQkRRSWZwWWs1YzJZ?=
 =?utf-8?B?NkxnOE5BaWtVYkg4L01teE9aeVl0UC9GejRPRXd2QktUc2xWMTJOeXVGSnlu?=
 =?utf-8?B?d2svblFaV2tDbUQ5ZXYyd296MDI4OVlCYUphdzdLbTVYVFIxU0YxSWt1MDM3?=
 =?utf-8?B?VWpWYTF1cnN6R2hSakY4TW5rYkJYL3ZTVU96SVZwRmV0N2ZPaWtLUFRselh6?=
 =?utf-8?B?amJTNXhHMlNxVEdvaWtzcVE0dkxiM2tVeDVxRWN0RkprQTlTTVpveVk3dU5Z?=
 =?utf-8?B?d3VQMmhtVnVYbEFZSmJjY0krZ2svZjcwZms3UHB1TkVGK3NpVzBVVWVTUnZ1?=
 =?utf-8?B?STFiU0N6UUZVSEIxNXl2a3dCS2xwcmwwMWk2Uk4xbTZlNUp3NWVVYTIrUkV6?=
 =?utf-8?B?YTZwbHZCL3ArZ3o0WGlrdm9obWZoZFNLdDU0bWU3cVdiTzhaVGpKWHI4eXRr?=
 =?utf-8?B?Q0tsbDRjMDllSjdLTmkxK1pBWUxGdG1EazY4c0IyVGREbkhUTVFKS2h3V0F0?=
 =?utf-8?B?Z004NEFtVmRNb0ZWblgzeUNURjNKaGtuUC9oMTRiYlUrY2Ixd25qY1NLQWdY?=
 =?utf-8?B?UklBdm9nNU5JQkpaK1BLdXk3clhJV2lkajVqRHptVWs0SUs3YndFeThGL1ps?=
 =?utf-8?B?OGM3N1BBOGxMdjhJNERtWlFrRzk4dTBxZjQ2c1ZndlFPb3Vta3E0ZVkrb2ZZ?=
 =?utf-8?B?QXRSMkUzNzNtU25DK0plbGJXWENFVG9RTEVoaDNjUjNUTnRMazZyNEhuQkZQ?=
 =?utf-8?B?Tng1TDA2T2VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmcvSEdFODJNeGJYZXAra1NubGlRQWIvOXZpc0N1ak5xRXl2WkJiNDQ0Z1BQ?=
 =?utf-8?B?cW9OWEFRZFQ2cFdXUjVlR0tXczFHYWwyMC9CUjA0eGVPNnB0R080ZlBJemll?=
 =?utf-8?B?SUUyZHhqZ3FQdXc5R2o2OGdnQk9GOXhWRkpaR3Q4V2tKR2dPektLa00xYWNr?=
 =?utf-8?B?RVQwMHpQZDNOWGFSVUozbFBtUkJlUVp3d3hhMmErM0J1cmRQaDg1ejdCODN0?=
 =?utf-8?B?NnV4T3RNWjNsYUZNcjFTZExzQS8rY2RiVzZJS0NPTTNDNHBIZkNNMnpRR21k?=
 =?utf-8?B?L0prMGUyS1F2aXRNRnBJMlVhem1ZQTFEMWYrT0ZaYkNlL1M1ZWlFNGdxZ3c0?=
 =?utf-8?B?cGtaQnljeC9tamxQbEE0VUlEZnRlcEU3dEhMeXlYK1owdU52ZTVxQzBsME03?=
 =?utf-8?B?RzloeE14cmd5MEw2Sm5zbkY0RCtFMUw2dUw0NzUweW8wZWhDT1NkYzRaY2lq?=
 =?utf-8?B?WTNLOXprNEo1WWd6YzcrWm0wYnhNdXpabFNUbkpuTE9qMXhLSEtaSFRGaU1F?=
 =?utf-8?B?Sk5FbWd2U0wzbE15S05BYURHWmNqampVYXF3a2F5NEEzYXA4bDBXN0ROUW1w?=
 =?utf-8?B?QUtVOG90Y0Y3V3c4WnBnUWtjdDNNVW5FdUFibjZmVkt6R3Rrd2tDTlRWRkVr?=
 =?utf-8?B?Vi9WT05WNUdCaDc5bU90SmRtY3VxVk1TaElwL21HamNoYklaN2xmQWhKQ2Jv?=
 =?utf-8?B?cnQvK3VMT1pPUHM4aUhJTnRTTFV4VkZUTmRnZ1N3TEpRZU5aVERxYjRNMGlO?=
 =?utf-8?B?cWNZcjE2MmdyaXBXMHc3T2hzQ0trUGhHYTYveXhKVGN1NmJQNlVHQzBCZEdR?=
 =?utf-8?B?ZVh3aXFXQ2txZllDbjVnbWVrV3ZpQ3c4S0M2Q2tmUEdEak0rV3BGZ2pnWVVa?=
 =?utf-8?B?dG0zZUJjMDJwMi9VVUhlaXRLN2RqRURrS2tvU2t0VUdvTkZCVm9vaU4xS3Ri?=
 =?utf-8?B?cU5odVQ0V0NLMWl6RUxTNjNYUENHUzlkRDdYbUQ4N01LREJYWk04U29DdWIy?=
 =?utf-8?B?cWtmejlDR25OSHpwT3NHd29LZC9ISkFnUW15ZTh4U0E2RmtKWFJ1SkwrREha?=
 =?utf-8?B?WTdvT1U2eWtTNlZHbTFkSXlUYXJrWGZKNDNKMWs4Yytzclg0L0xXYTZ3NDlE?=
 =?utf-8?B?cS9xQ3VVMFNRUEVTS1ZZT2IzWGxobGVDdVZWbUxUTUtzRSt5eTVQMHRDbUd2?=
 =?utf-8?B?aWx0eHZTdWFEUzRNL3E0ZVdlQ1l2NlB4VkFiNWJyRE1tTTJHNys1QTBjZE95?=
 =?utf-8?B?QkNibHZIMHFNSWRjMmpudmxhamdzaHhXWHp6OEtvYkNTSmgzVlhDajhOTStH?=
 =?utf-8?B?UEkwVDFETjBCUW5ZTjJ2WFdySHJPaE1NUEhML2YxOG9nSndNeTFVVUthc041?=
 =?utf-8?B?Q2thcTY3QTBuUnVIMzhnYWRBdHdTVnAvRTV1YVpPVmlQdXlGZGVqN0tXNnJD?=
 =?utf-8?B?TXhPd3FSMWxhTHFBUWtIRE4rdHhPSGgrREdIV3NiTXo5Umw5TklOMG43VitO?=
 =?utf-8?B?L3dycEhKTEdLYW9EUHFXMjVibnRuR3RXYytubjVZUDhXL3I2V0ZYclZITWVR?=
 =?utf-8?B?WnZCYWxxelBOUmZ1d2N3TlRWZFYzeHY3WEVOb0xjM2RkUy9nSDIxUkM3cUNP?=
 =?utf-8?B?QTdJNHlQY2VqZ2JsUTZIdkxrNHFSMTJseDE3a0YwWXpqdFdCKzdOZG15Z3Z1?=
 =?utf-8?B?ckV6V3BuZk5WUHM0YUxvb1NzNEt3YTh6ZG9hM3dJQUdJVm5uVVAzYlRrK1Ry?=
 =?utf-8?B?MU9FR1NpdysxeS9oaWpNNXh5S2t2MWY0VkV5MWpFZWR0VkpiNGNnM2ttYnpU?=
 =?utf-8?B?Rm5OYUdYS1VzVlJIck82WHFqdmVJRFBVZ2dRODFVSkdJNFF2d0xNK05SNE5J?=
 =?utf-8?B?V1I5bXdxbHoreENyUHNKa0NKMHNGcTcyVitEMHcwU2g0c3RvUlBYM0E3Qjdq?=
 =?utf-8?B?ZXdYYzNzcWw2eGtJS1BhSkZ5bmxNU1dZQzRYdERXbm1Yd0ZQNFQvSm1FTlNn?=
 =?utf-8?B?NXdiMk5qbURCYnVKZlVEK1hVbXV6WGc0TU9ycTZtRlo5NkRIMkFMNTZ3dGFm?=
 =?utf-8?B?TmdkYTJPVURUejNPMW5PaGxCZklxb2MxSWVSRFRFcERNbEFKc0ljNGN2aC9v?=
 =?utf-8?B?dm5ldEhPNUJpVlk2RVA4SmlTdW9FeXc5dmZiZ3RtRW1DanhBVzE4dkEvblo2?=
 =?utf-8?Q?1i2r8AHi+1YMB7kQ7hdcBTk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c12d93a3-f09d-44e1-ff39-08ddde3f3a5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:08:50.1690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsn84PAztTcTmbqTEHlYD3RAey8rgy30Ek0ku+ptclhFkJ3ud0JxeKhPMWDe+g9zrstoItDeYKMclxsYkbqF6b4ai1a3v2s8gjyc6oApu+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9052
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

Thanks, applied to all except patch 18.

Mikhail

On 18.08.2025 11:29, Frieder Schrempf wrote:
> Am 14.08.25 um 01:42 schrieb Mikhail Kshevetskiy:
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Use an enum to differentiate the type of I/O (reading or writing a
>> page). Also update the request iterator.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
>>
>> This is a port of linux patch 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> AFAIK, the tags should be all kept together at the bottom of the commit
> message. If you want to restrict your SoB-tag to the U-Boot port, then
> just add a small note (e.g. "# U-Boot port") at the end of the tag:
>
> ###
> [...]
>
> This is a port of linux patch 701981cab016 ("mtd: nand: Add a NAND page
> I/O request type")
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: [...]
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> #
> U-Boot port
> ###
>
> Same for patch 4, 11, 12, 13, 14, 16, 18, 19, 20.
>
>> ---
>>  drivers/mtd/nand/spi/core.c |  4 ++--
>>  include/linux/mtd/nand.h    | 18 ++++++++++++++++--
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index c1b8b9627f2..d8abd03e919 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>>  	mutex_lock(&spinand->lock);
>>  #endif
>>  
>> -	nanddev_io_for_each_page(nand, from, ops, &iter) {
>> +	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
>>  		schedule();
>>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>>  		if (ret)
>> @@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>>  	mutex_lock(&spinand->lock);
>>  #endif
>>  
>> -	nanddev_io_for_each_page(nand, to, ops, &iter) {
>> +	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
>>  		schedule();
>>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>>  		if (ret)
>> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
>> index 651f8706df5..0afdaed5715 100644
>> --- a/include/linux/mtd/nand.h
>> +++ b/include/linux/mtd/nand.h
>> @@ -80,8 +80,19 @@ struct nand_pos {
>>  	unsigned int page;
>>  };
>>  
>> +/**
>> + * enum nand_page_io_req_type - Direction of an I/O request
>> + * @NAND_PAGE_READ: from the chip, to the controller
>> + * @NAND_PAGE_WRITE: from the controller, to the chip
>> + */
>> +enum nand_page_io_req_type {
>> +	NAND_PAGE_READ = 0,
>> +	NAND_PAGE_WRITE,
>> +};
>> +
>>  /**
>>   * struct nand_page_io_req - NAND I/O request object
>> + * @type: the type of page I/O: read or write
>>   * @pos: the position this I/O request is targeting
>>   * @dataoffs: the offset within the page
>>   * @datalen: number of data bytes to read from/write to this page
>> @@ -97,6 +108,7 @@ struct nand_pos {
>>   * specific commands/operations.
>>   */
>>  struct nand_page_io_req {
>> +	enum nand_page_io_req_type type;
>>  	struct nand_pos pos;
>>  	unsigned int dataoffs;
>>  	unsigned int datalen;
>> @@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
>>   * layer.
>>   */
>>  static inline void nanddev_io_iter_init(struct nand_device *nand,
>> +					enum nand_page_io_req_type reqtype,
>>  					loff_t offs, struct mtd_oob_ops *req,
>>  					struct nand_io_iter *iter)
>>  {
>>  	struct mtd_info *mtd = nanddev_to_mtd(nand);
>>  
>> +	iter->req.type = reqtype;
>>  	iter->req.mode = req->mode;
>>  	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
>>  	iter->req.ooboffs = req->ooboffs;
>> @@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
>>   *
>>   * Should be used for iterate over pages that are contained in an MTD request.
>>   */
>> -#define nanddev_io_for_each_page(nand, start, req, iter)		\
>> -	for (nanddev_io_iter_init(nand, start, req, iter);		\
>> +#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
>> +	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
>>  	     !nanddev_io_iter_end(nand, iter);				\
>>  	     nanddev_io_iter_next_page(nand, iter))
>>  
