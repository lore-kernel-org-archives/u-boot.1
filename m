Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B69ECDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79DD89079;
	Thu, 19 Sep 2024 02:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jyU6qU6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249228904E; Thu, 19 Sep 2024 02:15:16 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F4A89090
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eISEi9Mq+bCJg+e9FOOr7xgphcWh9bWXTuZMW4OyFFErMJB7h6MNqWZH9WrbXrREYNZC2+8YEoApLqFINRz3eP3DmVE3oGfEzM7dUTW8H9NzHvXvPQSuvzz2zRVr6QIm5dQiWf6aE/wrG1bJY2eQKHG2Zf5nXiswCEbQ+bLEubZSIym5s25YzUYJGZ57GvfDWYISl1BdEvax+yBDX34BUO74+5Z30nVNsqryjeCmxsZju2llapZV9Hgho6HBcLlh/L7+ASKM5AbiRf9jg9PtehhaFjSPJPR8dU3PRJ+/zUSEnQ8RLPQyI2HOhKquTbUUz/n96QvDVfkEpau+kgnDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soZfKGafllz89Ve0TM/cfF+bRidwH5WvN8QJ5mopvUc=;
 b=d5Xs3RaZ8pmAcFOnpc2hqMeCnL+kLTUe7ZvN92je37o6/phBJQV9x+Z8knOurrce/m40UlH9J3QMoWcBE/vXSy7l1yN4b2BXPtboa7xwLgG1jjVgKu+EM1vueMkQqHfD/+UtJxm9KVSgIBFyajG0Xi3Vxe8zO9U+ucVbHrENCZucHiBpsdx7e9Fvf+NXyi0cQOdXvm9MxxZ6Ih+93wpHuHIFwI2hSKUg55O4FtkmLe7wctBszYVDXZ3b7SxpMQvXDP431l2zlnrEO52ZZyPlpJXC3DpG4HiiSMUcX/WUHw310Xx2Mz/5TURkx6YQe7QdXwjmfHV6ZKMJ/7JrDPbxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soZfKGafllz89Ve0TM/cfF+bRidwH5WvN8QJ5mopvUc=;
 b=jyU6qU6e+dJGMddJlJTd7YGYMDTzMm27JyAIreliCl9MnBFDZpWdT9e5X8uMMUvqPMCzxqTnh62YcNjwqD3LMOlGsSabqXd2WC8I5GHZhcwoDMDm4WYVOXuAq2uZA7Lutr5lUFrOErDpi8StvfTlYmVzjEBonBIvdR2Cx2UVpayHzRfm+9AvG8WxXjpAjiap8FVjS+WLUgmmnwgRQ1r6HGSh8AcTi3H6bRFgnGdX1hNsxKZKaJwfxsEWVgy/RaLraBwSTWU48AZZI5iR6wFxjweDFJelD4dzjHvA8GsXAr+VjIWXExz6mSCgayu8PRxm60UeHaAA3xXbbqxTpGMRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:11 +0800
