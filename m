Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC56C87FD3
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 06:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A081083E18;
	Mon,  4 Aug 2025 08:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BLWS5wK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4067383E57; Mon,  4 Aug 2025 08:37:25 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E20283E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 08:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/zJnh/Zau0Y3pWc3Ep2vaoxLcpFUY1EOfbLAJT0Yd6DQYnNnAlpWkXVDFSKXfGZQ6Z9mHmZte+VGPDyvTNtLFOv9np8d9qdD+4iFry9e5HWk0AdeYzcHZS8w/Z9qQBl/zi029CL4x44En1N4wmUgT9lXF9kxuHWFars2U5lqqLZOAbogKwSkKlQS3waSS8s/xltipVzMMcPVZLMWbTcK8p2KccfIV7DW8jeziVFZnyUxrlxHOBgMapfd/Hai9yFh09wwKLauecW8c7CyU2hmocDNqhpehy3c++wceqfMTCaMSlJTZ06pRRH5ng3IgxdFI2C2eh+aQsLCpfhkACByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3i7byuCt9KAzczXTyrpIHajsYyj0oW4ogUo1iMsEuo=;
 b=Lz1zvhhO9wypoSoCwyF3znqzELyVKkd0icahrGaOcqx2iOCBcK7GWs52RlZlySRu0tNfVspOslCn8NpxrflqTYEZpgL7YvEJW42VBHJh5/8bU2mmaTq90nEt19vmtbBpgEfg/+Rkh8Huq1FSMm1JLVNhje7xAhLfTNLk+oRXqNmbpIUxshIS78E/oohuNXyfZGygOpjJrJskYO8tYdqns+s3SifrFb+ZmCF/Mz0nErHGtBwLT2rP+J9SFoL7EkdMgH7M0h6awTp/LvZnCPs8u9cY5Y9qQ/8YuGo8ehv8mJR9J53iuZT79MxLMSceRTOP6q4L7FatXztsN4PWp+hVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3i7byuCt9KAzczXTyrpIHajsYyj0oW4ogUo1iMsEuo=;
 b=BLWS5wK/n2HNTEqhakZxmg8Hb4q7p1hIvEoQANSy9OLsmQxYEXoy7pUS7/4PEQP8GGrwCUkRUWhAZE/7iQWpF3+fI48+iRQoK4+YG6GfyJ0xjxbESE5SWIlRXGXVXtt4qLPPXJoU9WUNgzQFTLHCyUN+NIJkpKBR3T0qGqRcflCZyrMKOuGN7EtzcHaewcN8x89I48aE3e3NZrHIfUejoh8fPYuaoxsik/L/ey84u1m7Tp2PmyxyLvJ8RFG9PVFgZf+gX7oGz/M1JA/flQWwSFABZFKm54f7dkWtpsERLHkXdkva3xdHWq54bi2kA674bl0dnHj/yzcSiDUYOuD6YA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 06:37:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 06:37:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>, "Alice Guo
 (OSS)" <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>, Tom Rini <trini@konsulko.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: =?gb2312?B?u9i4tDogW1JFU0VORCBQQVRDSF0gcGh5OiBwaHktaW14OG1xLXVzYjogQWRk?=
 =?gb2312?Q?_support_for_i.MX95_USB3_PHY?=
Thread-Topic: [RESEND PATCH] phy: phy-imx8mq-usb: Add support for i.MX95 USB3
 PHY
