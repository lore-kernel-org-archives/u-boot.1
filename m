Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D22F8A149
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBF0841C2;
	Thu, 16 Apr 2026 10:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yMky+U+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7788420C; Thu, 16 Apr 2026 10:55:58 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243B5840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-649278a69c5so6434185d50.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776329755; cv=none;
 d=google.com; s=arc-20240605;
 b=hEg76SexhYJqFBppVaEPgCEUTgblz5J53K4nF4PWbvQyCnpFugt0QH3tuUHtPxD5TL
 rPLsYmTLKHviiKdIIvGuEZKSmF/gpPc8wqTeK0plavwKg8MvAVzsDu4ub69B1haNu/tj
 7dS8vYloE+/aUUBv6MwDtsaa2alfQ9Gr2anPjo3WYqeJ1jv7Ua/j3EbKJ9MiFMRWGQOj
 Owc85kQYcbcuKYa89d/3u8ssisDMaEobOMMn1454o6tcid4tgsga3KmE2o3azZVi6keE
 J4rJClsdqL9LE4Ly3bWZ23eJlgICCsoiSIaVyhn+KOhHfirMBlcZst/Y/rIXHCEo2Lf1
 wExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M3CGRBU9wO/Jaxr6dHrIQbKMW1koZ4MxFTdS2S84ByY=;
 fh=S0jZpfVGHvp6D8zdtandUQUF49zSvd4oAp/tKFFs02g=;
 b=VhFdg9H/Kxs7RaYokKfJFThIUZO7dSei4p0AdFUwKidtlKCrtdIpoz2sJ74HG9QsdP
 xRBPLZeYa6NYMgLYwViPKdhJMskGNLpGAiQdXg8DH7Htagdzx1E04SQJ8BjTpvJtexxk
 1h0zPqpqQNVrRY2D2Fj4NkR80WBXN1DseAeL2txVQ10n7O+BhcCfjfpCe2x7KAbvQ/Tt
 BfrOnGkqbuELNEttb1CotlLnZqm2UkyZdvQ5wwew7azBNpXfbfGvfu+16jmwEuCgYHU0
 MD5PzgImiNOXcxhlHDPfTpoPjqvAdbRj38XqoYOMm5y265wN/S7awJCky3jdfLo3UZ1k
 YGLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776329755; x=1776934555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M3CGRBU9wO/Jaxr6dHrIQbKMW1koZ4MxFTdS2S84ByY=;
 b=yMky+U+le+Xy2G7jjkyV9/LYQCtZst6sq46IECEmzCRtYL+ezKT7DF3wKbi/xwCecZ
 rtuzC1APEM/tycZgGzVgNzQn9J7NPeD1ftMinBlBt9hAq94QJzVslo7/5KH25cYG0mEP
 EFvEM0H2zl8N+P1TOP3Zyr4u7goz6HQYHxR4v6Ef11eRG+0DBege0pry8Dy70Tuv77RG
 Ls+SW8YVQuzZARyBVvbaCSIPBkvIGvi8eCkDqNQ1ipqw7KBEHspu4smN+t2SD0EbypOL
 Xnix55aMmKIyrJcDaMayRVUYiDJbhYTic1elLI8ofKtiPiwI8Dyz9F4g5GHLOrQgSmPW
 GBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329755; x=1776934555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3CGRBU9wO/Jaxr6dHrIQbKMW1koZ4MxFTdS2S84ByY=;
 b=VWdJ7JY22ZLb7PLwCl9GrQt3f4Qo0+1mC84mIVI2VVbEFigVX+Hpyl2pX74jtNtk7V
 +ncQfeptlgk+1aVvxLdi20tqO+/fmEob1SlFGmNDEiID1/z/nFF+54C+btbL3BA6oHqH
 EvtgHcTwDnkX48HmFG2h6847eZ9NzdXN9xx7s/lnJCrd6ny6Eo+aWQ1beiJ7gh6hyQ/F
 rY0BCWT0n85AkoWFiCYHuz43akFBUpXjOmyBj12xEnbQgxz9yzuOVivLto+8dohMoU9i
 bRG95qPaVDQsYdt+TIMf9cQkKYc+Woede5MzaMpezzMeakKcnhR5pnDBvutXbzzbLJej
 AoiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HkaxpyQHz9a0qYX3w9t+L9n+nqEGvYgzivgQOXtMwCkZywGAuSznhLx88BMYUBvr3mi7jT8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwBiBk+D4BSOVT2inTWDGHYVBMjNZHultCr0gcw8unEalCiUTqh
 dra0AsP5I1YFyCyd/SHWTogmCwcH9M5OfNl4Aot3WTB6EDZgzl7zTK4KPH/NUZbIsXEn652Dsiq
 KiCv4O+G5imbrsqnjKI6S6zM3T4H7ima0Ab3TODjc5w==
