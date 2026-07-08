Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A5C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0071838D7;
	Wed,  8 Jul 2026 06:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Hs4qTEfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBB58497A; Wed,  8 Jul 2026 06:36:04 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2431D80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg3wcQit1NODdVI/7fPDshSTDZV8PzDJotD28TjsuAOhmKZ5xT7N3vhWvEWW1O/xOWHcBWSgbo97+1Z0fCqxIpIC+Vab0525mZwQtWC6p/uEscsiJVz404EEYLdADSMKfH8R7zf769V/VZ9lOGtmU3ZBaKwXiBwuQy+oGEJFRnD5zqnRS95AgE0zp5fi/j3nATmMUOCo2Ldt4wbRyBggA+RcpFWsW+fqedmxAFG6oZ9nPfuXQ7Of5ra9kVeKtggG22CbuwfMc44ZJYeroUMwExpYv7TD7nwZefWUs8W9cCKcWhoCTdisa3ltVRCEuD3ZqPJbKxXilw86LBUo95zkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pofmqzKFpqI54Vq355SVDTkMZFBNkFbURr5oXSKLHc=;
 b=FRB8EETVKAYBC15gzJf5D6UgwMQ3U1+couS2bn2HmBAnF4G5VWALYdcc/c9ug6ffGiUHGWmrpsRIlJF6Y8Qoh34kGHqRhxRJWwMkqkCGnAYt2dgMm/CdLU8iLj15VAMSgtXxE6gCSQzJurbZZE/XX6KLJ6fqkUDuIizzNp2sHnEbor5/Alz+2+7/ViLLA4uiEpS7WpPJ7lXZsMwbpHb91CYRPLUDB515srmvDQNM3Oa2ld8WwgogRW+7dYTBKzOrmOxgY7jzG7iwpVj/w58XVrLT08wy9NitdRU5hgMQv9QuGQGsxN96i1vREQzuIzd6zMHxI7MpaHYVJkAnMqcJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pofmqzKFpqI54Vq355SVDTkMZFBNkFbURr5oXSKLHc=;
 b=Hs4qTEfn6h8MQXeCprKTbTI1fy7hA6otDq5LfSuheHdMPSVMrJiDdVNWBzNATrZNSZMwYupVuIZBCHg59ocIUG17lmN8gkSqVuat+PEewL3thbP19zI95Q6pOcalooO/rezwsQ9k43OCNTKkgO/1bAhIUgAj40npv9J43YG6soqYhogE2qDDM6/4qnhn06lfCvksJ9plJQguKhAUnPkG6j95biS5H5k3m0YYUyNGXXCLbBSQOTpYXdyc/ASjQYBf9/F4sU86w98C+N35VhTLoiaAIN1yXGCohA+r/ZwqCQCWrtxgdNfOk839l6zIEPV9/XRZKUmR+RXHNMWvbEnodg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:35:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:35:59 +0000
