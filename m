Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3554DD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B68F84132;
	Thu,  8 Jan 2026 16:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cMvFgnJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD2A84132; Thu,  8 Jan 2026 16:54:35 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006A084121
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDUEHfnRL9sRybdTT+No+t8oyafbaJx5LslvHUiP2d6LEXOqOSIRJHnCHBP4C+gNg+VGgW4BXmpHXRkv4m/v1tryQg1sntr5Q17sQeb6Iiz4UbJng5LFI9q53EfpD79yIXjdSqkR3IDhGNvaw8cJjZmM7CmeIcqbykQx8PlxDzQOzjzNNGQi52OnlggFIL/lky8qJKAKB2IzV4Qf7+4c3idxItNzoGP7Iw2+LXo8atVnjIXWkd/NvT9JcBSKG6oR7S+E4jdtQ9ldAb4+nXRfOYrqQUOr5KiCuso+wiFQwPO09UjipabDjn65YwHshV6Bc/NDd0czoZ+k6h/QTHzguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX5uc8rMbqVdMB5jXPhYKBaAKSCrFwech2YBngQpbJY=;
 b=onvuPxfMj7Xh616hQzoodR2UQt3RMY6OQrab4QnpSTsr1YXuETTVl0aqdyme4giARRPoXbM4OowMPhDqYRy+OnSVjNz4nFDf/k4ljQKAID/s9DKX+GZkeEiwEm9quoGG2FMK54nBXWLte9osYaA/atBK3Lvi8fd63tg5l1DMr4kfLsylndnYRZ38vc2gLoxJ7lyDoM5Pw3MLxFfihNs021Wy8kJt5957kK18pijuThGeXFkFB7yBnfka2uQfPrkb+s4efekrE8Ci2ypoYdr/piGtSs1GydOMp7W113WWgdyvZTc7a4x64i9I6SfxdYkArc4A1tqmvJ0uk+3IQAoNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX5uc8rMbqVdMB5jXPhYKBaAKSCrFwech2YBngQpbJY=;
 b=cMvFgnJJvUfoK0tGoQXKewTi9xRWkMo/XKf5KWiKp90eUWiDQskGs8eo2Pz7YAEG1smHuBfFBkvS8SzglATbaTBUNJV4OqLuPgV4FMMMlkWl40SYHM/UbZi8Waywdk9XD/4divXjtwAIFs+QbV4oYBG3c0D5GXhx7reN3K+YiTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Thu, 8 Jan
 2026 15:54:30 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 15:54:30 +0000
Message-ID: <a0c0d2d1-32e0-4e33-a2cd-e61ba5accb1c@cherry.de>
Date: Thu, 8 Jan 2026 16:54:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: unclear license identifiers
From: Quentin Schulz <quentin.schulz@cherry.de>
To: oliver Fendt <ofendt@googlemail.com>, u-boot@lists.denx.de
Cc: Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Alex Soo <yuklin.soo@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
References: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
 <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
