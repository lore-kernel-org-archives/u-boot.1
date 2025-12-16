Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD8D5B86C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C4280077;
	Tue, 16 Dec 2025 03:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uay7LGLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D66C800AB; Tue, 16 Dec 2025 03:36:39 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF97E8003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td8kBlHY6ueP3dts9AoF2ckTCdg5RIMiLQe9YnhmN5GM4z3xEUx119qsaxSLR2Dk+M1ZJUrk9NztwleJylETJl2SCqE72QCHg7939ZLpy2Dsu3ueP5QBjLDyXVIEIz0NMa4BpDdon3lp01jxmqzG/jeoFxT3r/zX81GPKM4IfTPwN936jON3NjbOIdQU+0TrcGkwFQjXJ0B1ouVsb6ewvoeH1L6rU1wRPby+kf1MuIlMrcXKX8dIaQcdRwpNMHeKPsg+eA5Z2RR40N9EUTn5FBPtAeSNN5JimtJneLkQaG5zSgjgDgOU4ft/be+EpuLzmO9BbrzNlYcw3hMwDseIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mMqT9nt6fgt19sc/rtOXwS7o0l9a/K+0SSONiTOMiQ=;
 b=tdeEf24iQDmmf4Cq+Dm/oa31eFO7khWlCnZgki1BAi/lo0+IAN3/62ExJb0gCDPNo2lCVq95SWDWDVZGCGMp9NE4oEkUVIHQk0AQUBDhE+/GiOl/Yy7/QS9t7Ji8VVGIKLu3i7ck47N0WSNc/sFOBkjgCU+NC1YXQLcGmbkYvKFRAq56w0fnWQ5ADYQfyK52Pu59Ahv8pQMhZJHlcldGrbnU2iEy8OfiDHO16w5Ls9PR83OKO1XElD4CCV5XL4MQgCxOt8+5tbgY3msvRzXRo/+MeyOLn7l02QDgPKpOgx/MHlPQzwQPc/SpbvJRwAGkdNBey8ahwKWSfpoWPhmk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mMqT9nt6fgt19sc/rtOXwS7o0l9a/K+0SSONiTOMiQ=;
 b=uay7LGLGhZI/AOUCfLriTf6wWSjIiwFApT0qdSICmOS9w2nKmcKBCUzZS+dGBFrVDcnMdVgDvwTrAfd/cGapArY35xjgV2XiWSFzxtC856bYKuuL0ziZCeCEm1TqgTKZGLnWqq1K+r/t1pOuswm6w2z5ytyo+LlY9PB8Wgry/yY=