Message-ID: <83cc656f-2d39-4cb1-90e6-1df1033dc08e@altera.com>
Date: Wed, 8 Jul 2026 12:35:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] arm: dts: socfpga: n5x: update GMAC nodes and DT
 register settings
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-3-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-3-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:295::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: b31fd75a-6b3a-4594-284d-08dedcaa687f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info: rS2wP7VI+EGsQkoNidILZAhi3cJ1r3juJuLCbMLd5tEdM9IJMVOuruRWaitU8QaX0ROfHvI2UOleCOJxeZygxm4v51YzSBbFMccOefsamTONh00Z99ns1MXVZCu7bN2lIFO+JLhNfg7ttKJ+YXz7nqtR52rpQ1KvecevTXJ5k6oFH0hy6cIsZgU8jC/f2HTz+2CNgvt5H9kNSH5k6sJ4Os70XU37fTnA7x1I7zrqsyHm0Jte5XweZcXe0SewrxHtX5KxI9sQ+/JpER5dctXz/Kq1UejAQlZcdHsJqhHgQcDCPefYvsKbiIw/NjAnoR4fkcVMK3PAsM3vELrFgzZnq//0RBkAG172n5n3T2ahcTiwGXmkffOBSxRZFlqfTyWBr/iySnbVtiG8FrsqkC8GlLLXjg6fiKA2j2Mw2abOhCjOV3sbIpn07C0Na2lPCl6cv1P78ozgtNgYYYwSpvYwC9d20oAbW3sHjqjkB6SKRvS9cXnbakeYaSPPkxuSVInpaGVK0DIYeTXBke4jhJLKnEEjKcWj3IUFmp/bwivdEqX7DffHX1gbe2QlPeHC8eCRseVNWXwUrpH3PwAfKMdI17dIrZGUpwD3NdYR9k/TCmM+DTEV8obcRycwNE8EfDVq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDR6Y0NUN05maUgwR2JlWld3YWZNcXg0SlZHWE1jbGgrc0drRHc5SVQ0MVpk?=
 =?utf-8?B?YWlwWEU1R29UZUdGbUFBV25FQVFrdVJwSUJvQ0g2UU9TNmhwSG5MVk8wT1kx?=
 =?utf-8?B?WExpSGs0c2x6bEJndnUvMWNzUzhGM1c5dHFIYUJJVXAzRU9sbXFReWVWRXIv?=
 =?utf-8?B?K0NVVEV0OE5EaUtwSnNEaUFreHRvOGR2ZWk4Z1B5R1lPUHBHSUlNTzV5QXdX?=
 =?utf-8?B?VEVXQjRJUTZWR2kyOUpYRFhLOWFNOFZOTWR4ZWZXanlKVGsrZnpJZFRLNzFy?=
 =?utf-8?B?ekhJZ2xYNThpWEJqVUtPMkpCaEpCbW1kMmFkOXhVd1JjSUcxdFUxa2ljeFht?=
 =?utf-8?B?c1k2c2RjWVQwc24zc1J4TTYzR3NqVXRxZ3ovUlNLOHZoZHNWNWQ1MGpGWUw2?=
 =?utf-8?B?MnJFZmQzVURQY09DeU5VQjZRaGpUdk13Y21GeGNFVEtKT0h2NVJUanZQRE9G?=
 =?utf-8?B?UVJvMkR4T1FwVTFYa1RWcXgwNENyRkRSYWlMa0lqaVFPWW4zS3ZRMEFxYk5p?=
 =?utf-8?B?SXRkMHBlSUtyRzBYbXRuTDY1djR3aHZqQzIxcXFGT05Ib29ZT09wbmsvQmow?=
 =?utf-8?B?dm9QQ25YOG4zbGtJaVE3NldoTVZHc3JCK2hxVG5tbVVPZGJ1TC9saUgzeUVD?=
 =?utf-8?B?SnVtZzlCeUV2R04xdjMvR2IxNFlBMzhQdUs5TmVRdHlQVVVpNnR3YVBiV1dn?=
 =?utf-8?B?ZjFzcUJ4NFdmVEVnU0VLd2lxVWk5VDVueUdTZkc3QXUrTEFUNExrOGFlOXM1?=
 =?utf-8?B?TmRXK2Q0c2J4elR3WGwxeENKR2RqUmY2TU1oVENPYzJ1QVF5WlNTZVphTmRM?=
 =?utf-8?B?dGo0YkpFbkg5WVlPSGFnRENRelJIMmFhNEZCTFNCUDVhajIyVWthNkRxSFpm?=
 =?utf-8?B?QVpHa0NVZWhMWWdUWVF0UEZXTTNBckFWK3hHdW9acW5mYzhOSXVJSk1Dc3Va?=
 =?utf-8?B?V0o0Z2dhbU5kN3ErK001NWJuYlB1bmhnL0NVMCtsOUYrZk9qTW9YeFk4VXpx?=
 =?utf-8?B?dGVReEJ0NTIybGEvWUp3RnBxUG5nSkpwVVFUWm1CeUZ5aWI3UEtGaCtDN3pv?=
 =?utf-8?B?UHZwZVhxZGRRRTUzNnlMekIxSCtyVnhYdlZJN2Z0LzVaZE9XeVJXQUVVelFi?=
 =?utf-8?B?YWRON1k3Zmx4M29GUW9CRk11eG51NGdFZ2NCQVg0UXdBRU1DbnNHOHBWV0tO?=
 =?utf-8?B?NU9QNzRYa0lMR2pGUCsrYnhmRTYxZEM1QlRXSFQvM2UrcWlPMFJwd3cxNzdR?=
 =?utf-8?B?SUFpMVlGTk9sdm5CTUYrVEdXVjFiU0FVdHgyWjFqNVU0aC9rM25qZ1V6VVVX?=
 =?utf-8?B?STYrOVVpZjlVVEx0NFV0Zi9nZldPVnVIRkhhSXY3THpQbWZsMmVGcVlRektD?=
 =?utf-8?B?U0U4T0NzVC81YmdvUTY3OW9QcUVEQmJOREI4a1oxZjltaEFiN045aTFkckVn?=
 =?utf-8?B?YkRlc3o2WHg3eXc4L2EzaGEzaUF1NGNCWXZvekxERFZiSDJlSUNDZzcySlND?=
 =?utf-8?B?amc1czZwemVyYUNadVk1eUV2L1FtMklIeFFrZCtTYTlpeUlMQ1ZpMUxqSjEy?=
 =?utf-8?B?aGZ6enlTUTdSTjVuVU51Y0p4NnlRTTRmRHBCcFFuVkJHZzMybkhqZ04yUkkv?=
 =?utf-8?B?UExJNzBTU3J0dUhUWkt0UUN4WGtaN3RnVHE5TjByRmV1YzJVREsrWDlSYXJU?=
 =?utf-8?B?dFFYV0xBTVJoVHZSR0UxbkZRcXY5NUlhV0xabkJ5TCtkdWw3YnpPcHFKTHp1?=
 =?utf-8?B?RnZaWU9sWVdtcVNqNzdqNGU2K21yd1ZzSTNRVmJIRW1SVjV5Q1p5NEZINVB2?=
 =?utf-8?B?OVVlSFRENDVHeDRuMnZCWFZzV0czd2NPVG9CQlRiS3dwY0owbVhqRCt0ZnRH?=
 =?utf-8?B?S1RXckhaVXhHdGs2LzZXMWcyVzg5VkVBQmlTZVNDZjhJcnE1WS9BZlRSaXpQ?=
 =?utf-8?B?V0xjdHVOQWRCdEJndDUrcjdkK2p1TTNib2JlVXR2SkwvTGNvbVI1Wkx0Yzc4?=
 =?utf-8?B?amNCZlhFWW9pTVBmZVc4TkQzODNNakFFenZvVVFFWVJITElKRHJIcFNlVmNu?=
 =?utf-8?B?K3M5UzdkMGMwOEYrcjdHVkRybWVEM2JmcFJQYURZUVRQdGk2Nm1ZYUhQeDVN?=
 =?utf-8?B?a0U1UDU5V0pOYkZPbmh5V25oenBwY0xVV0pVME5uR1BLeXF2WWJ3K0dZMTJB?=
 =?utf-8?B?WlBOQ0xKSmc5TUFzNDgwNGtuZDBvazVvVmJUclRIV2FLUUZ6b3kyQm9EU3hR?=
 =?utf-8?B?dm5Jdk5TaDlQMFhrNWhTUFEwbTFmbEJuTjRFV2xxTmdvZUs0NTc5OENKdHRE?=
 =?utf-8?B?VTcwemIrTkl3VzhqWFByS0xkOUg3ZEU4cEJlK1BnWm1saFBaZ1gvT1RidjVH?=
 =?utf-8?Q?tocS+0wg9JLtURQM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31fd75a-6b3a-4594-284d-08dedcaa687f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:35:59.2871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayUNgHyerwHcz5zxlP4t6S0aNhneklv3PXTR4R5nlyvUjz+CjUfGHwr5YIhntK6CIzNkljg12Ke/7THYIQessaCfj9t7m7Qdg1FoGWz3fIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Enable register settings in the N5X U-Boot device tree by adding
