Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C6FD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFBE83CE3;
	Mon,  1 Dec 2025 19:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cSMpCF40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4931A83CF2; Mon,  1 Dec 2025 19:22:50 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272CC83CAA
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBNZ/OXmr8ALnbYtbeD1EJEF7CVArHBVPAy53D/+pDVuDEZEMyFrEXuYzS6ngUl/u0FT0Y8417ARzuK3jLrGWVYrEnv3rs2bMPFytE0rQmMGTBLeJMWFKfj6s9ZtsISfSrRHDXzoPyrfNVWUSlmMJuFDCjMcO+1E1zqlwc/CuXlqzpkAnEYuiU4m0BE1Ky23DCh/tE1Z6rxOgY2Ty3roTAkk+N9FhHc7BRScuEQjaLzcyTSlIFY+CjNwO12Hk9IQ8TdKRnGCry8Nk9Egp8F8Q0veZNThDJu51PulGTPbNAoav0/eaN1nGJwJGYv48xiLQRUja/9/Bgxf26spgEQRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyE6U+zzK/MUnwQxjNDXUyVTNcaAdUt9NI1njJTa5HE=;
 b=FHfeGmi13Kq0U4vSQLqYWoMjyUYspx9XTyoaQQs29I9qvLYJPkrcuwTf8KK2bwttDDaWdcfAIbh7qNR1ykS/hyBJS3tqG2ef6o4qxXjPUpLubW2x5jpPFikN/Nbha77KrHPOadkCs7mMFcJEFn8SHDG3/oN/5wFV7GCyXB++U5b0OSA89OsJ58G3QhWuPoVViVPsYHCcIKo2hN2s7jHZ8pp3yPkfOQhy5YtnIEqsT97lydDZvnmzzWzDBd33NsgfG9sB20n9SzHk67IScVBRhgLsiWQ57tvA2kSxRlVrVVp6KHVsLf1ISin9KNnPkk7LigZJ4YDu6Q0krJVoBnadxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyE6U+zzK/MUnwQxjNDXUyVTNcaAdUt9NI1njJTa5HE=;
 b=cSMpCF40eBq/3qXKptKUyw/C74PNCOULYCRd40eTJQKpG5Qt1DgzdjbJskchJz2GBwWbhLFrhWZYNIo8V79DWRSjlsXohLbiqg6KF3H2AH3LQw7VmYdKqRgONIGFxA3yfH4RncjqtcPm6zG4GT2ByGEgXOHSFBnqubImBwmvf0s=
