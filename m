Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E55E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3CA80655;
	Tue,  7 Jan 2025 16:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="frNW8xN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8A780658; Tue,  7 Jan 2025 16:32:49 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525598036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso223434045ad.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263964; x=1736868764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=311tvjk94TQrtIECutv4FiqdOLGUkmkGw94pzOJQ+1s=;
 b=frNW8xN8wv2PHIOan8aTnZLMO3whhP5ax9TPlcG3MxFX0bwD9EHKn1K4hhKn+iZDY4
 j9FBhSwk/DcBJPTy/X5m8TEvgBAGmsIJeX2C1lzBwMHzh32SpXlooT8qvbP/Y2y1hbTi
 sXU9zLwHu9XgALSBAl2mGtS92sW54xTKkmBEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263964; x=1736868764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=311tvjk94TQrtIECutv4FiqdOLGUkmkGw94pzOJQ+1s=;
 b=sPe5xLNYgfj+whDQe4JcWMEV9Ur+YDV4YzCmVEgA3apafGrw2BoXAEt3jfI1QojgVx
 esiXSYFA1K1RR4SN+SB4NOqrIqN/iH7vHBbrFYzrqim37jgD+KNN4tofSlEP3X/XTfGt
 oKb+kZJyWrbtEE+yojfLe5Vfxt3sLdm97bYCh2YplgDDFnD6VkmF5dgJE+LrorziCP8X
 XzjwwmgvscNtCejMTds+DGoyVxdI0ZX0V2X6KVoIqDVRBTPEDCaGZCDTFA6EJaBvBSj2
 LJPzFXTftOaObuc7N64nNI0PjuQtIRHxdhPLHdpE6EGIqcvBBXGKZ7JDfuwixVkEA34K
 ssUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwsHhJtNiTNXvdwmrPU8btIcLiUug4t4l25zLlAZGCMCZXlMasnQIx3DOEtzzOTpS2e6XK6TY=@lists.denx.de
X-Gm-Message-State: AOJu0YzgTYBmAZfOl4udtLv94YMbNSQfTB9tq4MLKSSijqt2+B916iSs
 mNl9BBtpkoFjT/eqKuQfF1CZLkoPbh9mmF7m+ayfOTmi9F8Z8DN1yJ9WgwsDGCxdgQRNkzYvt+o
 dNW8YB2gIBciv91fCFp+B9R4YEbhwhngqb7IN
X-Gm-Gg: ASbGncu962Toc+njePdwTw43pjuCJeP4erqmQumXTSCpBeE8C8WNw8m+YpyLjR11lcm
 +Lm75+sT8tDy0kth7bC/pPugM3KozzwAe+hgikeo=
X-Google-Smtp-Source: AGHT+IFM46KeIe6AO2wlVgV4Btu8dce+Tt/BUgmUU4HpBIGZToDQ1hVc75rNxWhEk85kYBrL/5AaOxBrgfjMH8qbjhM=
X-Received: by 2002:a05:6a00:3e13:b0:724:e75b:22d1 with SMTP id
 d2e1a72fcca58-72abe060a05mr89059793b3a.16.1736263963921; Tue, 07 Jan 2025
 07:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-11-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-11-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:19 -0700
X-Gm-Features: AbW1kvYAC2wEXIp-MPBdAoZFnjyLvt3B9KK08amvooMhFWF6l8ZfzlMvWaI_VI4
Message-ID: <CAFLszTjMi35c3BQjaPYatw9iCnpf11x8UEpK=NjEV5ob85ci3Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] mach-snapdragon: increase pre-relocation malloc
 size for smem
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Ensure we have enough space to init smem prior to relocation, since we
> might parse the DDR bank layout from there.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Wow that's a lot of space!


>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 976c0e35fcef..5f3a1b11d8e2 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -14,9 +14,9 @@ config SYS_VENDOR
>  config SYS_MALLOC_LEN
>         default 0x10000000
>
>  config SYS_MALLOC_F_LEN
> -       default 0x2000
> +       default 0x20000
>
>  config SPL_SYS_MALLOC_F
>         default y
>
>
> --
> 2.47.0
>
