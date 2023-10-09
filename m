Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0B6E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 10:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F31186CBD;
	Mon,  9 Oct 2023 12:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKU7W8Jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D595C86D60; Mon,  9 Oct 2023 12:17:39 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C928638B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 12:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVCROvYUGqAwE8OJdE4E+nCleGOeMLnkUjznoN6U//prXU+NHX1zK4vV2GFUza9hgp4D2PbnEgwxaR91btvTFwNrGGYAfaTHDSeXt9IFAI6zZRtBf6OFQFDzMgWhZ6lUaGFKyYIHAxMum9mhw8b6IgNMFji6zw+AQIyKp1qjSw622wQdARA8OwAAqi4n1qFvhgDjdD7HTKaKhRVFHbvnHu6hp2CO7mTnPWoQNusuuGXCR5BynErEQUWcWzwgmkykAvtUNfoBg9+HeOlcGs0EiDHaRsbeicLnV/T11MXdXRhEqw3g+T9ZrMoFq1iUiEC/rkIsP9ackSaBTIc2lKvSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7jsrUM999UkTgZwcRCdeGbIGk/Mv9DXZvOHJrgNdKU=;
 b=OUzkggLhtMrpkmCi7EZfBAnPI48Xmcp+jLuAprpyBhSFjqyC1L+GBfL+6SUdx/RIDHsK+/54rb2ST8kC46bOt7CX2BHIYE5nd/HsTDS9tqm09tierEycBvnzo34sBOjeA4kMeqvivyNwcKOZ1PGlYNF57lEQNV4lbv0iutAXgKqo/MSdtYD3cDkXD4vb618775ZM7PPgdXg+yL/qt0IPqud3/pDseIK9a47WGO99tDvC40brsi2fflNN438ffyV6mPLTi8Nu57V8f2UtNX9bNG9YhTOKRvRXBSsmtBLHM5SlPiXESO6v1Wr4PB3lXQFh5Tn7LfIrrikJe+XRbwOCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arri.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7jsrUM999UkTgZwcRCdeGbIGk/Mv9DXZvOHJrgNdKU=;
 b=CKU7W8JhILtW1i7qGOipSD1YKCvJhoE5lRyTn03sPCjkqi7TPkSjunF69mr6bROf6gHTLn7X5AhVT4r/X2IBWDZcg9t3kWNNTfMiDuVtKFWAD44tEVBY8MXpbuNgYc4CQa8dHfLj0NgY6IbbCp2t151ANDWxqa4glAx9RFbuzsk=
