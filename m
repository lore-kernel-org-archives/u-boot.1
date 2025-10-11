Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADF6CCD183
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 09:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1C983D01;
	Sat, 11 Oct 2025 11:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="khu0ijqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835C383D40; Sat, 11 Oct 2025 11:39:38 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BBA83C94
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIguhsuDP4k/bRwSunFiE8AEqyobzIjgvcdU9M+4jBVlAW6FBVXB1QTqXMfKUrtT7VOrkM2ksN8OqKOQ9mzLgIJFCu7iocM4DkB9+JX4/EQTYSTpRXascHUSYGgHCvSkcgKnjgNW/6/FjHdEUuo7DI0chL1PHzdnTM05pt1G5cMCvsY5efqdutYxOlrtnuef7TvqH2BjNgPF9XaGPbPMQPDp+DmRXSNNVvXkMVjFtVetx8ajliZkZb/aHYoqLoJe8Dsy76gBg8r1G28fNHuqxpeXQXSX8hUNhh9LULvCLxMfBB+4W2RMNPEnBh02vW25f5LS5y4eN1oaUQMDRpQ9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8Zo8sRnF4MOxxzBVn41Kg3zEwMVMzTwuTlS7PpI0Bw=;
 b=DsDhh0rP4iOkeCuozev+OiWk8OQyHyMpPw8STqerwtLjTgkDxXRoXYfNzJE1r0pfIycwjgbj1tTWUQv9b7Nx0xT2rVIiDmlM1OkndUYir690wRk4AaoSnfOBTchdk/vbcfZ8U/vcRx72SBB/r1n6xRNaNkJDsETcnchtFkBgaJaXoJP/7ceEvpMOv/+wxceDrzTKt0hyhArwl/ioZmU167PTZFmdKpW5GcNfRqIMq4AwXvfi8rzVxnmF8EdAY3Sghs+YF6/I0KD3VbsPad5olT2bvs69qAWPWTF3Wnki7ZC+11Ypey+6TspWc8fQrNdovzzAWO+11HhEqW9C4s+mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Zo8sRnF4MOxxzBVn41Kg3zEwMVMzTwuTlS7PpI0Bw=;
 b=khu0ijqSaxcMRAChEpbOz9LLI9m2RLv5XRADhmYMUG9iUtFf4poa104dAgFuOmgElQT436rUKrf9KkqkeE63N95MCV+cTMm6JVrBFPg4Ajs0gxH70AGnW2FFdo0X//US5YkT9XCJ76a0RPsoZXLz7snH4V8zyTL7keuBsUjovEmv6DDXqJdz+liheTkknjmO76ne0A0c5ne78vAywBWyuRHXYoU5aAcZRF8/5Dyuvetb0qNjRZxAZxUnCYfxD3g3Rnfexkjn394fTwlE8j7N0fTZch54Lu06ahr1JamkWRq9D0n6NEof3WtVNAG+itohDUFvXWVLH4Z3uZ3TTY882g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS5PR04MB11324.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:39:34 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:39:34 +0000
Message-ID: <ded1aacf-6b5b-4668-8231-2c44277ccb86@oss.nxp.com>
Date: Sat, 11 Oct 2025 17:39:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] net: fsl_enetc: Add i.MX94 support to NETC block
 control driver
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
 <20250923-usbnetc-v1-8-507cddbe7214@oss.nxp.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-8-507cddbe7214@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS5PR04MB11324:EE_
