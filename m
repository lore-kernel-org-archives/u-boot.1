Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92239C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 10:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002808497A;
	Mon, 29 Jun 2026 12:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="qtJRKZ/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B07849EE; Mon, 29 Jun 2026 12:15:21 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F6E848F3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrrCjlD10SqpD/J/+8fBoEv7M+TdBhNzo0ysouEfOw13JjxKy5wqe5/71Ubz3vIc1yM/hOSW9I6brXMUmNWglFHpgMPosGxnZA+FIQopL9QQwzCgHjJi9BdtLmAMEzVrX87Wm42ZLsLHReQ2AC3NbeVl9KOc+tDM0GfnYnyRaqG844AHIe178h2Qu1+94q1OECWLkxUkvQ+nB8L/eu1OpoLHCOBjqfWpChwIFoAebiMJHUfnahFZmcsxeydT8GzMCRGOEik01iNHQExA3awI2L4nbG50uMCeAhq8we8ozIizdD+1qp4IeOGDGU497uNsww2cZkyA1mLZT9SRT7Knsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE7LY05s5Jhuro422jP0x0kxir2p+4i4I1C4/YzkP7E=;
 b=QUQWV3Q1/gFIQQkb1cSyuvFQ5PHpLa/jfHIffQrp0au7tri9jCbnjJlUik1GlmYZ8vwzaMrsHM/YqzvIZ9Maz748ce72kpATgpm3vLKvyNZzzTEoN4zbEFdLoRlzZL1X+GJGSBJwYpjdaRhLaqArqfmTDkJ9WYBh3jpDITcz72LZ/969yYSywb/ql4eAYV5w5p9dSVJVzfRNVCRoNB3XP0GV3K7+AnYLfQ0h1QL7Tcyzke/D3fJWBBDQky0jyAtc660O699MlhmuFMIgp+Hx5hhbNQahk+c7TV5cF/TnkvsXdP1urIcdXTiAFq+TahzzEdKn7YAN8VundRzjhZ9N5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE7LY05s5Jhuro422jP0x0kxir2p+4i4I1C4/YzkP7E=;
 b=qtJRKZ/1VtRnIhrFgI5CS73R0lemwrbbYy+eQRMeBeypQQ+EK6Voc6rY/tak2xO1ETmNbsrRSmLED2LxQSpFU7BxJaFRkv40TO9FklVd5jWzyd+qlGnveV7iwXV2XrJQkeUTirU+ofd2fHkMBPPBKvczz6cO6OU9ng/hAljnL0U7Zs4p0fcbI0SPZXtwqbbuntgBC1Lxlu+DJAhvpR3RmJDSzSEMkOpj/ufafbLNHFTmkDICCrMKErfnVSsCqwtlBLTh1FlZPmC+c2EXvTYEU+ysgwIKPvwU8ZJPnfhwKhPO8uog5nDJiEcoyqBqw2YNtI2wCyn/7oLM9UODq42osA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GV2PR06MB9873.eurprd06.prod.outlook.com (2603:10a6:150:27b::21)
 by AS8PR06MB7847.eurprd06.prod.outlook.com (2603:10a6:20b:3ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:15:13 +0000
Received: from GV2PR06MB9873.eurprd06.prod.outlook.com
 ([fe80::9df8:87d5:9917:f283]) by GV2PR06MB9873.eurprd06.prod.outlook.com
 ([fe80::9df8:87d5:9917:f283%3]) with mapi id 15.21.0159.013; Mon, 29 Jun 2026
 10:15:13 +0000
Message-ID: <b2a2f480-3f07-45e2-85f5-1ede50ae3efc@vaisala.com>
Date: Mon, 29 Jun 2026 13:15:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: zynqmp: DT updates
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Harini T <harini.t@amd.com>, Neal Frager <neal.frager@amd.com>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Quanyang Wang <quanyang.wang@windriver.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Rohit Visavalia <rohit.visavalia@amd.com>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
References: <cover.1782726386.git.michal.simek@amd.com>
Content-Language: en-GB
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::10) To GV2PR06MB9873.eurprd06.prod.outlook.com
 (2603:10a6:150:27b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR06MB9873:EE_|AS8PR06MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fbde58-a1d4-4f9f-c88e-08ded5c74ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PN8NF4zTyLBG1fSpCqiRasESUhd9kLqJGA2HJO4e/8dL2OGthps6E0SEEQoHhfoCVcCdppFo6yhORDKBbZTxMTu8urPnAT8QypQGY3LVutSq4owM4nhrAlAbp05lxOmzEuM+I+MGheZ/RqpB2hz8aIqsPaVtEuED7Xxw4LoND4g3LZMlRcLm6993UAmRg3rZFNi0qTL6aK542Mkk9P/HdrM6sWxRDhp4stuI+CRdd0r0PGCXbuoAhiyL3MU+ScP/U7H1ljIhTUDcrKGmFdGxuBqI8ckFlJlxQJg50NniDrutlHPF1Tr8qoTLAIhAxJfmu4RBVPzWKrRTNcmwCpd+CxQXWFgtUhTth1kPnVPf7TGdJFGbt13K4HLNMIwIwPFbxu5uKQys9mju3DhcSWtFO70lgs5QjiWp1psXX1YdihE4rjMJDOkcNo7DEJ812GXkI1rUEdMwlFgooviBkhJGigeTY3+o1aU7iaik2+pwZDsqrRq8BK1Wxi8jLZ1mYUnoYS3Gnw0pxJf4naV6TSrQdRmtMPGy/PlSuqbfqB8yJH3YVcfUYxc7DTklyxVc9csGfOeyjW/5CB1yZHWukHuKQPL51yiTTzbcllAKTpfSzkZtO2e1FeltjnOYJipOgp5ZGqd6hXkI3BwaAcpzN+1ssfDmqo6n8BBWrE/pAyIQ8ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR06MB9873.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05Dd3pBSk9sYnV1Sk1keFR5KzVhMnh1YU1FK1NqMDFrZTRGeGFLNGwyWVNG?=
 =?utf-8?B?NmF0QVdiOVhONDdrdzZ5a0RJWlNNc21aZnYwcjhENU9EZUNaWkpnNmVQZFN0?=
 =?utf-8?B?SFc4cmNmV21ia2JqWnU1T0JLQllRWFhiaU1uWG9ZWS9PQ0pBR3MvR1ZQcTJG?=
 =?utf-8?B?SlE0alpRMGhBK2dFVnZtckFSWk90bitGOTN6eUY1TUMwM2wrd3V1d0E4YlRq?=
 =?utf-8?B?ZEQyK1hyYTBoYm1lMytvRXlCaHQvdFFHY05mYldlZ1MvT1g5Y2p1aWhXUXcr?=
 =?utf-8?B?dW4vZTd1VjFueldGdHllTHAxczZkMTNxYmVEZUdhVWhHM1JkY205Q0Q3aDNy?=
 =?utf-8?B?WTFuVHNsWUNmNFR6UG1iRWdRYmVaMTBwR1lEQThGVmNheUxIQ1hqSFNoUUto?=
 =?utf-8?B?SXBydkFHN3hCZE1CVm1haUxlemg2M21oS2FzZnROZUtrT2R6WUloUnh0QmdT?=
 =?utf-8?B?aitkazFudEJ4bTJYVGlwMWlYeVd4OTZLMm1JcHNVMkNoaWhpZ0Q4VmI1STBO?=
 =?utf-8?B?QmJ2bFp3MmQwSDAxbFRYY0FCL1lLN2Z6NS9ncnRkemRxY0l6K3ZEeXVHUk9J?=
 =?utf-8?B?VFBsVGFRS1dhNGI2OCtFd2R0QzF4MCtsc084NjgxOFhXSjQyYk1sQ2FhMDVm?=
 =?utf-8?B?SlRVT1lIUUMxNDVlL1pZcjhYK1FPWUY2c2JkMjE3V21JTFp2QVplVU9jZVBH?=
 =?utf-8?B?OFF5K1haaG80cUJtUzJ1YkhWcmVEb0NSUEdMQU1BbFE3Y1B6TDBzbGFPQXdq?=
 =?utf-8?B?d3llUE9Hdk1ub0d6RFVvZ2Ewd09lZG9EVU9mcW5WaHQ2ejdlak14dHFwSTA3?=
 =?utf-8?B?Qll3b1ZKQUU5b2plNXYvYXlWamh4UWhhVjNxWmVncmxvRm5HSy9NZTNhVGd2?=
 =?utf-8?B?Rk5VNThtTHdydTgzc0tzWVU3ZHlQYW1nQXJTQy9oTGZSOVdDeGt3WFJ4Q2JF?=
 =?utf-8?B?T1NlWDg1QWJHU1hVSWJlcHFlOEFBVGZJem81WUJrRGU2by8yK1RvZUp0R0Yw?=
 =?utf-8?B?QXVRV0x5cGc3MERyc0RKZFFZc3VuRGpDWEZFTm1CZlp6QlZ6LzlPOFBBYnN2?=
 =?utf-8?B?U0pGaVdlSFZvR2ZtZUovR2twUkV6dFA0akpCQjlkd3piZ0piaEFGY3EvTDBt?=
 =?utf-8?B?dUVGcFg1eXAwTUpPSXhZamxGMXJ0NEJ5Q1g0cTJqUzRYVXZueGdONGNtQ0p6?=
 =?utf-8?B?UkZROFk4T0ZjWld2SG5HSEkwVisrNkxORDZybXY5S1NjZXluM1hFVlZlc1Ry?=
 =?utf-8?B?UTF2RFVLWE1yYWVFT1M0TXNuSzVhcTR3UWR3ckppVXIwbzhQYU5NMTFPaWtQ?=
 =?utf-8?B?ZVdPc1pQczhBM0dqODRsU1Q2djJReXdxUTNsbWd1WEsrY2k0UG1CcFRKaVla?=
 =?utf-8?B?NU50ajFGdW5EbHA4SC9YMXBtWmFDVXBWOTR0a3FVcEJqV1lRU0VJVENQaEJa?=
 =?utf-8?B?akRRa0JxQzJWTzJ1L0Y1WnYvR0lJNEVwcmIwL0tLNE1kSElJdkh5a01aTzUz?=
 =?utf-8?B?S0psUDNYN0RQTG03a0MwcHY4ZzVmalNRL1NSb0Raa3FwYWNneVR5d1dRaXY2?=
 =?utf-8?B?NVlMcGxqQkFMa0EzSGlkaTZqTGRibGVRMjd0UFIxSlpuQTl4R2N6eGM5LzRz?=
 =?utf-8?B?NFU0RkhGbG1UNlFCNkhvbGc2cnpzbW1KMk1xSGpWYTN5VGhkZjd3bFNNUUdW?=
 =?utf-8?B?alZRQytMZVpOVEVYMlErbzNLVTFpeFl2dlFWeUJuQktqaE5HN2VLaHFQcEYx?=
 =?utf-8?B?WGRVZWhUTXNiTDNpVmYwVTZFZ1BUL0hYL1JJcHpoRWVwMVJxUWpPNDh3UkJx?=
 =?utf-8?B?Y2RkYzU3RkpWWWRGL2ZaREtCZXFYenBQV1NaQTdQbzVWS3NKU1Z2d3B2RUZP?=
 =?utf-8?B?TWk5QmZxS3ZyRlNOTG5iT3dxU0RWaU9aVnpqeTlPc0FJQk8zQTZrWXF3UVR6?=
 =?utf-8?B?NzAyR0E1TGtUcXZkd0VRZURKM0RPRldvR2V6RTNTY09PYkJRYUpDNnV1WnhJ?=
 =?utf-8?B?WC9XUWZyL080M3hzK0g1Tys2bGdHOXd6bk1wVzBMNWtIRWhuaGp6MkNMNlJK?=
 =?utf-8?B?RzRwYk1LQnV2TVVrTC9hVldqNk1DT1N4OC9yV3dONU5HdlhvMG9qV096bDVh?=
 =?utf-8?B?NFdLOUtsSmFhMDBmK0RDaVkxejM4UTBrTk5QdHhxcDliT0JaVUZjclByenlo?=
 =?utf-8?B?bE5rSld0YTNXczBjcUxLTERhN1oxc0FFM0ppN0xHelkxQm5mVWZPSzNDUmdU?=
 =?utf-8?B?OXlKa0k3NkNzMlU4UmdJSVBER2U1TEw4RmJFQ0w1aTdSSVhNTE1Tb0xPUGxt?=
 =?utf-8?B?TDR0RGk5Z2g0SzFDSGVwNkNISVlId0k0K2JlVHNWMVdPc2RmRU1GVE5wYjJD?=
 =?utf-8?Q?6XD7NKFF8t87mCmc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fbde58-a1d4-4f9f-c88e-08ded5c74ec4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB9873.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:15:13.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+eFsr6hQUUsdhzv4+y9WaIvaiekwfqpZ/YGXZ+gzajRQXybxV5qYA1ZI/gnaoYeWADu3eTmNPTYGghJGwrjnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7847
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


On 29/06/2026 12:46, Michal Simek wrote:
> Hi,
>
> sending some patches to integrated the latest DT updates for ZynqMP SOC.
>
> Thanks,
> Michal
>
>
> Harini T (1):
>    arch: arm: dts: Add RTC clock nodes for ZynqMP platform
>
> Michal Simek (3):
>    arm64: zynqmp: Disable ina226 iio-hwmon nodes
>    arm64: xilinx: Add missing newline in kr260-revA
>    arm: dts: zynqmp: Fix space indentation to use tabs
>
>   arch/arm/dts/zynqmp-clk-ccf.dtsi              | 15 ++++++-
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts       | 20 ++++++++++
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  6 +++
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  6 +++
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  5 +++
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  5 +++
>   .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 20 +++++++++-
>   .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 ++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  1 +
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 40 +++++++++----------
>   arch/arm/dts/zynqmp-zcu100-revC.dts           |  2 +
>   arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 +++++++++
>   arch/arm/dts/zynqmp-zcu104-revC.dts           |  1 +
>   arch/arm/dts/zynqmp-zcu106-revA.dts           | 18 +++++++++
>   arch/arm/dts/zynqmp-zcu111-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu208-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu216-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu670-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu670-revB.dts           | 14 +++++++
>   arch/arm/dts/zynqmp.dtsi                      |  1 -
>   20 files changed, 220 insertions(+), 24 deletions(-)
>
> ---
> base-commit: 3819bbedb39a31a0f872540dac5ed6076d39c026
> branch: debian-sent3
>
Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>