Received: from SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::19)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:36:33 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::79) by SN7P222CA0006.outlook.office365.com
 (2603:10b6:806:124::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:36:32 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 20:36:31 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 20:36:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 20:36:31 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BG2aSS83343115;
 Mon, 15 Dec 2025 20:36:29 -0600
Message-ID: <b7123c6d-afc2-4d96-a7bc-3c658a736140@ti.com>
Date: Tue, 16 Dec 2025 08:06:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j7200: Extend firewall for ATF region to TIFS
To: Prasanth Babu Mantena <p-mantena@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <n-francis@ti.com>
CC: <vigneshr@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>
References: <20251215104623.1665884-1-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251215104623.1665884-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2ef220-a355-4029-f033-08de3c4becc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHJTZDFSdlhYRUIrZ3Z1MWM2c1Q0Q0xnanhJOEk3Ym5hWUY3eHhGZDhOQS9p?=
 =?utf-8?B?U3h6c0dlUi9XSkFIQ2dhQ1NqbjU3dmtIdkR0aCtMd1M1STNOM213djlxVW9S?=
 =?utf-8?B?c3ZPbFNZL2JhWG4xOGYwVWVWbkQ2T2FBa0hyWkhmT29pZjJFOXF5dm1qR2ZY?=
 =?utf-8?B?VFNwTlpkdXhUb096TU5tZnNpK1FJTTZucHNMcXdkVHdiSm9Yd1B0elp2V2hZ?=
 =?utf-8?B?ZjltNmh4Z0I3SjFLd0RtZEg2VndpVzFwLzA2VDhTME1MU005TkYySldXZ2Nj?=
 =?utf-8?B?VzBWSXIwN3VJamNld0lTc0s1ZDkvbjd6SVFQNXNkQkxIcDVjU2ovc1IySGFj?=
 =?utf-8?B?VzNTUm1mcWxNTkc5NjVzTlB2dGlNWFpWOUFPaUw3VlcveSs1YVp0dFRodFU3?=
 =?utf-8?B?WHMzaVhyaUs5a2QvQ3dsTWxpeFNFSTg2S2xmU3phTXNhUE4wSUkrV1NKdkUz?=
 =?utf-8?B?RmNhUkRNL2RQZXpVSHNhM1RjYmE1QnNqTlJ6VnYzU3VpMm9YMlBWVTZKUEpo?=
 =?utf-8?B?UENwTDkyU2dwSTdvTnhyc1BKNm1HenRzM2Qzbk1lS0pCYms1MHZ3L0h3Um0w?=
 =?utf-8?B?M2RyWHR6ajlVd1ZZU1JLc3JTdENOTEQxYzJsZGxPY1RFVXFBVU1IWk9EV3hm?=
 =?utf-8?B?dngwTUt2N2ZjOWIveG9VNE9TYXhDTitOdGcwd3QyQW9HcFMvdGFVQ2h1NDQv?=
 =?utf-8?B?R0NtQVBnbWgyQ201Q2pYL3FxVVpWanV1MXFHdDBxY2RET0p6RVczZ0hwZHp5?=
 =?utf-8?B?eEw4eDQ5UkZibmVER0VlUjJyZE9UUTdZVFNZVENiMUY2MXAydGxmVTFnaUNK?=
 =?utf-8?B?ak0wdnlqVURDcFNhUG9TTTdMR2VDME9kNUY2Tk15Q00wamNPRjYyU1F3eCty?=
 =?utf-8?B?ZXY3RmR4NStjTWRPTGt4bmtRYkVlMkZRZE91SGI3U2V4YnE2WllFYXFudDA1?=
 =?utf-8?B?MGJFRW9RRk9LSDBPVDg0aG5Oenh5ZEt1YzBmREgzWEJ5YU5lM3U2bm5EeFh3?=
 =?utf-8?B?cDlUQUZaZzdqRy80VDFDWmRhUmpuZW04TzlsbVM0UFAweWhtZjBGYmFPcjNQ?=
 =?utf-8?B?RERPd1pHb3JFeHdEK1FQMGZaNXc3UERDUkpoc3NvZDZsaGRKQWRmQkdneG0v?=
 =?utf-8?B?VTA2ZzdqREd0TTljQ01UeU1YbkZhSDJJSnlCOU03eVdOeVN6SDg4cDFudE8w?=
 =?utf-8?B?a3NQalpwMFlFc1o5VEFWMzlJUFh5S3drdlYrck5NUVA2b0ZRdU95N2lOcmZB?=
 =?utf-8?B?Y1dvUkkyM1pCZUdBQjVWcFBSdkhnQ2lKVHdZcG5HWHFzQ1pwTEIrenhBRmJN?=
 =?utf-8?B?WWFpRjhnaUdHQWE0L1piWHB5Z25lT1JoSjJWdW1VWTU0N3NITXU5U1N3RElX?=
 =?utf-8?B?MzBhMkhzMm9IQUxyTXpCaGI1bzBWZ0w1TEZzdEJHTXB6Yk82V1Z5R0ZuUUsv?=
 =?utf-8?B?R3J1U25xZkV3dmJZQmlFV0dhVStkNGtzT1hGVEVkR2NqY0l3Nlp4bXhvcEda?=
 =?utf-8?B?b0ZRYm9USkxkZE1lT24vMVdtR2JOL0VPdWw3djBiMjdUQXlvMTd0TmxnaU8y?=
 =?utf-8?B?ZUExSkt6R0NkbFhuUmRhK3Q1R3UvK1N1N05kYm5WVWhyTEJ5djZ2YWE5ZDVP?=
 =?utf-8?B?WW9EREV6VHI3SmtYdG4vemxvTEk3T3U3TXI4VWVjUDNKRXIwbE1HR3IwZWY2?=
 =?utf-8?B?TTFXSkgzNjEzcVFiOWxOVGRBSWtqUTRvN2lIY3RUYkg5UEtCL2F2dW94eEVq?=
 =?utf-8?B?YmFsUWhma1ltTm04b2pwajdzT2NHT0I3OTFmKzNOOHFySjVoN3hMVmhtbUcr?=
 =?utf-8?B?b2s4UFdJTGJyc1lhN2lnT2JhUzJaSDByU3pJK0hiZng2K3lNeGRHWitrRzR0?=
 =?utf-8?B?UlY4c3BDejJQYktQRWNWRUlQUTFCU0s3R1ZZNCs1NU4ycndTTUYwbGRHTjVp?=
 =?utf-8?B?Z1Nic3ExNXVqYnRwemRzTVRKOU8xZm54d3NPT3RvaHZ5NGJOMnlvTjBDZ0pu?=
 =?utf-8?B?V2dZT1hlei9UQ1dzMTI4aTFoV29ENmt1SXdHWkdROCt4WWdGcWMvVkFseWw4?=
 =?utf-8?B?QldzdC9rdTdkWnBvTGRlem5tRUF4S3FtQXhDNFNRYThhV3BTQ2Vzdkx4SCt6?=
 =?utf-8?Q?yDuw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:36:32.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2ef220-a355-4029-f033-08de3c4becc4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
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


On 12/15/2025 4:16 PM, Prasanth Babu Mantena wrote:
> Extend the access to SRAM region of ATF to TIFS as well. This is
> needed for TIFS for encryption and decryption of ATF as a part of
> low power sequence.
> So, give permissions for TIFS to access this region.
>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
>   arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
>   arch/arm/dts/k3-security.h        |  1 +
>   3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 761b1730464..6c5ebaa1f35 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -479,7 +479,21 @@
>   		start_address = <0x0 0x70000000>;
>   		end_address = <0x0 0x7001ffff>;
>   	};
> -	firewall_armv8_optee_fg: template-8 {
> +	firewall_armv8_atf_tifs_fg: template-8 {
> +		control = <(FWCTRL_EN | FWCTRL_LOCK |
> +					FWCTRL_CACHE)>;
> +		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD)>,
> +					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD |
> +						FWPERM_NON_SECURE_PRIV_RWCD |
> +						FWPERM_NON_SECURE_USER_RWCD)>;


