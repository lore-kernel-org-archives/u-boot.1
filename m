Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63BDC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 07:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2843D87F19;
	Mon, 12 Aug 2024 09:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bUfD4Oqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808068861A; Mon, 12 Aug 2024 09:58:45 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AAE87CF8
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd69e44596so27339455ad.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723449522; x=1724054322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6TUhgN+A+7mhKaPy7651v7GF9UaU+5UutmEV8n2VcGg=;
 b=bUfD4Oqn5BU3F0Y69PjMPN6YJM5/CGYHQty/N+l/urXfZVHd7pf12VqCgWrUd6M1As
 tUCX0o59/LeUwqDNjTWumIQqNq3zKB1o6qqmhbzOHaKR9hXZCpQv6gAae601ZmB1umif
 Th+9DPd8eH+KxG6SFd6lCH4lBfjbnYWTrZqzAzLGmUZ5e6RD6sgZspMgE8psHaq5GHGH
 NpPR/juKJBNVfPd+4O6LrgBZqpRXAq9F6uLJQnJPUasny6mLxCT7J9Iwg41M7I+7D2gZ
 R0XrJ8Z/KYkfQPlkkPFNcnRtE8TTHoJfpuERUVhTkCmut7ozgen2WeLknLjD2sesRdIl
 7DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723449522; x=1724054322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6TUhgN+A+7mhKaPy7651v7GF9UaU+5UutmEV8n2VcGg=;
 b=Sa4P5BOOvS6xLC4YqXfTo2uhPAp9rlv9nMAjIjA6YHhKLv/W3evdN4bK4N+g9hhcNj
 wlhk9CCdY7olgwFK50P4bKdSR/E9XeYMiPz44fFw4BAK7jNj9Wdm43ie4su7dZWcswps
 iScN+sPkjhmVEJ6Uuvjgnk3xT1zEKyOUBI+HicuHNpT1zRCDb/0Tfa2oepyk9i3/UQkN
 oxXzu1eF9pYaBdQJevQxMMx47NTCXX89xeYZNhHmJynFlee3wpivl8wNV/bCidPF9ch3
 X4i+56t6tiB7NiOTjzokiW/Hnk4XTgJj8jJko9ZZUJ3OBr5OARU7wdhpirUKW9ZM1DSu
 FFWA==
X-Gm-Message-State: AOJu0Yw9bZGANmbmh0e4NxWP70eFWsE1iyJCfcuJxy0keGtSzjZ+eblK
 XGzjYGrttS5MKXhqrlQS9Bn14Kr53ht7dZ+wvUK0hQqHXm1o4TOgXZeMwDhxK5c7Cx1iS2Zcqzo
 Bc/4wh3+gZFPrQ4YLXDLo/tYEWSkkVUFTSuaAxQ==
X-Google-Smtp-Source: AGHT+IE3/2JhKcevT6shO2x/4Zt+5U17ssa8DI/Wli/JF64MRd4bk7/WrR3A46hSsFHotQ4bZdAV6p0JNmgCgT+3cX8=
X-Received: by 2002:a17:902:d4c5:b0:1fa:2b11:657d with SMTP id
 d9443c01a7336-200ae5034aamr141984015ad.10.1723449521533; Mon, 12 Aug 2024
 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-32-sjg@chromium.org>
In-Reply-To: <20240811145209.4191404-32-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 12 Aug 2024 10:58:05 +0300
Message-ID: <CAC_iWjLdNHG4ZuT3Ryoob6nec9UiQ-gknDgVLJk4nSdO2g+_Lw@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] efi: Show the vendor in helloworld
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
>
> Show the vendor name so it is clear which firmware is being used, e.g.
> whether U-Boot is providing the boot services.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Reword commit message
> - Use 'Firmware vendor' instead of just 'Vendor'
>
>  lib/efi_loader/helloworld.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 586177de0c8..c4d2afcb40a 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>                         (con_out, u"Missing device path for device handle\r\n");
>                 goto out;
>         }
> +       con_out->output_string(con_out, u"Firmware vendor: ");
> +       con_out->output_string(con_out, systab->fw_vendor);
> +       con_out->output_string(con_out, u"\n");
>         con_out->output_string(con_out, u"Boot device: ");
>         ret = print_device_path(device_path, device_path_to_text);
>         if (ret != EFI_SUCCESS)
> --
> 2.34.1
>
