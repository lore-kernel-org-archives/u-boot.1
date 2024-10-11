Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCFCFD30C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F26D892CD;
	Fri, 11 Oct 2024 12:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NI+ly8dT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6A9892D9; Fri, 11 Oct 2024 12:23:21 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA577886DF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c6ef58865so16758625ad.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728642197; x=1729246997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+s9p5+1BtlVif/0CHbFEhfJnDn5V5l3Vrju3Ii+fzs0=;
 b=NI+ly8dTn/gwZgWv1uiBL94Qjwf0lSxugBLkRHG2MKHpYHrIZDKKQNnGLk7WVgz5Dp
 jVQFx9eY1cQWFjsUtxId7hda9P670l4nH/rWM+5gEUfVumHm/mI/8Xqz/oeCn2yrMUFY
 tOyonJW12ATubRxcNhpB9IjQAL5EA1irY8sQ+Y6iz8t9oGAAvydYtC5PFBNWDU5KXMTu
 aRUqDGpXi/zewxSPI9V1Z1q8u+K63CxfBgQuyy83jh8I3qGWGLlV1tIbu1c3/LxzgRGl
 E60dEl3VY4kDOdFmWWIcqINJ2tCTBMURVH/VdYHQPL1IOkdLbnFHhavbuHGFNexoamDb
 vBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642197; x=1729246997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+s9p5+1BtlVif/0CHbFEhfJnDn5V5l3Vrju3Ii+fzs0=;
 b=O7BDPp8/71N0MdSM/unb+1e/SwlvJVAY8itrzMPyRvwfNh3U0aE8ozmXxeTELQtDHI
 dLu6LwLzOPRy05KMqZPzclGufnAhLPbWEw/9tiOI4LWQMSNohZ3JyjSXrcbykcLhCSwz
 IOs4ZhYdX7rn3KXrp15uYhAsCNs8KYwVUAzmn3znHHoN6jZnW4pHgTZ+AG3JI1ujOU4o
 +icQfTggbxBOs/w9rP0SCqliSqBC95yuJi0Bw9fGjTbLIGrD1y7DmupygLmOmek2gOFU
 tEWxk3a3oT0uk99lg+wkdNjNAS/EInpM+PPqE7TtW9OakH7N25CR+ObvF/0ilRQxEJcz
 44yA==
X-Gm-Message-State: AOJu0Yxzkc0xvvXE09NZ07ncbKfXy3u3FBns1hryVEat12AS3q3teJdY
 sUyuLruC+8kHArRMTanugZpgm03yhhkHGAiLBgoWFc060x7SQ3PvU4gHlIW9b2omd7sS0tb9KW/
 yWbG4B41GJ/Nxm4rYyNNOqy5UhpmpgR+nLuATyw==
X-Google-Smtp-Source: AGHT+IE3QvlOC68GLrl0JrOO1kYOamglOlzKeIam4OqSTXtVBwQBtRp5D3L6/xxSUJNGTvYuBvlS6aCygrWFneBIpN0=
X-Received: by 2002:a17:902:74c7:b0:20b:65d6:d268 with SMTP id
 d9443c01a7336-20ca16f0863mr20844475ad.53.1728642197471; Fri, 11 Oct 2024
 03:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-8-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-8-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 13:22:41 +0300
Message-ID: <CAC_iWjL3SD3zmNSn0mkGCE9iNEXVdHJfToBHO6U4yoGd0qkxWA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] ti: k3: remove efi_add_known_memory() function
 definition
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The efi_add_known_memory() function for the TI K3 platforms is adding
> the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
> through the LMB module -- the lmb_add_memory() adds this memory to the
> memory map. Remove the definition of the now superfluous
> efi_add_known_memory() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  arch/arm/mach-k3/common.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index df48ec8d479..f2086cbdf51 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -310,14 +310,3 @@ void setup_qos(void)
>                 writel(qos_data[i].val, (uintptr_t)qos_data[i].reg);
>  }
>  #endif
> -
> -void efi_add_known_memory(void)
> -{
> -       if (IS_ENABLED(CONFIG_EFI_LOADER))
> -               /*
> -                * Memory over ram_top can be used by various firmware
> -                * Declare to EFI only memory area below ram_top
> -                */
> -               efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
> -                                  EFI_CONVENTIONAL_MEMORY);
> -}
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
