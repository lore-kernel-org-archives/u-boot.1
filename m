Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59298E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939A080371;
	Fri, 20 Dec 2024 03:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A5YURvY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE71C80379; Fri, 20 Dec 2024 03:55:28 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD10980362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thKVI50uK/MVW85nxxxbquh8jbfzsfL8IxNDqNdX8iafRdPINOYWrbIkLmAQRVV4NSbor7PvTN0A1hq+C4cdQZwe3DXCSfDwAeMmdnwgU8ZDVSyNjbQ+Qjd1DzyvZgOiPejKnXvMoBFpQLXCwlxACPF19CW2LGTEe4menIN+w8BJDIcrHOHjbHIzK2elE2riQJ+57sfeRfG+VrQfLBLnWU7+bNsEGYRtMujZYJxiYTFs6lHwu0jL3h6Ht0wDv5ilrqacRETZ8hOH+js8UpRh4I6nxjWOcSvGOS1oaBdRZzyzvnO4s4mmCuVocvmhnj8wVYsUdAMLx0sDIquLuh7jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=CUgu57SW13nOfMINYJznMSn74k4xunbxhu58qp9IllC69sfE3LNG477vb6lukIyEbUnbNMqvl0Q8AJOOMu6jboFFGU0Y5KsnwOpDO+jx3F/zZVnJ87rNDxyWHu9UmrZxEHcfuDo/P4mzFQP0AvalV8TLsyleZwpW7Ft7JMaST66hqw6oIT7ktlgSv8qmYy938gH0sMNvRfou4uOvTL8IXYdwUjeKSsoH7izw0vbzI9K3CXFbHSBtEtCjQUN3Lh9uGHgQS2/XX0BcQ/m1A1sI9NVO4sfUZ2hW2A2QWGq2DE7TZTbeft5xp/aFqWtAvedI4fhl18nP6kawI/9fFiQbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=A5YURvY+FxO0XLlDxBOX8orgVUaEJ8NVzeNahwg1BvcGOo800dKjRm144kxCv7NtuD3SmAzTT/N92jzJvolmeKkgzPsfSHySe6RjpJLbz2QnERQVHXsE3s1bgjNv+coOrCCmuWJQNGoJDQqt1jtbCeO9pzROZHQOOAIb2m/79sDt3XrSb6VWqXmQa/xkMOcFM+yjYI8PRTRGCgSkiaZQchfy/IeZy6II+7ykuRPKezVYFFQwTiATbMkbbV80m7AH20au4wG1ZPkHaxu/x7RarrehDHdqXjd9NynGWwGFKmSIXqODANC1nLbt+4VhRtWTSi91KbVcMdgtIluTyUItHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:25 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:03 +0800
