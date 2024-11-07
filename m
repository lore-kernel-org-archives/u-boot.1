Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B8D5AE7C
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456DC8923D;
	Thu,  7 Nov 2024 10:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yrhiXxXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E247589242; Thu,  7 Nov 2024 10:54:43 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6448D89032
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so633452a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973280; x=1731578080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7V1Tg3Rjb3U25yrrX/cNzHOa9cMdZSVZ1djd5F4kvhM=;
 b=yrhiXxXtbu9aTBvkqFxrTQY168rzlsQjGtmz2FFJwLXS0yD633gdUTjM2rTqQ3Ot50
 g/mWqqiMBLvjXWcx73KeE9GtzxhDICM6rLT0yQolRcJ6NHW67P4inkZ6TBeZ4KmDrB+3
 9K0c+FyZzGPoEAGyWhzs0AUgSx31/7KYS/adp50mkphSeIALbcPybO/0Y7yUSIfKxUXe
 JdDese5TzCYwaKH06vD/wcucOmNJDhjWBSFcL+xD5K6dmhNktJ2bXF0pNA5gNMtABsQd
 O0aB7gJ30pKVaKyOglbkuCQE9whQo7XZVoD6HRB5B9UxdWW/F1LWcXsaQ5RntGWWjHv0
 UKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973280; x=1731578080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7V1Tg3Rjb3U25yrrX/cNzHOa9cMdZSVZ1djd5F4kvhM=;
 b=GYYiX7PHsB1JWp3XmYxkzhtAw7ZI5MUCw4jo4t+NPcUcXf/k76V/Cjx7oHqU3Gp5aN
 +3hAAFxjifHw5GGONVlxJ27+2kKURXQKKh0DHk0hRNOczRF83MY/JWmwzVN5zI/j7/vu
 Kxhwk9iMnnUrI5vGeE9Ih9g5cg8A0khPXE741V9FVNVh77ly+JbO+sxpWFzfpcJpyYA2
 v7s0sOi2wGDasuiAEJsAfQjFGEIfG1Gt/4iCVDLJqiBENDbr/2HpepCIQj4THNeog9YE
 fQ4rAa4lJjirs/4TRc2OVCVEoOyrXcyhfNQn7JDuCYFz9Mz+zin3/e0cSlKCS3wiGO4s
 2U8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnxIt2tP9AJPZngoBh4v3QuV/UVdLDsQ5SG+tMmz4pEOQlBaRAFxIt7jswO5/XJu4OnlGxblE=@lists.denx.de
X-Gm-Message-State: AOJu0YyTBGOwoukzZ0A7VAl8vB5xrxhnJLPotthkkqU6HLa9f/A1Fm1v
 syQPFXPOR7UQCixe8zDtqnGIs5CCCi1Z8bLzGN6UxTauP+i/bEjbjv+rhM0HNC7AwdfIyGR3xTd
 xyicIRptnBnk7LSg1lmSGgemgGcEcfXhIQ+Lizg==
X-Google-Smtp-Source: AGHT+IFiXgf1ExxXYiraqpeqgOtWWY6XHH6oXdDjOOgc3phazq7YwDyTuNVTD8ff+AFqRU0Lsh+RybApLJgsHPMwrV4=
X-Received: by 2002:a17:90b:53c6:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e94c29a338mr34263195a91.1.1730973279912; Thu, 07 Nov 2024
 01:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20241102102546.107412-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102102546.107412-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:54:03 +0000
Message-ID: <CAC_iWj+3Scbn3RUMa4NY63ZzKC=gEQWn5A_HOMnqq5w_A53nzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add lib/tpm* to TPM DRIVERS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sat, 2 Nov 2024 at 10:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> All TPM code should be maintained.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df046192ea0..ff115970103 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1690,6 +1690,7 @@ T:        git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
>  F:     cmd/tpm*
>  F:     drivers/tpm/
>  F:     include/tpm*
> +F:     lib/tpm*
>
>  TQ GROUP
>  #M:    Martin Krause <martin.krause@tq-systems.de>
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
