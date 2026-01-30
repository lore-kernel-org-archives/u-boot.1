Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122CDD49C68
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 07:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540AC84206;
	Fri, 30 Jan 2026 08:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pzqoBAmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C475A84206; Fri, 30 Jan 2026 08:40:23 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CF084131
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7946a1f2430so18165937b3.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:40:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769758814; cv=none;
 d=google.com; s=arc-20240605;
 b=EPoorT1eaP9M9OmYwerFBfu520YxLB1vlMTLn78wWOQTiewilh71Bkw+OTRzHRzYtM
 KWeWnNkzToHsDprw1LzSNT9eD7AqxZAHZIBa7AOM61OkslwVMx0FUG6EJbv0wlPwXgQw
 ZMQu3bO9h8+CiPe96p2p28EUE5UL4N8Bu1owcn2uEuPD/KpUjwrPwPSCZNukaTJrEcF8
 61PSduJ+sneF1WgulDL3U1mKBvkfhrBm9/e/OYHbLVuZUTsTJ5Hkj0B3pzKzwsCjQn6o
 b/ai5Vg1c8ioHdI9yIy/vQzHBd5Ph/eFb3PQ+apASmoMTwtVKc0sW9Z+5fkMZoe7JfXe
 obIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y3L3p/JaUyVdfEcqI5/hEblwO/TYRjov/WpjCEO6nsc=;
 fh=scYkI2pdHmhnl5JNcajeOeRDElDDCijDpN9lSr2JUsY=;
 b=WloiDE1yViVbQHDXjHc9/VidAbLDxTIAFnw/kfKG6N7vUb5dabqVLKlGdaU8TQJMFh
 EvIszqugnnhirwziKDv3VcmusZK9lK10KLAWgPOCTKpZPLjoR9FtLPz91Bf904HNHxQz
 Pq7ErS9Aj/AkPkF3fs+tewxNreAiIvC56VOFIQUE2YGFl50HFLure4hjQc7DVfPKNNgz
 DmY6OtEZSJk2VQQ7n3NtmV7DBxVSukcKBF8aZubs9s+Pnz0ZYUKmTLFWVc+4vwfIeR13
 vSQHonegnXZpDM/NkTKxThLPBs8KqmnrFJtL5ZGbM8Vy4kS9KWhAeo2WsZIHGdGCfMOe
 lYPA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769758814; x=1770363614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3L3p/JaUyVdfEcqI5/hEblwO/TYRjov/WpjCEO6nsc=;
 b=pzqoBAmSONeOEH+Za/oVR1SJV354N0nJPCSUDjGkugymiyBMcB7rCoXzNAeFGTZMPA
 PlCSxstNirlaHOWyFEdImhrksSEFMy1sZ+mWny+546M+Nh6i2jm2JsNEHXIHJGMXbDCi
 H3Sdk8txFg0yOBv3ixcjPqzN+Z/e53K/8ILwMQFfLhGRYMCS4Y8717Xe81vuSSbOIApi
 JGzDxtj5BoAZHwpPl7y0djKxpEJeZB0aLKLTMwAFAJ977Z7B6xK4J+MNtSPuo2IllkCK
 mTse/SWpfqCCR8TkbU7PW5cf15uQ3xlVkfiNG48F6a2oHsNawaSsctDzojdoZ+CYqrPz
 mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769758814; x=1770363614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3L3p/JaUyVdfEcqI5/hEblwO/TYRjov/WpjCEO6nsc=;
 b=KJNhvMSX9aMn7PHuu8j7kIYZeJIOklp15rz3WEtQh17gtrZ/x2IEbKeNk7wrCwZlJX
 CDzQzuf9jJfyGKM9Qk4cwi767UwhbQVd3bo5tnsync5CUuXIFIEI9DZbvygtii2kC8NT
 Fu5pMTnHQ2FxuQZ40hg8mdV3yrnZ5cgVsU4h3ayH+v2NZF8+RacoBYznX/uASX+ddZ60
 XbTU8/vVz3+UA1Uyb8laNfMH55XwlZadnSfRAf/K6XGuITR3JIPWBlODhSkOmksYKRdl
 6kO2KP3hV5q+yHQPW4Pi2dcmse9IFdQQtAeTXCQ8/rzc9chR8P4gqcHt6qhCSxPRKcsP
 rWqA==
