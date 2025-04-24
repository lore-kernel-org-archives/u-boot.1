Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE83CC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E782280FDA;
	Thu, 24 Apr 2025 20:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShzEle0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5CA817C4; Thu, 24 Apr 2025 20:31:06 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087E7803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so2027777a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519462; x=1746124262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gp547bILx3JVm+atJN0Yd9HgNt8WPVT/iLUcGHxfXTI=;
 b=ShzEle0qzk9HhjEUIyQiWDTvzaVff6UVZE+djesQMsW4tnyCP9wc8w3YdMxE0E4yrV
 t1XqA8n4X6TpVeZGPUNP1QnjIiVT7GwtsJ/qS7Ec9tvB2Vro35FQsue+mElEm6e3VhzO
 +YL31lNUtjmD65aECMMs1u8myCKzn0HJ0O4Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519462; x=1746124262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gp547bILx3JVm+atJN0Yd9HgNt8WPVT/iLUcGHxfXTI=;
 b=OtAXMPeZ1nNoC5i4e+kmqZGLj3gRsGr3bZpzeD+pZ35LBjXfI9SLl5znfVDyZlryQh
 UqV0oC2yJ6zibUbyilMHpw0XgW0dCtTlzQe3KQfTlOBRS9q9g0vruAqMsWGtJlxH6DKQ
 fj77OQvgME8KkxL4SQUDfd7tUM6cnVPRnfusxzPZCkBp7uIQk39ei1new81Hydr3WiBY
 w/HqxvkkbQJVHbvROQINKfU9UBhvI3wvP7J0/A3RCN+sdRgJQ9dR7v7ykOVtRdaIN34u
 t/MtO/npV+KA7PkK2Q5i4QYLi9dYRx6S90lIA2Tc0br/i4RgG+gs9wybEvx+rTPugj8c
 MDRw==
X-Gm-Message-State: AOJu0YxHkBWtIWq+FiFNmmK8RmWP0D5xDLrGZtUeFViNKdrB0iuyCtg5
 CmhNg7vOHd5P5YryBwu+aZNhjiWKSr7PXepcmg7AYzpZpKzTnTk1lTf+7UnskVckCmshYzo8bUC
 uTNfWwHDnyZyXKSDowqdrJcvcmMMf3kWeiN3l
X-Gm-Gg: ASbGncsDBg+/oJvhod0wtS/3am01clht/Ot8c0hENJf0RAaeuPCqV4B8QMF80eixw4r
 0++//o9Ia9hqJJabW4UoNm23HLisXi9rOVpZm+Mk6Bz4b7meLSaPDxw9ZWIKfGV/jRaDg1bkpsI
 rOBo7GYZv02j8ZHB3Ngltasq0=
X-Google-Smtp-Source: AGHT+IE8JIB6mE7+LwCGfXHRJw8bHr1zByPYhh6sf+QUFE6IGaWZfXx/EPVn10iZ+04pI3xWzAsHOmjDk8idCoDKSHk=
X-Received: by 2002:a17:907:7d89:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-ace57248dd4mr356595266b.24.1745519462455; Thu, 24 Apr 2025
 11:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250423144913.3918472-1-trini@konsulko.com>
In-Reply-To: <20250423144913.3918472-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:30:50 -0600
X-Gm-Features: ATxdqUFpTiTT3dRMo5i605YU8f9n0caaW-wSgcQrH-A9ub5wo8fUL45NV37IwwI
Message-ID: <CAFLszTh9vzZS1m3xbQt7Ws06myLU2WUjA6U_3yRvfKQsj9ejrg@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Rework BLK dependency
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

On Wed, 23 Apr 2025 at 08:49, Tom Rini <trini@konsulko.com> wrote:
>
> The bootstd code itself does not have any dependency on BLK in order to
> build. However, in order to minimize size growth of non-migrated
> platforms, change this from being "default y" to "default y if BLK".
> This will make it easier to begin migration of platforms which do not
> have any BLK-class device but do want to use bootstd.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  boot/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thank you for letting this happen.


- Simon

>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc95..0e796a71a82c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -427,8 +427,8 @@ config BOOT_DEFAULTS
>
>  menuconfig BOOTSTD
>         bool "Standard boot"
> -       default y
> -       depends on DM && OF_CONTROL && BLK
> +       default y if BLK
> +       depends on DM && OF_CONTROL
>         help
>           U-Boot supports a standard way of locating something to boot,
>           typically an Operating System such as Linux, provided by a distro such
> --
> 2.43.0
>
