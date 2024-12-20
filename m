Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE7EE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE09980383;
	Fri, 20 Dec 2024 03:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zcr9PZT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AFA8021D; Fri, 20 Dec 2024 03:55:59 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D897E803AB
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC6hLNaWzGB7XJCa9Sm9ly1Wj0LQ1TH+fJsNbbw5ZEkJkXr8duogdpmDaeIgwFPH0n4TMLs/1E9Ks+mDSbxsq2jTrow2yAX46+2G4bp+hNGFlvDlsvee3MgPSXCdFC6ZDkyUEafaNbpuPAzUZ5Pr4qMoR0t1Fw99j4b8UpDe4QUIkMCeeX/DiFTJG9SOY2ZhOo1hAo+m0ytrrPmzNjkPnzBFwBFk3ebv9K2adcUxTeVi+incOpUHjwPaQoYEiK7T6X7ExRH74V+QRzXEiX9muvFJ+hb1GuoHhtqFt6cR06w3VIeRUibMBOvvRudiwJjaNSuHPapheoWXLUbduNa4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=K1mEMyMo1QOkXg6ccHa4Gf0ATDt/DLTgm6qLDS+Fxcmdg+YSZgy6wZIwX8scyhXT2bdCS6jdRKYdQerEThv+Npn5NT03U9psHygfIBwFu9WpsMqSrgrzzkvppM+FMdByVIzsSfJA2hxvYnjM+gxdWSi01voyQ9xlZiWMdMgu3f3GsSBqkrUu6o5SwBdDI6FNcwjRfyFvuAXlrrs+ifEqn3tqpZEdyle2qFlcQqI7I1Byx5Czf99pj9mqNKXRNuZhlRBTQe3POV4GKuyQ5Tx+ULy3Eaa7wb2rrzImp5nBnnsquw3WBLLcpRj/mZyXlIlJtkprxHe1JDyxwlOAbxqOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=Zcr9PZT8vvsTcy4+x3k28x5ha8ezPiOGYZ27Fygpd09xQareiwnWxFnNI7WPHxm9pySSEkWCUqg8Fc7SyOjcw26Y8q8BDcQts/h7tfqbICA7bvh7V5rpWKZLrxr+ZIGdTYlAOuKQJIsMQ9KHfwzspB/GE6EMp4kwU9CiWk35AOnCXeXOL/C6/hvGKN+nlmi3rqzssLncv+6ccTFbcTOKHugNRaJJsnyX2PqZmVE11ghrCa5jOlmIxOptZBCxxLw9slm8nETGF4bC2a6k/qzNiYM2fsTbxbPSplIjbSU1qZAUbUYl7n/1yRi7lp4JUwmcaTNNA2xWbdRmANCtd86v+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:56 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:11 +0800
Subject: [PATCH v2 13/17] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-13-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=838;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=qFnDLk5UGg3n289p9q9s+aG7DJldt3JWcpA6cpeJkUc=;
 b=bxg6uUWpvaU44uEle1bZnrQrIPtksCL3jtSuMvzEp+08RjW24J8Iaftmz7NKQ6GpOxj6MT0XQ
 GA8LgvysZVvDW2WKORSqPmOFm9zK7IlfjjEl3jYZq1xvjl9JyJTF0lX
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6eaba9-2b29-4a69-e281-08dd20a1d358
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTV5U1ZUamRVSDd4bklJanZVZk5kb0xwbVlXZkpCWmpZTHdYYkJ6ckd3S3gv?=
 =?utf-8?B?bm5Oa0NnclBlMjArK0RwRzY2ZytzMVNwUytXUmdNUHhkdFdZUzRRbVlZWWlS?=
 =?utf-8?B?bWVONk1YLzREbXNtQnFVQWdHMHJjdndxcThFQTZ2cTFOWVFvM013Um10dkZq?=
 =?utf-8?B?ZEVsbGdtelFIT0RSNlFyS0xTTDdvTE9SQWs1U3diNE9iU0hjc0xYOXlKYlo3?=
 =?utf-8?B?SEJabUowTHpSWktqOHk2dkJCdnpuM2NNSEFtMHFUNWwvK0RjeW0vQnh5Q29R?=
 =?utf-8?B?VGl2a0tPa2dZUkJoK1RQVlNFcUNlRDJBZUtnNzJpUCtjL09NNXBONFdNQ0Ix?=
 =?utf-8?B?Q25iWnhIOUJFdkVWdGIvTHpZUmhlRzYxYTBreTBiNlFpaElzSnBpc21zL1lY?=
 =?utf-8?B?T285WWxSTWtQNTZKZUtKcW4rU1N4VnFPQzZ1S1J5YndxRzJoUUxjSDhpeGFU?=
 =?utf-8?B?YXFTdFZ3bkhiRDhvTHhjZUt0WGtzbFVaR09KVjhleU9lKzFnQm1kcGtCKyth?=
 =?utf-8?B?MU9VMzQwN0VNanRPRmVLWGV0STBrSi96MjNlem41Q1dBTzg2VFlkRFN1eG05?=
 =?utf-8?B?ZlFaUEVWeEhJZEIwa3BvdTJ4Z1FISDJuM0xNTmVKeEZIQm9XejgvOE8xK21j?=
 =?utf-8?B?clhjbGxsYnZqb0dqdVFmdlpwMXp4MEo3ckV2VzJyQVAzbHFYeVdLN0htSEtG?=
 =?utf-8?B?U3J2NGkwTEhERGVMSlFWTzFzSm1EaXZnNmF5MTRnN0xiVjFwTUVuaElVN0dR?=
 =?utf-8?B?UkZpZFcrWGlFbloybHBiRXdlYVJBY1hUbHVLQ2ZndVNrbEduZHdkZmpaOWN2?=
 =?utf-8?B?T0RZdzcyQjRTODB5RkppeXhuZ1hNb043YzlJWmJlZFNGZUVtZHl1Z1lQaU5m?=
 =?utf-8?B?elJuanJiN0xjUzB6RVFnazNldkZHbi9OckRIQStibnFuT0dGck1jS2hRdUFt?=
 =?utf-8?B?bUtrWENUcHBNTTd5UDU0bkJMWXRNSXVWZVI3VDRDK2tkSzhIVVM1WGFwWmhE?=
 =?utf-8?B?TFdna0tCU1pXeEhxbGlqSU53NTF3a0NyWXhIeGFqNmJEb1FWSU8rbFozaWRl?=
 =?utf-8?B?UXE0dWFxa2MwRG43R0ZpMk9YWUpEcExoQnFoakpNamxERkdMakNWMkZoMUtM?=
 =?utf-8?B?SHY3Q0xCc2RkcHJZVEpzL2t6eHljL21oZjNCak5tNGU0L1gydnlYVURub3BU?=
 =?utf-8?B?eU1qWUJpYXd5TVgvK1ptRDErTVc4b1o1em5jYzVBeDV4MkQwL1Z3S3JabG1E?=
 =?utf-8?B?RWZ1MUVxcmNqWTgyc1JsemduMlpQRVh2bk9MNmJoTjFGOG15SWxSTjdrUSth?=
 =?utf-8?B?Q3VRdWtURzRMZDFFNm1kY0d3NWp1QUluQUJPVzRtMkJFOUIzTURIbFZybVRk?=
 =?utf-8?B?R3c5TzBkekJ1SzFnMG9CT3o5cDJmTmdKK05nVm9XdjFFbHdwTHZtdGp3NFN3?=
 =?utf-8?B?MFE3bU0va01jSGJlM0plY3RTU210STFRL1lTZ2lQN3ZzNlg5dENEWjNxY3pL?=
 =?utf-8?B?aVhQN1dtdmF2K2NQUXpKZFRTMklWU002M3NXOHlReEt2blo2YkQ5ZklTdm9E?=
 =?utf-8?B?WnBDc25BbGppdFVidnE1WmRjTjl2RktsY243VUxkdTZMWjhBNDNxOEI3MUUy?=
 =?utf-8?B?S0RHdU95RjlCQ2N3YzNDT1JPeW9ZcDdHRXVCRW1PbjhsL1hJaG50TVFGZnhF?=
 =?utf-8?B?Y2FuaUlYaEVsTnhsQis0NDJJUzlJZWZzY1g1MnJGRWVxOURqNUcxNEdhRUpy?=
 =?utf-8?B?ZWZYQ1l2bngydVI5ZDNQTGNxQUUwL1V2dFVPVGJRMjRnajVOeHI5QUl6b3lC?=
 =?utf-8?B?c21yTFAvVzJKR2dLbFdEdDBWeDdXSGNIMU5WL1VUekptMFpUdkdpOC9ndE9M?=
 =?utf-8?B?azNBSTZ3S0I0MENGZVoySVFZL01Eb0FUWHd3WnFEN0puY2xJdGVuUlBnQnpT?=
 =?utf-8?Q?0Fp93qpBI5fFYoZlF/3ybEQCUZUAd/Ke?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9yNFBWTkNFM1lBa0xCbjN5Z3NKRndwVDNHNnh3cmVvQU9zNDkwb29zb0dz?=
 =?utf-8?B?KzdjTjRHVUVlOVVwa1NSM0RrYW16eTBrQWlQbHk0OXNrZzY3c3FQOGRnQzNO?=
 =?utf-8?B?N2F0aDl2TkRGMTB1c1VHMFplOG5KOGcrWTBTQXFQTVR1YmIwdXBHVzhrWnJp?=
 =?utf-8?B?THZNak5LaDNUanN0K0ZwWXhnTk5MVGlzUjJkb1NxTmtSQVRPMVc2aGlSclJi?=
 =?utf-8?B?cnJZVlhVc0l6WCtHR0pSUUxJMG93dlV4Qk4vMyttTlFQemZjcVVBQ1VJdXo3?=
 =?utf-8?B?L0ZSV3ZjdldOLzMrcW8rb2p3VUVOK0pyUE1EUjAwWmJsRENEZzdSOW94ZFRr?=
 =?utf-8?B?MDYwN3hmU0xnd3RPQXVwcnY4V014d0FoQWtQZERCbU5NNUNvKzNwcTRyQlNl?=
 =?utf-8?B?NnJ6TnBDR0Y0RW1uVTVEeUZRL1hUOU03T0twL05WMEk2dk1IVm4zblBLUWpU?=
 =?utf-8?B?bzN2SUdIS0pSSVBZd09uVW9RSGJDWmRyZGphTjNsUUljeGhWSEVVMjJiejl2?=
 =?utf-8?B?QkRYekpaVVdYUEpmb0swejcrZDBIUDFZR21HR2dVSXBBQ3VsNnhuNmpGbUNv?=
 =?utf-8?B?UDUvR00yM2tRNVExbm9sZjNnR0dqMlRoWDNkbE9rbC9JYitsYmg5clZYYVEy?=
 =?utf-8?B?WHUra1F1cVJjM3R2M2paR3dOREM1dGRFUi9NTWZNQk1sd2cya1grK2Y3TTFM?=
 =?utf-8?B?NUo3a0VMTlM5c29SY0Z3QnhVU2p1RnBYMGZWNDhGVFdOL1JIK01XZlByc1pD?=
 =?utf-8?B?ZFVhM1dHTk5BREZPdjhvZEF6OWRQV3BFeDl4YUE0WjJ5d2cxTWFnWWNDMEpn?=
 =?utf-8?B?VXIzeTBGRVBXWDUrWWczY0l0aWpKYUVwRi9tY1FZZDJZS2QwMmREYkF6NnhH?=
 =?utf-8?B?UU5LWjVNbklSTytmN2tDekZRamRySFN1dHMrVEpvZmFpTHhYaHhpbEs2RTZY?=
 =?utf-8?B?cU1JOEh1SFI2TklCMDFjUTA3S1RXQ1RxZjhyNWp2U0pNUmtyUFJuNlg3SkM3?=
 =?utf-8?B?Qm44MklEb1dNWGR4VG0wZmRMR3VKckJvMkg2OUducHlyVlhBODVMRFhPcVNm?=
 =?utf-8?B?ZFBPanNFQUQvU2p6MVh5THlPcnl3Qyt0cXZMZUxmRys0eVhzTE4vZzdDTGdx?=
 =?utf-8?B?bC9vN1laSDNNYi9Fc0Job0ZORUs1RUQxYUJEUUQ4YXE5VzZWRU1zbWhHZDNK?=
 =?utf-8?B?LzRxL3c2bWNHMXVzZ3ZobUloVzBBcWs3bms4Y3NYaDUvSlZldzZKUUlsNXBh?=
 =?utf-8?B?WmRSc1RLZUR1MlhONWdvRXRpYW9vRlRSd3NTNlhobVBGTjg5RWpVV1hUMGYw?=
 =?utf-8?B?ZEhWWlBKQjZJdHlrUnhtZC9qLzlrQUEvb1JQN0c4eDJhZFk5bmM1U0p5OEs1?=
 =?utf-8?B?ZWZJOVNYdG1RR1J1RGVxeHMxZWlrYW9FT1NVbTB4ZFB3Y1QzcHR5NHNMN1Jv?=
 =?utf-8?B?Sm5Wa2EyUGkyaktJTUorbVMwVGdKVkFxc1F6QzN1a1cvWWxnN0hJbUZpczFr?=
 =?utf-8?B?clFwSWtpeVdVdFNSbDd3TW9wRnROUWlMWUs2TGY0U3M5eHJBMXlONE1DOHh2?=
 =?utf-8?B?bFdlR1RnMld3a3JDM0RQR1FTOGNhK1o0RnBpbDF6enFGd1RpUGVTRms1QWdh?=
 =?utf-8?B?UDZNNzkyLzQ2d0NsQlg2MUJvaTdhNU0vcHM2UVFtdnlxYzZOSjhwdE8zRFFx?=
 =?utf-8?B?Y2JrRThHVVIrcUNNdWVEdlcvUm1GSENsUmJrZVR6K21BeUk3ZzJxK1ZNMDdi?=
 =?utf-8?B?Tk9laG52T0xNL2xFajVIMDNZNUprTVlzeVBkcDFjcWV0NmZuT2hvTmlvbDZj?=
 =?utf-8?B?SVVERmZSdS9JejcvU2dQQ21lWDIzdjFXOW9DRUt4M1FVR3FnUENnOXlKT2hv?=
 =?utf-8?B?SkNLQ1VGZksxdFZmVDF2ZEVQMElCeHQ0ak9JQUpYQU82LzJGVjRLK0lrTkdY?=
 =?utf-8?B?ditpTUFrdVRGdDFwcGVMdlhtZytNMUJmKy9YYjcvQ0czM0U5dURwT1F0MnpD?=
 =?utf-8?B?YXorOWg4MjZjTmk1K3FUc1QrKzg5WG43R0xVeHZ5anJxS2tHSm5RdWlxd3lU?=
 =?utf-8?B?YXNxbllmVFl5Rm1JQTlKb2lSQ3BoWWFwOUZPbStlOTl0STRiWTlWa2k4SUJl?=
 =?utf-8?Q?8qsR2hJ37q51WBESs9fq/r7Bi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6eaba9-2b29-4a69-e281-08dd20a1d358
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:56.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtJ5l/7tpPpKsZuVBE0DJvwHP+ab0J7tJEoKoPIOy0eS6FHF8A7s9Ovajw9IcYduXV8uaTVGkWidYQI9MyWfhQ==
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3787d78e28af03d40c41a8b2b1981b..daf6443aa5b40b6410f2645937239a4ec785fa34 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || (IMX9 && !IMX95)
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.34.1

