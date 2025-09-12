Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44131CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4433833F5;
	Fri, 12 Sep 2025 08:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oCxZiI2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945FB833F9; Fri, 12 Sep 2025 08:35:43 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BDB83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-60f4678ceabso946351d50.3
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757658939; x=1758263739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S5nS/1KT1m0VKtVAjXDyb1k7RB5BC2ls/c6XqaLCKWM=;
 b=oCxZiI2dYR0CuRaPE9u+N++SaEMhpJ5YZEDGUJVH0BhoVcUSCG4pcWzaN9wY3ztoHC
 Wdy+01ABtut1mbvlWlSJwquXyqiqeRenPaoaE9ygm1lmK10Ut6JI4oq5ZPqwKuAqtr9c
 ZXZQdzxzkyw4m4BpvJGKmt8sdtQUCBtCsr9VwljGrD6zFa5FRhY21wG8Nudnc72BbISu
 UDpkjeOwYeNSTpwxg8ILBoaFPeFdGHpBg1Xgs3fAlDjyIsd66Y02pPCd5LYLaRytl8Uf
 0fiPYS8YCnxA6DAb0bcfHvkN5eTuzUoouagB480i4tuSZ2faQgSr9Hl3hKHMKYrCbPPZ
 N4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757658939; x=1758263739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5nS/1KT1m0VKtVAjXDyb1k7RB5BC2ls/c6XqaLCKWM=;
 b=SZU7Y7ABNb5FKo12SqUHw+GFC+p6RcYsQoXUP7++N/YL1fkuj50XVZs5ZlcdgLGIGw
 nToVd/OCg0oBB001icxaIbEn8AY9sAc2BHhvhJNdLjRdOJqhT+clKeHwriyTwmGvw7tr
 vJFHP32rnet6gzg5ynVDs88BHAmIc2euKcbnbw5sWsqHh/jINMiyeqW9Rc9L2LgTPsm4
 2h9oTsMjjp77UPDg7qzDF69Jq0InCFkBEte1R2bbAmSc++Zx3wipSiLI5baLuvvSUeWU
 Nkb3PdwtRgJEyHzaMcrvsmn9WbWGTED4xeBvW48gNU6fzSbKdwx0Xvfh1KNXVzjbMyqq
 DA2Q==
X-Gm-Message-State: AOJu0YyLxnwYVaECnqxgScZakIpdvX5jaRFQ3jBkICLPj6EyilotS5DC
 io3ok4rfQrxGim/slSSupzaPYkftRdqu/md346GQnVKSpGfG9lK6Pj5s/WB/iCj3yup/QObmhHx
 Bv/d2JDnTc9zczyEXsKskWoHDERaaZmLKpqf2SWRZqg==
X-Gm-Gg: ASbGnctMS2ubM8xph5zzFkHnDSVolAjhr5OtmX+ye82Hrgi3qZY+v1Q3HQs/jCOF4es
 8jN8DNKSzMCfV5khh6hoHHlympxnplaa3VdThX4ZhsAkQWRKSouFgqK2/7CZUJdyueu8nwQgk0/
 zRdtEKoYvgNAAg73FAZXVgGQOzOWdFL9kPeZEYGC26MvlMSs0vWmY6/k3WkXeHvuKGDc2PjeQQH
 2WSf0bp9viVgta4zFXC8NRnZlr05J73RZzy5gUuyqUKjakuNFJau2R6lYthIhkQvcshBv3FEb8B
 eQn5a5fD2Q7FV7i0b6HSQvHh1oBb10EFfmil5T5UnQvaO2bO9HgJPFkBhgzT/iI=
X-Google-Smtp-Source: AGHT+IGwFoqwGZ+YF2YzlZKvC1zJzAQDYjtPtsVRbzGHDbuLay4uChXm+H/2perhv6zeZ4CLJIaKQWaffCrWtX6v/2E=
X-Received: by 2002:a53:7b03:0:b0:604:3849:9b8a with SMTP id
 956f58d0204a3-6272164e7bbmr1258931d50.32.1757658938696; Thu, 11 Sep 2025
 23:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-8-anshuld@ti.com>
In-Reply-To: <20250905081902.489345-8-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Sep 2025 09:35:02 +0300
X-Gm-Features: Ac12FXzsaFs3m3cPjM1LzjQQLUiJLurBU31kIVy-ozXgRUtUvFMS87PgQoIPRC0
Message-ID: <CAC_iWjL4oJDtRMGqBQ9r-bgjR5w+J5o=5cQrt330S4KLr2E0xQ@mail.gmail.com>
Subject: Re: [PATCH -next v6 07/10] arm: armv8: mmu: add mmu_unmap_reserved_mem
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 a-nandan@ti.com, afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

Hi Anshul,

[....]

>
>         return 0;
>  }
> +
> +int mmu_unmap_reserved_mem(const char *name)
> +{
> +       void *fdt = (void *)gd->fdt_blob;
> +       char node_path[128];
> +       fdt_addr_t addr;
> +       fdt_size_t size;
> +       int ret;
> +
> +       snprintf(node_path, sizeof(node_path), "/reserved-memory/%s", name);
> +       ret = fdt_path_offset(fdt, node_path);
> +       if (ret < 0)
> +               return ret;
> +
> +       addr = fdtdec_get_addr_size(fdt, ret, "reg", &size);
> +       if (addr == FDT_ADDR_T_NONE)
> +               return -1;
> +
> +       mmu_change_region_attr(addr, size, PTE_TYPE_FAULT);

Since you are basically breaking the memory map here, you can use
mmu_change_region_attr_nobreak() and not run the loop twice.

[...]

Cheers
/Ilias
