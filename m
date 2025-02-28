Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D982C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD52680FF2;
	Fri, 28 Feb 2025 11:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wLZ5ZS0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D3D807D7; Fri, 28 Feb 2025 11:55:14 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FDE811E0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBcNVDcHXelbO0wsP6FqTu9f605pU0S+BglAuzO6cZZ3IG3y9I8BMy+l77l6zfT4X7SABKnvU9LNAXQawCJCIx4ya8RJf4jx8cdxxw0OZk9sCO5xuC9fUACAEpoD96NyHb6TOQkVnPMVcquq16JVYo3QDAaF8pk5PY75gkyRpPxjSfS5ZMoe2HagkWE/zt7D1oG1S/EtFEhr9wAL6Cu/NAlpHjo1BVxHFrEj1y6yk2jmURX/8g/KRQaLQX7gZru5+fihwbAD4BFRl0+Wu1BC2fcJpICJvXcXk8KdnWJ3Qd6KIY4Dsp3WsVRwPnyC9m9ll4ExNvxGv2JqcQsLghpKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSnL/iQIbYrwOwF+4ROgujtIlhV2jVeejcdY7hRn4qE=;
 b=EJKM3l4mFxDF/25hVeh/Cb+jPPcexOaCX2+qtJNrdlTG4bdYLfJfnz7MgNuGs7obU107yD0GycgZXIIfWOI4ITlsv0GU7knK3narT2cpidJhpTHrkh2sKecdlTVnQiA7EZRa3FVPFZRnMe6F6g4vk5O5yeLUULuq6jAfhoMeMg1Cr5ndhpy3dYKdLRN9kafCyC6w22ETmSACV6oFixKMR7BOn60kU3Yr112IpuAa4dmk31vdfpSm/NjZ//S+KoUUmrychbLg5jwa97SD6fmhwsb7uAHpv9dBlaB/kGfxgkYUUOJLHuHQ/YLQM5j5zxE6sX/C7NUcP06d/rAg0Z51Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSnL/iQIbYrwOwF+4ROgujtIlhV2jVeejcdY7hRn4qE=;
 b=wLZ5ZS0BXmdfFvtb/mciz/5JFWfgjECA2o0jSKs4krYEuzjliO9jXMHiyQ7ZGhJgHwCmiyg8DRjoNGUxv7uO2crbzq3YleFW8d+ODG3tDpq1AB7Ibm0jzPcREQ3ikREcYOdR9U0dWKnZUw+1v+IrriuHCTvPWikYouTGdFeers8yYuHFHJRY5RCj8axslSmfZpPIUMz9cPNY5zsxaflxX0nZ1GfmJXhMIHU0sF1/sNyRPcFmqoGV4n6ASKVbveq2D8ruHNxTOK+qLcK0+EjNeq+sFNEWspk5OcQpV8qDtBNA8CP7kZu/YO5B0hsLLZ/xhpHYhIArLuF9LENOklpyCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:55:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:10 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:00 +0800
