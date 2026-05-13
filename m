Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1BDCD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D832845E3;
	Wed, 13 May 2026 16:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HYLBL0ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F33F845E3; Wed, 13 May 2026 16:18:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825318341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQkDeTfeSgokpatevuXUINZv1t/AUXLme+qn6xqgeVMnfCD34Y9ZuCCU/9QNVe19qS5faBmcT+cvzM9d6nFWcPOuzvkQTyH+WZyC79CQmnUPf/PEyy8R5Xg7H2SzHEKLMwYpffpM7bQQe2LLem688VWJ6Qu/qQExYzfEu4Yr+BjZvxcl6q1AyzG/ryAl8ZCA+wY5B1RotjOkga90QZDKz+0GolLzWY0sCrp6qOefe065IRLitAYdh9cEYzyk4MYw9LA12ufd+E7LcR3kFjIXTMf+hIcb5tuGCul/7VAuZ41gXjjqgu7EpnxtOfeltVVMXOdh995cvTHesi/Jp4PXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLbOEuGlNb4KXiibn4icUAlaiDRZo7TMQGO6u6jy//s=;
 b=fPCKrXccVU9OlvxSenxp+nQe2U56cWTiYneUZZjKn+JhoqLPBTMU4hgkh2kFeoZrdZ1/TTq4VSgdSiBTmhHpSO6yD9VmPbESBe7bQBH2ozV4h0uDzTnA/s5jPg6ViBN/VZMpaNqkvSflZo87MUELcrkwcn0ubTmUiZXEZbTcq/mupY4Uw4ICE7T07my/J5Hn8Ja0uUD3nLp5AfWwv6cIzeRehXDzUiT2OGZw4ClopeEPJ7BTe+L54WazCdfafKZ5XLSbjPA7IsLkWq0ALIjBzfkWWSVy3f2kr9PPwlA0CC0xZYxd1Pz1hOw4kkt6gPamhaswFzA+IS1uCEwtxqBB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLbOEuGlNb4KXiibn4icUAlaiDRZo7TMQGO6u6jy//s=;
 b=HYLBL0ET4WZDPLoqCJiHG8OBim3m+WB95VORX8zOGfa7/faiAEZJ1am7tJ7JdrUuHUlzPNh8ruRMjAm7pjXWTjBC23vD5m+3puKQwin9P2Z5qLm0XgumECzeGdDNkF4n4grnRoAs6xzPIfPeA++5DKF3jHWDF2gFlzGNEAnSdDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10429.eurprd04.prod.outlook.com (2603:10a6:150:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:18:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:18:34 +0000
Message-ID: <7d1c3a1b-1a85-4adc-a294-45b3dc34108d@cherry.de>
Date: Wed, 13 May 2026 16:18:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: Kconfig: use bool instead of tristate
To: David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8928d623-f472-4f0a-90e8-08deb0fa8440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Js9rjjBDNJYhj8SqW9/6SA+Uade0ObCaSe9G7dDwvdaLioBlQAW8oXdZaZ8vGDxi6N92VUI6NKWVNFsb79UbHCPfuEdEyBdx0Y3BNMJtFu0AlGsaK4CtznwYN5/ft7lmeY07g9f3G5GorsnPtQ1AmPRLxZilCe1AMsVGPwdbOX66CoqAhoWO2UR2l1r7+L2VIqaspI0G+YXJ6rGATDRt/AuzHbzMGLSpMYBWhc4EMq8/RBVSbbRowy5hsdWJwta6aOWQvZpsvf2vf4wIPnTvFlc0Xda9+BdDwRy6+LFzgzUPX70ZsO0XC2KgHmofERaAILu1TYMQ/Y77A6J/ZRahYnEzOLKslgIBrW4uaKSJA8NNiWaN+CkAdcRfcrH8/6jqw/pZFJzC0zgXtmzYkWOUdxIYbIf/0TL2AwaqYj35gkIEInjY5DSXoCu3LzKHWB5W+FUZezhJAPGu87uQHI4gLopEqA/wbg1VeaAAVOlG7oOdWVjlIsjn/neTum+hjGdxf9jJa0uv+tuYB+TENESTKFgnDt0uhkxA8Z6UN2qFN7h3ahnMiR4NvUNYsBZUoMiguEGQfr0o+b4AgM7kdJ3Kjr/4MihnwIJ+H2YPblDwpJAOkJ7izuKE/l3iuhH4QKreSq27WGZJNBh8vE8P5zxlPyIOVPzMdLucyXt3hRF4+G9iSkHB1kmzOgvgFEH69AAc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlV3T2VyNnNxbVE3Q21Vb2NRcHAwcDFqSHFmOHU3VG80eGZ0Mi9aYzdjZ1E1?=
 =?utf-8?B?TXI3UWtub1Z6L05SbTI2MG1DZGJoVlNaZ1ZTL3BqZkJjM1gwQ1Y3STMxQ0pr?=
 =?utf-8?B?cVRIZVBYZUFpdTJGNUhkck42N3dNTTg0T0RCS1g1YjRQbFlmN093T1JwNTdI?=
 =?utf-8?B?VlV5OHlzR1dZY09XVjRtcjhramRHdlhZK3UwMzI1WlNFR2d4N2R1YUdKTzZ5?=
 =?utf-8?B?VGhyWlcxWWtXd00rVjM3WG9sbnA4V3pQYTBrcEpNcjJFcUpjdTJ0azV3QkRL?=
 =?utf-8?B?aFRkdDhMZXRCQ0RESXNGR2lKMEp6OG16UEZpNDVNaU9rdHNzam1FbGNOM0RN?=
 =?utf-8?B?d1lpeWRsbUI4N0JEVGV2WmRiMTdaZFdBYU9ENXVKRnRoeU5QTzl3L0c4Z21r?=
 =?utf-8?B?dTg3TWNtV1NZaEl2V0dENGVYUld6QmIwTnVKRW91SDZvdWYyTE9sSXR4VDV4?=
 =?utf-8?B?enBrc0swbzNoV00zUWJEU1Y0Smh3WnlzZDhIUTlBVHFQcWRNNnFQTFBoTTdL?=
 =?utf-8?B?ZE1ldDQ5SzBzVE1CSGtsMitrcTU0Mjc1SkdGajJleWx2SDM0Y0pGMTJDa3hw?=
 =?utf-8?B?N0pGQmdzaCtwc0VUc1R2aXJraVNIREo4MDBTT01LeGtBL3BhQldIQjl3UVNO?=
 =?utf-8?B?UVptWUxLUThUMVl4dE5Yam50UE9aWE1DdmViSzVoRDdiaWtVTWloeWMyS1hG?=
 =?utf-8?B?Y212dTBIbVEzZUh0VmtvSzZPcDBaRS9LZEhBRCtTQzcwQU0wclhFcGRrUFF3?=
 =?utf-8?B?RmdleldGQUUwcUlPb1p5dGdxRW00aGZYdHF2Q1lneXVOdTRNMGlMU0p6RWdQ?=
 =?utf-8?B?d29jbDlLUFFJK0pqdTV6UE1zQzdXN0h0RVA1QlJPaHQ4eE9RM3J6b3liQ0Rx?=
 =?utf-8?B?YTczL21HektiOWZJQk9NSUZWSWJUbUpiRk5KUVNwdkNZZmJtdEZ6RVNNWjEz?=
 =?utf-8?B?bmpwc1Q0QTF2Q0ZrK0VGK3ZNenRKemU3Q3hISndBZXZPVWprOHhzQjZNa2hm?=
 =?utf-8?B?TWUvbXVYQkY2ZElESlVTYkx5dk5pZnhSbFhiNmg2S1BRa2hERVZNUTlPODZM?=
 =?utf-8?B?WHIrdWU2QU5OT1JiTGd5OHQ1YXRDaEJnYTdqbGRSamI3WitDZ3RVY3RZbld4?=
 =?utf-8?B?dVUrNDdaU0FLamMwTTlYTmUvcG1aSTNjZnZGL2hIWkIvRmhFc0dUYk1tRXU4?=
 =?utf-8?B?RGZyTHhWVHY4RzlQTWNVRW1UcS9HUTk3bmhQSnZvekk1Mmh0RlFXSmtkSVMr?=
 =?utf-8?B?LzBkQ2FhajJFZWtGOGFkdEc4TVRBTkwycllTTW5ZaVl3S2ZYaGJSM1pZalFp?=
 =?utf-8?B?aXA1RzBENCtud3Uza1BpRlB0L2luZWpqbi9VUlpHMWt5ZUh3R0V0ZVlYenlL?=
 =?utf-8?B?WlpFTkY1V3RVc1NNeVdaZXNNKy9vV0JoUCtjMTNkanNBUllKOFJOeVErbERE?=
 =?utf-8?B?WDgwczBFcEV3b2cvSy9iZkRoNWtlQUtXUXZSNXQwaEtxanBHS3hmMkhuaWVR?=
 =?utf-8?B?YjM1Lzk4QnpuYWlwYnZuaDJhcm5RdHFucGtMbFhGcTU4eFE5WlFXZXZFQWox?=
 =?utf-8?B?enBtU09DTkE0MnpHY0wxdy9GQmZXV3Z3OExlWE50cDBxRkUwTVA0MU0xNDFQ?=
 =?utf-8?B?a0RVbTYwcVpzUW9lcUJvL0c3cURZMUpvQmNjTG1qVDN0OThVZHE3L004UEMy?=
 =?utf-8?B?VllZNGYvN08xM1dBbUZoKy9FNkY0Ukh0YjFHTy9IVFhJSjFBb3pWWTArSzNq?=
 =?utf-8?B?MWdVbTB2VWtxdG9YVlpkSHFsL0pKOEIzYjhuaXUrbnFVZkJTSDU3N2lKaW9T?=
 =?utf-8?B?V0k5QkIxWHpFdVBaNjVxUTlaOWhyVThQczNETEJqQ2d5eXFhQzYyRVR3Y3Ex?=
 =?utf-8?B?c2wvOHRJYkl2dzU4cndDQ2Z5U0V3WlFMMm9XcS96TWZlY21EZld0bC9WNk81?=
 =?utf-8?B?QWtyNUlrWktoYjB3VU1UTXBJemxlK3J2UWVsbFFUdi9ja3FuSDhnYURDbHFq?=
 =?utf-8?B?Rm9HTkZoN2dPd2N1Ly9uYjk1bFpyVGFKTXRIS2w4TmFPOVh6L2kwdS92K0Mw?=
 =?utf-8?B?U0ZzQURhT1ZVbDVxNW5kS1JkcXVGZkwrY1FxRDVuRXMwUjQ5QXBMQjJ6RFJk?=
 =?utf-8?B?Unh0eGpBTm0vcUQyMUdTaTBzMVdCeDYrbnlVeWZTMmIrMU0wQk4yMm56dyt0?=
 =?utf-8?B?ckFWQVVzR1E3VmUrMmg4djRtTWQxeXBvbVJ5RCs1M2t0ckMrMGd3Sk4wVk11?=
 =?utf-8?B?b1dqUHl5TzRZUU5GeWpxOFZsV2d5SCsrRU5jTTVJSDhVb2tWL053bDBaWlRZ?=
 =?utf-8?B?aVl3Y250dkVKWVRCV0dxT2h6NDcxNzNKN0xGdkNXeFNKZW1rbjJGUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8928d623-f472-4f0a-90e8-08deb0fa8440
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:18:34.2322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3gWdRC95gKK+57+piN6nuS7BqklbroBLlzDcAp53i4a75fYi6uhtEdiW0zD58NboM5hLEAWtfOy67xo81/z/tfKT5kaTqlsY+mlihF2RcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10429
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

Hi David,

On 5/13/26 4:09 PM, David Lechner wrote:
> Change the lone use of tristate in the UFS Kconfig to bool. U-Boot does
> not support modules, so tristate does not make sense here.
> 

Fixes: 6cca3db2bd91 ("ufs: Add MediaTek UFS driver")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
