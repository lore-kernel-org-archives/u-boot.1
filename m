Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF88EE6F090
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 13:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62881840C3;
	Tue, 23 Dec 2025 14:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IhHcu/Em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4512E83F4C; Tue, 23 Dec 2025 09:14:18 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E92683EDF
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WINRlRI1BgOqwSg9Vs0BW9tPXS95kIOo/HkhJ6tSx1T4yVKCb57QfGqABTbUZDIrhBHoiO8akfSHdOY+CTEvJnweW9S7ppTRjxy88qZ7HsX4ChP113DjaxKLvQLelNtMFjEShxIL0/5BqNxoeCEZXJEHf63OCo8/i1vWV2Msk9aLsEFW+JWp2CtNlwWvG1a93K97al8XD2iIb2AeT4gu5gCgfUWdquIwthZJHaMEDZV439iyAIFgPpymsYQloQMLaQOB5OadgkDqNH1MQKCFKUv9nkHQcKr/eHB5N1AXPc3cTOfUECNE87FP+n2Oh9awAtmC/aUq7v/CnJMTmWciOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAljGktZBnaP0n/Mcyq7TjsvETijQCRujgVqiFiPL1c=;
 b=LyIU04IuATQJ9FceiL+tgkbNKWmTIgmJ4aTNuvT7b1ZwDSEqgGKxyM+gvHGwLMdOkDJeeGOf1OavD0Kd4x4RrDFNtjEdpx8J0QbWeiK1Mny0Kr30hzaTwfjXfB1NRbAz3qGAvYvbyxMtWGeCbUXK4nT5KFtciDA5WjY5RdICPZTZ0VsfiuUnUFrTmn4fhIy9LdJvRd/ocAZCwwlk0TNCgQ65y/R6bl1TPzAMHZGdgWlkogHUPw31XU6PiEQfqSeVeVN0UvA1PaZnJu0+hW1kmVC1n6DU20dLWAbgwmIERnUQbcqJXr/jokFrwkIEsH9//eFxy5b9+g9kL3AR6n5I5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAljGktZBnaP0n/Mcyq7TjsvETijQCRujgVqiFiPL1c=;
 b=IhHcu/EmK+4GiVgolyGQupQZQ/S52xL1/wCIwI7+79KhxJb8gAtfdD4mgWbORWt4ja1zm3weHpV1/WS5sJp+4gRwl2UXGQ7OaecgnWhpMAexFqGButFDuWKVD4EoQg+ivoLwn2TtURZtUySwtaHMtIWAH1Twd+clWeUKC+jF074=
