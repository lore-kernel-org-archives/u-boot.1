Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614ADF588C6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EE884198;
	Mon, 20 Apr 2026 15:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="umDXoarn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F23E84394; Mon, 20 Apr 2026 15:45:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150DD839D9
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 61B2540D52;
 Mon, 20 Apr 2026 13:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7738EC19425;
 Mon, 20 Apr 2026 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776692719;
 bh=YQQyoG6IgODNgnviNFcqI40vWAX6lXsK23iK132zC5U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=umDXoarnDr+XDhPuXzc0DGTAAx+pLIZJhUXTm+9tSEhQs5+7UjPscqCWTn9Xd4t+Y
 JOIFvkNx6phBNEavv1+3dBc9Ihr5t2HdDal9YLIiQqXnur2DKxlhnYTck39YBvZEQC
 6Vq8PPD5mMMDabp3Cuv/dUHy1x+IHL1fsOYtrlMeO8b0ZER4c0Szq1g3PgJGv4Pe70
 y2FOdXQWleTsuhub/l9XsHeeegspOzKzoz+eNNaFFcs4mGjtqjbWa3pSFakcGi5rce
 T+R0aCpIp7+92z/dYjLNluYNJf0qAC2V5X7y66pkWyh721icFC+dRC2ci9yMtlQp0b
 2K/Sg+NE1JdbA==
Date: Mon, 20 Apr 2026 19:15:13 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sughosh.ganu@arm.com,
 gchan9527@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] mach-snapdragon: Add KVM hypervisor support
Message-ID: <aeYt6cz5AVXFc5m3@sumit-xelite>
References: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
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

On Sun, Apr 19, 2026 at 11:08:29PM +0530, Aswin Murugan wrote:
> Enable Linux KVM virtualization on Snapdragon SoCs.
> 
> Introduce CONFIG_QCOM_KVM_SUPPORT to select KVM or Gunyah
> hypervisor modes at build time.
> 
> qcom-priv.h:
>  - Add TrustZone SMC interface definitions and parameter IDs
>  - Define hypervisor boot types (GUNYAH=0, KVM=1)
>  - Add TCR_EL2 bit field definitions for memory config
> 
> board.c:
>  - Add qcom_configure_kvm_hypervisor() with EL-aware logic
>  - EL2: Perform direct SMC call for hypervisor setup
>  - EL1: Save context, disable caches, run SMC, restore state,
>    reconfigure TCR_EL2, re-enable caches

Please don't switch EL1 -> EL2 in the middle of U-Boot execution which
just adds these expensive MMU operations during boot.

Rather than that just follow the upstream edk2 example to switch from
EL1 -> EL2 on the first platform specific init code code sequence. Have
a look at this reference [1]. Surely you can keep the switch under a
config option. This will make U-Boot to properly execute either in EL1
or EL2.

[1] https://github.com/tianocore/edk2-platforms/blob/master/Silicon/Qualcomm/KodiakPkg/Library/KodiakLib/KodiakHelper.S

-Sumit

