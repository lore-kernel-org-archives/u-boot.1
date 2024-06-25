Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E46C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC618841D;
	Tue, 25 Jun 2024 10:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QofF/J7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCB6884A4; Tue, 25 Jun 2024 10:24:12 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF83F87C40
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 10:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso40768705ad.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719303848; x=1719908648; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3uS6/qeT9Yug9fHtxkveiEwIOEavMsMKzJl8srybIJQ=;
 b=QofF/J7eO2ZHbxn+1R9eFvn1zWLHE5rTrOVE8UqEd5WYA+f16dIZZ3EAW4XuZEvA9E
 Rk2NUjV49V4QpawyniRwy/F8VtBqeUyS1xyPqOetZ/BimsAx9ebDTOjvDSFpWYxF/271
 JNQgmEEDUNxVWWCj8bbKE/7gk8+yMjAwhTuNTbb0bx06LK/AmIJneMkdh2ICFZ/qNtDm
 yB2+G+sADBDngqmEE7mIy/ldeLhgf6fP596lFDC/lqjNvt3PrNGuy+QBRCUBByzvpOxi
 cc3xsxwz4HqmvjYr+DMiVnYS8b8qFftwHx/Cm8b7RTGn/soupw74U43vzGXjoP+WxDEh
 LuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719303848; x=1719908648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uS6/qeT9Yug9fHtxkveiEwIOEavMsMKzJl8srybIJQ=;
 b=qSAXYehdFfuQ7abEaxVGksuBYTqpK20kyruwolsNjMWGTKVl4hrACQd4JeTfIBBtEp
 manzPehw0KWIQw1+mKz8Qr3NPazaZiOh0+tbJLxSTexdR1yNpVlcRaP3Tax1IGPukgc0
 vWLYsMEEJLLbojVbDhFILDqbYizlHA+m9S1kmn6nBAMgvSV27sa6KwQvDtHT0Ceok75+
 VUjVk9Bno/jn+9ylcvN0yB+qqKHOfgg3xVO7OyDelL6v6vNOWLUy96nmPb3wnda3YVbi
 cELmm040Rpib7R3iZBJ+Hmq1bI9kyuxGrUyMfb065U84LAIK8j4bcXfCn2EIr6t8dvqU
 94aA==
X-Gm-Message-State: AOJu0YwTrBBc0XwrwmPYnDUSsogfKUDkz3DamYmNM5rpGke88swLR3gO
 omaO0JCq8ltV56BoQGG/TWMfqXNLUaGe7rD0RauQeCnGOYxNrdzVWjHnG4B68VCUUTY27OjYABy
 tKz5b92ZtYV3/rFNqPwZqAQ5W5ThxRurxljOvdQ==
X-Google-Smtp-Source: AGHT+IGYiwtTnXzijR9dIh3Ig/aGKQE3VzDKlJOnTJIcPBxUfif3ajoQcr6fyWWVqJoek4AGeft49QAJjmnAlVkzNdg=
X-Received: by 2002:a17:90b:4c8f:b0:2c2:d468:76df with SMTP id
 98e67ed59e1d1-2c858291902mr6361768a91.31.1719303848004; Tue, 25 Jun 2024
 01:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212759.3456158-1-trini@konsulko.com>
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 25 Jun 2024 11:23:31 +0300
Message-ID: <CAC_iWjL51Byep07TLLkjjGWndw11d5xtmFvtxo7ixDGY+uTzDA@mail.gmail.com>
Subject: Re: [PATCH 1/7] m68k: Implement a default flush_dcache_all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>
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
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  arch/m68k/lib/cache.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> index de04124404cf..dab834c1cbd8 100644
> --- a/arch/m68k/lib/cache.c
> +++ b/arch/m68k/lib/cache.c
> @@ -134,6 +134,15 @@ void dcache_invalid(void)
>  #endif
>  }
>
> +/*
> + * Default implementation:
> + * do a range flush for the entire range
> + */
> +__weak void flush_dcache_all(void)
> +{
> +       flush_dcache_range(0, ~0);
> +}
> +
>  __weak void invalidate_dcache_range(unsigned long start, unsigned long stop)
>  {
>         /* An empty stub, real implementation should be in platform code */
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
