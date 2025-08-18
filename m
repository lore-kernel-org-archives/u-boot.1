Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B0CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB047830F6;
	Mon, 18 Aug 2025 10:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="DZFgeoFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6791A831C2; Mon, 18 Aug 2025 10:20:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C715830A0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY0D3esdVLM18O4qnx39jgVEos7vFPsqgzcfoLxF/MTOr8XglejeMy34HcOTO38otB6zoXOC6yJ+NrXKRkTca8NJ6MfqX+/mue7qMY+dJcCk/vgSZpN90ZiABtv/HHSkPkEn3aqoo+1UVT+XW+aAXxUMHcnEU6OM8ltPA0iYPzIrikYF7njpQuc/cl0/6/DaZKbe/6AMa+kC9lgeB32FIQ15cTM2U1gn6a3fiKMKOYmCOhU3RE1EMQ1mjpOT3dpZ4NCxNF1pwXQX0wFThHR3JM37NvjsaqcWX5lshBheAuj8YS4WzV9wvyQTSOyo/kgcIiVGXLagIFzY5dJWSNXr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCFfZ+j3jvdro1DOGFxB5WYa2g/rDw4pg2TFfQm8Ywg=;
 b=Fw1OyE0S0GmH6J2x9jEv9YVbl3BICypmFHXL9v/qjQnpP7HbnZjNK2ahm9zD4zLJI0pJMax0GX2mBzzk3x5CrZUKs/ejAdVBJwQxlZjG+StImKXN01XrelrKaCRwv4p094ywUDojYDGj0XXh6fpjMNhGpotHR0bGyK4dgEKjUF1qT0tDcxbbSXSOY4MCFnwyreJBuf+imYoAnVXtlb0nZE+dmRjcKPWcUusEU3w1X3HJhX0iKw5+bgFlZpVGLTa4aOiHhQbqtMDLxKDoLGe8VH2oqMWuJAOaLWTGvs51FZBItBufyxgPP/ZrnJQp/BdDTfp2UqKM99Oj+Qud/xcJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCFfZ+j3jvdro1DOGFxB5WYa2g/rDw4pg2TFfQm8Ywg=;
 b=DZFgeoFfoqG3vvU8E3r7VODDLIIvnsbnwkJ54WKjM1R4YrQVOYnlgXQ0g6mad27gjHHJD+myUmSZTClC1Yn43GylI6F4UidkcofMLrbKBdd2rc7//tRAktpLldwM+cJjdQaJW4VFlkOC/M5+5f9zenRrEf2UtFD+t4poaiXPfZPAzzigbtA+MM3vBWgy9pDkcqiWzrXvUPrT8SFx3NA5IGzHJ/tVx7M5XQzWA1eqdujDaVJRx5gotNlmPYUoqP5a50syDTcUdHtqS3si1W/RDHS3K5K7bDBMAlX6oXpED/UUiPCCgfWQR+Ckz0muqsMtr7oZNPV2lsBrncy/ADUXHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:404::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:19:56 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 08:19:56 +0000
