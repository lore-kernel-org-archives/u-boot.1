Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51BBC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 08:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED17F86E42;
	Thu, 25 Jan 2024 09:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aWBD8/L3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CE686F67; Thu, 25 Jan 2024 09:52:49 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291BA80245
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 09:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50eabfac2b7so8249882e87.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 00:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706172765; x=1706777565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRBttucsko3pzX+Rj7K1wVdlJjPreRKXUeiAcMMmky0=;
 b=aWBD8/L3KufiKwq6eVPYCzwsbZM2BeD6MJTX6zxj2rjUIJKLsmoyPH4jjarP2+L0RU
 scA0zkawJyuaGiOCcNoeVFcP+PrWv4qrtwjVi5J8VAg5gN4pHtb7pkLFNopk/QYuyAYE
 zlxshskWWwH1+2o/kEWNr0zNf7RdRd3FXFkFFkxSA6W94aY8IVjpwm0rDUKTXGQLN65P
 BhP9jGOaisGZtdrPMW/XWRG4K6sYbREV+khDTIKvFXv4VtUEFHX8YqKJQJjPhhkN5Jha
 dQJ906Q2xGhBHlofKhOs8wSa/JvoKHl2zOQat/buikjox1IWrvOGBEZLjeQ1ZhqP//R9
 lwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706172765; x=1706777565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRBttucsko3pzX+Rj7K1wVdlJjPreRKXUeiAcMMmky0=;
 b=bver6RKHLvu8RIgT9rqX6c3EsM17TIh7hpzWES0TefxTSUFENP2FzLNy8OeYuLMHdv
 +J+x44UirxeYyKMBV8Bd98d9AfiP8Gf8xacZdeyw2SLE7yw0ULVClTbzoI7leifWYMZE
 rnd7tdt99fkgQc9pu3SnVDNOqgp8SE3fboP0RHEagpy+LdItLzWED6GkXchkN2E/tf4n
 XAPm8CVUqxuKT9hAm+ibBuR/mOHYKjg1UiWu2jLWT5ZQ3C1x2jA4FVgr5cdm5zj6UYJ/
 cpGF73UoabRhNqcx0KIEaXvjm+ntJNriWJU7u4qMI5BHai/r5S1l37XzQVpMe4Oyi+rA
 1KzA==
X-Gm-Message-State: AOJu0YwSTrZy3rvTWYORJaU7wqj/4ZsjAmxJ+9r3OzQmESxZEl9UM+lV
 GmwShNcPnMS/gIiw9HtCBpzohaeEzr1FOIGVekz8g0Ex9mlQwXIynCwSWiX19xcR7YIVyYU5FuB
 XfA0inMTj5T6pmIzfIdnNk5rcTM9HVXhV87Lm0w==
X-Google-Smtp-Source: AGHT+IGQa4uEdEAhtoymOnXGfOEJTRnwNMgKxk2cUJY2R6AbftxIPXg/CZTvD2yxX0I8KaQpnDs8CZIsqEWX6C14k0o=
X-Received: by 2002:ac2:465e:0:b0:50e:b3bc:4aa with SMTP id
 s30-20020ac2465e000000b0050eb3bc04aamr324396lfo.57.1706172765551; Thu, 25 Jan
 2024 00:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20240124200433.23543-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240124200433.23543-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jan 2024 10:52:09 +0200
Message-ID: <CAC_iWj+PpUY13jCHuwxMOEpPc6JFsN1MBGjvpY+y2WAHZJk=jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: add missing line feed in
 efi_selftest_miniapp_exit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, 24 Jan 2024 at 22:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If an error occurs we may see an output like:
>
>     EFI application calling Exit
>
>     Could not open loaded image protocolLoaded image protocol missing
>
> Add the missing line feed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_miniapp_exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exit.c b/lib/efi_selftest/efi_selftest_miniapp_exit.c
> index 8b2e60cc711..0909a5ca748 100644
> --- a/lib/efi_selftest/efi_selftest_miniapp_exit.c
> +++ b/lib/efi_selftest/efi_selftest_miniapp_exit.c
> @@ -39,7 +39,7 @@ static efi_status_t EFIAPI check_loaded_image_protocol
>                                   NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>         if (ret != EFI_SUCCESS) {
>                 cout->output_string(cout,
> -                                   u"Could not open loaded image protocol");
> +                                   u"Could not open loaded image protocol\n");
>                 return ret;
>         }
>         if ((void *)check_loaded_image_protocol <
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