Subject: [PATCH v2 12/21] imx8m: soc: Drop disable_pmu_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-12-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: db8047ed-330e-4fce-caf9-08dcd8401e96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UklmUlV0azE1b2NqbWljTHNTUEJxMVc0RVpHckNoT1JOay9kZlJZNkZZNVVv?=
 =?utf-8?B?SzdzY3dIbEQvdDI4MzNZMUxSRjExelpvZUp0azVYUkI1Y2x1UkhTazdCamFh?=
 =?utf-8?B?M0pETlJGUEVuRHFFdGhXQkpaZXUvYW9xY1ZkalpLMVZtbjdOU2xwZE1pZHY2?=
 =?utf-8?B?eVpZVTNWTStpUXV3MUtJeHVoUXpFYTN4K0ZEZG9zUjNHS2hpaytkYnZTYnZN?=
 =?utf-8?B?Z3JUOUw3NmxXSjMwQmtuaE03anYxaGJienZnOExObmxSNjhyWlBaNzk0V3Bq?=
 =?utf-8?B?UkdZOWI2M0hVdElUUTZQRHJjNHphdHppK3NUZnhuYzdTRjdlWUJwM3I1aUlx?=
 =?utf-8?B?dWxkcWtBc1NVT2lLRFByd3N5eEpIcEpqSDBnVFBCeHdLMGJvTkJGdGdpSGlt?=
 =?utf-8?B?TG9SbFlkRy9xa2xBbWVMMTFsY1NkMEZmTlErUkxsMXdyc2ZaandZV2R6Smcw?=
 =?utf-8?B?cWJCa1FzZEVkZlY5eWlZQWhucUplTXR4cCt3TWdhaGNxa2FodC82SHRwSVpJ?=
 =?utf-8?B?M3UrMlBkYWlQRkltY0FHcHJBZWVJckVxWHoxbHBMTC8xRGRpWnl6cFRUUkFu?=
 =?utf-8?B?TFhOWHdlQjNKaGJKSUw1MlhNNVgrNVNsa3NydkR5WkF4SVJUbzJlRWxCekZV?=
 =?utf-8?B?bWgzZEpMSHVWWlVMd2tCSzQxTS9tUFNXTUNrVVUrRitSRWRPcEVGSGhXbGRa?=
 =?utf-8?B?aGpXaTVCUnRwZnRmYUF1WG8zL09MY0Rwa0VMWFhkVU42YlNqbDQ1elJDWW92?=
 =?utf-8?B?UXRveHh3YS9hbFJnSFppSGd5UmNLcWJ0eFpnQ1c5b3lRVmxFR2JqdXBqa1RT?=
 =?utf-8?B?Skx3R2lvSFVxQkdNOHpSQldoT1VtZElHYkxCWlFiZlFyQU5lN2xEc2IvcEk1?=
 =?utf-8?B?TjdBbHl6Z1kyTGt0L0s1bHJKTWt3NlMzakZYbXJLWlJHa2pydk5QTmRIenda?=
 =?utf-8?B?T3ZQVnJCLy9DeW9FemppYitUS0NmSktvTXBPV3FjMUd5YUZETVdaVVF6RjFK?=
 =?utf-8?B?WnNUUys3OTk2Z09uSlVUYSt1TnBiL0NQZTZyZFc0ZWRpem5yanluOEhaQ2ZW?=
 =?utf-8?B?MEhrUHg1TENvRjVIcE0vYWxQdFhDL0Fad3FMaVQ0bjBxbzJ1N2ZCL3J0NVN3?=
 =?utf-8?B?M2FpTzhLVXRMYUhJRUNMN2NLcks1UlpWeEowVmVMWWtQTDRKWGpLQ3o0UlB5?=
 =?utf-8?B?ck9oSDVvTi9BY1NFMnJoZ1ZrUEczbUs2MUpuQWVNeVUvR1NsUTNISnVGenRR?=
 =?utf-8?B?N2VjRVFTeEI4VTlPRDBmRlpWYUdWSVg0Qk5TS1UyVVZsU0dIN1ZzVXV2Uitm?=
 =?utf-8?B?MW9qd0JGVk9NakFJZVZIODZSWU45NnR5R3JLa1FIYXhVK01waXhHUFczM0J3?=
 =?utf-8?B?SmRGMXpwUXpQNHpVSzN2R1NENXZuUjlZS3JBSGx4UnhIZk1GK3lBbE9xRlFn?=
 =?utf-8?B?VkU4bnBzOE1IcnNzV1NjYUhnV2R6WXJXZ1pUam00UHF4YXVMd3lpNU4yZFRD?=
 =?utf-8?B?NUE1QUh3SHFTNkF6aGdsc3c4cU9WREoxM0dnVXBjM2E0WGViQ2FCMitwQmdr?=
 =?utf-8?B?Z2UwNUsvTWdCdCtzV2M3cGlTcTF4ODE3ZExybS9DYXRMa0oyZjdPOUdFV1VC?=
 =?utf-8?B?NnJzb2pGWkhWMXRucHdVMCsvaUxlUDltUmNHelBmS3hlNTJJZzRUMGJ3OUUx?=
 =?utf-8?B?YjcxdWZ0cWM2bUNlK0lwOUd4QXMrdVZ5dkVNR3RhWjB1SE5xZXNDWTNpVjFW?=
 =?utf-8?B?a085b1NwdXRPUWpTVWdMWkgrQTd5T0l2VVlROVVsYmVUdkZ6MWpwM3dkNlR5?=
 =?utf-8?B?NVE3WU8vRXNEYXpZY0YwRC9tVWs1U2ZzdTlESEZjVTNUMFQwd2RDakdhVFV6?=
 =?utf-8?B?Ynl2TWZkVXB0TkM2ZDRWRmw0dEcwZU5SL2ZXYnRreFBYY0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTh3SmQ3ZFZxM0lsc0NYd3BnSkJzYXpmZ2pTdVozZVA2MkRvOWZsUUxlc1k1?=
 =?utf-8?B?NGRwQitqVlNGcWxHb216M3I5aVFGcVZ1R041akgvNFAzQ3NieXhLTkhBMmJN?=
 =?utf-8?B?TTFZeWZ4bDVCdmloY1Y0eDk3V3hEU1VsWG84Z01vOWtRcTBDNnRrWWV0ZlpB?=
 =?utf-8?B?bnkwQXhGQjF2Tm9hcHk1R3JPYlVHQzlHalMwVHZXUVR5dUhRVXVVejR3L0lq?=
 =?utf-8?B?T0xSR1AzY2NEbG5xcmhSRmtiR2k5dEJQWFZ5NzlOQWVLajNsLyt2M0ZSdmRT?=
 =?utf-8?B?ZFBFZ0Z2L1VmTXRvaEdFY1F6UjVGWFRGRVpWV1hKbnNZQ0N0WE16R1ZOd1VK?=
 =?utf-8?B?VnJQR21mSG1kRmNrNDlqdWJSTmxVS21obi83emR4ZEd1RWc2OXRyb0hYOWdD?=
 =?utf-8?B?MDZGc2FWNTJ5UWc3MDRXRFc0dnRnTHoxcVpEUWl4UnNRVTRVbG5EUGsyN0hB?=
 =?utf-8?B?VnBLbUV4R1BQbUEvUldtaVhmWVZpSndwT3FZQTNOMFZFR3FDdVZpZFhUcUVH?=
 =?utf-8?B?eUxPSHczRXNHZWxtOFA3Q1JOdWR1WElOaEl3Snd1WWZ4SlF1eWcyb2h0aUtD?=
 =?utf-8?B?WDFkWUZqRzlFdjNDL2hQNW5mcXZROFVGS1lHdzhVQnlvS2xaVUUzT203RkhV?=
 =?utf-8?B?QWxOamhhRTR5RS9sc1JuTHdRNnJFQjIwWGsvUWpNcnJWVHoyYllNcFc1Njll?=
 =?utf-8?B?WVBnRElHWUdId3lucktiZ2RQM0NIMWk3UXQrOENuVEZuNXhZVzBZVWk4bzdr?=
 =?utf-8?B?QzVxR0Z0UVQ2Zm45b29IUjVKbkpqMm9kbXFUZ2JZZ20veTArNC8xdElmY2wv?=
 =?utf-8?B?enp5R1lpMk9FNnFmUVRCZ0pZU3M1V1dtald1UVhlaE5vY0VZaEt2cTdIUjh1?=
 =?utf-8?B?c2ZoZkVLK2NTTmV3b0h4SXFzVXpkYlhrcnRERHR6MTR3eUJUeDkrMHo4TE1u?=
 =?utf-8?B?UDhEelI5b2xpb3FFNjZSWklBbWttZEdIMzVmeWdyQkdFTWxFeWJJY1FUNzJ1?=
 =?utf-8?B?QWk4UGU0ZG1hZXA0TC91SzFyMEEvRXp5Z2NvQmVjVVZlZTBzdUZtVy9pQUhV?=
 =?utf-8?B?b0NXZ3psU05DL0FrTmIvbHRJc0pweTc2NFhsZXd4Zlo0bG1lTzA3cUt0QUtk?=
 =?utf-8?B?aEtqRlpJRStpanBZYTVLNlI3Kzh1UzZ4VEtib2p5ZEQ4VTVxMDZJbGh0WnZL?=
 =?utf-8?B?WnpoMGVjalMxOUEvNWJYeXBvcDlIY1NaWFNSZUJhdWRsMU9sRk1lOXoyQW1l?=
 =?utf-8?B?SE05aTdweVorLzRJWEV5cDB3Zk5rbzdkdFluZk5mS1pMYmNSOTFVMFc3b3lD?=
 =?utf-8?B?YW1Jd05nNXUyd3ptVndERDlhN2lFd05HanlYczhNM0ZzYlJFb1NaNjVwVlNn?=
 =?utf-8?B?Wld2M2Ryc1NwaEc3MHppTzh0MENNZ0xGUitNZWVORHU5Z01mcU1MYmtjOEUy?=
 =?utf-8?B?YTkySG9HaG4vaTNjNUpscUhuT3MvcUhNMng4VFF4UHFLZGJPNmRLZUU3RnZR?=
 =?utf-8?B?RnhwK2hUMmIwNmpJckpZR05weHdzNnNNM0ZZNDUrQ25PYmFxcWpvRWR3R2V3?=
 =?utf-8?B?cFc0QUdaa3M2TXJ5NHFGZWJSUkw5dnJmSjlqdTVJZWtnc3ZmSlJKajJjRzdi?=
 =?utf-8?B?KzgwNGdhbWZJWm9odnROM3FvUWgydHlEemx1bjNOSkVXVXVTV056K2R3R2Na?=
 =?utf-8?B?QW14ZDNUQ1BoakhwQ0J6aHpFVWxudTlUM3dKbWp3cWhtd1ZLaFk2OWZOV1dy?=
 =?utf-8?B?a1d3c1dJaUs0RGZRc3ZBcCtCU2RRSGlMSEc2Y0hpOURKSWVWOWU3SkIwSUtl?=
 =?utf-8?B?VmxVamFkaC9DRnRTL05EUlgrRjZFVTZTRmhKdmhhM0g0NHVBc1MrMW9XTkFh?=
 =?utf-8?B?OXo1aS9sc1RxYXZPbkdSRWVESUhwWXpqbFhoUmJ4ZjZBU3hxWWRia2dnREVF?=
 =?utf-8?B?cjZMY2xrT1JXTjNhVGF1N0pydUtZbDVVR0pna0p2ZG5PdW81YVdpa1RXa2c5?=
 =?utf-8?B?dmdxK0FoVGF2R3R3dm04ZHNBdEtZdXd4NFBKdGZnV1lzY2hzVDN1RGhhajFy?=
 =?utf-8?B?UGl0TVIvYlZnMm84RWhrdGFrSVhxNEcxKytvZjE3YVRNRWMwR2NRNkJoZzkw?=
 =?utf-8?Q?+Ok5HbmqymvE39rIOPbRJ6G72?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8047ed-330e-4fce-caf9-08dcd8401e96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:08.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps6cwq5bMU+5ZM5fJfumUM4Fqb9rREabTfADaD7udLOqopZ7l47/e+Myrj6tlRFRZSJpC479/95/T6GnmiqLUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