Thread-Index: AQHb8OWImY5U8SjkTkeATMQrFG1L2rRSMWJQ
Date: Mon, 4 Aug 2025 06:37:19 +0000
Message-ID: <PAXPR04MB964459F9FC599677EAC9F08EE223A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250709152408.3037701-1-tharvey@gateworks.com>
In-Reply-To: <20250709152408.3037701-1-tharvey@gateworks.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8912:EE_
x-ms-office365-filtering-correlation-id: 46fdfea6-7fd2-4f9e-2cfc-08ddd3215c9f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?NGYyam1sNnNBWnhwRVBiZkxBMWIvZEhMMCtZZUtPZUpXNkRSQTN6U3V3emts?=
 =?gb2312?B?VkhkUU1RT1ROMXd5NEZFWUNrYjFsSkorNUY1bUJkWFNXVlYwamFScWRSSWQ4?=
 =?gb2312?B?cVp3cGF2K2pvZjlXUEJJaWhUc25kTjAwUEVzV2M1dTJYYnJybFVDRkNuZCs0?=
 =?gb2312?B?dDh0MWpGV0c5L2RQQmFWUkxoRWkzTUUvby9JQkZZSCtZbVZLeHZmMHU1S1Zy?=
 =?gb2312?B?blNRa0dKNmpOS2Izelk2cHVBeGppUHdDQ21PUE9UTHUyUGlWZjRvcUt5Wm10?=
 =?gb2312?B?cjArZTdUdWc0QTd2L1NkVWhUSXF2MVhybDFpTXpmNHpseXlHNDB0V3Y1bHBZ?=
 =?gb2312?B?WlJDbnEzcTFRb0tweWZxWDVwQlFzU2RhdVV4aTNIZ3BncVJJY0VhZWlnQ3NV?=
 =?gb2312?B?NFpwaUdYNDZ2b0FWcms3SXplMHg5WUhneFJIS0NBaUtBVzNvenV3ZTdyYlEx?=
 =?gb2312?B?R1Zpc043NnZlOHArU2F6bFpMYjV3aVVkdm5vUWxpQjNzMi9WYUxHOHhvN2po?=
 =?gb2312?B?ZENHUXNNQ0VmbS9rNWc3d3FDM0xKNzJIZVNXclNoUThYcW4vb3Y5aWlIL3Qr?=
 =?gb2312?B?azMxZWsxMWx6SnFGVkI0aUNqeE9sQ1ovMnlueDN6UWlKMFpKdmNGVzFCUlZa?=
 =?gb2312?B?NjZybjIyOTJRd2pYTnRHMWVBZ2JCTmVvYTJYdEdVSGw0bHZuWnVrcUs0YVln?=
 =?gb2312?B?dVJYY1FnMCs0dk8yODFTOCtGUWkwYmhOSDUwNWE2K3JOaDVRQWxVWTNyTHBY?=
 =?gb2312?B?VTNmKzBwRGNEVk8vTDZyV0UwT0hOVmphclZZQXp5Zlp6UjRVZWNqcHBqY0dP?=
 =?gb2312?B?NnA0NS8ybkt1SEpHRGdHTkc2Rk8vQkhrUHVHVUc4NGhxNTZBbUNobFNCVlFN?=
 =?gb2312?B?N0o4ck4rYjdlenpPZHIyTHpIK0VFNENPeG1ycC90Y1B1bkRQd21IaEdiUUxU?=
 =?gb2312?B?UnVidWV0dkdTQ2hjTW5CT243OWV0L2pLWi9mbnFQWHk5WlJ5RWVUMTJnN1Z2?=
 =?gb2312?B?ZWRMdVhyL1RaZ0FPcEcwckU1NHRrcEE2RjNlYWFCS3lMZ290VzVvQ2ovelZG?=
 =?gb2312?B?T3U2dm83ZndESUJtZ3RBR0t3ZGtOKzQzRUxkaU94bEJMNGtnVU5rVjRSd3dh?=
 =?gb2312?B?Rms1NmxpbUpRMzV2NkE2RmNSSXJFdDlDTFZsOHVpeGwzWjFwVzJPbkg5bTdW?=
 =?gb2312?B?OTd0dUE0YUlHelpVc3RlZUpCZVpKaGpIbXRudDN2S0NoTGVXbzl3MHFydUFu?=
 =?gb2312?B?VC9yUkVXRGlrSVpBTHVsRkE0TFU2Z0RvRUNaLy9hTCsrV1c2RVhjTzA0RG5Z?=
 =?gb2312?B?OU9BT0xMV1hzd3hwcVljVW02YjJnUzI4K0NHQmFFRVFhVmJqQUJpRGdHOGw0?=
 =?gb2312?B?RzJ6U1I5dzVFRWVKU2RMbWZsWkNsTW8rSXArMWZ1OGNwZWYvbjliSzh5RGtT?=
 =?gb2312?B?d1RYZTJ4ZitFUGNpTGtoYTY5RE94UC90VkxxMVJIRHE5eThqOTZDR0RsU3Bj?=
 =?gb2312?B?cmIzME9wQWFuUFF0RHFpSWZoU1ZjZGxWa3h3ZFprREJCckg3U1R6SEg5dE5J?=
 =?gb2312?B?Q2FqQkNHZjR3bGdqSE5rUGxxZ3lIUzJHQ25pRGJrdUVhbUNmQVB1NUJQK1Rq?=
 =?gb2312?B?NjJxUi9lSk1iaFF2dHZLbytUVkNXWTdTeTlTS3VHalVjc0hTbzlUYlNwSW95?=
 =?gb2312?B?Q1Y0REUrN1hCeUY2bXRzQWVHc3RGWWZ1N0cyY0JBVEE5VlY1RTVUVHJNZlBm?=
 =?gb2312?B?VWRkaTUxUmJPZlZVUFhTWmtQMGFLcE9mVTdka2Fqckc4ZXkyKzJXYXIyUXFB?=
 =?gb2312?B?Z3VMczRQanZLYzRzd2FTdU4xejRXTmc0T1gwK2FienBjOUtCWnZRWGRVazNZ?=
 =?gb2312?B?RUt5bmpVOC96Sk0ySE5MRHd0V0ZBdjYxWmMwV2VuYXNackp5QzlGd3lLcVNx?=
 =?gb2312?B?SGxaRGN5a3NZSmM2b0lXcEVia2I4aXROMitMaTRsRFRuM3RXc25pcDNrTDNj?=
 =?gb2312?B?RXdGdVBsVTFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Yy9GQnBLOVFhQXpsTVNZQTkremNnbDJyMmpIZHUrOWhjbTNxRXpFVmZ2U0FS?=
 =?gb2312?B?NmNZK0xyZjBnbU1ueVN1T1ArSGoyMTIwS0JTVS92eDRydjllTFBNVC8veUtY?=
 =?gb2312?B?WWVKSEZRS1ArQ2txV09TRmU1TzRKcmhrTWlyVkNzYkhkYXNTOHBpaytZajFm?=
 =?gb2312?B?VlVNTDVkSzJLNnlLdUFweWRpM3IxQy9sVjR5Z1BRUVRidUhCclNLWFBlRzg5?=
 =?gb2312?B?TUVlUUhXVW11VE5uVkJwSVNnUEpha1V5ME1LL3V5VWtlODIwYnJIN2hGTGlt?=
 =?gb2312?B?eHR6dGcvN3NVbmFRZ1F5Yjh2YVNxK3hSUEc0SDNZYmJBbzllL1MvUG9SMGVu?=
 =?gb2312?B?WUZJYkE0OUJtL0cvQVhYaFVjczFYakF3MnlPcXRkS2Q1aldNWjFmaU52eHI2?=
 =?gb2312?B?TzZUYTBnVjR3amd3SmZrc0Qvc1dGSTlWM0l2YXNyZ0JpMkRFL0RwZnAzWlEy?=
 =?gb2312?B?RVJqc0JKNHl2a3ovTHlqSGJPOGtxTk9teXhqNmNDYWVSdDBudG5OdVc4aE53?=
 =?gb2312?B?TWxuWnkxbm8yRzI0MWE2WE5wTlBMdnNEWU8vdWFEYlQ0VHdJeUF6dHN1eWVD?=
 =?gb2312?B?WVhkNkhhTFNmRmdLVmxYOGxPSWUyLzh6STl3UG8vbUZHcXhIa3VNd2poally?=
 =?gb2312?B?VnBXVDFoam9FUEw3b3QwcjlyQ3p2N2ltSDE0dHJBTkpwaGU5RlNuMzVJb2xl?=
 =?gb2312?B?RThSR2RuV2Jha0Fub2RONmZKdEFPaERrZlNvWnU2WUZSMGc5RFd6RTQyTWIx?=
 =?gb2312?B?OFBzR0pmbElKeXlBKzkyaFhIN3VreVN3T294akNiMnZ4S050Qm1FRHRXblZJ?=
 =?gb2312?B?MWFHc2R3aDZTVTFYVXY2NGFidVdhUmsvR0JnNXVOS1FUMXJobDg1a2grQis0?=
 =?gb2312?B?YmdPU0g4Vzl2OGNtQ0ZaamExQUZodU9ZRFBRanFVS3hKV0pzTDBmQTJvc3RQ?=
 =?gb2312?B?cmdDbDFZT2hPajBubTc4ZWJSMzhNdUNhZVl1YitoUXRVUVEzZ0huSE9QV3Vi?=
 =?gb2312?B?NVdvTnVxc000YThsb3hmODJCaHhRSFpBK0oyUTJyOWI1Q0FCMitmY0UzWVpG?=
 =?gb2312?B?YmpOekJWZXJ6MzRQV1ZZUzlnbzRVY2RuRHF2V29VWUhZeDkwcHROYWEvTzRx?=
 =?gb2312?B?M1NrcTBHcWJwazB1YVpQK093U2l3WmVXK3VVSDhrenlteWVDbDM3OHdoV1po?=
 =?gb2312?B?VndHMGVoK2lVNFY4Lzh5d1YvSEpFbGYzSTVuNUl1MkdqcksyQ04vMVI0M3Rs?=
 =?gb2312?B?SHJuVW04Q29qSG1qTzBwd1VlWXQxejJ5MEJBajB3eklJMEJEcGtqUTJsZWZp?=
 =?gb2312?B?c0VaY0M4SHZ2V0Z3WmQrMVlZcDRsSThlcTNaV05OM1haa3cvekxrVUU5bXdC?=
 =?gb2312?B?ZmJMeWlSUXJ3Ty9zWkxuS3NlR2lOeFF4MGJGeEhjMTd6dlpNblhjc0p6MWlI?=
 =?gb2312?B?ZDF0Tko0QWg0ZmY0WUhwSWZRUHQrYzVIR0JZY2FzMHUzWm82YkhLTmQ0akNY?=
 =?gb2312?B?dmdXTXRtbTJVSUt5ZVFwZmNqeUVtY2tTdmVWRDdnMVMxeHY3cTUzWnZpRktL?=
 =?gb2312?B?WENBdW80dTZZV2R1cTZBb0UxUzE1eWR0S0kwV1o5MFFqaXordlNqK3RVSEFu?=
 =?gb2312?B?SDd5YUZ5T2gvNmtyZ3FCZ2hzTGdYVlh5QXY1Y2VmWU1pZVNhSUZNcWFwellj?=
 =?gb2312?B?eUdINFZNNURiOHRrQWRoVkk5d2dIL0h5VmZrMTlaODZYZXBWelowSUtjcGZF?=
 =?gb2312?B?M3hvb1oyTU9Valk4MG96emhtZEhoczgvQkxpRVJ6L3pnZWxISkNqamZaaDFn?=
 =?gb2312?B?RlVtOUIweVFwamF5VytabGsxbVFhVTJheHZvcWJlWXpBOVN0eWQreWROZ1lo?=
 =?gb2312?B?N0NybmFuRFJ5a3p6ZHcvcVNkbWcyZnF3dCtoNHF6UGlOaTBacHJiR25ueEJW?=
 =?gb2312?B?RjlETjRMVXhRcTJ1NWxYWjZjVlZoTEIrR2dRbVVTMVFvKzE1VlR1OENnR1Vw?=
 =?gb2312?B?dHZDcUZUU3UvRzZGK2N6NkIvcWYwd2ZXTzFtdlN6NW90TzZzcjB6R0VSK0NN?=
 =?gb2312?B?RTVyeWQyUmQ0NkxLTVBzSU9oRnprQ0tLazlZUjk3R2h1eWV2VjdTaU82R1FP?=
 =?gb2312?Q?gjBGGZpQIP+5WThlU/y9Tqb26?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fdfea6-7fd2-4f9e-2cfc-08ddd3215c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 06:37:19.7572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JTFD/ZiE2IhTN97oPx5iTbxuJPmCoAFUgD/bFnbHwGNrh/BtAVbFD+XvpaG0Su+k9nmNYHf+oGngEUGbeHf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBUaW0gSGFydmV5IDx0aGFydmV5QGdhdGV3
