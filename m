Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E03DD358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE43F83EE2;
	Thu, 29 Jan 2026 10:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NBCUQN1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4990F83ECF; Thu, 29 Jan 2026 10:39:49 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848B883E60
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js2Z5KpadDf/EHs724v7rrqPMt/uXT2ceik+7Zy6KvbORb68HjQNaA3eZuI515JS7eOqi5JdseAbXlPm1uIrEIgasIRYrUEgGUrtaZJzgFfvfB4dB5EspbAMU8/GK46sIl8ZfbOrU/TUZXtzu4/htQ5Zdo78/JfR4I+jZRRgdxvXA6u7sij/SIZF9KNRyEWBF9drH2fLajxWBhiDuRriSXMWTa36VkWZO497GBIADXG90WIaw0JzmokGte1g8+uxQI52rChFvF2TGTwDPtGiPpqzDEJhr4cmrjpHPuZMfEPDxxmVesNohiFckQl8QqTvuua79P292J21AhpRAk0l7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcJ0p1Gtjp1W1r6qgdpEV3AfUnxoauNPmBCIQIzmq00=;
 b=q7FpW/f2Ahf569ir4peZ6Mbj7DJJaLronJ2dnTTq1MzSnAvs0VHjvTBoytnNhyE9+O33O9iiiEhg34ItxUx0u1JeLlTDU0eKIgNjuMKtaknzvRNYc0o3/0pfC8uk8fBdRQ/xK92F+tTR++o3a0D2Mf5oxcPz36tqmfbvUWRrRMoKEhDopEa4Brwr/Ip4tFn6sCXMxlCsCakLy+35n8YeRPTa/PW3HgvsLMmKyYfRtPOGA4Hckj1CmDheNOA88NKcZIvg7NVujDR9PUfktYSLrF2jUs3B96w1WJ76vF2OgvRuqMtQ7UU5/i86jeQltwbg0srntMmSutENxTXK7dHK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcJ0p1Gtjp1W1r6qgdpEV3AfUnxoauNPmBCIQIzmq00=;
 b=NBCUQN1lbJIhVht5NDWSUc4ZQbSP9vHztoiFdARXLq9RBS3X2X2PAZK7VsIAMH+a1zLSA8ONACrQ/mCPrKzpnUKnzydKJTpXRh6U5wToySJlTD5MnUWX81FiqDvuF5Yio5VdOjJOGV6bqvkjl4Y+35zktAnyyXr7mCwuNdVkAxSBQDsfCfRxKXjQ9qaSd7zeT9JYhHpaFfN4pqBK83bpNshFwj/VWDiQr4yVqR0WdULaKaHZIWBvtooroec1WbE1F9atpaGWAlxp7/+uO7q5h/TqqbFwR1kW/vJSSMP9UA6dYqn0JNXGFLCkUMHIekhLM5ToAXxyoLWa1GpKmQatMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:09 +0800
