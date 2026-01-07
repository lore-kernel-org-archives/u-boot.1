Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2887ECF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 02:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F8183FF9;
	Wed,  7 Jan 2026 03:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lc6ZB5lG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACE48400F; Wed,  7 Jan 2026 03:37:04 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0225183C6E
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 03:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so3021243a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767753421; x=1768358221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NhhHAFzawZqHJmAFtzZQyn2dqpZKllz75rnqLuhTGtM=;
 b=Lc6ZB5lGvKIH8PmiSARWJtAIyobWqZAv9Lt6ytv8eyjs3frtcTgVZgIPP7PJa0RBVz
 Dgn60T476MNq2PGUDtvUIRvHPPaSv3kVCUfr+C0u9fGB0he81tfvDGzKskfNWEQswhst
 6B7ABXhe9K4gLjcS3jSD09vE6ssjgtU6UaKO1x2bLq0e0BAREoQcyoIGv3kcg99AedCk
 z4VPmCzKvCjKGDVoFUzozgG5IYR09uRvBiWa6VybmINlhOZ7wa3z2HS1/rKXtL5wuJ75
 VqLSUMm3YguGnmop+tG94BsuLczBCY/7j+X34DTngMKv0dCCqGu4bProMr0MkYVkem+4
 WGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753421; x=1768358221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhhHAFzawZqHJmAFtzZQyn2dqpZKllz75rnqLuhTGtM=;
 b=KQb0GbYsCwwQLQDVpzH9CI8AaccKnDEvY0cjRx7C3Q2RVnwV2qdZ64uBsfGh/33uWW
 0Mt66Y/fba2qOXZ7vGZfUDAIxQ0KFK8ge6YRsQ7QS5NWDrk7EedV1ey/tCqPiPwvKTNZ
 /ovbiQkA69NCLLdLhD/SfX37AukMGzUuNhsJKeyxJpPDL2igIDpiunQ+JZeDkl3wTV8K
 5ODVn0wucMnukHUHQh+BniGmAs+wVujRelR84yiGI2qFStkoaga3lZAGH/LWAbtS6Ngh
 bC6PeBgL0TcJXLxWz6BFwvVHb3tS0OMTwNzJC5iZrN7jJJwwN8x3YdEV/CRfHF7pztwG
 tHOA==
X-Gm-Message-State: AOJu0Yw9tK1JH1w6aSTLqdIPoPm+KEXDJ33Er+2PQl6bQzGK0Tj6j1c3
 OwryVlN4HZDzJWW0Q75NFB8TMDxojMBzYV945A7O9rx7ZtdRdsL8v+apgb5LQMG84k2JimRd9IU
 YpfdtmkeZImRE1O/hsSCVCx359oO5BRk=
X-Gm-Gg: AY/fxX61ouWDiYQrEiht99dbVWGSZ+00egUi3QwHdKIsVavmuOX2HrbDZbuhnwdvQp3
 q0mQxHJeDd+dm1+Xuw6mivwMh4t7FNicD0BASFLBgQ62ZQwIFTZDqebMNACzFWgdgMprMTTrWpd
 nx8lRynGtRdksCXVrhcZO/xchNMw1inrWnRs3PBl+C6yLdHIv04k1uY8q+Mmaa2hEHOrlz+r+ci
 dOEOdJRr5yPqGUXUTwyvTPCIsZE4ITJRUHuyjme9IToY9enzLGp+RSSz8jhXlrt4xw1QkiAcNBR
 9IEr2v4YE8glfmUU68KPxV3//nDG8lMraMK1XZSx9ZRcd0MRRIfXi+rANjvpUXPU7XTOd5XRMDw
 X/sxr5HBiYs0dcmUjUzCwV8qh2i+4Ygq7Fl0P
X-Google-Smtp-Source: AGHT+IHS6oNFasOQEAgXxrEil3cvWjSkzHjeM1K3PT0zAWm7ZEsG+9qWIeYY2nVb8d8fENiDqzI52TVaGRXKM6duefE=
X-Received: by 2002:a05:6402:3593:b0:649:79a8:8b4f with SMTP id
 4fb4d7f45d1cf-65097df5bf5mr919526a12.11.1767753420974; Tue, 06 Jan 2026
 18:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-11-simon.glass@canonical.com>
In-Reply-To: <20260107003131.3064800-11-simon.glass@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Jan 2026 02:36:49 +0000
X-Gm-Features: AQt7F2prXy-7sU61NgM6-PPUQHXHh4i65l450X6AvhyAgums1MY56TArkCkqljg
Message-ID: <CALeDE9OzMUm4PjymcOs_iAWWwoN+BSi+gDHXq4JvmCsB_YM5vA@mail.gmail.com>
Subject: Re: [PATCH 10/10] x86: Add cleanup_before_linux()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Bin Meng <bmeng.cn@gmail.com>
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

On Wed, 7 Jan 2026 at 00:40, Simon Glass <sjg@chromium.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> This function is not present on x86, but there is an x86-specific
> version which is never called. Add the former, making it call the
> latter.

If the later is never called up until now why is it actually needed,
if it's not been missed until now why not just drop it? Please
describe why in the commit.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>
>  arch/x86/cpu/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
> index c373b14df30..f756a9ebf09 100644
> --- a/arch/x86/cpu/cpu.c
> +++ b/arch/x86/cpu/cpu.c
> @@ -80,6 +80,11 @@ int __weak x86_cleanup_before_linux(void)
>         return 0;
>  }
>
> +int cleanup_before_linux(void)
> +{
> +       return x86_cleanup_before_linux();
> +}
> +
>  int x86_init_cache(void)
>  {
>         enable_caches();
> --
> 2.43.0
>
