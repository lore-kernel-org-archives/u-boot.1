Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B84CD0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C18893B2;
	Fri, 11 Oct 2024 19:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="d6d7bsqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B87893B4; Fri, 11 Oct 2024 19:53:30 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1764893AD
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b6ec43d2-87f9-11ef-9dda-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b6ec43d2-87f9-11ef-9dda-00505699b430;
 Fri, 11 Oct 2024 19:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=2f58V7N6wVy6S331qbMAmr8qYiDiVnAlUDE/VJ6fbzo=;
 b=d6d7bsqJfKi4EHLWfEfejEK5P4uMx5TQucZtM6OZ1g3Y3luPaTb+m7CHQx9NIOUT+pH37BEpBGr7J
 O6SxgWCGYb3twib/+YGIEeOoWdU4UW65Gu7ruY6wVBEqwiyp+xfTTkzy1LBSF1QPTp6UeRvvthn8bC
 qxaQ4DQa7Gscav13Qz8tp5Dc6gsRmhVxkgGJ71HP8M9YG34cLlC6YB5qK7zKC4spxa4x+3msaOlBPb
 /EAkzeuXFgS2tmCv29uEweDdRjaSfJVmZoowFI85BHxJ/+NSLjF/T+V2OKANTlYmLrx/61Rra/1aVW
 pipqSS594KBY9Z+Y5VUWESlzOxGDQUg==
X-KPN-MID: 33|aSXLCKPp8ck5O77jbfOz5uiYLDPVy3zSZfdXY7YwISu2eaWPvH136UpUbBAOUza
 2gB/ARDLVlztzVKIE13fAzHgLjasCVogg3XqhI/7QE0o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iqpE3Ry7OE0FYKZ2wMQ9pr/8lKAgAUYWNetSbzvm1KL7dEBY6VREWs5tICA86KW
 bs2ePKlBKY5EUCUSwRYA06A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b7e9094d-87f9-11ef-b648-00505699b758;
 Fri, 11 Oct 2024 19:53:28 +0200 (CEST)
Date: Fri, 11 Oct 2024 19:53:27 +0200
Message-Id: <875xpyle5k.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, vincent.stehle@arm.com,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20241011173341.24330-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Fri, 11 Oct 2024 19:33:40 +0200)
Subject: Re: [PATCH 1/1] efi_loader: provide variable BootOptionSupport
References: <20241011173341.24330-1-heinrich.schuchardt@canonical.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Fri, 11 Oct 2024 19:33:40 +0200

Hi Heinrich,

> The UEFI variable BootOptionSupport is required by the UEFI specification
> [1]. It reports if specific types of boot options are honored.
> 
> We don't support any of these extras. So we should set the value 0.

It also says:

  "If the global variable is not present, then an installer or
   application must act as if a value of 0 was returned."

So until we support any of those extras, we don't have to provide that
variable.

> [1] 3.1.4 Boot Manager Capabilities, UEFI Specification 2.10 Errata A,
> 
> Cc: Vincent Stehlé <vincent.stehle@arm.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index a610e032d2f..05d035f4eb5 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -179,6 +179,22 @@ static efi_status_t efi_init_os_indications(void)
>  				    &os_indications_supported, false);
>  }
>  
> +/**
> + * efi_init_boot_options_support() - indicate supported boot option types
> + */
> +static efi_status_t efi_init_boot_options_support(void)
> +{
> +	u32 boot_options_support = 0;
> +
> +	return efi_set_variable_int(u"BootOptionSupport",
> +				    &efi_global_variable_guid,
> +				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +				    EFI_VARIABLE_RUNTIME_ACCESS |
> +				    EFI_VARIABLE_READ_ONLY,
> +				    sizeof(boot_options_support),
> +				    &boot_options_support, false);
> +}
> +
>  /**
>   * efi_init_early() - handle initialization at early stage
>   *
> @@ -261,6 +277,13 @@ efi_status_t efi_init_obj_list(void)
>  	if (ret != EFI_SUCCESS)
>  		goto out;
>  
> +	/* Indicate supported boot option types */
> +	if (IS_ENABLED(CONFIG_EFI_BOOTMGR)) {
> +		ret = efi_init_boot_options_support();
> +		if (ret != EFI_SUCCESS)
> +			goto out;
> +	}
> +
>  	/* Initialize system table */
>  	ret = efi_initialize_system_table();
>  	if (ret != EFI_SUCCESS)
> -- 
> 2.45.2
> 
> 