Content-Language: en-US
In-Reply-To: <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: bafda1f1-0d4a-40fd-0b8a-08de4ece35e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um5FZG01UW9udzh6dDFKY05rL0xUNUxPcnhNb0VqUStmblByUGhucnFNaUZM?=
 =?utf-8?B?Ulp5U0JoejhxaWVFdlpNUm0rR3lCOG1CZk9zVjA3TUdRY0lkbC80Uld4MGRI?=
 =?utf-8?B?dXM3TzdvNzhjTFZUSTRlRGxIMkl0dVNsMDlqZGxHbFM4TlZvY3pNWmpQR1BL?=
 =?utf-8?B?RHdLalhudUVpOHB3anVuVysxK012cStzS1pmbTRjUUZ6ekFkdUtBQnh4SFI2?=
 =?utf-8?B?a2JIcnhobGlCaC95My9uZnhHTERSWGQ3cHBDeE9jdllidUtPMHplSlF5T2Ra?=
 =?utf-8?B?blNiOS9WK1N6Wkl4WEZScUVZSjNEZm4xcWZuenJrMnBYd29WSHZ4bFpkRDNo?=
 =?utf-8?B?NWMxYkowZVB4WEVpQXZYQU44SHFIOUY1SWZzU1l6YW9RRTJBcjRBY3VYR2JQ?=
 =?utf-8?B?ZEpLVk5QQmU2WVYrMmRVdFRXazE3ZjBYQVJqN0IvNkZDZmZwQS91Z1dOQ0tx?=
 =?utf-8?B?V29UblNVa0JmNk1mQXRIeU04L3dNYWQ3Z1RNRGdIUlhNaHN4anY5YlNGc0pC?=
 =?utf-8?B?dlM1cWxXbTFLbUlJVzZ4Qjl6MzhCdWRMam0xeGFxRFkxU2pvNDFWd3JPdGRV?=
 =?utf-8?B?ZXF2aFQ4dmtxV1oyK0NwSHhocWlneFlmRlh3L3p5SEVNcVFMRzZxQ1FPR0g2?=
 =?utf-8?B?TCtxUjR5MXJiQW91MHJCRENoL1JlZUQ4T1hBbjVCR2JuRFJIUXRnY1pNSzNj?=
 =?utf-8?B?ME5YeUZTT0tQZTBHU2pZSjhIbkdqOTQ2UUFXMVk5S0V5YWh5ZjNZYU1ndlpI?=
 =?utf-8?B?NDRhdXp6VHFLaGgxSjdyUmpCMVFJUGJUYkcxdnlhSEhxd2FIRmFjNmk5dlg5?=
 =?utf-8?B?bi9jN2xxdUJHdmJ3WXgrZzFxdTUzQnFJRzZRTjlvR09HNXVuaTJueTM0TFFs?=
 =?utf-8?B?OUVkQm5jdC9DV3Z1NS9uRklwSHZEbVpEZnJwM2hHeExCY3NRMjNTTDVCL3lV?=
 =?utf-8?B?Y0w5WktSdWIvanZSVkppeW80aFlBVEluS054bkNmY3VRbGUrUkJtM2tNajZF?=
 =?utf-8?B?M2xuRkM5bWUrbWY5ZjlTYmE2aDJTSjFrMDRiUnR3dndVMEt0RzIzajlNV3FL?=
 =?utf-8?B?LzJOa0pPRzRTdFZoUUsrRGNyZXBtMS9xU0l4WDBwLzVvcU4vK21hRmJpRGlV?=
 =?utf-8?B?Q2dIbitrQ3RCSHRXcDA3M1Fjd0dCaGtBMW5xSFRIdnRkRUVRcERzT2tjYlNm?=
 =?utf-8?B?ZTlCem1kRTJCZ08yNEVkejVmamdQVzBZT2RRYzFXYitITWhvTWUwa2o1dXFl?=
 =?utf-8?B?TDdEUDhLdmJxbm5FWW1SQStyWEUxZExZTU9HZk1WMmJrU2QydVcwcE5VQzVO?=
 =?utf-8?B?aGFuRTYwT2ZBeThyd2RlMUVJYXlmMGpaR2F6eGFzR2NCRDVZeTJoNlRGbURL?=
 =?utf-8?B?VDkvK2VDdkF1TkpJeEVXMzFFUUQ3YzhQdE5RdmZHYklnZlN2aTMybjFOWWxo?=
 =?utf-8?B?SEI4Y2UybDdIdUlHZ05UZVlzajFpZDBvS1gzdTNEQmVYWFF1SEZHMEU4ZVBU?=
 =?utf-8?B?VjNhZVhFUkdyYzM5dkhuR0pYMEtnUnZja3Z0eVhVUkh1SnVxTU9lWmVGeVVH?=
 =?utf-8?B?T1JPaWt6MVYvRi95eE5iYUpLMW8weUNKdGdCNTlaeXJSZ1NMNG5DcE5CNHAz?=
 =?utf-8?B?TzhKa2RBMGNkd2ZnMVo2M3NuemoxTzl5WCt3MW1NVkpOOER0cTYvK0JxOExk?=
 =?utf-8?B?dWw0aHhpdTFwRDRzc2pFcGh5WmNTSkNJNDc5Si8zVlVvR1hUd0NBbXhyZXFB?=
 =?utf-8?B?ekZOeXl3WWYzSEpYSkJ1bExsWmp1Y2huejBaeVdOZ0hXYXlSWnNJWXRvcWUw?=
 =?utf-8?B?NlhFbXlvNnpReFFaRjFlRk1Mck5tNWViRHkzZndHMkhtNWd2TG1aRHJzOVVV?=
 =?utf-8?B?WWkwSG0xOFNoRllnVFVySkJPaVNUKzE5TmlBZWpodTZTbkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SituN09HWlRVbVhPaUp6SXVuZ3l0dGFUNGpHc1FxSmRvWWNzQnhjK0JCcXdN?=
 =?utf-8?B?MlRDVitOMjEyYWpLZE1yTmpVcTdEWVUydXZkTHAydjRkbUFncU1ITE91UXYy?=
 =?utf-8?B?eWtYU05GM3BBOCtUQ3FVTlJBOWl1ak9lVGMydlVmNWhyYmhPRVZHa2Rwbm5s?=
 =?utf-8?B?VUFpanUwLzdjQ3lGcmhoemhaRUMyRG5CalRTL1d0NE9RQVFPdGN3NGJqc2lQ?=
 =?utf-8?B?cmFkZWhGTXZQcWh1T3JlWmZRQWo0aU5qbjd1bUpVY3dGRkozNU81c2FRSmdR?=
 =?utf-8?B?dUk3TFpTY09jL1NiaFJULzRLVjBvZU40MGJQa0QyYklHTnJrVHBNdkprNGpV?=
 =?utf-8?B?c2M2NjQzaFp2VDRUOXRtV2RUMGhPcFUzNFBRdS9zTHo5bk0vdmEweld2ZFhQ?=
 =?utf-8?B?QXBNREZmRGVNdCtNaHBkK24vRTVlN25rK0Q1VmRwTno5RmJLWXd4b1FNTkxG?=
 =?utf-8?B?VjU0RGROeWk4UEpSNGtCT01YdHZSa0ttY3crYXJiYzU2a3RkQkxDV3I5ZUEr?=
 =?utf-8?B?R0VVSVdTTDRab21lb0EwRThSaVR5OUI2VUNHazhKeG1Ya0F5SFhrUzE1QzZW?=
 =?utf-8?B?bXZSK3Q3Mkw2VEhqVmJHa1k5T3Y0QlFLdENaYXlIK29tV296dXQ5aVdGVjMy?=
 =?utf-8?B?V1Flb1RYTXJaTHpPanE5QXZLSGJkcjlvc044M0hzVTRyTjFOc1JDeldoejlx?=
 =?utf-8?B?Y3ZGaFlhbWNmanJWWlN5eU4wMnRVbGdNVVp3MzYyRERzL3d2RUtydHlYbTU2?=
 =?utf-8?B?MW55N01vWkFKbThZZ21iOGFFWTR5RGtaTzZWemNWclBUZ0FFQmdvaXU3aHlZ?=
 =?utf-8?B?c1c5ZUJaSE44bVFJQXFpSm9CSUpLRDdlUGVlUUxzbXkyRFR1bkU2aG90TzZw?=
 =?utf-8?B?WmV2aStRMXNpMWJzTFQ4TUhTRzl4K1JRS0c4d0FTV2hOTzVJWnNhdjZNb0NB?=
 =?utf-8?B?dUJ0RHJFWFFwL2dXbjNRR09IbHpQcmc1cHEyZjh3ejhaU1daeHNFWGFGZmRT?=
 =?utf-8?B?clZWSCtiWlEraGkvYTBQUll6bjRoRndHdFN4UHZyOVk1WEVHSnRwYlhOOExh?=
 =?utf-8?B?dUV0cDYzZVk2eS91YTlNWmlMMjZEZXFuWElzaCtZc0NQV05sZ2JSdTlIT2d1?=
 =?utf-8?B?RVlSWjJLQ204OWNYbWY5bDRxcldUdUZObi9pMlh0ZzFqdkJWSk5BUGJFTW5j?=
 =?utf-8?B?OVN3d0U5aVNGcmFtY1RsZnpRbkNBSXQ0K29ZNEhJY1VjcXZITjdXN3VlK0Q3?=
 =?utf-8?B?Q0RRRXJGeUVCcHlDVDVSeGlZT1UyaVh4NzJqQ0FXWjZiSVMzZ3QyZDE2NWxV?=
 =?utf-8?B?Q3lVc3BtMUYra09JdEN3cHlIRitmVzRvVEpQUEM0bDdzbnV4U3RnNVNZcGxm?=
 =?utf-8?B?dVVXb3o5dWhkY0JzdkVXdndTcDdpcE1ldWt4OUxpUE11V2RSb2hlUFFTL0pF?=
 =?utf-8?B?WVVLNmxTeDJnRWVpUnVTZW56eFNxYkgyaGVDejlON0Z4bEN4Z0VxemJMUDhN?=
 =?utf-8?B?SDJaSEN1bysrSTlLaVc2MEZqZFpuMkNXQi9zeXJNYjFmanFjT3FPMGtNeXpT?=
 =?utf-8?B?dGU0NmprSlBvZjNpSjBSVDE1SXMwV1JZZDBSZ0tTKzZFNVAvMHhWQ1kvSWt1?=
 =?utf-8?B?VzkxNUNPVkFxeGs0Zk9FUUxUWjVHRmZ1SlZlMEhSMWJiTW5yQ3NXbTFYTG01?=
 =?utf-8?B?ODJwZ0FoOC93R242cWZXN0xtYmFhZnJObHo2ZTZnSjFGUVdoRndmcmpuTTNO?=
 =?utf-8?B?Vk1vd2cyN2lmU1hQVGxRdTlpemxneC9HUXhTTDRyanZJSHlMc3pEZG94WnRI?=
 =?utf-8?B?UWhKSUM4TnMvMGpPOXN4S1VYVUlTWmhramlxRExheUI4bXB2dnAwWm4yWFBO?=
 =?utf-8?B?YUpNWndoMlJCK2hyMFBraGFoa0xDaHI3a3lCNVdUNnhFNUxnYkpoaHRRaVhP?=
 =?utf-8?B?MmpsOE1VYXYyWDFFSzdORU9HdGhxQXNZVi90dHdWOFp1cThkVEFCMDVFVlNp?=
 =?utf-8?B?NW9QeEw1ZWdQRExQZ0pyc0pxVUhQeEFNeFZBSnlnTjU2UDRjbktqclN0Mktz?=
 =?utf-8?B?SzR4Vmd0b0NFalk2T0VsN0pmQ2duTWM3Q0JSTFkxQ1QrUGtPSnRNbzQ2Z3U4?=
 =?utf-8?B?cDF1K0pGM3F4eUpibmpIMm41c2hhRW9IWitiZ1hPY3lFY0FydytpNXFnZlBZ?=
 =?utf-8?B?WGpMVmNtV2lsekpEazRnazduY0dXeXNSYVI1dmdNd1AwRXVqeEtmZFl1REU1?=
 =?utf-8?B?OFRpSkoweStQdVJ4dlJhdUlVRXFGalRDdEV1RTRIK3FZUVc1d0RWUkJvRVFl?=
 =?utf-8?B?QlVPbXN0WG9zVi9aUHdvMHFFdmFMeHpUOGxtcUxCMHBBWFZMNlhYUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bafda1f1-0d4a-40fd-0b8a-08de4ece35e4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:54:30.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fZbWBCl5v2SkAuUH4cKa6JUmJa9jySjE6nHECq/lQNJBzde6XAeG6lmwqnaJMZdcib23V+Bt/TchLgZiisE9+16i3an9L4x2bqHmklUEDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
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

