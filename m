Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C2BE70719
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADE2864EE;
	Thu, 21 Sep 2023 13:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mH5D7uWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63AD88646E; Thu, 21 Sep 2023 13:14:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB8E864EE
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaOn9AXC5PrfjU6eCPcPoj0poy++QRGj2vnHohnphTdLnshGk1ZALLziQV4eNiFySJdL4U9R1KlSYkMlqblmcdzAGTo2Ja+QdFBT2Zf7tEWSsXeAC+dPb8LN2CJoVj2a9gSYqt7k5K1ynR2TgtoYkzgWgzCy6IjAC8C4bCziSveZYhljIA9vvMGGByc+1OugEQB6eW5KWYGq2BQvZ47Ft+nKffb9NB+F6EiSQEVty5a35IuUKMAVQ99ByxgM8y6S6gmfg8Ji6pw6YeXBtH13RGaRPqFj++yNKaDWNKgYn9owyElzmjEj3npMd99QMUyCxl16zc1vwxsuGe/cRYtyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiCA0RAnVF/clqep7e5aqE9J5As0qpjSCAZyETx3AJM=;
 b=WQTRd/XgwMOO9owtmyJQGzbLELb1Xk+3ejSv6fACK6p5S1zE2ml7F8RjUuirXv/s0C0vzJKyEtR9ilfNozTFb+Psn2JfjHZxAE6nslXXX2r9rCpYxDLLiZs6zGAzRtW8eD49C8+VQL7T76GLeHmULDKhATvoON4Tg8Mg3aMXFPJq9vZvJePz13y8hvGMmJMtktn9a77RGjQXFX1PzNwHv5GB7r9fXHMa9t3Q+FQZmGFLefV6aO90bIxznDiUaQmwHboVTEfJmjzgi0LBtmtqKU0ry607YsI0D59rsuJK5bLBCsul+8vMK0qKphaknjoIFQ3r/rZL21FvTzICvJWvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arri.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiCA0RAnVF/clqep7e5aqE9J5As0qpjSCAZyETx3AJM=;
 b=mH5D7uWgg0WvegLYRnsALGL5iK2G3ZqDuyyIm/8CYOsASu2n1EuZuP3tMqfgj5X4Ruo+y2WURv0L8bq4zSYQ83+wEPrtx58LnMAkXrSr1v0ZiI31LHLSv6Umz7vf6iw3/oFNkdihc08khoj1DYwYxRmgENvKy3/55wrZ74r+h94=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 11:14:17 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::d7) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 11:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 11:14:16 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:14:15 -0500
Message-ID: <5f2b9d87-7427-4a6f-9a67-017ae78cb51d@amd.com>
Date: Thu, 21 Sep 2023 13:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal: Add SelectMAP boot mode identification
Content-Language: en-US
To: "Polak, Leszek" <LPolak@arri.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Roese <sr@denx.de>
References: <DU0PR07MB8419EB5D613237A44374949DC8FAA@DU0PR07MB8419.eurprd07.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DU0PR07MB8419EB5D613237A44374949DC8FAA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: aeec08ce-5986-42a6-e7c5-08dbba93e525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPXRBjB2mAyRIIy6L3a+2RDJj7yc8vkGf5VhDVaVpG9HkkcRQ661y9Vip5rC9Dn/0bisa7MzmB0uq3+cG76d6skCJizGLNwi8leInMdsR0RWEXuqpQj10KBVMTauvNBqwh+rlZqs2vlsf6weDfXCa/phD6F+I2NjDPIQvV5ZVtaRwrVMQedC4mzcRymptV344eAsQXQOZp8YeTBMTkypC75A1t/hbSRffohKGfUlW1Wkar7tUPIr33CizQ5d7JCyl/wqP4HNFhCUYLTbEdhF0e7hmH+Wm9QsxhYfHAR0fwJoaWeSFwAPM02h0xFGJiirebKNVSTSf240jFmUFQQdZxznQF3uzUjNXp4PFuBlltPSy788W5VfCWL/D4bZpxuHMi08j+R/D0Ew6+Nm8gBlZN6f2gHJWW+wtA1J2mkPZKfH6wSiL0ErjJp4mptkfulbM8Z0DujD/p76VJHzQmr3NYZYUwUsccqgcIquWgC6VVLptU5B6fZdfDKCAwAyIbZqTJIPqb882IbFLbBHfmirIVcf1BW8DYMHFcKIraj2MB2zMTEEQFnqhI8gkvQszn2FVvzwFB460ytqgdHMc7icKP7CFQeCsG5xh3ECo87SNZ9cH5ljzBc2Tuvm3iJGlMarL0jgMJTdpqkiK+GzNlaBzgzNWrCWe2Dk2FRBHoreyaGtPlX7hlm5Zm7gCdjcLBTmdk2Xv/7sJWVRYC2tk+yivncGRtqUlkAEm1nsuKTN9Ykc6OXzlzzhx4EgK6gBx9kp1K1fweM971oq7eszgTqj9ihEJSf+egzkzDWcPR2Qshv7vbOv4Qox5uwC+b8DR7Pv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(356005)(53546011)(82740400003)(81166007)(2616005)(40480700001)(70586007)(70206006)(110136005)(86362001)(478600001)(6666004)(31696002)(36860700001)(47076005)(426003)(336012)(40460700003)(26005)(16526019)(5660300002)(4326008)(44832011)(8676002)(16576012)(316002)(41300700001)(8936002)(2906002)(36756003)(31686004)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:14:16.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeec08ce-5986-42a6-e7c5-08dbba93e525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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



