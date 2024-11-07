Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A305D5AE7D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B788923A;
	Thu,  7 Nov 2024 10:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jENA+aWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2498B8924C; Thu,  7 Nov 2024 10:59:32 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A5589218
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so587707a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973568; x=1731578368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W8dvvSnqPexyEemZ0R5GoubYPffV/kDdP0gG2tkYYr8=;
 b=jENA+aWinCJW3QePkWzw6wd5UNXsOPnSWeBoSoZHKeUVps17MJPFmsQ70xQlk7mdqV
 HmR82b+MJe8omXnwvXamzqjj/6c6PvzFh+SDeOkK67UVci3Qh+Qq9Nx5g1PObFD5NWN3
 TVDKa3+2wFJLErWrxqVrxzCcvePy+OeZ/eVVJ5LHvvtWsoT29oNwpEjp7wqk+1MchN+N
 gAdaHk2pr55MiyzvQEFwwsMazOrOOOGb+m/tTwxwhm08cRX+JMFCMJGIRcrWBTyx2z52
 u6tQEziRGLNSTzCIhWOL4+ui9CaG4KC8kKCbcwksrgqIBYLIPnu4EMbMCL5OMi+iPiRC
 yhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973568; x=1731578368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8dvvSnqPexyEemZ0R5GoubYPffV/kDdP0gG2tkYYr8=;
 b=W1+tfmMq9znxB+hQT9PCIk+BvIAWsRSku9A3kCQCvgy7ZTBrs1j6KhrRn8wDxE/SB0
 ivNZMsZWuqOnq9FhZa+kPgXCcY392lEa4JMKfRCrVnWhLvxux/Uo9us0R8KuZsUhHA/U
 nM1Mq2VfZFL3EAHq+TevX0w8a6/ymq7qsoWLvOuKQDcLElqVv7AuOS98XRnXYAmPjCJV
 H7wEN7sU9d6BOP+XY8NzvjWGmlnjczg4BFpsyVbdiesAatocQodkbSXyW1MAyEP2Cm9v
 gex8Jml6B9wKMbKJ5tvMevuy0Tdz/ocpaVCDMqdfOwY3LGXank2KJrqttOISY45niu00
 cYIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI3viFu1TDnv0a1AkHITDZQQIM9fSp5NSKzSCYwLghIvsz3p0CtGHcG5gVLEAU3bv5lSBsFvE=@lists.denx.de
X-Gm-Message-State: AOJu0YyPb873hOhdvF6xe0/TvtoAMeTV/FthRCdXUZ47RB/AFrolJYi2
 eecI/W30xthj4TgFWvWlra2m6clN8lQ2tdVHXKciEXK9oB/JgI2sbF3+q4Hm4feWqPEO3YOa3OS
 LiV14qssIdrQyqepGy8gKlKBWnrtxGWXQU2EQMQ==
X-Google-Smtp-Source: AGHT+IEpJnpZwi5HaDc3PhhVah3IEs42gFgwvU2eTj4OveYL8ZksUybtUc54ezr1kFFs4ih/CjIl9UgXy1VbdB+mtBY=
X-Received: by 2002:a17:90a:db87:b0:2e2:cd11:c9b with SMTP id
 98e67ed59e1d1-2e8f1058107mr45592060a91.3.1730973568432; Thu, 07 Nov 2024
 01:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20241105042045.36435-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241105042045.36435-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:58:52 +0000
Message-ID: <CAC_iWjLE16PPzazVcWK9zMWpdA3m7NXXa+eD-0Lyvw_u1APbkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: simplify efi_tcg2_hash_log_extend_event()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Eddie James <eajames@linux.ibm.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Tue, 5 Nov 2024 at 04:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The value of variable nt is never used. Just use NULL when calling
> efi_check_pe().
>
> The API function is not expected to write to the console. Such output might
> have unwanted side effects on the screen layout of an EFI application.
>
> Leave error handling to the caller.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_tcg2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 866a529857e..572c6b5bf63 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -607,12 +607,9 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
>          * Format"
>          */
>         if (flags & PE_COFF_IMAGE) {
> -               IMAGE_NT_HEADERS32 *nt;
> -
>                 ret = efi_check_pe((void *)(uintptr_t)data_to_hash,
> -                                  data_to_hash_len, (void **)&nt);
> +                                  data_to_hash_len, NULL);
>                 if (ret != EFI_SUCCESS) {
> -                       log_err("Not a valid PE-COFF file\n");
>                         ret = EFI_UNSUPPORTED;
>                         goto out;
>                 }
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