Subject: [PATCH v2 05/17] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-5-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1209;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=BJ/qxA9lxg2nGm+vMp5VJshGwywLmhm+kcwTDcL9kMY=;
 b=lAAYzG1byTPBwHT/Ky1LxuH49vsXq2IJR25l+b7PI3n3U1HuEYkjrZ/RkjSmMrSTk5SO7fZiE
 CkXokbf2vwfBHncpxhBmS1H1HfJJJCx5YjpClIW5t9t0VfGrkw0bjn5
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d2ea60-68fc-4c05-a9db-08dd20a1c0b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3JkSlV5WTUxYXVYVENzWTkzbkUxTEFwaXNtajNPU0lCQkQ2WTAwbEVpL1p3?=
 =?utf-8?B?bUEvazFjMDhOejl2OW1UdmdRVUZFV0JNMWRZelZYc0RyWkI4QndMQ21WQk45?=
 =?utf-8?B?TmdWUzRoSVo1dmwwblNLN29zb0FYZnp6bDg5UXhNeDh5T3pUZXRnbmZTYk5B?=
 =?utf-8?B?QzNCaVphcjQ4ditTVjJ1K1FIeWdTY0gyR21EYUlSNWtsQzBrWWVIY2Z4R1Nh?=
 =?utf-8?B?U0pmWnlibk9Vd082ekZoam00SkNWeTUrMzM3TXJRMWFxbnl1eWN1dDV3VE5k?=
 =?utf-8?B?WHk5Sno1TGtSTGhiZW90eERlM0VObFIrZ3RlTVF0Z1lrdkMrSDU5cXBQQ0FF?=
 =?utf-8?B?VVd0Q3NaRlQweUxtTVhsS1NER040d1NtTGQvYmk3ZzN2UWc3YkJHSTk5V2Vv?=
 =?utf-8?B?YjVtUEJvL3hvSTJXTHgrNWpQYUdhNjFjUUdZckdzcXpZQ3NNbkwrcDlNNytI?=
 =?utf-8?B?M1E4SjFleTUxQmkyK2xhVnZpdTVkdjRtM09LYlFwdGhhTmp4eDdXZmRsbWt3?=
 =?utf-8?B?Zy9SWGZlUUZUb1Z4endoQm0vUjJlUUNsZ0dsTWJsdmZBa3A2TVFTSVV6YWZT?=
 =?utf-8?B?V2NiNE1VRUdLcktQL0o1V2h5bEFuSUNFWG03eTlHOW1XaFRjSzZveHlxeWc2?=
 =?utf-8?B?bHdmYUxjbSsxaGFnVFNSWE9odWI3SWk4VWtPQlBYOVB3OHU3aTJvN3hBazBx?=
 =?utf-8?B?VTl3Qkk3U3IwL1U3SFNsL3V6S21Ibyt1bHBHeGttZnZDbDBLU1F1TVc1K2Qr?=
 =?utf-8?B?MHVqOGszMG5VWUYrby9CN0NGTnpxS1ZsTGM0aUdON3dMOHYzOUZITUd2WnQ1?=
 =?utf-8?B?dkdrTzdPK25yNFF4WlU1Ry9vZUZsTU5UakYvc1g2VDY5MnV2TW5TMEFkQWQv?=
 =?utf-8?B?UGMvcFIySFZaNXJJUFpmY2Z5QXdYQTZEM2xyalJGeis2YlppVVRTVkphRWNw?=
 =?utf-8?B?emg1bjRaS1M5Smsxalh6M3lFZXBWZTRXOVdHZmF5QVJhVmxRVEE5RVdqWDk0?=
 =?utf-8?B?REJSQlU5NDd3WUtTYWNRV3pRUjdVZDBZdWFUREpHWFpCZ0VickNwcGpTZ0RW?=
 =?utf-8?B?Qk5naW1WSDFpWWxTVHMrdmFNaDdmcUgyV3dqSE4xcDFBQ2ZER294OHRCUVl2?=
 =?utf-8?B?YlNwbEFlR0pKb0hEdGNubVl2QzZPNXNvejZPTDJwRnhPZjlOckdISUlDdjI1?=
 =?utf-8?B?aWhlWTgrWjcySlpudGpWUnpwdVF2QmdJSTJiaUdPZmxZT2dzdW5heVg3UDFl?=
 =?utf-8?B?dzdValRzcTRGMG1scUN4NE5RMjNMQml2N1U3LzNZUUUvMkZjcFlDZnRpa2sw?=
 =?utf-8?B?ak90VEZQTjBFMVBkRjY3bUlhQWZYUjVScENWUTBIWWtvL0ZLSlZLMkdnT0JZ?=
 =?utf-8?B?YjY5SURId0ZyRFYyMjE3SVlKdjNkREpvZkRtYlVHRUYxNlM0WForLzRmRVBq?=
 =?utf-8?B?ZllLUkZ2SGlpZXBNdlpKYnhwVDN0aURPcjhlTzg2V2dRTWFLalE3d3liNm1S?=
 =?utf-8?B?VUxVZ3BKUEdNQVVNTUhidGhaRmJBUkVTaTdNRVVVdjhjanZzTzlTcFN0SGZT?=
 =?utf-8?B?SDNKeWhDRGxnNXVNKzdmTmhtZDg1S3UzQVV0VTRMT2ttZWRMZG13VksvSElN?=
 =?utf-8?B?dE4wRHBIMVR5OWRmbWpBOUp2NGYzWlQrS3NwditGRWQwWVRVUUgyeEZGUDVp?=
 =?utf-8?B?cEY2SlZIdEJNMUg2WEZqMlpxNmY0a1dHU0wwQjNMTFJrUFJRcDdaYXV5dU5W?=
 =?utf-8?B?TkVESHNNODZJMjNZd3RoV0xIdFdSdEVVc1IycGFtUE8zcnIvTXJLTTlIejJN?=
 =?utf-8?B?STJLRHR0bEN3eTJ3WSsvd1JWTnpvOWJCTWlXb2RQcjNtRWVzWUIyc3dLVGhD?=
 =?utf-8?B?eDVscjVnNWY4bWxMZndsSTZvcUZnU0F1TFVQekZZK1F2MnVWTDcxSjlQUEtL?=
 =?utf-8?Q?R5HOpuVornQ4Ojx7BrmpoycydnsB3w7b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3pVZHZBNGlGaUFqSEh6K215a2JLakJzYVd0Y1pOdURMakZDQ1hZZlBiMXNM?=
 =?utf-8?B?dmRQVGJ2eWYxejRyenNxTjhpSjJqTlFLdk1TMTROTTNSL29PZ0U3cDhSWS80?=
 =?utf-8?B?QitZZ3BNZ1VSaXJRdWRWUFZ2bXpHUlRXWVFsRkxZNjdJMzZpUFVWQmVOVnJz?=
 =?utf-8?B?MjVoMTN6ZHNKZ0xqQkQzU2VLUCtiRS9VekNwWk0xTURQQXZVRXdlL3dpQ21u?=
 =?utf-8?B?WVZYaExkTnJrTjZucElRQU4wT0ViMGdReEhDb3NIcW9JbWVpMVMxcXFINnIv?=
 =?utf-8?B?VG9HeUhkTTN6VGMrZGVPTWxwZ3BlV2NOL2JTaE1iWktOM0NIZ1lDaGUzM0pN?=
 =?utf-8?B?blZqSi92M3RGYkF4eVBoQ2NabG0zSEdLWlIyaCtrOGJSSTIzamd6VWp1cmRk?=
 =?utf-8?B?N0o1cEVJbjJ3Qlo3RUpVejIvdGVRdXowY3FwTUFhTjVSVHVaTndQSXpKVHVj?=
 =?utf-8?B?SXg2YXFJQ1ZQVnM5U3JiTWdrWmFIRjQxUUV4RHUwZHcwM0plN0hBL3JRY2dP?=
 =?utf-8?B?QkJMV2pHcXoxTm1vK3pYL3BWVzArWWpkUUtjam9IM3NMOWFhZzl5MWpWZVkx?=
 =?utf-8?B?bmhpYWtOUkNocEZnR2Z6MjRoNEdBUldIaDdBSzhHN0RNdzdFYnBITlBzazFJ?=
 =?utf-8?B?U05mWmJMUnV6OHYxcW1WMWFjMmIwSG1KVjJCRU82cnpIM0lWMU1wQ0tZcGt6?=
 =?utf-8?B?WmFHc0h4eGpEd25BQ0JqcVcweUhHOEIrWWhKVk0wdkJuZXdFUEpyS0Z3Vjh5?=
 =?utf-8?B?S3cvN1UvTzIrWVdPOFpZNE5QalRGUXM5RXNCZFZTQ0RJZ1c2b0dWSkkxdnRz?=
 =?utf-8?B?aGhya09qWWlEZXpYTFhleEdWR3MwZU5YQlNSNHk5VWFtRGV0UnQxZ29LZW02?=
 =?utf-8?B?TENKNWw3RUJOL1NEbWMwRVI3eUlLaWxMWkxhTlNieHhjdUdlQTFSYmhuM3pQ?=
 =?utf-8?B?NHFndGdYOHNzbnhjVDNXRWQvQ2ZUcVJwelZOYnM3bGd1RlVzOWEvL0ZOWkpn?=
 =?utf-8?B?ZzNJQVRUemx5Vm5MbUdib054K0NCQnZJczRzdXFwMk5lUVdZdWNITVRxWER6?=
 =?utf-8?B?dG5qMVBYaTRqL20vOVNxYWtEbzd1SWRhS1NDeFpsT1RFVk1qdjhRQytLOVgy?=
 =?utf-8?B?TEYrYmNQR040UmtONWVIampydXZRNHpXdkJ5Q1FUUGFKYU5XZmFaNnZ5Qnpx?=
 =?utf-8?B?ZVV2TlFTT0ErZVU1eFIrem1oQlZlaHhSeHljV0N0OWpZaldnc041RkZORlhk?=
 =?utf-8?B?Tlo0cy9RK3RSYXFPTzdpY2JCTDdwY1BZQVlTanlhc2tEanVnKzBOZ2w5WTRV?=
 =?utf-8?B?Wm80aEFXQnZ3VzhFQ1RaeTBBbEtVVzZRc2Rxek5LYmpaTlM5SGQ0WmRtVjRh?=
 =?utf-8?B?VVJXMXZETUhaNnFwRlZyVXpBWm5NeS8vTytFWmh1eVJDQW9XS1R5T3ZHK0Q3?=
 =?utf-8?B?bGxrK1QzOC9ialhkaWljQkMxbll2MXNxcTdzSTFsUnpaeXFFdis0MkhTT1hn?=
 =?utf-8?B?bzJuOURMOEorUTZvNGQ4YXl5TkVLdzVuUmhWeG9XMFNKMktwbnlZUzFoUTVK?=
 =?utf-8?B?ZnkyK3g2b0FYem05MGRJNkczK0hZSVhweXExZS9pL2I3MTJhYUpJaHVzUXlI?=
 =?utf-8?B?K2lkR09SV0pwSG1nQjdpa2pQZ0g3TkVHVWNWb1VjMGovR1VNTElvL2VVZUZL?=
 =?utf-8?B?bmpyZUpabFdhVkNqWkcxbFY5c0ErVW05dTBBci9Wb3RxcUpHZDRPODJ6dG1F?=
 =?utf-8?B?QU9EeXF2d0hWUVUyNmJQY1J1Qy9FQ3hTTmZSbnppem94N3JwY2dxUUVyQkh3?=
 =?utf-8?B?WW8xc2hkV1oyK0lZV3AyTkxmbjY3MGpZK2ZrMlRud2Q0RXVmSWNLeHFtTmNv?=
 =?utf-8?B?WmRRSWh5R3hoTmxDNWNSdGlXOUdwQWUrVkFyS0RTMm01SWZ2ZGVaWmlDdlN5?=
 =?utf-8?B?SWprc0VHQzZ5ZEd2cWlZRVdQZTc1V3pteitFRWxtWmtOSzdOTDRxSFNudDhh?=
 =?utf-8?B?b2Nkb2Rxb1ppN2FHZHZIbkxTemVEZjVNR0JOM0pXOVVNek91L21NZ0Q5emgr?=
 =?utf-8?B?eVZ4ZytJOVlnUStZaHR0Si9qVjkvN29FZlZTZStiamh6dVIyTEZ1d3ZjaXYw?=
 =?utf-8?Q?o3sgEBETVG9Vfkry9tGd3XjPl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d2ea60-68fc-4c05-a9db-08dd20a1c0b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:25.1952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpXMrMKcNqdC8ZewJ3hEYvqPsEghR/4c/Cvb3XPg77ZUS03GMlRzCuHeSxktTrzP5YVbztjc/GT4nr2kmtc6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Peng Fan <peng.fan@nxp.com>

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 6cda1f00df1f6baf6db65a28b4cab114f8540a4b..08c86a642844570424dddbfcf9670d1e6757d8d1 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1044,4 +1044,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