On 9/19/23 14:47, Polak, Leszek wrote:
> Add missing SelectMAP bootmode for proper identification during boot.
> 
> The SelectMAP configuration interface provides an 8-bit, 16-bit or
> 32-bit bidirectional data bus interface to the Versal FPGA
> configuration logic that can be used for both configuration and
> readback.
> 
> A connected microcontoller to the SelectMAP interface can load boot
> image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.
> 
> This commit adds the missing identification of the SelectMAP mode.
> 
> Signed-off-by: Leszek Polak <lpolak@arri.de>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Stefan Roese <sr@denx.de>
> ---
>   arch/arm/mach-versal-net/include/mach/hardware.h | 1 +
>   arch/arm/mach-versal/include/mach/hardware.h     | 1 +
>   board/xilinx/versal-net/board.c                  | 4 ++++
>   board/xilinx/versal/board.c                      | 5 +++++
>   4 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-versal-net/include/mach/hardware.h b/arch/arm/mach-versal-net/include/mach/hardware.h
> index 9bddb8b00723..767cdd368682 100644
> --- a/arch/arm/mach-versal-net/include/mach/hardware.h
> +++ b/arch/arm/mach-versal-net/include/mach/hardware.h
> @@ -66,6 +66,7 @@ struct crp_regs {
>   #define EMMC_MODE	0x00000006
>   #define USB_MODE	0x00000007
>   #define OSPI_MODE	0x00000008
> +#define SELECTMAP_MODE	0x0000000A
>   #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
> diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-versal/include/mach/hardware.h
> index 000af974e867..9d1c2f0dcfc1 100644
> --- a/arch/arm/mach-versal/include/mach/hardware.h
> +++ b/arch/arm/mach-versal/include/mach/hardware.h
> @@ -82,6 +82,7 @@ struct crp_regs {
>   #define EMMC_MODE	0x00000006
>   #define USB_MODE	0x00000007
>   #define OSPI_MODE	0x00000008
> +#define SELECTMAP_MODE	0x0000000A
>   #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index f0d2224b332e..992e0df73b30 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -287,6 +287,10 @@ int board_late_init(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case SELECTMAP_MODE:
> +		puts("SELECTMAP_MODE\n");
> +		mode = "selectmap";

We are not defining distro boot for selectmap that's why boot_targets don't need 
to be extended. That's why please remove this line.

> +		break;
>   	default:
>   		mode = "";
>   		printf("Invalid Boot Mode:0x%x\n", bootmode);
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 60bf37d3c90f..b619dbc73c80 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -213,6 +213,10 @@ int board_late_init(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case SELECTMAP_MODE:
> +		puts("SELECTMAP_MODE\n");
> +		mode = "selectmap";

The same here.

> +		break;
>   	default:
>   		mode = "";
>   		printf("Invalid Boot Mode:0x%x\n", bootmode);
> @@ -298,6 +302,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_SPI_FLASH;
>   		return ENVL_NOWHERE;
>   	case JTAG_MODE:
> +	case SELECTMAP_MODE:
>   	default:
>   		return ENVL_NOWHERE;
>   	}
> --
> 2.42.0

The rest looks good to me.

Thanks,
Michal
