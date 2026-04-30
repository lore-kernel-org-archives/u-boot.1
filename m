Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5C2FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9AE83A91;
	Thu, 30 Apr 2026 06:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="h+OBzWMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA9383FB5; Thu, 30 Apr 2026 06:32:42 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FB7803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfwLfHoawINLEzzl2YDWU+xis7nT+EY8cAZd7vldlA0BX0XEwA4T74QI2JSHmyDuAJSDrn9ZJZR55Wc/oVN7vfdnsR0Yo99HCINHfANqdiXzTdUZ0JkJhsJUkbNi43qnRSiNM2ErUVCtHU1S0v56cgWhSPRV0rzkxqtn357CE8T6k3RgD6MJ1LLJT3A7yudQARMsBcyi+Uxf+UdiwAE7CmJIezU3Xs/Me5FuZfo8yBBkRTRR7R/8+zgV5Z/pQJ6azsruSx8CEa13H9oqsw58yyzYcEuxZbhbMBMGi8LePBwOCq3/7MJacNuA+dt1OxAz13GaV51bOlLs+Hn+vmlf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlCCNhU7a+W1gvpJ0cfjTJ14/JimEXljSPt5e+CDsMs=;
 b=YHbFrnM3E7qmym0UT9rok7gRYIEk+hY1ze53B8qIguWhAySeHwsuBrZRKeVzYlsvT5ZlNM3Y2U0OTe3ywPnAghXZlMijGcJ7IZn0fSpT/yBeVgGzYFzH99TujZFSrsruJJOadexoy3tN/51OBAtFrwDHfcLRPRK1c4MxtGiLDXPbRPYzQARmRh0k61e+VdQDj5ddNsLXQwsbMuEK4MzPGBEqHZJV12gB53ARp2kTjxuSwKp1L8Ew/1iJwdJrQyfo2a3H6vu7pHBNZMwMD4Cf7EKITrJws10GuXSXvqtiZZPWnAkNOrTRE7bRlmMMBXQwJxMSP2PQ4XU+TjhPkFcjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlCCNhU7a+W1gvpJ0cfjTJ14/JimEXljSPt5e+CDsMs=;
 b=h+OBzWMMz+GhmrZMsbtNOdA5IdjvArl5PJ4CKB/ez4DDTAK8FCypMTqcDvHML7PFjyJLyOEet4404UUhI1Si1duiT+Y1WFEK/XpUmyvTDVYcrt7Rvk4hqaUWWR5EJY9zceREZwLRZxTOJd78SNEt4khB/JS+vT8lDEd/ZqfRjoriiIBW6jZb/20ihHuHA6CZ6sq82ShlH/6lV1KauGCVy3gmvHyf65LHbTRQvknL1u+hvguXXCCLsWudBS6sQGX8SGXUlwWtt4aWsqO8khFCOyCrcv9mFfPvQ8XTau+Ne78b20cw4fNzXNlrObXOfsLHj5g8xxymt34Krb+KkhRUZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BY1PR03MB7190.namprd03.prod.outlook.com (2603:10b6:a03:52d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 04:32:37 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Thu, 30 Apr 2026
 04:32:36 +0000
Message-ID: <3da55cba-d4f9-434b-b91b-cea87a4d1175@altera.com>
Date: Thu, 30 Apr 2026 12:32:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: socfpga: soc64: separate reset manager into
 common and platform-family parts
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260415030459.36610-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260415030459.36610-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|BY1PR03MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 67474b53-c107-459e-a1da-08dea6718180
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: QGYczc5HGcHUXtXPR9AffIqej+Oj8JdnUIKJHvubIMKUSjBHUGMutQHspVTVT0++I7ZkE8aoz9uYPuXR3Qcds0Cedmh7Up+DcYXARdXPs2lVlUuNbghj5Vpcdf0sW51vfC/mg1M8RDqO6Mw5o/7btdjVSG9w2SV6wUfQNNTSjLDDBvt9HYUW1S3cWSACASsBjDklmbyP1UnNVawUKNMZTFDCpCgJF5s84/1Hw/+fI3eTJhoNmIonBjZ/STWaMKV9QK6Y0SM9ql7AP2IdgEipT3BR9LSs7QEH6TTdArGilknHb1rZcgOlksRi+WNBco1Fts58IlzzzkdWKEjYDzY19ohr1g6oaiCkY/ED44uzoGsSXqus1m9jgdH0CX8UxmCIHQLGYCxWgm9wNUBWSnDWlc6560bVmLn1qgszVB0jmIJ45oVzfj9aIYmtbiMYV2WRzsv3UKOFj9LS/j6AUuaXMk5JMfUDf/lXCaD0/s3OzM29kQnsvYYSeOrjOi/YvnPgaCUXsL7MC3A9Gl2KWE0yi2KJxBgG+ALzoYdm8+8Whp9FwThY2gZWLmWvH3uh+Al8k+4+U29sjNkcQzIYp6y1lDVsVnHvUBRPxt5s7DqY9PDVOBLX4QA2sZ41qaJmFgi/ESd4X44KMZNj+tsqgJqa8K7y4bWv7KVaKRS8qwyP1mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDAzTGpJZWErSnhyUk1tQXBsbUM0NW9USUtVdFdwNFJ4YkJWTEo3MmJQSXhW?=
 =?utf-8?B?SVNPeW1yMUNxbnMvK3V6RXR4ajhQdklqbng5YjlHN21rNGt6Y3BZMTM1a2RQ?=
 =?utf-8?B?K2hKbkZzNnpjWGs0cmFyQXl3dzlVZGJaU0p5OFh2WEVDblRKZVR5TW1nVDVV?=
 =?utf-8?B?MVg1T1FYT2w2b2szdTRmeTdzM3dSSkM2cUY2T0RCam9KcEplS2RmNzZ3UkFu?=
 =?utf-8?B?OEJhMDBBZnhnaUZJaXlPZnRTMDlpT2xKaXdDdEZQRHBtMndWcUxVK2swWjh6?=
 =?utf-8?B?QkJHeVY2dDM0YTB0Q2h1Rk5wVzBja2t5Wk1IM3lhczQxT0UwWWZRc1c5MzBy?=
 =?utf-8?B?OEtsL21VNmQyTVVXNFRJdElHTU1lbWE3M2kzcWtmYmxPdEpJWEtWQ2lxMm81?=
 =?utf-8?B?MGh2K3BLcjAzU3VCLzdwRE82S2dkMkZlNm9MczVxazg1RUxpbmdWdGNFVFVX?=
 =?utf-8?B?V0pxbmR2VWlhbU5MU1J0Q0lZTlNNU1BGcVd3MmptWFJYUXM0U0thdlJ2eEdT?=
 =?utf-8?B?MkdRUnJYQlIwNnl5bzZUY2t3MTgySU9tVit5cDl3L0lZV2xsRURwQ3dFdndR?=
 =?utf-8?B?cWthMFA5Q1U4Um9pUmgxZld0anFhMFJTWm5lbnlHTC81MHhRc1AyZ2VXSC81?=
 =?utf-8?B?b2hjUFY4THNqWWVMVFY3b1h4Z0hIOHYzVFlBbHFtRjB3d0lXdng4T1d3eTRp?=
 =?utf-8?B?Kys0ck04Z0h2RFBPNE5KMVRwM2xvQ2QvSEk2eGNzUm5yUGthaUJyQ1YzQ1pS?=
 =?utf-8?B?TDZXeGozaXRvNDhjL25ya1pKL0UrbGNmVjNtN1J5SjhjYXlOemdhaWordnRw?=
 =?utf-8?B?ek1MRzM0N2NkUHJNdjgvZmJySWo0amF4RjNFNVZ4dDdwNE9weWdEcUVnOU0x?=
 =?utf-8?B?QXNJY2V0aGpJWXlPUk0xQ0ZkeHRCVGZmUlcxK0tFM3BYUTQ5VUczNG9WaGZw?=
 =?utf-8?B?UlJyTGNydDhoSUUzVFIwMVROMHhsamlCa25Ub1pTdHFHMklWMnBBQVFyYVVG?=
 =?utf-8?B?WkVkY2txK2lYTWRRdmI5Q2pZL2pIZWYvc1pVQXdkd2lhNlZvejFsRVF5OTdv?=
 =?utf-8?B?L1ZQYUtjeUhnLzZocStnZXNEODhWQWxXeEdyZzlTYy9vQjFLZCtna3Vjdk5Q?=
 =?utf-8?B?RDZHSlJHbjRzeE12aUV5S2E4VFl0RUppbGxoWXhVcDZrdjUydUF6SzB1T3Js?=
 =?utf-8?B?cE1xeElQSmtKVFVtLys4UkF1TThaY0I0dHZNRzdXUjNyME84WENyN0xPRFU3?=
 =?utf-8?B?dElSL2JiT2Z4YnBVVmFzTlZBRVFGdjFjaUxyTy9maElDY0JYa3hzQktWY2FJ?=
 =?utf-8?B?R3F0TmZmbU9yL0NNRTA1VnZ4dGVtSUFOVWpIV3dGZ0htbjNXUUVKbmdrcWcz?=
 =?utf-8?B?aUZ0elhBSkRLdEI0ZmgwNGNDMkJBem9pcHZseUNVRExpbngreTVKNS9lUGtO?=
 =?utf-8?B?WUlvbUY5Zlk0QnFNeXJ6dkVhd2xVdFVVamp6QXZLNEhnRUx6WnpaMHZDRXZY?=
 =?utf-8?B?dXYwek9qTE9MdjFiREFLSU9oWjNDdTBWalExR212UCsvQVF0MFFkL2IzaURq?=
 =?utf-8?B?SWhMZ2pWRzdpVHV0anVlQUN5YmdqLzVERmVSNTcrSzRKZ0RXN3JrTDZlN1pK?=
 =?utf-8?B?eGdGSXdleGNVUzZGNExESjhja2hhUFZISEZZUzFxa25GZERaZ0oxV1F5UXd2?=
 =?utf-8?B?OHZXSHJ1WHFsaVJmTXh4UVU5Q3YyUUthazZuUmIrcVZ2WTZWeGlsTFc1bmtI?=
 =?utf-8?B?NnIrc0w1ajhTWlRSTlRRRWEwUXYvZ2IwWnM2ZHk2cmZselhzQlRyeUQwc3Ez?=
 =?utf-8?B?bktyWkFMTU5PYXEwZ25wbFl4N3FWK1g5bE0vRXhLaElqeThtQVpNSlEzQ3RB?=
 =?utf-8?B?bHU2aFlwVWF5VnpXelpnK1JiTEpoWWltRjJxNHYveTFqdU1FRUZhTVc5RGp4?=
 =?utf-8?B?RnNIbXdwdnZCTWt0Sy84NmVaelVtMnRDYnFNSnpsZUtBUlNRSnl5dzZFMHFW?=
 =?utf-8?B?bGRJeEtRYndOSFE4TmNMMGFoMVJ3TzBCNC82RHVVU3hiT3pXYnNXTSswblk2?=
 =?utf-8?B?Q09MdVUwUlFBMVc0QldBaTA2a0hXZXZHNkpmamVodzlEK3pkaCtnUDhrT1BU?=
 =?utf-8?B?cmlBN1lqb0xtK3RUSzFjZzZOMjYxZzRGclBTdWtXRFRjaGdNWEltYVdNTEtV?=
 =?utf-8?B?T0pkQVZ5S0p6Q3F2YTZEZXZqR1JMMCtOQzVyRUNRYVltMUtQUmxRbUxNT3pV?=
 =?utf-8?B?ZVdyMFoxVGtRMU9MY3liYWtGWVlCd0gxV3d6UHAxRXJJWG5rMndxMkk3SzQ1?=
 =?utf-8?B?allIZ0NnY3k4bFlmNm44TytnNTRWZldaR1JVRFQwaVo2elZCMTFUT1orM1lm?=
 =?utf-8?Q?hctDfhDwz9jb4/KE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67474b53-c107-459e-a1da-08dea6718180
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 04:32:36.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY732zNBP+YIfHqGIN8KhhSTZGVQ323ZdgyPnjKBjqz8zqKhSay+HxwGxj47eVlZH/vIbCi1kkd0fmwXafAIHFJoB0sgQFcfFDeT5W7tvmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7190
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

On 15/4/2026 11:04 am, Chen Huei Lok wrote:
> The SoCFPGA SoC64 reset manager code is currently built as
> reset_manager_s10.o even though it is shared across multiple SoC64
> families.
>
> Split the implementation into:
> - reset_manager_soc64.o for common SoC64 logic
> - reset_manager_soc64_families.o for platform-family-specific
>    code
>
> This improves code organization and prepares the reset manager for
> additional SoC64 platform families. No functional change intended.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/mach-socfpga/Makefile                | 15 ++--
>   arch/arm/mach-socfpga/reset_manager_soc64.c   | 80 ++++++++++++++++++
>   ...r_s10.c => reset_manager_soc64_families.c} | 81 +------------------
>   3 files changed, 92 insertions(+), 84 deletions(-)
>   create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c
>   rename arch/arm/mach-socfpga/{reset_manager_s10.c => reset_manager_soc64_families.c} (76%)
>
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index b6f35ddacc4..ee0ae6a6131 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -34,7 +34,8 @@ obj-y	+= lowlevel_init_soc64.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
> -obj-y	+= reset_manager_s10.o
> +obj-y	+= reset_manager_soc64.o
> +obj-y	+= reset_manager_soc64_families.o
>   obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
>   obj-y	+= wrap_handoff_soc64.o
> @@ -47,7 +48,8 @@ obj-y	+= lowlevel_init_soc64.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
> -obj-y	+= reset_manager_s10.o
> +obj-y	+= reset_manager_soc64.o
> +obj-y	+= reset_manager_soc64_families.o
>   obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
>   obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
> @@ -62,7 +64,8 @@ obj-y	+= clock_manager_agilex5.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
> -obj-y	+= reset_manager_s10.o
> +obj-y	+= reset_manager_soc64.o
> +obj-y	+= reset_manager_soc64_families.o
>   obj-y	+= wrap_handoff_soc64.o
>   obj-y	+= wrap_pll_config_soc64.o
>   obj-y	+= altera-sysmgr.o
> @@ -79,7 +82,8 @@ obj-y	+= lowlevel_init_soc64.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
> -obj-y	+= reset_manager_s10.o
> +obj-y	+= reset_manager_soc64.o
> +obj-y	+= reset_manager_soc64_families.o
>   obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
>   obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
> @@ -95,7 +99,8 @@ obj-y	+= lowlevel_init_soc64.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
> -obj-y	+= reset_manager_s10.o
> +obj-y	+= reset_manager_soc64.o
> +obj-y	+= reset_manager_soc64_families.o
>   obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
>   obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
> diff --git a/arch/arm/mach-socfpga/reset_manager_soc64.c b/arch/arm/mach-socfpga/reset_manager_soc64.c
> new file mode 100644
> index 00000000000..9b28a34beb2
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/reset_manager_soc64.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + *
> + */
> +
> +#include <asm/io.h>
> +#include <asm/arch/reset_manager.h>
> +
> +/* Assert or de-assert SoCFPGA reset manager reset. */
> +void socfpga_per_reset(u32 reset, int set)
> +{
> +	unsigned long reg;
> +
> +	if (RSTMGR_BANK(reset) == 0)
> +		reg = RSTMGR_SOC64_MPUMODRST;
> +	else if (RSTMGR_BANK(reset) == 1)
> +		reg = RSTMGR_SOC64_PER0MODRST;
> +	else if (RSTMGR_BANK(reset) == 2)
> +		reg = RSTMGR_SOC64_PER1MODRST;
> +	else if (RSTMGR_BANK(reset) == 3)
> +		reg = RSTMGR_SOC64_BRGMODRST;
> +	else	/* Invalid reset register, do nothing */
> +		return;
> +
> +	if (set)
> +		setbits_le32(socfpga_get_rstmgr_addr() + reg,
> +			     1 << RSTMGR_RESET(reset));
> +	else
> +		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
> +			     1 << RSTMGR_RESET(reset));
> +}
> +
> +/*
> + * Assert reset on every peripheral but L4WD0.
> + * Watchdog must be kept intact to prevent glitches
> + * and/or hangs.
> + */
> +void socfpga_per_reset_all(void)
> +{
> +	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
> +
> +	/* disable all except OCP and l4wd0. OCP disable later */
> +	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
> +	       socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
> +	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
> +	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
> +}
> +
> +/*
> + * Return non-zero if the CPU has been warm reset
> + */
> +int cpu_has_been_warmreset(void)
> +{
> +	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
> +			RSTMGR_L4WD_MPU_WARMRESET_MASK;
> +}
> +
> +void print_reset_info(void)
> +{
> +	bool iswd;
> +	int n;
> +	u32 stat = cpu_has_been_warmreset();
> +
> +	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
> +	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
> +
> +	stat &= ~RSTMGR_STAT_SDMWARMRST;
> +	if (!stat) {
> +		puts("\n");
> +		return;
> +	}
> +
> +	n = generic_ffs(stat) - 1;
> +	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
> +	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
> +	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
> +	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
> +}
> diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_soc64_families.c
> similarity index 76%
> rename from arch/arm/mach-socfpga/reset_manager_s10.c
> rename to arch/arm/mach-socfpga/reset_manager_soc64_families.c
> index b2b4077fd4b..b60e1a82bcf 100644
> --- a/arch/arm/mach-socfpga/reset_manager_s10.c
> +++ b/arch/arm/mach-socfpga/reset_manager_soc64_families.c
> @@ -5,17 +5,11 @@
>    *
>    */
>   
> -#include <errno.h>
> -#include <hang.h>
>   #include <asm/io.h>
> -#include <asm/secure.h>
> +#include <asm/arch/base_addr_soc64.h>
>   #include <asm/arch/reset_manager.h>
>   #include <asm/arch/smc_api.h>
>   #include <asm/arch/system_manager.h>
> -#include <asm/arch/timer.h>
> -#include <dt-bindings/reset/altr,rst-mgr-s10.h>
> -#include <exports.h>
> -#include <linux/iopoll.h>
>   #include <linux/intel-smc.h>
>   #include <wait_bit.h>
>   
> @@ -26,46 +20,6 @@
>   #define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
>   #define F2SDRAM_SIDEBAND_FLAGOUTCLR0	0x54
>   
> -/* Assert or de-assert SoCFPGA reset manager reset. */
> -void socfpga_per_reset(u32 reset, int set)
> -{
> -	unsigned long reg;
> -
> -	if (RSTMGR_BANK(reset) == 0)
> -		reg = RSTMGR_SOC64_MPUMODRST;
> -	else if (RSTMGR_BANK(reset) == 1)
> -		reg = RSTMGR_SOC64_PER0MODRST;
> -	else if (RSTMGR_BANK(reset) == 2)
> -		reg = RSTMGR_SOC64_PER1MODRST;
> -	else if (RSTMGR_BANK(reset) == 3)
> -		reg = RSTMGR_SOC64_BRGMODRST;
> -	else	/* Invalid reset register, do nothing */
> -		return;
> -
> -	if (set)
> -		setbits_le32(socfpga_get_rstmgr_addr() + reg,
> -			     1 << RSTMGR_RESET(reset));
> -	else
> -		clrbits_le32(socfpga_get_rstmgr_addr() + reg,
> -			     1 << RSTMGR_RESET(reset));
> -}
> -
> -/*
> - * Assert reset on every peripheral but L4WD0.
> - * Watchdog must be kept intact to prevent glitches
> - * and/or hangs.
> - */
> -void socfpga_per_reset_all(void)
> -{
> -	const u32 l4wd0 = 1 << RSTMGR_RESET(SOCFPGA_RESET(L4WD0));
> -
> -	/* disable all except OCP and l4wd0. OCP disable later */
> -	writel(~(l4wd0 | RSTMGR_PER0MODRST_OCP_MASK),
> -		      socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
> -	writel(~l4wd0, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER0MODRST);
> -	writel(0xffffffff, socfpga_get_rstmgr_addr() + RSTMGR_SOC64_PER1MODRST);
> -}
> -
>   static void socfpga_f2s_bridges_reset(int enable, unsigned int mask)
>   {
>   	int ret;
> @@ -268,40 +222,9 @@ void socfpga_bridges_reset(int enable, unsigned int mask)
>   				 ARRAY_SIZE(arg), NULL, 0);
>   		if (ret)
>   			printf("Failed to %s the HPS bridges, check bridges availability. Status %d.\n",
> -				enable ? "enable" : "disable", ret);
> +			       enable ? "enable" : "disable", ret);
>   	} else {
>   		socfpga_s2f_bridges_reset(enable, mask);
>   		socfpga_f2s_bridges_reset(enable, mask);
>   	}
>   }
> -
> -/*
> - * Return non-zero if the CPU has been warm reset
> - */
> -int cpu_has_been_warmreset(void)
> -{
> -	return readl(socfpga_get_rstmgr_addr() + RSTMGR_SOC64_STATUS) &
> -			RSTMGR_L4WD_MPU_WARMRESET_MASK;
> -}
> -
> -void print_reset_info(void)
> -{
> -	bool iswd;
> -	int n;
> -	u32 stat = cpu_has_been_warmreset();
> -
> -	printf("Reset state: %s%s", stat ? "Warm " : "Cold",
> -	       (stat & RSTMGR_STAT_SDMWARMRST) ? "[from SDM] " : "");
> -
> -	stat &= ~RSTMGR_STAT_SDMWARMRST;
> -	if (!stat) {
> -		puts("\n");
> -		return;
> -	}
> -
> -	n = generic_ffs(stat) - 1;
> -	iswd = (n >= RSTMGR_STAT_L4WD0RST_BITPOS);
> -	printf("(Triggered by %s %d)\n", iswd ? "Watchdog" : "MPU",
> -	       iswd ? (n - RSTMGR_STAT_L4WD0RST_BITPOS) :
> -	       (n - RSTMGR_STAT_MPU0RST_BITPOS));
> -}

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

