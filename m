Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9E6C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7504487C2D;
	Tue, 20 Feb 2024 06:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QDTEfvZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A278D87C2D; Tue, 20 Feb 2024 06:41:42 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7C187EAD
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ce603b9051so1967901241.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708407685; x=1709012485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/A4g2BvtQz7nA3iXawAz0skWyhRi91RDACxSrA6geM=;
 b=QDTEfvZayC+ee8B30Sr+rCBR/nqlhLLEg8ZB9T1gzIwWAO+04STkcvpCes4lUwPLk2
 /vvwcM88bbINtQ279R/1qG9G5o4LJTIAfXqMq67X/yw9VjjvvbEZNJ1qE8NIIF9c2nK2
 LUbhf3mHZXGbu07MNmMP2dE0e1pWQdH8OV5H8W4pSVNL7ER5dVaEl2N9AZ7zTgBdKS9T
 ecJwefVRdB+tWTDyLZtIg7wrByRx1GRykL1pYnhhUc+6HgahGLgx6ZqZWRH5Wg6Yk89A
 GrflfHG4WpgURIMgAUGm6WeCBrXNNghGPzJT8hQnStT5ogKD0YzHS1aoG79NUm285UGP
 cHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708407685; x=1709012485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/A4g2BvtQz7nA3iXawAz0skWyhRi91RDACxSrA6geM=;
 b=PXhTtZMS2TOfHLpR3A38DB8CDAuEV3rZBtp31jKlH2bSblyoKg+Kjg/XGmVC2n2Btv
 3JApb6ugHJO9sudPkIZ146+tdtVtdOi7GXS1JQzGYw3XP4v371wxehH9wO2rYAcfE+CB
 3uTCLGp53h1JwakAcsaBhVmEqOjZUlw7OA/r3PJOEEcbVoSbVAWukfywseByPynrMGVU
 RvXrXo3eqJBNnZjVmfrTj40lPKeDJ3T+N/D5ZKStErReFc9qQarN894nCHAl+YOt5xBj
 h4uefeav17IlvkPTS2JFHUBkasS8XOjTkBJV0yqjSmV4x8DTdaC5uS2xuPlUWnreJhjZ
 iRsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxsjq9JOeWt/Ehw7UaDpbqkjWVs81MeBgXnBEdY91QXVOmEjYVLbhETCA4N9eBXQVulkyJ6kGRG4e33Faj9sEn6qPEtw==
X-Gm-Message-State: AOJu0YxekXWkzbehFO07SQ08xeszVJPzDmnoaGJhsj3I2MQJIt2s2sKf
 1/lRcgU+04tkOWIdK8DfPuG+gN4YGwaL8rllBXG8E1StCGZ3i6Ip4dh+uY76i8drvgARz4GneuK
 05uwLTmmJCH2wEHHi6ZS0T2DoLGWKSntpT0iHFA==
X-Google-Smtp-Source: AGHT+IGSBX53PTUku/XFZ87V2ErZYE2Abcp/uDzdj45t09QHi7Qf8b0tWnmRF8BlW7xGxEybKm6+EK5e659gmrubeO8=
X-Received: by 2002:a05:6102:903:b0:470:4712:58c with SMTP id
 x3-20020a056102090300b004704712058cmr4048993vsh.4.1708407685296; Mon, 19 Feb
 2024 21:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-1-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-1-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:11:14 +0530
Message-ID: <CAFA6WYP5n8v+i0QuTy8twjyJOTAXV-8PfSpfStY7fC_=Zf42=g@mail.gmail.com>
Subject: Re: [PATCH v4 01/39] arm: init: export prev_bl_fdt_addr
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> When booting U-Boot on board with a locked down first-stage bootloader,
> we emulate the Linux boot header. By passing the U-Boot FDT through this
> first-stage bootloader and retrieving it afterwards we can pre-populate
> the memory nodes and other info like the KASLR address.
>
> Add a function to export the FDT addr so that boards can use it over the
> built-in FDT.
>
> Don't check is_addr_accessible() here because we might not yet have a
> valid mem_map if it's going to be populated from the FDT, let the board
> do their own validation instead.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/lib/save_prev_bl_data.c |  5 +++++
>  include/init.h                   | 11 +++++++++++
>  2 files changed, 16 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
> index f7b23faf0d66..b286bac9bf00 100644
> --- a/arch/arm/lib/save_prev_bl_data.c
> +++ b/arch/arm/lib/save_prev_bl_data.c
> @@ -45,6 +45,11 @@ bool is_addr_accessible(phys_addr_t addr)
>         return false;
>  }
>
> +phys_addr_t get_prev_bl_fdt_addr(void)
> +{
> +       return reg0;
> +}
> +
>  int save_prev_bl_data(void)
>  {
>         struct fdt_header *fdt_blob;
> diff --git a/include/init.h b/include/init.h
> index 9a1951d10a01..630d86729c4e 100644
> --- a/include/init.h
> +++ b/include/init.h
> @@ -168,6 +168,17 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
>   * Return: 0 if ok; -ENODATA on error
>   */
>  int save_prev_bl_data(void);
> +
> +/**
> + * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
> + * of the FDT passed by the previous bootloader.
> + *
> + * Return: the address of the FDT passed by the previous bootloader
> + * or 0 if not found.
> + */
> +phys_addr_t get_prev_bl_fdt_addr(void);
> +#else
> +#define get_prev_bl_fdt_addr() 0LLU
>  #endif
>
>  /**
>
> --
> 2.43.1
>
