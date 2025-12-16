Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189D2D5C0D7
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B45800D0;
	Tue, 16 Dec 2025 09:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rnfdZzVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C95180107; Tue, 16 Dec 2025 09:22:56 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFB780077
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpX0pDqzOnvci4vQb1iTiZgSDa/LMyXRjh+peXReXRaIiB/RBRBWFpj95LVG1v7ZiW6xRsSXMrlCO9o01GcxVn+gDe7bn2n3UZUjtePJGGqWK9kJZjy7V81tgBx8GhwRLvQYb6OQtaDm0weGSAYsHUIzG5m6nxXQ2H5OxSA8dijmYdQ9OwCBOBx8nGFS+0VeEe+CB6by5jPCDq2gsuw6+xNdGNR9KtPdpf3WP/Lq0ZdCFBAw1VxUOh47054oq6gczgts91Xmi4toEmbo7AWMEo08kudhmyJ/lI0d1J6W3buqTN6q8vJfC9g7xTWCnVkdad7C2dpddrPXS4ssTtK1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=initRIrp/awaP+bAC3P/6BsaxO2FixBUKWhAIyo3qPo=;
 b=k+ol9Wz1K1yh/+AfAQzJNuIBZD3p9CAfcfl7HGTAMkYCphogoXTuJuH1DpNCZ89kgWRDOpdse0a4N1zNfkpz+3iHKSpF3OtKELeXgjjd6+2ZNHX1ERpjNarny5D1GizCBd2C9DGm1+H/4nBNCf/xPpSspEoYTrKokvGb9hhW3mPvWvIMR7vBYsIixbZYVLIeMz05e0uKOmrWeDRG++uDL4HIKylg6NaFLjl4mnhkxy8ZXAK92oOl4jGVp5vHOE3O3/jNHzIvruPo3S+bh1N6DD1HvMMsXR+zihDbPW8J6rj1bZkWjm6qqIIjeO1bZcD0UJdRFZEh8j9qPg/LmX5IMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=initRIrp/awaP+bAC3P/6BsaxO2FixBUKWhAIyo3qPo=;
 b=rnfdZzVMJa54UMd1JV5j90wTwHaZjfHV3GgYChtkaeIiPFclFNSXY8hZpfL+p3/PcOiIaOiSdqYislB2cX80vlPg9PgiKAKwzb7giK7HGSnxQ8mC66YyBy3ACBB/rgTEpcQjIcArDzOUkHyArezTbgNAFx7DXBFNSUiqyeeT/8Q=
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:22:50 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::b8) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 08:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 08:22:48 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 02:22:43 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 02:22:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 02:22:39 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BG8McXB3816665;
 Tue, 16 Dec 2025 02:22:38 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Dec 2025 13:52:37 +0530
