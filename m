Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B4AC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB9780FF0;
	Thu, 27 Feb 2025 15:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/sxIPgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9445180FF2; Thu, 27 Feb 2025 15:57:33 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590DE80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e60b01d0e1bso170162276.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740668250; x=1741273050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAmHDvXVrWImVF+uB9AccEg9I6a9ClQoY5FPMf/40CU=;
 b=b/sxIPgOmVqGUv/v/Zbt2kxTYAbRBHNAtlhWAJWCDZmh/HU7deM6kUyUJiOSMwRbUr
 h4YGBSdLwYWoEWOaiU2rmPZHcMO8bQTUEeR8OVJ6jyB1fhiAKhu/rpvwMxL9z8APKgoD
 zx7GSCukItc2VIDJjzkfoO8BvTkbiwW3IsJbs0xwhWYtqRCpU2oEuiFMlegV9l5qYqeX
 CwR0Nl8oM1Dtx9hCwQma3VANl++7Oopy7vw8FC4NwV+djfpdTitOnGyI7kZHH9FL19LZ
 ipVQfP+e0a8Vl/prDesWfzmmlelnHZhFkTqn1zmX7qeEEsXLYvUop3nyHG8+TKk8XGJv
 YTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740668250; x=1741273050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAmHDvXVrWImVF+uB9AccEg9I6a9ClQoY5FPMf/40CU=;
 b=b5Dsc+5qUWesEAJBcVcYUIenb44wEeuGmRYikt85Rnf5yxkJm2gsiFKfDazxdheg7w
 ZJX+UiTn+J7f5hjQjxoL3Thdjq1wQlOnFHFvA0lSyr801CC30wEwfJfUrjLkAYttLLfr
 tTd8foFpLMEpvsmpAi+QGB0I+2r0S09Z4zu1tkPjXwZHErnPmtvMyqXoUo0hTOhDL0WF
 PzE0BKZjSCX71WixdFcur7728yJ5YTr1/YODg7RFPqlgDdS4mMr/xKjdCKj7XwhNkMi0
 yg2zlqcJid7chCgpKS14lnUOOb8mzclzDoNJEpodsImXq1tnUL0bOB9vm+WBPgtDYY2R
 VPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWytEtWMb5mjX7U7Wbp5wVLQMEfmfFXXcatEoPSxz075F+TE6g+iffhX/gjp1x/0zfRkOTZb5g=@lists.denx.de
X-Gm-Message-State: AOJu0YwuXvMoQzpz+T8QN6X2VTYFn9mmt6Lt62tNlvO8ztlwKa7jC/qd
 trxhvhoCyJvhgZaDZ1bMy/QaZujMThPgWN8uJ0MC+AkKhfZI87cVEidMvy3p1t+sD6L9kqiOUs/
 Twoo3HQGtvFojdmBZqQCS5DUvyg+Ljck9vQXyCLVutktUpYKL
X-Gm-Gg: ASbGnctXBELJ+u9HH+Qn/ihGmtCnK7aZ+Z7p255uQPrVYgmAB2fd5Cul/wfOb/b0zla
 3nokFe8RVsuf7i0XT9XSgcK4cYwD44tlBdggcCIzef75aZ/qKr3LIo6Ed/uIbQoMr47dhMZenF0
 nAZcI6GmEl
X-Google-Smtp-Source: AGHT+IHOInTUVoxAkQcJqChUF4ARlYbFYbjea5U1kkwKzOq8f7Py3uaN4+BfY4nx7kseVbtmRfibMtc00/RIHHsqgXw=
X-Received: by 2002:a05:6902:a04:b0:e60:99d2:cbc2 with SMTP id
 3f1490d57ef6-e6099d2cebbmr5883999276.25.1740668250230; Thu, 27 Feb 2025
 06:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20250226091258.16582-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250226091258.16582-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 27 Feb 2025 16:56:54 +0200
X-Gm-Features: AQ5f1JpWKRHjTO1BmpgIZcDwkoUssMiO8nIgYSgktIJSV1zD2hENsFFWjwTaUm8
Message-ID: <CAC_iWjLPj1vxdbVT+HXp-22+0G=77PQa1yweai9vo4HhGoWrDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: simplify eficonfig_init()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Hi Heinrich,

[...]

> @@ -2287,22 +2287,8 @@ static efi_status_t eficonfig_init(void)
>         unsigned long columns, rows;
>
>         if (!init) {
> -               ret = efi_search_protocol(efi_root, &efi_guid_text_input_protocol, &handler);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -
> -               ret = efi_protocol_open(handler, (void **)&cin, efi_root, NULL,
> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -               ret = efi_search_protocol(efi_root, &efi_guid_text_output_protocol, &handler);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -
> -               ret = efi_protocol_open(handler, (void **)&cout, efi_root, NULL,

[...]

You need to remove the definition of handler as well.

Other than that, looks good

Cheers
/Ilias
