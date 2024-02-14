Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCEFC4829F
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 06:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD05C87DC2;
	Wed, 14 Feb 2024 07:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hSCNDm+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6CF869F7; Wed, 14 Feb 2024 07:43:05 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5BF869F7
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 07:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5119cfaeb9bso1591232e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 22:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707892978; x=1708497778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCoqIcez1gFBDn/jhf3ugHCWJmbwh9qo/yVN04wCUfQ=;
 b=hSCNDm+6z44DL1MdHSmxFGXLzotzu4AJ7pK1NdRf++ubYh0sTyjB0e2YGhTfTYRJe2
 2GTX2zPNkrnRv+3H5RtyyifaaswzXM3Vp1iHk0S/HYectEOGEUN61qnZLoGuqPR3JJpO
 3dva2TJ0F+ka5/9fX4Ow58K5uv8zU85urVAh67/FMlq7hAiqRC3kshmDWHljCxQIAVjf
 9L6l3MHOY0IVGrF/hM4CleEc6SsbrMg5J5L5U0Jkj5GJgd4cuYs7WCoeb1ZfWeBMdOoR
 aC6Kin9a7xYp/ZYScyGrAjuJS9WwFvwfAy1BavKy7GRGywRW/E2+ce9L+/LirE5NeIin
 FN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707892978; x=1708497778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCoqIcez1gFBDn/jhf3ugHCWJmbwh9qo/yVN04wCUfQ=;
 b=SkJ1H4gTUany4CDZqjqf0JouVfXGphxdODFqEGwtnJ2AbZtzr13Tr3IODraX3kTzr6
 lb++TfgGHkqpVLH/mO3vzWNDTMBQgGXinbuWy0JFv9w6cNUxeWlltXEWXKj/J2UHiHHu
 usMj6jCS6UP61GYckTLfdM1bt6T9OIkeLKTII+LTiJo2qdC9PZOUc9u2dioZ9mSnHBjt
 AAsO7siOOQWP2DHdwnsBrk+wagignpvliOdvhMTL79Mt5HLtWA1rz7fDO79Ad2fvl/it
 TLdP8OV+5ddP9EVXSrYlUmhpam6xy7TKFHF3Xja7d9agP/TiQ8uDH0XZXY5HlmN5K6Ov
 bfEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIpZ0Bj6ja7W75nae9HyVPIdgZbpvx14QI+b/0BQDS5fwaz4XrALh+uBMukekicjCV1wJs7lYOL1/ke1/lg4xmDJ+XNA==
X-Gm-Message-State: AOJu0Yzx2Hi5YuJwjQsuEwOAQUBqvCkekIz6s9HfuZ1tUHNXDsnNDz8H
 y3tcCoQ7incx4IUpoxISumi+tAR9CZjfOyMmWK86fcTWDJr9d82ZT8RpNKBN4nQ5oAk4jGPI+ea
 OGvRRmJQZs6m2Fiz3EzlZSzvZEP6KIz0THnyxjg==
X-Google-Smtp-Source: AGHT+IHssRKfjlGAJJ1LeFvIteASUEoteKcL7F9T5zGNYznc2i5TucBxHVg+QNiSrf2GtSlWt0U1dnjLIRrqdB2ntxc=
X-Received: by 2002:ac2:5282:0:b0:511:8987:1941 with SMTP id
 q2-20020ac25282000000b0051189871941mr1029973lfm.62.1707892977741; Tue, 13 Feb
 2024 22:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20240202141252.62378-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240202141252.62378-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Feb 2024 08:42:21 +0200
Message-ID: <CAC_iWjKDHDXK3ojjgEGa7kyc0YrRJv2cOaU8NuZ65NEbSon8LA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: simplify error message in
 efi_disk_create_raw()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, 2 Feb 2024 at 16:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The error message
>
>     Adding disk for usb_mass_storage.lun0 failed (err=-9223372036854775788/0x8000000000000014)
>
> provides a decimal and a hexadecimal notation of the EFI status code
> EFI_ALREADY_STARTED which is defined as (EFI_ERROR_MASK | 20).
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
> ---
>  lib/efi_loader/efi_disk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index b1739d99201..2fefd05fbdc 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -574,7 +574,8 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>                         log_notice("Disk %s not ready\n", dev->name);
>                         ret = -EBUSY;
>                 } else {
> -                       log_err("Adding disk for %s failed (err=%ld/%#lx)\n", dev->name, ret, ret);
> +                       log_err("Adding block device %s failed, r = %lu\n",
> +                               dev->name, ret & ~EFI_ERROR_MASK);
>                         ret = -ENOENT;
>                 }
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
