Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E7BC71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F327E80C83;
	Tue, 17 Jun 2025 08:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LZlA6mdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2118F81E18; Tue, 17 Jun 2025 08:39:30 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338108070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6099d89a19cso199739a12.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750142367; x=1750747167; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcCasylUYnZlNWRk+7T8JcDpJopx7vfTjQhHnmU0Xmo=;
 b=LZlA6mdw++rDTMONjFoKeAL/aYv3VoljFfdh8e1AkW1w2LWo777krTZcKxa2QdPpbf
 R3GLQCEWk8pjQqDkbHtD+PLAzlw2b2KCLvFnaEvkbE8LEuEZe8lIQ97UAjYwsjuMK8HI
 JZQNG+kqulOACfyDuhhs/lnp1hMR534Xa3kDYyB7T67ZoHQlHKU22bm6plX5p7XjWNwv
 JTyuRCmDk1XioqmJp1V8F0PeGFNdksuftiqBkxzoYVBGApCg1LhFGx8+sQ0j4Xh1zkzs
 J/oM/KDCswjgA92KW0ti6u/JT4TxxvqkPkbRGqThbcpPTGvjd+Wef73U2fwqDstpyp3y
 05yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750142367; x=1750747167;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fcCasylUYnZlNWRk+7T8JcDpJopx7vfTjQhHnmU0Xmo=;
 b=CzlA37Uf+rfg2WtQl1QPri64E+Y8sb9jYvLxeUzTWreuFuqFwM/ka5RhbHnHAt4IVo
 K6LxwmMhTdEtGTCEw0+HeuDs/lNUFPD86ACmuxA/T0FJGHoELQpj07hNjakcCr55uXQa
 JrodsUomHyz6l/Ab/AypblH2m9qs19vZAk1rjmcyOoiMq/AIbBuFHtBqrVoveyLxhUN9
 BUlBjuOa/T89a4p9WFvCBzZ/6WlwpA0aZfRwSFM3GTjN5swx58wWYlnSNPKm64xhl/+u
 ruM5Wf00EduVsay06eOYhhP5iIzEgOfqM3n4IchAi8vfYZUPbuHSLgNbyurTG6nXmdTS
 RTBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4eeqHqLCr9Ipk7luDHUzVwXVsqLqXZYocr7ugI3w7RgHdpyrKzU/lIsc1h5C8nN7lhbP8LvU=@lists.denx.de
X-Gm-Message-State: AOJu0YwQncO/ZBc9poz/O3cG5d40bM9iw/KzF8QRbiPF/0ptVK9YtRic
 Imqz9cgChEKIfyZ0P0bS8A1r7KolOBHWDUIf5YnDzVBN2ilSRUefCk0nBTl8QBox66Q=
X-Gm-Gg: ASbGncvi1JlCKU+Dt3X0emn5EWlyaoHGAaRc5XErmNjWGIY26nGqje8Ev8a5sG5cEmq
 wRRMsmMdD54xeLzURbLPoRysOad31y2uxreNaCgi7Er+NeYijKlImUTBiiMhzB67g7qhRWJBkox
 xLBLbm9d6nFElE6ft8S51ztvXC8P8QNkSTKORwww2BQdG/bEjjNAEkftKrvHBw/NuZmSGxIyj/J
 yu24aySLI+WGuX2etBe8nWrYVlDRzMKdof4gVh8BRHyMDyEKUZ4iK2vo8WaWBDa5mr3EQCoud8b
 kZsPXUKH02hmHa/XQdP35PxOOF88O5e6lgVt1lORTpeNh+71ceSxnWjNRO7uwIWCzQj/1zBWlPl
 y/9/A5FKqBpJk0ITHwKr9Mdz1
X-Google-Smtp-Source: AGHT+IF1Y2mX848jIpYvIknBbO2XdxhX/hlVvzO7PGKFrAdvfzX+6uLdKvo+hBTCPUaJkNyWYQqaEQ==
X-Received: by 2002:a17:906:fe49:b0:adb:335b:decb with SMTP id
 a640c23a62f3a-adfad318002mr1063369666b.24.1750142367611; 
 Mon, 16 Jun 2025 23:39:27 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec88ff1a1sm791655666b.89.2025.06.16.23.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 23:39:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Jun 2025 09:39:25 +0300
Message-Id: <DAOLOVHXW7MX.LAIVDE0UN7GN@linaro.org>
Subject: Re: [PATCH] disable VBE by default
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Peter Robinson" <pbrobinson@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.0
References: <20250615093344.159920-1-pbrobinson@gmail.com>
In-Reply-To: <20250615093344.159920-1-pbrobinson@gmail.com>
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

On Sun Jun 15, 2025 at 12:33 PM EEST, Peter Robinson wrote:
> The VBE protocol needs explicit device support and as
> such isn't particularly useful by itself without that,
> it also adds size and the potential of an attack vector
> so devices that wish to use this protocol should
> explicitly opt in to it like all other large features
> in U-Boot.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  boot/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7..e8c3fbcb11d 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -635,7 +635,6 @@ config BOOTMETH_QFW
>  config BOOTMETH_VBE
>  	bool "Bootdev support for Verified Boot for Embedded"
>  	depends on FIT
> -	default y
>  	select BOOTMETH_GLOBAL
>  	select EVENT
>  	help