Received: from BYAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:c0::18)
 by PH5PR10MB997757.namprd10.prod.outlook.com (2603:10b6:510:39e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:22:44 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::93) by BYAPR05CA0005.outlook.office365.com
 (2603:10b6:a03:c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 18:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:22:41 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:22:37 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:22:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 12:22:37 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1IMa4E890350;
 Mon, 1 Dec 2025 12:22:37 -0600
Message-ID: <5f575e86-a687-4427-af8a-108f08ee4d39@ti.com>
Date: Mon, 1 Dec 2025 12:22:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am62d-evm-binman: Update DM
To: Paresh Bhagat <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <v-singh1@ti.com>, <khasim@ti.com>, 
 <anshuld@ti.com>
References: <20251128110210.4143342-1-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251128110210.4143342-1-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH5PR10MB997757:EE_
X-MS-Office365-Filtering-Correlation-Id: 73aba8dd-8fc0-42e9-3cfe-08de31069ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qlp3eHg2U3dDcDg4Y2FTWWRXQmFibmdEVXQrUkNVTHpOU2FpRDBlaDNmS2ZS?=
 =?utf-8?B?UHFWUHVzQUxUV3QzSXYzN09MaEh2REJvQ3VuMnVoQnNPWEtZZFo4dHErVEZJ?=
 =?utf-8?B?dWJHV3ZmZXlrL3Urc0pKM0hRa2tqZEJrNVowWXJvVWFGOXFnbFRiSnVDRDF3?=
 =?utf-8?B?OTg2Ti9wWFUyUW5QWUY4WlNzc25vclhpSml1dnYxTkJsK3JZSERSZThIdVpa?=
 =?utf-8?B?eHB1RW9xbDF4a3BBMFFBOUNRSk80ZW5WcjRhTFBQWUNWUkZFdmozRnZaWFdx?=
 =?utf-8?B?ejJMWklWcERSVFZNSGREMm1sUFZCT3FYYi8xMjhSOUU4TTJWNnVDYzRGUW40?=
 =?utf-8?B?V1BabEM3WTM2TjhxUStxNWxSQkp6QjRRbEtJSGFrQUpIU0l0NVZzaGcySWNP?=
 =?utf-8?B?MXViSS9vV0FnY0t6ZEtjK002dDlSclFTbmVuTVFWZFIvKzY4U2RmekVWYVU3?=
 =?utf-8?B?Q3pvWkxaVWx6TE54bmZNM0N3ZEtYTTcyR0FrejhTa0F1WFJLajR5TDQyRGM4?=
 =?utf-8?B?L1hsL00rQnBzR090SWJ3OURWMVBjR3FoY0U2RzdYdlV2Zlp6N0hhOExjdEY0?=
 =?utf-8?B?ODNEaDVRM1NFTzRJemtWWmJPUzNNNjRXQlBvbjAvTlV6Q2lLeEJmNXFJS3NP?=
 =?utf-8?B?bms1d0hnK3FyZGkzSnFkUzU0YVlhbEdNT1N4aEFIZFYwWnpNU1pzSXpiSGNy?=
 =?utf-8?B?bzFXdVlRd3o3UTBBZ0U3OG9mTVo1VlhWZzIxTW9MUEowQUFmTmxJS2cxNWpF?=
 =?utf-8?B?YTVnUzNoNHFCbDRWbmFvMDFBNTU2S3E3Ujk2dktTUlhnb2ZqWDZQY21YQm8r?=
 =?utf-8?B?ZmF0RG94eUR5dldDUnJud1JUZHo5bWlvNEkrQUc3bE9xVGdJZlp6emJlNUs1?=
 =?utf-8?B?VkhrQTEzcGEwaDJLZXdPQkw1WGp5SVVHYXkvUy9VL3UrWDZQWWR6ZThJdmZx?=
 =?utf-8?B?K1plNnU3cmg3ZnRaVkxiTStQNzBWbjgxTVA5T3NoK2FQVFVOOEJlL3J2SG5x?=
 =?utf-8?B?TzZZOHZKTVFEOHdwL0FpclA5TlNybmRlbkFTS09uTWttQkJzNXVVaUw5SktZ?=
 =?utf-8?B?TDRybFFLNS9YQTNKTFBrSVVaeExIVkxDL05LcWI3WHlKT3dKeDFmblFKbU9Z?=
 =?utf-8?B?TzJVVDJQL2d3aGJLY0tyZlgxWmsrQUxpcW03aXV6U3lJRnUvem4rWFFNRHdV?=
 =?utf-8?B?M3h2VmZ2djNGTTZRZjJheUh6Zmx5R2IyMU5mcHlmNThIWng5eE5kZXhjakZI?=
 =?utf-8?B?aHM2UWFMemN3T3ZvVllzOGVqWE5yQS9zQUZ3TnNLRFN1UUxHME5UOTNUQ0Fv?=
 =?utf-8?B?KzVJSTdqU2hFN0pYOFp3N2pnWkh2dVNQeVpFQ3BSRkZVekNDVW5Cc2lFVnFY?=
 =?utf-8?B?RlhENUlUTDh2UFI5NnI2Qk1nWlFlR0Vzam5XSEdoblVLNE90blQ2US9xZ2d1?=
 =?utf-8?B?K2p2elZoY3hPWDZjY2wwS2lTNCs5YklHUFpjQ295QzljOXdYR3V4Z01TTjhJ?=
 =?utf-8?B?dlk4VWRvdFcyTlpLWm54NHo0K0Z0bkhDcUhUMzA5YkdFUzVvOGhsVEN5K1RY?=
 =?utf-8?B?VGp4TEZsczNlbzhXdmROeFJ3c2xleWtUWGF6TUEvOG5aeEdqbEVUVFVaeU90?=
 =?utf-8?B?TkVHOUh1djBMeXpNVC94QXlUVG1Ec2tTU0JOUXhWNk5vZlJYWkVIblRiS1Zr?=
 =?utf-8?B?LzdseVFDaVVOQlNQaWpzbk0zWVBPUTZMTmU0L0h0eXA5U0wxMVNMUHFBdFl5?=
 =?utf-8?B?cHpNRmp3UmppaFVYUXBMUnZHcjhkL3I4QWErVHNOWUVaZVd1d2pyaldPNHJx?=
 =?utf-8?B?VlBNWjJQUmQ4YmdiR0thbTJRYm5UWllEQ0NpOElLcjhJM2tmMWt0YzZvem52?=
 =?utf-8?B?NlZnMGppNm5zRTY3a1VubVA2RXA1endLRlZ6S25FZmlodklQcnFMbGl3S3I3?=
 =?utf-8?B?NnUzVm1sTllVNlkyV0JDcmVRYTNCOWRiYUFOakx5ZTVNR09HSy91cDZKUS9G?=
 =?utf-8?B?VGIwUlhJby9tSlN2RytrUEtQOXpYVkFITE9Za3VmMG93TnVPUTh3L2kzVlVN?=
 =?utf-8?B?NG1jK2xLVWJJc3FRK1l0dkIrdHZkbVVic0VtbjVNTkNQSlM3TWxSTm1PbDNw?=
 =?utf-8?Q?EF3Q=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:22:41.9992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aba8dd-8fc0-42e9-3cfe-08de31069ddc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997757
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

On 11/28/25 5:02 AM, Paresh Bhagat wrote:
> AM62d previously reused the AM62a DM. Since a dedicated DM is now
> available, migrate to device specific DM.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
> Boot logs
> https://gist.github.com/paresh-bhagat12/38bce75c43466b5074271f4cb2ddc3f3
> 
>   arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> index 7bf0e955645..3a0ab9f8b2b 100644
> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> @@ -101,4 +101,12 @@
>   	description = "k3-am62d2-evm";
>   };
>   
> +&dm_falcon {

Not related to this patch, but just noticed we have a different DM node for
falcon vs regular, would these ever be different? Could we reuse the same
filename for both, was this a limitation of binman or an oversight?

Anyway for this patch, LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> +	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +};
> +
> +&dm {
> +	filename = "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +};
> +
>   #endif

