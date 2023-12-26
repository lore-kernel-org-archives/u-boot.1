Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48AC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B4586FCE;
	Tue, 26 Dec 2023 08:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8571387032; Tue, 26 Dec 2023 08:45:26 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06824807A7
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ7jHIG020765
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:45:17 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 26 Dec 2023 15:45:17 +0800
Date: Tue, 26 Dec 2023 15:45:13 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph@andestech.com>
Subject: Re: [PATCH v2 6/6] andes: ae350: Enable MISC_INIT_R for ae350 platform
Message-ID: <ZYqEiazBiQqmSsrt@APC323>
References: <20231226065441.1130540-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231226065441.1130540-1-ycliang@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ7jHIG020765
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

On Tue, Dec 26, 2023 at 02:54:41PM +0800, Leo Yu-Chi Liang wrote:
> Enable MISC_INIT_R for ae350 to support CPU name detection
> and re-sync the configs via make savedefconfig.
> 
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

> ---
>  configs/ae350_rv32_defconfig         | 5 +++--
>  configs/ae350_rv32_spl_defconfig     | 5 +++--
>  configs/ae350_rv32_spl_xip_defconfig | 5 +++--
>  configs/ae350_rv32_xip_defconfig     | 5 +++--
>  configs/ae350_rv64_defconfig         | 5 +++--
>  configs/ae350_rv64_spl_defconfig     | 5 +++--
>  configs/ae350_rv64_spl_xip_defconfig | 5 +++--
>  configs/ae350_rv64_xip_defconfig     | 5 +++--
>  8 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
> index 06cd972a0d..3bfa3e9f8e 100644
> --- a/configs/ae350_rv32_defconfig
> +++ b/configs/ae350_rv32_defconfig
> @@ -11,14 +11,15 @@ CONFIG_SYS_LOAD_ADDR=0x100000
>  CONFIG_TARGET_ANDES_AE350=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
> index f469d5bb2b..aeb50206d2 100644
> --- a/configs/ae350_rv32_spl_defconfig
> +++ b/configs/ae350_rv32_spl_defconfig
> @@ -16,19 +16,20 @@ CONFIG_RISCV_SMODE=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SPL_MAX_SIZE=0x100000
>  CONFIG_SPL_BSS_START_ADDR=0x400000
>  CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_CACHE=y
>  CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
> index 9672a19c23..f15ec301ce 100644
> --- a/configs/ae350_rv32_spl_xip_defconfig
> +++ b/configs/ae350_rv32_spl_xip_defconfig
> @@ -17,19 +17,20 @@ CONFIG_SPL_XIP=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SPL_MAX_SIZE=0x100000
>  CONFIG_SPL_BSS_START_ADDR=0x400000
>  CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_CACHE=y
>  CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
> index b90200a97e..c40eb043c5 100644
> --- a/configs/ae350_rv32_xip_defconfig
> +++ b/configs/ae350_rv32_xip_defconfig
> @@ -12,14 +12,15 @@ CONFIG_TARGET_ANDES_AE350=y
>  CONFIG_XIP=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
> index a4b9ad6162..7ae938aeb2 100644
> --- a/configs/ae350_rv64_defconfig
> +++ b/configs/ae350_rv64_defconfig
> @@ -11,14 +11,15 @@ CONFIG_TARGET_ANDES_AE350=y
>  CONFIG_ARCH_RV64I=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
> index 834a0fbbdd..68ac4325ab 100644
> --- a/configs/ae350_rv64_spl_defconfig
> +++ b/configs/ae350_rv64_spl_defconfig
> @@ -16,19 +16,20 @@ CONFIG_RISCV_SMODE=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SPL_MAX_SIZE=0x100000
>  CONFIG_SPL_BSS_START_ADDR=0x400000
>  CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_CACHE=y
>  CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
> index b52b8d78d7..839ca335d4 100644
> --- a/configs/ae350_rv64_spl_xip_defconfig
> +++ b/configs/ae350_rv64_spl_xip_defconfig
> @@ -17,19 +17,20 @@ CONFIG_SPL_XIP=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SPL_MAX_SIZE=0x100000
>  CONFIG_SPL_BSS_START_ADDR=0x400000
>  CONFIG_SPL_BOARD_INIT=y
>  CONFIG_SPL_CACHE=y
>  CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
> index cc5e751c9b..5432b6d6d7 100644
> --- a/configs/ae350_rv64_xip_defconfig
> +++ b/configs/ae350_rv64_xip_defconfig
> @@ -12,14 +12,15 @@ CONFIG_ARCH_RV64I=y
>  CONFIG_XIP=y
>  CONFIG_SYS_MONITOR_BASE=0x88000000
>  CONFIG_FIT=y
> +CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> +CONFIG_SYS_PBSIZE=1050
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
>  CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_MISC_INIT_R=y
>  CONFIG_SYS_PROMPT="RISC-V # "
> -CONFIG_SYS_PBSIZE=1050
> -CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_CMD_IMLS=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_SF_TEST=y
> -- 
> 2.34.1
> 