I think you don't need permission for Non-secure (priv and user)


> +		start_address = <0x0 0x70000000>;
> +		end_address = <0x0 0x7001ffff>;
> +	};
> +	firewall_armv8_optee_fg: template-9 {
>   		control = <(FWCTRL_EN | FWCTRL_LOCK |
>   					FWCTRL_CACHE)>;
>   		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> @@ -489,7 +503,7 @@
>   		end_address = <0x0 0x9fffffff>;
>   	};
>   
> -	ti_falcon_template: template-9 {
> +	ti_falcon_template: template-10 {
>   		filename = "tifalcon.bin";
>   		pad-byte = <0xff>;
>   
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index b4e0ce8bfcf..72490fc7617 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -259,7 +259,7 @@
>   
>   						firewall-4760-1 {
>   							/* nb_slv0__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4760>;
>   							region = <1>;
>   						};
> @@ -272,7 +272,7 @@
>   
>   						firewall-4761-1 {
>   							/* nb_slv1__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4761>;
>   							region = <1>;
>   						};
> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> index 33609caa8fb..0b3f2cf3df1 100644
> --- a/arch/arm/dts/k3-security.h
> +++ b/arch/arm/dts/k3-security.h
> @@ -7,6 +7,7 @@
>   #define DTS_ARM64_TI_K3_FIREWALL_H
>   
>   #define FWPRIVID_ALL    0xc3
> +#define FWPRIVID_TIFS	0xca
>   #define FWPRIVID_ARMV8  1
>   #define FWPRIVID_SHIFT  16
>   
