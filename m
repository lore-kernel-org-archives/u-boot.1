Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A1D59F76
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5288389A;
	Sat, 13 Dec 2025 15:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JFsnM6or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0B88307F; Sat, 13 Dec 2025 07:47:31 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F27E83045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfS1XSleFoPsElHX0wDJR2/7unuuS/BDpAfihjZxTe5gNxmU6H/4C3V4ZpnPwuABisrdvtcje8fucLKHpw/PelPehOzLllQcC4A9GJYfuEDIfvXI6zijI1m//Q0euP1feC9AGhU+HVYSBjWWtf2Q0pIJkxLR4dSQPz/F6hXti5oWUHFDAdIVmGn+KiQ6VyOJdh+TDNAmHuabxlvKGJ6t8cJJ3wgRl/k+BKxNY3W3SLyXR7m3Cm5yOR8niEkVpmeYGjQTNPsWB15Lje1fYsCnIXoanaCcNNnlou7GJEaXj2JzZg9ucy8QtnvSqM5MVgf70caBYZp6NxRT0lxe1Jn7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhc9JS0Z6lvpEByDnqJ354iae6qv0oGM7wbXIj/ypXo=;
 b=WWnnWNtFk4LTyl7apVqyxyGqU2W8oXc+K8qn0vJP119L3tZGXyp1gvTPB0VU2o/rSwTRPlImY5Pdy7Ntm7yAjkd0dfQrSbxAnDxtE42HgcjJ92g9yFsISdhPRrTG8KiGv6QULu7kpOs6zwEAU3b6XPpEu8UmaUUdQVmY4LGAL6QrngXSeE3F4fqro28AIJe5xb6oH7YjKS6zsF+Z4DPi7xWhVXmjdO/cDYY3XrY2gog1dft+K/Peh0feKC+T17m+l3d8ednG6WkLxuUZvq9kcheaEPTs/x7uyqDIhDGKlLrAOYQcPg5kodKmv+H9SNbs3nqBpB8Ji44fgLKVhiwEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhc9JS0Z6lvpEByDnqJ354iae6qv0oGM7wbXIj/ypXo=;
 b=JFsnM6or3IFZlYfGrdQO/z6UKw2eBBNohj8RY1IDMRXTkf1f2Zbf7Gu4gTQqNGGLObUHZsv1hZsq8sZwgAGLMAp1wygOJUQn4E3SCPE6lIobyXBnFJ6nkcsvPJayY3SRehU27LE09aMBAnAE9NMCyyISvjOpWL+Cfo0V8j1C51A=
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Sat, 13 Dec
 2025 06:47:26 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::7e) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 06:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:47:24 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:47:20 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:47:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:47:17 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6l3wF3381726;
 Sat, 13 Dec 2025 00:47:04 -0600
