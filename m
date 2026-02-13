Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3DCEF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA7083DFF;
	Fri, 13 Feb 2026 21:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f8NLkzHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCFF83DFF; Fri, 13 Feb 2026 21:21:00 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112E583015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso8529115ad.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014056; cv=none;
 d=google.com; s=arc-20240605;
 b=K/cPtyjId9ifbn4B4ZSRiqekocv/LsuwicinallgaLO9JN5Xshj6V6Mvpe5SrAuvU6
 PPDTgGlL3XFt5dLQ4y1mU6U1PhDYXxnRS5CBgKbU5YknffS3xkBTZsV+2bGid0V54pSu
 waMlglHt/xJNwwwhJuJdiM0U927PqNzmnJZCc6U1m5iMcLfEgbedkKMihpsDS9jxnjlR
 UPF6QWHF0i++GZOHGEFwX5usDxymUlSIxv6XfSI2ngsRBbFKKkVQVx/nygZEfEbZc5/5
 QhjmyaduO0UkeDf6yvKNjuyjKWDVAhLmyPz9A6GAOhVRlqvatObMmT0ULvCh4UlQXVIY
 i/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bmzEflmCvKpst4oJa4TCoEoCGC2lnSFFKBN/WgmxDB8=;
 fh=zJE/Fo8l/szBmEOetLct695NX5uRaYsIjDN5aCBW4wU=;
 b=RBJIJcWY1VvIeRHN8t7kqaaydtgMuFj0kMtvI8m0ZVf4x/BW9LG9CcxOPvez53Aazb
 TFHypK9YeBk+vtO8+FeJ67SvVpuENGATWd1pHK2yXkCp0Vm7qCTj3bYw5fZBlnkxdYJk
 UQvbDG3vj25nAzATsQCLGLmfU/L130eCoVp0uz7cvcjnff2ZxsyCA0VKnh+dj7G5VpB0
 t96KZEiGpvcQCHmmJEcWCIUnXmkYj1daICunzbCPAqURBUkr8puxMw92So1yMfYSS2d0
 Egyy85GlfFSGP7dDpSVxLcNxjGW9qHPhTGjAIoJXaL+2M0wk7oHuGZObAM4iHLDPr4fF
 ms3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014056; x=1771618856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmzEflmCvKpst4oJa4TCoEoCGC2lnSFFKBN/WgmxDB8=;
 b=f8NLkzHqwiY+A/zlgGs+aK3HQAi/yhaIxmzpbudC4LRoTZ4s+LGi8p6yIDzsBo2RET
 rXKA6GuhGvOsNnFUACUNqFddL+evkTg6uSBhnshfy3XOZWKYsD81SWJ8OltU5ty5kDmM
 WPwm2zK0O8IEjBYF6eEbRxfB7sw1eEm548ytI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014056; x=1771618856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmzEflmCvKpst4oJa4TCoEoCGC2lnSFFKBN/WgmxDB8=;
 b=KnTm1u5XJbUMlZpjuHRHW4Nexgk75HCjc+mbCWzlRzwFWQqxTnAThOmEXBWEEAfmzA
 Y8KM6sTCDpAjIcxBHpBH7ZJUWClHheN589TWEZDX1cIIBHNBJYVq46AF0uFqhr9iVur9
 RWvYcS1wTcRI38G/dfUgjyQdjzI3y+bjJv5c5lQhkZoPyeUhRRW+UDwoLqM92guq9/fo
 U1kkSU8S23E67ggAs3cSotJ+hbeVFyvDQw0WdJNlIlrmPLDbepwFWqoig0aKFiZSvaDR
 7wnna2S4LKw68awneyw3ynLHzgf0LbgJFdLSClA67yQrWWTPaHAcsqS1FFqS30dG28si
 2bLQ==
X-Gm-Message-State: AOJu0Yz6wlWrNbYawWtFUqcYJFCp1n3zutMMIXmQ5/lFq1rjzU2hE2+o
 2MctCBcFdzlWSMO3CnMC6T97tk4BgR4s6shMqTW71tR3Qq4gHP680yDCRQ1JLPhjoLqm8ele2oE
 KQLy27H4aKDhoKZ3H8V2DP13HhIcK7BWEgwZT7tfg
X-Gm-Gg: AZuq6aJGzXaVtW2ysiw++gWCdo1jU+/63HX1Srvf0HqRClZBzXPKUOgPq/tNTfpsxB9
 EWxjklDm4B2MMqEfwHWmpbyi/F6pl6hI6ZvvOtKZp67N9gwP/BkBIBXtAQQKExGZCfYQa7pLNVJ
 MfLrGn4BzMHV0hW5ce/2D1E0t7ibit4b+1KGQFpRjrAvhG4miRwqR6edwFefdDdJyNFtFBciU5C
 k6k4J3BW0YuOeTZ35z3/a13azmpt/u4VHG4aTSHU3aswemTap091c47xOf+SIPhm5VO3yRSg7OX
 W2BP
X-Received: by 2002:a17:902:ecc7:b0:2a7:6aa5:68f3 with SMTP id
 d9443c01a7336-2ad174dcf0fmr6005305ad.34.1771014056406; Fri, 13 Feb 2026
 12:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
In-Reply-To: <20260210-ofnode-to-fdt-null-v1-1-4bed28680f35@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:20:16 -0700
X-Gm-Features: AZwV_QjPsgpZWaNe5J7TTTKSjrskikg58HjcKMDrm_WleKEXSqCCKZlge4bKdjU
Message-ID: <CAFLszTgtGwjyPt2HHf+ZorSfDOoLropv6b-v0WvYBLhkSGuoVA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Don't allow ofnode_to_fdt() to return NULL
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

Hi Romain,

On Tue, 10 Feb 2026 at 09:29, Romain Gantois <romain.gantois@bootlin.com> wrote:
>
> The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> Or, this function's return value is often passed directly to functions such
> as fdt_getprop() which end up dereferencing it, thus causing a NULL pointer
> exception.
>
> Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> dereference.
>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/core/ofnode.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index cf1cf8abfbe..af24a2c533c 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -164,15 +164,20 @@ void *ofnode_lookup_fdt(ofnode node)
>
>  void *ofnode_to_fdt(ofnode node)
>  {
> +       void *fdt;
> +
>  #ifdef OF_CHECKS
>         if (of_live_active())
> -               return NULL;
> +               panic("%s called with live tree in use!\n", __func__);
>  #endif
>         if (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) && ofnode_valid(node))
> -               return ofnode_lookup_fdt(node);
> +               fdt = ofnode_lookup_fdt(node);
> +       else
> +               fdt = gd->fdt_blob;
> +
> +       assert(fdt);
>
> -       /* Use the control FDT by default */
> -       return (void *)gd->fdt_blob;
> +       return fdt;
>  }
>
>  /**
>
> ---
> base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
> change-id: 20260210-ofnode-to-fdt-null-95a9f357819e
>
> Best regards,
> --
> Romain Gantois <romain.gantois@bootlin.com>
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

This seems to me to be a hole in the checking in fdt_check_node_offset_()

Regards,
Simon
