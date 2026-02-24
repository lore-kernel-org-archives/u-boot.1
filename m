Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3832EEC2B5
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A70F83642;
	Tue, 24 Feb 2026 17:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="F4wyOZs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FF783DAE; Tue, 24 Feb 2026 17:43:28 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B22682BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDe7mKEKj9EEBgk8YCBVpQaTHI1LGwdzUJPJK71vu5nj3ZR+ZMsD+ww4kFzSLIdfMa49M9FjwS9OQOh+/vjnyjKdfJFEve+/8fAzsg93ogCm6I8Np1RzKG3MradC2hQcZHFUXxsFBY8FK2tka9uKblQWl54sSrHPDXO5UmJULkSHEHXqYOj6pgjw59MpU2TJF+9Ip58VGby2e9cU7JP9z8O5PK8U+5OycxPrrK1B2bm/tzJvMSmhvqFLlCL2rTuAEBmN4AvRcpxCoQfcs97eLOfPqnKgePCqEvEpiGj0qXzrwIdDFF4UQGxxJIYO+NfM77SGdlCBxOUgIF0EIG4s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3UhtSIMoOC4QvMYmS25R8NxH3/v51bCCkns7HRyTZ0=;
 b=eggbjqCDxiH5tfXyJDNovm4wgpmcxEIOJo/h2DckaEbmUFzZg7YwK5YyRsiGsSvMhh0mLQrTJzq6KUQYBuoAPDjnkJqDaXHA0/i9k2iv7B4bq6dt+Tuu9JZROfADlBQidkglDStON1Y4M5aH7HqqgW9CuRiAEV4wEyuK121FTv0mkvoQ5tJIDapVQpAroruTOO2Ktr4zQxCMchzHFIi3ue0JcZRZ5vnQXNwkzPifkqbAKCtspwBrg+IKH/+ncYEahc20/zrztCh6wDvbV1nq5daiW6AvH/nsoaMJU3VhtPA44b6KhgvAIvxZFLcrQZ533b9j8DlocMfBmNr8RvsCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3UhtSIMoOC4QvMYmS25R8NxH3/v51bCCkns7HRyTZ0=;
 b=F4wyOZs3Yo9QsygIsx5bwXT9AXSGIxowcYRG1nBrsYf5RctRCpub/XLaSM0jXfFg7TKJYmg9ZY8HXMyBfQzG/EdfbRhAnFQtkfpZvA/3uJecIyQ/kr1qT10A+nKLn5dvsHW0u7TSX2lErHWPZ/QZG99wwf+3AuQJAxMtYgQXv43VoOatNAHTzSpvfqBkQxFcTS+cUf76HOpl32+tPoJU8cKiOFfFOmMdmOLbnTXJOmJ/L6ftNckWVt+hF23WpE8Cgzbtwpw2isjm0JF8EHobyiuEBsNcp9Yz94hyXYOmACdbNoDiiWA/m2VAafgVV8F9LS7+Rsz649l0AjKKbWQp8Q==
