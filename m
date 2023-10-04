Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE6E8FDCB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 06:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7895286D1E;
	Wed,  4 Oct 2023 08:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0rd4Zcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D825687224; Wed,  4 Oct 2023 08:23:17 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A60586D1E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 08:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7GH60bstr4xvu7KazN2fBy6+kdAR6QJnQeQrAPe37SodI9/lzgroDrAl83YtXy+/C/vLH7bmhkAZnWkWg0MXizapIOSWpbFATYKrqm3KCRPk6wG6J9fkinXMP9OY/jLKSD5GAemPpPWRpRW6EZOXFTcbiyr0iS5uIGgLj2NyJJQbu/3V0843pRCz1o9gaoKNUF8IqlSs9LfKtzF5Wmle4tvBxu2nQc9Tkd5nGc+jrA95EKi20kRhXlUO6jl1ieS6bDwnHz3wPkBr/CIapR+YPRNKHC2xduNH6PKSHpYbag6YBcpq5Fs7/nb6HyELIUzWQV4cSVNCxMwrRtqNFQy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo2pCJtv9UrP/BHEIjigXX7oFvikLvY8iiVkWJsQyjY=;
 b=fshugB19j1OtBXXN0DmCjSOuw491aCgEd7EhJGa4SBW1ENNPSQq6kVvJrpgDHg00WBA4/hVh6zbTQmTXDuhfrJDOFJLGFrFcD29mPiiQTg9amp+3eizlqoTyqmeniQXCppXcW43HfuO0/5TcdcFJS94Xvtn2DMaA4ADP8K+PJ+x93XL/nE7Bzn2qnLXknZpL7feJpO64ySlZi1sJprVIzXsSlknqJ1m6kbf+wdTil2Doc4q61Yv75ZYAOeTu2TX9DDq5lx15b7TUR5I8TtIyjA64KWAIi7b0RAb+/qmBhtVq6mpitkjHcYhPzBsIokyD44gjLnkARtnMwmOSbCmiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arri.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo2pCJtv9UrP/BHEIjigXX7oFvikLvY8iiVkWJsQyjY=;
 b=B0rd4ZcdI29GLYuee3N66gh035bDMWgIgqfR1OnDrwO6Rx6IXmixejR9wuYJk4uPmEIPsTh0UXrb79dYcvyCf6i0xGO/w9PZz+N6+JuwRcCPhNJXTwXRq0bVDYebcXJhzqbm4tqjlcaMfR0jCbNr+7VwGMrCgNOEwKqYTO5IYLo=
