Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC800C3ABB2
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD1A8319F;
	Fri, 30 May 2025 09:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="suXWhqHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4655830D9; Fri, 30 May 2025 09:47:18 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8278312C
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70df67e1b17so17206757b3.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748591235; x=1749196035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehgyfEbIuRe8Kg4MV1G7hkUcQEXr/1/96+v6YgoRz0A=;
 b=suXWhqHDljvgNKvs4EYaeDM6ozlea1vlA66EChF3jQwnSbeq1HKQBqTfXP7Lq12uAA
 3J9ZOH5OIUM+zU2k8ZwdyQfclkbQcuoTT3lhs5yVojpbnA/lHGfc7gjb7WGyY4Y8xi00
 dotCj6FaOBGOn18QaGJ+ekGGmfCJ9Knd0QZEJUN5iVwdFWTAwseTRIiByXAmYuHxSpEB
 x9RXjAt/rYlOqGdEB6OJHcDhiBGCDAJpXrVDcka1kCrXLgXWmV2FPwQ4Nc0BeYbZXEQv
 gi7bcA9tUUVV1uiA8mNAHBY566hdNJIKnml1Hmgss58nQWJrn4Y6WSSm1b7rP4BVy84s
 L4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748591235; x=1749196035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehgyfEbIuRe8Kg4MV1G7hkUcQEXr/1/96+v6YgoRz0A=;
 b=WzqFHZvGOpN8YmUOZniB7+Mt6YgoVKWuDpmuDB3od0fDwzvkSKyfOWkKH3UpyEFvWk
 p/LpcxoNcLuALRuyXa48jGMHZmSWK+WIcGEsRnwSO8XhJ0fNi9mH//sMDTZICO20bGeK
 exuwTewTorWikQeLFPJ0oK0NRe9IBlLFmturwbvla/7ha0J1DtGSsfF3YU/RaRgmeTIY
 3Bomye3WttA+syI7zdwUnpJ/TMK7atTSqi+QR9KeTyiFPL7WLSDEhN7dMlYdFxEOjdsl
 LJ+JwHp0+xJOhFcy1pibTNJjpfP0O1MqDdvd+UvJsvAh6F0kFRwjp/yM0aMN19W8TJJ7
 UHfw==
X-Gm-Message-State: AOJu0YzJ9OYfGC/KmZHvie5YoVK9cM+Pew4nYISpKj82ZU/JJWgOD2or
 obQXisAELR4qck/Pywma+gyf4tuZn8Xjirb5DXxFkemCnNMQYQiYWk4YDB6UcbInftLcLzRHm6+
 BCGea7OmJjCmp8Dyzh2030tpwffMdQuOyHn6Oy8hFRQ==
X-Gm-Gg: ASbGncsj0Co0FK31X8btUwyRZOuF1pjxneyxZSfbjVndgbQuI1xV1XxojTmgQMv0xLb
 j7T8dBcez0NsGQO5/1JaMhBylXPOcDlJOBMm9ABamAk4xqTYXwM2jVjb4WzMhbkXjpvrsvryHgu
 pByHIIO3NfXIGoZ/2bdXuMrz+tIOSpeMlnVw==
X-Google-Smtp-Source: AGHT+IGEXIDzQcEdImauDIualR93svelqKDjq5At5sgmu5cXiiwJczsKtVYBCM6dN0YAeMaluB6f85WNlf6eKFgbOmc=
X-Received: by 2002:a05:690c:6f07:b0:709:ad9e:e651 with SMTP id
 00721157ae682-70f97fb72bamr37051497b3.27.1748591235638; Fri, 30 May 2025
 00:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250526091253.400802-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 May 2025 10:46:38 +0300
X-Gm-Features: AX0GCFsQ_UTYCpY4VY40LZ4avGXZwqwuId_P_KcdcwkzfPLCgfFYPrKzhn3IzPU
Message-ID: <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

> +static phys_addr_t lmb_alloc(phys_size_t size)
> +{
> +       int ret;
> +       phys_addr_t addr;
> +
> +       /* All memory regions allocated with a 2MiB alignment */
> +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> +       if (ret)
> +               return 0;
> +
> +       return addr;
> +}
> +

I think we  need a better naming for these. Right now we have
lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
I'd say either export them as API if you think they would be useful,
or get rid of the wrappers.

[...]

> +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> +{
> +       int err;
> +       phys_addr_t addr;
> +
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> +       if (err)
> +               return 0;


This tends to blow up in random ways. See
commit 67be24906fe. TL;DR 0 is a valid address in some systems.

> +
> +       return addr;
> +}
> +
> +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> +                                 phys_addr_t max_addr, u32 flags)
> +{
> +       int err;
> +       phys_addr_t addr;
> +
> +       addr = max_addr;
> +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> +       if (err)
> +               return 0;
> +
> +       return addr;
> +}
> +
>  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
>
>  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> --
> 2.34.1
>

Cheers
/Ilias