Subject: [PATCH v2 07/12] imx8ulp_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-7-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc3c845-2de7-4544-9c0c-08de5f1a5595
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTl2bDlXMmpmZFJodWlFYjZnUW80N1JTRTFGOFpKR1ZZeFg5K2dnbm9MelZi?=
 =?utf-8?B?ampoSDVXMmEvVG9SYWR3ZmRYcUg2TUxUQUtwS2M1SjdjYmJ5UUNsVmE1RExK?=
 =?utf-8?B?b1V2RDJvaTdoL1FBN3pkU2JTMXB2bVdaTW12UXNObkZMZnVWRXhENWV4OGw1?=
 =?utf-8?B?ME1Nakw1Y1VEUkZWcXpMT1AwS0xLOVZ1eFgycVMySVc0VjJmRzBYM2liRzgz?=
 =?utf-8?B?aU9DUWh3S3RsaTZDVHdMWTk4M3JPSHg1QnhLeEVNdTdFazZVcCtxUUFTa21C?=
 =?utf-8?B?VVRjcHh3a3I2TVBIckRkaS95d3YrZkYyVUgxdDFUU1h2d3ArZkFub0dBdFRi?=
 =?utf-8?B?V0ZjMGV2a2tuVjU0Q3VTYnd5eVdsTGFtZml2ZGxMTUtsck41cDExdXZTY2Zm?=
 =?utf-8?B?b1NUVzNhazFTRitXMFNrWVdUMTFHay9DSnhsMVpOQkdWZWZPaFdxYXIxdURQ?=
 =?utf-8?B?U0xBL2F3UDdpdFYxdFo2VHBMUHlrc0FsYlVvdXJrb3EveGJGb05EWVM4TGtS?=
 =?utf-8?B?dGVnMkFVeHVLUUtLUktWUTJQQnpFTDNsZ3FvK3FmTE5TcWhYTGhRbWY0LzNB?=
 =?utf-8?B?disrUlRtMGs4c1F3YWw5TFUzRkhibm5YUmN3cCs0VjNXOVhQQThyYW9pSm9B?=
 =?utf-8?B?Z2loS2Q0enJ2YmQ2bU8zMXllV3ZkcnlsMlpRazNLeFUyQ0pQNWpZNjRiS2dn?=
 =?utf-8?B?NStPVThRRThIamFidGRxOGliSzRoK3lNa3pXRzRUM0FkUkZ5eU1CSzdBNlJD?=
 =?utf-8?B?bzdXdDlHL3YxRkdiNjhlVUw3c3EwNVVoclJ0WDlwRGVMT0xNN1VFR3h0dnpG?=
 =?utf-8?B?TVVvakZHVW5jbElzMkVEWWJtbnFvbGFVQ3VIZjV3cnNVSXNuNXpQMXA3OHM4?=
 =?utf-8?B?ZERHUlRBNzdHNDVubm9BYk9rN1NTL1BMaXQ5RENtSnZIOGZWQWNJSVZTSnZJ?=
 =?utf-8?B?ck1IdGlSd005eUM5eU9lS1lGZXMvR2lHNkFmSGFIcm5Db0pEQ0xVTVZvK0dE?=
 =?utf-8?B?Witpa3VHS1F5T2Z6VHd5OUZMMHdDdTBVT0psem9PbkhRS0V1TEp0VDJDWk0z?=
 =?utf-8?B?K25QcktpMkNjUUNxQ05ZZDV5ZFBKeUpKdHlOK0tDQXVEaE55SjFoQUljd0ZZ?=
 =?utf-8?B?eWxmZ2swN2pTckZyZEtXbWt4V29YbG5ITFRyUlJYMEVNODVxSzJTNGdPQ1FK?=
 =?utf-8?B?RGNJVTBMeDNkU3VyaXJXUFFXcE4wbTg2bE1hekRueWVvZmFDcElNbnRuVDVU?=
 =?utf-8?B?UzNyOVVKQjNUaUlqckpwOG1ZQWtlOXlteTdQeldkR0YyYnhZaE1PdVdSZGVY?=
 =?utf-8?B?Z1dpTFBaSWN4UGlDb0UrcWJZMXgycjRuTkFmcDVGeVJ4WlVrYkFvTjNZZms4?=
 =?utf-8?B?YkJsUzhzRU5iSkYvUkxsTWxCMXpaVzl2L1J1UU94TFpQRkVsdGFjZi85N2k0?=
 =?utf-8?B?M29jUndqc1NoMVNtd3F3WkUrZklRaWdwYVI2WGJZb1NNOVJmSDNGT292NzY5?=
 =?utf-8?B?em5jTDQvTEJVVThmWjRxa2tIYlk5U1MzS2hrMFVqZHZCbUhsMkhjSUVRZUw0?=
 =?utf-8?B?ekNWMzdKbFpHWWxHUm0zSC9jaVRHb3hwcXN2WVVza0p1bGpOOGR6R0xCWGJq?=
 =?utf-8?B?YmVOVmhUYzAzb1dNVzgwN2ZrVWU3UzdEdXVPaU5aSHdWTmJ5MFNPaXVldHY3?=
 =?utf-8?B?T1ZZdXNEbUtHZTMwZnAvRWhtdU4vSE1QNm5hQUVsUjZrdTRWbWV1cG5zUU94?=
 =?utf-8?B?S1FianFsNXU4N1M5WXU2UEwzYVdIVERnczU1WjJUMHhQRUlJS0dyRzQzYlFG?=
 =?utf-8?B?aUM3cmszb2VOZ1J6T1RsSWFvSzNEZDhXek4rYit0VEZLMnd2UkRXdU82K3E5?=
 =?utf-8?B?NnZpaEtuSXZhYVczamQwOTB4b0I2M3dwWVZtNi90YzNkR3pMbHAyZGFybDNE?=
 =?utf-8?B?QlE3QVY0dnhweGRyaThMUGRtQTlmR0ZicyszVUhPWXpPcW5TdkUxVmI5RmhB?=
 =?utf-8?B?S3RSOG1UTWwvUG5ocUw5d2dLY01aTEZuUG1LRGJyaSttWW5rT1dRaEZZSmRq?=
 =?utf-8?B?RjgzZFN1WVB0MjQ0WXJqM01GRk40ZE96eFJUemUyL25telprM2FRTG5qdzJw?=
 =?utf-8?B?U0ZkVDRWQk1FL3dDbWVlZ2c0VlZQVFlmSmlhMjFlemJUUlltbUhrclFFL3RM?=
 =?utf-8?Q?RypWTyLW8QlJmDaHNdKrUjM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BrM0w0eUU0Z1BtYkY4cnpHbUQ3TXB3K2tOOGlJL3BtWUNBQ0Zxa2I2cjRF?=
 =?utf-8?B?bEJTbTdyMXZwMXBzVVBKUXhPM3ZJQ1pxeUM0ZEhuWXdCUG9QT3hrWldaVmdq?=
 =?utf-8?B?NEM3SWE3VFFsMVl3bzZ2QURXOHl3QWw5N3ZWKy9GS242c2o3ZGdET2hCQTl1?=
 =?utf-8?B?VnJDSGNRUlBFZVJSQzN0ZVdJc2tPeTMrdnNVSE9OdzJBaThsN1ZVRCs5b3hn?=
 =?utf-8?B?SUtiREx3UjBYYzUrQ3ByS1ZuZFZWY0tUVjFNZy9xK2xCTlZOcGJ3Tlg4QXFP?=
 =?utf-8?B?Rzlsc21NYjlFam1JaHc3dDJuMnRWMHZ5am01SHJBZVhBcHRQNGpONVlDcG12?=
 =?utf-8?B?VnhlTDNMK09oUHRNSkRCRkcwSVdpSDd1T1N5Rm0zbExIYkV4aG1tVDJYU25k?=
 =?utf-8?B?Q0lySmtWdk1xY044WUVuRFFjUzhvTFpTVTkxQnF3L1dpWHFHV3NRc1lMOUE1?=
 =?utf-8?B?bXdVMmhlU04xamZTYngxS09EaGdoU3p6MjZ5NXQwcHBJMFJtbGdlNUw2QUtF?=
 =?utf-8?B?R0VicmZlTHVPTlJBQVZOei9sZ1RIdU1vMnZ2bkpWNVZ3b0xnWFNIL0twRmxN?=
 =?utf-8?B?ZVZ3OU9BSWVXZlpZak9nUVB0SGtsbDcvYzloVFBNZ00ycDVVNGwwTjA1N1Zs?=
 =?utf-8?B?K2NyMTFYV3hPWG1tdmlaM3QyTzQ2dXR3WlRUNXlpOUZMQzVObTczamFnNU82?=
 =?utf-8?B?eCtHeWErZUdVOFYzN2J2a2pDc1FKMWMwVVBDb0V6RE4xTzZqRXF0TWNGVGdz?=
 =?utf-8?B?RDgxdllITnY2cTB4bEw3aHUzQWFJRDZHRUJsbUFENGt2YkJnUDBveFVMKzdr?=
 =?utf-8?B?VUZUd2NLYXN2ZENudUFsSEJXeVdCZWdVb3BVNlplR0N0VnNWYmYvVURzQkNQ?=
 =?utf-8?B?WDk5WTduYzA4Wm9ZSnZjVGdpVkJEdU5BS0dVVkJWNTVyUFVEOW9jS2Q4UFJP?=
 =?utf-8?B?K2J5Wkd5QlJrYlFQeThoVGdkaCtCbTI5Y0IyOFlyaHNrWWZidHpVNzMwa1Rh?=
 =?utf-8?B?QmFoZ0x4S3N1YnhhWVlROHI1TDJ5M3VIelRUcGZOWFI2cU9Rc0hLT2NQWjhB?=
 =?utf-8?B?K3M2UkxXTGkwdHdWRXJVNERYenEyUmJmeW9GcmVkcjdSeE8xdkFkWHJDd2Jk?=
 =?utf-8?B?bGd5N1NxaWZsQU5BMFByYnlTWURua05SVGNISW05TzZiQjVLRUI2KzBpUUNk?=
 =?utf-8?B?VHc3WnhNQWpOenY4Y3V1eU9HbzgwelpCT0N5TjZhWURxakhkSklwN3FMaS9z?=
 =?utf-8?B?WXhnNW8wbkNTbWVMM3d4RnBQdTQvM2toQnJ1OFNkZ05pSjJwY0RtRUNuOEpx?=
 =?utf-8?B?OWpraFNFY2p6RzIweVFhRVpxMlNZdHh1ZWFBQmFVVURzdGwzNmFzQnpGTjRx?=
 =?utf-8?B?cE11Ylp1dW16Q0VkenNNZXZRQlBuNy8wT2hIZUhHUG5hTzNJZnVrUzdvektv?=
 =?utf-8?B?dzNSWHQ4WVFtRWd5SUhuR2lNUmZGRHRtRUdqeU5rQTNHVkdmejZOV1ZmelBB?=
 =?utf-8?B?YWFrVm9pVnMxR3M3bTVXMzY1Qkt0RHlYWXRrMnFqL3o1NTgvY3UreDg2Mm1x?=
 =?utf-8?B?UHQyakoxUHoydldudFRGTWRsQXpaT3JndkVaSmJLTUVHRHh2QklTQU8wekhu?=
 =?utf-8?B?S05rbkxVcTN4NkoyK29xNy9GbEdoVXpRQVlYWE9STU9Rci9NUGdrcnUrUmg4?=
 =?utf-8?B?M2F1SnhwZUs5b25NVFV4cjJvOVVhL2FuT3ByOG9wanhTTllsRUJ4YlAxT29S?=
 =?utf-8?B?N3dPb2t2TEl2NU8vblJ4Qnp5UGZQazdNZmFlQTNzZU9oOHBJMjlSaWh6R2dv?=
 =?utf-8?B?WGM3MUEwaXpNNWNDSy9aaHAzUFRXNmdsZ0dXaFN6OXdhSkdCbkV1TndhTzFs?=
 =?utf-8?B?RnZGYzRRMGhrZlFDcnpQeFhtd3VrakNrcEx1VmprWkNneklRQ3d5aVgrall2?=
 =?utf-8?B?dDN3RjNybm1QM2I4TlVma2NyNk4rUVNyS2xyNkpVVkxXbk94d2JiZmNOeFRM?=
 =?utf-8?B?Z2ZySTdPNkhvdWoraGtTT2F0K2E3YkxHeDVzNjNkVTl4ZGhDdWtPYnFoMkRH?=
 =?utf-8?B?MzVaSkhPSzBpN0dVTzRQQXE2aU80azQ2aXJaZVkwZThjTE9pY2RjcDhtMnY1?=
 =?utf-8?B?c3prbG56L1R4ajU2eW9mbWZoenZZbGVGbzExdEFzSnIvSmRlQThTZHU3MW1v?=
 =?utf-8?B?MWhIVk5ZSXc2MVVaQ1RHVEJaMGNrREh2MG1rZERXWGw5QzgwdjJqRzBDSlAx?=
 =?utf-8?B?M3kxRnYrdGMyQ04vTURONnJZeFVJa05VNjIzQWRTNk1tWG82MExid0kvZ082?=
 =?utf-8?B?S1l1NFJNcXd5YWcxZzR4YlR1R1hFYTQya2JFbWN0aXFIU1pielVaQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc3c845-2de7-4544-9c0c-08de5f1a5595
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:44.4383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/2xHhT+jwPs7AfrWOc963psfEU6oQ0n6JH4aSOCgwEuEfyhBbHhhALNB6uQEcDxtw/sy5Hdwui1gx1GxrNYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c | 2 --
 board/nxp/imx8ulp_evk/spl.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
index 4bf77a488cc..cd17f6960c7 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
@@ -14,8 +14,6 @@
 #include <netdev.h>
 #include <asm/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #define ENET_CLK_PAD_CTRL	(PAD_CTL_PUS_UP | PAD_CTL_DSE | PAD_CTL_IBE_ENABLE)
 static iomux_cfg_t const enet_clk_pads[] = {
diff --git a/board/nxp/imx8ulp_evk/spl.c b/board/nxp/imx8ulp_evk/spl.c
index fe637077928..656c2723494 100644
--- a/board/nxp/imx8ulp_evk/spl.c
+++ b/board/nxp/imx8ulp_evk/spl.c
@@ -21,8 +21,6 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void spl_dram_init(void)
 {
 	/* Reboot in dual boot setting no need to init ddr again */

-- 
2.51.0

