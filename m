Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDFC83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 12:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2812D8304D;
	Tue,  8 Jul 2025 14:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2YTCHlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03868305C; Tue,  8 Jul 2025 14:32:50 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1664983018
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 14:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4a585dc5f4aso54229261cf.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751977967; x=1752582767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DlrJisb1i5krUtUWHgEGAul+ft2VsOWAhAWnSkgovo0=;
 b=U2YTCHlQnjTEoZnm1CfZMCgszCEBeWwfANEhhDA6LQzSFHxekdb5X0aj8HNU+C/1zN
 RAZ8nHWxtDq6kZ0jQh3xjp6OEtWUMzxNKl65nfarW1me6FtpKiE4SR9w5v2XEn3KVXCi
 VdRYNDbwyxQE8m0dh5pQQygI2qXTlfMpEFbwjCtCD0mSevt3x36+kBkgvbmjNMpf7dZl
 RJMfiUWGoBoFWsNtmst3VvdbX+R3gTTVrZi830ljIGw2IcvkCnfWdyuPE7lgOUmHszcP
 PA+RanPGHYPkf20UKWV2epGGeXcAfmUKSahAsJVtWld28aVCCuxQmvYNAUchy5/KEmYZ
 OjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751977967; x=1752582767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlrJisb1i5krUtUWHgEGAul+ft2VsOWAhAWnSkgovo0=;
 b=sdLypiCRLTVVUgS84WDaTWTWaBEtzMcLpHE7+48zaR1TrrdsF1Y+4yECCKh6u3jxmK
 ewh2buqljQ/tbFnVbjTrsYvxlvUD7ef5ehV02PogGQOZT7IW7424pxJOc7WdbpKlwaay
 kXxgjtUdwxM5djbUx6dNEz0WVta8VsRtOftibSUYjI8XYk/OD8KIMlqFPUU4aaivlkuN
 2l0sjGRW12V/YodnNdhGxb8OxPIF9geYFuBuZUHjLUJh9wlLO5QLFT70pps3wjv6/JBN
 kEuByNf+dzxw0kkfo+s4Jui6u7ygX3ADyw9yNFi9BYYMJckh83wn6h4j9YflHflPx2Ra
 vkvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoBqx+7VNexLrMnWvcE6RejCDJ5fr7FZrYL6gMtBjU4hzj8tturumTriG6kwcHomr1BuXX0qo=@lists.denx.de
X-Gm-Message-State: AOJu0YwROy9jRNwZk5psg9bS4U8VozzeWrq5p5o6mVPl85L6fpySUa8Z
 7zDzFM7FVYtQGnbKN/VFLX40zzn3CjGXW5HwBJn4TF9q3CkI4zHHlLxLkzlIPGJrfeE3CG+eDOS
 /5l6yCeKh6o83VR2ksjTFYa7v7dS5igPbzaP2OyeqAg==
X-Gm-Gg: ASbGncuEe8Lp42iv6TTqM5iczzDxWcnwwA90Hmu+1E4foMNL0fSxkVM/G/InDIOqzpj
 JhAdBCXg8ctGkqCdfT2NTE40PzlnI8r8CZV4lj18cQHST7ldTV9RtUJ8EBn3m/3+a6B8fVFs4ph
 fN9s+CpFcUfj/4s8tNQGeFm8W5BaWRj+UeUiMHvcvfD8ZsH+zLA0Am750=
X-Google-Smtp-Source: AGHT+IH5HhZITR+lcJDhAGWoLmsR189yjQkc7vp1FWIPR/wueoPhlP+ab7r0SSmUrEbS304qUvOMIvnnQ/Xgu1y8YWw=
X-Received: by 2002:ac8:5796:0:b0:494:a235:fcbb with SMTP id
 d75a77b69052e-4a9ccc07f14mr50590701cf.29.1751977966185; Tue, 08 Jul 2025
 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 8 Jul 2025 18:02:34 +0530
X-Gm-Features: Ac12FXwssNXB1R7Zn5nwbw-ZVeiCuwXIeCH-NV6eFr-oi3HI538ifolUKaDe76g
Message-ID: <CADg8p96hiG7Tewhgz6eZH0yMnMVRS1CbR=dxx_kX4E2mtiuNjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: add missing fallthrough in lmb_alloc_mem()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
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

On Tue, 8 Jul 2025 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fallthrough to clarify the intent.
>
> Addresses-Coverity-ID: CID 569481: Control flow issues (MISSING_BREAK)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lmb.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 45b26512a5b..e5a0677e3f9 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -762,6 +762,7 @@ int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
>         switch (type) {
>         case LMB_MEM_ALLOC_ANY:
>                 *addr = LMB_ALLOC_ANYWHERE;
> +               fallthrough;
>         case LMB_MEM_ALLOC_MAX:
>                 ret = _lmb_alloc_base(size, align, addr, flags);
>                 break;
> --
> 2.48.1
>