Received: from AM6P194CA0068.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::45)
 by VI0PR10MB9577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:31d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:43:21 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:209:84:cafe::20) by AM6P194CA0068.outlook.office365.com
 (2603:10a6:209:84::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 16:43:21 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:45:11 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:43:03 +0100
Message-ID: <b9dd138c-1361-4ecc-8db1-c62a7fec6861@foss.st.com>
Date: Tue, 24 Feb 2026 17:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ARM: stm32mp: Add STM32MP21x support
To: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, Simeon
 Marijon <simeon.marijon@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|VI0PR10MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac7acd5-be3d-487b-04dc-08de73c3d1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVFWSHNLVmVuQlgwY1JaRkN2YjlubHgxeXZqM3pMbnZBVHByQXVMRzV6TVA0?=
 =?utf-8?B?T0xuWDBTMGIzdVorSWdtS1Fna21OQmN1OGQwNGlwZzB5eEJLb0FlSm1keHg3?=
 =?utf-8?B?OWRhWS9sRWxvTk5TRElKTnJXbkVXcjM2bnF3QVUwckNiUEQxZFMrUG9GTXJq?=
 =?utf-8?B?djBjT2x3dW5UV3RwdXc4aStzTHk2OUR2SXhoT29YREw4SnRFb2oyckNXSDdS?=
 =?utf-8?B?T2hJVjM0ZUh0L1JNdlNVRHRQUWJJempvSjBzOGtTUHhha2FaT29HTzRmWTl6?=
 =?utf-8?B?MzBUSHl0bkUxanRreFhHU2pGR3lHK0VjYjV0aWY0blcwQWl0ZWUrajNZTzBJ?=
 =?utf-8?B?NFpQVUwwaHZ4bXhnU2t2U0NLcUlGb04xdExtU0tMYVUrL1drUEJPbGwwMVBI?=
 =?utf-8?B?OXZnUXRsVkFGV1ZSOUw5OFRhNVJod0crS2M4cWozZ1pwZTRac245dExjV2tL?=
 =?utf-8?B?c014dkNISjEvVXhwUDBML0YrUEpxRURSakVaS1kxWGxJMHpTQ2oxaEVXTWVG?=
 =?utf-8?B?bTdIR2xXUm9oZENFU1hOWmdjcGFOYVZnV2JDaWtKUHltT21VaUpkZ29walU1?=
 =?utf-8?B?M1dBMmRNSnRES2xUaFJQc3VHSjVVU3NFcWNJSGpGWnpqcm1JRTB4UE9kS1VO?=
 =?utf-8?B?MkNwcnRxU1RyVytHVUh3Sk50NVoxUFBJOEppek1pRmN5NnlpSzFza2Jna0Nn?=
 =?utf-8?B?TkpITU9CMTNMcGxFZ1hxZVZtazlZZzUwRk9hVDM2YjN1R3lPS1FtNHdHNVNv?=
 =?utf-8?B?RHdUYVZLeFpNN0x3SVZ6d3pCTUp6MTZ2U3VoZTBLR0hsSXEzamhBVUNVQ3Rk?=
 =?utf-8?B?UUlIK3UzWWFOV29JQlk0aWtQT1pYeS9YdXo4b2puRmgxVUhZVjN1cjJtOCsr?=
 =?utf-8?B?ZmRPRGR5Mm9RZmhqcmkzOEdrSk9yWUxKYkNVdG1FVE1ESy82M2JISTNJWGhT?=
 =?utf-8?B?ZTBYWHZuNSs0cXNhU1VubHoxc1ByWUZLYmorV3VKWWlONXltSEN6WmErRzRI?=
 =?utf-8?B?LzNJb2dyR2dQcnppOStFOFZBUGM0cm1SS2d1R2diUDl2RVc1NGRYemV0dERv?=
 =?utf-8?B?L3BuV0VvUDloRXM2N1k0aUcrQkFzSkhQSXJEUXdYbUt0cVRKTDM3T01yVDcx?=
 =?utf-8?B?MFNWRTV2YjQ3RFJKWlhOQ0hKY21tMStpVW1EeGh4S3VOdHYwSGhaLzZzK0Y5?=
 =?utf-8?B?Mm1iVnNGSmZVQjRETldPSXZjRm9JQmxTWGVucmpwQUtNbkZOUmZlN3Z4bVN2?=
 =?utf-8?B?Ui92b1hnRllaZmUxSzc1VXpsT1VQZ0RjRG9zdmVMMVdLQ1ByZWQ4YUdEOCtK?=
 =?utf-8?B?NWNsdGtIMDhDamxHVXo1TGdDYkNBNklzVlZYdEFjN1JGejV0SDBBQytFYjlh?=
 =?utf-8?B?dFFuZVNlYzEvMzgxSVc5TzNQQ2hZelBGUnErekhIcDZLL2g1T2xvdzhUV3Fp?=
 =?utf-8?B?MUNta0JTUVRmOTQ0Q29BdFRidnlhZ282dGtCUk5DRUkwMEM4aUE2K1NENjQ5?=
 =?utf-8?B?cHY2SXBlTXlBS1Y2MkMrTzVqc2FBY1l2RXg5azdIeXFXR3hLRm51VjhoMCsx?=
 =?utf-8?B?Ri9Ya0xBeHl2UWxiOVprQ010TGJlWENUMlZzdndkNHdjM2hubXBvS0pZVFVn?=
 =?utf-8?B?UUR2RG8vZ0IrZkcycXVyWGdxcUZhcGpkbjNoc2N1Nm03QUhVRVIwQ0o1ZHZD?=
 =?utf-8?B?RjVhaUh6ZGxhMmpMeGJPTjJja2tjWC9HcjQrUlJCWHR3VThMaERhMlNsVU5I?=
 =?utf-8?B?eVdrS2x4SFl1TkkwNHZreFVjNFNPbExTNWZ0V2FYNmpmTkxBTFkzUm9DSEtk?=
 =?utf-8?B?Vkd4MlZTNm5sWW1xQkF6dGZ2UG15ZGNRS0hCVks4R2E5TGV4VFVSNjlSZDlF?=
 =?utf-8?B?a3NOK1ZrZTdsTnNvUWVJM2FXdnNqU1VaRU8ydFRpNXFYemlIMURWWWtIbmZ4?=
 =?utf-8?B?ZlpJbGZuV1F5TU1DcXZnN2l3ZGRyZjE0Z0UzZUs4RWVwWXFvWisyT3N0aEto?=
 =?utf-8?B?WTVDT3owbjM0djhiT21zK0thZ2JYTm1VQW5HTUUvQXBuK2dvVU43TWtjSTVF?=
 =?utf-8?B?Q29Qcm5qU3VBWlpGL3dhRlJWVHJJaHM5bCtkaUE1eFh0VldiVElqQ1gvTG9S?=
 =?utf-8?B?M1k3L1dnVnJWbEJkTnlzTGx5VUZkQXpqaWVNQWJMUlpuN3FBZWlZREkxV1RC?=
 =?utf-8?B?aVNFVWNIVTkxTUs3TnFwcmJGbVdxMHJwLzdSdXlkRUFtQVdFa1hYbjdNY3o1?=
 =?utf-8?B?Uk0xSnZnS3lWQlY2anBSeEtDL0JnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MqyS49lexRleeHnfak+Azo73d53q0nsTHrVICqjkehriR3E48bqPnw4T/OIvbN017Qp2Ejum/f56HaQbBj+4HNsYmYlqCjneDVYzixjXgLTVsQJnUm3BLoGXzUQp+NRN5wraAvdsPqW4XvOmm9gQQtB7Z8pnVvJQRSFAbz1E1RkS+EOzqe71SgTgQrs9dkvicRCZHmnTfhY7cfh5mdqqq5cq1cJLYo6qC88lFq8HeKnl0aFDZDy9ukfEWSFg46QAQq/RqOpQD9x4+wzuu5RF0OzMbKvBIDzauoY7oTK4AuERiXf+pUkN7WKvrgzVK4qazExkWyir0eT+MNfUqkAVYSf1NO90ROtIteKhXJ80ehlUCmnBMapAHMroU9SJfVPE9biIFdKX4j/75AFn4T5PtUtxNpMT/2+JrlyhNp96DYRdfa8pbou0iFyzT4+ed/lJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:43:21.0728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac7acd5-be3d-487b-04dc-08de73c3d1f6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9577
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



On 2/3/26 17:49, Patrice Chotard wrote:
> Add STM32MP21 support which is an application processors
> (STM32 MPUs) based on a single Arm Cortex®-A35 core running
> up to 1.5 GHz and Cortex®-M33 core running at 300 MHz.
> 
> More details available at:
> https://www.st.com/en/microcontrollers-microprocessors/stm32mp2-series.html
> 
> This series adds STM32MP21x machine, clock and reset drivers and update
> cmd_stm32key, mmu, rifsc, syscon for STM32MP21 support. 
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Patrice Chotard (7):
>       clk: stm32mp21: Add clock driver support
>       reset: stm32mp21: add stm32mp21 reset driver
>       stm32mp: syscon: Add STM32MP21 support
>       stm32mp: cmd_stm32key: add support of STM32MP21x
>       ARM: stm32mp: Add STM32MP21 support
>       ARM: dts: stm32: Add stm32mp215f-dk-u-boot
>       ARM: dts: stm32: Add bootph-all in stm32mp215f-dk-u-boot.dtsi
> 
>  arch/arm/dts/stm32mp215f-dk-u-boot.dtsi        |  19 +
>  arch/arm/mach-stm32mp/Kconfig                  |  27 +
>  arch/arm/mach-stm32mp/Kconfig.21x              |  37 ++
>  arch/arm/mach-stm32mp/Makefile                 |   3 +-
>  arch/arm/mach-stm32mp/cmd_stm32key.c           |  70 +--
>  arch/arm/mach-stm32mp/include/mach/stm32.h     |  12 +-
>  arch/arm/mach-stm32mp/include/mach/sys_proto.h |  22 +
>  arch/arm/mach-stm32mp/stm32mp2/Makefile        |   1 +
>  arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c     |   2 +
>  arch/arm/mach-stm32mp/stm32mp2/cpu.c           |   2 +
>  arch/arm/mach-stm32mp/stm32mp2/rifsc.c         |   1 +
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c    | 192 +++++++
>  arch/arm/mach-stm32mp/syscon.c                 |   1 +
>  board/st/common/Kconfig                        |   2 +-
>  board/st/stm32mp2/Kconfig                      |  14 +
>  configs/stm32mp21_defconfig                    |  78 +++
>  drivers/clk/stm32/Kconfig                      |   9 +
>  drivers/clk/stm32/Makefile                     |   1 +
>  drivers/clk/stm32/clk-stm32mp21.c              | 709 +++++++++++++++++++++++++
>  drivers/reset/stm32/Kconfig                    |   7 +
>  drivers/reset/stm32/Makefile                   |   1 +
>  drivers/reset/stm32/stm32-reset-mp21.c         | 136 +++++
>  include/configs/stm32mp21_common.h             | 126 +++++
>  include/configs/stm32mp21_st_common.h          |  51 ++
>  include/stm32mp21_rcc.h                        | 651 +++++++++++++++++++++++
>  25 files changed, 2135 insertions(+), 39 deletions(-)
> ---
> base-commit: 66891ffb14920e35abfafcae795cf4604de6682f
> change-id: 20260203-upstream_add_stm32mp21_support-0b0ed074dda9
> 
> Best regards,


For the whole series with fix on patch 5:


Applied to u-boot-stm32/master

Thanks
Patrice

