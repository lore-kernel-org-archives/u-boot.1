Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64537C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA31F8890F;
	Wed, 31 Jul 2024 10:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="frSw2N0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7C88897A; Wed, 31 Jul 2024 10:34:58 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344128842C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so8149014a12.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722414895; x=1723019695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cxl/9VqkV958aEpD+ruXnSJToxzQyvfVGMl7M4IqmZA=;
 b=frSw2N0V8xxXkzGE5SuPrmO5QRwmp4RE7/H4py67PdC0uIbi8VOShgc7amjrp9iOiq
 9oRhT3ZmJRC9va4tpEx8gPsJwu6BFE9KZ3POqNxbmTV7CT51fa5NxobbCMcQdFxqpHli
 xdwi4BxAOEi55ys/dZoSvUvG0bUkc//ZKjz9Ck+d7zuWs9iXEV+J3dcvug9IkPfD/DFa
 Ftm542lrpjRkg6ouKPr9gjpavWcsCfdPilgrqgKg6ysxUbU3LZHgi31Ns2c2SKqfBHkk
 knj32Faxf6ksMopiB8/kL6zQI/VuUgfEmD6wxcqaSMvuy2URZWQGUw0fNOFfs3klq98B
 yMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722414896; x=1723019696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cxl/9VqkV958aEpD+ruXnSJToxzQyvfVGMl7M4IqmZA=;
 b=FBCsR2rGoIUpGaodg559jWjdX1FRZTmD4QpiKhkxRrUDqwdQOIaOCIv+QJQkVuk4nI
 /ZBrr4oqNUr2EPvWhN5kDAcJi3PMMx458zx/afEfoioBWHLKdE1ESSgz3rvP0eNYXaep
 O7MPpLPGVL/7i/OVWe5spwxmi6R/8Osa3WAqPuP8bipDMVEZI3EfT7QRsqM793wUhTe/
 t30k49aAIkkqGgrAf0vibrDV30J41uV/oS+LyyjDanWzg3kL9Z8q3Hp1BdW6c4khruZh
 D/5ikz/RZUDEkXiSghwa8pay01aQuTY59RejABoKTxkvedV/aZF8+8kWnQ3DBHVm7DmB
 LsTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV8LUy2WisK9zkcjIAESpptK9PpTnFVuZxlFJm4tw5EsV1QpygTr4mnjgzwaYCiDZoLipbIM8FbSU/q8wLSMRywCNAVg==
X-Gm-Message-State: AOJu0YyyorQ0Rr1Id0MuW679COCXN+cGfRQ6OIg8IW2vEajGABvHM6eU
 f9bWgf2yMxmxydTNt0L7R7310qJbf4TDgvOvFfNHrSNIB5c/Sxm+7lT0T4GTQNkWB7fRcqN1KsE
 kmKcFJAoEGFMu17Qfp8m0+1OK3vGSMji8dpZbng==
X-Google-Smtp-Source: AGHT+IEmRS9iD6Y8oju+hk9QuCB5vx8YH9mldf+sbNOtVaFr2s9QhgfR5MWJx+dnDdeoF8712scM7hy9bLlshvOXtjM=
X-Received: by 2002:a05:6402:40d2:b0:5a1:f9bc:7f17 with SMTP id
 4fb4d7f45d1cf-5b02010339bmr10690641a12.5.1722414895489; Wed, 31 Jul 2024
 01:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240731081304.81848-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240731081304.81848-1-heinrich.schuchardt@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 31 Jul 2024 14:04:44 +0530
Message-ID: <CADg8p95P5iTuoJo-UZ1do8O=zKQVuorQh9-A4-XEguSVec2Fzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: use list_count_nodes() in
 efi_protocols_per_handle()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 31 Jul 2024 at 13:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Simplify the code by using the list_count_nodes() function.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

I have made changes to the files that you mentioned in your review,
and plan to come up with a v2 once the CI goes through. Thanks.

-sughosh

>  lib/efi_loader/efi_boottime.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index eedc5f39549..4f52284b4c6 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2509,16 +2509,12 @@ static efi_status_t EFIAPI efi_protocols_per_handle(
>                 return EFI_EXIT(EFI_INVALID_PARAMETER);
>
>         *protocol_buffer = NULL;
> -       *protocol_buffer_count = 0;
>
>         efiobj = efi_search_obj(handle);
>         if (!efiobj)
>                 return EFI_EXIT(EFI_INVALID_PARAMETER);
>
> -       /* Count protocols */
> -       list_for_each(protocol_handle, &efiobj->protocols) {
> -               ++*protocol_buffer_count;
> -       }
> +       *protocol_buffer_count = list_count_nodes(&efiobj->protocols);
>
>         /* Copy GUIDs */
>         if (*protocol_buffer_count) {
> --
> 2.45.2
>
