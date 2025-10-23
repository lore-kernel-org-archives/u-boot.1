Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7482CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 387FC83710;
	Thu, 23 Oct 2025 09:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ILOX4trW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E718A833AD; Thu, 23 Oct 2025 09:34:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1896D82E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFJkxeX1TkLCbnSBPAH+C/EEgxzL2k/jrAYufW0A0YrUnT1+lZ+oyO/56ZjMb0r3cYyeAyq+1X9GCCQV+Gru5MvUg3I7UZ9IyjKgT6a9ec7Zp22J139n5ATFU4tPrwh9uVAu6J78SFNsyA6eD1zGFE896eVDIpiT2DlDIF8WlB0b7/8Lyx4Lt1eGR1qVD5PjluyOAnlRO/SkP75YQA7QwbNOu5wvSwcGQomJeHrbWmFQYpuVlPlbyaMyOY43oJGDlgCUYVED2IHb/JrQnCB1wzWhKb+8xU/k5OkCWBmvOfhG6f0BCz+RS7yM5h1OQUjWmD9zwQ1WYRJihU/gsPUD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kut2RWZrk0aFQyyq50Ny/SsxfgKHA+x5MtmfNgMDzGk=;
 b=FCYe1+T4KZFZNgUMBv6s6HHNEYgVzTU5FrvBBBXagITZiyTe87PervPzn25kWEegKfpI2aPdHQAhjO4N4oI1gDj6Tlg3O4Tc7YEhOWpbMcFJ6xQN3xdDY1iykq0o93K2L2LG3SDm/2dssky9lq0n7dCbhMzbu7cQW2xQYfE8idkiwA5Etg2tlKyVCStG7/rrBTk32rXcObTzWwh8vcX4fJWGJEjSSB6pssrgk/yRpAqXOva0EhK6IZwdwVUZIDmx+0+b6fj5sVAmld+XONh6u63Hg4D/QujKf/g5OqTy0IMoAv6NW6zmjDbvfzYxpc5rZ0ckn6gMXzGf83/wB6NSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kut2RWZrk0aFQyyq50Ny/SsxfgKHA+x5MtmfNgMDzGk=;
 b=ILOX4trWs1f4x8jUpl1kES62ObkFAVBL5qx6i0sUqUKpTUfNN2mr4yjJjnI1oMUBs0UVFdhlmf31OA32ATZqC82OwF/tY6J3ZMGobn8aSo8GFknCjvi/3IV0me/Ce5V7sW8qkWiJy3SZK40cMd+y5qg6jVxcG7l0S5d5CpikwdobnewY2C0vlb8hjWEk+Ov6m0O5zDtc4tYDqL4Ievm5PJL+MzmA8677w5c5DclYzDRFzfwEJ8Pk6ZZxWx1HnfGJvRk7JYQvM9qvfBlpEAqEKAoBU7oV6H8+BQS4eTGLTf94phvIsM9F6zUtufb1gdWCV/UHYMuJacAKkggrEvhPdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com
Subject: Re: [PATCH] sdhci: Reorder interrupt flags in SDHCI_INT_DATA_MASK
 definition
