Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90505CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 05:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E7883AB4;
	Wed, 12 Nov 2025 06:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F/l3bGyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4186883C01; Wed, 12 Nov 2025 06:34:05 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2071A83AAD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz3GkXuIfugzmwiohpyVzHSi9jxaQs6OioSrfv6CQE/ZfYjQT8fnNyy8bZl0Dp6QR4buXQsGxwIT6YmM+sRl554MQzwUvF0khRXIgyy6trJeqQJY3tKtVJjnL56NnVd0ytMv6TVT92ErONaEy5uT9zLlvfivAZoeI/rnC27AMlZDN123SGMSiT2XkifHAQrsjCVI1hzqXvjcLFkJdn4QhhqNs6V9nNgCPPl0I8RplCoHGAy0ngmlxBtN29aDXEOwQkaCWduir7WYpfo2mJ2lQ1qSxUneS0zOlpq3MXZGvhfKxd2A7b5GkhH5QnPSFU42EvvI19yMf/Wmqlp4sHY2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiS5G4MBbfwVtt46xjncIIVU3LtVUKjBq3PsKTZThDM=;
 b=cl7J/rQaczMhSgjaR4PRMXnUO6aIFQkVRSgnnzZRT7fFB1ASF6WQbh8jvXhny1I4fcVvcLG+a3qFg01J7VccTSw+L+sFNvRo0+u5l7I5EE06LGvQZXgC6y64++amrSbLH8+0CAGe3Ozm6dUDoQsZLX0RobpFYXYyFuQijokxbe+0H9UvzkRF/lNJQwonDwX4xvyWPAOBdB5hy/x7gVI1yzlekhBbGZn3uf2x/WfH1JfaGasp4IKdu9697/m7gGDBO25ucm2ciO1lsUic3kjKrSG6K919vAn/+dOj0SsBfuSYxgC9on5AO/kgmfD7UozKJkC6rZU0oAqA0Xb/0XZQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiS5G4MBbfwVtt46xjncIIVU3LtVUKjBq3PsKTZThDM=;
 b=F/l3bGyUu1KtOHPRNl5mK3xZLaIrJIcB1fAH/gQBuvjjYVsEarzf8MHzZygLJfnFkWvNS8DHKkktEk4FW007IOewH9eVHiKPsisuZdtRVr+QzQS0k+N2qM7LGCSyG+qzrmO5ivFVebNJqylacD44Sv0U47Z2hH96bRowZXvIV2w=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:33:58 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::b2) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 05:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 05:33:58 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:33:52 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:33:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 23:33:51 -0600
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC5XlEZ2123574;
 Tue, 11 Nov 2025 23:33:47 -0600
