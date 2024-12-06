Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA25E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F476881FD;
	Fri,  6 Dec 2024 15:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qJbX0hB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1417088F92; Fri,  6 Dec 2024 15:59:46 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B4788F92
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6eff0f3306fso1632027b3.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497182; x=1734101982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ttE5jB3D/RmB5F4h4OlQOxXp0wYNJZqr165tHV/TSr0=;
 b=qJbX0hB7tZdDWJUehvI1P1jMwdEJjHdkKWyk4elrfwi+nv3EQxqFDVct3C+eEVj45/
 za2Qzm854FWhZFuCLhOUzxAvA1Ftd8il1uAezA3n96IaLzwqFMgV5WyM+NrTwLO291R5
 O4RPJdzsRaJQcCk/CKvC78jNcu0KQaMOUVoKU/yc2osilVVgpkoVVZcNdyGbImqzHcrh
 nleeg3fgY8E4GlRfm+01fXqtfoMTZZ0HsYzfPzdTkwmmwadu7PA2TA8Qt8twYU5IFwFM
 Jp1JlTEElSsQPxRig5nOsxQ12ntn6tndgmnJMhjt26Guo3tFXMT5kazFKvERA3vWi8ej
 QhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497182; x=1734101982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttE5jB3D/RmB5F4h4OlQOxXp0wYNJZqr165tHV/TSr0=;
 b=G4cg5HTZBDhGkSO3xDdR6a850sCwpQw0ep0OjMcx68Hnz32PGN8JX+hy3cke2AlO9K
 LsUMQKuUwk+DRa6d0OuKYlMe7XLOQ696fVmTNIMN2LikzSHkU7YxdHBE17DOKekddUZ7
 CEYcvYPkjWXN2CruIwDfdxhYro8wtY6P5ATiAWus6+rx3x5T/pHNGGgWVI6cBH/b2eIp
 zbpYVAHTccdcRvy173LWiZGH5HAAgP93wRuyRcY0XIMTNbruWNwsWfJ5OKuiOD4EL2Sl
 veosAhBj35amuBuQO+GPTWG1Hos/2J73K64XJfXDZkq6yZxa5TdYI7b/sgWE2rQawKhd
 iT8w==
X-Gm-Message-State: AOJu0Yw2SQlIpabAuVE/OrcjbFVguzmtA4jgo+a08WMeCkJ3/Dys2Tvb
 28iuDXG19F2IcFtjQ0uFV6PAakQ9TXa4BRI3HAUm8dI+XHCn8zEI9SdNfUo0gjUEDTBgXTdU+oq
 t4PwzxQwzzreWfRAV4CwVmclQ7k8p+wkk1NAECA==
X-Gm-Gg: ASbGncv8kyCqHdwVeTbSz/DI0bcUasOqNZTGrFAIhp1cMlAqbmWJb7RwTasa+heCnTw
 Hf+SPLG6IxlhQAE9EMWmtVtQJS3p+t7c=
X-Google-Smtp-Source: AGHT+IELCKvi/KELvh6YTWm32qvVmSPDFJw7/JUfnyexADAzgSInUH2MSda5uejXEbWZ/Ue10GRG0XE5siGYFTnICoY=
X-Received: by 2002:a05:690c:74c5:b0:6ef:a187:f377 with SMTP id
 00721157ae682-6efe3c6fe45mr34587467b3.34.1733497182370; Fri, 06 Dec 2024
 06:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
 <20241206122714.2365114-2-adriano.cordova@canonical.com>
In-Reply-To: <20241206122714.2365114-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Dec 2024 16:59:06 +0200
Message-ID: <CAC_iWjKf1F30Ai+xpJ9GU-Wa4bwDCxMxjYBcBbAV118CLAnwjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: Expose efi_reinstall_protocol_interface
 in efi_loader.h
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Fri, 6 Dec 2024 at 14:27, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  include/efi_loader.h          | 5 +++++
>  lib/efi_loader/efi_boottime.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9afbec35eb..0d858c1e12 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -711,6 +711,11 @@ efi_status_t efi_search_protocol(const efi_handle_t handle,
>  efi_status_t efi_add_protocol(const efi_handle_t handle,
>                               const efi_guid_t *protocol,
>                               void *protocol_interface);
> +/* Reinstall a protocol on a handle */
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +                       efi_handle_t handle,
> +                       const efi_guid_t *protocol,
> +                       void *old_interface, void *new_interface);
>  /* Open protocol */
>  efi_status_t efi_protocol_open(struct efi_handler *handler,
>                                void **protocol_interface, void *agent_handle,
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 080e7f78ae..58716fa795 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3733,7 +3733,7 @@ out:
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
>                         efi_handle_t handle, const efi_guid_t *protocol,
>                         void *old_interface, void *new_interface)
>  {
> --
> 2.43.0
>

The change is fine, but as Heinrich said, please send a v2 explaining
why you need this. Otherwise one will remember in a year from now

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