Received: from BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 10:17:32 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::95) by BLAPR03CA0061.outlook.office365.com
 (2603:10b6:208:329::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 10:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 10:17:31 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 05:17:29 -0500
Message-ID: <024aef2c-6690-4c43-b9ac-9d9ef79474c7@amd.com>
Date: Mon, 9 Oct 2023 12:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: versal: Add SelectMAP boot mode identification
Content-Language: en-US
To: "Polak, Leszek" <LPolak@arri.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Roese <sr@denx.de>
References: <DU0PR07MB8419F7765892CDBCE7D559C5C8CFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DU0PR07MB8419F7765892CDBCE7D559C5C8CFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: f821e9be-211f-41b5-d07d-08dbc8b0f2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW7x8Vk6YKcOkD8XMCODdaIvHkimX2MVj30VhbvDXLHknqAgouq1h5EqUyhWtkqg1Ylf8Gmf0y5gchrlk5Ej+TFoDPSRZC7rxjriNOteZKDXZT0IoxxLpORvE03htMelWHfUJMhVZYoz5aUReBIpu6iDBIQF52MtF52zHqhs5gDW3YA3PcMtvCz0340/mslsZqFaSllxkSv5pXWVujzIzJAIY3KXHfrPTVCnL4ApYzOKSP96GUd8VvoJaQd5BPu2lSjDAYgJQhs9zi03wSgeY2/5vZ81JE6hpgWQP00pJ2uX47sLXH8eRUJEAm8tGGQ6eBOlt2HJmnO4OgaatF1ru9c3gasI2q7wbdhUZpAFREu1awtT+432KCeJF70NeBK3CkQx+sS3JOeKxazbv0vFL5EX0YTc31awg24FlpYaq0XaAC1GwpmaXit/oQkhkGXrCEUvYERGdG6I3MWuH9l8MBHhhjJWgQO2dF9DggMkyLiOvERo6IZRpfxmfpaIvqrefooY0CpHJXPlaUeV+i+V3xCm1E365aX/PCvo9/2jlWyoj8KOyWK6DUSObC6OKNhOUu1uT8vkntkYYar5O4XUuPfal979o3ESBun6vkUQ/xlHIub/3wpkt7El9P1JJfLXJtXnX5ZBaOZ2Dm0Z7lcnfAO63+FuY+lYSDGO1qVUp3OKDOJDkzDPLPxGRvxp5nwdM+G2//K5mHv9S+QwvrrAdhghGjaZEW6fmVbM1NNyeX5PevzriQXEdM+f629dT7VOWrZbHRGmnSSpShc2RQHkcmPAuigWP6P2mdG/nn0XhJ94qF3kYwACILxUucT19Zk3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(336012)(426003)(16526019)(26005)(47076005)(36860700001)(316002)(110136005)(70206006)(70586007)(16576012)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(53546011)(6666004)(2906002)(478600001)(82740400003)(36756003)(356005)(81166007)(31696002)(86362001)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:17:31.7076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f821e9be-211f-41b5-d07d-08dbc8b0f2de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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



On 10/8/23 16:34, Polak, Leszek wrote:
> The SelectMAP configuration interface provides an 8-bit,
> 16-bit or 32-bit bidirectional data bus interface to the Versal FPGA
> configuration logic that can be used for both configuration and readback.
> 
> A connected microcontoller to the SelectMAP interface can load boot
> image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.
> 
> This commit adds the missing identification of the SelectMAP mode.
> 
> Signed-off-by: Polak, Leszek <LPolak@arri.de>
> Reviewed-by: Stefan Roese <sr@denx.de>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Stefan Roese <sr@denx.de>
> ---
> v2:
> - Drop assignment of 'mode' as selectmap is not be supported
>    by distro boot
> v3:
> - Changed E-Mail/Name to be the same as git setup
> v4:
> - Fixed formatting
> ---
>   arch/arm/mach-versal-net/include/mach/hardware.h | 1 +
>   arch/arm/mach-versal/include/mach/hardware.h     | 1 +
>   board/xilinx/versal-net/board.c                  | 3 +++
>   board/xilinx/versal/board.c                      | 4 ++++
>   4 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-versal-net/include/mach/hardware.h b/arch/arm/mach-versal-net/include/mach/hardware.h
> index 9bddb8b007..767cdd3686 100644
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
> index 000af974e8..9d1c2f0dcf 100644
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
> index c18be0c26c..990ca1650a 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -252,6 +252,9 @@ static int boot_targets_setup(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case SELECTMAP_MODE:
> +		puts("SELECTMAP_MODE\n");
> +		break;
>   	case SD_MODE:
>   		puts("SD_MODE\n");
>   		if (uclass_get_device_by_name(UCLASS_MMC,
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index e4bdd5d7a3..8c2e614ad8 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -174,6 +174,9 @@ static int boot_targets_setup(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case SELECTMAP_MODE:
> +		puts("SELECTMAP_MODE\n");
> +		break;
>   	case SD_MODE:
>   		puts("SD_MODE\n");
>   		if (uclass_get_device_by_name(UCLASS_MMC,
> @@ -312,6 +315,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_SPI_FLASH;
>   		return ENVL_NOWHERE;
>   	case JTAG_MODE:
> +	case SELECTMAP_MODE:
>   	default:
>   		return ENVL_NOWHERE;
>   	}

Applied.
M