Message-ID: <DEZHV1ELFZ43.E3FN619R0UNY@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
In-Reply-To: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6e8453-2a34-4976-02d4-08de3c7c4c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1pKYTRzcThGaGdTYnVjNk02S0NlYjZqNCtMY2RNeldBNkR5d0VaT1pRVUMv?=
 =?utf-8?B?bXVJRThnckxWV3dTTUpaWTgybDRuS1lHamMzYlRZZU5KTUM3ajBuSE1HdU0y?=
 =?utf-8?B?TDBveU1UM1l5SUxIVEQrWGw4VGNGR3RNbmRaY3NmV2taQk5TNTIvSUV3Y3dO?=
 =?utf-8?B?SnpIM1pTMmtaK1JaNnJSdG9ycEc0K09qT0E3M0Rnanp6ZExBWE81a3JmMTlQ?=
 =?utf-8?B?YmYrZWNBVllPcDh0RzVIWkM1VmNvclFoVGc3LzVsR0d2MitHWW1BRndoY2J3?=
 =?utf-8?B?TEl3TWlHNWJISVBNV1lWMWtiL1pVSjVDVXJEZzMrWTlqa0NmYlR0YitQaW1V?=
 =?utf-8?B?R1ZwNUZBTHNhUHowNVFHNFh6azNISGxmQkpRZDN2NWlNUktKbXBDbWxjRkFy?=
 =?utf-8?B?emtaVnFETFdVOHV5ZzdlSm5uaFZRQnhsRDFXMjA0L1JKWkh4d0ptV251ZFk1?=
 =?utf-8?B?L3l5TnJiNlIwaU9zL2NFM2kzZ1NKM2d3NDRzemhreUVmV2xDRUo3MUlkY0xR?=
 =?utf-8?B?eFE1NTE2Q3dzNk9TQW82UndSZXc5UGFvREtvWFd6ZklDcXc4VnhieTlYS1No?=
 =?utf-8?B?SDVxKzduck4yRDQ3cFRBY2VLeXE4OWZaazdMMnJ1N1AyeDNhc2ZhRGVIVXVM?=
 =?utf-8?B?c1A3bDZuTnhGNkUzWGpPL2NzRDh4c3dDUWpEOEdTampPeUE3cFNnQXFITFNi?=
 =?utf-8?B?ZTdseEhoUW1rWlFMWmNwOEk4dXNrSFhJaCtlSlNFSFlBeHdSNW5CUUJNaTkr?=
 =?utf-8?B?dFFubzJpYXMzVk1jcGk1M1FZRUxBYUtKZ004VlcyeXc1aVI2VktyTmZBN3Zv?=
 =?utf-8?B?NTdYU3AwWEhGRjFRbXNMdEdTdjFQbVlGQjAwRVlPYUFHay80L2lnR0ZzQ1hR?=
 =?utf-8?B?VWwraGh1dlpxa2tiRGg5anFrNVlHUnNpb3l3ZzJxczlZaHExYWNjck16RkZ4?=
 =?utf-8?B?UHhVT2Zyd2FyU3R1bW9oL2FGYW4vcWNxVXBKMHhXTjJWTFk2eW8rMk1jczRx?=
 =?utf-8?B?NVZVQ3N5Nklmdk9DT3NKM3NoVDEzV2tyYzJ4MVgzZXZVem5CSjFGdlhwU0RI?=
 =?utf-8?B?ZCszaGIxa3NQaWVCVHpadGtDenk4K3Z6WlVSQzhwclRyR3ZFaGprbmZ5dUpS?=
 =?utf-8?B?bzlFUElhb0Y2YTlYTFZDekhjSDhBNUh1Qnkya2JOTDk5YVF5dkJ5bTgxb0Z5?=
 =?utf-8?B?YkNQVWtkSzlsZEc2SkdSZ3B0K29adEFnODVGcUlpV3JkOTVjWlhscHM2b09Q?=
 =?utf-8?B?SjhleTRtTG1yZFZ6dklhYittWXVaR3pMN3liWUl6VjlMT1NneDNURjgzRXZT?=
 =?utf-8?B?TUQ5NHdoRTlHc09NNU1GdkpYcnZhRzNhbkx5cnNxWmoxdlhFdWdSWEFhMUJQ?=
 =?utf-8?B?U00wL2hja25WcnZ2NW1NcnNRT1QxK2N6S0RrOHVPTjJPOXVRYk1WUnpNUkhV?=
 =?utf-8?B?UWVnd0VKVGVHMWp4QTBpMCtLV0ZaYnlGdWhlemlOMGZVRXZHN0R4U1dvZFhh?=
 =?utf-8?B?UmRzTGQ3cmtwL0sxdVZBcEUyVXB4eUlKSjlFUjJGSmcvNm8wU1pURFNheDZs?=
 =?utf-8?B?SDBHdVhiUitGdUM4aTQ4dXQwSkMwS2licnBWYW1PS3Z5SEdvS3dNSDdpUEFh?=
 =?utf-8?B?ZnVweTdTS1BCZ01Fcnk1c2d1c0xDd3VWSitUakpXUlFLeW1qUi9GTENKdS9Q?=
 =?utf-8?B?LzRSOGlyRGNBTzBVang1bk14SHNQd1ZyeWo0TW5rVU5MWXJ5eTFmQTZMakx0?=
 =?utf-8?B?ckFqNXRtS2tWL043T1dlNWFYUnMyNnpMZjdGUWFOQlcvWXBrRzNxa1JLQS9o?=
 =?utf-8?B?QlRzM21XWVRzR1NnYUVCNmJrZ1FsMjVlRStsYXhOaXY4MEVnTWY2eHh4REJP?=
 =?utf-8?B?QkwybzB0eEVLSkVmdFQxMHQvRmpMdnFpSU9JUndtUU1wMVlaWG81MFl4QklZ?=
 =?utf-8?B?SW9TYWRIWE1IQkVZaEtnRVhXOTR4Ym13RmxLSXhJZDh6cldJRGFUTmJraHdj?=
 =?utf-8?B?K3hoSmlYZFlPQjhiV3FWR0l4QWROTFZvZzhlb1FXZFdEbllwNHNQa2NmSm91?=
 =?utf-8?B?WXNEMmplR0xYTFBXSWM2UTZ2U3JBZGtQK01LcisvM0JtYS9NMnd2Ty9xL2pQ?=
 =?utf-8?Q?TcfQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:22:48.8406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6e8453-2a34-4976-02d4-08de3c7c4c73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
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

Hi all,

Any updates on this patch? If possible could we pull this fix into
master as well for the 2026.01 release?

On Thu Dec 4, 2025 at 4:42 PM IST, Anshul Dalal wrote:
> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> made mandatory in order to use %p which would earlier have defaulted to
> a 'long' print.
>
> Without this config symbol, k3_sysfw_dfu_download fails to set the
> correct value for the DFU string with:
>
>  sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
>    CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
>
> The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
>
> Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for all K3
> devices since the size impact is less than 100 bytes.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v3:
> - Handle setting the config in Kconfig instead of the defconfig
> - Link to v2: https://lore.kernel.org/r/20251105-am65_dfu_fix-v2-1-ccada8=
9d966d@ti.com
>
> Changes in v2:
> - Remove unrelated changes
> - Link to v1: https://lore.kernel.org/r/20251105-am65_dfu_fix-v1-1-acc291=
11dccf@ti.com
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3db5474a05b..7756ed000b1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -830,6 +830,7 @@ config ARCH_K3
>  	bool "Texas Instruments' K3 Architecture"
>  	select SPL
>  	select SUPPORT_SPL
> +	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT
>  	select FIT
>  	select REGEX
>  	select FIT_SIGNATURE if ARM64
>
> ---
> base-commit: dca19206acf2af2d339087bb62aa0b8ee1b0e326
> change-id: 20251105-am65_dfu_fix-1144eec06b19
>
> Best regards,

