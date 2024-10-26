Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FE5D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B4388EC0;
	Sat, 26 Oct 2024 09:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OrxXA3k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7387B88F71; Sat, 26 Oct 2024 09:24:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728DA87F19
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso364554866b.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729927488; x=1730532288; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rjRYXNw5+Y/Ryv3EuiXopbR4KoGeLbggI3cs2wuXFN8=;
 b=OrxXA3k9ImoDOdWQe3lMFC1RY4oObbaogVTDahVwI6MRHoW3Q3prJzRzNP840sk/Bk
 +AHc+B1O9xYoeNqlSr7XMCHczL3qrh6ysfxvf+lvSkJbTxqFXlq0/TAthK36iT+ZNvxc
 5rLfNYESUJIhzaphCPCFNRvJ6INUafB0aV6N6a53+NwatU14MMADj39LUZ02aXYJB+a4
 UdJYHbpEC9bGsdaxcHFAG1S2NKaqes6671SOam3bXq3gNw7XhvcVAYbuEBXoY5pd7TBJ
 7m/lDJt8mblhYj3wzGPAOOTwQj+Bo+R9wv5aghJGryxd9taADR7ULzd0F/8bGWJAv/sF
 EvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729927488; x=1730532288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjRYXNw5+Y/Ryv3EuiXopbR4KoGeLbggI3cs2wuXFN8=;
 b=XnXuRvd6Gx+F8DWNzOrvIUz9xWCI6nPIxLt22Ik3CwlohVePbH0MdHoqKjKuJ1fY0a
 fxLQvcghE16cyz8qI9hqxBwF4QW0DBeDFn/s7VTvRD/sR7p3XjNtcTA4yNA86voyfa/B
 79aP3DR+rCwf7xqyPMfCI0J35Iyg1+PmT5VybAiK7ZI1T5wS9oS5Tcg1/Utx4y+jvV36
 c/GGmNkfviHkTkHg3K1TIp5+6Ny1wumgqUI5MAaK0HrymbX6dIrUae2pw/cHrGjNMooB
 trV/UttXO00YEvoArdl7UwR+GoXOz98THRN22xNCLoHLeZTcykLu0TIHX/kBHxSnLTym
 sYHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiSYVcuy/HbVv+7uuNGb50I429m751U6xMiPTjdMuKZUc2/ZYOtrGrFPrX4l81HsZAG61N+bs=@lists.denx.de
X-Gm-Message-State: AOJu0YxwvPJ/hOnvIqkJYUJ5wXUY8Ozj0leZauTacf9pJrvW8/Rcc4BL
 NwR2ew+hsRIQ6HFuVqs1ya9w9pDDvrzeFzgXu2ErNKX5/xKwXRpQxFkM0Cc/yMw=
X-Google-Smtp-Source: AGHT+IG7ph8AwZq3Y4nADf8WkZ2zFhvgY5+arGSjS5zbRNt84hgcqLBDk94PJphwHvuxkWwKqeKesg==
X-Received: by 2002:a17:907:3f02:b0:a9a:e0b8:5b7c with SMTP id
 a640c23a62f3a-a9de5c91d25mr152909766b.7.1729927487789; 
 Sat, 26 Oct 2024 00:24:47 -0700 (PDT)
Received: from hades (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b343d268asm144796366b.184.2024.10.26.00.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:24:46 -0700 (PDT)
Date: Sat, 26 Oct 2024 10:24:42 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd/eficonfig: capitalize 'enter description'
Message-ID: <ZxyZOk35IJDGUKM8@hades>
References: <20241025211505.361296-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025211505.361296-1-heinrich.schuchardt@canonical.com>
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

On Fri, Oct 25, 2024 at 11:15:05PM +0200, Heinrich Schuchardt wrote:
> To conform with other messages capitalize the first letter:
> %s/enter description/Enter description/g
> 
> Adjust the unit tests accordingly.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c                                | 2 +-
>  test/py/tests/test_eficonfig/test_eficonfig.py | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index bea09e4ecc7..029180250f0 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -963,7 +963,7 @@ static efi_status_t eficonfig_boot_add_enter_description(void *data)
>  	return handle_user_input(bo->description, EFICONFIG_DESCRIPTION_MAX, 22,
>  				 "\n  ** Edit Description **\n"
>  				 "\n"
> -				 "  enter description: ");
> +				 "  Enter description: ");
>  }
>  
>  /**
> diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig/test_eficonfig.py
> index 1d8e033f75d..d98de5249df 100644
> --- a/test/py/tests/test_eficonfig/test_eficonfig.py
> +++ b/test/py/tests/test_eficonfig/test_eficonfig.py
> @@ -117,7 +117,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
>          press_up_down_enter_and_wait(0, 0, True, 'Quit')
>  
>          # Press the enter key to select 'Description:' entry, then enter Description
> -        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
> +        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
>          # Send Description user input, press ENTER key to complete
>          send_user_input_and_wait('test 1', 'Quit')
>  
> @@ -166,7 +166,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
>          press_up_down_enter_and_wait(0, 0, True, 'Quit')
>  
>          # Press the enter key to select 'Description:' entry, then enter Description
> -        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
> +        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
>          # Send Description user input, press ENTER key to complete
>          send_user_input_and_wait('test 2', 'Quit')
>  
> @@ -278,7 +278,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
>              u_boot_console.p.expect([i])
>  
>          # Press the enter key to select 'Description:' entry, then enter Description
> -        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
> +        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
>          # Send Description user input, press ENTER key to complete
>          send_user_input_and_wait('test 3', 'Quit')
>  
> -- 
> 2.45.2
> 
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

