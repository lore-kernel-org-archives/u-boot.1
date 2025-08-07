Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9EC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC9D84543;
	Thu,  7 Aug 2025 15:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MFrsNsxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51BD84571; Thu,  7 Aug 2025 15:57:23 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396EC84541
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e9028e13bb4so869257276.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754575038; x=1755179838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GKwgI1bfDeoJFfKe3JxNg2F0C2YG9peNKLnjleIG8lI=;
 b=MFrsNsxu0UuT5V56YPELOPVNLTY+9Zf0/VEW3ucUbVtBbq61KoV/j/QQREYOvDJjIg
 +JtuBYRFuUr2Mwx/7pikt3eiAItDRX19dbMJjUfsvhY53mjf7qaN4bTExXN0RlyGkV2M
 6KWo/ROnLbOZxUHMwTLudspDtqM+ilvdQZ7vUnOVRt0gHXvtFD2nUFIAX458K6fZdhwF
 WkLwPcgFd1TU9PH5oGsLF03qC+9MdYWZbquoLw6DeVM7E0Gg1Cl7s8WhNbr+jezBwfk6
 E9obfUEtlR8z+yxT9BTgiWodF8YqvfZpwDvGeZe8i3ZBpQ5kUui6QRc4ah7wH5CF0XX9
 2uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754575038; x=1755179838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKwgI1bfDeoJFfKe3JxNg2F0C2YG9peNKLnjleIG8lI=;
 b=u5tJeAiNBQxYKDx8x99QSCLoxyWr3CyjhYNEwQZUqvFvJk1CLX9Ib9hhBu415YuMiD
 MjlPl/bDfxjzIRPgfDE+ocTYT3DH4jtIv/u5N4Lzvj6OGN061as/6eXhSdX3MlVqszaM
 uCH6+fmwhy6p78ZcscJ1nVLPp+b3EBqHbOQ+K1FjueVm27OHYEo2NpoMYRourq38RA5I
 /jK1cdC74E9ga3ppNQCY9NeGEBolpdKsZdec5NHIK9GKsHskuHY20jwISdgLHj4l8B50
 zj+pZwlS6x5tMSxf0CFCpW9JubsQNtUJaBl3UterH8F87ZhVHrcBy6IbfSHgGP3T7Uwt
 S0Wg==
X-Gm-Message-State: AOJu0Yz6XUHZFDUKqKMIt8v6ZdF6o48HQEg//ZkcZ6KnVR/F3d3x9Urj
 PWzoJ4qy7Cc56fA4sOMp5h6r+Iz6+ieRXajLfHjQPdMa6kk9dEYIzBmzXTJHN349cZd69wBTmX0
 NBxq65KF+csepmfl8j0xyx3EtnVYAQvUQw84M3ad9O+uATjHfpZfRNHAQsw==
X-Gm-Gg: ASbGnctsC22+4p89YVM30FXTEpUHkNBqHQiRQU4jSM+1LY5XVNQrB5Y7VqJfMeUCqEa
 ZmkpBrIx082hw0PBWIIVLRhi2spdsJHrNjn5da9Cqou42flWX7VqUZ+OLoLDYq9RkJrk5h2PacP
 kcdVoauSDYTPkI9MiC7K2jcfoHtt+zWACyGNH9Cvxva7sdkSvVhlxHlKcqHXqCE1+6hxPswvFOe
 dL5XXth9KObsQ2WXm2cVWIm1ctt647W3K3foRkwmD/OvN96iNI=
X-Google-Smtp-Source: AGHT+IF6uuX0+V4x8/oD9bn/2WR2GBgedrsW70yOK2HmcXc+B1SxVsrOQxcnC4TQvD3TQEaWmFRFcFfiYnSQx96FDd0=
X-Received: by 2002:a05:690c:a84:b0:71b:657c:589e with SMTP id
 00721157ae682-71bc995433bmr102079987b3.31.1754575037900; Thu, 07 Aug 2025
 06:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250806145519.1664444-1-trini@konsulko.com>
 <20250806145519.1664444-2-trini@konsulko.com>
In-Reply-To: <20250806145519.1664444-2-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Aug 2025 16:56:41 +0300
X-Gm-Features: Ac12FXy_sqy-BWZ1PPuGYclYoWsTEIsG29B9KQKLNtrV4P1t0bl0UsRK538za2M
Message-ID: <CAC_iWjJni90NYrkb-zS7ZB_FkDdkohE=Z8xPYkaU1OR65uWQKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tpm: cr50_i2c: Make use of 'z' for printing size_t
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 6 Aug 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> When printing the contents of an size_t variable we need to use z prefix
> to the format character in order to get the correct format type
> depending on 32 or 64bit-ness.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/tpm/cr50_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
> index 5b2d5ccb1460..14a94f8d4a8e 100644
> --- a/drivers/tpm/cr50_i2c.c
> +++ b/drivers/tpm/cr50_i2c.c
> @@ -388,7 +388,7 @@ static int cr50_i2c_recv(struct udevice *dev, u8 *buf, size_t buf_len)
>         int status;
>         int ret;
>
> -       log_debug("%s: buf_len=%x\n", __func__, buf_len);
> +       log_debug("%s: buf_len=%zx\n", __func__, buf_len);
>         if (buf_len < TPM_HEADER_SIZE)
>                 return -E2BIG;
>
> @@ -465,7 +465,7 @@ static int cr50_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
>         ulong timeout;
>         int ret;
>
> -       log_debug("len=%x\n", len);
> +       log_debug("len=%zx\n", len);
>         timeout = timer_get_us() + TIMEOUT_LONG_US;
>         do {
>                 ret = cr50_i2c_status(dev);
> --
> 2.43.0
>
