Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692EDCFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5495983DEE;
	Mon, 24 Nov 2025 13:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xdFNBPKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE7883BF4; Mon, 24 Nov 2025 05:08:16 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848A983B72
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcAfI52VX13ExMnfde/pXyeZu8FxCqkhtzDcnZGH5YrvbKlgty4SQfGMETBaLUOpljkQNd+ScnBJFqeXkdBXuR/hdbbqc4fk5TUU7ZAvB8uHXt6rnGpvY5D2mQPs6H/+T6n11UX3L/+KcUl+IYfsQcjPp50ZCD4oPrMa+MVkS8d6iZ6xjo2k9EeDWzuaycdroOcwoXUcBxuxpSxdF7nw8jWWn1/2wyXcMbHpJMcJ8aLZs1dmCFMdWhZ0DRnd1a9/uHcUHOPNU6wYejMm1XXw2qcHZ2F9oDUDsQ/B5NHvASS91rlBYqdqfjtXghOYnIvmlzNXUvSiCIAuZwRlwudH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fm4egomxFKFSrFj5IhiZzbZvjR40n05gRlol1oJewU=;
 b=BGOGXCPOk9fldcdyYQCXj5UxPeWL9dYeDUmC8wxKhOMnMJAuDVFINgJU+qsin8ajraR1H0TD8bbema3T00MhENaqrHXwBiEygedG/S0DFDj6MzH8G50OYo7Fb5jz9VM4AcrHzk/F/oSEgL93cfk+DIVjtPeEd3DHdFma0L6UJqZaaqWTN4YwOYxFnm+sDhXGKc0TEUfNwfdxGuX1lmA4hAqWnTcFCisxDtvznfjsfdMAdEB4zjFFDI6Qae4WQIr57Bk0/YIZtUp/4jBBDU6758UycP1uST9SGoO2hiWOEDGGs1FPXeV1AKSVBUm68LSwV1rl59Hyy8HSc+9WziUkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fm4egomxFKFSrFj5IhiZzbZvjR40n05gRlol1oJewU=;
 b=xdFNBPKZYsd+vgTbrrv8Zmbbcv3grE5YflGh9h8tXoIcPPN2tSm+FAxNv/DsbUjWB6AZ8TlJHsVtiQntbRp3lc0o70XDpru9OlqEKIjnz5/0f5E96vb6VAXjkdtx1vdl+CGAilk2sKbK0qTGHXDgoagOUZhkP9xyTDmmoZA0ZO0=
