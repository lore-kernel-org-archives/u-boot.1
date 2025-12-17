Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A3BD6554E
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 11:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B91F83AB7;
	Wed, 17 Dec 2025 12:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Nh/10Y2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF0F83AED; Wed, 17 Dec 2025 12:17:31 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3CA839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 12:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jurcBXjqw7PEB//u7nSvq9FtJN0epVsE7W8X8yo/VNY+fdrMbpNyx5awReKEeL5OCrdOYm5zA9ZnPMlQvZbQgweX6UITBmG9PvN+n6Oc2qZR25G9eGe3QWJ9qNSCYcfLtfs7BwhX/KPq1onpjFrgX3+f7W8SLsyEHmthgIomPNhIa/U5Vy9RCWmsVApiXD+VcCogkKgRArfaKX+r/z7b22DMooV7QYnTfk66s1v1Ny4WRGPMGNEdaH/+yCY6P022jUjzTztgQzKn3960NqgF9CFwqLyE1qNoz+YQFJ89/8ioU3xdeRLHseL0qbOHyqLaaboHQa9Q63lxewUdde/bwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0PXEpWNfNXqRR/5sZKg7MNhmfKDWtxLLj9gZ8XeyYI=;
 b=c5VvJZjt0uEHqR+up18stmVa4K62Jv0n8+QSypB0Fj73zMEiyes7APObLlVdXElfyJUS6HAv+cxknBJK5yjsdcNHGFBKsoHuVuSG5uh+y5kYEJMjpPFcIaBl1EuAtXus+6NROckGMMHiQPX2fcl4smZBWgNDRq9vLzW+ZLZtjLfx91SqGoUlzvXJuUs3JoOO/rFVfYn4+D6W5x8rNCI0AAOY488uuX4GRWpqzxJav1t9jT7OPBtKTyWUEMYQ/nEwAmpQuwniflI+KSC8NJXZvDzhfFKTdSFt3MQ/UHtpm/N2/2IGMAt6lpNr8fwcZn9UuCsqGjvjq3B4VG0BDVXcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0PXEpWNfNXqRR/5sZKg7MNhmfKDWtxLLj9gZ8XeyYI=;
 b=Nh/10Y2u62VV1SJLwN4QdJEexDe4XjXGxvMMuvK8YPSAGvoAJ1rhbHKzQM4RnK3ZSf5n2t8LrHdVBaO1dMFN2Y1dMd94cLNHG4zvVKA9HFFo1T64sS6YafGCAI+9iljxdlokuMT9T24G9GJboblK4nJF+HUtHfvXFtcTANgZtOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 11:17:27 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 11:17:27 +0000
