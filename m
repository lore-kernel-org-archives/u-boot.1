Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0EC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64636881A0;
	Fri, 22 Mar 2024 12:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YshCldzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A80881EA; Fri, 22 Mar 2024 12:55:46 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 929E487B77
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8EB7UqYFEE85rxRydRSbvIFl7+fZUhf/HLk2KqaJCal4pe6Fe3UO3zQ1vZnVCpefRsjTUeimjLkGYSRtfQfR+6iGgROwanACj1jUb0UH/GF9gSQdlp8Hp1ReOORLkOqRa8PYGt+/JGChazUZj3XpxSzepg0QYVY+Qu/++k4/HeHLJCZXSYI7U5TyV9bSZM1gnfKDxlwFtmgeQpFd+o52wSepGym3WqIR2vztD2jbcxuVEumuQd4xXrEUgpD0gMLPYi1aPglFPIf0NW5o5As/HJoHBUWKSiCnxZrJB4YQdsej2mIeZsce9bi3k6pLveISTQmvlfC4m/LpOzamvkRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3+GLWD9h+YLLzgrPZLvtndMS9ry3xId3uPuPpjl3qA=;
 b=TSU4FpM0Tg9yFCuVsEHs/AFrVwsh0lTFqgJhzAvW8LOb1LFTtKbIkNtfoOwnJvYo9eajHwZ64S+bV+rv1NI2EDlt61BdLEZOsbg/442uFenN0WttqEMJEgd7iYL/CO3zuDljN0yIJ82j2euQagC0zvqBb7HLta+bXtmC3PnyYvzrvJryuEQfZNaOv/FRTRVgrYoHt76SJIKdiiGsqtyIjhcHHGb4VQ/XDWosFTGHNCd8PJ8zC9ChK63iBWH5H+gl8R1qw8aDVrhVxUFjpuTc1Xth0Ia4RdEUW1YIzM/ZecxVsz7gYxinMKyhGBNwnsx+I2tbpWlxcFXQ0Tbvu6yDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3+GLWD9h+YLLzgrPZLvtndMS9ry3xId3uPuPpjl3qA=;
 b=YshCldzjMN93OD8pN0qiq0biJ9cK20pqECyN3erGBy2udue8oG0VT0IByvKDGq405c5ruUFKdZbVgkIC3S+28r+dBqcAIgNR3muRYxnqalDp+bV7uxHKgxa/xfunt3QaLSOoPnkCYhVtrYR2tAzrfxRMEfYeEYU70xDV4ZjM2OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:55:41 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f%7]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 11:55:41 +0000
