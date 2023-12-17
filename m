Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FC0C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 17:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB0287CF4;
	Sun, 17 Dec 2023 18:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dibyh9XA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF0F87CF5; Sun, 17 Dec 2023 18:35:41 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B5F87C34
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50bfd8d5c77so2332512e87.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702834539; x=1703439339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DriLpsppq63p0O7hkCtAAOeEzm4ZZr01Kdr4sBspnhQ=;
 b=dibyh9XAXWvXYtEr/nheKP2wSK9J9Z4UXcO6PeujGlCVWusE/62ia0vPltV6OhZiwC
 GqpUPUp0nTHVjOTmh4fviptBpt9VuZQ5hkOLbPgEjZxiKhMssoS6wre2iY4LW6it/LF8
 B6tIzf2I6bNLZnrKQMn+e5/IxQHmlME5xaZbQzmIskpfREKCLHwhZSa3GA1OUU5ZoBg/
 P1OiBVBeMKa5p4Nb+uA6YQ+Xw6ApuiY2d4hY1kEOSHBi+xdfBu7iH4udAWOMvhcUie4R
 kLrLtsQ0ExSFHDdNSrOz6M8F5bFV7TSRGniZbGw+ANjaqZfVAk1yLhkRVIdL6QPjG7xE
 67fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702834539; x=1703439339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DriLpsppq63p0O7hkCtAAOeEzm4ZZr01Kdr4sBspnhQ=;
 b=Sxc2qWHs3K+TEVo3VpzScmrmIfD7YdUc7WhzNIv1EWJ9ecVyfDKIOx8llpevAd6jww
 Z4B2ogvDEWtNrlHsyjCZYL9Tk/UJeuvjmwzIP6CZv5KXKakEp79BXfUpHPJACBVZUGhm
 RECOZeIsZQOrV6avHB+55T8nODJNk12q+VBcTFBrDkkmHFdsVBbro/Fn/iguX9E/QKk/
 Wtk50G/ly7MUtog6mNDqUTCEHgoUQneLJ8wxTdpfEc5oXQo/K1VB4AmOfKjg9tyQ1p0x
 2kPx3+f7o7WZI4WBSZbCR+4vd/cMXNNFzEmu5iWV8jvYhBFNU5FYArdJfp5bbH6CBcit
 jtWg==
X-Gm-Message-State: AOJu0YwDdWlGCaFSjPIKHbMunYGxupnpdlfsxuqR34AuNqVWS/5zO66j
 gkXTN7AuTIwo8iFQF5ErWTJZLIcrTw/2DU2CxkOS7PlseLo3b6FlXb4=
X-Google-Smtp-Source: AGHT+IFCQ/GIG7G5SpiHgkocynre5fgUVUMOWOk1GwCW//GdcA4YIjWSBW/1ds5/JzTu/nT2TzAz0JlQPSzH1to9zJo=
X-Received: by 2002:a19:6753:0:b0:50e:378b:363d with SMTP id
 e19-20020a196753000000b0050e378b363dmr107902lfj.0.1702834538962; Sun, 17 Dec
 2023 09:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20231217114457.70128-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231217114457.70128-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 17 Dec 2023 19:35:02 +0200
Message-ID: <CAC_iWjJ+VUY+FVyyh8fib+i=qy3K0fDwvcjTfmJMfJkSW25SQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: CONFIG_CMD_BOOTEFI_HELLO_COMPILE dependencies
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Sun, 17 Dec 2023 at 13:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_EFI_LOADER cannot be chosen for ARM v7m. Remove the superfluous
> dependency on CONFIG_CPU_V7M=n.
>
> Fixes: b20bb09b2108 ("efi_loader: restrict EFI_LOADER to armv7 and armv8 on ARM")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 748b959961..0ae5bcd981 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -373,7 +373,7 @@ config CMD_BOOTEFI_BOOTMGR
>
>  config CMD_BOOTEFI_HELLO_COMPILE
>         bool "Compile a standard EFI hello world binary for testing"
> -       depends on CMD_BOOTEFI && !CPU_V7M
> +       depends on CMD_BOOTEFI
>         default y
>         help
>           This compiles a standard EFI hello world application with U-Boot so
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
