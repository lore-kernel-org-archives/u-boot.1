Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6ADC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B4683869;
	Mon, 12 Jan 2026 14:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hovXHOCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A1E8388D; Mon, 12 Jan 2026 14:08:58 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazhn150110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d905::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EB68382A
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5LN7qWYYPGRSkE8Xsj6Ub5WIfVHfRZnQeXzxUPtiddjiZqBksLa8l7QNBk4JTie1/Fe4EcM6cCyK8UMyPF3DUIn/e5I6Gd8/tfC/J4JL/pxkWA4K5oeP+RHRiU/eY4B6Em8eNOG6lNatsFt8vISWgfQcwu7RbpJ+sspwHgRXVBPS6AjvmCUhhe2xZdHXLK8rfo8mhurQvlbyyvzjwFf2QOuHrY2ESYeeyXsM8m+DC7eOK4X89oZ7RO4+H9jI8cwDD2rQfZr7KNxnqyMTpSYjATMx74G4zKxr3mB9YcnEGNWfn6v0K+f7IukdzoR8DByiYEhtYifHktR8XsE7pxgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2i8uEf+88wIjyxzK1BO4o3jsF94o2omgeTe2896sek=;
 b=JqNFZwzfW/o9jvVGecWRsJoHw0/8S/moi1cJMtVQjvF2scqHFtoFhO4v3syyRQrXBSxWvGPDaFp3mAAv+mF0EdyLva6hqdVN2Z83mKMCQSThsyQv5ZE2SmjSNeHjcpsbCWoERfQwPqBkj1D5CoaIbIlyxEiW3l6dqtGxAyZd8M+8kQ22/67GMbRpmEIeM4YS9igmY/wNVXvM3YJigN6YhKd2WVsrPCDzXu75d4h9tKIoTljGCfR7Srj7dYxxnFrwFtj5u1GM1m7rRgKCKfCasiZHp0XWEcgzo2Z6c3C0d9bCO1OkaWqylrXB8lUraCveMveU7F6j6u6kmUkcZZbu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2i8uEf+88wIjyxzK1BO4o3jsF94o2omgeTe2896sek=;
 b=hovXHOCLFRJj122xRLzjbjenBhUjq+3cBxpxHol1QH/ZUsBmK5g3rbLUMXlpIAyRL2QK1Z1NPZQzpS1jjZmJcq9BVirsacTQW+kIXfNg8G5CzE7lb8e9EMSPoNNYsYKuRnnT0jnT5Gx1SMVjVK8NHn8epUn9LoZJNhwbFnBZ3zo=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by IA1PR10MB8209.namprd10.prod.outlook.com (2603:10b6:208:463::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:08:52 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::5c) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 13:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:08:50 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 07:08:21 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 07:08:21 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 07:08:21 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CD8KpP531678;
 Mon, 12 Jan 2026 07:08:20 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jan 2026 18:38:19 +0530