>  - Add qcom_configure_gunyah_hypervisor() for standard flow
>  - Add SCM service availability checks
> 
> Default mode remains Gunyah. Enable CONFIG_QCOM_KVM_SUPPORT to
> select KVM for Linux.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig     |   7 ++
>  arch/arm/mach-snapdragon/board.c     | 154 +++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  31 ++++++
>  3 files changed, 192 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..2e5676945ca 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
>  
> +config QCOM_KVM_SUPPORT
> +	bool "Enable KVM support for Qualcomm platforms"
> +	depends on ARM64
> +	help
> +	  This configures the hypervisor interface during boot to support
> +	  KVM virtualization instead of the default Gunyah hypervisor.
> +
>  endif
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..2926dd8ccc0 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
>  {
>  }
>  
> +/**
> + * qcom_configure_kvm_hypervisor() - Configure hypervisor for KVM guest mode
> + *
> + * Configures the hypervisor for KVM operation:
> + * - EL2 path: Direct SMC call
> + * - EL1 path: Save context, disable caches, SMC call, restore context
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_configure_kvm_hypervisor(void)
> +{
> +	struct arm_smccc_res res;
> +	u64 current_el;
> +
> +	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
> +	current_el = (current_el >> 2) & 0x3;
> +
> +	log_info("Configuring hypervisor for KVM (EL%llu)\n", current_el);
> +
> +	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
> +		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != 0)
> +		log_debug("KVM milestone service not available (0x%lx)\n", res.a0);
> +
> +	if (current_el == 2) {
> +		log_debug("At EL2\n");
> +
> +		arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +			      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +			      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
> +			      0, 0, 0, &res);
> +
> +		if (res.a0 != 0) {
> +			log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +			return -EIO;
> +		}
> +
> +		log_info("KVM hypervisor configured\n");
> +		return 0;
> +	}
> +
> +	log_debug("At EL1, saving register context\n");
> +
> +	u64 ttbr0_el1, tcr_el1, tcr_el2, mair_el1;
> +	u64 t0sz, phys_addr_size;
> +
> +	/* Save EL1 system register context */
> +	asm volatile("mrs %0, ttbr0_el1" : "=r" (ttbr0_el1));
> +	asm volatile("mrs %0, tcr_el1" : "=r" (tcr_el1));
> +	asm volatile("mrs %0, mair_el1" : "=r" (mair_el1));
> +
> +	t0sz = tcr_el1 & TCR_T0SZ_MASK;
> +	phys_addr_size = tcr_el1 & TCR_PS_MASK;
> +
> +	log_debug("Saved context: TTBR0=0x%llx TCR=0x%llx MAIR=0x%llx\n",
> +		  ttbr0_el1, tcr_el1, mair_el1);
> +
> +	icache_disable();
> +	dcache_disable();
> +
> +	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +		      0, 0, QCOM_HYP_BOOT_TYPE_KVM,
> +		      0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +		icache_enable();
> +		dcache_enable();
> +		return -EIO;
> +	}
> +
> +	asm volatile("mrs %0, CurrentEL" : "=r" (current_el));
> +	current_el = (current_el >> 2) & 0x3;
> +
> +	asm volatile("msr ttbr0_el1, %0" : : "r" (ttbr0_el1));
> +	asm volatile("isb");
> +
> +	if (current_el != 2) {
> +		log_debug("No EL2 transition, skipping TCR_EL2 config\n");
> +		icache_enable();
> +		dcache_enable();
> +		log_warning("KVM hypervisor configuration failed\n");
> +		return 0;
> +	}
> +
> +	/* Read current TCR_EL2 and reconfigure it */
> +	asm volatile("mrs %0, tcr_el2" : "=r" (tcr_el2));
> +
> +	tcr_el2 &= ~(TCR_T0SZ_MASK | (0x7UL << 16));
> +	tcr_el2 |= t0sz | (phys_addr_size >> TCR_PS_SHIFT);
> +
> +	tcr_el2 &= ~TCR_SH_ORGN_IRGN_MASK;
> +	tcr_el2 |= TCR_SH_INNER_SHAREABLE |
> +		   TCR_ORGN_WRITE_BACK_ALLOC |
> +		   TCR_IRGN_WRITE_BACK_ALLOC;
> +
> +	asm volatile("msr tcr_el2, %0" : : "r" (tcr_el2));
> +	asm volatile("msr mair_el1, %0" : : "r" (mair_el1));
> +	asm volatile("isb");
> +
> +	icache_enable();
> +	dcache_enable();
> +
> +	log_info("KVM hypervisor configured\n");
> +	return 0;
> +}
> +
> +/**
> + * qcom_configure_gunyah_hypervisor() - Configure hypervisor for Gunyah mode
> + *
> + * Configures the hypervisor for standard Gunyah operation.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_configure_gunyah_hypervisor(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	log_info("Configuring hypervisor for Gunyah mode\n");
> +
> +	arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
> +		      TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_debug("Hypervisor milestone service not available (0x%lx)\n", res.a0);
> +		return 0;
> +	}
> +
> +	arm_smccc_smc(TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +		      TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID,
> +		      0, 0, QCOM_HYP_BOOT_TYPE_GUNYAH,
> +		      0, 0, 0, &res);
> +
> +	if (res.a0 != 0) {
> +		log_err("Hypervisor configuration failed: 0x%lx\n", res.a0);
> +		return -EIO;
> +	}
> +
> +	log_info("Gunyah hypervisor configured\n");
> +	return 0;
> +}
> +
>  #define KERNEL_COMP_SIZE	SZ_64M
> arch/arm/mach-snapdragon/Kconfig #ifdef CONFIG_FASTBOOT_BUF_SIZE
>  #define FASTBOOT_BUF_SIZE CONFIG_FASTBOOT_BUF_SIZE
> @@ -570,6 +718,12 @@ int board_late_init(void)
>  	qcom_late_init();
>  
>  	qcom_show_boot_source();
> +
> +	if (IS_ENABLED(CONFIG_QCOM_KVM_SUPPORT))
> +		qcom_configure_kvm_hypervisor();
> +	else
> +		qcom_configure_gunyah_hypervisor();
> +
>  	/* Configure the dfu_string for capsule updates */
>  	qcom_configure_capsule_updates();
>  
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bb..a5d9dec6aa7 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -17,6 +17,37 @@ enum qcom_boot_source {
>  
>  extern enum qcom_boot_source qcom_boot_source;
>  
> +/* TrustZone SMC definitions */
> +#define TZ_SYSCALL_CREATE_SMC_ID(o, s, f) \
> +	((u32)((((o) & 0x3f) << 24) | (((s) & 0xff) << 8) | ((f) & 0xff)))
> +
> +#define TZ_OWNER_SIP				2
> +#define TZ_SVC_BOOT				1
> +#define TZ_SVC_INFO				6
> +#define TZ_BOOT_CMD_KVM_MILESTONE		0x21
> +#define TZ_INFO_IS_SVC_AVAILABLE_CMD		0x01
> +
> +#define TZ_CONFIGURE_MILESTONE_SERVICE_ID \
> +	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_BOOT, TZ_BOOT_CMD_KVM_MILESTONE)
> +#define TZ_CONFIGURE_MILESTONE_SERVICE_PARAM_ID		0x23
> +
> +#define TZ_INFO_IS_SVC_AVAILABLE_ID \
> +	TZ_SYSCALL_CREATE_SMC_ID(TZ_OWNER_SIP, TZ_SVC_INFO, TZ_INFO_IS_SVC_AVAILABLE_CMD)
> +#define TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID		0x1
> +
> +/* Hypervisor boot types */
> +#define QCOM_HYP_BOOT_TYPE_GUNYAH		0
> +#define QCOM_HYP_BOOT_TYPE_KVM			1
> +
> +/* TCR_EL2 bit field definitions */
> +#define TCR_T0SZ_MASK				0x1FUL
> +#define TCR_PS_MASK				(0x7UL << 32)
> +#define TCR_PS_SHIFT				16
> +#define TCR_SH_ORGN_IRGN_MASK			0x3F00UL
> +#define TCR_SH_INNER_SHAREABLE			(3UL << 12)
> +#define TCR_ORGN_WRITE_BACK_ALLOC		BIT(10)
> +#define TCR_IRGN_WRITE_BACK_ALLOC		BIT(8)
> +
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>  void qcom_configure_capsule_updates(void);
>  #else
> -- 
> 2.34.1
> 
