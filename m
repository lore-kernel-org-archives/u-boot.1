Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ACDC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BCB8397D;
	Thu, 22 Jan 2026 13:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dm1WWkrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C149839DF; Thu, 22 Jan 2026 13:19:25 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECB080077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-790b7b3e594so9251307b3.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 04:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769084360; cv=none;
 d=google.com; s=arc-20240605;
 b=QuNBmb3Od0dwa9+Shb3c6oORPT6zin7RYl9z+825Wu15xWcEtvl05ZnKwn75fU+G/f
 D1y0VqpQW3AWoXsobUZYosaSc/JMb9VIKDgsCY6dUXKrazvi7j3S2d9hVr8q0lpuqsrJ
 aJ1shozDICzD7gmxpKODgLiqf+kUkjbuQuI+rq4d+toZS/8q2qJxv/eOjwbwrhe1GeOQ
 IcRzYH/uid+w80fFaoCenEokzbmNuIhbuv1nJgBEHfU+3xWKAOn+7/pE/QYiDrk8B8xZ
 FWCUpskkHL9TB/o8x6MuKw00N+BKIYNvwmFAFqPOhTXp0O4Bsdl9Gk9St3hBxHNRwg2A
 G3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vAmfCrVknJdLf/TgQJ59VdcuAYPpMDIx6hB+GjhzWqU=;
 fh=l55blx1uJNrEHBfEjQi7HmAVq2q5ZQ+HEUVE2r0uaUA=;
 b=BmBZ5bzOyWcLb7drV3t3NgAD77Pgt20UxEN27tfz8/SDpGK4GDGAqw/FpIApthiEnb
 ypGCayF9nueA+j2Fgr2mjusDNtNUvy7mlzZGJRhG4AlxYjVzEFbW33ThxYCyCwauWUAG
 aI0AgV7wX7Y843iPt2OqnMJ6gqZqM2E1L7QCDRkUodwFhFqrJntxVJT7urNxuCJtzuIw
 bKzIUoVLNA7a8sR3DKFiOSZogB9V8khtPc9FCPVX0zdawmOzJTve9SCCjwddoHDL/IDQ
 9XpA5n7qZqBixl1SRitEhH1MNffY6PDs6nnz6hXUo9Jjxd9Kvc49D1uPRZwCphQxDSRR
 cp5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769084360; x=1769689160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAmfCrVknJdLf/TgQJ59VdcuAYPpMDIx6hB+GjhzWqU=;
 b=dm1WWkrC3RJdYSASAuw/VQut7NVe5osx3tzvZmkaIK65+fHFuelFgwsA5CmpBOFk5b
 FLkAvgaLmjvgQTFSr6uBndN4gKzr+RlU5o1BGtHHmvg5oj/dGMlrS3N/tiuqHVXe0cY3
 /3oGe5jiKrvI6u4aMF+7LkLv2NRAdHJXwETzL26pgdPy3pV/+HYZ2JLLUUd8i0GquTo7
 9u1JrVlbk/4R2VqMVciQiOfLmL9qRhh/GLr+QLxMmyKOAxQKxD+sTmvwSwx2YitmaOJs
 Y4qNghrNI9UYSURzhq5QkUxFF4SB6Q70MNZnqUgTH51vxb0EIhoHMRCuc5Q/FwdQi9B7
 WVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769084360; x=1769689160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAmfCrVknJdLf/TgQJ59VdcuAYPpMDIx6hB+GjhzWqU=;
 b=D8CnIBDtYV8iVu/lh1R0BK7WimsmGhGWStxvKViSu9dEOqJoM5zWm646n7sGaoobSX
 SU3lxWLQienfTh9M/sENbU7BIzrZrNM2wi93c2xtB4qyYREuX5xo3zP/uSZf9PIST4SA
 v0fSf97ssy/IQYk02tUYDNetkTQJ0mkgdOS2kFrIEpSCFY3Lsc4KdezW2351f/gKcraF
 wYqw3MIaSkDK4xuvjCKxiz1xb4+kVDECQbwaJUMuamX4n9W6OyUIFrkBPtLJU4giua8P
 2I/iddrNhgY8IFDqrLyds3JdKQNT4/70kuOwHgUT78eYPv04WUSJhjY2B3AQHH85Xamw
 vChQ==