i.MX8M use PPI for PMU interrupts, there is no reason to update
interrupt-affinity for PMU even interrupt-affinity was wrongly added
to device tree before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index be38ca52885..9ed27b59303 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1171,43 +1171,6 @@ static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 }
 
-static void disable_pmu_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const pmu_path[] = {
-		"/pmu"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 irq_affinity[4];
-
-	for (i = 0; i < ARRAY_SIZE(pmu_path); i++) {
-		nodeoff = fdt_path_offset(blob, pmu_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "interrupt-affinity",
-						 irq_affinity, 4);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 4)
-			printf("Warning: %s, interrupt-affinity count %d\n", pmu_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			irq_affinity[j] = cpu_to_fdt32(irq_affinity[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "interrupt-affinity", &irq_affinity,
-				 sizeof(u32) * (4 - disabled_cores));
-		if (ret < 0) {
-			printf("Warning: %s, interrupt-affinity setprop failed %d\n",
-			       pmu_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, interrupt-affinity prop\n", pmu_path[i]);
-	}
-}
-
 static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 {
 	static const char * const nodes_path[] = {
@@ -1241,7 +1204,6 @@ static int disable_cpu_nodes(void *blob, u32 disabled_cores)
 	}
 
 	disable_thermal_cpu_nodes(blob, disabled_cores);
-	disable_pmu_cpu_nodes(blob, disabled_cores);
 
 	return 0;
 }

-- 
2.35.3