Message-ID: <1eb32553-b5a2-4108-b49a-f2a227837111@amd.com>
Date: Fri, 22 Mar 2024 12:55:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not setup default SPL options without
 SPL
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>
References: <8dc4b799d36f963a3e1ebb5b24793632dc360b61.1710258674.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <8dc4b799d36f963a3e1ebb5b24793632dc360b61.1710258674.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:802:14::46) To PH7PR12MB8108.namprd12.prod.outlook.com
 (2603:10b6:510:2bc::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: f631e4fa-a50a-43e8-e4c9-08dc4a66ff1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS3h8XNQga61JoXdNjxM/jfW5KFVUPS4HCrMdCcBMObh51Lmj0P2K98F35mD739JjnDZLC+D8HgOOwIeEoZKy1C++Hd7oMZZ3xLY5qBD/c5gWyUdse1N2rxMWWYCkphqkhux5Zj4n0eACEzhtmS+2EvlDp8JIQduY4xzQRO4O1tVoftzpF2y9XqhEqWhChd5uRA2p9gzUdhHgkIBo7TsYfeYzLmaSzft+Cvfh8SFyWCZeqWVa5ZwYq9a+Khulybxoh7mt8Z3OrS9YDbzxdRBADhiUViDWCBeltvFLsw3rnYLs/XNBYpRq0vOQAAz9UI+N6Ep5xJevrbXBhjKHVY91S2YqUahBmN2lPtDOrkxYCF0UCls5+RyLrReKHeogyhbcBtb1JXWrhGGAoUNJtbATdYTVaivmSNL4EpJnM/VQgQjWGJC5d2oGWC61slS+F6aaNS+73MrVNkSuLN8lmXhUnD++RFOxIjfiJlJV4n81w5ZmmNcl5n01zy6gyni42rRL0LSco57g5R1H/EgPB+8bGH+78RVfIcUNqZGA5ntlvT8HQmKa5hEtPoaqY1V0O3agYM5fgqQE+M9brDCEdrwvKnWYqSh0xcnwCOXf7SjuIgXZlWxZ/bQVT4ZcRe++XDCcmcMAntzk0Kvo1D2uaN3W0BTKd1+zMcwsYJf9AkAFfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sldmc0ZmUG5xbGpZcmJvdmtuUklJRHUyK0RYZFpsSitld29vZ0hWZ1BXMkRQ?=
 =?utf-8?B?OFVUZXZPZmErZThSNG4rUGRQdm1WTU9iempOR2FpUkZNZzVaMEpyNlBtVUhR?=
 =?utf-8?B?MXJJOFFSRUQ0YnIyNk0wQlJkSmo1dTFjeTdXTDFoSW5Uc3J4RE4xRll4R0NU?=
 =?utf-8?B?NmpxczN3WmI3eDZnMHA0UmVPQk9nS3BzYjdpMyt3VTBDUE9haitUNHE5OWln?=
 =?utf-8?B?R1NLMzdXY05GZjkvNGFwbUcwVzB0ekpUUlhUc295Z0RWWDg4emhIQXE5aU5R?=
 =?utf-8?B?MEdLbzE5ekVreUtvblJhMHQvNnE2L2crWHNGZ2h4OFQ2aUJwRHZGTTFLUUxN?=
 =?utf-8?B?d3A5enJmcklhUmRSZWtUY09ZeUhwZWJiK2JmMHZtVGJCYXZPUkhoMXNNUkJo?=
 =?utf-8?B?QzN6TEUyZnBHSVdSZzFXQUU0WnoveVd4dWJpM0J5MjZ2amJXcXF1UFBiZ3RY?=
 =?utf-8?B?TDVoTFNBdExlVE5pOGtsaVgwa2NiVE54emNYYmMzOERqWk03U1locVpSSnkr?=
 =?utf-8?B?YTkwaXYvVnN3Y0xWRW9ra1RwZlRiajVIbTNMSmpRR2NtcjBTdGp4OVp1LzUz?=
 =?utf-8?B?RHNYS0FseWVMaXh4WEJsc3E1Y0ZnWGxaU2FySFVpMVNNamp2RC9nTmdRNzNm?=
 =?utf-8?B?Qy9lcldtVkNhTksrY3JscFhHL2xxTGsycjRhYTdQNkRHdHkwV2U5QmpFczU4?=
 =?utf-8?B?ODMrZTB5QVM0U1VDWWRvUGk1Y2d2bVhkdWs2NzlCNzJGTGxwbHl3eWVIVVRr?=
 =?utf-8?B?b2phRlptWURLV2JBNXNYTklLbVI2cDNDVFhzdzRSS3RpY21XMyszS2hyM0c0?=
 =?utf-8?B?VE9teVhxeW1sSjB5TnhYTzl2OFU0MkE0dnlyWnIxOTB0MjFSNU1LMndVWkd2?=
 =?utf-8?B?WHRRY3d2UnhtRU9INjU1ZU8zQlJlQkRFRVJVQVphYXhFd1BuSWw5RXRzYlNw?=
 =?utf-8?B?Y0owRDUwUmlwQlVRc2RpWWxJb2hGOUh5NWNhQ3hnb1gzbEFVZWdBNWNMUFRI?=
 =?utf-8?B?TFpVd2xKTkpaUUVSbG5rWlhvUm9MZWNVK0w5RjlncWpWWS9BWmxvNC80TXdo?=
 =?utf-8?B?WGtzTE5Ya0QybXJlNEkxQUtPbzltWXlPVGdzdExOdEdoYVRXRkpCbGtjRFZ6?=
 =?utf-8?B?QWpxcUpkVEszcGpDN1YwbXlKSVliWDNxeFZNZzdyTkRQa2J1QzFqWU1CcXp4?=
 =?utf-8?B?Wm95cVFneTkycXJTV29FUkdIZVZxODVFY2dWTGFCZ0kxVk16OFpqMXZqbTI1?=
 =?utf-8?B?elR6dGdLMW9QRjh5Mm5SOTkzckZiR3hlU2ZRVU1TblNKaGg2UkhvVnFwZFBX?=
 =?utf-8?B?cFR6ZkFFUng1MkpvMU50L3pwclZHRnNQazRTcjJ6Tk02NWxrbTlpMVdVUllt?=
 =?utf-8?B?bHN0M0ZNK3VRdGl0UmFKUjQzYWhqNm9RSUVZcVdLSFY1ZHJ3S29KQTBJeEMv?=
 =?utf-8?B?WFVFajlGZHJIcmh3T3VtZjNHenZjL0Qxd3pIVDBzNHRzZ3lwazF1LzZaUjVT?=
 =?utf-8?B?dkZwd0xOOUNWYk1wZzU1SE1UU3JUelg0TjRRMEZiZit1czBaaXJNS2FTc1VI?=
 =?utf-8?B?c1lRMkVUWEwxSG5ORFY1LzArUXUraWdSR2QrbEFxTVljc1ZPNHM0dzFqb1BK?=
 =?utf-8?B?bWxIVm1kaHlRdDVrbDZvM2N6YU1yTGZTWmZaaDQ5ajNXODdKVG5YVyt6dkU1?=
 =?utf-8?B?ZTV1eXdMMmdvTGxpYTFxMC9sUlBSNWhKQkFKSVRvL2FMa0hQeGVKT2lGTW1Z?=
 =?utf-8?B?K1ZRWXZYV0JUUHB6d2UwbEN1VnRLWDBnZnFieXVPUEZ2ZzY4NGJaOS9zWFZN?=
 =?utf-8?B?RjNnd3Q2S0h1WGNtWENEblYvSjJIbVJ5ei9OcWtVSi9HQ3ViOHJFb2pRV0dK?=
 =?utf-8?B?S2l4QjZNeU9MUCtZTEd3RXduQ1JmdTRNeTBsbml1eUdRUHZJR1JHd2F6Ym1y?=
 =?utf-8?B?Y0dFWFRQQTFXS3dkOEFhNUVnRnJTc2VkNjBnK2VwblNLNURIMlZ1R2pkUjU3?=
 =?utf-8?B?SzNlc2NYVjRJVEZnSDR3UERsYnF3M2IwMExBSU1sQy96dFhtZHBNRjRBQldB?=
 =?utf-8?B?Yi9Md01uVnJJdXF1d2FmWkE3VlpRemFkUkJVTldTeFNQQUlYS0JCRkFhTENm?=
 =?utf-8?Q?U2t+k/++Tv5Rb6kDlxMbzMZEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f631e4fa-a50a-43e8-e4c9-08dc4a66ff1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:55:41.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85kxaFzMYG2UNLN0+OppaHAM0z1i3Os8yR5Lz263OkVjQqx0JZZCvCsrR3DPmx4p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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



On 3/12/24 16:51, Michal Simek wrote:
> mach Kconfig file select some options independently of if SPL is actually
> enabled. It ends up in situation that SPL is disabled but symbols are still
> present in .config. That's why add SPL dependency for them but also group
> them with other SPL options in ARCH_ZYNQMP fragment with using imply
> option. This should ensure the same behavior as default y.
> 
> Also fixed SPL_ZYNQMP_PSU_INIT_ENABLED for the same.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/Kconfig             |  8 ++++++++
>   arch/arm/mach-zynqmp/Kconfig | 27 ++-------------------------
>   2 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fde85dc0d537..0cf85edcb45d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1325,6 +1325,14 @@ config ARCH_ZYNQMP
>   	select SPL_DM_SPI_FLASH if SPL_DM_SPI
>   	select SPL_DM_MAILBOX if SPL
>   	imply SPL_FIRMWARE if SPL
> +	imply SPL_FS_FAT if SPL
> +	imply SPL_LIBCOMMON_SUPPORT if SPL
> +	imply SPL_LIBDISK_SUPPORT if SPL
> +	imply SPL_LIBGENERIC_SUPPORT if SPL
> +	imply SPL_MMC if SPL && MMC_SDHCI_ZYNQ
> +	imply SPL_SERIAL if SPL
> +	imply SPL_SPI if SPL && ZYNQ_QSPI
> +	imply SPL_SPI_FLASH_SUPPORT if SPL && ZYNQ_QSPI
>   	select SPL_SEPARATE_BSS if SPL
>   	select SUPPORT_SPL
>   	imply ZYNQMP_IPI if DM_MAILBOX
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index 7e7c87d16fa9..eee34380f0a0 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -1,29 +1,5 @@
>   if ARCH_ZYNQMP
>   
> -config SPL_FS_FAT
> -	default y
> -
> -config SPL_LIBCOMMON_SUPPORT
> -	default y
> -
> -config SPL_LIBDISK_SUPPORT
> -	default y
> -
> -config SPL_LIBGENERIC_SUPPORT
> -	default y
> -
> -config SPL_MMC
> -	default y if MMC_SDHCI_ZYNQ
> -
> -config SPL_SERIAL
> -	default y
> -
> -config SPL_SPI_FLASH_SUPPORT
> -	default y if ZYNQ_QSPI
> -
> -config SPL_SPI
> -	default y if ZYNQ_QSPI
> -
>   config SYS_BOARD
>   	string "Board name"
>   	default "zynqmp"
> @@ -143,7 +119,8 @@ config ZYNQMP_PSU_INIT_ENABLED
>   
>   config SPL_ZYNQMP_PSU_INIT_ENABLED
>   	bool "Include psu_init in SPL"
> -	default y if SPL
> +	depends on SPL
> +	default y
>   	select BOARD_EARLY_INIT_F
>   	help
>   	  Include psu_init by default in SPL.

Applied.
M