X-Gm-Message-State: AOJu0YzdaUjp6K9lJ8SWRGP7wbiXQbYQ6GNJKEsDNQ7n0b9ARgiZEOI6
 9URv0dW/fwCI3Z4aobiyA1UAteonYCegO3bvcLr4npj+wlpoCXf27m5O6XKMutNv9Hw8t8uVueN
 hEGjzSQnmRRnE6hMauQp0BSSt9RZgUyGlkwPRvQ5Agw==
X-Gm-Gg: AZuq6aIFnfTIwAo2e59U1NzVC7raKbpXWyFSxE4MZt7NIGnPDaskZ2UrRaL0eofTVU2
 brszGGE69KIxU8dAVqw53/oQv3e8yMBz/B+2fwQ0XcHq/Ksx4Tg9qx/CCiei5US+enQs//RquWR
 6uKqSGi8bwd4b88WDFrf6uQwl3iE7VkZQBnrGRQ4mKhyjtPJgosAV5K2ONJLr1OFIL2RJosL6ZY
 nTyf3qq22NjmcN9OSx/DpRHddjzdLoWTW0pgxVQ3O7qb7ksolv05gYqtpxLrE8mcGDe9auuPOKQ
 7g/pzyLP+1UfNC05Pw0RL4noKAhqmYUEyYdVQKYcyf1U22Qa9gL2bT7Kut6NgSy39F5Z05exweQ
 20jz7oQcOMi5wtpEomttKuaiUBhTuAxXLl4Q1GmR1YAyOV1Mtrskjy1Sqd/j+2xLMcQPwxW9DKW
 yWoO+W4lb+sBaJRZjsUJ+yKLd2NjHcFsEpd8qM9Fqw9Zj6fdp5P+H5aVVCz6jdGGydcE8LqK+BU
 cHQIGojCSxBP55ERy99QeH0lbUgrK/8y2ihuOtQ3IhSlOmUwWZuTjQVKK1ejZ8IjoDfXkNyIMi7
 dP+Kh6oEszZNFcvUZWAiaKg9bkgvlnEQ
X-Received: by 2002:a05:690c:c522:b0:78c:665f:7bf7 with SMTP id
 00721157ae682-7949debea81mr18430017b3.17.1769758814539; Thu, 29 Jan 2026
 23:40:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769177838.git.michal.simek@amd.com>
 <a24775e12c07f363f05e966b707280487c8bbe3f.1769177838.git.michal.simek@amd.com>
In-Reply-To: <a24775e12c07f363f05e966b707280487c8bbe3f.1769177838.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Jan 2026 09:39:38 +0200
X-Gm-Features: AZwV_Qg2VYA0YAZdc_rUNqwfDYaMFj338IUJkK93DrwkulsmOm0WDrg3bLST_OQ
Message-ID: <CAC_iWj+dvScrzUYvWP=aeqr9wJAjL0CU6atnAm98F+SL2C_TBg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] efi_var_file: refactor to move buffer functions
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

Thanks for following up on this


>   * efi_var_restore() - restore EFI variables from buffer
>   *
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index f490081f6542..ca1775eb03be 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>  obj-y += efi_variable_tee.o
>  else
>  obj-y += efi_variable.o
> -obj-y += efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o

hrmm what if we compile with EFI_VARIABLE_NO_STORE?

> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index f3533f4def3a..13db6eae882a 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = EFI_SUCCESS;
>
>         /*
> -        * Write non-volatile EFI variables to file
> +        * Write non-volatile EFI variables
>          * TODO: check if a value change has occured to avoid superfluous writes
>          */
> -       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> +       if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> +               if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
> +                       return EFI_NOT_READY;

I think we should just return success here. EFI_VARIABLE_NO_STORE
means "dont store on file, but we still have to update the memory
backend.

[...]

Thanks
/Ilias
