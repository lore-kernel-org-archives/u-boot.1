Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E36DCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 08:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB649846D3;
	Mon,  1 Jun 2026 10:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LVNO9c//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D88846F8; Mon,  1 Jun 2026 10:05:57 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B648466E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kumar2@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJTcJRW4rWFZJJDKaY+oaP7Ea22WPw8DHxXFc94MKu3qF0/W4vJ25NuKUegg8uzx5AKSkWts+pq5EEmgyBN7tTZXhDluZ4V/UfnVDKo4joqxBjF8xTvHmwF08R//GNd1CXQk5SMGwgss7WGVQbJ9+S5l4AE9b5TdySK9M1qajkRgL0Q2bz7T636WIBQFiHBKJ/BtbpSSLyxeHRVS0BpMIWTsgH94ZvggVuJfo4uXIXsmgT/0S1HgoS1quSkqXZ9IrnXiG4UcDa7jROs9M2CKrYInBIpWq26xFutCWUG29xR8yK751BDDVP6I4olNFHs+OWMy+vzqC0yJrmUS+KV7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ4rNW+5qPiu4ZzB0vafh+mPjdpgVemeAJ0rHxO44/Q=;
 b=TxkknSAen6j1XylM4MpIwwvZrEID1W0S1JdFrQ3YUH0LI+8/v+NQ7N/Fp0Zy1hLlvk0Ycsb9+O7Z3mNbkeFaMWAq6ZVVreHyLc/nuXOAcewn282gFPtE7wSUDNhwmvHcof0kKK28laNGBkfTXQZjSu9N+Rzbibu6jUoKJRPtezyPSJwXg0RSXAwoXm1b42itl+UJiGfaejEyr6B5c8GB3OeSckilu/iuPgzNT23EFJS47JHl5++mGyiO+EoRdp9gs6Pt6b4uxcCYrDarslVZ1Jt21kmq8IIGfY7osUv/Sb1sV2cTCzP95o+H+pmdHsVKfdGNsWjeD31DutOD5YuCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ4rNW+5qPiu4ZzB0vafh+mPjdpgVemeAJ0rHxO44/Q=;
 b=LVNO9c//VpX/BahUNMi8LA0QPqQFE28Fdnmcl4UZLbIczmTKBrpnDEwxuwIn2dmv94N9vN0GjTsJwpX4eXjRlJFm3sgLwNXB37iqqvZ4IbocEW9UKJ7fppPZTpol36FWyEW9PhSN704h5qiTzZizwTHHo4P65QRE8mC7SOFumsc=
Received: from SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22)
 by PH7PR10MB5770.namprd10.prod.outlook.com (2603:10b6:510:126::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:05:51 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::46) by SJ0PR13CA0047.outlook.office365.com
 (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 08:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 08:05:51 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:05:50 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:05:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 03:05:45 -0500
Received: from [172.24.18.244] (ltpw0ewr2k.dhcp.ti.com [172.24.18.244])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65185dip1122381;
 Mon, 1 Jun 2026 03:05:40 -0500
Message-ID: <1cab46ae-e03d-4a6b-bce1-7a5c3767c000@ti.com>
Date: Mon, 1 Jun 2026 13:35:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH 11/20] mach-k3: r5: common: add helper
 functions needed in LPM resume sequence
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-12-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Abhash" <a-kumar2@ti.com>
In-Reply-To: <20260430084414.1354490-12-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH7PR10MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: a6be6047-a6cb-45bb-d344-08debfb498fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|4133799003|22082099003|18002099003|4143699003|3023799007|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: hDgOIDXIYdYoHpUF3PhE8w6CLAZNicj3F/BlqmXFsUpapFm9R3CHIZNqpolUT1hsRyb059pgWe9hRbPqg/w21vvDZNq91OhiZHfnFBGKbfb8lQHNCVepHvnvBndTVbgn85vh1HFQBfb16KZZFa+hUsL4cLzME+HZ0mLM8DxK6guzLlfJn/5DeJEfbGNYztQAe9RLb3UhgvJfC6bWatxFD/q+n6hTogsEa1oV4BzLuJAATnoQSDptkZnZneWrl/O5CJkIm7ncJX9+NWohSbedPGvnSbow50hQW4s/epkIAH7pEQjnOhfOcbK0ZXWbi81qBBHf4T0AlgPq0oit9mWDTpyE7xkYxjBS8cjHCAN/YzH/XWk2+Tvmo9xwoidXl6elYshRWWQqYJqpObt1EzhEg63tYwJjvWHvRA+UVxtUsNyVaUe8g1L4P41PEQlrh/o5HOyPgFIQT7u57swSw2AqB1ez19VPxf4t6+XKG1Fg+UPsYcK0OHZ9zLlOYMcEz+OMxodpiAItnpt+k+18NBHM9WgGmlpEfjh8Z4Cnnmz4+exBoS+WLSV5AOtG7ez3MhIH08qiu6MXyFbVDAH2jfJMCTBhiQQHrwFjBEjQFjL1fZ1iJI1FEXQ15lESqCJTtW9EWN+/hSb+yNotib6Sx2j26l9Lcu3w2JPGwb8AV9nAs8dH7j4/BUmatBPY2Wxpjq1V67NV9SDJonDqgS9FLnd7qXKfPovwt0AZrvTemQUeYH/50aTAMO2H5B7yMsXHrtbrT/ycq/42CDaUKxYuvQ5kKjr8yW40UnpnzLY15Cs8GmQ=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(4133799003)(22082099003)(18002099003)(4143699003)(3023799007)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EIGQoDwu+/cbDweLd3PQYJAUf01rYlzXcGXHozffv1w9lyvebUOSBwiu8smRX2qG3UwUTqon3FQbAqmoC2X2IXF3j+Ys8q+7SQ9ZhfIYwlGIrzSEFLD056DR+tahHdS7m05UU45l7Y607yz/gzRT5hQGmdNvc4QAcFH2id9PA8dQZoPj1rVd4rIfiMWXZ3m/TGSY8JGr6Uk6yRLSj7ZYzzJdo8tiigDZ49CNKRB6Q9Wk5b1Oq2glQdbvFJ0TAjX/eVCzmM+GaJAKEgh/jkColNjOAlPXmZVQkyUNp9emLhCxLs+gAQH9KBO14ejsyu0nY1DPf3bLEZFg3prct7G+FyxtQ64wyB3c7VBFvzINCIADPyJsMl5ul9MyHHWMNVwxcAp4Z8I3Cn2V8s7FqAIu2aCvFqUvh+ZChspx8kKTcUBUmauKDJhukFlXXgDvDs06
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:05:51.3713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6be6047-a6cb-45bb-d344-08debfb498fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5770
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