Message-ID: <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
From: Anshul Dalal <anshuld@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
In-Reply-To: <20260112101102.1417970-3-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|IA1PR10MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: bf65bc24-7252-47ce-d825-08de51dbba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2FQdGVEckRTNm5uV1h3eldIZlNvQlRMRlVmTm5aVjk5RklxbE1teVduMEE3?=
 =?utf-8?B?ZnR1VTFyMlEyREN1eUtSY21nMnQ3VFEzdHJKd2RkZi8zWHV6U1Rma1IySEhq?=
 =?utf-8?B?cTFIVlhmaFFSYWhCYzJUYnVqaDcveFNSSkdhTlpuRDlqVzZzYmZaQ0Y3ZCs2?=
 =?utf-8?B?b3ZxMnIxenpFclJERWxVSlpQQm02VytvK05xb2ZEY0U4aDhncjhaOUZlSkUr?=
 =?utf-8?B?Ym52Q1RqSnZ6dElNTlRFeTNXTDBJSGVZakFlOTZFZVpkbmk0ZWVSV1lqN1Rr?=
 =?utf-8?B?eitYWThEWVE0Y1h2VFI2Q2ZnUGRINTRxYTNRY0ttZTRodUxhRGlFSDF2WGto?=
 =?utf-8?B?M1VFYmNuaVVIL2xqbUtXM3RMZUhBdTRUUXllWWlIdlFrR3d6ZUQ2cVBTS25F?=
 =?utf-8?B?MDhpeFBQU3MxN3puWnpmMVB5endjMkFZMlZJU2xqVXgyQnR1eE5lQVdzdnZD?=
 =?utf-8?B?NXZCWXhCclJFdjRkR1BUOVozTm5MS3RGWWpzc1hhNEQxWlhCVTlObklVRUpP?=
 =?utf-8?B?N2hacjR1KzFTMEVWOGxsdmZkR096N2NIWHo4VlBncWdaZjVBRnlEakdMU0NQ?=
 =?utf-8?B?UWh1SXo4WmZ3SXJsbXp5Z3lUQnAwOEcyR1Z0RU1CQXNneGExQ3BjeHJiUnN1?=
 =?utf-8?B?cHZqeFZJMEV1WndkdmJxdTBrQWNQWWh6U2dtSzg5RlIydmd5VmlQNUJHV28z?=
 =?utf-8?B?UWdFcTZuUml1Y055djJNK2o3VENhVkpiTDRCZDlKSDJGR3hKc1BwcWZxeUVl?=
 =?utf-8?B?TWFMdnFuSmFDRm1tMDYvd2pHM1prZHdSZE1RaTlXSzBQV0J3K2YyQXZjeThC?=
 =?utf-8?B?cjhlOW5MWm5ZS1pjbngzT3NJMXVpVEN4V1h2Z1F0czZhZCsvNXIrbk00eEpL?=
 =?utf-8?B?UHJSeTc1bkxEUkEvSjlyRGc5d3Y1SGxFRXRNaDgxQmhSR3VpcGxDcVdoNTF4?=
 =?utf-8?B?Unh6aXB3Q0JwNWJDcEFPSGRaNEdLbkdlTGdJSTBJdnVoaHRMZmoxTFR5Y3Vu?=
 =?utf-8?B?QkxLRHd1NzQyWjQ1NE1BeUVuSW1FYUorTmk1eFEvOHFvTGQ2L3pEUTQwTFph?=
 =?utf-8?B?UE10ckd2SVB3NEF3emFWYjRSOUpPdG5HWmZJc1FUVjZZZzJxWlI5bGZ3ZnVj?=
 =?utf-8?B?ei9tcDlCb1JweW0xTm5vU0k3Zmh6YUFEeEtaelNCdjlMdFU4U3QvRW5NTm5O?=
 =?utf-8?B?b1J6UDArWTE3NUo1Rkh3LzVzZHFjRGgrZ25PcmtxdmhVUkladHMzWG5UQkVP?=
 =?utf-8?B?S0RsQzlnbDA4bTdFL2x4aWtyWWtQb2EyZW5nTUI5MjVpZXVveTNHUnpQMDNK?=
 =?utf-8?B?NHFzL2NBT1VaTEZSY1lGSDVPQURCT2VTMjNSdmI0SjhUUmNsNmpveTUzU0N4?=
 =?utf-8?B?Vlh2MVNvcHc1YnlWOFFjWU0wV3dPb3E3bENlK1BQUWJ0a0QyVndvQkNhZXVp?=
 =?utf-8?B?YWdkZy9hYi9RK1lLbVBjbkQzYTM1a1BDaXlGZ3NiTzVoWGZNcXhOeVNwWTFl?=
 =?utf-8?B?UDhtY0pCcnY2YmZ0cS9GZThGTW5GLzNiZW1ETlJsRjdUQ2pGK3VGUXRBTkVY?=
 =?utf-8?B?SlZMRTdQRFRMMmtzMHJPTFphejdyVllJMWRiZmdnUFpyNXE0d0YwSzJYdCtv?=
 =?utf-8?B?Y3dEV0NRaWNEejdCZGhlMEpXdnRZZzJ2amVqSDJ2QitRM21Sdm9xZ3A5N2M4?=
 =?utf-8?B?RWt0aXR5R0dlODEvMlN6eUp0ZjByT0VJc2F0ZVRqRWd4WUNPWGdMMCt3Uk9G?=
 =?utf-8?B?SlNCNGFSbVFXK2owQUVDU3Mxb1YxbU1CV3VuVGpTdjlSeE5SbGRwbk8rcGp6?=
 =?utf-8?B?MTc5UnNuclR2MjIxdnNVbVVsdE9oK2hFaStLTFRLM0Rwa3RkVnJsVVVlOUNX?=
 =?utf-8?B?dWxoY1FEU0tBZU1kM3liZmhiY1plcFNlUlRoNmJyRm1GQ2V3eTZKOWl3eXlD?=
 =?utf-8?B?SVZNNE9ZUmZWUG5YcDBXYmNLVGRZcWU1YUJXZVJ1SDNBcWJ1dTBYSEloT3Fn?=
 =?utf-8?B?NDFJQzNrNlpZYXF3WWkrWU9sN0N1L2R2ZjU1TysrNjF1N3RaVFVLbVRXMGV5?=
 =?utf-8?B?VWxldWVxZU82UHhvK2FjYUsvbHlySkhUb1VvMS9EZlltcTVNNmt1MG45VW1G?=
 =?utf-8?Q?YDgUCPKFGvcrVV60hrYv52eAe?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:08:50.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65bc24-7252-47ce-d825-08de51dbba85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8209
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