Subject: [PATCH v6 09/20] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-9-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f1819f-2948-47e9-8ee4-08dd57e65edb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDNOV0grTXQyZ3k1S0w5amkweVJoTnJoOEYwTS91VXVYV0NicTJ4WmR2WFh0?=
 =?utf-8?B?aUh3dFZKZmpVM285YkZiSHc3N3FuM1gvMVZ0RXRmQzZDTVdmUDA5NWdxNlE0?=
 =?utf-8?B?UnA2SzhOeU8rbHBMSko5RGE2NUIrWGRWRkxxWEJkekh6NVJNbHZwVFZ6VFVE?=
 =?utf-8?B?bldqdUZtbkNaajcrZ3FuaEFKTTV5Q1VFNXJMOFkzTHQ4WkpYcmVkckxlTG1R?=
 =?utf-8?B?bEwyK0g2dHN6RGFVbU9JMlRDUG1VekpSK3VDN1pLTi9aRmU5MkFwS2MzL1pR?=
 =?utf-8?B?UjBYeWlXbTNCa1g0THAxYkZxcFpiVVp1TG16Mk95LytKS1RLQis3UHBzTEJ0?=
 =?utf-8?B?SWR2UThJK0RNQlZFZXhVc2NYOUtxaVlUYWJvRUtURFNmSXRBUVdibXRCUEZJ?=
 =?utf-8?B?aUtYdFg1dTFoVkdaKzEwMlYxM2IyeFlXVCt0Y1hxQ0pnNUtPdFFCZnRFMDd4?=
 =?utf-8?B?enBiTW9ZTE83R1BkUDY1NTgrSCs3U2NIWWVkU0kvN0t4dU1XcUNST3BDUzc0?=
 =?utf-8?B?cERHSWloZTVvYjA0OUZmc3hHcTRFcVF5ejFSRUVDQjVDb0ZaWnd3WlRCSEln?=
 =?utf-8?B?bktwanJLZnZvNEhSdkpUdlpyMCtoVURtdW1uclFmc25sR0t5M25YRVpMR0Vz?=
 =?utf-8?B?KzFXMXFpQ0FKOVhKaVlEcFBpNW9SWHBxK3MyancrUEVuOTJYT0xCbXVZR1F3?=
 =?utf-8?B?UEtRTE8vc3VlSkNXejh6TmN4N1RmUGtJY2J1eEdEdUQ2djJtWHdiaDlXQS9M?=
 =?utf-8?B?REVPdjlzOTBvbVYvV0V4a0hkRnRCdEdSMjJSbE1OTHE5ZVZrRjIreHdwemF6?=
 =?utf-8?B?N2U2dWdmcG9admRzd1RuTUxkRThuN3BJK0VOdjNKNGNqYkFPT1FaZE15MUc0?=
 =?utf-8?B?V1daNm5yNjhmMWZvNVZ5eWN0YWNNaHV4Q0o2c1JvZWdUbGczV09vdklzVGRL?=
 =?utf-8?B?MXhtTXo5TWNMSVBSRmVGbEZFZ2d4dkRoeVZtZXRtb3B3S0x5SFd4SzU5aHk0?=
 =?utf-8?B?TWM1MzlGYVB6SFh4L1hQbVZwaDNDZ2NlcDkvbmVIdFNkdTNQYm9DSUZ5Y0d1?=
 =?utf-8?B?em5UYVlGS3lCTW1wVk9ONG1YZ2FmN1lzVTI0VkFPeUp1SkVkbE50RmxvZUZp?=
 =?utf-8?B?S0ZJMGpLWStBYXFPWisyWDZHWDBNWFBsUUFaNExPSmV5UWZ5YWVvSjBxYUJi?=
 =?utf-8?B?SmZuWkpQQXpud0tCdFhRVkEwTnI4ay81d3ZydHRZVndPT1QxRFhrMCsvSlZJ?=
 =?utf-8?B?SXFoU2JSbVlyUUZKaElBWitTTWtEV0paRHo4UEZnZVNEVHdKd096bmV1K0FE?=
 =?utf-8?B?YmxYMnVNL0Y2amxWRlpLM0YxS2R0TnBCdkp0NUtrdXVxSEppSTM1cjB4bXMx?=
 =?utf-8?B?UnhzR1JVMTFpY2VrbkkvbGsyVTFxUXRLZ21lK0I2OGlVMys5eHBYcTJ4YzB5?=
 =?utf-8?B?ZTVYb3puNFhXbzNSTGU2dkJCME5uVlQyRG9CUlNBcUV5bVdpMC9PZENzUnR4?=
 =?utf-8?B?dG9UZzFJZ2RpdElodzZiVnpCQklvZG1SU2lteTR3RXRVVFBzNXB2V1hrN2pR?=
 =?utf-8?B?TXFFWUdBR2dHeFJyMWFTWmFpS09mdjBEVXlwWkErZm1pOEY2T0lSam56QlFY?=
 =?utf-8?B?REZjaVQvNy9HaE5OSjlRR0g1V3BIb0VtVjByRHdtUlNZN2wxTjdoeUtYVTV4?=
 =?utf-8?B?ajM0cFhuZjNudWxVRllEdWRqQXErMEZxQXh1NUFocU1JaEJZa0RnZXYyS01B?=
 =?utf-8?B?WXJNRjRNQndISVNPZ2FJTm9NWG1aczFNMUhTeUh3Zi9FU1VJOVc2WGcwUWV2?=
 =?utf-8?B?TS9pZHEvY2s3elkvSk5KZWxJK0VpcjJIKzlVNkJrU3liYUpBV253aTR1QUE5?=
 =?utf-8?B?SFltNk9RU3I0VzJ5NFdiNmVKTkk4NmJIem1keS9oOW82MjUvckpMTHVjSDJS?=
 =?utf-8?B?dzFIYmhHOGdQSGZmdUZ3elZUc3ArQmtpSTE3d2kwT0kzeDJ0YWVYaTVzQ0JU?=
 =?utf-8?B?L1RXNFFjMklRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1tNFhBYzRtelpqdnMzM0FvMHVwT3dVR1c1cWJVRkVZVUlrMDRNYzhiTE5q?=
 =?utf-8?B?Mk8zU0hHeXdKTkxkY2p3YmVZVGgyWTlRcWFjazkwajdkOXpzRERqVWljTmpw?=
 =?utf-8?B?OWNjRFErZC9NQkZTd0prODNSQ3M0RWd1NCtoK29heDFwT2c3ajV1UlJIOTZF?=
 =?utf-8?B?ejdxUW5PckE4RjRwT1FCQlJzZzNreHQ5amVuRVc5dytBbGRtTXFVOW5WK0Nq?=
 =?utf-8?B?V3JtK2l3R2FEVHhNck5CNU9TcDFjN05ZaEJJV2NyWW1iTVRrZksvVlJleUR4?=
 =?utf-8?B?ajVCbmg4ZG4yLzZKZHVTRHJqWjl5WURtVkhmUS94MVRLY25ycnFIa290eTVE?=
 =?utf-8?B?cWROK2ZsZndrRWEvcU1EaXR6eFNsbzZMMlhiY3JTSTZEYXdTYXgzdHdTK0Nm?=
 =?utf-8?B?S2xYZEg5eHJPd2lpRnh5NFpYazdyekJ4MktpTDRyQWZOOUN5eWNpb0taUGlp?=
 =?utf-8?B?Q2dlbWxWbnk5ZlhGZFhsL2JEZkdmMHRBK0VwS2tldklBS2ZwSDA3TU9PZm92?=
 =?utf-8?B?cVZISkszQW4wSitjWTNib0dMVmJGbmRKOVZzM3VldWQxckdqei83UVFDWW90?=
 =?utf-8?B?cFBhbURkTTE4cjFCa0VHOE1EbUo3NTJCTVIvWlBIR0FEUGZ4M05sdm5MUXVk?=
 =?utf-8?B?dUY0Z1NhWlV4SzZya3orNEg5VVpvbUU3YllRQmhHNWI4TFoxeVluM0k4NkFO?=
 =?utf-8?B?V2xpYVhFUUpmNlRNUkdsZktUVFdlZzVrRmZVQ3lxRmxuWVM5ZEsveFRadUFQ?=
 =?utf-8?B?eE1wWnZsRDhKQTNZR0VDN0F5SDB1TERaY3JueGF5TXBhN1VIdXJYVTJFVy96?=
 =?utf-8?B?V3JuWlZVK1ZBSFdSNHJwTkRHcWVZSFFoWHE0blA2UU04aUEyeDI4enZTU3dY?=
 =?utf-8?B?MVFBM2JpSE5jWmNwYkhtK08rUEIxby8xdzVmZ2hXZFNoRUNyWVVPRjBoT0ZS?=
 =?utf-8?B?QkwvTWNhNzk3ckJQZE9GT2hETWhQcGd3bDdCdzFKRnUybmxQT3RUMTI3dXE3?=
 =?utf-8?B?WlBQaHlRMnZnUzJ3czhMTmxxdExqL0loeno2SnFaTmczK091VTc4RVBqK3Q5?=
 =?utf-8?B?L2dNSEE2cDdkN3I2WlZwaVpGbHZqcVF1US9kSW52dWNUZytuVDJxNTJoWWlP?=
 =?utf-8?B?bHFLem5SL0h4aG95MHdESm5CQmNLbUg5eElEYTh4czJOMmVFM3BOTHl5am1V?=
 =?utf-8?B?VVIreWxFalpOVEh6bFBHallOWGRzL1dHdG1UQTR3cXlubHNYSFcxQzM2YlFk?=
 =?utf-8?B?MjFRaWFpR0V6SnFmNkFMODRoZkZLZ3hlbmdxRElZaTFwSGwzYzlNY1R0eC9a?=
 =?utf-8?B?ZTdkN3h0V1BVMmpoZm1XQ2o4OURFSll5NDFPYnRpVnV6YVJpOUpORm1IamRS?=
 =?utf-8?B?Q0hDYkhPL0txYUJodzVjZUNiZFEzMzRsRTZoNFR5TTV5UXlsUGQ0UzAyNjRv?=
 =?utf-8?B?aWJPM1c2MWRxRXdhanlwbWJxS1NjczZNNUtYZmpPMjhUQSsrcEl2NE93a3ov?=
 =?utf-8?B?L1lPNFZ1bURqUDF3dmF3QXBKWU1LKzAwN3lGTnNYQWcwUUl1akplT29RS2VZ?=
 =?utf-8?B?QjlUUUVjRGxpSU1Ca1MrcWxzWGU1VEFCblBJa1l1dEczcEozdjJidmVoeXhL?=
 =?utf-8?B?bzhFeXFLMi9xOTIvdVFBN2I1MVNUV1QvNitKZjZKcjByYUVzRXl3NStFTTQv?=
 =?utf-8?B?UitOZ2p5SmF4L1RMc2FWamNWMmlQR2N1UldrSHFPQjFwbHJCZUFEa090Q3JG?=
 =?utf-8?B?VXpoVFpBZlIwMmxUcG1FM2FFUERPTThyYnZCVFR5Zmp6TkE1NE5wTHFLeXNN?=
 =?utf-8?B?OXZ6ZHVxTG0wS3hKOXRHME1SQ2pFS0Z5V1BaanBQa29RVGliL3I2YzNheUJl?=
 =?utf-8?B?alBKemJGd043dytVUVg1Yzk4TmtmWXZvQTlkMmV2UnlKT2JYOVcyVjVuOXoz?=
 =?utf-8?B?TTlrcFVTdlFPSUdOUHhMeTBYempqSFkyc1Z0Nll1Zms0MEVyZ1ZxRkpqVmVw?=
 =?utf-8?B?dUhtRXVWWlA0RDUrUWtXSHI5eGZYZXBobi9BN2FWM0pRSVFWbnJmOTlOZ2RZ?=
 =?utf-8?B?czlKOFlCL1oyR1M2SmN6anF0SHdmM1Ftck1TdnNISjBEVXFNVUg0NTlhNmRZ?=
 =?utf-8?Q?padvfVVVuZu9Y/WjP6G7/r+xm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f1819f-2948-47e9-8ee4-08dd57e65edb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:10.3672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD1pfn3+7jkv7eS0pks10kICBSaqTMPSAz0DZK7xSjYYd7aIKiRtztQS1FilMWVcvhJ1rgUz9ePwlaHveeZtwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098..b30e536a35 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec4..74a87832dc 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.43.0