X-Gm-Message-State: AOJu0YzWqhqFJdzwJh0Vw7m+xk/WfGyl48/bTAjzPtAN7ULRGfau1IFH
 46jnh3J0YVD8wkBmITHZdjk7lKvQ7VYj9H0SRzzcIxd4an6ncJj7+ybQDLWE860lELzryeFJOIr
 hKP5peqZV/yjGPCoTVowlQu+qm6kZsMt4a/IfTfdrkw==
X-Gm-Gg: AZuq6aK591jOuq20u+tNfInzZ7PeNlqhj0H1vvuCFzgG2+ZtDt5huBKvK9KCpQj/Gkg
 TXGs9oKe7NeE4FnH0lYxcliHaTbX3ueKQE2CdSZOF6jGfGtJftoFOoCMM8ML8Tom+3xhnia4X67
 TJ5rTJiz29VbbZJLLFrm6axwOpMNzW60qkbpFklHERjC62LtQIqe0LuQ2kri3zYpK/Emtr5nfdL
 Lkwi0qOwWfijCOKO4ISC3OxNN80FjgRlAxG73bcO0fYGKTD6X/gNcC8laEvipcywakTLoLCEY8V
 a21I6+OF8Yirr+JFfTG4dJrxrSRchJ3CddjLPHqZOcByA8x96M8S2LEQx7UBalK32xI4BlmiFIt
 oR6/LPoH8ib9dpAmEaTKPn2AA9gTKsYYyNXfot81drznX26P6vw9hXQvFCmOsmxjgixoyFIV7Jm
 f+Xbt1D93tE55a44eRmzqTAlVJruKykwdFyUNIXXqAtjNbVTo7Q2+kcKCbkco8lPvozLGUCqkJC
 nTM0TSnx23kHjbpY8qw0+lirWzxNubBoVhXFeTKjRLYhubyQNbppTSznRym7xnPv9deoWHcoIbt
 0DAhYHcWmULhIgG1BIK1BoYmLwaZgxKR
X-Received: by 2002:a05:690c:e3ce:b0:794:18b4:af0 with SMTP id
 00721157ae682-79418b424c7mr52955697b3.0.1769084359499; Thu, 22 Jan 2026
 04:19:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
In-Reply-To: <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 22 Jan 2026 14:18:43 +0200
X-Gm-Features: AZwV_QhGT5y05OVo8rjhOC5jG7cXcNlmbKFQgfuw4RLZl7lUMhV-xUUpqs3Brmo
Message-ID: <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

Hi Michal,

[...]

>
>  config EFI_RT_VOLATILE_STORE
>         bool "Allow variable runtime services in volatile storage (e.g RAM)"
> -       depends on EFI_VARIABLE_FILE_STORE
> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE

Will this work on nands as well? They got a  much shrter lifetime that
spi flashes.

>         help
>           When EFI variables are stored on file we don't allow SetVariableRT,
>           since the OS doesn't know how to write that file. At the same time

I am not sure we need to allow this for now. At least not until we've
talked to the efitool maintainers and make sure they will accept
another 'special' case.

The problem with allowing this is that if people enable it, boot a
linux and do a setvariable, it will return a success. But none of the
variables will be preserved after a reboot unless someone manually
updates the serial flash contents. In theory, we can preserve the
driver  model and the spi drivers in EFI runtime services and allow
'proper' setvariable at runtime.
However, I think this is not very useful. Having an unprotected to
store authenticated EFI variables, is dangerous. Someone can erase the
SPI flash and efectively disable secure boot. Due to that, I prefer
the current file based approach for EFI variables -- which doesn't
store/restore authenticated EFI variables (and which this patch
implements). The obvious downside is that enable setvariable at
runtime is tricky once again....

[...]

> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index be670a8e7c25..feab212b245b 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = EFI_SUCCESS;
>
>         /*
> -        * Write non-volatile EFI variables to file
> +        * Write non-volatile EFI variables to file or SPI Flash
>          * TODO: check if a value change has occured to avoid superfluous writes
>          */
>         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)

Do we need the ifdefery here? efi_variable.o is basically compiled
whenever we have the variables managed by the non-secure world and
this function will exist either with a file back storage or a SPI
flash
>                 efi_var_write();
>  #else
>                 return EFI_NOT_READY;
> @@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)

ditto

>         ret = efi_var_read();
>         if (ret != EFI_SUCCESS)
>                 return ret;
> --
> 2.43.0
>

Cheers
/Ilias