On 1/8/26 4:47 PM, Quentin Schulz wrote:
> Hi Oliver,
> 
> On 12/19/25 4:51 PM, oliver Fendt wrote:
>> [You don't often get email from ofendt@googlemail.com. Learn why this 
>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi all,
>>
>> I recently did a license analysis of u-boot an I came across some
>> unclear license information in files. I do not know whether this is
>> the right place to put my points, nevertheless I want to share my
>> findings.
>> 1. the file https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Fdrivers%2Fmmc%2Fsdhci- 
>> cadence6.c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdde9821aaf3941a7103108de3f284ddd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639017639504977773%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=g9tZGco8ca9ScjhMgxCxzBwZfHvzdMtCoKPg%2FeERyBo%3D&reserved=0
>> contains the following information SPDX-License-Identifier:
>> GPL-2.0-or-platform_driver which is not a valid license identifier, I
>> think GPL-2.0-or-later is meant here.
>>
> 
> +Cc @Kuan Lim Lee, @Alex Soo, @Wei Liang Lim who contributed the driver, 
> they should be able to answer what the intended license was (I assume 
> the same as you).
> 
>> 2. the file https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Fdts%2Fupstream%2Fsrc%2Farm64%2Farm%2Fjuno- 
>> clocks.dtsi&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdde9821aaf3941a7103108de3f284ddd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639017639504990800%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xIjuRJ6aCai1Qkrjyox1zoeuBeqraiHFqrURQoqyPuM%3D&reserved=0
>> contains the following information "This file is licensed under a dual
>> GPLv2 or BSD license." the BSD license term is vague is it
>> BSD-3-Clause or BSD-2-Clause or 0BSD or...
>>
> 
> We get this file from the Linux kernel, so report that there. This file 
> is more than a decade old, but arm is still active in the community so 
> you should be able to find someone to answer this question.
> 
> See: https://elixir.bootlin.com/linux/v6.18.3/source/arch/arm64/boot/ 
> dts/arm/juno-clocks.dtsi
> We do NOT modify any file in dts/ folder in U-Boot. It's imported 
> (merged) from https://git.kernel.org/pub/scm/linux/kernel/git/ 
> devicetree/devicetree-rebasing.git/ which is generated from the Linux 
> kernel tree from Torvalds.
> 
>> 3. the file https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Flib%2Fzstd%2Fcommon%2Fcpu.h&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdde9821aaf3941a7103108de3f284ddd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639017639504999145%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=V%2BBI%2BTuw8%2FJfOA9BHSmIO6Mu9tDFE%2BRI5TEZtfuHFRE%3D&reserved=0
>> an others contain the following text:
>>   * Copyright (c) Facebook, Inc.
>>   * All rights reserved.
>>   *
>>   * This source code is licensed under both the BSD-style license 
>> (found in the
>>   * LICENSE file in the root directory of this source tree) and the 
>> GPLv2 (found
>>   * in the COPYING file in the root directory of this source tree).
>>   * You may select, at your option, one of the above-listed licenses.
>>
>> when looking up the zstd repo on GitHub there is the same file
> 
> Be careful when doing those cross-checks. We import a specific version 
> of files, so you need to check at that specific time in the repo history 
> what the license was.
> 

And guess who checked the version used in Linux kernel and not in U-Boot :)