b3Jrcy5jb20+DQo+ILeiy83KsbzkOiAyMDI1xOo31MI5yNUgMjM6MjQNCj4gytW8/sjLOiB1LWJv
b3RAbGlzdHMuZGVueC5kZQ0KPiCzrcvNOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGRlbnguZGU+Ow0KPiBBbGljZSBHdW8gKE9TUykgPGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BuYWJsYWRl
di5jb20+OyBZZSBMaQ0KPiA8eWUubGlAbnhwLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxr
by5jb20+OyB0aGFydmV5QGdhdGV3b3Jrcy5jb20NCj4g1vfM4jogW1JFU0VORCBQQVRDSF0gcGh5
OiBwaHktaW14OG1xLXVzYjogQWRkIHN1cHBvcnQgZm9yIGkuTVg5NSBVU0IzIFBIWQ0KPiANCj4g
QWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgaS5NWDk1IFVTQi4zMCBQSFksIHdoaWNoIGlzIHNpbWls
YXIgdG8gdGhlIGkuTVg4TVEgYW5kDQo+IGkuTVg4TVAgVVNCIFBIWS4NCj4gDQo+IFRoZSBpLk1Y
OTUgVVNCMyBQSFkgaGFzIGEgVHlwZS1DIEFzc2lzdCBibG9jayAoVENBKSBjb25zaXN0aW5nIG9m
IHR3bw0KPiBmdW5jdGlvbmFsIGJsb2NrcyAoWEJhciBhc3Npc3QgYW5kIFZCdXMgYXNzaXN0KSBh
bmQgaXMgZG9jdW1lbnRlZCBpbiB0aGUgaS5NWDk1DQo+IFJNIENoYXB0ZXIgMTYzLjMuOCBUeXBl
LUMgYXNzaXN0IChUQ0EpIGJsb2NrLg0KPiANCj4gSW5zdGVhZCBvZiByZWx5aW5nIG9uIGFuIGV4
dGVybmFsIE1VWCBmb3IgVHlwZS1DIHBsdWcgb3JpZW50YXRpb24gdGhlIFhCYXIgY2FuDQo+IGhh
bmRsZSB0aGUgZmxpcCBpbnRlcm5hbGx5Lg0KPiANCj4gQWRkIGluaXRpYWwgc3VwcG9ydCBmb3Ig
aS5NWDk1IGJ5Og0KPiAgLSBhbGxvd2luZyB0aGUgZHJpdmVyIHRvIGJlIGVuYWJsZWQgaS5NWDk1
DQo+ICAtIHJlc2V0dGluZyB0aGUgWEJhcg0KPiAgLSBjb25maWd1cmluZyB0aGUgVENBIGluIFN5
c3RlbSBDb25maWd1cmF0aW9uIG1vZGUgKHdoaWNoIHdhcyBkZXRlcm1pbmVkDQo+ICAgIHRvIGJl
IG5lY2Vzc2FyeSB0byBlbmFibGUgdGhlIFBIWSBpbiBkZXZpY2UtbW9kZSkNCj4gDQo+IEZvbGxv
dy1vbiBzdXBwb3J0IHdpbGwgbmVlZCB0byBiZSBhZGRlZCB0byBzdGVlciB0aGUgWEJhciBiYXNl
ZCBvbiBlaXRoZXIgYm9hcmQNCj4gZGVzaWduIChpZiBvbmx5IG9uZSBwYWlyIGlzIGJyb3VnaHQg
b3V0KSBvciBpZiB1c2VkIHdpdGggYSBUeXBlLUMgY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCg0KVGVzdGVkLWJ5OiBB
bGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8N
Cg==