Received: from SN7PR04CA0097.namprd04.prod.outlook.com (2603:10b6:806:122::12)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Tue, 23 Dec
 2025 08:13:59 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::56) by SN7PR04CA0097.outlook.office365.com
 (2603:10b6:806:122::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 08:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 08:13:57 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:13:55 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:13:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 02:13:52 -0600
Received: from [172.24.31.151] (lt5cd2489kgj.dhcp.ti.com [172.24.31.151])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BN8DgQT2705183;
 Tue, 23 Dec 2025 02:13:43 -0600
Message-ID: <63de2fc6-efb0-41b3-b0c1-e7bc0c7b61f6@ti.com>
Date: Tue, 23 Dec 2025 13:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
 <20251222-topic-am62-ioddr-v2025-04-rc1-v8-9-e70fed16b166@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-9-e70fed16b166@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e693df-3ae8-4c40-2a2f-08de41fb38d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk1rTW1ZdjBKUDBwMlJ3bENlWVc5bVhVV3FmYnBsa1BwWllPbTBLVWgwdjhy?=
 =?utf-8?B?WmxZdlVTRXRpc0hXREJvQ1pWOXRkdkFWRVkvMEJHZ3BGYklEb0VRM0xZOUkr?=
 =?utf-8?B?OEJ3Z2xFUU9EKzR3V1I1cklBTVVwZ1pzb0RqZGMyWnNZTndxcEcva0xuQWRC?=
 =?utf-8?B?MGdBanVXNkZJMHpFSGQ0VXZtVVFQTThkWXpYYVI5OHRiVjhldkZTRmVYT28z?=
 =?utf-8?B?TG5raUFsaVl0WU9wMy94SEdnUStYdEtvc0tuQVRDL3IzeFRJVGVBZTVDRHVa?=
 =?utf-8?B?aU1QYzNIN2NvL04xamNBdGxFemtPczlFMDE2WlZqS2t3TkFaaE1SQU1VOGhm?=
 =?utf-8?B?M2pwTnVmTHFETG10Z0RkRG14UWRYV2VEMnV5TDFZZ3JmSG5QOWtocUt4cm5E?=
 =?utf-8?B?ZW9aK1l1UWllL2wrMGM5RW9ZV1NxUXFaU0Y4a09VRllZN05FR1F0SlpuS3A3?=
 =?utf-8?B?UHdoQjNsbjJiMk5Hdml4UjhjaERkbk9aNjN4K2NreCtNS3NId295VmNRMktl?=
 =?utf-8?B?VU8xTHVYK2M5T1FTUDdiaXZNZ0doNHlwMEhxcWIydmJoVEkrMlZpam83cFNE?=
 =?utf-8?B?WnU3ci9wK2t6T3YvSDhkVm54RCthbitXcnNZMm9ZVVFubW1hK2x5LytZdTl6?=
 =?utf-8?B?US9GQmFCQkt1WWpkUDRWQ1pETzNJNlVqSnRRcXF5dFhIZEhSWSt0bTIrS29S?=
 =?utf-8?B?WlN3dEdQbVE4ZmZZeFVkbDlNMXNoQVI0aE9CUEhXaDVGNkhBSU1hRlRDNTRu?=
 =?utf-8?B?Tm0wbVBybFJLc2g3MVo4eHZzd2h4N3k1UlVad1NkU1NnU1NLdFVuYkhoMldr?=
 =?utf-8?B?T29TNE9CRVo5L0p5QVp1T01ycjc5K01kclkydmdOclZxQVVRTytsVEtUUURK?=
 =?utf-8?B?bFQ4eWVNdE90eVR3UGxPVlZ0M21ybTNmVVYyTFJqQ2hRRUYrVXlENXlaSG0r?=
 =?utf-8?B?K3ljSjgxRVp5Si8xeVdHSVNYMXdSVHozeCtjQW1IajlPalUwTG11MHNaSXZO?=
 =?utf-8?B?YmtsMERCZTd3cWNlbTIvTm93aW9WeitjNXYwZW9hQWtySkMrTjZvdHVaOGVw?=
 =?utf-8?B?b3crRU1wTzN1VGtFcjVGc29QOUo5UEJIOUFzNnZpS2hpMDhOeUlaNGJLTXNi?=
 =?utf-8?B?Si9OTG1YSXRiRjVRM0w1c2dFMzJVYmRUQ2lvdXhibFNCQjRkRzZVVC82YnBC?=
 =?utf-8?B?a1ZYbmNZZXE5Qy9GWVZobkNKV2Jvb1dLY3pPVkszd2dic1JndENFdTJtNG55?=
 =?utf-8?B?aTBXalBzWC8vK2k1M1RnT05zYXNHajc2Y1pYbTZqSXpFZi94bHU5TGx2WHUv?=
 =?utf-8?B?NmRHU1g3TmhlSXBVNXZDS0hsZWxuNWF3cmlidTZhcEV0cXJsa3ZPeDlNTjJu?=
 =?utf-8?B?cWdQNnBkVDc1YUNVQ0xRNUpsUHRPTVVpK05lYm5WQWY1VXQ4dkNjeVhVcnBz?=
 =?utf-8?B?Szh6UWU1a1QxWUhFVmRuWHZ0Zm9pUDVXSWFCbGhsejBkSWtPR0YrQW9QMStR?=
 =?utf-8?B?Zms3K3dyeEIxTkgvSHYrMXp2QjFoWWdjbTZwV3lJQzFDam11dUhEbEpVQjR6?=
 =?utf-8?B?SHA0d2dWd0FrUldiaDhhSWRJMHRFQVcwV1ZpekxTNGE5M2hWOTE3T01XT0Uw?=
 =?utf-8?B?UGZoY0JKb05MbUJkUGRONXZ4VEhyWmxaTndPVGZmVEdjMlNZaW02OXZXaEdL?=
 =?utf-8?B?SXRrbFZrYVJlajhzeENVaDdVNWJCamR4SzZhVE9CMXV5VjhraUpIZ0ZvT2Mx?=
 =?utf-8?B?ZGRSTlVkekxidXhndzJYWEUzc1NnSU80OVFrZ0ZoM2VmUDNaNEdXTm5uRUhK?=
 =?utf-8?B?TFVQR1FOejJyN25KVjQvMkdiQ3U2SjhzbmFVY0paWGVDanlraHRocVJlbGFM?=
 =?utf-8?B?NDRNM041ZTkvOW9MRXEyc0p3WVBzRWdmby9zLytwSTJPdXdOdllHajB6cFFP?=
 =?utf-8?B?UjVzTGwxWXRBZFJOL0d3Y0s1OFVWTkZxS1ZXa2pXVks0VDloOHphRWVHQ0JC?=
 =?utf-8?B?c3lCeEFHanlvSEpzMTlwVk5IT3g4K0xMRTNZQ285eXhVMmFON21rQ1REWm5z?=
 =?utf-8?B?bVdBTWFTYlM5YThyYlVqemF4YjRKMG8vWXNoZ1dxZ2VoMGh2dGtZVzNpKzd1?=
 =?utf-8?Q?7Sts=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 08:13:57.8634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e693df-3ae8-4c40-2a2f-08de41fb38d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Mailman-Approved-At: Tue, 23 Dec 2025 14:36:20 +0100
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

Hi Markus,

On 12/23/2025 1:31 AM, Markus Schneider-Pargmann (TI.com) wrote:
> When exiting a low power mode with DDR self-refresh, we can directly
> resume after DDR setup is done. Call the common function to resume.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62px/am62p5_init.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index a74fe3d23d7c4b66ac95aa5a01c2a32a586e9ced..63cc9827b6a178d36f054400772417411cb508f5 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -253,6 +253,15 @@ void board_init_f(ulong dummy)
>   		enable_mcu_esm_reset();
>   	}
>   
> +	if (wkup_ctrl_is_lpm_exit()) {
> +		u64 meta_data_addr;
> +
> +		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
> +		if (ret)
> +			panic("Failed to get LPM meta data address %d\n", ret);
> +		lpm_resume_from_ddr(meta_data_addr);
> +	}
> +


Thanks for moving enable cache after if

But advise how setup_qos will be done now.


>   	spl_enable_cache();
>   
>   	setup_qos();
>
