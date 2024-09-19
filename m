Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F85CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0C28906A;
	Thu, 19 Sep 2024 02:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mKLA265Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B6489088; Thu, 19 Sep 2024 02:15:08 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5DE89078
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB33q28jrynTMDbsWSW0D3Z0lbTlZzOlEEy4wdyNkT7LtAkNlgEB88jC8XnmB83fQsEnWI9CSi55/98+RCU+MryzNHSZKI4ZV1x0sR2p2oA8K5bTKgUz2Vyp9yI4FaEPprnWYEkRjM7EDvPBEthuf745mLUIW8GU4CiWCnSZJWXz8Y5OlsH+XX58zeAmxu8YXMqOnHl0M8FvGzcx7qSJ08owzp0vNb9AwxHTnZ4OokiFVBhkuTigIyyI0OwYvEbvzqHyN2Vb1jgDCaCW9lz3/u0s/QDYb4YqjkjleGiigp8Ma3ZN8NBcxy/FaOOwnYPC8W9FYFbrh+2FcW9Y9UD0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKTdGM7EtE2ZpzQIXOcCDbhWG7ZPl/+zF/RllvKegps=;
 b=JEjtBKxb40dKISZpdtdvWh1nafuoackMqOGjxQ1fnnaiO172sDRvA6AjXY9+sOmolWkXt7k+8A7laKAM+SLMMwL6tGmHw1wqjvregF7hf2NxO4hMIZS2Bm/MJyJwMDp6RcWpI21B/eV0UKhrlQQleeFGvlI7c6hSpUjk3uqvE6hZntPn1dA9hzDex87NvnL3KZC1jCsAGxCpvxpfSo0bo4Qqqyx3mY+XXxrdvkTFwwgnUJ7ZMAikO8bt7Q27N33ha9a1sHm5O4Agj5nqYErzW6iT3Jbg3NFU9Zgn6EyfNTXKaWs76mvx77oDHbzCQOqNmvyG6X1t1VrN1duTFMAkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKTdGM7EtE2ZpzQIXOcCDbhWG7ZPl/+zF/RllvKegps=;
 b=mKLA265ZRJebAD0QkHi7UQR978tguajHb+cnlXGKdvbQdn6v7BHjo/NI8L26qXMBQLVOz76ZjNibmYCYbmFe+XlssBvdSNCdcJMwuK1gaOy3P5jHFz+Du7qYn1m17nTs/y9cXM0liy15aF6ne2POPt4LDZnuOw6PCMoWyCFAxqVQMe6DDF76sMBhw+UNkjC2N9S19Ykobga7tZN8JFAfYtDkMb0dexTBN7K+h4FqET0uUzKT1hAhocMm/Ueuys+0khaKrvCBprYalb3bpfMXkOLt1dGYXPbXrMD/BZpKNhT6Sjs0fSPsVBP6AY73/3iHt4eVwJC2hcZU9x4nJeYdHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:09 +0800
