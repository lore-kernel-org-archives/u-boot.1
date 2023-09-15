Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FBEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD5286545;
	Fri, 15 Sep 2023 13:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAXWEJ2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19548654A; Fri, 15 Sep 2023 13:25:38 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C3B864EE
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 13:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N76Msad1+llo89CCLd4rIJgy6j9tXyfzEiMvdTFmg/yZWbuwZSrIlw3qh6Le9iLicIBcmlfJ50ijPcVNVbOzcnICj4BSKDX3IMeTFc/kLuzZBdUqSM0s3+e+gZU62wlsehT+1Db7FPWnVSqWFt5pwjS1byAG5/UQCCmj0+dqhN7oAzvnHcrwZx1xf8A3VPzoIf6t+JaDDuqiHhAB+N5WIQkzHNMWVp025xqwUEKdpzbqfQlhtCh6clQDNrCpPeKF0uJKA96E1XZO9Qht+/LJMtpGbXhrSWPyjGqX3QIgcXE6jTsAslsG99fCzRDQhLIEMZIOB5gWN77yp8hsPl7IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyaw1rl0dHltg4HlF4947GZ+Gfeg9pbM8TUAamDq+rY=;
 b=oOra5khAPWHDSiz9XZRXvT2syHJuZWO+7UeZnYmpyGesZSqkt5ayizEm5fAq2RNb8ma3YS4FcjNT9c9UyKOMoRBOWoaodNv0tWM7d5dR6SWxEow7DyKgr9zn4RRip9rksAy0iHfZHIIbMYmJNRDcQTBz0pSoMYmS5V3CsryN34MvDt3Kg2TPVQGmMquLvjZLcwlZVsynhaEouFlENItzbVY9QIE9mo84nLuAhZOV5p4NiTp1sGng09HBQxM1PIos/g+yuapFlGisaPNZ/UCqsu8gqkp8nPtcSXRWME/O/+JQAlSBR2NiEwsNblxU84IDPpCnvLRDRrXnB9RFLjpRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyaw1rl0dHltg4HlF4947GZ+Gfeg9pbM8TUAamDq+rY=;
 b=CAXWEJ2Pu2b3WCSHjYx1OGuj4f8TMb/SJrTxKKBiNSZMljRL5Svsx0ekq8SwCzBBwPZ2aveBKnu5vlVinrZaMkAZemk1+E2vWCEihY74L3H69u/hhXLqUeJDcVju/GVdLTfTgvDM8yJcrrBw4VFacBOfEgu7KJhlp03z3fI7gEI=
Received: from BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:25:32 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::e2) by BL0PR02CA0029.outlook.office365.com
 (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 11:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:25:31 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:25:29 -0500
Message-ID: <51016e88-2c90-4a9b-8cfa-c34e7e4f90b0@amd.com>
Date: Fri, 15 Sep 2023 13:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] global: Use proper project name U-Boot (next2)
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alexander Graf <agraf@csgraf.de>, Angelo Dureghello
 <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, Sean Anderson
 <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