Received: from SA0PR11CA0110.namprd11.prod.outlook.com (2603:10b6:806:d1::25)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 04:08:11 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::73) by SA0PR11CA0110.outlook.office365.com
 (2603:10b6:806:d1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 04:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 04:08:10 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:08:09 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:08:05 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:08:05 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO47tEB1262151;
 Sun, 23 Nov 2025 22:07:56 -0600
Message-ID: <9d1d0c37-67f4-40ee-9f49-23062829aa8d@ti.com>
Date: Mon, 24 Nov 2025 09:37:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
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
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-8-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-8-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffc0fcd-e95e-4e33-78b3-08de2b0f1490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDl5SXNYTjYwc2lYSU1vU1l0dURHQ3RiaGNEdTd4VVVhU1gyUkViR0VKUHJl?=
 =?utf-8?B?MC9ZdEo4aE45ZTJnSTZNMVQrMGM1bnVEOWU5UTQwK1VpaVBHcTRLV1g0QlVS?=
 =?utf-8?B?cmE3ZTk1M1NuUXhVVnY0TjNPN2cxRGxHcWJNSHdwLzY5M09DNjBmWG1GOXE4?=
 =?utf-8?B?YjJxWE04NUtyWkNKeFpkejcrVHFEblNsTklQai9Qakg3aXhGL2JoM2pabkpQ?=
 =?utf-8?B?TW5RaWtNb3NUYXg3bzhMRmw4bjRjaG50RnR3eE9VbEIrMmNQVWxJbytweGtR?=
 =?utf-8?B?NU55OUFneXJYSlU5N213OFpxL2Q4MzkxVEQ3eUlqNjB4Y2VrMVc0dnA2TDhT?=
 =?utf-8?B?UnZSVk5vbHA3L25PKzZQaUNVNDRRblFqMnJXSEU1aGc4RzJqV2ZzWkcwWmhZ?=
 =?utf-8?B?cVdKWHFZa09yTzNGTEJqYXlLaUpPSFgrV01NRXowaWxrZENBZ3R3c0pkYU9J?=
 =?utf-8?B?Rys0WWRVblEySC9wbnFWTlRvRUtEQWJNenpjVWJYM2RVdWdKRHA4RXJZZUhG?=
 =?utf-8?B?V3g4Zmk1eXpiRXlmMmE0N2tubVFCSTMxVFpWRFBXNmdOU29oWWQ4anRVOFBQ?=
 =?utf-8?B?YjRwbDYzRS91UWh6YldqWGZ1WHZ6VWQ5RDFEMDJmaHFYcVBiSGR2dUNkY1Jz?=
 =?utf-8?B?T0pOcFl4Y2dPaDNLTFlGc1pUenY5U3Q5RjVVK2ZveUc5eWFFR2VIa2pBY3Vp?=
 =?utf-8?B?eVNoVXVFZ1F5NVpoQTZxTDYvSXEwTjJOM2hidjBoUmQ5MGRjVVdWWTduaFBm?=
 =?utf-8?B?UUs1M05RY3M5cUdkOWc3SnpWVnhFWU5kdTJpQzkvdytsNVRwYVVUUHpkNlRM?=
 =?utf-8?B?WDJ2VndFSEFVSkZuZzlBUkhwQm5VVDZFc2pDbFpHZHF2RXQ1dEhiN2FJelZ1?=
 =?utf-8?B?cGdYUzljRVloZHgvNzZGZk9wQWx1S3RCWjRmV21WOHprQ2QrTEdJc0VqMVBu?=
 =?utf-8?B?OUtKWDZtOWorS2tndUpmdlhUeE11eW04OGhiUjRhZ1JkSTV0YTdRNFpTM0Nl?=
 =?utf-8?B?SUpmdWw0MENQYU1RWHRGOXgwam03dU5abmREejh2bUU1V3U4Q2RnN1NuSE5y?=
 =?utf-8?B?L3R1VEtPelRiM0h0czErSnNRNnVUdEJtdEwwdWhJMTlGeHhMTEJmZGFJK0ZK?=
 =?utf-8?B?UWFKTXNVZ0RNMUt1OFFaS2ZKT1hZVFBuSkI4cnJ2MnBjRHlGRThrMzBQNjg3?=
 =?utf-8?B?c3Y4WlhTM25oZmt1dUFyTmJnZVVYcjVCS0NXanphRHJkSGZPMVRxOVNrUC8y?=
 =?utf-8?B?MHh1bnI1RDBNVUlsTHFMN1kzWm42Nm9IUjRoTS9YeDByRDdhMGFLS2Q2YmZV?=
 =?utf-8?B?bFB3SGw5TTNxaXdkaUxvd1VNKzJ1ayswYUdQQ0Y2Sks5YjY0WkVlNWZCUFVB?=
 =?utf-8?B?aWV3NlJabEQ0bTdBQUFRR25TRTRKVmxUTEZrajVuOU85MmYrT2lpb2x0WDZW?=
 =?utf-8?B?aWxDU1lyVHhRTnFaQWR3eWMxL0w3UC9Pb2lUNVY2eVYvbXB2S21rZlg1UUxv?=
 =?utf-8?B?WTgwTEl5MlRLTVJGdlhTTkI0VVlOeXVEUDc2QVhPNmZTWVN1VVpkOFRXN0Yz?=
 =?utf-8?B?OU52cUxwdEhmV2FVK1ZHdjZuVFhSWjVMSDhxb210K3NwS0w4MGFzRWo2Nmtx?=
 =?utf-8?B?MGdmZ1JJOGxrMjBlZUlCdVhhRTRhV1o4ZWFMSlpTSzZRSGg4SnRxQWxDRExC?=
 =?utf-8?B?aHZucjZkbGlnakxZdzlSV0lRRWczbnllS1V5cFk5cnM5eWUyS2VYLys1WkVQ?=
 =?utf-8?B?OHRCYWJkb3dFd1dsQWl4Qmx5TXkrc3hiNkRuR0pic2FuamtzZnNFMXdRN1Jl?=
 =?utf-8?B?U1JaK3V3a0xHNmYwMkNYU2hrV0tKMWhqeUs1cHZBZnNPNm44cnh0QXlmdllU?=
 =?utf-8?B?K29XUjR5YjNnbEpUN2dFQWZzTWs0KzlKRXZjQVoyWGt2ejdkMkNEV0ZoTkJz?=
 =?utf-8?B?L3pDVkdka3FxSnVOY09QRzlLNGJkMXZhaDJxdkJ2akdiT2FtSWFBZ2tYZkpZ?=
 =?utf-8?B?aFUwemRIQWxweTFOaHJselowNXBGN2M2ZFNtUGdTYldmdzVCeGVZalhsUTV3?=
 =?utf-8?B?bWhmd0tBL1VLbVlHRDZobGNZRkE4L0dmcWl2MnUwRDlQdjkvcFdWUjJMME5D?=
 =?utf-8?Q?jVWM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 04:08:10.1971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffc0fcd-e95e-4e33-78b3-08de2b0f1490
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Mailman-Approved-At: Mon, 24 Nov 2025 13:50:30 +0100
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


On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
> When exiting a low power mode with DDR self-refresh, we can directly
> resume after DDR setup is done. Call the common function to resume.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 60645272c816023798cc5d6fa46a2c569143343b..4f0a8ed66179e7f7445f9c250ffb4f53f4977546 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -195,6 +195,15 @@ void board_init_f(ulong dummy)
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret)
>   		panic("DRAM init failed: %d\n", ret);
> +
> +	if (wkup_ctrl_is_lpm_exit()) {
> +		u64 meta_data_addr;
> +
> +		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
> +		if (ret)
> +			panic("Failed to get LPM meta data address %d\n", ret);
> +		lpm_resume_from_ddr(meta_data_addr);

Do be you want to protect this code with DDR_IO config ?


> +	}
>   #endif
>   	spl_enable_cache();
>   
>