Subject: [PATCH v2 10/21] imx9: soc: Mask the wdog reset in src by default
 on i.mx9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-10-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e62bff-28d6-4869-53a4-08dcd8401c0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDJVTTBJQ0hTaHJOMmRrZE9wZDluN1czZG5TQ3dXWEt1TW13SS9pRFZNdWMy?=
 =?utf-8?B?R3VNYzJFQko4Z2FaV2JRa2xQOWI1NlBPNWdobmVuVndjY0w5ZTdhOXNzV2Mz?=
 =?utf-8?B?UDB0ZzNuV05MOG9Db1QyM1Y2Q2luTElVd0JWQ0h6S0JZTkk5QzlLSTZnamVQ?=
 =?utf-8?B?Uk9xNExoMkRoMUxBdnVQUy80TEM1bUxDWmFINGR3dzk3OW5yYVZUQU9TNlVU?=
 =?utf-8?B?dVo2QkVLN240MDJHbkx0dHpFTDB4OWkyK1dTWlRhNXFXM3FiSXU2UmNLVWJ3?=
 =?utf-8?B?VjF1djVZaUtGVHptaXRoWnNoRVJzVDBRMjhTM2s3Rk5rQjIvSHhuRU1rc3dh?=
 =?utf-8?B?ci9VdlBLOHI2THhyemNKeXBWdE9YcjhiSlVpT0FMNHFTOUNkcFRQVHZERyt5?=
 =?utf-8?B?QmMxQlZocmFNVm5RZC9POXNONkkwMTNrdk1JTHlWUWt1bWtRU0VsaFBEQkRI?=
 =?utf-8?B?OVZMSlRpNHlFaTV1aC9jOERBUFBTQ09LWnFKTllzeHlyd08rd0p0dWhJY1NL?=
 =?utf-8?B?czNRVjg1M3BLbjFEMjdDVXRvTUpxRS9lR2pCZ0xRTC9EQ3BZQWNzNE9HMzZi?=
 =?utf-8?B?TmlCZTZHSENhUUN4dFlsS0g4dG5WMlJMdURWUE5MZkN1TGRGa0pKeFNsdmdr?=
 =?utf-8?B?anU4QVBZT2RlR2h5bVVpQUl3cWxueEVZeitJbUNlL2lUQkViRWZ2M2dRbTBQ?=
 =?utf-8?B?N0c1MkxUcVh4QktuT1U4MFQ0eENJVWcxbGduNDJ0Tlh3QWRDKy9tV3ovZUc0?=
 =?utf-8?B?MUpNS3dwVFF1elBHYnZyNGVVMWZHRUZHZ0pNdGgxMGZMSUxVVXkydGdVaGdq?=
 =?utf-8?B?ek5scktpSDZWMlVmWllCN2c1TWtSUVhQT2NDUTN2eXhEMEpGTHFiMjFaTVFY?=
 =?utf-8?B?Q05ZNzRFekVMZ2tDRXFxRTdFMXlMQlRXclNpWGk4QW80SHhKc3BYeEt2d2Jh?=
 =?utf-8?B?RmdaUzFkUTZIQnBTRXlha1IyWEFlSmcyckc3aysycTUrWVBJWGZvcjVySkNT?=
 =?utf-8?B?cVUzSTBuUFFwVWNhSFRhV0VMSExIYjZ5OXNJRFJqWUl4TWNiSWlzSjFMRlkw?=
 =?utf-8?B?WHZZekh6RzZoUm5ydjBNYnQrYW9tU2dMbiswcVZuNXAxbC9GMDMyenNnSjJh?=
 =?utf-8?B?OWhLVkZjVWNmUTlWdi93ZlVVaEprM2FUb1MxZTI3c2xDZ09TNmhsR2NvOTFH?=
 =?utf-8?B?VlNINDNScUNlTEVGNDRPQW14a2hDN3REMXJpSWMvUzR6bHdsMnlPN1I0andp?=
 =?utf-8?B?UDlPNHlTMGxsMkpyTEFhYVRyU1FkKzlva3JCR1VtcXRWeVZDZmlBSjlCMk9o?=
 =?utf-8?B?aUJJdTZ2dWFxaDQ4d1BmOXZLdG9ZZWNuMzVyenZjejUwazNFdy85bG1HTll1?=
 =?utf-8?B?eUJZV2NSblZhRUxBcmVNZnZwYUxBUHRIczliTDNDekFEMEVCc2ZJUmJaYStF?=
 =?utf-8?B?VDdjL3kvMzQyY1J4c1hkK2R1SW5Ud3J0QVhoR2hibFBJbm1aUHZaakM3ZHAv?=
 =?utf-8?B?bW9TeFJXV0IvVDNHMzBHbmsyeTdjQXhaZlhuaGhwbmpseUZVcEFQWnhVQ3V0?=
 =?utf-8?B?TlRBTHRHR2xhQWlpNWQvRWM4QU5RQ1NSNlJpRlAwdUZERXlOQ09nc2QzTndR?=
 =?utf-8?B?RmlYWGdvTGRTbm0zeHZFRFhUSzkvYWhBYTNHbSt0eXh1Q1FMOWVLQ01oa0Zs?=
 =?utf-8?B?TS9kUjRkME9Qb0dZQmIwUTFHYzlLSHNYakQvZ3FPSkNpakRLQno1bGZheWkz?=
 =?utf-8?B?cm9acnVOcTFrR3NhWmJqeFM4aS9EWU1IUVBPY0Z6MWRRYTJmc2hMZHdUeU5p?=
 =?utf-8?B?V1hLMXY5VU9UQzd4TEJWeUtoS3IrMGFBdjhLbzM0WHdENFZJeHFiUnljd01S?=
 =?utf-8?B?eHlQcWZUYmhDaVRkN3RYUi9IaFFlczJsaHdRZGZ6TmZRaWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1EZnEzakpicmlBZUlubFZZWXpETmNXMXpubmxKaG1qajNMdE9FK0pBb3lj?=
 =?utf-8?B?UTR6c2hGeFJpN3J6Vm9nWVhCT3hFODczWmdZSWdQSHFjVlYwQ3I0Vm9kaGpV?=
 =?utf-8?B?VjRyKzgvS2FzK1hIZWhhNDFPZzdVSHpPbzFoK1BlbU16ZkIxQzloTmtNQVV1?=
 =?utf-8?B?QnlQRTlsTWgrR2V0UDNhR01LQ0tkYUVZMFRNSGlkaXpiWnZiL3RjOWhvNDNw?=
 =?utf-8?B?VFQvb2V2em04bjd0RnQ0RmZRcmRKNkRma3FhRGtMd0R4cW9wZE85VmRKalRm?=
 =?utf-8?B?ZUFRenk1Q0dsOFVZaExrTnNYYy9PZjFRa1BOTlg5UVpEb2RpczRHdTY1Vnlk?=
 =?utf-8?B?WVlkMlh4QlYrbEpPUzdUQS9YZkllK2E4NTY3YnFkZitLdFdDSW9Vd2hzWmR2?=
 =?utf-8?B?NXRibG9pNEl2WDFPbFl1dVpMZDJ1TCs4VlErUHRxNVEwaTVXUTVldjNNOFBr?=
 =?utf-8?B?OEd1WGJxeHdQc2ZyZWp4ZmpZYisxcFVGOHdETUxScEZ1ZXJuUGhDbXZXdllh?=
 =?utf-8?B?aEF6UDlTRmZqeWNJVGk4dE9iM2dBbTdhTHJwSmRxTjJ3aUlocmhFZ1hsa2dB?=
 =?utf-8?B?N1BrMldvSlZZbGRsNzZNMmNRaXp1RFdYUUtBQ3JOcVRIelM0dmFwZkhFMHdy?=
 =?utf-8?B?VklBY2JvbklleFAyUDVMVlROL3Fjc3ZseWFTVnJ1RXhlNlFuZTlxVXl6SEx1?=
 =?utf-8?B?VGdlankwTXFtOXh4WURMWlRkRnYvb3JSa0lwUTJibHRldTFnQWJDemhOY05a?=
 =?utf-8?B?MklKbjVtUGFhcURyeGZOWmQxNElmRjVtaHVSM1I2b3pmTVlNWm1xTHRBWklX?=
 =?utf-8?B?T3Q4THFmOHFYcFpPbkRROVRDU1FydE9nYU5FbUdySnFnb3lFMEhxVnJFVTlv?=
 =?utf-8?B?aDBvVkZ1c0Z4bmNhT2xtelpkWTBwNWdFMzNwSGNOWStrK3l5K1NWSk92RUZX?=
 =?utf-8?B?TDR4MVpEczR6YUVIL2RFR2N2NE5peUxockszaGdOSWdvTjFFdDF3Q0Z0RURq?=
 =?utf-8?B?NWpSZUovYndsdHZIUDE0LzZoNmYyZXFEVk13MlJjdm5zRlQ5U0FZYVJSNi9n?=
 =?utf-8?B?QzFiR2tIWHBoZWdRM3dHaTBOSXJoSVkvMlVyeS9sVVcyNEN2RGZhblNQakJ6?=
 =?utf-8?B?MDdrZTBGVWdOK29iTlVRUzNwSU5MQ3NvUUhIaGY4L3Y0TEVNY1dzY0xMSDAr?=
 =?utf-8?B?TWdUTjhkcS84R20xemdKeCtWTHZNTDVEY0s1RTUyemVCeGpLTGFIT3EvaHkr?=
 =?utf-8?B?UEV2S2pkdHVRcnIxV2pSSkFyKy92bW1RZG82b1MrajFlS1hTeG8xVURjQ3dR?=
 =?utf-8?B?Skh2c1VnaSs2RVlTM2VZTng4ZUZHZE9wZHYyMTBvYkNXamE3cnJpK21YQWN3?=
 =?utf-8?B?Q2pmYlZoZjRpUlVkbW96Yjk1ZlZQSTFnYTh1RWowRnV4WTBsSkZXd0hkVktE?=
 =?utf-8?B?N3dZZlIwV0kzRjBKeHpDWnBvb2lzb0o2dEEwT0pTR0p0ZGZsREhFNW14enky?=
 =?utf-8?B?TVo3YnJEN2VBU3dXTWgvdERlMjFRZTVBTGtncllHenlsekRNVmNlTnBoTzB4?=
 =?utf-8?B?MkNZeSs2cXZvNTNRN3FiTzZBUkVWTFBybkRNY04zTFRjdVM0MzlTWnpheXhF?=
 =?utf-8?B?WFNGMTZxbUpYQ2NoenBYWmNHM0IybWlOVDZ2NzFneUJPdXhXQThUWkVqRDdG?=
 =?utf-8?B?TkdUeC9BL3dRVmdxQi80RXVLQ1FjcUUyYW9jUFhSL3YwUit0VkE1OGRCd2dL?=
 =?utf-8?B?Q1o0Ryt0ODNsYUxNdWtnMnFBTXQydVV6WXh2eElXWWpkMENRN3c5MlRvdWVT?=
 =?utf-8?B?WFJEc3F5RDFxT2puRXBIcXJjOEE1cklTYTNXSjhTeS9MYnVNZ09FQzEzMWw2?=
 =?utf-8?B?VERxcktudmptQUhJUDNaNDVwQk5NK3BPOGxtRjVXUUFFV2dudUFPeExZWFNJ?=
 =?utf-8?B?dEo4K3R6VVoxNWp5ZTZRUUJBL1hYbWIxYW5Ub1pQQ2IySmtkSVlxZUVRbEhU?=
 =?utf-8?B?clVVenZlSjI5eStzZkVGVTFwN3hIY2Z4UlhnT1dGSk5uWFU3WGZDTGg0TVE1?=
 =?utf-8?B?NG5UeUlEOW5vNkNMMTduMXV1N09Cd2ZkMmJNTzNGd1Z6R0pJbVVEeC83OHhU?=
 =?utf-8?Q?NVIoPGBKcyM6aqs3y1dgH5P2Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e62bff-28d6-4869-53a4-08dcd8401c0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:04.0932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHLX/oBdcedKcHRSJSfi5dgvtXPe6jslI4f2qVWyqm0pXH4TXRxEmUlefYVYbCbZBTn0XH3AX2hpzmiKtyxr+A==
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

From: Jacky Bai <ping.bai@nxp.com>

Normally, the wdog will be used for trigger external PMIC reset
through the WDOG_ANY pin. If the PMIC chip has debounce logic for
the reset signal, in some corner case the wdog can NOT trigger
external PMIC reset if the SoC has been reset internal before the
PMIC captures the WDOG_ANY pin reset, so need to keep the WDOG3-5
reset masked in the SRC to let the PMIC to do the reset safely.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 112773f98f6..df259c26ad8 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -240,15 +240,9 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	u32 src_val;
-
 	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
-
-	src_val = readl(0x54460018); /* reset mask */
-	src_val &= ~0x1c;
-	writel(src_val, 0x54460018);
 }
 
 static struct mm_region imx93_mem_map[] = {

-- 
2.35.3

