Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D54C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 19:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAC583426;
	Wed, 28 May 2025 21:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YxXVeSmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7166834E5; Wed, 28 May 2025 21:51:01 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81313831E1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70f86c9e3e7so2473917b3.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748461858; x=1749066658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cwsw05Vxl1sE3Imr8XVQtdhyHllBwEd83rAcO8eyNdk=;
 b=YxXVeSmD5WxvZYJRQWEt9gZCHtAubt4xf2MONwrKoC86C9MDZxJPbLk9yPTtV3rvAl
 xSGuSrtZVWXz+K+PuaFBou1tsfs1YBDDLaNWLoDLpAoCLmUsurKPVVNpzII2sDyq6HoZ
 IJilpczBTj2wCYrqLVxhDnATPCP0eWVWyS0QlsMPrC3U3qizfYVB6k+0nILvfMX7eqHM
 QOAroiG4XyQiJuU/+nYN6080sBgXn6/2OSmqnHikkJMeSQkjFcPM7ex/H4Kg+WAWhe+I
 2YUfVEGaYQ4pkZebP/C5L9QF7SNKZlYE5ff7bT+JUijHoilb1wrZ7m6rCFPv/qHaUG/T
 RxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748461858; x=1749066658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwsw05Vxl1sE3Imr8XVQtdhyHllBwEd83rAcO8eyNdk=;
 b=Wc7hJbVsrH6vW4oqZ5k68OpLUPJKARXggMp+p6ewAPxR9KLmfdw3jPqaB8AwFTnZtY
 bqh/q31uFHcKz0VZJUiYyaaXuZA41eeH5WN7K8tdOaie40VMJWBpmaOvODHJAIMYs6KF
 6Aacr0zktdxyxAGiX3HTm5kzA0G1uSqDNbIT/Rv54REVKb0TZVGBFiHz935IKgQKJrIe
 XfT59jh5ZRcbfr/4XmY2OFydzxyNS5+gNhCxxTYHkKYgfrszEW9+31i0dYSD6ivqctM+
 sJmPnvmDgsLgrqcKW7yC/8knnrvSjN/+uJQ6qykRRM7L/pXs8BbL7EIipYpaKVKKGG/m
 6rAw==
X-Gm-Message-State: AOJu0YwX3npXJSv4boayj2J6xi/A0LxQ7iPPTZK59bDDVY9WBRYRpiQp
 vAytDpChWjHJ42P7LxLvCv6edbTuRugo3S/tzxcZ3ceLzCAj1UQ8l/UC6XIYT3oNRfMKs8fuWhc
 o7fUVRwkZ3dq5KUp6OAqHdmTidho0uib/6HBhmvD8OA==
X-Gm-Gg: ASbGncvRf4PpGqkV3YWfAHaJAqU9Q3TmrvFa/ocaw0rY/KHagxRVgS2l3p/421/9uuc
 uwwofcMkc2UnFa0WxyDlsUoiuhM2bARuxvAKr0FClVJINWOucqsRK9q95cQGAlNxQsyIPsWfRvz
 R/7uZNJTBeZOeEoWSEAXSHB56as7n8kzEPog==
X-Google-Smtp-Source: AGHT+IG0IMgt5kioXc3kQddMwy5Bi1s+OfCkT1zjBHm5Kkjk8II5gm8Lozww5X04VFDTn421Fw/6Obkr++By6igdP1E=
X-Received: by 2002:a05:690c:d1c:b0:70e:86a:ae1e with SMTP id
 00721157ae682-70e2d9c0870mr247715507b3.22.1748461858340; Wed, 28 May 2025
 12:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250528160323.1184731-1-sjg@chromium.org>
 <20250528160323.1184731-4-sjg@chromium.org>
In-Reply-To: <20250528160323.1184731-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 May 2025 22:50:22 +0300
X-Gm-Features: AX0GCFss0MEcDAH0TBF54vk-dTSTeIVMBBdQ-QVfoxwViw8GBF3xFIjqZv4vSGE
Message-ID: <CAC_iWj+mvNkSMBru-7PDPiBMsccCag3oRudS04Wytn4B37fS6g@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi: Update maintainers for EFI_CLIENT
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Greg Malysa <malysagreg@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 28 May 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
>
> The 'EFI PAYLOAD' entry really refers to the EFI loader and EFI APP
> refers to the app and the payload.
>
> Rename 'EFI PAYLOAD' to 'EFI LOADER' and 'EFI APP' to 'EFI CLIENT'
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46ef4359961..8109f0b4df1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1092,7 +1092,7 @@ F:        drivers/core/
>  F:     include/dm/
>  F:     test/dm/
>
> -EFI APP
> +EFI CLIENT
>  M:     Simon Glass <sjg@chromium.org>
>  M:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>  S:     Maintained
> @@ -1106,7 +1106,7 @@ F:        lib/efi_client/
>  F:     scripts/build-efi.sh
>  F:     test/dm/efi_media.c
>
> -EFI PAYLOAD
> +EFI LOADER
>  M:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>  M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  S:     Maintained
> --
> 2.43.0
>
> base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
> branch: efit

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
