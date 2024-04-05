Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152CBCD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F7C88499;
	Fri,  5 Apr 2024 10:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="npipvEZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B89D8849E; Fri,  5 Apr 2024 10:24:15 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4860F88433
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516d6898bebso97258e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305452; x=1712910252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k9GkzKlkv9Zcy9opzRGS0KZMOGwkzmtu37hEI6Dpkeo=;
 b=npipvEZ4dn3RUfiNqE1VM9OoKb2HDS1EJKYqfSgDB2Jih21Yq3rZos+LO8krezDo4z
 m4Sy+2WxWJ4r+cVU2HqxQkppek/p92XWjoxdgqMm1FmdNdjYHgSlFw931runSRyBqJTj
 WKom3r+V5EcM6Qt9RErT8GXZikHRvnR4OpRuPQij+2PVt2YVE+Q/BPmzWuRUjaNMLHjT
 poFb9FSHNDUkcrFHnPEMb7fJUfn4yJJi741qj5p/2iIqBILzGVdQvdtWlFZckc5d0PCc
 rrPPbpTjEKGRnguJrEDP/nCXYoJ3m8ODe+SlMAL39RBG3LphTQfz15Ce6208umRLJvUH
 5TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305452; x=1712910252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9GkzKlkv9Zcy9opzRGS0KZMOGwkzmtu37hEI6Dpkeo=;
 b=HHR++XtlrGL9gmhjEIEjTJWvmk3X3ZVgnNznqmUnzeqoZ9x5do0Rd5kNtSZfgDfneJ
 FJ0n/j1wig1vf42jTbmvDk50Kzr0CrNI7BCG7Z9PqCKqyp347kcWUi1d+kVHZmxnTsvb
 MCixwX5+6zDajPKC5QkqN2spiabQMUv3oHov5psNLWqpiUHIMnRc4qLN1jTr1OXLiswR
 h1mlYuRZLS+nV0plhNY7h4eZW9nQU2VltsKwXgo0TynusV8BBkIaIeUdSfdNA4V2cCXW
 CC8W4+mclTkCN+C/Tf/Fpg6P9qXbkM8wzRPxEOiqrvwOZFVxAuisBpo6MzsrCOtlRvpn
 J/dg==
X-Gm-Message-State: AOJu0YzwzZgdXJA1Msraw5z5BmzVTeOIXjwgYB0ZRRocC0Wsd4P1+3vP
 y6OpEfKD5vmUkLSZH362pO6KSV3s57NXcExMSCqPoeQzH2Gv4mt85CMYTVHMJPFG4yTF4QRpvJ1
 oWm0ZE/tmZy1IwXETrCeeBjpJU50Fsrm2xEMwPw==
X-Google-Smtp-Source: AGHT+IEpEUEhTfpEAh1JKfZUrszwVSIauqxjj2e252decmkssedY1vQDoJb9VIG2O20CAoEOyn7w1+umlUTNz092MHc=
X-Received: by 2002:a05:6512:224d:b0:516:cef7:1042 with SMTP id
 i13-20020a056512224d00b00516cef71042mr640870lfu.11.1712305452435; Fri, 05 Apr
 2024 01:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240405081257.9515-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240405081257.9515-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Apr 2024 11:23:35 +0300
Message-ID: <CAC_iWjKp2M8X-CZ3CwEX7vV1H-j8rUtZLU=hTHy2ARMKnkYimw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: eliminate duplicate runtime section
 definitions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 5 Apr 2024 at 11:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The following symbols are defined in two includes:
>
> * __efi_runtime_start[]
> * __efi_runtime_stop[]
> * __efi_runtime_rel_start[]
> * __efi_runtime_rel_stop[]
>
> Eliminate the definitions in efi_loader.h.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h        | 3 ---
>  lib/efi_loader/efi_memory.c | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 7daca0afba..bb51c02817 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -345,9 +345,6 @@ extern const efi_guid_t smbios3_guid;
>  extern const efi_guid_t efi_guid_text_input_protocol;
>  extern const efi_guid_t efi_guid_text_output_protocol;
>
> -extern char __efi_runtime_start[], __efi_runtime_stop[];
> -extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> -
>  /**
>   * struct efi_open_protocol_info_item - open protocol info item
>   *
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index edfad2d95a..81f5f98a8a 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -15,6 +15,7 @@
>  #include <watchdog.h>
>  #include <asm/cache.h>
>  #include <asm/global_data.h>
> +#include <asm/sections.h>
>  #include <linux/list_sort.h>
>  #include <linux/sizes.h>
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
