Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B10C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F908812BB;
	Mon, 27 Jan 2025 17:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CNJ7INZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C558141D; Mon, 27 Jan 2025 17:36:44 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291A381292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3f1bdc60-dccd-11ef-9401-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3f1bdc60-dccd-11ef-9401-005056994fde;
 Mon, 27 Jan 2025 17:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=uVUeR37vGhmVVhZQSIK5TgLaWRRxLNblbiaxX1kYuNY=;
 b=CNJ7INZxzIeH3ADebQERf8/9jZ3eRgcyKf/AQW2y7JROacNetLq3XtsgAOUfyTBNqNtZfkKQCltKj
 durrBnEd9aTz5DjbKSiqijgoOx6I7zAXkkeR3LLZSevupkVWAT25eItnO75WsH0Ulq8hi6GUjiO2lt
 8wQer92nblwt+My1UXmZB2uLtoGYuZtYAR3SJNL6QFdYYHbAJhIv0Jd/X5wj3VeGJG6hngzkNEmRP5
 iUF0df3jTN0O87sQVjPaKeqh0EkndcNiOH6ub8IMBeQ0FEce8qbS7r1gFMdfc3JeRph1c8yiLggZeq
 IJKaZrvE/aG8sLErAyQnOMyR8bEJIyA==
X-KPN-MID: 33|U0wymo+QS1I5KcAj4G+T0hvBhJ0mhFNsMR6aJRQr6XOmCfCfScxydSbcQAfG3DA
 Q+pIZePWJMj0OijkZ7clWDZpO+iJKLqbKhkE7602YWWs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|mXLpX49GKpPCxwh2HIiRVbGPMOfuvPW4puaWuW4A/3VvSLMcBcW2FQo+6eKW4m7
 Nev7NNhNYaaUm7/VWbY5l3Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e2ec6a93-dccc-11ef-88d8-00505699772e;
 Mon, 27 Jan 2025 17:36:41 +0100 (CET)
Date: Mon, 27 Jan 2025 17:36:40 +0100
Message-Id: <87sep4i57r.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sam Day <me@samcday.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, me@samcday.com
In-Reply-To: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
 (message from Sam Day on Mon, 27 Jan 2025 14:48:55 +0000)
Subject: Re: [PATCH] mach-snapdragon: handle platforms without PSCI support
References: <20250127-qcom-handle-absent-psci-v1-1-e762f2db938c@samcday.com>
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

> Date: Mon, 27 Jan 2025 14:48:55 +0000
> From: Sam Day <me@samcday.com>

Hi Sam,

> Most MSM8916 devices shipped without PSCI support. The history is quite
> nuanced (a good overview can be found in [1]), but the end result is
> that the upstream DTs for this SoC pretend that PSCI exists, and it's
> expected that the bootloader handles the case where it doesn't. This is
> codified by the de-facto bootloader for MSM8916 devices, lk2nd [2].
> 
> So we handle it here by deleting the /psci node if we detect the absence
> of PSCI. We need to do this early to ensure sysreset works correctly,
> since the PSCI firmware driver is PRE_RELOC and binds the PSCI sysreset
> driver.

But deleting the /psci node isn't enough is it?  At least on systems
with more than a single core the OS will need a way to spin up the
additonal cores.  So you'll need to modify the CPU nodes as well and
change the "enable-method" property to "spin-table" and add the
necessary infrastructure for that.

> Additionally, show_psci_version is updated to check that PSCI exists.
> Currently this banner outputs "PSCI: 65535.65535" on devices without
> PSCI support, which isn't very useful :)
> 
> [1]: https://github.com/msm8916-mainline/linux/issues/388
> [2]: https://github.com/msm8916-mainline/lk2nd/blob/8183ea2/lk2nd/smp/spin-table/spin-table.c#L237
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 43 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index e87551784b8d7afb4186533d43b8bddacba9faec..75b9cf1a8a1b3383665eb2d4e6725efe59718de0 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -162,11 +162,42 @@ static void show_psci_version(void)
>  
>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>  
> +	/* Some older SoCs like MSM8916 don't always support PSCI */
> +	if ((int)res.a0 == PSCI_RET_NOT_SUPPORTED)
> +		return;
> +
>  	debug("PSCI:  v%ld.%ld\n",
>  	      PSCI_VERSION_MAJOR(res.a0),
>  	      PSCI_VERSION_MINOR(res.a0));
>  }
>  
> +/**
> + * Most MSM8916 devices in the wild shipped without PSCI support, but the
> + * upstream DTs pretend that PSCI exists. If that situation is detected here,
> + * the /psci node is deleted. This is done very early to ensure the PSCI
> + * firmware driver doesn't bind (which then binds a sysreset driver that won't
> + * work).
> + */
> +static void qcom_psci_fixup(void *fdt)
> +{
> +	int offset, ret;
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)
> +		return;
> +
> +	offset = fdt_path_offset(fdt, "/psci");
> +	if (offset < 0)
> +		return;
> +
> +	debug("Found /psci DT node on device with no PSCI. Deleting.\n");
> +	ret = fdt_del_node(fdt, offset);
> +	if (ret)
> +		log_err("Failed to delete /psci node: %d\n", ret);
> +}
> +
>  /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>   * or for supporting quirky devices where it's easier to leave the downstream DT in place
>   * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> @@ -212,12 +243,16 @@ int board_fdt_blob_setup(void **fdtp)
>  
>  	if (internal_valid) {
>  		debug("Using built in FDT\n");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +	} else {
> +		debug("Using external FDT\n");
> +		*fdtp = external_fdt;
> +		ret = 0;
>  	}
>  
> -	debug("Using external FDT\n");
> -	*fdtp = external_fdt;
> -	return 0;
> +	qcom_psci_fixup(*fdtp);
> +
> +	return ret;
>  }
>  
>  void reset_cpu(void)
> 
> ---
> base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
> change-id: 20250127-qcom-handle-absent-psci-6e8e8af7bcd7
> prerequisite-change-id: 20250120-qcom-parse-memory-updates-96ffe248cdf1:v3
> prerequisite-patch-id: 65448b5a93120d2117c1361035afc9bd911d005f
> 
> Best regards,
> -- 
> Sam Day <me@samcday.com>
> 
> 
> 
