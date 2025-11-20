Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC9ECFA46A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 02:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1595E836D1;
	Fri, 21 Nov 2025 03:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nZdo952M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AED18405F; Thu, 20 Nov 2025 23:28:27 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA92A83734
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 23:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=k-willis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD2GDHeoqpqRRJqd8lRhbquWKbpBPjPeLl06B1XQQ+GJx2HXmrXA24Xd4ANuEXVDPEdUjo/cn1bwuQOoxwpZRBQdAPGhAZwi6QhplGnpgiuc8tpFMwPLaZBo1EXDGcqR0kKkifSocQXMtUgB5Jrlb2wBh4QTy4aQKuw7GTRc5YExgVkGg+f9xhPugIombAAMKBDZggmy+4iMCF6LN6BSGtEiU1Y+H6+T/mp1ZbVA9ytwPUW0BhhD3bRhsxJ5/Bk4V3Wlf1rjMFapM+u0OsOdDrSmlzzkHzDcS/AqotR7sRlMAbJZl/+vDfJJIHKcsESAUwlhl+cQE5yVNOep/bc8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49YUHDazwTtSuf7EWpX28BhaKC1zPghJe/IY65gEVHk=;
 b=JPucyDWk6u1EBO2P39L3EKvoqZjWoWJ2l8wesqnWg3i4xB+GHT7NdhbvUzK/eeE6E9KLVb5dTQvqErqrSD85asKpp8bfg0S/VhOVBPDvOyJofsFXu0h+yka6ypBOGmlvbpAbHU25v1SIRRCirhB/V5FvOJN7KpEzIG9u6UOOtSSWcDWTtZaEqWpBNqjJRC/NEBvTpuhPWpc/rImyDiYrHa83jgSghdIrygMZoBMfz0aDvXoM1mQH/K5/5cz1EdCdOs6/wHSi8wIcgJMC1XJRPPNG7zE8vfNt1S7aIffEAjEiXsQ9XtVx3VFZBjSpXu9+MipFArnnYIlXeHgWbxTKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49YUHDazwTtSuf7EWpX28BhaKC1zPghJe/IY65gEVHk=;
 b=nZdo952MZS8SKM26whqnbCfLsNmXPrUA/eIk/cKAGxUsrHvi0ToHUyCe4/lsE1KL41k5RvTSTCdR4StBSeBbHd8kKH4bbQFVMJbsIKL/LPPVc4db+XvWpsmqyYqiICCqn7RHPBqlrgVlhb5npcXxV9cIEse89gslOcx+IeRuLJs=
