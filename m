Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5122BC4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 19:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C4F87084;
	Sun, 10 Dec 2023 20:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="hersD578";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="ZHy2zyuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60E887120; Sun, 10 Dec 2023 20:55:21 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AB287076
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 20:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id ab743003;
 Sun, 10 Dec 2023 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=8F
 7nXpHiHsJEqaciXwlKUIHVF7s=; b=hersD578M+6FeA+ZBeQGJFoS8Qf+UaEWJw
 VHEqMoGF5diCCse10jL2aEGzw/9ilnObdovm/FqApBPH93xB0IPlKcQ1tRD0A+Cd
 gdKJ5hLT4u0XsMIOEctCgyBoLH987Lz5x2duWdJSNSPfhGSPMZfc/zHmmUq5kl2P
 Lc6QhChlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 ANBY4/JdEHBQhL0zI9+wkiB984cZ6HR1rrvB3Dc5GRTPDs2V/jZHzyCSBuQ9Nn2O
 cQNc4I14RwR3oxoXyNTNDe1y24BBQTjRvdLF2+ihTGiXCZ9SxKdEBoXAqgkKJTre
 O7Ka5JkhwDGV+xUQ67iWx+ZNvzW+hWsfAFKmbRfJh8k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1702238049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgxkWD0x/lnEtfDICm5sgdSic59gNehKufY3sYE5ysM=;
 b=ZHy2zyuNMhgaiAHb0lHmpwBTqq6vCoXp42YKnod7ZwoXUxWyHYRpOciKxP94j+mKzwAOSU
 ADeKtgV1mnLKTwGkSi5dzP7/GKQmYAo5zdusiSRlXwdWeq037LpzZjp7Aa6sjoW7a8mCU3
 uMrepGL8Mvkrw+OhokesK7KzK92aAAk=