Message-ID: <86ce7d12-99a1-44dd-858b-58fa7e4050c0@cherry.de>
Date: Wed, 17 Dec 2025 12:16:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
 <30bf5f74-b3ee-4f83-974c-44b0155e0839@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <30bf5f74-b3ee-4f83-974c-44b0155e0839@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 03eb256f-65b7-49f8-2348-08de3d5ddc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk5qdE5jclpDU1k0eEthbWpmbFFObmpQeC84cWZTY1hHRkFnYkprOFR0RlRu?=
 =?utf-8?B?blZWTnpmeEJZRE5XQWxXT2xyRFJ4ZDN6bE5mRjdaVmhTOHR3L21JSlhENW5q?=
 =?utf-8?B?TGtUT1pybVRKT1grakc2c011b1d3bW1saXIzLzMzckx3amlTRDZSRkRNMU10?=
 =?utf-8?B?bUdZSWQzcVo3V3k2dWR5a2VVc09FNm5EZm1tYlZqWlFNelNoZ255NFdhNkxW?=
 =?utf-8?B?aEhUeVh1VGRoUXU2QlVEdlRqd1Z1anVCMWJQZnVnbjFEVjVwSjl6VTNNclF3?=
 =?utf-8?B?NEMrZW5tTE9EaU1oMk9hMWpVTW1GaHNxaVpQV0lmNHZvN1RoZVUyWjJmQy9D?=
 =?utf-8?B?bElzQy8zOEhHc0RKYXhnUk1JTzVhSDJJcjlwSTBNQTZ6UHFnRlZvTGtiNS9w?=
 =?utf-8?B?bmpLQXNwZXJOVzk3cFp3c3Z0ejVKRFFtNkdFd2pQQXZ6RmhqOWFaREdGaUtE?=
 =?utf-8?B?SDVPbzNyRUNsNlc5RVo3d2Vhd0ZYQUtIWjNMSmFZWXNjczFjM1NNcDRvMHpJ?=
 =?utf-8?B?N2MvK1Y2SGtsRnVidytlS1MvdW1Dbk5jeDIxUVdxZ2pvN29XNTNvNzExY3g0?=
 =?utf-8?B?aVdXOGcrOEJCQSs4dFVlSUVBNVNJdjBtUkM2ZThDbExXVTR6VEFYa3JDQUpQ?=
 =?utf-8?B?RysralFVZGNIUTRNZWRaLzBLbUlwL015aTBOaU03R3hIZkJ6WHpzbG9kc1oy?=
 =?utf-8?B?aDVQSzZaRElHYWhYSENINUNEYTV4OEVYa1EwWDhuWG9mVkN2TE9yOFJDNDQ2?=
 =?utf-8?B?dVhkeDk2MVlSWXNsSVNRWnhUTXNZbmF1bWlUQ0JjYVNRZkVPKy91WWo2czJs?=
 =?utf-8?B?SzlvUms4TE5rV09RK0hvSXdrUDdyQmlGcjFJUlJCdkVsTk1ISnYyV1VSYXR0?=
 =?utf-8?B?MVpZMlpnbDNMSGhaMWxSdm0rVVNVbGIrVnlvOG9YMWtGNE5LNmxVU2RhbTVF?=
 =?utf-8?B?R1JkcU9QOVp6bnFMcFJIUy9VTkQ5RG82U1gwWTNTSEN2TUl6RW1VamN6N2ZC?=
 =?utf-8?B?VnFScTNKVnFqK213OC93dzRWVlZVazM4ay9uRzBlSENlenpOcXBuVklRZ0lL?=
 =?utf-8?B?RUttVFlwUG1MWFVrMFZKTE13YjNBNlErdThFV2l3WVA3aGtINHg1R1BuT3BR?=
 =?utf-8?B?YjdUVEowcCtuY2RTR3ZzL2lJVThEa0dhUjl1eGJ4VVVkVzVUTVp4TkJYeEpw?=
 =?utf-8?B?OXNVTzV0Uks1NkhGRnVhbkpoN2xXaFVMUmJRZ1dFS1BUekJPUEUxdnpiTFIx?=
 =?utf-8?B?L1Nkb2V1cm1VWTlLNVhWUEY3T0kvZFZhVWZqaUJwdklZSWNCTGFZS0U4TkZk?=
 =?utf-8?B?bjN3bE5Xc0xGcDM5MkF3RHlVZ0E1OENxMnpsaCt1QlVKbDFxVEMzY3BINEJt?=
 =?utf-8?B?VXVMWHlZK081V25pSFl0T3QzS3RHNDBWOTJZWTNQVVJqMDg3SkRZazRISTlK?=
 =?utf-8?B?Z3lFZ1EwYnh2MmZwU2lVQjRYU3N6YVpyUVpjbDJjTHFEbEFwVmcvSkQwNTBI?=
 =?utf-8?B?WEh2dms2Q2orSllzcGlPTEVoNVNiWGZxTGlKZVgrYnVocU9UMGdPcGU3dVlU?=
 =?utf-8?B?d0RwS2tZc3psWkRSYWhXZWVjYytzTTFuZmdSdVBSUWx2MW45RU9lRDdRaXNY?=
 =?utf-8?B?VVJUbGNkODNvcWo1ZVJNL3I3bXVFaGE2RGk5dWZxSGl0QnJxY1pGMENXcTBy?=
 =?utf-8?B?cndvdC9wTFQwOUJ0aU1FcUI5OW1ZOTRFTGVVMzVKdm9BMyt4TThURGdLeTU2?=
 =?utf-8?B?eWpaVEVhVk1scUZEMU1DZ1JuUlM0R1I1SlFzbWpVQ3BHYUxGK2dKWmVSMUFZ?=
 =?utf-8?B?Q0FXdWk0QlozYURrZGs4S01qOWl4QVVDWU9udTBaSURDMzNXd3BzblY4UWpY?=
 =?utf-8?B?MCtvUjFUbHp3UDdwOUpucHhnOHBPZWtCUGJUdjh0YUQrWGtxRmVieG1IMnpV?=
 =?utf-8?Q?8y/dtTl5nv9rjdUKdItPsqK1KG30HF3Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5HdEp3bVlndmlCUERBbFFOeDZuMlhZNk5nZVVQQXpUZ0c4aDNiaENxUkpH?=
 =?utf-8?B?OVpOaGMxZ0VRSWpjaHVsTytyZVlSeXRxdWh4Vi92MEVSUTlxRFdpV2gvbDRn?=
 =?utf-8?B?ZVQwQ04yWUpXdXRRd2FPQ3AwKzVwcW9FcFFYRzErVktWVVZKcTc1dWJpbzl4?=
 =?utf-8?B?QUZzcFRzRCtLUjZLWTBiRk4waGc0MFA0L0JWQ05nS2FmeFdRL0p0U0U4aFA1?=
 =?utf-8?B?WTFCWHBtWXVsZUlKbGt3R2I1R0tXYnVBTUhPUXdEWTBFZ3Jwc2ord1RKbXVy?=
 =?utf-8?B?T09aT3JBcWlHTWJ3d2Q1ZFlvdVZwOFFyUVA3SzR3cDR4eG9IWjdONXRsbUFI?=
 =?utf-8?B?aUptOHJmSHdDTSs3cmhkc2JLUllFRHZBbzJUMk5zQWtrMnpXYjIxdEpvN1R4?=
 =?utf-8?B?VXM5Z2hZaW53UzVLeDRORG1QMFppT2NvdURSZzFXQlIvVUJscmo5OXlWTjlu?=
 =?utf-8?B?TFR1Q2VWQmNSR0lkRlJQZEZaeWx3S0ZMYnpXT1hhL3l4Q0VtcUMvd1JMQ2NV?=
 =?utf-8?B?VE1VOUg4cXo2K25nUXliYnk5bnpybkExM0tIVEs0K2UzaXdyRFhtb3hUOGNQ?=
 =?utf-8?B?Vk9OWDVyOVpnL01lNzMxWm9aYjU5aHZKeE1wajlkK3FWb014ZU9qM2p5TDdD?=
 =?utf-8?B?Z29HZ0tkclovOTFEZVAzSmZVaDdISTBXaHdna1VsRnBuS0F4S0xUWnZvdlho?=
 =?utf-8?B?Z1RjS3J1MFhSZG85am1sdVVvMDlnejJtL3dqREZrNVFEeThjcUNwVFJBeUdh?=
 =?utf-8?B?RjBpMHM2dzA4czltNkdyak53M0MrUmhabjVEUGQ4WHFtQXg1TGNMSUxlVE5E?=
 =?utf-8?B?OWJjdTlmVHduR0JPR0c5N0p6NENMdmtsMDQvT0FXcDVGcjEveHhrc1ZCdDlX?=
 =?utf-8?B?bFFwRWxNRjl3c0JwR25FMUVHSGpOZTVMRjdJMHNoek9QS3FjTHJXemwyQkFs?=
 =?utf-8?B?TWNwamV3V1A2UGRvQjdxekd2YVJMU0F5ZmIvQkdYRkxxN09ZSnlXZG9kb2lu?=
 =?utf-8?B?MVR0WnFMWGdydnVFL1BRbVd1V3lyNGUxbkhHNUxLQWlmbHJ6UmFrVEcycnFH?=
 =?utf-8?B?RS9RUElHQXR0Z0FiR05JRHR2STRlNUZ2ci9Ca1RFcXhIL0V0cktDdTc2WVc1?=
 =?utf-8?B?MFlEYmRUcFpkVkZZS0JReXRrTHBDRUJWVUZEUlhkTFZXY3NudXp6RmxSZVZ0?=
 =?utf-8?B?WEcrU2l5NnRwM3M1aGo0S2J2VSs4c1h3V3VIdUJXT0dUZUF2T1YrMkJTYm1T?=
 =?utf-8?B?cG1OWlBRTnJwMVJ3bndFQjBFWlByT201aDM5QlBtbmxlQXJDZFlZNFViOURu?=
 =?utf-8?B?Qll3SllPSFNGMlV4aWpoa3hLUGhTZDd4K2c5UWRoMG55ZG5jeThZVW81TWJF?=
 =?utf-8?B?Tzg2UFdud1RQNTUzRW13VUlBcllVaW5qLzc4VG9nU3Y1TUlSeTlQYkZoZjBu?=
 =?utf-8?B?aGorVTYrMXhQSXpxT3J0L29WeE1GRWx1RHgzRnpkdDRZZWtEUGZla2txQXZ1?=
 =?utf-8?B?VDExVmJwUTRXNWdsZVZxSnFkWC90K2RJejk0bW9MTmlqcW0rbXhBMmJVSHRv?=
 =?utf-8?B?ZEh0dGpHOHZRYmZ2dnBxU1RGQzhDL1FuQ0g3UVlKRzBNVU5UMjFFQldJeXJM?=
 =?utf-8?B?MjBVR1Z3RDBTRFNjbE5kSWV3MjFyK3hoM1ZEVDdNaGVKZTVUc2NrM3Z4NS9I?=
 =?utf-8?B?Zkx3RnJZWXE4Y2ZwcFNHaDFzMFNUc3VIMyt6U09FNEJXcDZpN1VrTmg0N3JZ?=
 =?utf-8?B?ZEZzWjluMFphNTgyU2J3UGlHMHRHLytORWprYzlveTR6YjZhUkRPQjZGS0Fn?=
 =?utf-8?B?UUE3Zm9JOE1uWXl5YXYySStmVytaTkQyTEpkektSbWNwSUFMU3dORkFQR005?=
 =?utf-8?B?UU5nUmNZeFlqRXpCRmszNngxMXI5MElSeERtRFJUS2Y2UC83QjBBQnN4bFk0?=
 =?utf-8?B?Ykw5NGdIZ1I3OW1Jc1g3TWI3ZjA4QkJsOWZ1VzBsZXZWZXljakNwUVM5UmdK?=
 =?utf-8?B?L2JWM0d6UU9GdjNJMVA1WGtYVjU3ZXhDSXIzUXU2KzFjYmZtSGxyZXdxTjNi?=
 =?utf-8?B?Nm0vSFQvcmpGTkZiREw5WTRFSkduanVjTTlSYTdOWmw4Q095NlZEYzdBaHZr?=
 =?utf-8?B?ajhXdXRkSXo3WDNMMHh4S3hBV0RLK0lCaURobDJNR0tCY093S3NmZDhrbkE0?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eb256f-65b7-49f8-2348-08de3d5ddc68
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 11:17:27.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiz529foHG8qgkPtETwgdkRkNsYm+I/mfEfWDHEHFGDBlcgcrbYLOT+30CrTVcx/YXpd5W4++xiSERLiLw+78V1Od/OHYvGNTdfqiz/80JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
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

