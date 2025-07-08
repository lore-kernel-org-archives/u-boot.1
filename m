Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10290C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 12:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFFE8305C;
	Tue,  8 Jul 2025 14:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zc8b/mK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5988683123; Tue,  8 Jul 2025 14:50:03 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1691B8304D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 14:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e77831d68so37504917b3.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751979000; x=1752583800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ev9dJ1NuMaGR7PeGXADfn38M9TEX7EIMRGmSbiQ8t0k=;
 b=zc8b/mK+L+wvreUcdhfk8lS2cZ19aC/O4h8Eg5xQjkEoc0YnLDpghA9E/qUKsLGxG6
 Ad7HEBGxqoQiZ6NkIyT1kAlsPWS/687104QDR0PkPUjuJa/OJD6+nqOmPr+6EcYv1sLO
 wymADRC8aZH5rDCC6/S4Mz/MfSJrH+cGYFS8Mh6T6kmw/RavlWf16xZXN1Y5Kmp2rHws
 fs4BVjrLsp+jrwRjfGMk7X4fta8gfQTpLTbT+ZsCfpaHCuafuKLy2owjNj0HQqRpZd1h
 y8kS0yrWMSA0bf9VA/Aw+zH3Bdkzl5btSj8NLWjmBaoEZa5bG5y08Mcl/alP7u2BG0go
 RC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751979000; x=1752583800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ev9dJ1NuMaGR7PeGXADfn38M9TEX7EIMRGmSbiQ8t0k=;
 b=GAu5Mhc7XhTUO4cgM7yNQkmDn5wwunyqpad8flGErqDTFFZpzxOmlJvdxY/ebiKY9n
 zzsbApJPM1Nm9pofZ1cOgpQxf1rcb3aE8hqSxGy3Ym0DygrLxvNQIYeGutevgQWV8WJy
 GtIUs4UlKNvbk8XAG4jFSlYmDZgX0RTTKyApa5ija8SO+khFLITxL1YC1c2Vo8y3VzNd
 wb33yVNwtjJCGS5No6ebieVwdS+fmzEQlfzRcSZS1Tfq4JCFUFeLrVIMQ6/A3dIq/b1w
 64md2hLU9G7rhjmQLexgV9+srg1bvv+/S3X35tRLA+KSCYjq82XYI1NfDBS9alQATD6T
 HRzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSzEpEz0aLi3uCtEEQEEQzQ+GfHFyWW+L8VIWkJng0xxrbOgPosyzjiooM8njbgk+N3gIpmhI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpWkwJMW9YmU2ACzg16wF9aMBdFr2gUqUpDSNbbFQT3atduGld
 rOadTbzYoHN0G+m0vneBH5v3eqfpDvK3BcO1PLDjsRl3cmn1FJtNs07ly59/iVOEdlvpPUuzulN
 VxIoygSRJ8BPFaVjDHzl/sPt9wQvZjnEHBYoli+/meA==
X-Gm-Gg: ASbGnctajtZYm0GTGgqsiIRFwxumGR1AK5ACoiHrpcicjN2NFvqC/7nq5JbRnquJg16
 63XDqSUs0pxHS+ySQfLgRqH5zp3Ne0OdLtM8xLOMd4it3bdAggHLESasqGqG21M6TFPKM2oEwJf
 z03sdQWhb+3buMyKXJEcz4qU8KyKfV1BodxcMNJnvQ3/c=
X-Google-Smtp-Source: AGHT+IFnqnmEtRN+TnEYkgzLsmMgMu9onXcJAYbNnUDSeYhetjNypQJyEsWU6D9PgFUqO9CVSYXI0gE7k0I71fJn7NA=
X-Received: by 2002:a05:690c:6c8c:b0:716:33dc:7ca8 with SMTP id
 00721157ae682-71668d14d44mr228152077b3.18.1751978999887; Tue, 08 Jul 2025
 05:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 15:49:23 +0300
X-Gm-Features: Ac12FXyh6oY7zo1vFcm9-8PdPSdYfsWpXxTlsiTBgAVcIBv-EawT7UlL6E1bJM4
Message-ID: <CAC_iWjJR7u6Y=ucqK65cmEgABikt-S+QqmvH3uprZydAEH+GvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: add missing fallthrough in lmb_alloc_mem()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

On Tue, 8 Jul 2025 at 15:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fallthrough to clarify the intent.
>
> Addresses-Coverity-ID: CID 569481: Control flow issues (MISSING_BREAK)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/lmb.c | 1 +
>  1 file changed, 1 insertion(+)
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