Received: from [192.168.0.2] (host-80-182-197-185.pool80182.interbusiness.it
 [80.182.197.185])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id e055eb33
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 10 Dec 2023 19:54:09 +0000 (UTC)
Message-ID: <01ecad38-516d-a562-a5ff-3519d39b28f2@kernel-space.org>
Date: Sun, 10 Dec 2023 20:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 05/18] treewide: bootm: Drop command-line args to
 boot_os_fn
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231203172622.5.Id5671bc2d663f968a6f9da1c7d248525a794a4ba@changeid>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20231203172622.5.Id5671bc2d663f968a6f9da1c7d248525a794a4ba@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 04/12/23 1:26 AM, Simon Glass wrote:
> These arguments are not used now. They cannot be provided when there is
> no bootm command invoked to provide arguments. Drop the argc and argv
> parameters.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arc/lib/bootm.c        |  2 +-
>   arch/arm/lib/bootm.c        |  3 +--
>   arch/m68k/lib/bootm.c       |  3 +--
>   arch/microblaze/lib/bootm.c |  3 +--
>   arch/mips/lib/bootm.c       |  3 +--
>   arch/nios2/lib/bootm.c      |  3 +--
>   arch/powerpc/lib/bootm.c    |  3 +--
>   arch/riscv/lib/bootm.c      |  5 ++--
>   arch/sandbox/lib/bootm.c    |  2 +-
>   arch/sh/lib/bootm.c         |  3 +--
>   arch/x86/lib/bootm.c        |  3 +--
>   arch/xtensa/lib/bootm.c     |  2 +-
>   boot/bootm.c                |  6 ++---
>   boot/bootm_os.c             | 46 ++++++++++++++-----------------------
>   include/bootm.h             |  7 +-----
>   15 files changed, 34 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
> index 44ec5864a1c6..0ae7a21b24b6 100644
> --- a/arch/arc/lib/bootm.c
> +++ b/arch/arc/lib/bootm.c
> @@ -78,7 +78,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
>   		board_jump_and_run(kernel_entry, r0, 0, r2);
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* No need for those on ARC */
>   	if ((flag & BOOTM_STATE_OS_BD_T) || (flag & BOOTM_STATE_OS_CMDLINE))
> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> index c56285738a26..ebaac029e094 100644
> --- a/arch/arm/lib/bootm.c
> +++ b/arch/arm/lib/bootm.c
> @@ -378,8 +378,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
>    * DIFFERENCE: Instead of calling prep and go at the end
>    * they are called if subcommand is equal 0.
>    */
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* No need for those on ARM */
>   	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
> diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
> index 79d8b34c0d56..0720861ae9cc 100644
> --- a/arch/m68k/lib/bootm.c
> +++ b/arch/m68k/lib/bootm.c
> @@ -34,8 +34,7 @@ void arch_lmb_reserve(struct lmb *lmb)
>   	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 1024);
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	int ret;
>   	struct bd_info  *kbd;
> diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
> index f3ec4b741b88..93cdf62e18cf 100644
> --- a/arch/microblaze/lib/bootm.c
> +++ b/arch/microblaze/lib/bootm.c
> @@ -81,8 +81,7 @@ static void boot_prep_linux(struct bootm_headers *images)
>   	}
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	images->cmdline_start = (ulong)env_get("bootargs");
>   
> diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
> index d6d2f7d9d031..05dbe6131728 100644
> --- a/arch/mips/lib/bootm.c
> +++ b/arch/mips/lib/bootm.c
> @@ -300,8 +300,7 @@ static void boot_jump_linux(struct bootm_headers *images)
>   			linux_extra);
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* No need for those on MIPS */
>   	if (flag & BOOTM_STATE_OS_BD_T)
> diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
> index 823d524c9a2d..040a806bc75e 100644
> --- a/arch/nios2/lib/bootm.c
> +++ b/arch/nios2/lib/bootm.c
> @@ -16,8 +16,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	void (*kernel)(int, int, int, char *) = (void *)images->ep;
>   	char *commandline = env_get("bootargs");
> diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
> index 910121ec9c85..4d248cb13b5f 100644
> --- a/arch/powerpc/lib/bootm.c
> +++ b/arch/powerpc/lib/bootm.c
> @@ -223,8 +223,7 @@ static int boot_body_linux(struct bootm_headers *images)
>   	return 0;
>   }
>   
> -noinline int do_bootm_linux(int flag, int argc, char *const argv[],
> -			    struct bootm_headers *images)
> +noinline int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	int	ret;
>   
> diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> index f9e1e18ae026..d90f26091530 100644
> --- a/arch/riscv/lib/bootm.c
> +++ b/arch/riscv/lib/bootm.c
> @@ -105,8 +105,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
>   	}
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* No need for those on RISC-V */
>   	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
> @@ -130,7 +129,7 @@ int do_bootm_linux(int flag, int argc, char *const argv[],
>   int do_bootm_vxworks(int flag, int argc, char *const argv[],
>   		     struct bootm_headers *images)
>   {
> -	return do_bootm_linux(flag, argc, argv, images);
> +	return do_bootm_linux(flag, images);
>   }
>   
>   static ulong get_sp(void)
> diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
> index dc8b8e46cb41..d2b514d3f0ca 100644
> --- a/arch/sandbox/lib/bootm.c
> +++ b/arch/sandbox/lib/bootm.c
> @@ -64,7 +64,7 @@ static int boot_prep_linux(struct bootm_headers *images)
>   	return 0;
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	if (flag & BOOTM_STATE_OS_PREP)
>   		return boot_prep_linux(images);
> diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
> index b205e5e3db1b..d0284582ae0e 100644
> --- a/arch/sh/lib/bootm.c
> +++ b/arch/sh/lib/bootm.c
> @@ -39,8 +39,7 @@ static unsigned long sh_check_cmd_arg(char *cmdline, char *key, int base)
>   	return val;
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* Linux kernel load address */
>   	void (*kernel) (void) = (void (*)(void))images->ep;
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 3196f9ddc2c8..34d5c585a55a 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -237,8 +237,7 @@ static int boot_jump_linux(struct bootm_headers *images)
>   				 images->os.arch == IH_ARCH_X86_64);
>   }
>   
> -int do_bootm_linux(int flag, int argc, char *const argv[],
> -		   struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	/* No need for those on x86 */
>   	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
> diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
> index fee339281502..5e8e14021ab3 100644
> --- a/arch/xtensa/lib/bootm.c
> +++ b/arch/xtensa/lib/bootm.c
> @@ -134,7 +134,7 @@ static struct bp_tag *setup_fdt_tag(struct bp_tag *params, void *fdt_start)
>    * Boot Linux.
>    */
>   
> -int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
> +int do_bootm_linux(int flag, struct bootm_headers *images)
>   {
>   	struct bp_tag *params, *params_start;
>   	ulong initrd_start, initrd_end;
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 301cfded05cb..c343f313e80a 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1099,9 +1099,9 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>   
>   	/* Call various other states that are not generally used */
>   	if (!ret && (states & BOOTM_STATE_OS_CMDLINE))
> -		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, argc, argv, images);
> +		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, images);
>   	if (!ret && (states & BOOTM_STATE_OS_BD_T))
> -		ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
> +		ret = boot_fn(BOOTM_STATE_OS_BD_T, images);
>   	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
>   		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
>   		if (ret) {
> @@ -1109,7 +1109,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>   			ret = CMD_RET_FAILURE;
>   			goto err;
>   		}
> -		ret = boot_fn(BOOTM_STATE_OS_PREP, argc, argv, images);
> +		ret = boot_fn(BOOTM_STATE_OS_PREP, images);
>   	}
>   
>   #ifdef CONFIG_TRACE
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index 598671e576c6..df1aab4b3e4d 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -23,8 +23,7 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -static int do_bootm_standalone(int flag, int argc, char *const argv[],
> -			       struct bootm_headers *images)
> +static int do_bootm_standalone(int flag, struct bootm_headers *images)
>   {
>   	int (*appl)(int, char *const[]);
>   
> @@ -33,7 +32,7 @@ static int do_bootm_standalone(int flag, int argc, char *const argv[],
>   		return 0;
>   	}
>   	appl = (int (*)(int, char * const []))images->ep;
> -	appl(argc, argv);
> +	appl(0, NULL);
>   	return 0;
>   }
>   
> @@ -50,8 +49,7 @@ static void __maybe_unused fit_unsupported_reset(const char *msg)
>   }
>   
>   #ifdef CONFIG_BOOTM_NETBSD
> -static int do_bootm_netbsd(int flag, int argc, char *const argv[],
> -			   struct bootm_headers *images)
> +static int do_bootm_netbsd(int flag, struct bootm_headers *images)
>   {
>   	void (*loader)(struct bd_info *bd, struct legacy_img_hdr *hdr,
>   		       char *console, char *cmdline);
> @@ -113,8 +111,7 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
>   #endif /* CONFIG_BOOTM_NETBSD*/
>   
>   #ifdef CONFIG_BOOTM_RTEMS
> -static int do_bootm_rtems(int flag, int argc, char *const argv[],
> -			  struct bootm_headers *images)
> +static int do_bootm_rtems(int flag, struct bootm_headers *images)
>   {
>   	void (*entry_point)(struct bd_info *);
>   
> @@ -146,8 +143,7 @@ static int do_bootm_rtems(int flag, int argc, char *const argv[],
>   #endif /* CONFIG_BOOTM_RTEMS */
>   
>   #if defined(CONFIG_BOOTM_OSE)
> -static int do_bootm_ose(int flag, int argc, char *const argv[],
> -			struct bootm_headers *images)
> +static int do_bootm_ose(int flag, struct bootm_headers *images)
>   {
>   	void (*entry_point)(void);
>   
> @@ -179,8 +175,7 @@ static int do_bootm_ose(int flag, int argc, char *const argv[],
>   #endif /* CONFIG_BOOTM_OSE */
>   
>   #if defined(CONFIG_BOOTM_PLAN9)
> -static int do_bootm_plan9(int flag, int argc, char *const argv[],
> -			  struct bootm_headers *images)
> +static int do_bootm_plan9(int flag, struct bootm_headers *images)
>   {
>   	void (*entry_point)(void);
>   	char *s;
> @@ -283,8 +278,7 @@ static void do_bootvx_fdt(struct bootm_headers *images)
>   	puts("## vxWorks terminated\n");
>   }
>   
> -static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
> -				   struct bootm_headers *images)
> +static int do_bootm_vxworks_legacy(int flag, struct bootm_headers *images)
>   {
>   	if (flag != BOOTM_STATE_OS_GO)
>   		return 0;
> @@ -294,8 +288,7 @@ static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
>   	return 1;
>   }
>   
> -int do_bootm_vxworks(int flag, int argc, char *const argv[],
> -		     struct bootm_headers *images)
> +int do_bootm_vxworks(int flag, struct bootm_headers *images)
>   {
>   	char *bootargs;
>   	int pos;
> @@ -320,18 +313,17 @@ int do_bootm_vxworks(int flag, int argc, char *const argv[],
>   	if (std_dtb) {
>   		if (flag & BOOTM_STATE_OS_PREP)
>   			printf("   Using standard DTB\n");
> -		return do_bootm_linux(flag, argc, argv, images);
> +		return do_bootm_linux(flag, images);
>   	} else {
>   		if (flag & BOOTM_STATE_OS_PREP)
>   			printf("   !!! WARNING !!! Using legacy DTB\n");
> -		return do_bootm_vxworks_legacy(flag, argc, argv, images);
> +		return do_bootm_vxworks_legacy(flag, images);
>   	}
>   }
>   #endif
>   
>   #if defined(CONFIG_CMD_ELF)
> -static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
> -			   struct bootm_headers *images)
> +static int do_bootm_qnxelf(int flag, struct bootm_headers *images)
>   {
>   	char *local_args[3];
>   	char str[16];
> @@ -369,8 +361,7 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
>   #endif
>   
>   #ifdef CONFIG_INTEGRITY
> -static int do_bootm_integrity(int flag, int argc, char *const argv[],
> -			      struct bootm_headers *images)
> +static int do_bootm_integrity(int flag, struct bootm_headers *images)
>   {
>   	void (*entry_point)(void);
>   
> @@ -402,8 +393,7 @@ static int do_bootm_integrity(int flag, int argc, char *const argv[],
>   #endif
>   
>   #ifdef CONFIG_BOOTM_OPENRTOS
> -static int do_bootm_openrtos(int flag, int argc, char *const argv[],
> -			     struct bootm_headers *images)
> +static int do_bootm_openrtos(int flag, struct bootm_headers *images)
>   {
>   	void (*entry_point)(void);
>   
> @@ -428,8 +418,7 @@ static int do_bootm_openrtos(int flag, int argc, char *const argv[],
>   #endif
>   
>   #ifdef CONFIG_BOOTM_OPTEE
> -static int do_bootm_tee(int flag, int argc, char *const argv[],
> -			struct bootm_headers *images)
> +static int do_bootm_tee(int flag, struct bootm_headers *images)
>   {
>   	int ret;
>   
> @@ -441,13 +430,12 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
>   		return ret;
>   
>   	/* From here we can run the regular linux boot path */
> -	return do_bootm_linux(flag, argc, argv, images);
> +	return do_bootm_linux(flag, images);
>   }
>   #endif
>   
>   #ifdef CONFIG_BOOTM_EFI
> -static int do_bootm_efi(int flag, int argc, char *const argv[],
> -			struct bootm_headers *images)
> +static int do_bootm_efi(int flag, struct bootm_headers *images)
>   {
>   	efi_status_t efi_ret;
>   	void *image_buf;
> @@ -544,7 +532,7 @@ int boot_selected_os(int argc, char *const argv[], int state,
>   {
>   	arch_preboot_os();
>   	board_preboot_os();
> -	boot_fn(state, argc, argv, images);
> +	boot_fn(state, images);
>   
>   	/* Stand-alone may return when 'autostart' is 'no' */
>   	if (images->os.type == IH_TYPE_STANDALONE ||
> diff --git a/include/bootm.h b/include/bootm.h
> index f5229ea90b33..0e4662485006 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -25,16 +25,11 @@ struct cmd_tbl;
>    *  - disabled interrupts.
>    *
>    * @flag: Flags indicating what to do (BOOTM_STATE_...)
> - * @argc: Number of arguments. Note that the arguments are shifted down
> - *	 so that 0 is the first argument not processed by U-Boot, and
> - *	 argc is adjusted accordingly. This avoids confusion as to how
> - *	 many arguments are available for the OS.
>    * @images: Pointers to os/initrd/fdt
>    * Return: 1 on error. On success the OS boots so this function does
>    * not return.
>    */
> -typedef int boot_os_fn(int flag, int argc, char *const argv[],
> -			struct bootm_headers *images);
> +typedef int boot_os_fn(int flag, struct bootm_headers *images);
>   
>   extern boot_os_fn do_bootm_linux;
>   extern boot_os_fn do_bootm_vxworks;