Date: Thu, 23 Oct 2025 16:46:07 +0800
Message-Id: <176120893103.2124.15888827989388370377.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251021205410.2878-1-tanmay.kathpalia@altera.com>
References: <20251021205410.2878-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: d571b78e-dbfe-4712-5804-08de12069281
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1Y3V0Z4WTNZQ0Jsd1lxY0J1dGhSSFp5WU1sa2d1MHc4UUF0aTFGZUpXOUxB?=
 =?utf-8?B?amNWZzlERHRsT0JReFNvSnhoWWtCbFMvZEV5dm9TUFNJazM0MmdOQjh1Q1lF?=
 =?utf-8?B?bjg3aU5ybU5KaEsxTmxRUDlFUncvQlNRcFBEQjU0OUU3WHdYclhPLzdyY1lm?=
 =?utf-8?B?VU03TmVmb0o2YyswTk1oaGtJbWQvMmJ0UDc0cmIrLzZ1M000OWlTaldjaEJQ?=
 =?utf-8?B?OFU3d29yRFV3TEwxdm00OHM0SUY2cGZQVSt1ekRCZDhpWTRXblo5Zml3aS84?=
 =?utf-8?B?ckljYjF4d01PZjdrd1owK2xaUUhISlB0SUNoZHd4elBUOW1sZVlEN3JFUHlM?=
 =?utf-8?B?UTdUNWFOWitZZmV1OXhiL3UyWkk1dDgydFFoVnp1Y3UxTEdCYnhBdVkwSFVB?=
 =?utf-8?B?MXJ4cDBSZFhEUDN0SnN5a2NBU2dTckZCcFh5czVnN2dUOENNL1hGb2NwNkkv?=
 =?utf-8?B?aE1oZHJGM3RtWmR4UjNiS2lZbmVvaEsxZEV1YlEvZlg5ZUdldlJGVzlLTWRB?=
 =?utf-8?B?QzhQcGl6Y2NueGFBM3d5UmhuNTNQWm5lUVgvM1NRbWs0K1E5ZWllUDBhSGNi?=
 =?utf-8?B?UGQ1d0tJVWZUTXFlMFNjZzc4VUNMQnRBd0xFOXRDbHZLMmtVZHRvbEFNK3hY?=
 =?utf-8?B?bitKckZlVnRwL1l5RHlxbmFlZUpLa1Z6akJYQjEwQlNFSDQ0ZmhEdUJSR2Jq?=
 =?utf-8?B?anU0SnlDbXVucDFsQXd2NWRLUWk3SWRIZlo0MENqekdicEV4M1ZPNDNHZGhY?=
 =?utf-8?B?WjJMMWVhQng4eFdTWFZ3MTUxY25OREZrRk5mcDQ1ZEo4SXhmMzB5SUwzUXNE?=
 =?utf-8?B?SDlnb3o2elh1bEw4K3AyeWhlOFdNb0FvSGd4RTFaRGdDbmU0SVIyWnRmekZT?=
 =?utf-8?B?bkE2U1d2VmZvOWVkcGNKVDFaWUNhN2Q0N3BrRTkvRUEvT0JNSW9mTGZ3dGpU?=
 =?utf-8?B?NHhSdWZQOVpGNlRVZWQ2WWRnUHU2Q0lCdllzbWxUR2lZSmpXQTd0Vytoc2x6?=
 =?utf-8?B?THd2VDBOeklIL0RmK053NzlxVk85dTF4Tk84WVJzbUtKWUlZaU80ZUNITXk5?=
 =?utf-8?B?TFJaeDRHRjlOMldMTTBWQjNXY0VNR1N1UlpwYkFCeWR6M1hKRjZPMHo1TzJh?=
 =?utf-8?B?Q1dUVHRTSUlrVnV4SldUeGhaV2R1dVpGb0hZUE5RTXZwRnZEZHRkK2p2cE1t?=
 =?utf-8?B?ZWJNeDhVbXhVcitqMjdCYXAzeVJPeG9DNCtkN0dzZ1JxbHJ1S3U2aG1tVEpC?=
 =?utf-8?B?QU5tVEtWNzJqUzJNWU13c00vYWlhREsyK2dzT0NlRXZuaCtRSHFKYWtxck50?=
 =?utf-8?B?YTdaNXk0K0xsNmhtcTNOUHJtb0pTb0szNEU0ZndQbjlnUmpTNUZoRVJyMHpi?=
 =?utf-8?B?NURFcVB3bGJucFdiYWo5SUNtUVdzTnNxL3hHVkdjYUFaM2FEeGZvZUhlNU5j?=
 =?utf-8?B?T21YSm9RclZDeWhsc21VcU8yVzVuYXV4MlhXZ01vT3cveFhqakVxc3F5bXlS?=
 =?utf-8?B?N2xRWGJQdFN4dDJIdFJjK0R4c1hkWlFUUjllRmwrQkxNZXVVODY3ekNlZWFv?=
 =?utf-8?B?b1VqU1RZVTI4VWZOVGEzRzExVlAwbTR5M3FkdUUra21NS01mM2RWTDRseUox?=
 =?utf-8?B?TnZQaFNJVXk5NHdOM1d1d0RXUlJmbEtreDFIM0VsY1dkSFBlY1dseXVnaExj?=
 =?utf-8?B?QVF4d2VBdWFVRjZlT1lkSWMwdkFmblJJZDlzSjFrSWdUcEJJalY0eHZ5bkdm?=
 =?utf-8?B?aFJKTWhYdDBuKzFTTEdGRFgzd0NsTnNzZ09admFJdUxHQjJMeHdKQzg3MFZV?=
 =?utf-8?B?SXNSUklaUmJRQUU2VXRvc2hrMHZQNmxZVkZUTGxYY2JValo2UXA1UFo3Y0ox?=
 =?utf-8?B?cVVtbXoxeXZYRFFpRUd2U2FGZVhIT0tTNXM0OVZaMjA5RkZsM3VGTGZ5NTE5?=
 =?utf-8?B?SFFqTnVCcktSSE8ya3Rkbnk5WkZJVTFzVDlOblNKK2h1dmN5YXM5WGZqbEs1?=
 =?utf-8?B?WjEzYnh4dG10dlhDVW1SLzRLRDJUejgxa3hac1lmVWx0SUd0QzU3YVdpalQw?=
 =?utf-8?Q?zXh1Gm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZnRTBjeTMvM3JFR3hTRnZnZU1PcmU1UUh3U2l1VUpFNXJ6NVJ0WHU4TkJy?=
 =?utf-8?B?aUY5RDJJMzdCQ0NzSmRsUEZ4WjRLY3p4ZmJuZ0tzdEtlaTFwT3ZDTmlVNUp3?=
 =?utf-8?B?WVFaZjRxRlp2L3Y1dis4d0ttN09WaWhrckxOYmZ6Sm1ZU3BYRk0ydGN0MGtC?=
 =?utf-8?B?UHZyQlB3UDhRZ2JoS2g3SzVJRWw4V2VGSGtreURFT0FsaTVoMDZudU9YSU1O?=
 =?utf-8?B?THdFa0RQeHhuSVI1L3JJeHlMS2hkaEdQZVJXaVFZTEEwKzZQVU4yUGpheWpW?=
 =?utf-8?B?UTZjR3RHMUFFcEI0OVJ4WTlUZmRjdVBYcnVUYWRqSWZxL1ZiUFgwc0N2RDZ6?=
 =?utf-8?B?MWllcmk3aTlEd0pXdUVIeFJicFNEK0RFWW5uRk0vNW1maFlpSFZna3J0eTZI?=
 =?utf-8?B?RklaZlBuay91UnRXSzJNenBhcDYzNVNHc1RLcjhOVEJkaG1VWk9DSTlyZDla?=
 =?utf-8?B?by9sK1FOZ0hweXNZdU05SXRxcy82aEFXZ0RBa20wVytPNFgyVG51bVp0N2R3?=
 =?utf-8?B?ejJzd3l0R1VEbmxFK3o3eGVDY0VidTRqb2o4eCtjKzIvRWZaZlY3WmRFZ3V4?=
 =?utf-8?B?NjY3bEdZUXNOYjZTc0pKeU5TS2pXSmhINW1pOEZyekg1dHBjS2c4aXEzUjdt?=
 =?utf-8?B?Mzd2WnErbVQ1bm5wbGVzYTJQNnZ1REx1WVYwZjFscHpyTWowdkROS2o3aTNP?=
 =?utf-8?B?a0wyM2s4Q2ZUYjl6RWRBaXVUUUlEZjRhemcvVnpmMUFBSnN6K29xWDh5Wk1G?=
 =?utf-8?B?QklOSG1zeEhwalR2L0d2ckJhVkh2cmlUMWU5Vnh4SmdXOFowRU5BRHJmL0NE?=
 =?utf-8?B?bzRzU0NNa09WaVN3ZHZFQjN0V0xLUmVXOG9ENEJtRDNmckt6VFZpQ2R5N2Jy?=
 =?utf-8?B?SmF6V1g4QjQrby9vZC9mbzFna0NzTi9CMWl6SHJiSmdYV2pyd08zdUY4VDFy?=
 =?utf-8?B?ZTlnWFJRU3hid0JGNGVEVmtiNW8zb25KdytDclVsTDc1eE9Mb1JoaUpudVJm?=
 =?utf-8?B?ZityYTU0UlBkNysxUjFZWjVSRFhCc0Zjd3JWT0czaGZ0TFQvTWJpY2EvNWgz?=
 =?utf-8?B?WURsNHZDYXJjZjdPeGphYUtDVjNFZlRwOHUzZFUxS3hLS0xKZk0weFo0Y25o?=
 =?utf-8?B?cjdZRkwzZFBNendkdzc3TzhERG40ak10cXJSNkVtNnZaUmFsWFZlTlRvdnBa?=
 =?utf-8?B?MGFJQXVLSWYxQXREMU05SmJMTEJ4RUJzQ3FuS2dSbmtwYkZ1VmgycFd3ZEpK?=
 =?utf-8?B?VmNrY0FwRFREeW9nRVY4REtrcHEwTzQ4YWJlcDEyLzA4UVFYZkYzaWxjaGY4?=
 =?utf-8?B?RWFCUVNaa1hBWGZoSklhVWdJNEJXVk1udEExOXlpMlpLWk9SV05ZOERZaHlw?=
 =?utf-8?B?amhEbWRQZnVvOFZiQTcvWU9KMURSN0htMXQrRWVTK3ZlWUhnckhES0FZUk1t?=
 =?utf-8?B?cGRXUzVkWk40Vlo1NFcyaEdXdXUwQW9mR0NHcnFRL0xNWFRYQlcwT1FnUWNk?=
 =?utf-8?B?TTVzK3o0ejlSNHN0Q1U5T0QzeUMrZ1RxS0hvMndraVBRUjJMb2xwM1g2Znpv?=
 =?utf-8?B?OFNzeWNkL3RQcGVvRmxJVmFrdlNtZTM4d1RPeW5NRnJkSmtpTTRacDRxN0lE?=
 =?utf-8?B?WFNKeWlZOHRYeDdMcUFLaTVzanB4SnVjNThqTXNoUGYwMzg4VkN4SVFHM3FB?=
 =?utf-8?B?YmY0Q3pFMktFOGJLaVhvUGdJaU9RNGR3QWxnNzFDUkxUVXFRQnhtaUcvRllS?=
 =?utf-8?B?bHhPYWlJQ0txWnN2Y3N3aDlVbEIzZEtlNVp4YkJnVmhlQ1JKS1lDbURzTS84?=
 =?utf-8?B?MjhYSDVMOVc1QzY3VFBkQkN2RFJyY2pMQ1lxTHBRTkduNVVLTVczZnQvd2Z2?=
 =?utf-8?B?TC9UZVAydXdrRlE4SUJsOHkyaG5GR3ROZS9jS1h0LzVCRXJSSTZsU2haWFdX?=
 =?utf-8?B?enVXQnJQRkM3SVBya1p5TGwzVkd1QUk0V0x2S25hamZpaDBST0doUUNidjd2?=
 =?utf-8?B?U2hORGNORkhpSXFLZ05GajFMOStRWkc4TkxMWmJteU5RVUpGNDMxNndDZ2Ra?=
 =?utf-8?B?YktpdkR2ZDlaK1FCNkJWMS9uZTdDc1lWOTNsdjNKZlRIU0J4dXJXTUNUWGNX?=
 =?utf-8?Q?CBzh20IeBh9tBzvdA07rVb89/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d571b78e-dbfe-4712-5804-08de12069281
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:17.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3AjkxMoiKYQoiKj5hk+aiaHG9nuL0zhMuPyt24u+DA5FnmKAs7hjdDtpgZX+pg3ayAxhqXezZef2Ns1mED6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Tue, 21 Oct 2025 13:54:10 -0700, Tanmay Kathpalia wrote:
> Reorder the SDHCI_INT_SPACE_AVAIL and SDHCI_INT_DATA_AVAIL flags in the
> SDHCI_INT_DATA_MASK definition to match the bit order as defined in the
> SDHCI specification and maintain consistency with the register layout.
> 
> The functional behavior remains unchanged as this only affects the
> order of OR operations in the mask definition.
> 
> [...]

Applied to mmc/next, thanks!

[1/1] sdhci: Reorder interrupt flags in SDHCI_INT_DATA_MASK definition
      commit: 09e812d836e5f46e9e0dd7a83643e33f520d330a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
