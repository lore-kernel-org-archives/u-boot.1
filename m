Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748EFE77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA1C8036D;
	Thu, 26 Dec 2024 10:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC8680384; Thu, 26 Dec 2024 10:51:54 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200f::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5166080362
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacobe.zang@wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4rCvOEVV2AXCUVlOO5x9N4cTc9AxYqmadIHW3/lE1bMIoHKQUDXOIupKKrSGwUNRSQUyWUVXPPbYiTtC15JDsZ4uKFAVbXARbrMiB+qTeWLsG67hpUBdZc3QHgt//hWSlyAnFl8UL5rLb4weIKk4HNww2pD5dOWpUfAYuV5vM530/tSfxtLZMFNARaY70GkYDUn74/vQcmo8+x2qYW6dCeXPukoCV56u8HbOth1HMKBFzp3DW21+GpqDAB1BdwG3pt4cm2GleILm9UibG9brmTu2MkX0hRcXSSZWEH4McTdKEiJg0CP4bwigbC98IsJf6J+fKMEmSVYo+D/4fWe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW66TCDsaelk0wLYM2SJeOEvF0nDGhYkk41g7DjjRgo=;
 b=UcnFffXBKSeSzBkWGSe5yi+e13jL7veAD43EzmGVCuKLoWTT7b0XiALyfJD0vhSM1ijpmHx+9JvTwL97wqbAV3Fb61vQgkeq3Fze5xtwZ9yqM9+No1ON2dfC5N+Be022ci6oYULsctmCFvLQo7sy7jnObT4++5V/D/v0qyagdimksEMe5+aGqUAmXl0gURRsusfAfHaJ952L6jV744vW24c8LgQlloSJC5qVcwoWiu1qWisR6TS9ZltbJrutl/3LXO3KXR1LP15m3TMqkL+dA7K5o11KojIjDdPgZ2eMebxppiYJRpXmq3OnQGIt+wrL9APZdjbENAH2BuJ/ZojM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8285.apcprd03.prod.outlook.com (2603:1096:820:10e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Thu, 26 Dec
 2024 09:51:46 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 09:51:45 +0000
Message-ID: <c5fcba38-1cec-4658-86c0-0640cf6bdd25@wesion.com>
Date: Thu, 26 Dec 2024 17:51:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Khadas Edge2 RK3588 board
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 916400c3-b2ea-4cd3-362b-08dd2592e8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjJGbCt0MUNIREVwSmd0cDIzZ0pTVmlkeHduM3lBYitlSFJMYVI1eExtbGRS?=
 =?utf-8?B?RXFzQWJVTFZlOHcxelYwYkd2bzR5aW5wMyttaHdIOUJzNEpzSUFpYURmdXpF?=
 =?utf-8?B?U2xhak9JSjVDcXZvMFc0cVBaeUtCVWxzdXloTGhMWENWZ09UbEJmay9vd3Av?=
 =?utf-8?B?QmVjOGlNK0VhY2lsVTI0TklFbVFCNTAvNzJ5L3VQN0tBZlpQdjBqT3paT25C?=
 =?utf-8?B?b1VBb3ZxSU4xT245MzRicThCNzBhOURnTXJqUTFCM0VKQUVUVmZvT3ZpOHdD?=
 =?utf-8?B?cWNGTUxqRjdCQ0VUQkFYaElxMWgyODV2bGFTWWRicmxGS21maVgrS0ZRVlg3?=
 =?utf-8?B?Vmc5UWIxeFl2NWdKaFBOSGFRa2o2bW9EL3RZYXIxQUI1YW1EczRtSDZkbWRN?=
 =?utf-8?B?SkdxQ3Y1NElPOTRPQTd1TGVENml4cVpaaVpSdmNid3hqRGRZaTc2dkpTeGcy?=
 =?utf-8?B?RjZRS2ZjN1JHSWwySkdZdlBrWVAwT3BTSkdzMnpGejJxbUtoWFh2ZmVuQmFl?=
 =?utf-8?B?MGtMRlFKMlVtS1RtTzN3UkYvZkNpK2pUMktxZ1pLVXJFZy80bWpDaVFpWnRF?=
 =?utf-8?B?d1V5M1hUTUNVOGFvcWVBY1A5akorR1A0aklQaWFPMnp4ZkdWbTNHK2IvNFJW?=
 =?utf-8?B?UjdpR1EvQVhxSzVnS2NvUXE5T0tNMVdzeEZxZ2NWOWRPVGs0aDdRYmI3NHFF?=
 =?utf-8?B?QjR5aisvWUZBV2tSZkxzVHNJUnVoZ2lRV1JWdHJmeXk5OStMUWpyNmJOeDY2?=
 =?utf-8?B?b3FtM3Z1VU1jOVNOS2xML01XOHdadEl6SmpsZ3BDZ3VsUVBxVWk1ZFk5S0Jl?=
 =?utf-8?B?eG56RGpCZGhCc1B3eVlaYzRHaFJYUkFMMUFKenNJSTN2bFdNMWVPNmlnWkda?=
 =?utf-8?B?V2FJRUVFNDcrNEduaEp1akFndEtHdHB4MHpKNFoydkZNa0cwcHZPRUlnR1VE?=
 =?utf-8?B?NXlQUEFoS0tRcDBMY2krRnVsaUwzeGpwbFdZY1NlYldvcnFMeEhvakxaNll3?=
 =?utf-8?B?d284WVRtWE1vRVhsZ2IvckdrYWRBaGsvUy9hQVhaaThNWXY0b0QzM2MrRFI4?=
 =?utf-8?B?OWZodm1XY1BFRG5XdkxGWVlnd3dXbXlKbm9RZ3BVcHZiclI3Q3pId2x2RU13?=
 =?utf-8?B?QmZ3WmZiNGdrTWFlY1JtTWtQcnY5REtKQWkzMWV6Wi82bzlWbTVqNVBHV09a?=
 =?utf-8?B?aDJienU0bGVoOFBkM3FjUEx4Qi9penZ6bHNZamlNeFE5VzlZek1SOHRmclZ1?=
 =?utf-8?B?RXd3dENlVzJaU2xaVTJmdVAwM1N3Wjd4c3FIbUVRZmJyS2xvdTZvV0xjQjMw?=
 =?utf-8?B?UHJkZmFiVTZhc2JSYThkbVFhMGdURDAwVldxa2gzNVp3bUFWTlE2Qno4NFlI?=
 =?utf-8?B?WmYwaHFIbVh5VG5Ici95Z3k4UlhrdmNpWHhja1ZwcitoUzZDZXh1V1ZOK0xu?=
 =?utf-8?B?K3cwT1k4L0dEZWx1MDkva3NHbzR3dzBxdXFaeTdWS0d5Uk1iT0JNYXUwWnEz?=
 =?utf-8?B?VWRRbFFXTUwrb3RESjg0d0R1M3A1Vlp4dHRrbUd3Q2YwVmtWa2dDOUl4NjY3?=
 =?utf-8?B?TVkvRWVyZHlOK0dNOEZGRWo4ZjdFRE4wVHBhQXFQM3grWUI4dVgrd0l2eURN?=
 =?utf-8?B?RWxseWNBT2UzOFVDZC9XWDZOQVlkNFo1WEhKakNGWjZBYjlJODlUNU9UYkRC?=
 =?utf-8?B?Sm5NQTR1ZGhUbEppMzR4bHM3WUV6Y0dCQVpXaXJzQ20zQ05yT0NsODJzVVly?=
 =?utf-8?B?T3JONm5rMVlkeTN0bmFrZGthbjFldTJ0TUd1M3ZUMnhXdjFEUEU1TGN2aWdF?=
 =?utf-8?B?NXM3ejFVbmpsUXNRVXpmSWEyYTJUcWRQSk9UcnBseUJoMFJ0bGl4ZU8venpk?=
 =?utf-8?Q?bXRzbHF452nvg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB7001.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhWNzhvcFpJQnFGaVBOOFc0MjA4TGM1cE5sajRPV2FyTUd6UC82bVZDbWRZ?=
 =?utf-8?B?MW9Bcmw1bmU4NU9mS1NHcmI4Zy92VEVZYlZxdWQwc0Rud3F4ZmF3bXNvWllX?=
 =?utf-8?B?VUQ4MmhXVDJJN0p5SHFlK013Vkt4UEtHSG93OGE3U3BkdUUvbEhoekJvcU93?=
 =?utf-8?B?UkVONnRBNlM5SlRTNzkyemdSck4rQ1NYV3dBdk16eERWbkdxeVlyL2RKOFBH?=
 =?utf-8?B?RnJMbVArME8zOXgrc2grNFFBVlZtOGhpM3ZWQ3VyenBXbTJqZmtyb0NtSWZH?=
 =?utf-8?B?aG01ZlpYTi9CaXh2Rm1aYXJoOGg2TktwWmZPNUVnczVCZTNNNlFlNEMySUhw?=
 =?utf-8?B?T00yVS85Uy9Cbmc4eHJVUTBWbSthZ002VldRL1pxdzRNbkV1RWFZVzRXWHB1?=
 =?utf-8?B?NDBpRU9OYndnbzNYYjVSNXlvNjhBVmpTNURiZWdabGF4WHF3TFpBUnJvWkZl?=
 =?utf-8?B?bkh4TnVzbjJyVzJIUUVJWVltYXNteWVDa2g0NXd1ZEowa1I4TWJEK0pNVEFn?=
 =?utf-8?B?ckdFOW5zVUtaeWVkZ3Bsbkp4TE9XZElKM3dFanhaMi9OVDgrdlVRWEJ5RWpH?=
 =?utf-8?B?MmtoT3BaaXVJdDU2OHh0K29vaW5CeG5UNDZBVG5ENm9oeWZkZjU4TU10ZFg0?=
 =?utf-8?B?M0JObmNpbUZmQUpJQVJ6dE4wU0lmOVFRVDhxOXoxMXQ3eTl4ZUhNcTRMOTR2?=
 =?utf-8?B?ckZLQ3RmaFI2M0hKMk0xY0FIL1JqRHNRTFJsbUJyWTgvTlpCc1daVXdNSzYw?=
 =?utf-8?B?a015Mnl4eGlXRjFiZWN0SGY1RUNHYkdoeGEwQ1JKUFhCellKcTJmeDFXR0lv?=
 =?utf-8?B?MS8vaEdmQy9KZERWMTNQemQxdEV5WDhIQzZ6QnJyR1Y3eW9tZUp3NUtWUW82?=
 =?utf-8?B?cG5ybWowbFJhS2Ntdm0wd0Y3YmloZjVaZklocElISnp4UGZQcjllL3MrSDZY?=
 =?utf-8?B?ejNDcGtaYnZ3ZWROdlFhZGltZFRZSDVQbThTOWlST1lzeUNHalpBYTYrUGpv?=
 =?utf-8?B?OFdNZnBER2xaeUhoVUJzLzAxMytDLytXY0pibmp3akJYYlpIb1gvMmY0bFJZ?=
 =?utf-8?B?T1NaZzRKWW53TXpCSXh2eWRjZC9Md3ZCSklwaC9nZWhFK05VYmI2M2JFSFM0?=
 =?utf-8?B?S1luR3NyZlZrR1dubjA2RUUvT2xnZE56S0tlNnlIUTd0REZaUmhjeXRsUXp2?=
 =?utf-8?B?dThsZk5QZEFnRGtRUk42bndKdWVCWmYzaXpubFpHT1NKcUhTdnEyNDZ3ZDVL?=
 =?utf-8?B?cWloN29UUnpHc0FqUUZXcUJxQVpCVWthckR1YitQdzk3MmtrMXpBWW40aUVq?=
 =?utf-8?B?d2p2YWUzMzhiYVArWmlub0s5Szl1ZnIrcnRmZURnTzRrQ04rODg3WURjZjNG?=
 =?utf-8?B?NEVZQWhlMFB3ZTlXZ3BZbno5cG4yNGVwRDJ4eWxDOFppOGRQUk1JRFVkZE5V?=
 =?utf-8?B?WXd4VUdhbWgxaXpOWWRVNWE5TENsUXI1WVJGc0Z6elFVSGtVd0JDeUdlMnhK?=
 =?utf-8?B?VnlHSHhBTGQyVk9iT1I0OEIveXozS2VUTUltS2w5aDVLQU5uMElaRDA5djJT?=
 =?utf-8?B?R1UxdUR2UHpLZVE2Q2JydjFQbWx4MjBDWDJUTElWWXJUT05IcFJLRzU2Mm53?=
 =?utf-8?B?dllUa2FHbFRGbzZzenIyWkJRS1dGTjErNURPeGp4V1QvazdWMERGMGh2S2pT?=
 =?utf-8?B?V2ZGU3pBMTllRjBJYjVXbzBDWjR4T3JIM0xWcGYrUlQyUmZQMVNXRGUyZkZH?=
 =?utf-8?B?eW5iM25nM2hrMTB0K0dDeG1BZE9nU0VLeDBmRko1ZGlhdDQxNHdQV1Fadkpk?=
 =?utf-8?B?dlVzNHNhQ3BQeXFtY3JFVnBaeGVmbjNYRFBnYlE4RUw0RlVuQ0RLcXVTWW90?=
 =?utf-8?B?bk9DWjVVbFREdlBwVDMwNVV3WGxxWlE5Vi9rbkdzUXdEdERWa1ZrVXZlRCt0?=
 =?utf-8?B?dWp1SDBNb2l5RUJCeFp6Yy84bHVsSG94RXVHWFBvb3B2VGpFUXVURUtmdDdB?=
 =?utf-8?B?MTVmWHVWclFXa3JrVUcwdkFrZWN2ZHAwNHcxZ05YNXlsM3lBZXg5dXY5aGhu?=
 =?utf-8?B?TVl2eXRrZ0VMM3pWWklEc1RDTGNmdEtYVjN1R2xJcndjcVMrS2hhR1prY0kr?=
 =?utf-8?Q?qfqdQcnRk7nkkwbA9JphZFqpB?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916400c3-b2ea-4cd3-362b-08dd2592e8d0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 09:51:45.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep4iwpr/aDgDBFe4e+69uBJDz2KJ1RP+nkzGjC4qgQY8hT7YFqaXHQgpGD51AAscTH1c3ixXfCJTJFAhJ89q9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8285
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



On 2024/12/6 21:28, Quentin Schulz wrote:> Hi Jacobe,
 >
 > On 12/4/24 10:45 AM, Jacobe Zang wrote:
 >> [You don't often get email from jacobe.zang@wesion.com. Learn why this
 >> is important at https://aka.ms/LearnAboutSenderIdentification ]
 >>
 >> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
 >> by Khadas.
 >>
 >> There are tree variants depending on the DRAM size : 8G and 16G.
 >
 > What's the third variant :)?
 >

Sorry for replying so late, this is a tpyo error. In fact this board 
only have these two variants.

 >>
 >> Specification:
 >>
 >>      Rockchip RK3588S SoC
 >>      4x ARM Cortex-A76, 4x ARM Cortex-A55
 >>      8/16GB memory LPDDR4x
 >>      Mali G610MP4 GPU
 >>      3x MIPI CSI 4x lanes
 >>      2x MIPI-DSI DPHY 4x lanes
 >>      32/64GB eMMC
 >>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
 >>      1x HDMI 2.1 output, 1x DP 1.4 output
 >>      USB PD over USB Type-C
 >>
 >> Kernel commit:
 >> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
 >>
 >> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
 >> ---
 >> Add support for Khadas Edge2
 >> ---
 >> Changes in v2:
 >> - defconfig: Update defconfig made from upstream
 >
 > How did you generate the defconfig?

Well, I copied the defconfig from the U-boot 2017 version, v2 has delete 
some configurations that are not supported in the mainline and I dropped 
the unused configurations one by one..

So the correct way to generate the defconfig is ..?

 >
 > I applied your patch and ran make khadas-edge2-rk3588s_defconfig
 > followed by make savedefconfig and they are different enough to make me
 > suspicious of how this defconfig was generated?
 >

I run the same command as you, but I didn't see the changes in git diff. 
Maybe there is something I forgot to do?

 >> - Link to v1: https://lore.kernel.org/r/20241119-edge2-v1-1-
 >> b10c5d7626ca@wesion.com
 >> ---
 >>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 ++++
 >>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 +++
 >>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 ++
 >>   configs/khadas-edge2-rk3588s_defconfig        | 146 ++++++++++++++++
 >> ++++++++++
 >>   doc/board/rockchip/rockchip.rst               |   1 +
 >>   include/configs/khadas-edge2-rk3588s.h        |  15 +++
 >>   6 files changed, 203 insertions(+)
 >>
 >> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-
 >> rockchip/rk3588/Kconfig
 >> index b5a0e624a53..7d817e7f1bd 100644
 >> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
 >> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
 >> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
 >>                - fan controller (AMC6821 emulation)
 >>              * 80-pin Mezzanine connector
 >>
 >> +config TARGET_KHADAS_EDGE2_RK3588
 >> +       bool "Khadas Edge2 RK3588 board"
 >> +       select BOARD_LATE_INIT
 >> +       help
 >> +         Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board
 >> Computer)
 >> +         by Khadas.
 >> +
 >> +         There are tree variants depending on the DRAM size : 8G and
 >> 16G.
 >> +
 >
 > If there's a third variant, please make it explicit as well here.
 >

I will fix it in next version ;-)

 >> +         Specification:
 >> +
 >> +         Rockchip RK3588S SoC
 >> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
 >> +         8/16GB memory LPDDR4x
 >> +         Mali G610MP4 GPU
 >> +         3x MIPI CSI 4x lanes
 >> +         2x MIPI-DSI DPHY 4x lanes
 >> +         32/64GB eMMC
 >> +         1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
 >> +         1x HDMI 2.1 output, 1x DP 1.4 output
 >> +         USB PD over USB Type-C
 >> +
 >>   config TARGET_NANOPCT6_RK3588
 >>          bool "FriendlyElec NanoPC-T6 RK3588 board"
 >>          select BOARD_LATE_INIT
 >> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/
 >> Kconfig"
 >>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
 >>   source "board/hardkernel/odroid_m2/Kconfig"
 >>   source "board/indiedroid/nova/Kconfig"
 >> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
 >>   source "board/pine64/quartzpro64-rk3588/Kconfig"
 >>   source "board/turing/turing-rk1-rk3588/Kconfig"
 >>   source "board/radxa/rock5a-rk3588s/Kconfig"
 >> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/
 >> khadas-edge2-rk3588s/Kconfig
 >> new file mode 100644
 >> index 00000000000..dd7b6cd8054
 >> --- /dev/null
 >> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
 >> @@ -0,0 +1,12 @@
 >> +if TARGET_KHADAS_EDGE2_RK3588
 >> +
 >> +config SYS_BOARD
 >> +       default "khadas-edge2-rk3588s"
 >> +
 >> +config SYS_VENDOR
 >> +       default "khadas"
 >> +
 >> +config SYS_CONFIG_NAME
 >> +       default "khadas-edge2-rk3588s"
 >> +
 >> +endif
 >> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/
 >> khadas/khadas-edge2-rk3588s/MAINTAINERS
 >> new file mode 100644
 >> index 00000000000..3f16923b0f2
 >> --- /dev/null
 >> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
 >> @@ -0,0 +1,6 @@
 >> +KHADAS-EDGE2-RK3588S
 >> +M:     Jacobe Zang <jacobe.zang@wesion.com>
 >> +S:     Maintained
 >> +F:     configs/khadas-edge2-rk3588s_defconfig
 >> +F:     include/configs/khadas-edge2-rk3588s.h
 >> +F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
 >> \ No newline at end of file
 >> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-
 >> edge2-rk3588s_defconfig
 >> new file mode 100644
 >> index 00000000000..bc9e8f39ec5
 >> --- /dev/null
 >> +++ b/configs/khadas-edge2-rk3588s_defconfig
 >> @@ -0,0 +1,146 @@
 >
 > The board seems to have an SPI-NOR flash. If it can boot from it, you
 > probably want to enable
 >

