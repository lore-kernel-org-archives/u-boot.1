Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2728AC54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1DC87F63;
	Mon,  4 Mar 2024 10:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="LL4cXEkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A414687F5B; Mon,  4 Mar 2024 10:45:41 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0705.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E90487F63
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIVEqAvuHOI1qQNc3uCjvDyQX2TnVyM+dqXdQKNvnp4Ih/LZR0LWiJu/jR9z7A6xjlREF+83w5RhL4TeMCwirvK9XDx7YBi55j35Ym11KgBMGaDCFzfFB7EEWwBs0pOU+0uJJJFcuMjjUNMFOm0jSTV2jP9WZdUcZJLmlc330Z/Is37u9FKEZprC+oNs9n7BNMfI3DMtVYhHnJIfQO8nBEjDBXMM4AttBEixPHjxVCIorAme/yMgRiuipbdZZkiWqX9xT07EwCUO5g3H0P1DMe8YJGTPaMDi42RnwHUHikyHsucKVuHKp7rBIRApeQ52RsQ+ccWf2WTFq0iwR/22GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPtknU+u6o4F4lLZTukWIuXgV9EsHQaULvzY08XVG2o=;
 b=ibw9zTpVJsU92Fk0hnW2UxofOmVuHe8jCtTHcQSN/FBC/UUvu3LV51oB2xB6OetA/kgPn+uEcnZzdNp+7YW69jDB7HmFiHPMylSv5837Wqv71Dsax3OD/13GFSjVXKM9pPb4iz4MGbAZSul9c1jZeu5HyDlVG9bLtxfz5AMUW5aRC/PAOCDKB5QMtOLuzw0gzRBvNyaKMRH/5rvycUIMrAK+UujY8F1nKwFj2fa1cqnBQgMhpz10zw34k39uEJQTYPKUO8rraG41ynYkQlbbqDDczvTeiLrn/jpPG7SetYQdtREJ8/xTHfQpSFbIyLkvB7M3uSY3G8ms38q7zA8r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPtknU+u6o4F4lLZTukWIuXgV9EsHQaULvzY08XVG2o=;
 b=LL4cXEkWW4ALEO5bw+UCOtrFvY431JD4kjb+lYzHpCoVfZO+l88ZovrBx5ItUBPRpzH9al/2gs+S/Uk4JuK3b4vBYDmZj5Fpbzo6Vgp2Dx3CoMnv1NN7NVSG5ZP5CNG7bc4iaHNBDvo0C7FhVpNePKXLAo9+Ln/qxKnBH0kES8nBmmPo0of7+Pm/1VYqNvph3xyZsEiRFQ/DPE77jj574Ye25MUr71L2eL0tYrMvVex2cMr6G8JU7NQKiSTWNr0TmW4fOnswjxliqThF40kbtgxQtoK2TZ9sKATq1w7ABWHOdsyQyJwp05gA9mO5xQmGKLwcqTjUiRsDTiBiHC2Gpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by GV1PR04MB9152.eurprd04.prod.outlook.com (2603:10a6:150:27::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 09:45:28 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 09:45:28 +0000
Message-ID: <a3be3512-21e1-437e-b94b-79790121eca7@theobroma-systems.com>
Date: Mon, 4 Mar 2024 10:45:27 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1/2=5D_rockchip=3A_spl-boot-order=3A_Fi?=
 =?UTF-8?Q?x_spelling_succes=E2=86=92success?=
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
Cc: kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
 <20240302145107.168080-2-chris.obbard@collabora.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240302145107.168080-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0204.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|GV1PR04MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d8a3b0-5a32-4a07-245c-08dc3c2fd338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAS4vkNbQ3Ujsyl6oxeAK9oEVigXeW2B4/j9NLTI2BqlvuIiU/WoVRuMMa1UEC+SBei4LYBpDmuQa8tz3oqcF/LHFWcFhTjAEHtdfMjoMGV5eBtXPMYrUkB+LNFPonNPvtlPo3m3cWBp8Cdqlfc8OHop4lDT6uKo2fzkKezeDjGW7nl608tC8T1BbtghXKM+fzR4RmEa6C++unUz+w00WON5ytsdncs+eI/iDW+pvsYl7veWVCDqQepZYwR8N8quxufwnUbqr4kcDMW2q8J5AzcilfhZIQIVU7OS5nQYY4gCxfqnsy4NnGAGhqyY0m2lI5uyMkqdbdsRKUSysFDo0RIHYChjakwW/5TsLOi6uGQlRsRxDeuoVI4bKz/q8+oyZAqyiVExbx2DtOQlgCNUcexFcexI8+wi6uUYmRmmKxjE7hC0SEDUbzPVfK+xkQ4MomRxNMbgwAn7jPzqoD+InFNApaUC1jEc82d9FlUVI189gY+s6JIUZgPiSCacCODNaUm1JKCS6WzL9yIL+fXbhUhro7LQOYHq0cgauAn5m0T3Yh49Gz6iwSZSgCTryg6/BncWYzX9D+wLheKl1tk0nWFGSayS6RPAVsrrsP5/9fBsJzy/hMJvEgZATQt0UMTvp6BRwpHJ3IXaZjdQ5FOUdxOoiq1RXSCvMYgL4O/tSEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZjVkZIbW1FZXBUc2I3NFFLbThPZ2liY25KK2NKN2lqSDcrZGc0d3daNFVN?=
 =?utf-8?B?WXVnQVB1RUpPRDJFVmd2UHp3ZTFKNlhVanZ2UnA2TjhRYjE4MlhsRTczU2Q1?=
 =?utf-8?B?OXptUkV6SFRWSVg4WUpWcFhHNUtNT1NOaDhPTzJvemJxZm81UUdCR1dXM0J2?=
 =?utf-8?B?TVBDaWlwd0wvVlU1UDcrOHovY21jSS9vaGxGdFpXTjBGRDRIcmdDMlhaUlVY?=
 =?utf-8?B?eWsxWHFGV0Jndk9xcWJ3V2NsY2wrWVB0UG5odnJkNndPN3BQcy9WUDNFYkhJ?=
 =?utf-8?B?U1NiQ2crcUhMalNEcVdkK3pWd1UvT3ErVGI4YnA4MEM2c2ZRTnJyU1ZqaGM1?=
 =?utf-8?B?bXNVYzRNRVlRaFdoYzUwQ1NPUG1TaUJaalBSckZoL0hkbFNhQjlOVWZNek1p?=
 =?utf-8?B?TUQvNS91dnRwU3V4eDIwRlU2b2JOVEJRSjd3dk5vSmQ1a3oxRlZ0RTVnRlJS?=
 =?utf-8?B?dlIyNzhXd1V1Z2JiSVBiKzA2Y1Rsd2dBQ1BiU1lEOXlKY3c2KzhPRU5ndGUy?=
 =?utf-8?B?bFpUcTRLTGRkZmtZMjRsYldiY3gwN0JXZ2xjUXh5cTN1SlRkNWZ4Mmg4eHFv?=
 =?utf-8?B?aFZYc2gxVzZOUXhteVg1NEZuTUtxRk1DcnhZamtPV2hOdFNqSDlkQnluZTN5?=
 =?utf-8?B?dTljMW5FUjRrbWpOdGF4R1RXcXdiajFONGlEeEVNQnFFTlBHVlhWd3JQZWda?=
 =?utf-8?B?RHc0YTRRdnZCakJTc2p4azFuQkp4QmwvZnB2VWxlbHpHNTRHS0FieU5QaVlk?=
 =?utf-8?B?THhUeXhKVFkzeHhDeWhLUExlUTh4WExVOWl6UDVLd3hyS3RBUFNvWUxJYVIv?=
 =?utf-8?B?VUhCbGVWOE9OTWRDSVZZMDI0Y3pEVTRCOVl6am9mbmdhQlZ3VjV0YXpPdEZH?=
 =?utf-8?B?eFhXb1JpOEY3NmprZENZTGxrWG4vL0VSVG8vQytlYnU5SE5sWVRIb0dMUFdu?=
 =?utf-8?B?TVlBY3pXMFRXRFpkSzhodnBlY0NHK251QzIvZ3RYdmJWeTVLZ1p6R1laTmVV?=
 =?utf-8?B?Q21aRnVmRU56bkx3b2E5M2s0eGxXUG9IR3E1K2hMbk4xTHlUY25reWhxdVQy?=
 =?utf-8?B?TGQrWThNQmozNnVGZ0N4UVgrM1pmK3BQQU1CYVNqcFdFc0pVeVlpdzQ1NktK?=
 =?utf-8?B?Z2lCcHFsdWUxN3oxdnFLQ0l1ZWFtb05lR2Z6bmpLU2tqbXJVUTNvbW9IL3ZY?=
 =?utf-8?B?dW5wSW0reVcxUmVkYUVGVTFzQjBMa0lHZDFDT0xhMzVQZjJZVnBUU3N5bjh0?=
 =?utf-8?B?bUdIQjN4WDNYN1VkVnRhNFdHeG5HcG1xZEhSeWhpdm44aTZLQTE3MFdDUlJF?=
 =?utf-8?B?cHJoZGE1NHR2bUFjL2lIK0dqbnZhbkhNVUNiUVkzZGNHdDU3cEd2MXRpamI2?=
 =?utf-8?B?c2Z5cVRVajg1WGNPaGxHZFdxQ0R4ZU9pZWszL25VM1RROE82alZhR1lDVTh5?=
 =?utf-8?B?UXFrS2hHbnQ4bHRFcndybnF2LzFKblNNT0ZlZmpYMmM1eWY2bWVuZWJNMFUz?=
 =?utf-8?B?bFViRFRReGFBM2VTZ2I0ZnAzSmp1Z3BSZkVDRUZTNjdQSWdjZ01vMXlQTXJu?=
 =?utf-8?B?MlVFZzJCSVd0TTFsRHpOSDhrV3A0alZBTkVCRmNxWjZ5aUpoQTZuNVJUSTNJ?=
 =?utf-8?B?K1ljUmd6bmp3RzZnYW9qUnFKS1ZiNStGWVdYSjlBSVp1TDNzUVdJMFFGb0hi?=
 =?utf-8?B?eldjZkRXejRabm9rMy82ZW5ZTExPaXNvL1BSN2VFRnZUTUYwRHluNTlERFVs?=
 =?utf-8?B?ODVNa2NrVkc4Qm5INkRlZmFkUlZzZGVpejEvT0NNODl1S29vbVdqWENjMU95?=
 =?utf-8?B?WUJ6VStUS1gyZ05pV0xxTE5NVlEwWjIvdHhlSWF2L2pROGZnWFo1K3FYdzQv?=
 =?utf-8?B?NXArTlhONmp0WEZvbnAwdjZyQ0lzTWY0b1Bqb2lwRWQrL3l6R2k0NDJCMGpH?=
 =?utf-8?B?aVZKMjNURFI0czQ0dHMrOTdzYU4vN2ZxbnVZcExPUkpIWjAzTklVakZVSU5R?=
 =?utf-8?B?RnpBUXdmYUV4NC9sOVcySTVKVFJ1NTEzeVJCRXJDN1dST2VNejNvMlZBTGgy?=
 =?utf-8?B?RGF2c0xMQXlJb2VtbmxvU3VXSEtLdjN1ZGxKRDdOWDBmK3ZpaDdYbnMvdlJF?=
 =?utf-8?B?ZksvY01haitkeFVpNlNaKzlxSVM3Y3RmekpFUEZ1T2NmTXVnay8zbFJYdVhL?=
 =?utf-8?Q?tmH2LfVlO7H+WlADAI6Kw8E=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d8a3b0-5a32-4a07-245c-08dc3c2fd338
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:45:28.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cue1NdiyXHWSgZnFN+p8PDNP2OqTro3n0z6QIH6r7flsbWlPHeOVPa/IIJ1ZHcbaIpcXKmQIqBqSLI18fOvbMuwNhME80L+w7cOeNaBLzUHPrBtO2ZHUM4Gz/3PcnZXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9152
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

Hi Christopher,

On 3/2/24 15:50, Christopher Obbard wrote:
> [You don't often get email from chris.obbard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fix a simple spelling mistake in a comment.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