Message-ID: <d17d8a4b-0959-4952-a6c9-d372200daa5a@kontron.de>
Date: Mon, 18 Aug 2025 10:19:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/21] mtd: spinand: Extend spinand_wait() to match
 Linux kernel implementation
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
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
 <20250813234314.3945708-6-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813234314.3945708-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e8a1ee-5fdc-4744-bd1d-08ddde30041a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnZUbmdsYUFUMWgveUN2ckxIeGlicVdnTmJuZ1ZibU5jbjlkcjZ3QWExcjEx?=
 =?utf-8?B?YlJucnphdG9zSURsRU83cVlXY1hMeCtIakRHeElJUE9qUjUvcFBYNGs3UWcw?=
 =?utf-8?B?TE9ZRDZRZHlOZWhyNE5LNXpXQWZSM09zSVo4aVh5dGdwOGowWVFuT3Z4Smt3?=
 =?utf-8?B?UFo4cEszMlEwVTBBWFNyVktncDByTXJ5ZGE0K0pwZU4xZEhxcjZYalFnbE1s?=
 =?utf-8?B?RmdSc05GSkNkL3lEaVBHTHFjU25UL2wzQUhVSXZ3azFCTFNMc1puR1VVMENK?=
 =?utf-8?B?SGhoeVVHRzhWSXZPVmx0Z2ZpS1NNTXYybW9jZFJRdTRySDluZzJYTmswWktp?=
 =?utf-8?B?Y0l6ZDJldDIwZ0VqK0pxTVUwZjB5K3ZmUE5sOVZhc09YU1lxWHBIdDErM01z?=
 =?utf-8?B?WDlxeFg0VGJuRlRmT3JPOHQzZFVYREVUeW45cGZsN09OcW5xWTkzYTNzZ1JB?=
 =?utf-8?B?VjRacUpjZzhrNjkvcFRhTDlaT1dJbDB6UFQyd2plRGZSTnV6NTVUNkljUk4z?=
 =?utf-8?B?N1QxdkdOWWZCU2x0Zm41YVJkU0VIbW5Bemh1d3JvQnA0RWlTYWp2bWFybzhW?=
 =?utf-8?B?NUd3Zk5mbnEvOU1sWmNmclcwWXVxQzJMcXdya0MxK2JWZDBYaDRTSisrNnZq?=
 =?utf-8?B?bHh3ZHJvdEdteUN2c2NKaVZDaEk5WkFkSDQxdjVvWE43UTl2Wndjem5VTEJp?=
 =?utf-8?B?alU1YjBTTkVWM0Z1b0J3WWJ1ZGlkUEh3RkdnZDVhOE5xTlpPa1EzczV3dmdR?=
 =?utf-8?B?NTJ6VUxBKzNRVmhzZFo3REVtdXdNQzZkMEl4SWVZMW9RUFFsaGFaQ2dLay9w?=
 =?utf-8?B?MXpWL0Nsei9ZNEJsdlJZR1RCT0hPTUk3TlY1cW53T0t3emJjaTBLRVNMWHhZ?=
 =?utf-8?B?dFZrbnFlY2tWeURTNmxIdWdvcVNDaWRlWUg5RFRsWWhUYjlnbHhlVnk4elJX?=
 =?utf-8?B?TUcwVE50M1gxWVNDUXFzM2RHK0NHQzhyeHN3TG5xanZqMlYxTGJzVFMrL2ls?=
 =?utf-8?B?NlMxRGRCNDMrZ1NiWFNMNlVyZkJIOTVYeE1PaHNDTmV2aC9uTjJCWUQyYWtk?=
 =?utf-8?B?emNnTis5Nm1lQ0h5S0FOaHFickE1SXNLdUdZazdDYmhOR2J3Nm9kSXRhcmxH?=
 =?utf-8?B?VWkrVktOaHFpMldDQ3ZqZDNkY3hwMjN2Vkh3S01YSHkvdUM4ZmJpN2lucHE4?=
 =?utf-8?B?U294cWsvcHZYdHdhSlpjUEQyV0VEWmhwQjdCckRwODJITEF1VkR2d04vTVpk?=
 =?utf-8?B?eGkwVElaWkpjbC9zZm1QU3o0TThCakVlOUJMRHp3TUdzcDVmYTByeEN3QURU?=
 =?utf-8?B?UXpua01MUEhHNWpjUi9BWi9Xc1lIdThBOGhzYjNhRUNsb3dLMDdtUTdHUzBZ?=
 =?utf-8?B?VjRaSHFSYS80WDU4Z251RGFlTTN5OUJJZUZ4UFRsa3B2WTl4d0tDeVo3MXBB?=
 =?utf-8?B?b3ZlZW5GVXN5bjJjMEV5dlo3YWFPTmhjZTlQcVpJclppcUFYaTU5VUFIdWNm?=
 =?utf-8?B?VWpSWkpEL3hSNFpPbTFGanUrcC9xeHAxQXpIRjVvQTE5cHI5YWhORjJ3cm5G?=
 =?utf-8?B?MjY2VWtpdTF1MkJlLzdtUkJxL3BRN0tDTW5RVjFvRGFRbWNTaWt4UXR1U2Z3?=
 =?utf-8?B?c0E1L3lUTnBKOTQ5QjVjNDgyZ1Jyblc4bFl2Y0JsV0FKaDdlMzRLaWJEdksy?=
 =?utf-8?B?YmwrMFh6Uk9mK0xsc3dSTUc3WnBMeWhVQTVKSGtqTlU3NDg1YVlic3hXbm1t?=
 =?utf-8?B?bW5TdWZiZ1FRUFU2VEFZcURSRHNDNGpGOGdpU0RndGZJSXJvQUhteWt6bXJz?=
 =?utf-8?B?Qm5uUlJYaUR3UEFOek9kMHdrMHdSanlrS3JNeThTOHZ5WUJBQ0NpanpHdmFw?=
 =?utf-8?B?bzY4NFZRU3d0STJXNUlsaCsycUtneEI5aTN1dkZDOHd1clIyK0JJaFBQTjd4?=
 =?utf-8?Q?QEnfnZZMpDuWFECBQQoTShwIzkRH85VF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNtUHB4T2ZNWDJrTEthSUNBYkkxdVBRdEVVWVJNL2VJT2FuZUdJR1lNL2Zu?=
 =?utf-8?B?N2xMMEpqQk5YMmdFRXBUTnpqRFIva2lkUEN1eFF5OWhBeVJUMUgreEl3c0tE?=
 =?utf-8?B?M2lnWEo1L3owbUtaV21wUDBlaE96T0hKNjhCMnlrNjVnbENyU01wSFU4aita?=
 =?utf-8?B?TDROdEN6OE1ZaWUvU0lKTHMyaW9tYW1xVUhVblNta1pNYm5CcVB3THFyaTF4?=
 =?utf-8?B?MjRFTlRRMEIxS0xyK3dwMDhuMXBLSVJVbVVOR0xENFRBQUxpbTR0akpUWEtM?=
 =?utf-8?B?THcxN04rZEE1VWcrZldqNzBCN21VUkF1RG1zeDkyUUJjdCtrMSt4Mnhld3hX?=
 =?utf-8?B?aWxaMVB1NEsyb1VtR3l6ZE4wcW1YK205RnBWUkZPdS9CVUMzQXBURFI3cE0v?=
 =?utf-8?B?S3dTb3d3NEpBYWgvRmxDSWZtYmJBZFBJTkZFVEFwQkZUL3VsZzAzMGlXdnEy?=
 =?utf-8?B?Ty96d1doWE1kb1c3QzYzWDMySnRqYVJ5SWJOVG4xVFk1KzYvcVl6b3ZlbmMz?=
 =?utf-8?B?N2diSEhvSi93Y0lIR0RjZlI2aEpRTVVhNHVvMDZoUDV2ZFZVa0FzeERjYzJJ?=
 =?utf-8?B?SitaRDMzZWdlRmZVS0NJdVFjSEJTbmFxb2NZNXRZeFV5VzNlTXAxL2dGZmo5?=
 =?utf-8?B?ZXMrTW95OUZQK1JFVGVpVTdLM3hPMnRUbG9NTkM1VGcvRnd2U0xXTEFkdTBQ?=
 =?utf-8?B?ODZoalRqOGJnUFNua3ZCbHFVdERJeExXU3dsVmQ5ejlOcVBqakhTdmgrZmF6?=
 =?utf-8?B?bWlYd0NSTHJxckxTNW1UUmVjQUZLaDMyTlZkeUM0TEFrY0w2bExpSk1VeTlS?=
 =?utf-8?B?Ulozcy9ZOWpsS2JMM0ZONzFlc2tvN1lReWtTWTFCczMwWmFXWFhxbVRmSEdv?=
 =?utf-8?B?WU80dGQrNEZxRktTZ1pWaFZJc2lzUG1FUUJ2dVBGSXgzRllDcFBseU1Bek1S?=
 =?utf-8?B?cWZTcmQ3c05CRlFWMDdiS1l2cmNBOXhsL0Ivc3V6aHQweTZFWWtLbnk1UjdZ?=
 =?utf-8?B?a3RkSTJWUzlhSWxWRkpqMWFsczNPdHpUUkRzOC9SaVcvcElLTjFQalkzS2lJ?=
 =?utf-8?B?S29ySEZ1NldTYzFiNWUwVTZhTHhiUklObmJleTc1MExWTCtBb2ZnUFcvejlZ?=
 =?utf-8?B?ZzdvdkVzUk1qeGhmUWUwYUFsbHRBRmhuWWQrcVpUTWZBMmFFdjlzK0N0enZz?=
 =?utf-8?B?NEV0ZVJMei9pd3ZoSW80Y21iUVcxMnJTV3FVWG56ZEFMZ1hZTFlORnBDRGFL?=
 =?utf-8?B?VVRzdGZLVC96QVQrUk5jNUhYaWNCMDVmSDJaUkNvczcvTHkwWFFmbHVrS0pG?=
 =?utf-8?B?ejA2VGtONS9VRUgvdnkycmh6RERwVHdteFVFWVJlYm9mRy9WTGhrbXhvRjNl?=
 =?utf-8?B?cVpaVmdUSGcrZXpBMzJqSmhRbEVuaDE4WTVXUmdjQjF1aURsQjZkWUp2Nm4x?=
 =?utf-8?B?bnZXa0JNcVJIVGpWd3pWcmk5QzI1K3lVZjYrR3hjb3ZJckhCYlRiSUI4RmI3?=
 =?utf-8?B?S0pEUm1yd1hUa0kvK2FpQ0g1aldXcTBaM3Q3NHpGV2pqTDJMNGVUZzFvTFdU?=
 =?utf-8?B?dlIrZ2plUll5OHlEQjVJVk1CNElPb2tZd0lFTENFT1BhaHFkbmFUd3ZnT2Vr?=
 =?utf-8?B?eHM0Qkxncm5ZV2JyaXZyUkxuVi91RThnelUwQjFENVdFdTlpdHYrNjNFb3ZE?=
 =?utf-8?B?M2ZBS2ZmRktDRStMeDRDN25OaWZSUjI5YVNOMHpIM0JJNTNHRFJjWFBVWlA1?=
 =?utf-8?B?c0VRVWlyT1VabUFqTmVCSThJb1NyWFh0MUkwbmlaVTF3Z3Z1QjlvdlhFbll3?=
 =?utf-8?B?YWJhSEFhQXdVUnVvZ1VxSDV2Vy9zVktkcENCYlpYc29KSlRSdU95WitDaG0r?=
 =?utf-8?B?RnZSVFFRNlpPdnJnY0JkTGJhWmh0R2xtaEV5SWszR2g1MkNoSm9ibXZoNHIx?=
 =?utf-8?B?QlNteWUrREsrUWpsSisySzNweExnRk9xS0RvUTV5N3B3NVkxSUhaYlAxZFBJ?=
 =?utf-8?B?YUI1Q2FsQi8wZm5wR3A5SmtiV0Z6VkRRN0F0bHcyQnZpV3ZrTmRsTnR5b2RV?=
 =?utf-8?B?Q3VETEhlMmpFb3BsSzFwc09oRzVPd3Flai9LQXhnNElTSy9pd2lRSTJDWUNP?=
 =?utf-8?B?bXpaNXZlU2ZheVY0aDF5S0hxVUhUQURVSHhZcFE4VytweEd5SVg4cEVZdjM0?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e8a1ee-5fdc-4744-bd1d-08ddde30041a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:19:56.6964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ozC3u/R063T0/zJus5bToT7yyrCWrNasEEwgtZnwMTtfApfR7wkSohByEcct+f9GnmXWwVFlLZhI3WCLfomRBK6jtD7m2jFwYIdzzjLiR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6512
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

Am 14.08.25 um 01:42 schrieb Mikhail Kshevetskiy:
> This aligns spinand_wait() with the linux kernel. Instead of calling into
> spi_mem_poll_status() which is not implemented in U-Boot, we code the
> polling logic and make sure that schedule() is called periodically.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