Yep, it has an SPI-NOR flash but we have preinstalled a custom boot 
system in it and we don't want users to modify, so don't enable it.

 > CONFIG_ROCKCHIP_SPI_IMAGE=y
 >
 > to generate u-boot-rockchip-spi.bin?
 >

As a result u-boot-rockchip-spi.bin is no need, so I will disable the 
configuration next time.

 >> +CONFIG_ARM=y
 >> +CONFIG_SKIP_LOWLEVEL_INIT=y
 >> +CONFIG_COUNTER_FREQUENCY=24000000
 >> +CONFIG_ARCH_ROCKCHIP=y
 >> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
 >> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 >> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 >> +CONFIG_SYS_MALLOC_F_LEN=0x80000
 >> +CONFIG_ROCKCHIP_RK3588=y
 >> +CONFIG_SPL_SERIAL=y
 >> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
 >> +CONFIG_DEBUG_UART_BASE=0xFEB50000
 >> +CONFIG_DEBUG_UART_CLOCK=24000000
 >> +CONFIG_SYS_LOAD_ADDR=0xc00800
 >> +CONFIG_DEBUG_UART=y
 >> +CONFIG_FIT=y
 >> +CONFIG_FIT_VERBOSE=y
 >> +CONFIG_SPL_FIT_SIGNATURE=y
 >> +CONFIG_SPL_LOAD_FIT=y
 >> +CONFIG_LEGACY_IMAGE_FORMAT=y
 >> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
 >> +# CONFIG_DISPLAY_CPUINFO is not set
 >> +CONFIG_DISPLAY_BOARDINFO_LATE=y
 >> +CONFIG_SPL_MAX_SIZE=0x40000
 >> +CONFIG_SPL_PAD_TO=0x7f8000
 >> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 >> +CONFIG_SPL_SEPARATE_BSS=y
 >> +CONFIG_SPL_MMC_WRITE=y
 >> +CONFIG_SPL_MTD_SUPPORT=y
 >> +CONFIG_SPL_ATF=y
 >> +CONFIG_SYS_PROMPT="kedge2# "
 >> +CONFIG_AUTOBOOT_KEYED=y
 >> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
 >> +CONFIG_AUTOBOOT_STOP_STR=" "
 >> +CONFIG_CMD_BOOTZ=y
 >
 > Can one really use bootz for Aarch64 images?

Now the device use bootflow to scan all the storage then boot.

 >
 > Otherwise the rest of the defconfig looks pretty similar to the rock5b
 > defconfig so I guess this is fine.
 >
 > I'm very surprised there's no -u-boot.dtsi file though. You may want to

Now the base version I test is okay so I didn't add .dtsi as the 
required one.

 > check that everything that can be used in SPL/TPL makes it in the
 > respective DT (spl/u-boot-spl.dtb and tpl/u-boot-tpl.dtb). E.g. if you
 > want to be able to fallback to SPI-NOR for U-Boot proper when booting
 > from eMMC/SD card, you would need everything related to the SPI
 > controller the flash is routed to (as well as the pinmux, pinconf,
 > regulators, etc...) be present in the TPL/SPL DT. Nothing we cannot
 > improve in later commits though, so not necessarily a blocker.
 >

Okay, thanks for your guidance.

---
Best regards,
Jacobe Zang