On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
> a 4-byte alignment directive after the __u_boot_list section. This
> alignment directive only advances the location counter without padding
> the actual binary output.
>
> When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
> data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
> not an aligned address (e.g., 0x41c35a00). So, when the FIT image
> containing device trees is concatenated to the SPL binary, it gets
> appended at this unaligned file size, causing libfdt validation failure.
>
> To fix this, move the alignment directive into the __u_boot_list section
> itself and make it 8-byte aligned as per DT spec. This forces the linker
> to include padding as part of the section data, ensuring objcopy
> includes the padding bytes in the binary and the appended FIT image
> starts at an 8-byte aligned boundary.
>
> Reported-by: Anshul Dalal <anshuld@ti.com>
> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g=
52f07dcca47c")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> 1. Get rid of extra ALIGN() directive, replace it with a comment
> 2. Carry Reported-by, Closes and Fixes tag.
>
> Link to v1:
> https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
>
>  arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-b=
oot-spl.lds
> index 3bb759d8a1c..5ad169a37b7 100644
> --- a/arch/arm/mach-omap2/u-boot-spl.lds
> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> @@ -35,9 +35,13 @@ SECTIONS
>  	. =3D ALIGN(4);
>  	__u_boot_list : {
>  		KEEP(*(SORT(__u_boot_list*)));
> +		/*
> +		 * Ensure 8-byte alignment at the end of the last section before
> +		 * DTB is appended, to satisfy DT spec alignment requirements
> +		 */
> +		. =3D ALIGN(8);

I wonder if there could be a better way to handle this constraint,
currently we have two major problems with this approach:

1. All platforms facing similar alignment issues would have to modify
their linker scripts.

2. The FDT only gets appended directly to SPL binary in cases of
CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT) as per
the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would have to
be 8-byte aligned as well as the SPL binary.

I wonder if we could have a new make target for say
u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optionally BSS
+ padding for alignment) and at runtime we modify the fdt addr in gd to
point to the correctly aligned address?

>  	} >.sram
> =20
> -	. =3D ALIGN(4);
>  	__image_copy_end =3D .;
>  	_end =3D .;
>  	_image_binary_end =3D .;