> firewall configuration nodes under the L3 interconnect firewall.
> These settings disable OCRAM security at the CCU and relax MPFE
> firewall restrictions required during early boot.
>
> Update the GMAC nodes to include proper compatible,
> reset-names, and clock-names properties, explicitly setting
> their status.
>
> Remove the clocks property from the QSPI node in
> socfpga_n5x_socdk-u-boot.dtsi. The QSPI controller clock is obtained
> via cm_get_qspi_controller_clk_hz(), so the device tree clock
> reference is unnecessary.
>
> Additionally, include socfpga_soc64_u-boot.dtsi and rename the
> soc node to soc@0 in socfpga_n5x-u-boot.dtsi to align with
> the common SoCFPGA DT layout.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  5 +++
>   2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> index e27a64651e1..dbfd2abfd59 100644
> --- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
>    */
>   
> +#include "socfpga_soc64_u-boot.dtsi"
>   #include "socfpga_soc64_fit-u-boot.dtsi"
>   #include <dt-bindings/clock/n5x-clock.h>
>   
> @@ -15,7 +16,7 @@
>   		bootph-all;
>   	};
>   
> -	soc {
> +	soc@0 {
>   		bootph-all;
>   
>   		ccu: cache-controller@f7000000 {
> @@ -46,17 +47,29 @@
>   };
>   
>   &gmac0 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	clocks = <&clkmgr N5X_EMAC0_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
>   };
>   
>   &gmac1 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
>   	clocks = <&clkmgr N5X_EMAC1_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
>   };
>   
>   &gmac2 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
>   	clocks = <&clkmgr N5X_EMAC2_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
>   };
>   
>   &i2c0 {
> @@ -132,6 +145,29 @@
>   	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
>   };
>   
> +&socfpga_l3interconnect_firewall {
> +	ocram-firewall@f7100200 {
> +		reg = <0xf7100200 0x00000014>;
> +		intel,offset-settings =
> +			/* Disable ocram security at CCU for non secure access */
> +			<0x00000004 0x8000ffff 0xe007ffff>,
> +			<0x00000008 0x8000ffff 0xe007ffff>,
> +			<0x0000000c 0x8000ffff 0xe007ffff>,
> +			<0x00000010 0x8000ffff 0xe007ffff>;
> +		bootph-all;
> +	};
> +
> +	mpfe-firewall@f8020000 {
> +		reg = <0xf8020000 0x0000001c>;
> +		intel,offset-settings =
> +			/* Disable MPFE firewall for SMMU */
> +			<0x00000000 0x00010101 0x00010101>,
> +			/* Disable MPFE firewall for HMC adapter */
> +			<0x00000004 0x00000001 0x00010101>;
> +		bootph-all;
> +	};
> +};
> +
>   &sysmgr {
>   	compatible = "altr,sys-mgr", "syscon";
>   	bootph-all;
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index 840537c9d0b..1f7e31bcae3 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -44,6 +44,10 @@
>   	bootph-all;
>   };
>   
> +&gmac0 {
> +	status = "okay";
> +};
> +
>   &i2c1 {
>   	status = "okay";
>   };
> @@ -55,6 +59,7 @@
>   };
>   
>   &qspi {
> +	/delete-property/ clocks;
>   	status = "okay";
>   };
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