Received: from PH8PR02CA0044.namprd02.prod.outlook.com (2603:10b6:510:2da::9)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 22:28:19 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::97) by PH8PR02CA0044.outlook.office365.com
 (2603:10b6:510:2da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 22:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:28:17 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:28:16 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:28:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 16:28:12 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AKMSCPN223832;
 Thu, 20 Nov 2025 16:28:12 -0600
Message-ID: <be2a0a5e-d7b4-4944-87bb-99dee08ddc44@ti.com>
Date: Thu, 20 Nov 2025 16:28:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] configs: am62ax_evm_r5: Enable IODDR resume
 support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-12-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-12-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3c409f-8f75-4799-8ef8-08de28841a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0llNjgvYjFOR2NRNWErQVIvMzRmdkNzV0xiY0ZsbTc2USt6cUlQUW50Qk9k?=
 =?utf-8?B?bFhDNk54d0IyVnNFRkFhZGFvVndSaHVoVGxINDN3amxpekZMR05XRDl1Zzly?=
 =?utf-8?B?NVlxVWd6VkhyenBzSm9GVW11cE9vSWNveDdsOGU2Tlo5SFkrS0lKUUZRWE1T?=
 =?utf-8?B?S0xVKzNMY0VQbzJVSFRtZHhtVXk4MlpzWEhod0U5cHVBZXBuN0NWMDZ3YWs4?=
 =?utf-8?B?M1ZmUU5zeW85U0dHaC90T2hIbG9vSTcrb09wUENTcWRpMDBzbjdZenora0sz?=
 =?utf-8?B?dnpPRlBtMEx0TjM2VUR4SkxkRjZ1WU5hS2pKbzFYTXlPWEdPTVRIekVKRjhU?=
 =?utf-8?B?cHBCQUhpcUYvMnk3cFYrcTVLOFBDaTd0alhETlBnWkFOTUFwbUN1OThaOHhi?=
 =?utf-8?B?UTEvbUZrSTZ2b2hpbldZNm01NFpGUnJjTTFwdkZ0WTVJVXEwQ090WmU4SDRY?=
 =?utf-8?B?U2tic1ovaVZYbzk3dDVXdnY1QnRURGRsNVgzcXNXYmZUZlBESE5jNHlpNnpo?=
 =?utf-8?B?YWhkN0t4N0FnNEtzNkdZRWgxZ1VYczlIWjFReE9LNjJ4OEh0aldaOXpWSUlK?=
 =?utf-8?B?OTBrZjBHYVlnK0ZSQUgyN3pNOW9zT2dTQXdDcFJ3ZU8xb1dKNWRod2cwUjd1?=
 =?utf-8?B?SElzc0l5bVlHcXNacUc4N1A4cGhoaUFXWDhkMURyQUU2MGw5WFEzUXljbE93?=
 =?utf-8?B?MDRyOXB5dlBsem1QVmhsSXdUcTlSMlZFaUFqM3VwaU1DVFB3WFVFMjBKdjI4?=
 =?utf-8?B?T21XRVpGbWk2UlhBMzV1d3BzbHYrZUNMMk85emRMb0dhVVdEdjlPdnRjcWxm?=
 =?utf-8?B?NnQ2bWZtckZzNDFTTmR3ZTJZNjdLWk42L1o2Q0x5ckRrYm9iMFpqeWNnaVcw?=
 =?utf-8?B?V1NOdFFUWWNHY1hvQ29HWTVJcjNZUkRHMnI3MmMwc2ZhbDEwS1ZMc25meG1l?=
 =?utf-8?B?WHlCMis4OFQ1T21Sbmt6Yjkra1FZejZ6cHBwSDFUZUl6WlhuaDR4eUVpVTJt?=
 =?utf-8?B?ZVFSM3RacVFzQnY5ZGtsUit3N3RoK1VMMUFvMjJWSHVPS3pJR0FOV1o5V21Y?=
 =?utf-8?B?SkdNQWFQY1l3V2NvcWhHZGhyREFtUjFyak5aODFUWUI1aGFnM3g1V1Q0TFo0?=
 =?utf-8?B?dWZCaU9IOVhUcEc1SWVyVTFaMHE2RTh3blBSRVpTK1VpOElrNUthd2hYTFVy?=
 =?utf-8?B?NHF2SlFnQm1MZnNScWVDMWFBMm0wSHJtMGJBdnl5eXFhdkRVT2NUU1hxUXZM?=
 =?utf-8?B?dk1rNGc0QVRhNFdGOERVVVJaMmk5bVY2RzY3a3FmdUJ1VE5IV2lNbEJqVzNY?=
 =?utf-8?B?bmpaWXUwTG8ycW1kMkkxTDFsYUl1NE1ZOGV5dXVBd2ZSRzdJaGNHYzJQVm9k?=
 =?utf-8?B?NmppM1E3bWpxRkVPa3ZISVJucndrU1ZTVHJ0aWQxeFNmOXdQTXpQdUZnSU55?=
 =?utf-8?B?K216M1gzSHlQMlFzeDc0UGJka0RrR2Nld3RVUHRWOXY3M1E2c0VkRUhWb3dw?=
 =?utf-8?B?RDN0Sks4UHJQdXJkNFhaSnhqdXI3UFJ5MTdpTDlyVHZZaDMxWlhybzVoVThj?=
 =?utf-8?B?SnI1NENmaEwvb3hsVVcrd2lBZEkrcjZCRW1WVGdZWWJaYmJhcUNyNUc5MnhM?=
 =?utf-8?B?MWpnQVRqSXJUbW1iOGhGYkZIM05hYXkxVTdUU0E4VE8vck5Dc1BGUUxpVUtN?=
 =?utf-8?B?b2pGZ3gvM25YOTkreS9XWUZZYnExME0vc0FFQzRBL3o2VWFObk5rSTloRXhr?=
 =?utf-8?B?Z2NIeisyOUU4KzNMeHNVM1BBTHhScURKVU5ieS9VblJiYXRGdGJhaFFvMmpR?=
 =?utf-8?B?SStNbkp1RUExUzZVZjZ6RjBISWRWMS91RWxuYk40VWJDSlljQnVjVFNpd045?=
 =?utf-8?B?WWtBdW5VOVdvdWRzVWI5SDBsZFBnUFllYkxURVAzVmxZRzBkSWtDNkE1ZEFP?=
 =?utf-8?B?TWpuYUpvN3lvUzdWRXArUEwyUlhzcTZTNGdYZlFrbStxcVl5ZGZDWmlGdC9D?=
 =?utf-8?B?elVvU3VuWDFydHFiUzUrL00xNUJDejlaUTBub3d5UzVFdE1IZTd0RmZhclp5?=
 =?utf-8?B?aWZhZVVyOWxIeEw1SEV4YkU0WGlFN3BEVlBpODFOMWVBTFpWWEkzU056M0RD?=
 =?utf-8?Q?xgOI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:28:17.7338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3c409f-8f75-4799-8ef8-08de28841a74
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Mailman-Approved-At: Fri, 21 Nov 2025 03:09:02 +0100
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

On 11/20/25 10:03, Markus Schneider-Pargmann (TI.com) wrote:
> Enable K3_IODDR to enable support to resume from DDR after exiting
> IO+DDR.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   configs/am62ax_evm_r5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
> index 64886986c4264a5d9272228e468f7057c195593a..3a9f382193532dc3b712a1bd3fa16a9c0de3fedb 100644
> --- a/configs/am62ax_evm_r5_defconfig
> +++ b/configs/am62ax_evm_r5_defconfig
> @@ -106,3 +106,4 @@ CONFIG_SPL_TIMER=y
>   CONFIG_OMAP_TIMER=y
>   CONFIG_LIB_RATIONAL=y
>   CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_K3_IODDR=y
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>