Message-ID: <26187782-ba7d-4ad0-892b-9e2e09f3fcad@ti.com>
Date: Wed, 12 Nov 2025 11:03:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] configs: j784s4_evm_r5_defconfig: Enable configs
 for PCIe boot
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <a-nandan@ti.com>, <c-vankar@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <n-francis@ti.com>, <peng.fan@nxp.com>, <semen.protsenko@linaro.org>,
 <s-vadapalli@ti.com>, <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <u-kumar1@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
 <20251111061645.1004382-5-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251111061645.1004382-5-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA2PR10MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 112316f5-edd8-4cf9-ec0f-08de21ad1401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0thQTV0SlFuNkt5NlRiK2p2V3ZmVXd1QTZlby9DTnYwNHF4eWRlallqaUl0?=
 =?utf-8?B?N1Y5MGh4QWJKZDIwaWRNQ24xNHRaUitjdGZiQnJPSnErYjIxemlNSm9CZWF4?=
 =?utf-8?B?TWU0WlhiclBCcHhXdGZoelg0QWJFbFdHSG9GRUc5VWpMOVpsU0lQc3N2bW5H?=
 =?utf-8?B?V3pDcnd4M2Yxa3k2bm0rWTVaY2wrZWNiRVJqMzJGZVlmc043aXRnVWZCYXpO?=
 =?utf-8?B?blVHOXVNWU5KeS9BSENPYjNzODkxUUsrZnFQd3hWS0c2blk0TlNMUWx3bXdt?=
 =?utf-8?B?L3hVMDJWOUsxVC8wN1VqaFI5YVFiOS9EM2V6SlZhblRFVkQ1MnUya0xlME1N?=
 =?utf-8?B?b0syb3ZtSkw5SVBxRjQ2UkRubmtUckYvc2psT2kvNVJCV0pRZTNYemFMZXMx?=
 =?utf-8?B?bHhza0JVd2RXR3cwbUFqZEFzMk1CSEVZWnRJZ2g3WkxWOFJBam90RmhoS0pG?=
 =?utf-8?B?ZWZXaERqNEd4QWR1clRQaXJuMUkwajFCQzN6UTR6K2JWcjVBWmx5NW5uRHFU?=
 =?utf-8?B?WmZxaE1xc0s5b0tPaU9tRHFTUkFQNDh0eEJmaXZRWWltSW5ld0RwRUtMbm4z?=
 =?utf-8?B?WnY1MGxCRlozMEVZM0RrcjJFZHkrWEgwdkxGdmpRblg3OXUyRHdhcjlFR3RT?=
 =?utf-8?B?WnF4ckNTQkdORzhrOWMwY3NEVEU2WG5zZ2VTWWtUUHMyczdBazNuaW1XdHpS?=
 =?utf-8?B?UzZ3TDZtUTVPaVBMcHU3RXRyODl0QTRFZUFDZW5TT09jaTBud3hRbyt0eVor?=
 =?utf-8?B?SmZmZ3gzTGJOM2lVTXZRYmxjd1duZFlBU2hwR1JjVnlIM2s4KzVNSklBdEdp?=
 =?utf-8?B?TlNNMkV6YXo3K2xzWThudEpteE83M2lwODdrNUdXaVI5Tm51ZmxsK0lwazFX?=
 =?utf-8?B?QVVHZ2xqZHBrVlVPUnNqVTVLMVFuQVZ2SmxhbSt6UElmUXZMZDZUeWtIak1k?=
 =?utf-8?B?UGxlY0lOVmxiejJEVHEzb3RzREQyTVVrNzdtdm9BQ2NFV1R6eG9XYjBUOWJV?=
 =?utf-8?B?OVY0ZTBFSUFWdGVkandUSWZzbVpIZWgrL2dwcW41cHM2OWVRblUwbU5uQzlK?=
 =?utf-8?B?bENsWHZ1QXltQUlXN254Vzl1ekhFdEg4YVdWOGdBM3RySTJsTGs0bldkaFBz?=
 =?utf-8?B?VkcvSXFjRUlrWFhnMytWQS83ZGxXM1JBRG9zUkRUSnJoSkNPRG1CVE9aTzBW?=
 =?utf-8?B?WG55WXg4ZHNpNkFiVGJNOWlhT2tCNGtvMFlhd0FMcWlndXNEM0dwTzFZWWtX?=
 =?utf-8?B?SlRqdmQyZGpoWTJ3YU12K0pPUlVBYnFySnZHYnRpdlJabWxVVnNmN3JScStD?=
 =?utf-8?B?d2hIcjU3MUFoMG81aDMxcDVxRnFKblNjZWQ4aUs1V3ZhSDFqT1dYakpRL1pt?=
 =?utf-8?B?ZkxnN2ZNUDFJb3NuMU10cmZmMmhRZ2NyNFFvNFpUUFBXSW9mTjVhWW4wdGxL?=
 =?utf-8?B?b3o5ZjBHVGFlSmVXWFRhSkpGQkU1Vkp1UnlHUmphc3U4ay90Rkl2WEVaTWFC?=
 =?utf-8?B?OVBsZEZNRkwwRzJobjF5ZVEwK1hnTXF1elIxTGx4K0tMRHE4R3FzYytuT0xz?=
 =?utf-8?B?dFpJN09ibVAvSTRuUnhVVitRdVJkSE9HN1dGYWpUVUVxNVpkKytTdG85b2Nn?=
 =?utf-8?B?RTdkN242UWd1dWRhWG9MSjNOMDlDR0g2WHF1VXF0OXNJR1RUblc2SXVXQ0Rk?=
 =?utf-8?B?UkNpUFlJM1ZXZWQvdXRyTkt0N1BxZXFHcXhkVDR0V1hnakhkZUlzbnp6eERS?=
 =?utf-8?B?R0lCVE1aVFQveGRSYWM4QzFVRUZnRCtMRkF6ajZyVlp5NzFMRDJjcjhUaFYr?=
 =?utf-8?B?RlV6TGlaK2VPRVJFZ2F5Q3d6VXFqOEROczJUdTlkYjZsZEo1K01NV2Jxa3RX?=
 =?utf-8?B?d0ZLUjVFOE14dVphUTcwUFByc0J4VWtYVzhPaVFZVUZSUU5VbjRLK3J6aEdG?=
 =?utf-8?B?RDg0MnZkWTdMc3RNOUtZQ3BlS0RhQzBwcFE1V0JGTzR5OEx5bEd6aml2RXhV?=
 =?utf-8?B?djQzOGt0UWw0SE1tRUZWbXUzL3MzYlRVVDEzdzVqTXVwdUZVNGUrYmExZHJC?=
 =?utf-8?B?bjFhK0c0V05WMm4rOW9Mb1NjTXdwUGI3SDllM0JaOGFlZG5MbW12WG1GcU02?=
 =?utf-8?Q?ysCJUYLjiXzvrPOh+hSzaLZhX?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:33:58.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112316f5-edd8-4cf9-ec0f-08de21ad1401
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
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


On 11/11/2025 11:46 AM, Hrushikesh Salunke wrote:
> J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
> PCIe1 instance is used for PCIe endpoint boot. Enable the configs
> required for PCIe boot on the J784S4 platform.
>
> Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
> Torrent PHY, and MMIO multiplexer. These are required to configure
> the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>   configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
> index cc340a2fe76..2279ba7f173 100644
> --- a/configs/j784s4_evm_r5_defconfig
> +++ b/configs/j784s4_evm_r5_defconfig
> @@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_PCI_ENDPOINT=y
>   CONFIG_SPL_DM_RESET=y
>   CONFIG_SPL_POWER_DOMAIN=y
>   CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_PCI_DFU=y
> +CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
> +CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
> +CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
> +CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010

Could you check once , DEVICE_ID

as per 
https://lore.kernel.org/linux-pci/20240401110951.3816291-1-s-vadapalli@ti.com/ 


ID should be 0xb012


> +CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
>   # CONFIG_SPL_SPI_FLASH_TINY is not set
>   CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPL_SPI_LOAD=y
> @@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_MULTIPLEXER=y
> +CONFIG_SPL_MUX_MMIO=y
> +CONFIG_PCIE_CDNS_TI_EP=y
> +CONFIG_SPL_PHY=y
> +CONFIG_SPL_PHY_CADENCE_TORRENT=y
> +CONFIG_SPL_PHY_J721E_WIZ=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_SINGLE=y