On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
> From: Prasanth Babu Mantena <p-mantena@ ti. com> Add helper functions 
> that are used by respective SoCs in LPM resume flow. - lpm_process() 
> is called at boot time to: - retrieve the LPM memory region from DTS - 
> save ATF/OPTEE certificates
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!undqXRfPtm2bSgZlPFMD_PaDMAG16nyrFWtHumWcmHVJHF2x9T6ju4MVod9Xz5kkhLg8jvqD8Vb2RXV8TKm6Nx3q-RI8sEAX0Ue59g$> 
>
> ZjQcmQRYFpfptBannerEnd
> From: Prasanth Babu Mantena <p-mantena@ti.com>
>
> Add helper functions that are used by respective SoCs in LPM resume flow.
>
> - lpm_process() is called at boot time to:
>    - retrieve the LPM memory region from DTS
>    - save ATF/OPTEE certificates information and DM code in this memory
>      region
>    - Forward the LPM address to TIFS via TISCI_MSG_LPM_SAVE_ADDR
> TIFS will use this address to save TFA context and its own minimal
> context just before suspend.
>
> - do_resume() is called at resume, just after bringing the DDR out of
>    retention to:
>    - retrieve the LPM memory region from DTS
>    - authenticate certificates from LPM memory region and apply firewalls
>    - ask TIFS to restore TFA and its own minimal context
>    - start TFA on remote proc
>    - load and jump to DM
>
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#lpm-msg-lpm-save-addr
>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>   arch/arm/mach-k3/common.h        |  16 +++
>   arch/arm/mach-k3/lpm-common.h    |  15 ++
>   arch/arm/mach-k3/r5/Kconfig      |   4 +
>   arch/arm/mach-k3/r5/Makefile     |   1 +
>   arch/arm/mach-k3/r5/common.c     |  17 +--
>   arch/arm/mach-k3/r5/lpm-common.c | 228 +++++++++++++++++++++++++++++++
>   6 files changed, 269 insertions(+), 12 deletions(-)
>   create mode 100644 arch/arm/mach-k3/lpm-common.h
>   create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
>
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index e970076d08ec..50e670f845e3 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -8,6 +8,7 @@
>   
>   #include <asm/armv7_mpu.h>
>   #include <asm/hardware.h>
> +#include <image.h>
>   #include <mach/security.h>
>   
> +static int extract_lpm_region(void)
> +{
> +	ofnode node;
> +	fdt_addr_t lpm_reg_addr;
> +	fdt_size_t lpm_reg_size;
> +
> +	node = ofnode_path("/reserved-memory/lpm-memory");
> +	if (!ofnode_valid(node)) {
> +		printf("lpm will not be functional\n");
> +		return -ENODEV;
> +	}
> +
> +	lpm_reg_addr = ofnode_get_addr(node);
> +	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
> +		printf("Can't find a valid reserved node!\n");
> +		return -ENODEV;
> +	}
> +
> +	lpm_reg_size = ofnode_get_size(node);
> +	if (lpm_reg_size == FDT_ADDR_T_NONE) {
> +		printf("Can't find a valid reserved node!\n");
> +		return -ENODEV;
> +	}
> +
> +	mem_addr_lpm.context_save_addr = (u32 *)lpm_reg_addr;
> +	mem_addr_lpm.atf_cert_addr = mem_addr_lpm.context_save_addr + FW_IMAGE_SIZE;
> +	mem_addr_lpm.optee_cert_addr = mem_addr_lpm.atf_cert_addr + FW_IMAGE_SIZE;

Hi Richard,

Adding a u32 pointer to an integer "FW_IMAGE_SIZE" would scale 
FW_IMAGE_SIZE by sizeof(u32).

This would cause the address values to come out different than intended.

> +	mem_addr_lpm.dm_save_addr = mem_addr_lpm.optee_cert_addr + (2 * FW_IMAGE_SIZE);
> +	mem_addr_lpm.size = lpm_reg_size;
> +
> +	return 0;
> +}
> +

Thanks,

Abhash