>> https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Ffacebook%2Fzstd%2Fblob%2Fdev%2Flib%2Fcommon%2Fcpu.h&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdde9821aaf3941a7103108de3f284ddd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639017639505006974%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=vUDaUjdiT8I5VC5suVIYVFdZDMJmVXJwoOyUdCzrlug%3D&reserved=0 with the
>> same license information. The root directory contains a COPYING file
>> and a LICENSE file (both are not present in u-boot) the COPYING file
>> contains the text of the GPL-2.0 and the LICENSE file contains the
>> following text:
>> Redistribution and use in source and binary forms, with or without 
>> modification,
>> are permitted provided that the following conditions are met:
>>
>>   * Redistributions of source code must retain the above copyright 
>> notice, this
>>     list of conditions and the following disclaimer.
>>
>>   * Redistributions in binary form must reproduce the above copyright 
>> notice,
>>     this list of conditions and the following disclaimer in the 
>> documentation
>>     and/or other materials provided with the distribution.
>>
>>   * Neither the name Facebook, nor Meta, nor the names of its 
>> contributors may
>>     be used to endorse or promote products derived from this software 
>> without
>>     specific prior written permission.
>>
>> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
>> "AS IS" AND
>> ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
>> IMPLIED
>> WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
>> DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
>> LIABLE FOR
>> ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
>> DAMAGES
>> (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
>> SERVICES;
>> LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
>> CAUSED AND ON
>> ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
>> OF THIS
>> SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>
>> Which is an individualized BSD-3-Clause license. Since the
>> BSD-3-Clause license is very clear in the wording " must reproduce the
>> above copyright notice, this list of conditions and the following
>> disclaimer in the documentation" the exact original license text of
>> the BSD-3-Clause license from Meta must be reproduced. Furthermore the
> 
> IANAL, so don't know if we *really* need to have this customized BSD 
> license text in our tree or if a generic BSD license text + the 
> appropriate copyright notice in each imported file would be enough. The 
> copyright seems to be the same in lib/zstd/decompress_sources.h in U- 
> Boot and LICENSE in the zstd repo, so that could be covered this way.
> 
>> GPL-2.0 is acc. to the text GPL-2.0-only and not GPL-2.0-or-later like
>> it is mentioned in
>> https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu- 
>> boot%2Fblob%2Fmaster%2Flib%2Fzstd%2Fdecompress_sources.h&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cdde9821aaf3941a7103108de3f284ddd%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639017639505015023%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=hQFytbMb02p%2FbodM3WFBtQUNa9qABC8vPhMQ%2FrdL9E8%3D&reserved=0:
>> /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
>> /*
>>   * Copyright (c) Facebook, Inc.
>>   * All rights reserved.
>>   *
>>   * This source code is licensed under both the BSD-style license 
>> (found in the
>>   * LICENSE file in the root directory of this source tree) and the 
>> GPLv2 (found
>>   * in the COPYING file in the root directory of this source tree).
>>   * You may select, at your option, one of the above-listed licenses.
>>
> 
> https://github.com/facebook/zstd/blob/v1.5.7/contrib/linux-kernel/ 
> decompress_sources.h. It's specified as later in the SPDX-License- 
> Identifier.
> 

Here it should be https://github.com/facebook/zstd/blob/v1.5.2/LICENSE 
instead. But same remarks apply.

Cheers,
Quentin