Message-ID: <c82bed01-8e24-48b7-bd30-d378f12940a1@ti.com>
Date: Sat, 13 Dec 2025 12:17:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-6-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-6-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b9a863-30b2-42b1-ac58-08de3a137945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnZ5ZEQrb2oyaHlzR3gzMVF1bVlFdGd3SEFTZTFmUzBtMlAxK1BYeU5LT3Az?=
 =?utf-8?B?TFRIV2NTcEFOdGttWkRpS2FPRVZ5T3o0Tjk4VExCcW5aTzRjV1piRXVkdGlB?=
 =?utf-8?B?ck1LMnNoYUJLblFFenVIQU1TRlhlNTZlcTJLQjFHcmQ2dXZyWC8yZkhtRGNn?=
 =?utf-8?B?RGZOZENKNFVNREpnWnM5dTBXQSs3ZktmNFMxOCtPdWZKczR3Rnh0WEVNSmEw?=
 =?utf-8?B?ZHBCQnhXMW1BTk5PMHgyUzlwTElpMzJVMnNaUUVGS2lLRnJsczR1bE5sTG1p?=
 =?utf-8?B?d0RQYXprcmNYVUZUQWRvNzdLb244UUdvUVA3T3pTenJENFlVVmROdHhCcjdH?=
 =?utf-8?B?b01xOTdmVE5iaXJieXo4Zm5PYkdBQ3JuU0FhekJBSTc4ZDQ2WlhVbk5QVFdl?=
 =?utf-8?B?NTY2blFBN0gzSElzNjZ4Q0JZV1NkYjd1bEgvc1lvTkdXcy9lUWxFTmd4QmY2?=
 =?utf-8?B?L0hWT0c5NkxkWFMxMnlQTUFOcmlmWUFBV0ROQUltNjY5cUxGUlBsdk15eExw?=
 =?utf-8?B?aC9LTlViRk9hZHp1RVU5TDRlRm41ekFtU2pWbFhHS3ZtNW13RGJtMzgxdU9z?=
 =?utf-8?B?c25IQnlMZVVhYVgwVW8zSU1ZOU1XN2lNM09CK3p2VndYaDN0L0Q2M2s0M0Jj?=
 =?utf-8?B?U2NPSitZOFB0eXcyYlVRUUx4TkphVzlrWHFzZm9jVGthNUZTWndFVjZ3Smxy?=
 =?utf-8?B?Q0tOQ3hrakRZQVFWdm9NZmk5MEVLNk9vbGhINFhwN3lZQmJBa3ZrYk5OclpI?=
 =?utf-8?B?dzljaDJ1WTA2NWtVT1FTaXdYVDg3YmFrQ3U1NHRjQmVrR25QQnVWbkh2NjRR?=
 =?utf-8?B?RnAxZkxVUWEremtMc2RvbFZ6TmRZa1hoRjJWZzBmaWVXUUMzQm9LVjZRaWg4?=
 =?utf-8?B?dTRwS05abHVrc09pRm5hZFlheXloSHRBQVZ5M0Q1Wk5RN0xFcksvekhEck1z?=
 =?utf-8?B?NW1lVUJtcEZkWXZTaGJRcEJvNSt2Q1NYamRSZmZhSVhHNDFZUmdQQmoxS2g5?=
 =?utf-8?B?ajdpTVE4T3lsU2cxSzBmRlIzTENmTWNhd3h3WkpMU2t4SjBKbTJRTzByNlNi?=
 =?utf-8?B?SGFrZHIzY1BsVExtOVVIUGRWTUJSL1BtUXFvR21mYjFMaFpRU1NHQTdIWlA4?=
 =?utf-8?B?WE1QSXF5Q214Q3g5dUR1YkYwQ2p6S2NDN3dacU4zU3lKRTZ1VC9yR0xNWUtx?=
 =?utf-8?B?cVlSRGZhL1FhaytaTVdObmFaWERQUXpHL0VNWG81WUdRL3ZPNnBDeXR5Nndx?=
 =?utf-8?B?K0l3b3g2cWUyVnR1ZEkxWHZkajQzRG5TVHZWUGJNNys5aGVCTDFSczFzMVRF?=
 =?utf-8?B?V0Z4cHZVeDNWUnhNNndZSnFmTmZrbC9pUWRpc3A5NFpYUTYzTW9kRjdLS3hs?=
 =?utf-8?B?RWxmc2lyU0JYZlVtRU9hL01YV21XL3VnVHJDK2tkREkwejBFQTY3ZFkya2RE?=
 =?utf-8?B?eFhnOE5uY2VUSlNURDhReXI0bk5lS1djMU5rbVc3NTJJb3kwUk1TTVU2UzRy?=
 =?utf-8?B?aGdMUW1hNEtSem5MZjZRcElkdWptSGRDdTEwbUhweU9UZTRoUThlY0QzbHVJ?=
 =?utf-8?B?czhReVh0MUlPUm14ZnF3aXVQS0dzL0tUT2tjWnFFbWM4RC9SY0xrcFczTXBB?=
 =?utf-8?B?MWNWd1ZBTEROM3o0MmV0UUFpS3dkbkV4c2xDSkUxZkljd0lVN1JYdTVabjhF?=
 =?utf-8?B?RE5Bb3VnRTFzSDFVNUJ0dXAzb2lIQVJpYlhZb04ycDFZWE8vNmI1V0hwai85?=
 =?utf-8?B?b0k1dlhBT1B2NTVPbWNlNkJIaHFFcTRTTHc0TS9sK01XVWgyVDRHa2J4cWNN?=
 =?utf-8?B?S3pIWHB4cFpRMTluVHZqNlZ6ZVk4TnY0L3BsRE9zWDVCY3dhcmZMRHJMMk1K?=
 =?utf-8?B?WWFuYXhhdDBJd2MxWGVESFgxM3A3VG1wckJ0dmF0UkRqU2dFYmdUK29Za3px?=
 =?utf-8?B?Sm9QQmFoUysrem5YN3E5STZaaGlKKzZSb1dEQnNHM0txYldzQWhEak9KMU5Z?=
 =?utf-8?B?YTlMQ0lDUnpDODZzZEF5YWlvbUFYaGNYTmhmcnBlaDdMUk1kWmdweHpIUEh4?=
 =?utf-8?B?QXVsM2tIMEhGRFVPZStTcDhzYUFhdnV1N0tjQkZEWndhejUyaWVtbHQwNW9E?=
 =?utf-8?Q?VJ/k=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:47:24.5597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b9a863-30b2-42b1-ac58-08de3a137945
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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