X-Gm-Gg: AeBDietS2/KyFOnMag/NTkYzYsAGmwlGl37bN7klDYrtgf4QvvYi3l8ukyaPi5LcNDw
 0DDcEI7R8ijCMU0vHJ24c33EQF5gmkvj7wVaCExl+Up0d3ZRrgR8TZiphdxlGiNMvJSYRh8ERFY
 Y6sA0N+c2J4WKySkAhQHRwA+1dRHcBZfZgE4fi/fQvMWvEEw2AzenqJb8rFfTzd1MzsTVcY3MQl
 /mmJMidzER6V4NVIP+i5T71IwcenFCQM2B/+MJzQzNO5TWki61EQwc6LPEanTGE2E8QgH/PraMI
 4dui5CmBczoVHX3fbSxIifzjD0++SMVl8n4FWN6yClAIfrItwop5DxQ1KjaoCJH7LRxBhMXl5hF
 h6Jvb7e+03mhlg146KYF7GWgY0j/X85oGuysSGKy5GcYMv64tihjtKf9+YXTU3+gtwIsF4VLSgl
 dkGvataTaQ/9ijg+bjhIprpQyZ6qVBECEP/DPniGPp/uCJSJF62IGsYL8hjdtXYm57tbveIP7Ou
 RnxlpmhCrZf0XDyZBLhz+KugpKaB/IE+ofWkDW1ZGplUPSQcO4N0L6Rxq1L+ky6NV3FX23qdCQG
 57hiPSe4FZnSxAO8fb5cg7s70Ahn64C8EFfasIsOh/v2
X-Received: by 2002:a05:690e:4450:b0:64c:f4ff:607c with SMTP id
 956f58d0204a3-65198bd57e3mr16504366d50.33.1776329754881; Thu, 16 Apr 2026
 01:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
In-Reply-To: <20260413203555.1990337-5-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 11:55:18 +0300
X-Gm-Features: AQROBzCD5ZVpwgXzIOXdR-OpNS5GgZX8H5qFauFp2s0xgxP4fJpzj1ZwpUfoQag
Message-ID: <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Check for duplicate memory mappings before reporting any incorrect
> attributes. Could be that second allocation has the correct type while
> the first doesn't. Knowing there is a duplicate in this scenario is
> more helpful than just reporting the first mismatch.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>

[...]

>                         }
> -                       found = true;
> -                       if (memory_type != entry->type) {
> -                               efi_st_error
> -                                       ("Wrong memory type %d, expected %d\n",
> -                                        entry->type, memory_type);
> -                               return EFI_ST_FAILURE;
> -                       }
> +                       match = entry;
>                 }
>         }
> -       if (!found) {
> +       if (!match) {
>                 efi_st_error("Missing memory map entry\n");
>                 return EFI_ST_FAILURE;
>         }
> +       if (memory_type != match->type) {
> +               efi_st_error("Wrong memory type %d, expected %d\n", match->type,
> +                            memory_type);
> +               return EFI_ST_FAILURE;

This check is now outside the loop and only checks for the last entry.
If you wan't to split the fucntionality, don't we need a loop over all
memory areas and the type?

Thanks
/Ilias


> +       }
>         return EFI_ST_SUCCESS;
>  }
>
> --
> 2.53.0
>
