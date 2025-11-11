Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5853CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 09:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CE083F56;
	Tue, 11 Nov 2025 10:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mNT50OcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462A683F5C; Tue, 11 Nov 2025 10:07:53 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E73483F24
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-63e2cc1ac4aso3520134d50.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762852068; x=1763456868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cM4CIPegjHoD0egcJW2HV4eGwp1Lv52MX12wwecewow=;
 b=mNT50OcOOka8ewxxG+hs5EXIXjWEXWtaz18Krt2bIMvfvNlMfNJPZtaKZrivwWEyPY
 p7YIXKFjS//2bxuj1XRn4FRHD/qdfa4g1QTeAU9taqqMYbQxDt+GLLE7ziOUjCrMF1+2
 +rSuEJxhQZ1tlqmT14IyjPMNPE2TDNNEJ9qJp6LI7tBpPs0A54zM4mz2H8NyCPMESN5d
 L4pRF92aRMvxIZYdXwCSpfcA/vuhrZDS+95qfgos3KOBh3NS+Fgfxv62ycqklc8lU7Y1
 j/UuyKEdM9ucGOw015BjC1coBshFE9h12KFE6iKBB9O0cA943z2eVQK+rDxJ5yqtOyem
 Fl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762852068; x=1763456868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM4CIPegjHoD0egcJW2HV4eGwp1Lv52MX12wwecewow=;
 b=jbAbGfGT/q2yYF1aSvt7OQyodT53nzPz71vj3ntE+Yv0BMDWWC2OEtsdV25wyjLFFo
 XgJzGOajfTep47zxamd752J+HgF1PZzb/QzydRwkj5fyzqnOmS4VWFgDvCfPmhAP07mZ
 F8JOxlqesSpDzCDgCQbK3UpGewKKuI7vl1J2PTB5T5/dVPGleg/Sb0U6YO/PaW4wAuxD
 +AYmxpjZ/b/+k416ZVFweqazJh8UURjyAKNSojXzYggwIKGHVX0ok1wBk3W+A4LZhPsK
 9wxXu2Pq66nDESDbcR/31m+SP9t78d3dFybNG0aH3/OpNT2TKDhVIR3j3M0+FtTCbFZq
 8img==
X-Gm-Message-State: AOJu0YwFs3phibH7/OAB8s9uPW5XCDgJRAdurFD3ZO09jmh8Fj3M6iXE
 ngdVEwLsKMoMy+tkBgsSEnDEgIf9ulrJSemmF9pQpWqOO1dNTdMarf8QF2+Xwww9KgayLs2XuVc
 SyVSG9JwO9CLgGq2WzptCn009+k8k8lXe+3+ijBMcgvGRG3tRAtTGit0=
X-Gm-Gg: ASbGncvsc7KxRtkpYJt9qbgOVofvarYOswzjOtGKQfFFg+r8Xz5pgyCzHBAX1Vn6EjP
 0Y+vl5uylItoNTZHc/eSTjXVxi9IkuuhbxVQfoaGBxO/54dkcDwbD1WfsXO2COFxNlwfR8IbMSz
 5zKcWf24DuFPEZYJ6t3amXoNWX6T7hf/6by0MNrCJaJ05zZdS4U5NUGMA15W93aff1f45HttCYw
 WWo19F80gii0l/bUP8s+X/PnYxKqAXSPhPYOdHmTAiigJuwFYxnoGuql0Hmynu2b1aaVLfLf2UX
 kOcB0fU2W0ps7H+5Jqom8mDgh2tXoaSvfL0l6t6S
X-Google-Smtp-Source: AGHT+IGeN6T7jQxkGjAxgXWMqFhIv8Ouh9KK3hK0DeRUid9vUsrEaCdhjhw+89y2cISbGXcZjsK5uNsKBpHZBwxxeXc=
X-Received: by 2002:a05:690e:4369:b0:640:d3aa:74e2 with SMTP id
 956f58d0204a3-640d45af5d2mr6543532d50.39.1762852068402; Tue, 11 Nov 2025
 01:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-2-hs@nabladev.com>
In-Reply-To: <20251111054813.1966-2-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 11:07:11 +0200
X-Gm-Features: AWmQ_bm1pVFnwPthiJbJrH02cni4m5hc73YcTqBjdpYyrTeN-4msjiCO_c-ZOVE
Message-ID: <CAC_iWj+vz2qx5ghn2YgBuCPUBgdj_DdWsBQ9fqnsVi2YBYYaDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lib: Import rol32 function from Linux
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, 11 Nov 2025 at 07:48, Heiko Schocher <hs@nabladev.com> wrote:
>
> sm3 crypto algorithm uses rol32 function from linux, so
> import it. Linux base was:
>
> commit ca91b9500108:("Merge tag 'v6.15-rc4-ksmbd-server-fixes' of git://git.samba.org/ksmbd")
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> Changes in v2:
> rebase to
> 6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh")
> add Ilias to Series-cc
>
>  include/linux/bitops.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index f826d7f3b34..29e0da48de8 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -148,6 +148,17 @@ static inline unsigned long hweight_long(unsigned long w)
>         return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
>  }
>
> +/**
> + * rol32 - rotate a 32-bit value left
> + * @word: value to rotate
> + * @shift: bits to roll
> + */
> +
> +static inline __u32 rol32(__u32 word, unsigned int shift)
> +{
> +       return (word << (shift & 31)) | (word >> ((-shift) & 31));
> +}
> +
>  #include <asm/bitops.h>
>
>  /* linux/include/asm-generic/bitops/non-atomic.h */
> --
> 2.20.1
>
