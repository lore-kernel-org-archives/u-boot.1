Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C5C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 09:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA68B8844C;
	Tue, 25 Jun 2024 11:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kOZO1551";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C40EF8824C; Tue, 25 Jun 2024 11:57:45 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949A6878F7
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 11:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-71871d5e087so2420742a12.1
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719309462; x=1719914262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qr80PiR2AiTSTsRtFtX0jcdPIx1QCwMzqV/WyJORHPU=;
 b=kOZO1551NA3Ejsw37fHET6liYi6RyeC0RR8DKG97Xu95xHBrqFDW+NR5D7F2JSvqfg
 3z9SNbbhnlesn+8nfkv3zck6VMJY4UAE+Zi3Z1i+ViTuKOYQYFUcDCo0C84/3tMjegfG
 hRahW50GfHF7zQlz70cqRDzfppBnwPJrXp+wdKaSkmxRhd7mBdGxpRh/gRlHvbNRiy8t
 qX/UA8aSsrmYuHEfScXnA2gveLESD8fk0tEZXOw2Eiz9DtVqv2uVeYCJ2uBfc69O9PQh
 MV9JFLIlyF7AW2Hdjvq0WRrfX5njh3Jt4hQ7S7DcF1JB3U3+pIsijk3mFGxnlEHnevJv
 oy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719309462; x=1719914262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qr80PiR2AiTSTsRtFtX0jcdPIx1QCwMzqV/WyJORHPU=;
 b=Tq5haVCBkJRTuO1SkHc6b3MesXIbM2spI8vlDh4Ab7r02qt4ICPlFdYa/usDzOhawG
 +rtavpT2EXYdoeHx1rV7nnksbevRy5Y6jptYrd9ppiGidvIL07aQ1bISzWsJq07fqGcG
 e1UCG3Y3euZVUx6vgtgTpkBkJGobXv+qXp4QWehflBCu8FG1xSicJPOWNsMoSSksbBfK
 R813V3XHOnXjZxppoP6311V1cbosL8yN+IAkNeRYpHyEtqBQhaCZrm9S5Ey1RYvCY5UD
 4svWc24zgDuzdJCoY7wZSyJYcGEXatepU9v9c9ipQMu7fsM+hPQKzZj1Xq/36kxxTubC
 SqYg==
X-Gm-Message-State: AOJu0YwUGed2Ru/LqgM5vZiknkK+rhcjiGyVfKEgJOi7MNQjCD/MZMCR
 ohCiABY6J08n04SvVA6nfpPQIU4/27SpkgbVfu/HQoz5XpghayV9ETSmWuLUm+4nYHuqaVW3TUb
 rgvYQ+76oOy9RqUxlNo3Cg3cjnAus16dcie5aTsqcJLxzvVFKnWzy5w==
X-Google-Smtp-Source: AGHT+IFI6gPfvW57kKanFw15DGRs78Hrw6C7FtQXzYksuk/o7av1Zv2mk7g8gW3s8U8mnK1RBzJRBYpcE72j1O8yX5w=
X-Received: by 2002:a05:6a20:8420:b0:1bc:e5b4:8972 with SMTP id
 adf61e73a8af0-1bcf44391e5mr10435185637.12.1719309461954; Tue, 25 Jun 2024
 02:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-5-trini@konsulko.com>
In-Reply-To: <20240619212759.3456158-5-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 25 Jun 2024 12:57:05 +0300
Message-ID: <CAC_iWjL1Dux3yD3QsB1BQBPoBLaqHwMPpTpjebY44_MLC0k6pA@mail.gmail.com>
Subject: Re: [PATCH 5/7] powerpc: Implement a default flush_dcache_all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 20 Jun 2024 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> Implement a weak default version of flush_dcache_all which is based on
> the ARM default, which is to flush the entire range via
> flush_dcache_range(...).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/powerpc/lib/cache.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
> index e480b2696494..130318d745aa 100644
> --- a/arch/powerpc/lib/cache.c
> +++ b/arch/powerpc/lib/cache.c
> @@ -43,3 +43,12 @@ void flush_cache(ulong start_addr, ulong size)
>         /* flush prefetch queue */
>         asm volatile("isync" : : : "memory");
>  }
> +
> +/*
> + * Default implementation:
> + * do a range flush for the entire range
> + */
> +void flush_dcache_all(void)
> +{
> +       flush_dcache_range(0, ~0);
> +}
> --
> 2.34.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
