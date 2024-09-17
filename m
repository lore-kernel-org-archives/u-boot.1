Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3264C36006
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 10:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F0388C86;
	Tue, 17 Sep 2024 12:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wMyx7TVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F380288CBB; Tue, 17 Sep 2024 12:05:26 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCD288B86
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 12:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso6966778a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726567524; x=1727172324; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnN/tQNWNpdnD6DshulwxTUh1OZbZt8ce3We1o56vPE=;
 b=wMyx7TVclBLZpluYTqfVBR1T4z3mG/wCMqBbzpHEgAHpVQfU44gReW32TewsXSU1Mo
 vzykGoSHCgmqynr+r4MX+HpTJFIa9sRPeMqUFpI05DFRqtlxfrUom5kvkotBYFDfpGeE
 2Jami/DP1UwYmQoWrk3x3Kb6onpYuxIt7sOFbSJVD7zcGlA8P0oQD6JJOSNazcDSUpZR
 ioofrR8Owse9ElJVmDnBfdea4JfNS0g9G51NyPs++6yZihhH6KdQIJqYulJIvV3IyBFy
 4ylNEk6qBJYLjTfAXnOABEN0gVWEXTeSD+tmOSmXZuXVKL2oFUXYTdWLDEK81W57Oe3Y
 GB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726567524; x=1727172324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnN/tQNWNpdnD6DshulwxTUh1OZbZt8ce3We1o56vPE=;
 b=n1AiomAO2U7qTv2g2EEqVlsjdkMAjVZUqnSuDcwWS2tP7UgML/+yhmt0z71XR26Dvh
 iqECju2s8U+EVjSEiLRgLK3ARQ61K8S53il/bF6adqvRjbhf5jPP9OEHHgNRp6Qc7Tz6
 MkXd1eL+vPIsotwz+7Oww1QrAX7xWtAw3uaUdEA7d98c3UNSy0k1HeeReOCwj6YoZQew
 O1a8obJhCId7jnZoFN+E84FyCjBPbajqZ1LSadYlwJgm9tNvBW8zR2MYi4YHd69FeXoR
 3mizqwU3iDaXFmpApCvCazVQhj7cbs056pwh9KFgNxFAsOpWbdpVOQvA/nGFoO0KDqDT
 +FkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0j7KfMgGJ564kVXHozDY93HUHDRCnq83v3nBOieoeixJsVr35oGQHvL+bMS6HhqgbsehP3hY=@lists.denx.de
X-Gm-Message-State: AOJu0YyGME4N3uxXg7U3lp2IMa9rsc3a8FyVfJnMncyADoUiH8f/U+Qe
 9nEFqGTmv1nqbK5T4pd/m8SrqleqGYUkqaJsSiD634s0hnJALgYxvNZ52byZR1fUKwvpKyd7yyb
 gDXgEhl/m2dYPu6dEXbLLftbnAmOXvm4E//ltKQ==
X-Google-Smtp-Source: AGHT+IH5Uk3n/5Oss9nrKVMjBExzED0jcfodGr4uat2zvuVTm+SSvfjsN9l9RIwZHVTJlOEugv29Ot61N1RdezZ8Lpg=
X-Received: by 2002:a05:6402:26c2:b0:5c4:2edc:dca2 with SMTP id
 4fb4d7f45d1cf-5c42edcdf6bmr5178984a12.21.1726567524140; Tue, 17 Sep 2024
 03:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 15:35:12 +0530
Message-ID: <CADg8p968=pmYLm-b+Q+zJhjXJRguyyH-XazPo5pH_hxY8Kbijg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Don't allocate from Special purpose memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 17 Sept 2024 at 14:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The EFI spec defines special-purpose memory in =C2=A77.2. That memory
> serves as a hint to the OS to avoid allocating this memory for core
> OS data or code that can not be relocated. So let's ignore it when
> allocating from conventional memory.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Can we rebase this patch on top of the LMB/EFI series patches that are
currently under review. I believe if we consider the direction that
the EFI allocation functionality is going to take, that of relying on
LMB for allocating conventional memory, we will have to take a
different route to this problem, whereby 1) the LMB module needs to be
intimated that the region of memory is reserved so that it does not
get allocated by LMB and 2) then adding this region of memory as
special-purpose in the EFI memory map.

-sughosh


>  lib/efi_loader/efi_memory.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd09456e..74732e37f8aa 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr, boo=
l must_be_allocated)
>
>                 if (addr >=3D start && addr < end) {
>                         if (must_be_allocated ^
> -                           (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMO=
RY))
> +                           (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMO=
RY) &&
> +                           !(item->desc.attribute & EFI_MEMORY_SP))
>                                 return EFI_SUCCESS;
>                         else
>                                 return EFI_NOT_FOUND;
> @@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len, ui=
nt64_t max_addr)
>                 if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
>                         continue;
>
> +               if (desc->attribute & EFI_MEMORY_SP)
> +                       continue;
> +
>                 /* Out of bounds for max_addr */
>                 if ((ret + len) > max_addr)
>                         continue;
> --
> 2.45.2
>