Hi Johan,

On 12/17/25 8:59 AM, Johan Jonker wrote:
> 
> 
> On 12/16/25 12:26, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I believe (hope) that the new SoCs should now have this fixed and not
>> require the "hack" implemented in rkspi format which almost doubles the
>> size of TPL+SPL (idbloader.img).
>>
>> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
>> to the DTS setting the mkimage format for the SPI's idbloader.img to
>> rksd explicitly).
>>
>> Since I do not have any board with a bootable SPI flash except on RK3399
>> where this work-around is required, I simply invert the logic by having
>> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
>> that did. It doesn't mean that the SoC actually requires rkspi format,
>> just that it's been the case until now (maybe because nobody tested).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>>   arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>>   arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>>   arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>>   arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>>   arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>>   19 files changed, 157 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
>> index 2f726b0aaba..7385de7d6ae 100644
>> --- a/arch/arm/dts/px30-u-boot.dtsi
>> +++ b/arch/arm/dts/px30-u-boot.dtsi
>> @@ -27,6 +27,18 @@
>>   	};
>>   };
>>   
>> +#ifdef CONFIG_SPL
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
>> +#endif
>> +#endif
>> +
>>   &otp {
>>   	bootph-some-ram;
>>   };
>> diff --git a/arch/arm/dts/rk3036-u-boot.dtsi b/arch/arm/dts/rk3036-u-boot.dtsi
>> index 41ac054b81e..988287e2f12 100644
>> --- a/arch/arm/dts/rk3036-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3036-u-boot.dtsi
>> @@ -4,3 +4,16 @@
>>    */
>>   
>>   #include "rockchip-u-boot.dtsi"
>> +
>> +#ifdef CONFIG_SPL
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
>> +#endif
>> +#endif
>> +
>> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
>> index d99db7853b5..4272bf4a8e2 100644
>> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
>> @@ -3,6 +3,18 @@
>>   #include "rockchip-u-boot.dtsi"
>>   #include "rk3xxx-u-boot.dtsi"
>>   
> 
>> +#ifdef CONFIG_SPL
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
> 
> I think that we shouldn't add extra functionality to old SOCs that nobody is able to verify on real boards anymore.
> Just skip this for rk30xx/rk31xx except maybe for rk3288 if someone still has hardware.
> 

I'm not adding extra functionality to old SoCs, it's already there and 
I'm just moving stuff around. See the discussion in the other thread 
with Jonas and the last paragraph in the commit log. This is a zero-sum 
patch.

Cheers,
Quentin
