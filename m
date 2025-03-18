Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD6C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61AE81DCC;
	Wed, 19 Mar 2025 04:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="edqUViPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627258129F; Tue, 18 Mar 2025 20:24:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856DE81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 20:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742325846; x=1773861846;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=TDSKsGOkgZjDb3VrFNGU3a+khqCItb8uHbblWJgYwrU=;
 b=edqUViPMEZnaGapDPvoTZ1DDWZH/TAaUBevgKe90UXN3SnKyaCCrD6dv
 7qjU+fCVJOhS8ooR3SMiSIOlMvV0orgfRmla7j9sZ21vR4yuFbHjMSol7
 yh30TXaIrdFK1opb5wSbC2xjzhdoX2PNuusFLRbqJRCzXwujlfWtrO28P
 PUlaMrwKFxKUWqAbRubfLHJM0bi6yRNIuxE+MagbL7KdQBH3P37Klk3bl
 8ZVmjVJIUJ362a2dzmmxpU48XI8he4y/xQDajQxmzLjy4iA5qUUFM11Gf
 wbiDlsDhu6L4yNOlxUDdY+YQc25tyw+/9/JAtZMZmYdNp1Jg7OS7QCJfT w==;
X-CSE-ConnectionGUID: PP/mvy0fRnOcqPOsMlGQuQ==
X-CSE-MsgGUID: M84ZOHFBRpGuDVlMn7r1FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42660705"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42660705"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 12:24:03 -0700
X-CSE-ConnectionGUID: DZcEbWGPRnyFQN1BkVAVPQ==
X-CSE-MsgGUID: dTRYSl7eTP2kU22MetOB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="153204862"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 12:24:02 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] arch/x86: Add 64-bit U-Boot configuration without SPL
In-Reply-To: <CAFLszTiszFkD_B1zgyM_a82VBuExu51kxBmyqwYoOCst+td7Xw@mail.gmail.com>
 (Simon Glass's message of "Sat, 15 Mar 2025 12:46:57 +0000")
References: <87ldt7uzzc.fsf@jcompost-mobl.amr.corp.intel.com>
 <CAFLszTiszFkD_B1zgyM_a82VBuExu51kxBmyqwYoOCst+td7Xw@mail.gmail.com>
Date: Tue, 18 Mar 2025 12:24:01 -0700
Message-ID: <87ldt2ta5q.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
 CA 95052. USA
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
Content-Type: text/plain
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

Thank you for your review. I submitted five commits as requested. I believe they are in the queue of the moderator since I am not a member of the mailing list.

Regards,

Jeremy

Simon Glass <sjg@chromium.org> writes:

> Hi Jeremy,
>
> On Fri, 14 Mar 2025 at 22:59, Jeremy Compostella
> <jeremy.compostella@intel.com> wrote:
>>
>> This commit introduces a new configuration option X86_RUN_64BIT_NO_SPL
>> to allow building U-Boot as a 64-bit binary without using the SPL
>> (Secondary Program Loader). The motivation is to simplify the boot
>> process for specific x86-based platforms that do not require SPL, such
>> as those booting directly from a 64-bit coreboot firmware.
>>
>> Key changes include:
>>
>> - Updated arch/x86/Kconfig to add a new choice for 64-bit U-Boot without
>>   SPL.
>>
>> - Modified logic in arch/x86/cpu/coreboot/coreboot.c and
>>   arch/x86/lib/zimage.c to use CONFIG_X86_64 instead of
>>   CONFIG_X86_RUN_64BIT for consistency.
>>
>> - Adjusted the arch/x86/cpu/coreboot/Kconfig to select BINMAN based on
>>   the CONFIG_X86_RUN_64BIT configuration.
>>
>> - Created a new defconfig file configs/coreboot64-no-spl_defconfig to
>>   provide default configurations for building U-Boot in this new
>>   mode. This includes enabling 64-bit operation, setting appropriate
>>   memory addresses, and specifying boot arguments and commands.
>>
>> - Updated include/config_distro_bootcmd.h to determine the correct boot
>>   EFI file name based on the new configuration.
>
> I think this patch would be better as separate commits, where each
> does one thing as you have listed above.
>
> Also, please use imperative tense, i.e. 'Update xxx to ...'
>
> With those changes you can add:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> to each.
>
>>
>> These changes are aimed at enhancing the flexibility and compatibility
>> of U-Boot on x86 platforms, particularly for systems utilizing 64-bit
>> coreboot without the need for a separate SPL stage.
>>
>> TEST=Built and booted U-Boot using the new configuration option on a
>>      coreboot-64-bit-supported device. Verified successful boot process and
>>      execution of U-Boot in 64-bit mode without SPL.
>>
>> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
>> ---
>>  arch/x86/Kconfig                    |  8 +++-
>>  arch/x86/cpu/coreboot/Kconfig       |  2 +-
>>  arch/x86/cpu/coreboot/coreboot.c    |  2 +-
>>  arch/x86/lib/zimage.c               |  2 +-
>>  configs/coreboot64-no-spl_defconfig | 62 +++++++++++++++++++++++++++++
>>  include/config_distro_bootcmd.h     |  2 +-
>>  6 files changed, 73 insertions(+), 5 deletions(-)
>>  create mode 100644 configs/coreboot64-no-spl_defconfig
>
> Thanks for looking at this.
>
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 006a59d6fa6..ecccad692e6 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -30,7 +30,7 @@ config X86_RUN_32BIT
>>           arch_phys_memset() can be used for basic access to other memory.
>>
>>  config X86_RUN_64BIT
>> -       bool "64-bit"
>> +       bool "32-bit SPL followed by 64-bit U-Boot"
>>         select X86_64
>>         select SPL if !EFI_APP
>>         select SPL_SEPARATE_BSS if !EFI_APP
>> @@ -40,6 +40,12 @@ config X86_RUN_64BIT
>>           runs through the 16-bit and 32-bit init, then switches to 64-bit
>>           mode and jumps to U-Boot proper.
>>
>> +config X86_RUN_64BIT_NO_SPL
>> +       bool "64-bit"
>> +       select X86_64
>> +       help
>> +         Build U-Boot as a 64-bit binary without SPL.
>
> Can you expand the help a little? You can say that with this option,
> U-Boot must be entered in 64-bit mode directly, meaning that a
> previous phase must have done the CPU setup (MP, page tables, etc.).
>
>> +
>>  endchoice
>>
>>  config X86_64
>> diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
>> index 085302c0482..66f25533b97 100644
>> --- a/arch/x86/cpu/coreboot/Kconfig
>> +++ b/arch/x86/cpu/coreboot/Kconfig
>> @@ -26,7 +26,7 @@ config SYS_COREBOOT
>>         imply CBMEM_CONSOLE
>>         imply X86_TSC_READ_BASE
>>         imply USE_PREBOOT
>> -       select BINMAN if X86_64
>> +       select BINMAN if X86_RUN_64BIT
>>         select SYSINFO
>>         imply SYSINFO_EXTRA
>>
>> diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
>> index fa7430b436f..d0719d1a405 100644
>> --- a/arch/x86/cpu/coreboot/coreboot.c
>> +++ b/arch/x86/cpu/coreboot/coreboot.c
>> @@ -22,7 +22,7 @@ int arch_cpu_init(void)
>>  {
>>         int ret;
>>
>> -       ret = IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
>> +       ret = IS_ENABLED(CONFIG_X86_64) ? x86_cpu_reinit_f() :
>>                 x86_cpu_init_f();
>
> This seems to change the behavior for the coreboot32->U-Boot
> SPL->U-Boot 64 case. But your change seems correct to me.
>
>>         if (ret)
>>                 return ret;
>> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
>> index 2eece34a073..ca3bd713ff2 100644
>> --- a/arch/x86/lib/zimage.c
>> +++ b/arch/x86/lib/zimage.c
>> @@ -424,7 +424,7 @@ int zboot_go(void)
>>
>>         entry = state.load_address;
>>         image_64bit = false;
>> -       if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
>> +       if (IS_ENABLED(CONFIG_X86_64) &&
>>             (hdr->xloadflags & XLF_KERNEL_64)) {
>>                 image_64bit = true;
>>         }
>> diff --git a/configs/coreboot64-no-spl_defconfig b/configs/coreboot64-no-spl_defconfig
>> new file mode 100644
>> index 00000000000..dd07524560b
>> --- /dev/null
>> +++ b/configs/coreboot64-no-spl_defconfig
>> @@ -0,0 +1,62 @@
>> +CONFIG_X86=y
>> +CONFIG_TEXT_BASE=0x1110000
>> +CONFIG_SYS_MALLOC_LEN=0x2000000
>> +CONFIG_NR_DRAM_BANKS=8
>> +CONFIG_ENV_SIZE=0x1000
>> +CONFIG_DEFAULT_DEVICE_TREE="coreboot"
>> +CONFIG_PRE_CON_BUF_ADDR=0x100000
>> +CONFIG_X86_RUN_64BIT_NO_SPL=y
>> +CONFIG_VENDOR_COREBOOT=y
>> +CONFIG_TARGET_COREBOOT=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_SIGNATURE=y
>> +CONFIG_BOOTSTD_FULL=y
>> +CONFIG_BOOTSTD_DEFAULTS=y
>> +CONFIG_SYS_MONITOR_BASE=0x01110000
>> +CONFIG_SHOW_BOOT_PROGRESS=y
>> +CONFIG_USE_BOOTARGS=y
>> +CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
>> +CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then bootflow boot; fi"
>> +CONFIG_PRE_CONSOLE_BUFFER=y
>> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
>> +CONFIG_LOG=y
>> +CONFIG_LOGF_LINE=y
>> +CONFIG_LOGF_FUNC=y
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_CMD_IDE=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_SATA=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_BOOTP_BOOTFILESIZE=y
>> +CONFIG_CMD_TIME=y
>> +CONFIG_CMD_SOUND=y
>> +CONFIG_CMD_EXT4_WRITE=y
>> +CONFIG_MAC_PARTITION=y
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> +CONFIG_USE_BOOTFILE=y
>> +CONFIG_BOOTFILE="bzImage"
>> +CONFIG_TFTP_TSIZE=y
>> +CONFIG_USE_ROOTPATH=y
>> +CONFIG_REGMAP=y
>> +CONFIG_SYSCON=y
>> +# CONFIG_ACPIGEN is not set
>> +CONFIG_SYS_IDE_MAXDEVICE=4
>> +CONFIG_SYS_ATA_DATA_OFFSET=0
>> +CONFIG_SYS_ATA_REG_OFFSET=0
>> +CONFIG_SYS_ATA_ALT_OFFSET=0
>> +CONFIG_ATAPI=y
>> +CONFIG_LBA48=y
>> +CONFIG_SYS_64BIT_LBA=y
>> +CONFIG_NVME_PCI=y
>> +# CONFIG_PCI_PNP is not set
>> +CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_SOUND=y
>> +CONFIG_SOUND_I8254=y
>> +CONFIG_VIDEO_COPY=y
>> +CONFIG_CONSOLE_TRUETYPE=y
>> +CONFIG_CONSOLE_SCROLL_LINES=5
>> +CONFIG_CMD_DHRYSTONE=y
>> +# CONFIG_GZIP is not set
>> +CONFIG_SMBIOS_PARSER=y
>> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
>> index 0a4e4b8ff85..8ac3a4feeb8 100644
>> --- a/include/config_distro_bootcmd.h
>> +++ b/include/config_distro_bootcmd.h
>> @@ -112,7 +112,7 @@
>>  #define BOOTEFI_NAME "bootarm.efi"
>>  #elif defined(CONFIG_X86_RUN_32BIT)
>>  #define BOOTEFI_NAME "bootia32.efi"
>> -#elif defined(CONFIG_X86_RUN_64BIT)
>> +#elif defined(CONFIG_X86_64)
>>  #define BOOTEFI_NAME "bootx64.efi"
>>  #elif defined(CONFIG_ARCH_RV32I)
>>  #define BOOTEFI_NAME "bootriscv32.efi"
>> --
>> 2.48.1
>>
>
> We don't use the distro scripts anymore on x86, but this change seems fine.
>
> Regards,
> Simon

-- 
Jeremy
One Emacs to rule them all
