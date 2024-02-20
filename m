Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B064BC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB9487D1A;
	Tue, 20 Feb 2024 12:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vSuUyCr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F59F87964; Tue, 20 Feb 2024 12:46:21 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B7687D2C
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so57680871fa.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708429453; x=1709034253; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=umxEw3DZPLcyfF54fZhxUr5EpHkw7p0hEe6uo1ZsSmU=;
 b=vSuUyCr4z/8WbKUGUEwqiFlp3P1DCKF3t48OOKzD5rFfoRcQuk+djuk0uUOteBxU2O
 b68Uot9UfIIM68B5LMSIxrLQPGz5uCJC8IcDodyGak+hQgFqfb3gq+Q67XDBhApjkHHo
 BG5vRYL8Qcl2zf/DyVjwhPZpJwOlU0EgUdkpQltApmLnpYoF/8T+RkDydzEK6srkQ/Kt
 pGhIg6QnEx03yBfno9lR3qHXbT1sbY9yT2toKNf4x5mHy284FdKfgFO7ytWFRm70583x
 c+JOtV48DECh8ymBXwQvT+Gr184Gakbh2/Y+HymGFGF1olhBgh/ljZG6MkSzHJ+2XSRS
 orLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708429453; x=1709034253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umxEw3DZPLcyfF54fZhxUr5EpHkw7p0hEe6uo1ZsSmU=;
 b=jmtL+7SuxTKLZDslY1jf0d3F/w7904RmTcsF+9YpeYCOBVoR/AprPAaTpAgRsnKPmv
 qOeURx6YI4BDXx5JFaIhB/M50NipR+0L310VSD4JjFbXEPs/FA6I0Z8rdDZ+zLtEvO5k
 iKWS5tFnvY4DFaWwQwI6dF5UJC7OpUv9qukJIsezSmm8gEiOzSRz/otYDw0MEuyYN3aw
 Wquv9pwAHw3+H+Hc9aJd0i+0tvP8JvbhHomUanQFtCGmDLW8LaSYpppaiMHkWWcHuwIu
 TLFwQxj7AL479uyP8uonK+qkUecpF9X1wDUnACLGj7zmYZkBLb9Xl0RolzaQevdRE862
 Lnyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAD2KAKjefWIiI8guvGGhowug4ZGbOS9ozQvU0y7DZ92K+KuhZphRrC8nGklgoyJUTpO9yfsATdPl20uyyvQRVIScs9w==
X-Gm-Message-State: AOJu0Yx0XlDeTz8Fouri3IlWXzDFuaZfYFCHMZbW9EVPRXz7zdhHnB+U
 U0kVQeEjj/7sdWMuIw1aMIdCnx7xF+bIoGzXsJ37UOmTwkijzXGFq8tY/evVSug=
X-Google-Smtp-Source: AGHT+IEiRa70YgY1uj3oTvZ1ojRNDVRkt/a7g3BXLI1kxwPSmWe/MU46FI/DW7y6dnbJrH5hRj2XdA==
X-Received: by 2002:a05:6512:3409:b0:512:b3bf:b803 with SMTP id
 i9-20020a056512340900b00512b3bfb803mr3837469lfr.39.1708429453010; 
 Tue, 20 Feb 2024 03:44:13 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b0041256ab5becsm11675855wms.26.2024.02.20.03.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 03:44:12 -0800 (PST)
Message-ID: <b3771ce5-e36c-4f28-875b-7c35b9492d73@linaro.org>
Date: Tue, 20 Feb 2024 11:44:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: simplify error message in
 efi_disk_create_raw()
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240202141252.62378-1-heinrich.schuchardt@canonical.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240202141252.62378-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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



On 02/02/2024 14:12, Heinrich Schuchardt wrote:
> The error message
> 
>     Adding disk for usb_mass_storage.lun0 failed (err=-9223372036854775788/0x8000000000000014)
> 
> provides a decimal and a hexadecimal notation of the EFI status code
> EFI_ALREADY_STARTED which is defined as (EFI_ERROR_MASK | 20).
> The decimal output does not convey the value 20 clearly.
> 
> With the patch we write
> 
>     Adding block device usb_mass_storage.lun0 failed, r = 20
> 
> similar to other EFI error messages.
> 
> Fixes: 952018117ab4 ("dm: sandbox: Switch over to using the new host uclass")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index b1739d99201..2fefd05fbdc 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -574,7 +574,8 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>  			log_notice("Disk %s not ready\n", dev->name);
>  			ret = -EBUSY;
>  		} else {
> -			log_err("Adding disk for %s failed (err=%ld/%#lx)\n", dev->name, ret, ret);
> +			log_err("Adding block device %s failed, r = %lu\n",
> +				dev->name, ret & ~EFI_ERROR_MASK);
>  			ret = -ENOENT;
>  		}
>  

-- 
// Caleb (they/them)