On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
> This is a common function that helps to resume from DDR. There are two
> pointers which are fetched from DDR to resume, the TIFS context pointer
> which points to the context in DDR. There is another pointer to the DM
> loadaddr to jump back into DM.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 50 insertions(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 81e180c8706445c270cfecb0500015eee7547f98..ee56f0b86ce303e319cfcd2b0db3bade1540635b 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -193,6 +193,55 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_K3_IODDR)
> +static int lpm_restore_context(u64 ctx_addr)
> +{
> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> +	int ret;
> +
> +	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, ctx_addr);
> +	if (ret)
> +		printf("Failed to restore context from DDR %d\n", ret);
> +
> +	return ret;
> +}
> +
> +struct lpm_meta_data {
> +	u64 dm_jump_address;
> +	u64 tifs_context_save_address;
> +	u64 reserved[30];
> +} __packed__;
> +
> +void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
> +{
> +	struct lpm_meta_data lpm_data = *(struct lpm_meta_data *)(uintptr_t)meta_data_addr;
> +	typedef void __noreturn (*image_entry_noargs_t)(void);
> +	image_entry_noargs_t image_entry;
> +	int ret;
> +
> +	ret = lpm_restore_context(lpm_data.tifs_context_save_address);
> +	if (ret)
> +		panic("Failed to restore context from 0x%x%08x\n",
> +		      (u32)(lpm_data.tifs_context_save_address >> 32),
> +		      (u32)lpm_data.tifs_context_save_address);
> +
> +	image_entry = (image_entry_noargs_t)(uintptr_t)lpm_data.dm_jump_address;
> +	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%x%08x, TIFS context restored from 0x%x%08x\n",
> +	       (u32)(lpm_data.dm_jump_address >> 32),
> +	       (u32)lpm_data.dm_jump_address,
> +	       (u32)(lpm_data.tifs_context_save_address >> 32),
> +	       (u32)lpm_data.tifs_context_save_address);

you want printf, here or could be debug info ?


> +
> +	image_entry();
> +}
> +#else
> +
> +void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
> +{
> +	panic("No IO+DDR support");
> +}
> +#endif
> +
>   bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
>   {
>   	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index a68924a2123961642b63401f3600ac825fb62da5..2c7cc552505bcdffc17fd469db3ee90779f3c192 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   bool wkup_ctrl_is_lpm_exit(void);
>   int wkup_ctrl_remove_can_io_isolation_if_set(void);
> +void lpm_resume_from_ddr(u64 meta_data_addr);
>   
>   #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>   int k3_r5_falcon_bootmode(void);
>