References: <536af05e7061982f15b668e87f941cdabfa25392.1694157084.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <536af05e7061982f15b668e87f941cdabfa25392.1694157084.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH0PR12MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6401a81a-3d7e-4f0b-e808-08dbb5de78e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVtqLL58AFwAIe7uPrqseVSph+1C2rm9FV5o/4URZmXnNgN6Ni7/nHrVrSSopV5DEb8+4SZGCgT2Phvl9qzGuLKieeelZMSY1YMLJenYgaPHo5lwy3B8HoQKGAXnlp1g4RafblzGEbZfD9TWKBJKBTczv7hYvQxDo3jfzDUHw/07L46QgvooK46aCRxK3Ytc/9IgkVK5iYOukosWZyLHE8xkO1rLTdVbEZiJlCDvMGphniYki3UVfrVz808XKRXHECn8pjxxioPEBvNDGZT8RT56uAYVQkGxlcsyw7B5qeHLW7hrquTJJ/k+N5PklNNnc9WjLXTZh/MO63XrSKgFif8M3I5trp8JjfwHdRn7T38wSWfGtnxgppsdSqUnqUbDsNbPbDP5tqmbOe9PH192tUV17tmv8zcQam519VPk/9qORnLRjJjDDH8h5LFKOAM9h7X8Ez4CvuokwVIEsPKCl90P4YTPsGazaTp+tDvYdVLE1QmCqL7iceC1BJ9sQO/iaboCRTe4wZV3pQlhCoCfywbz3nWSE7nidO3Tz+OeAs5Ua3UamaBGMVvRe9QLjlX8fXiYEny2dsQOQvMuPyKOLZBBbI4tDDe/uVt+rBMLK0jooxNTARGD8mp9NDY81AEgGVyE5zYuviVmi7y60NnR4e4h2FV5FcAAXXjCpoyzdPQvnpSqJJd5KnWzsd9h5WheSpz3Bl4+BwvuTos/IFYFuG5yhdZN5jZ+aLPRqH4uiYtmvZ6V3PkVYALlFjVwKeW/MKL8m6KLdpi5PSBWtjoSap9EM43l+yWpugHfJCCeHkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(16526019)(26005)(5660300002)(40460700003)(8936002)(8676002)(4326008)(2616005)(31696002)(2906002)(86362001)(83380400001)(15188155005)(81166007)(82740400003)(356005)(36860700001)(47076005)(336012)(16799955002)(36756003)(426003)(40480700001)(44832011)(110136005)(54906003)(70206006)(70586007)(53546011)(478600001)(31686004)(41300700001)(16576012)(316002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:25:31.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6401a81a-3d7e-4f0b-e808-08dbb5de78e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
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



On 9/8/23 09:11, Michal Simek wrote:
> Use proper project name in README, rst and comment.
> Done in connection to commit bb922ca3eb4b ("global: Use proper project name
> U-Boot (next)").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Revert change in tools/binman/entries.rst reported by Simon
> 
>   board/cobra5272/README                      | 18 +++++++++---------
>   board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
>   doc/board/xilinx/zynq.rst                   |  2 +-
>   doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
>   doc/imx/mkimage/imximage.txt                |  2 +-
>   doc/usage/environment.rst                   |  2 +-
>   doc/usage/semihosting.rst                   |  2 +-
>   7 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/board/cobra5272/README b/board/cobra5272/README
> index 11abcfacdb6e..0b07148b73a3 100644
> --- a/board/cobra5272/README
> +++ b/board/cobra5272/README
> @@ -1,6 +1,6 @@
>   File:		README.COBRA5272
>   Author:		Florian Schlote for Sentec elektronik (linux@sentec-elektronik.de)
> -Contents:	This is the README of u-boot (Universal bootloader) for our
> +Contents:	This is the README of U-Boot (Universal bootloader) for our
>   		COBRA5272 board.
>   Version:	v01.00
>   Date:		Tue Mar 30 00:28:33 CEST 2004
> @@ -31,7 +31,7 @@ Please refer to u-boot README (general info, u-boot-x-x-x/README),
>   to u-boot-x-x-x/board/cobra5272/README and
>   to the comments in u-boot-x-x-x/include/configs/cobra5272.h
>   
> -Configuring u-boot is done by commenting/uncommenting preprocessor defines.
> +Configuring U-Boot is done by commenting/uncommenting preprocessor defines.
>   
>   Default configuration is
>   
> @@ -48,10 +48,10 @@ Default configuration is
>   
>   
>   #-----------------------------------
> -# u-boot FLASH version & RAM version
> +# U-Boot FLASH version & RAM version
>   #-----------------------------------
>   
> -The u-boot bootloader for Coldfire processors can be configured
> +The U-Boot bootloader for Coldfire processors can be configured
>   
>   	1. as a standalone bootloader residing in flash & relocating itself to RAM on
>   	startup automatically => "FLASH version"
> @@ -60,7 +60,7 @@ The u-boot bootloader for Coldfire processors can be configured
>   	prestage bootloader ("chainloading") & is running only from the RAM address it
>   	is linked to => "RAM version"
>   
> -	This version may be very helpful when installing u-boot for the first time
> +	This version may be very helpful when installing U-Boot for the first time
>   	since it can be used to make available s. th. like a "bootstrap
>   	mechanism".
>   
> @@ -71,7 +71,7 @@ How to build the different images:
>   Flash version
>   ------------------------------
>   
> -Compile u-boot
> +Compile U-Boot
>   
>   in dir ./u-boot-x-x-x/
>   
> @@ -81,14 +81,14 @@ please first check:
>   
>   		CONFIG_MONITOR_IS_IN_RAM has to be not present in the file
>   
> -	=> u-boot as single bootloader starting from flash
> +	=> U-Boot as single bootloader starting from flash
>   
>   
>   	in configs/cobra5272_defconfig CONFIG_TEXT_BASE should be
>   
>   		CONFIG_TEXT_BASE=0xffe00000
>   
> -	=> linking address for u-boot as single bootloader stored in flash
> +	=> linking address for U-Boot as single bootloader stored in flash
>   
>   then:
>   
> @@ -116,7 +116,7 @@ please modify the settings:
>   
>   		CONFIG_MONITOR_IS_IN_RAM=y
>   
> -	=> u-boot as RAM version, chainloaded by another bootloader or using bdm cable
> +	=> U-Boot as RAM version, chainloaded by another bootloader or using bdm cable
>   
>   
>   	in configs/cobra5272_defconfig CONFIG_TEXT_BASE should be
> diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
> index a39bcb4fa0c7..40fd9e5e02b1 100644
> --- a/board/emulation/qemu-ppce500/qemu-ppce500.c
> +++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
> @@ -318,7 +318,7 @@ ulong get_bus_freq(ulong dummy)
>   int cpu_numcores(void)
>   {
>   	/*
> -	 * The QEMU u-boot target only needs to drive the first core,
> +	 * The QEMU U-Boot target only needs to drive the first core,
>   	 * spinning and device tree nodes get driven by QEMU itself
>   	 */
>   	return 1;
> diff --git a/doc/board/xilinx/zynq.rst b/doc/board/xilinx/zynq.rst
> index 438912fe42c2..76d67bd62ee9 100644
> --- a/doc/board/xilinx/zynq.rst
> +++ b/doc/board/xilinx/zynq.rst
> @@ -83,7 +83,7 @@ Mainline status
>   ---------------
>   
>   - Added basic board configurations support.
> -- Added zynq u-boot bsp code - arch/arm/mach-zynq
> +- Added zynq U-Boot bsp code - arch/arm/mach-zynq
>   - Added zynq boards named - zc70x, zed, microzed, zc770_xm010/xm011/xm012/xm013
>   - Added zynq drivers:
>   
> diff --git a/doc/board/xilinx/zynqmp-r5.rst b/doc/board/xilinx/zynqmp-r5.rst
> index 2cd368b0308e..266d07d1193f 100644
> --- a/doc/board/xilinx/zynqmp-r5.rst
> +++ b/doc/board/xilinx/zynqmp-r5.rst
> @@ -26,7 +26,7 @@ configure and build armv7 toolchain::
>   Notes
>   ^^^^^
>   
> -Output fragment is u-boot.
> +Output fragment is U-Boot.
>   
>   Loading
>   -------
> @@ -38,7 +38,7 @@ Bootgen
>   ^^^^^^^
>   
>   The first way is to use Xilinx FSBL (First stage
> -bootloader) to load u-boot and start it. The following bif can be used for boot
> +bootloader) to load U-Boot and start it. The following bif can be used for boot
>   image generation via Xilinx bootgen utility::
>   
>   
> diff --git a/doc/imx/mkimage/imximage.txt b/doc/imx/mkimage/imximage.txt
> index f2cf23c5dab8..fa4e486661c2 100644
> --- a/doc/imx/mkimage/imximage.txt
> +++ b/doc/imx/mkimage/imximage.txt
> @@ -213,7 +213,7 @@ Disk identifier: 0xb712a870
>   	Device Boot	 Start	       End	Blocks	 Id  System
>   /dev/mmcblk0p1		     3		16	112455	 83  Linux
>   
> -I have set 100MB, leaving the first 2 sectors free. I will copy u-boot
> +I have set 100MB, leaving the first 2 sectors free. I will copy U-Boot
>   there.
>   
>   8. Write the partition table and exit.
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index c6439dde6689..c57b717caaf3 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -216,7 +216,7 @@ fdt_high
>       0xffffffffffffffff (64-bit machines) then
>       the fdt will not be copied at all on boot.  For this
>       to work it must reside in writable memory, have
> -    sufficient padding on the end of it for u-boot to
> +    sufficient padding on the end of it for U-Boot to
>       add the information it needs into it, and the memory
>       must be accessible by the kernel. This usage is strongly discouraged
>       however as it also stops U-Boot from ensuring the device tree starting
> diff --git a/doc/usage/semihosting.rst b/doc/usage/semihosting.rst
> index 6a280b455e0c..9303a6364d5d 100644
> --- a/doc/usage/semihosting.rst
> +++ b/doc/usage/semihosting.rst
> @@ -23,7 +23,7 @@ eMMC or other NV media are available.
>   There are two main ARM virtual Fixed Virtual Platform (FVP) models,
>   `Versatile Express (VE) FVP and BASE FVP
>   <http://www.arm.com/products/tools/models/fast-models/foundation-model.php>`_.
> -The initial vexpress64 u-boot board created here runs on the VE virtual
> +The initial vexpress64 U-Boot board created here runs on the VE virtual
>   platform using the license-free Foundation_v8 simulator. Fortunately,
>   the Foundation_v8 simulator also supports the BASE_FVP model which
>   companies can purchase licenses for and contain much more functionality.


Applied.
M