X-MS-Office365-Filtering-Correlation-Id: 241b230e-d86a-43d8-87ce-08de08aa15d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|42112799006|19092799006|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3ZZTXZObU50dk9MQWtibGUrSllDVkt1Y2VuM0hMMm9PM0dsbFR2V0hIRWVD?=
 =?utf-8?B?OXdPaHB5WFU3akdKK2VNVFN5bUM4V3d4L0h1Y1RHbUI1OVBVeVdSQk51QzhB?=
 =?utf-8?B?bHhBTUNMK1JlWUVUdWxYYUpVeXBMSFN5UndQaXhwZkZEWk53d21wMVFZZjEz?=
 =?utf-8?B?UGpkWXRKclNBa093M0YySGhBRkNYQVplWnQ1ZjNqcVpZYUF4UlFEQVFFdHFY?=
 =?utf-8?B?Z3Axc1BWcE5ZSnZNV1lpdHNuTWZVOTB0OHQwancwT3dwaVc4OVNBd1FpOEpz?=
 =?utf-8?B?N0VOczU5WDB1QkxoOTlMaTg5dXp4MHVRTG52N0hsMFVZOHpZQ0kwNW1ZVXVp?=
 =?utf-8?B?K0FtTVlIZHI2OWw3WTlQaDlBS21wSEYvRk4rZEZuUGdCNjV4ZUZKVnBOZEt5?=
 =?utf-8?B?Q21MVmI5dVliMGVKUnRWbzhUT21wUnp4eWRVVzlvRHFnUXNENVdJQTN0NnRv?=
 =?utf-8?B?SS8xOWswQ2ZmbUZqemZJeEZaMnJvTjhYUkQ3TFZyVTl4WWxSVkVpSFlYYlhm?=
 =?utf-8?B?dm42RlN3TmhqVk9DVE5nQ3BmT3A3M0xldE0wUzJKOW9yYmhCYmFPeGpzVC8x?=
 =?utf-8?B?ZnJNUWpGMHNIbHBrZjlwSkhOUzdTOUVaNitJd1RXbnpLNmg0RUdsYnBWV2N3?=
 =?utf-8?B?TWJWN1F2WEE2aG1OczdVOTgvcjNpV3NpNmxBR2xNWktJdTdSdVpRUlVKL2xH?=
 =?utf-8?B?dmYzWlZTbEgwT3V6RzN0dkF6bUZxbC9NN2NUa2p4amhMRC9FeW5qZXNFVEdt?=
 =?utf-8?B?QUlQTng5clk5TFdrUWNPTUp3cU9SYzE4UHFsTjRxeEtqZC9QVmpTWkVHd0xJ?=
 =?utf-8?B?WnBnNkxBUVhlc2FSY2xkVWw2MWtwWlhkU0xLUS8rVnNJRHRGTG9SSUY0Q2c0?=
 =?utf-8?B?NkhIeHdIbC90QU56bG9SZUMwNTBWT09JNEVsc0dxUDZ3NGhWRkFNekcyTkdV?=
 =?utf-8?B?eVdPdDIxZDJtbUxxMEwyWVR3MlVSTEFCcnVYNUlLTjd1c2JSbUU2MXhkUFAx?=
 =?utf-8?B?MzRVMDh3QThZemFYMW15emkrdG5tUW5Qak5HdmIyTUw3Zm16am9PS2VhdThD?=
 =?utf-8?B?Z2kzRnk5YU0xUFpkdlZoeDJZcTluSFVMclA0czJMZkFFN0g5bE9VRU1Ia1g5?=
 =?utf-8?B?TjIzQXJrTVhqSER2bXY2WVdHbmdVY1g4bHpYRWxFZ1ljODdQeDNoQTJka1dt?=
 =?utf-8?B?SUtqSGk4OHBxcm5WenFaOXhFTzl4VDI2czVjSW1EcWZYM2EvcEV2ZVNpbnh5?=
 =?utf-8?B?VldkR1VTdXVQVldUQ3A5cmZSa3hsNU5jaFlRQ2JqNDlsOTcweGZ5VStPenB1?=
 =?utf-8?B?bklETThFWGxOTnRrU2h2NFNKRm5WQm1wZFdsZmZhakVEMEw4WEROV2cwaGtj?=
 =?utf-8?B?ZEJZV2Q2eVROdWNKSFBqUUxIWTBJTmIzVHBRdUIzRzNZQjgzQkVIdkxpdG5W?=
 =?utf-8?B?TEdHOSthOThmWkNCNjE4RC9Fc0JpTnJCaUYxUndPQ21MY3FFL0s0Q1NLM3Rm?=
 =?utf-8?B?ZUxERW9WRkxnUFhaa29ETmQ1SGlHSFRKMnI1NnFJSjBnWkhmUG9TYk5WQStM?=
 =?utf-8?B?S213dFQ0ajlCOEdOa0loTzExNE01ekJ5d3JYR1lFS1RtYVU5a3Q3TGtUa0ZY?=
 =?utf-8?B?TUZvSUNqdDJvVGkwS2gydWM0dk11TERydnhVTEZLYTZBS2FHdURoS1NkUWhl?=
 =?utf-8?B?aWdRYUFWVlhsYmlDZ3RxUnFkODhrb1NlZHE3eVhxV2M1SzJsWkhGeHVIU2I3?=
 =?utf-8?B?R2dZbWV2N2JkRE1BWTJ6TnpueDlqZmRldXdXdUdHRzB3RHNxSFRIRW9RdFhH?=
 =?utf-8?B?TUVCUGZtV2ZPT1JZYnlzZ3pqd3VDd0F3RlJPZ0ROOWNSclNwZlNKYWM1aU1k?=
 =?utf-8?B?T1NvZ2Zqd1krQlAzYTRvMlEwOUx5eVdGVVFMaHZUTGlTakl2QU9pMGRhbnhW?=
 =?utf-8?B?eDVsaC91aTh5VDV3OTQyTmhLc3FWUFphWWlGY2lCZ3YvaHBHTmRRaS9Hc1pl?=
 =?utf-8?Q?fk8Ik81QqnUZjG8M6BuFVhySfnOTJc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(42112799006)(19092799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9MSFN3M2JPVzF1UjJyazlLWFY0YmlwTUxvOW9KRHVqUC9JeUJ6cWdkQ0l6?=
 =?utf-8?B?c01ZT25VajhiK3piNWJkbG53bVhPdTF2VlNNMFFwS3VoVGVmbmNXYlZiQmEx?=
 =?utf-8?B?K0Rnd3ZrYkUzeUVVUXdpRjhrRTJKM2tEMjk2MzZGdjYyVXZVaWZPZDRsYzZV?=
 =?utf-8?B?cDMvaFRiUlFXMlVRaDdBUzhRYUJVRmJOMERMMTlUT2RrRENKT0NvaE5PT2c0?=
 =?utf-8?B?OEhhbUJVdlJ4ME9jTWZidjIwYXNxYlc4TUt3QzBLZVVtNDRydUtLVC9xY0F1?=
 =?utf-8?B?K3EvU1lpZXlrMmJnRlNncThtRnVDUVZUTWNqN05JR1pCdkZobHZ3OXY3RnNj?=
 =?utf-8?B?b1E2Y2FDYTlJampXcHo0Q1JFZDIwN2MrUnNTNVBiRTBjTzd6VDJYSWIweHJB?=
 =?utf-8?B?Mk9lQ2kxZitSenNZOTVMT1Jsd0g0V3VFdGpMVkhPc1hHU0FsTC9Ld0t6eGhZ?=
 =?utf-8?B?Z2NMTm1hSTFDRDJXOXY1WDArb2tVRVV2b05Va2RXVUF0Yy93WFQrMkh6R2N1?=
 =?utf-8?B?K3A4b004Qm93ZnhPRXBHMytaMmdBYXhzajZrcmVydUJXZVJ5cTVTMFRkWGtI?=
 =?utf-8?B?QW5PdURMc0xJUGZjOFlnbVhOQ0ZCUnlwNytaOUlVeHZVRzhGcVdCR09KZE0r?=
 =?utf-8?B?b0dRWE5MMHZSbk5zYk1zcDFVek0yWEpTZWhsaVJseGRSd1hOdUFCU3psZmZr?=
 =?utf-8?B?VHdVem1mSDhmamxIZ3UyOFZhUmY0NGd1V215T3drVWtvN29iR0d5aU02Znd2?=
 =?utf-8?B?Yk1nWmluV2ZCbXo2YzRKRkNpVzFFeHkzVkhTV0VWSmdza080ZEl4cFRJbVph?=
 =?utf-8?B?Y282QWtuRFJhbjRiZHJERVMreHpwbVJpZTg4QTdCUm9aRHZ3d2FGZ0pGQzFw?=
 =?utf-8?B?dkZtOVB5ekhmc3M3Q3NaVDhHT0dVcWo4eFZXaUJmT3p5WmxmTWF2K2NSNXVt?=
 =?utf-8?B?ZXhoZzhKeEZ1ZUNiNWcrUTM0cVNJd2g5MDV5cU9PbGdMYXRVVWpOWC8rdy84?=
 =?utf-8?B?U2c4bk9yUUFVWlJUZDYyRHBQRGF3N0U4ZGplVWU0a1dmVlRXOGZSU3JWQTN6?=
 =?utf-8?B?aU54LzlTa0x6NURTTkg2M1BqKzRiMW9aSjJvM0sybC9uc2QrVzNFYjdPSlZv?=
 =?utf-8?B?UDhoYklXSUt2WWE0REdmNlNzdjB6OWY4dTJaR2N0ODZsWm9GM05KSzNRRWJE?=
 =?utf-8?B?SnI1R1YrellOeHV2bjhjN2xiY3ByNXdQQmdNd0ZDeXM1ZGJtdWZHbFhjVC9L?=
 =?utf-8?B?SmhJR2hUbEh5TTA4L09iRVJtUWlKU2MydTlidmdWYjNuaENQVWx3TlZzQitJ?=
 =?utf-8?B?K3pGRWllRHEvKythZzAwenM1aGZ0RjhYZUE1WXQ5S253UnJ0azZuYVlFZTRK?=
 =?utf-8?B?Q3NCTERiQnVwaG45aURJYUhVd1Zjc0tDc2tHbGQzTkxhREVhMjVzZzdmMUc1?=
 =?utf-8?B?ZnhxSTJQRzJtWCtEQ3IxWFpoei9nZTRZTnpaZWpnZHZiQ2tuTHVGdzFDRzho?=
 =?utf-8?B?YjR2dWFJSXJxQkJ5ZE91ZTRORnBXTm5LMW83bEd6TFY0bi9zcVBvQVNhOGF1?=
 =?utf-8?B?UmkzWHoxODdyeEg0UVhJMW9MT3dEQlRRdngyL0lac2RyRE9IUVczSndhTEdk?=
 =?utf-8?B?czVWWXkwVDFOSGNRN1pwR1lFSzc4Nk5YYWlWZit0ZXczajA5ZG10ZEpVTFBS?=
 =?utf-8?B?b1JXNW05S1VPTzlNbnNLc2xzSUxuOEY3dHhaNXhMQzhIL0t4QUladkpiR0Ru?=
 =?utf-8?B?ZC9RMExFTHRURG1pemlLRm1GV21YNkRYcTY0VkVGRXh0K1JrMC8wSlFiVldz?=
 =?utf-8?B?RGszd21UU3hrRVFralAyVXVGeEJRcWJWeG4yMXc1MDVXSFhaWWJIcStnYjUx?=
 =?utf-8?B?K3Y2WGU5ZXFCQjJRa016VUd6b0ZtR09aRjdTMkswU00yZGJoSllHR0RRWlp0?=
 =?utf-8?B?cUU0b2lyNXIxWjl3VFo4S1owcStiRXJvVlp6amUzU2I2VnFTazY0dEhkWnNF?=
 =?utf-8?B?bElPdlBxRkZkeHJCNEYwcDM3aFhWdUxsSm5BTi9EWnVzSkhxUzlWVXFSZHF0?=
 =?utf-8?B?cFEwd3pIUnBoTm5VTkNqdk11TjB6UGR3NVJ4ZXJPeVV3b2NEZGFMMHpyVjcw?=
 =?utf-8?Q?GejNkUCYoJ6qyOb9693A8+jJQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241b230e-d86a-43d8-87ce-08de08aa15d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:39:34.0260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbgG/aj5XzvgsjyXwKrTCtIpiVJl8JOUtWp3pAO3ea1zro5YdLUW00UyWu2qbfTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11324
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



On 9/23/2025 7:11 PM, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> Extend the NETC block control driver to support the i.MX94 SoC.
> 
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   drivers/net/Kconfig                   |   5 +-
>   drivers/net/fsl_enetc_netc_blk_ctrl.c | 338 +++++++++++++++++++++++++++++++++-
>   2 files changed, 333 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d1cb69f85ad..4ad226bea4f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1002,8 +1002,9 @@ config FSL_ENETC
>   
>   config FSL_ENETC_NETC_BLK_CTRL
>   	bool "NXP ENETC NETC blocks control driver"
> -	depends on FSL_ENETC && IMX95
> -	default y if IMX95
> +	depends on FSL_ENETC
> +	depends on IMX95 || IMX94
> +	default y if IMX95 || IMX94
>   	help
>   	  This driver configures Integrated Endpoint Register Block (IERB) and
>   	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
> diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
> index 46b68d3d8a4..2d705c61ecd 100644
> --- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
> +++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
> @@ -43,6 +43,19 @@
>   #define PCS_PROT_SFI			BIT(4)
>   #define PCS_PROT_10G_SXGMII		BIT(6)
>   
> +#define IMX94_MISC_SOC_CONTROL		0x0
> +#define SEL_XPCS_1			BIT(1)
> +#define IMX94_XPCS_PORT_0		0x0
> +#define IMX94_XPCS_PORT_1		0x1
> +
> +#define IMX94_EXT_PIN_CONTROL		0x10
> +#define MAC2_MAC3_SEL			BIT(1)
> +
> +#define IMX94_CFG_LINK_PCS_PROT(a)	(0x14 + (a) * 4)
> +#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
> +#define NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
> +#define NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
> +
>   /* NETC privileged register block register */
>   #define PRB_NETCRR			0x100
>   #define  NETCRR_SR			BIT(0)
> @@ -55,6 +68,7 @@
>   /* NETC integrated endpoint register block register */
>   #define IERB_EMDIOFAUXR			0x344
>   #define IERB_T0FAUXR			0x444
> +#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
>   #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
>   #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
>   #define FAUXR_LDID			GENMASK(3, 0)
> @@ -64,6 +78,26 @@
>   #define IMX95_ENETC1_BUS_DEVFN		0x40
>   #define IMX95_ENETC2_BUS_DEVFN		0x80
>   
> +#define IMX94_ENETC3_BUS_DEVFN		0x0
> +#define IMX94_TIMER0_BUS_DEVFN		0x1
> +#define IMX94_SWITCH_BUS_DEVFN		0x2
> +#define IMX94_ENETC0_BUS_DEVFN		0x100
> +#define IMX94_TIMER1_BUS_DEVFN		0x101
> +#define IMX94_ENETC1_BUS_DEVFN		0x140
> +#define IMX94_ENETC2_BUS_DEVFN		0x180
> +#define IMX94_TIMER2_BUS_DEVFN		0x181
> +#define IMX94_ENETC0_LINK		3
> +#define IMX94_ENETC1_LINK		4
> +#define IMX94_ENETC2_LINK		5
> +#define IMX94_ENETC0_OFFSET		0
> +#define IMX94_ENETC1_OFFSET		1
> +#define IMX94_ENETC2_OFFSET		2
> +#define IMX94_SWITCH_PORT2		2
> +#define IMX94_SWITCH_CPU_PORT		3
> +#define IMX94_TIMER0_ID			0
> +#define IMX94_TIMER1_ID			1
> +#define IMX94_TIMER2_ID			2
> +
>   /* Flags for different platforms */
>   #define NETC_HAS_NETCMIX		BIT(0)
>   
> @@ -73,6 +107,15 @@ struct netc_blk_ctrl {
>   	void __iomem *netcmix;
>   };
>   
> +struct netc_devinfo {
> +	int (*netcmix_init)(struct udevice *dev);
> +	int (*ierb_init)(struct udevice *dev);
> +	void (*xpcs_port_init)(struct netc_blk_ctrl *priv, int port);
> +};
> +
> +static struct netc_blk_ctrl *netc_bc;
> +static struct netc_devinfo *netc_di;
> +
>   static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
>   {
>   	writel(val, base + offset);
> @@ -183,6 +226,150 @@ static int imx95_netcmix_init(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int imx94_enetc_get_link_num(ofnode np)
> +{
> +	int bus_devfn;
> +
> +	bus_devfn = netc_of_pci_get_bus_devfn(np);
> +	if (bus_devfn < 0)
> +		return -EINVAL;
> +
> +	/* Parse ENETC link number */
> +	switch (bus_devfn) {
> +	case IMX94_ENETC0_BUS_DEVFN:
> +		return IMX94_ENETC0_LINK;
> +	case IMX94_ENETC1_BUS_DEVFN:
> +		return IMX94_ENETC1_LINK;
> +	case IMX94_ENETC2_BUS_DEVFN:
> +		return IMX94_ENETC2_LINK;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_link_config(struct netc_blk_ctrl *priv,
> +			     ofnode np, int link_id)
> +{
> +	phy_interface_t interface;
> +	int mii_proto;
> +	u32 val;
> +
> +	interface = ofnode_read_phy_mode(np);
> +	if (interface == -1)
> +		return -EINVAL;
> +
> +	mii_proto = netc_get_link_mii_protocol(interface);
> +	if (mii_proto < 0)
> +		return -EINVAL;
> +
> +	val = mii_proto & NETC_LINK_CFG_MII_PROT;
> +	if (mii_proto == MII_PROT_SERIAL) {
> +		int pcs_proto = PCS_PROT_1G_SGMII;
> +
> +		if (pcs_proto == PHY_INTERFACE_MODE_2500BASEX)
> +			pcs_proto = PCS_PROT_2500M_SGMII;
It is dead code here. We already have a fix for it. Please combine the 
fix into the patch.

Best regards,
Ye Li> +
> +		netc_reg_write(priv->netcmix, IMX94_CFG_LINK_PCS_PROT(link_id),
> +			       pcs_proto);
> +		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
> +				       NETC_LINK_CFG_IO_VAR);
> +	}
> +
> +	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
> +
> +	if (link_id == IMX94_ENETC0_LINK) {
> +		val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
> +		val |= MAC2_MAC3_SEL;
> +		netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
> +				   ofnode np, bool *enetc0_en)
> +{
> +	int link_id;
> +
> +	link_id = imx94_enetc_get_link_num(np);
> +	if (link_id < 0)
> +		return -EINVAL;
> +
> +	if (link_id == IMX94_ENETC0_LINK)
> +		*enetc0_en = true;
> +
> +	return imx94_link_config(priv, np, link_id);
> +}
> +
> +static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
> +				    ofnode np, bool *swp2_en)
> +{
> +	ofnode ports, child;
> +	int port_id, err = 0;
> +
> +	ports = ofnode_find_subnode(np, "ports");
> +	if (!ofnode_valid(ports))
> +		ports = ofnode_find_subnode(np, "ethernet-ports");
> +	if (!ofnode_valid(ports))
> +		return -ENODEV;
> +
> +	ofnode_for_each_subnode(child, ports) {
> +		if (ofnode_read_u32(child, "reg", &port_id) < 0) {
> +			err = -ENODEV;
> +			goto end;
> +		}
> +
> +		if (port_id == IMX94_SWITCH_CPU_PORT)
> +			continue;
> +
> +		if (port_id == IMX94_SWITCH_PORT2)
> +			*swp2_en = true;
> +
> +		err = imx94_link_config(priv, child, port_id);
> +		if (err)
> +			goto end;
> +	}
> +
> +end:
> +	return err;
> +}
> +
> +static int imx94_netcmix_init(struct udevice *dev)
> +{
> +	struct netc_blk_ctrl *priv = dev_get_priv(dev);
> +	ofnode child, gchild;
> +	bool enetc0_en = false, swp2_en = false;
> +	int err;
> +
> +	dev_for_each_subnode(child, dev) {
> +		if (!ofnode_is_enabled(child))
> +			continue;
> +
> +		ofnode_for_each_subnode(gchild, child) {
> +			if (!ofnode_is_enabled(gchild))
> +				continue;
> +
> +			if (ofnode_device_is_compatible(gchild, "pci1131,e101")) {
> +				err = imx94_enetc_link_config(priv, gchild, &enetc0_en);
> +				if (err)
> +					return err;
> +			} else if (ofnode_device_is_compatible(gchild, "pci1131,eef2")) {
> +				err = imx94_switch_link_config(priv, gchild, &swp2_en);
> +				if (err)
> +					return err;
> +			}
> +		}
> +	}
> +
> +	if (enetc0_en && swp2_en) {
> +		dev_err(dev, "Cannot enable swp2 and enetc0 at the same time\n");
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
>   {
>   	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
> @@ -238,9 +425,99 @@ static int imx95_ierb_init(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int imx94_enetc_get_enetc_offset(ofnode np)
> +{
> +	int bus_devfn;
> +
> +	bus_devfn = netc_of_pci_get_bus_devfn(np);
> +	if (bus_devfn < 0)
> +		return -EINVAL;
> +
> +	/* Parse ENETC offset */
> +	switch (bus_devfn) {
> +	case IMX94_ENETC0_BUS_DEVFN:
> +		return IMX94_ENETC0_OFFSET;
> +	case IMX94_ENETC1_BUS_DEVFN:
> +		return IMX94_ENETC1_OFFSET;
> +	case IMX94_ENETC2_BUS_DEVFN:
> +		return IMX94_ENETC2_OFFSET;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_enetc_get_timer_id(ofnode np)
> +{
> +	int bus_devfn;
> +
> +	bus_devfn = netc_of_pci_get_bus_devfn(np);
> +	if (bus_devfn < 0)
> +		return -EINVAL;
> +
> +	/* Parse ENETC PTP timer ID */
> +	switch (bus_devfn) {
> +	case IMX94_TIMER0_BUS_DEVFN:
> +		return IMX94_TIMER0_ID;
> +	case IMX94_TIMER1_BUS_DEVFN:
> +		return IMX94_TIMER1_ID;
> +	case IMX94_TIMER2_BUS_DEVFN:
> +		return IMX94_TIMER2_ID;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv, ofnode pf_np)
> +{
> +	ofnode timer_np;
> +	int offset, tid;
> +
> +	offset = imx94_enetc_get_enetc_offset(pf_np);
> +	if (offset < 0) {
> +		printf("Find unknown PF node.\n");
> +		return offset;
> +	}
> +
> +	timer_np = ofnode_parse_phandle(pf_np, "nxp,ptp-timer", 0);
> +	if (!ofnode_valid(timer_np)) {
> +		/*
> +		 * If nxp,ptp-timer is not set, the first timer of the bus
> +		 * where enetc is located will be used as the default timer.
> +		 */
> +		tid = IMX94_TIMER1_ID;
> +		goto update_reg;
> +	}
> +
> +	tid = imx94_enetc_get_timer_id(timer_np);
> +	if (tid < 0) {
> +		printf("Incorrect bus/devfn of ptp-timer.\n");
> +		return tid;
> +	}
> +
> +update_reg:
> +	netc_reg_write(priv->ierb, IERB_ETBCR(offset), tid);
> +
> +	return 0;
> +}
> +
> +static int imx94_ierb_init(struct udevice *dev)
> +{
> +	struct netc_blk_ctrl *priv = dev_get_priv(dev);
> +	ofnode bus_np, pf_np;
> +	int ret = 0;
> +
> +	dev_for_each_subnode(bus_np, dev)
> +		ofnode_for_each_subnode(pf_np, bus_np)
> +			if (ofnode_device_is_compatible(pf_np, "pci1131,e101"))
> +				ret = imx94_enetc_update_tid(priv, pf_np);
> +
> +	return ret;
> +}
> +
>   static int netc_ierb_init(struct udevice *dev)
>   {
>   	struct netc_blk_ctrl *priv = dev_get_priv(dev);
> +	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
>   	int err;
>   
>   	if (netc_ierb_is_locked(priv)) {
> @@ -251,9 +528,11 @@ static int netc_ierb_init(struct udevice *dev)
>   		}
>   	}
>   
> -	err = imx95_ierb_init(dev);
> -	if (err)
> -		return err;
> +	if (devinfo->ierb_init) {
> +		err = devinfo->ierb_init(dev);
> +		if (err)
> +			return err;
> +	}
>   
>   	err = netc_lock_ierb(priv);
>   	if (err) {
> @@ -264,6 +543,31 @@ static int netc_ierb_init(struct udevice *dev)
>   	return 0;
>   }
>   
> +static void imx94_netc_xpcs_port_init(struct netc_blk_ctrl *priv, int port)
> +{
> +	u32 val;
> +
> +	val = netc_reg_read(priv->netcmix, IMX94_MISC_SOC_CONTROL);
> +	if (port == IMX94_XPCS_PORT_1)
> +		val |= SEL_XPCS_1;
> +	else
> +		val &= ~SEL_XPCS_1;
> +	netc_reg_write(priv->netcmix, IMX94_MISC_SOC_CONTROL, val);
> +}
> +
> +void netc_xpcs_port_init(int port)
> +{
> +	struct netc_blk_ctrl *priv = netc_bc;
> +	struct netc_devinfo *devinfo;
> +
> +	if (!priv)
> +		return;
> +
> +	devinfo = netc_di;
> +	if (devinfo->xpcs_port_init)
> +		devinfo->xpcs_port_init(priv, port);
> +}
> +
>   static int netc_prb_check_error(struct netc_blk_ctrl *priv)
>   {
>   	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
> @@ -272,14 +576,27 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
>   	return 0;
>   }
>   
> +static const struct netc_devinfo imx95_devinfo = {
> +	.netcmix_init = imx95_netcmix_init,
> +	.ierb_init = imx95_ierb_init,
> +};
> +
> +static const struct netc_devinfo imx94_devinfo = {
> +	.netcmix_init = imx94_netcmix_init,
> +	.ierb_init = imx94_ierb_init,
> +	.xpcs_port_init = imx94_netc_xpcs_port_init,
> +};
> +
>   static const struct udevice_id netc_blk_ctrl_match[] = {
> -	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
> +	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
> +	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
>   	{},
>   };
>   
>   static int netc_blk_ctrl_probe(struct udevice *dev)
>   {
>   	struct netc_blk_ctrl *priv = dev_get_priv(dev);
> +	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
>   	struct clk *ipg_clk;
>   	fdt_addr_t regs;
>   	int err;
> @@ -318,10 +635,12 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
>   
>   	priv->netcmix = (void __iomem *)regs;
>   
> -	err = imx95_netcmix_init(dev);
> -	if (err) {
> -		dev_err(dev, "Initializing NETCMIX failed\n");
> -		return err;
> +	if (devinfo->netcmix_init) {
> +		err = devinfo->netcmix_init(dev);
> +		if (err) {
> +			dev_err(dev, "Initializing NETCMIX failed\n");
> +			return err;
> +		}
>   	}
>   
>   	err = netc_ierb_init(dev);
> @@ -333,6 +652,9 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
>   	if (netc_prb_check_error(priv) < 0)
>   		dev_warn(dev, "The current IERB configuration is invalid\n");
>   
> +	netc_bc = priv;
> +	netc_di = devinfo;
> +
>   	return 0;
>   }
>   
> 