Received: from BLAPR03CA0067.namprd03.prod.outlook.com (2603:10b6:208:329::12)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 06:23:03 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::bb) by BLAPR03CA0067.outlook.office365.com
 (2603:10b6:208:329::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 06:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 06:23:01 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 01:22:59 -0500
Message-ID: <edc1a869-c17d-457c-8ac5-42f261e06890@amd.com>
Date: Wed, 4 Oct 2023 08:22:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: versal: Add SelectMAP boot mode identification
To: "Polak, Leszek" <LPolak@arri.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Roese <sr@denx.de>
References: <DU0PR07MB84197FD4D47E8F4921E200B1C8C4A@DU0PR07MB8419.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DU0PR07MB84197FD4D47E8F4921E200B1C8C4A@DU0PR07MB8419.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fd8c15-ac91-44ca-9379-08dbc4a25c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnqs/TQ707A8I+Y7GeI+l9vHCwzo/ZwgL2u3FCJDvDdjnJGaGzX23E8AZno5nP7Vp0JNYF/CRBXJl/BANidLZ85siU+ZzxVlPSfJaxic7/O67stVapVHDWz4dIMNrQPYaFieL1Wah37rxGo58xwrET4Far0CXZBtGvKTPYQrhcBkUFY35a0RJhpY2IPWrD8FZJQ2vWeHyrMBkuLhGSwzjaC6Y/V7YfagdWByHNtxlumcxrbr+i9xajjbC0wV7uxLJWt5TfBVCgR2W+dnQJ0QOB49rCAxrK3xdnwCXqb95qTA5Y5NJbgzOzGBQ5v2lvZPSrJcFUBhazLn79kPaoHVE2uFIqTVAQq39wfAwvCxlNvqdAU4maUgiq9GqH2wakTfnEZoPd2lwiIIQYLFos3Ersc0ONE9Y7nil2qShUDVwmcL+I2k+izqayBDDGb9mHGzX0EzPPYMOoAHKO6cHlG/VO2z2rfPnv1Wey0pzjjTJSpRAZDebtVMdH/RCBNxwuCHnKsa+YnuPd4yuC4suEL3k542WD0j0hMIYkdhhUHKKFaAXTVVbBbU0oaPAqcT08ohEKUHLf4DVou2lB5XSES947POXZ43PAXlKxAHeRkRXhcDCqg3H2+4k5Vk48zb3Ux5+lpPM2/TyZrBLZu2plNXvjh9lLOZsiofiyd/VS9JFreQlGr22+9uivdt7nnmhh8Goy6QKSk4oLUqQEwOUkcy+tcgiUnh3huREA7rTpd/G7J/tPy048Ce7GHTswHi6JlmRjIDx1AJLuRwSkpE6N9proHenQpLivv52w5ld/liP16Yxy4AExGhep28HY/eZRjOFvLWL4xyI8J+mtYYmBP3og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(45080400002)(40480700001)(47076005)(2906002)(36860700001)(356005)(81166007)(83380400001)(82740400003)(8676002)(70586007)(70206006)(966005)(53546011)(478600001)(110136005)(5660300002)(2616005)(4326008)(426003)(44832011)(336012)(41300700001)(26005)(16576012)(316002)(16526019)(8936002)(86362001)(36756003)(31696002)(40460700003)(31686004)(84970400001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 06:23:01.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fd8c15-ac91-44ca-9379-08dbc4a25c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

Hi,

On 10/3/23 19:04, Polak, Leszek wrote:
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
> 
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
>   #define EMMC_MODE       0x00000006
>   #define USB_MODE        0x00000007
>   #define OSPI_MODE       0x00000008
> +#define SELECTMAP_MODE 0x0000000A
>   #define SD1_LSHFT_MODE  0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE       0x00000000
>   #define BOOT_MODE_USE_ALT       0x100
> diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-versal/include/mach/hardware.h
> index 000af974e8..9d1c2f0dcf 100644
> --- a/arch/arm/mach-versal/include/mach/hardware.h
> +++ b/arch/arm/mach-versal/include/mach/hardware.h
> @@ -82,6 +82,7 @@ struct crp_regs {
>   #define EMMC_MODE       0x00000006
>   #define USB_MODE        0x00000007
>   #define OSPI_MODE       0x00000008
> +#define SELECTMAP_MODE 0x0000000A
>   #define SD1_LSHFT_MODE  0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE       0x00000000
>   #define BOOT_MODE_USE_ALT       0x100
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index f0d2224b33..651b7d24d7 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -260,6 +260,9 @@ int board_late_init(void)
>                   mode = "mmc";
>                   bootseq = dev_seq(dev);
>                   break;
> +       case SELECTMAP_MODE:
> +               puts("SELECTMAP_MODE\n");
> +               break;
>           case SD_MODE:
>                   puts("SD_MODE\n");
>                   if (uclass_get_device_by_name(UCLASS_MMC,
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 60bf37d3c9..26b4c7bf39 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -182,6 +182,9 @@ int board_late_init(void)
>                   mode = "mmc";
>                   bootseq = dev_seq(dev);
>                   break;
> +       case SELECTMAP_MODE:
> +               puts("SELECTMAP_MODE\n");
> +               break;
>           case SD_MODE:
>                   puts("SD_MODE\n");
>                   if (uclass_get_device_by_name(UCLASS_MMC,
> @@ -298,6 +301,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
>                           return ENVL_SPI_FLASH;
>                   return ENVL_NOWHERE;
>           case JTAG_MODE:
> +       case SELECTMAP_MODE:
>           default:
>                   return ENVL_NOWHERE;
>           }

If I compare v2 with with v3 I see that tabs have been converted to spaces which 
is nicely visible above if you focus on alignment.
This is causing that I can't apply the patch.
Please fix it.

Thanks,
Michal

[u-boot](debian-sent3)$ b4 am 
DU0PR07MB84197FD4D47E8F4921E200B1C8C4A@DU0PR07MB8419.eurprd07.prod.outlook.com
Grabbing thread from 
lore.kernel.org/all/DU0PR07MB84197FD4D47E8F4921E200B1C8C4A%40DU0PR07MB8419.eurprd07.prod.outlook.com/t.mbox.gz
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v3] arm64: versal: Add SelectMAP boot mode identification
   ---
   ✓ Signed: DKIM/arrigroup.onmicrosoft.com (From: LPolak@arri.de)
---
Total patches: 1
---
  Link: 
https://lore.kernel.org/r/DU0PR07MB84197FD4D47E8F4921E200B1C8C4A@DU0PR07MB8419.eurprd07.prod.outlook.com
  Base: not specified
        git am 
./v3_20231003_lpolak_arm64_versal_add_selectmap_boot_mode_identification.mbx
[u-boot](debian-sent3)$ git am -s 
./v3_20231003_lpolak_arm64_versal_add_selectmap_boot_mode_identification.mbx
Adding link to lore.kernel.org
Applying: arm64: versal: Add SelectMAP boot mode identification
error: patch failed: arch/arm/mach-versal-net/include/mach/hardware.h:66
error: arch/arm/mach-versal-net/include/mach/hardware.h: patch does not apply
error: patch failed: arch/arm/mach-versal/include/mach/hardware.h:82
error: arch/arm/mach-versal/include/mach/hardware.h: patch does not apply
error: patch failed: board/xilinx/versal-net/board.c:260
error: board/xilinx/versal-net/board.c: patch does not apply
error: patch failed: board/xilinx/versal/board.c:182
error: board/xilinx/versal/board.c: patch does not apply
Patch failed at 0001 arm64: versal: Add SelectMAP boot mode identification
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

