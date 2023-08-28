Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A018FC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124CC86505;
	Mon, 28 Aug 2023 17:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="kSRUvWzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B1F8651A; Mon, 28 Aug 2023 17:25:37 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDFD864D8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so31190865e9.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236334; x=1693841134; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=auGDTmaLMBznTTyW1lJ7RsIOi1+ELW7ZSteYsu5OuZU=;
 b=kSRUvWziX78zpPexL8Kk0Ce0GwiF9NRp3N6qLYPkFFMXAlKLa1U7kRALqONgfV7UUR
 lZNNKrYV4tNGeXG1fMg0dmOz3ajcm4C3Ls99EH9yRA1H1az96ILrqoKMF5bPihcWJ2dJ
 0Zdas95hWzivPwrZoaNLjAjRJZv0HxvYBcj69H9opv/anlfbD5MpRlwKFW+ENlOjRPL9
 LiGGVrLeYPf6/pk6B1ROjMAAR4TUk7EcxLOz5zk9LbzCc3/L/+1yrSKUeKWQ+SHQwe70
 ENuJpcd+Q93Ktif0d62vhMD32BJGBbIGE1L1bh1FoU6JM70J1ZP5X87e4Sl7ewodtnoC
 DCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236334; x=1693841134;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=auGDTmaLMBznTTyW1lJ7RsIOi1+ELW7ZSteYsu5OuZU=;
 b=e2lgFHCduLaPV8YVJj8+eq4m5cvhmY3aumUYSMKdAQ9ALgH/0+L3QcCvMT0T4rqZ1L
 HbYJeujcdW3ayHO08no8Dxa2mmqb6F0HaY9l4447Ja/yKnDk7wbTzQqNK+frR2oLYaMX
 EC+lFck1OO9OiVyVOuobIs3f+7KwEHlTA6QrSvo3VB6amNOngFDQ9tPsopVJFNqfWi0e
 93s6A7ynQDHpetgRvAoyXN2YzzdOyy63pYUDNv26hs92u9vr8bhXHhV+ahObjaMJiFth
 CLW8i+/s5ZNzyaahnFW60ptso7esmaPh/eUNKfd6ROcRg+XbItmMzQ0hyCTXxt0HWMY7
 FECA==
X-Gm-Message-State: AOJu0YwAS75ytJluH8tUZ4d05NCFX/SyCTw4BUwpABaFQV+vqHgAzVgz
 0uHFoKeuFSltGdi5Vm6o2P/enQ==
X-Google-Smtp-Source: AGHT+IFkqO8JVrm+xxTutSAZ7FA8HBx7pPRXNzmrInRgzwGyXWVUXLLMlX6IiMvjuFMEPRcRFK7eqQ==
X-Received: by 2002:a05:600c:2210:b0:401:d258:ad26 with SMTP id
 z16-20020a05600c221000b00401d258ad26mr203200wml.19.1693236334266; 
 Mon, 28 Aug 2023 08:25:34 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c229000b003fff96bb62csm11066888wmf.16.2023.08.28.08.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:25:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 02/20] include: env: ti: mmc: envboot: Only attempt
 boot.scr if BOOTSTD is not enabled
In-Reply-To: <20230825180305.69515-3-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-3-nm@ti.com>
Date: Mon, 28 Aug 2023 17:25:33 +0200
Message-ID: <87jztfw5n6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> 'script' bootmethod that should be used with CONFIG_BOOTSTD.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Since Simon educated me to realize that the published documentation can
> be stale and bootmeths=3Dscript does indeed work for some time despite
> what the docs say..
>
>  include/env/ti/mmc.env | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
> index b8eb51ca1744..0256a2d2aaca 100644
> --- a/include/env/ti/mmc.env
> +++ b/include/env/ti/mmc.env
> @@ -5,7 +5,9 @@ args_mmc=3Drun finduuid;setenv bootargs console=3D${conso=
le}
>  	${optargs}
>  	root=3DPARTUUID=3D${uuid} rw
>  	rootfstype=3D${mmcrootfstype}
> +#ifndef CONFIG_BOOTSTD
>  loadbootscript=3Dload mmc ${mmcdev} ${loadaddr} boot.scr
> +#endif
>  bootscript=3Decho Running bootscript from mmc${mmcdev} ...;
>  	source ${loadaddr}
>  bootenvfile=3DuEnv.txt
> @@ -18,7 +20,7 @@ get_fdt_mmc=3Dload mmc ${bootpart} ${fdtaddr} ${bootdir=
}/dtb/${name_fdt}
>  envboot=3Dif mmc dev ${mmcdev}; then
>  	if mmc rescan; then
>  		echo SD/MMC found on device ${mmcdev};
> -		if run loadbootscript; then
> +		if test -n "${loadbootscript}" && run loadbootscript; then
>  			run bootscript;
>  		else
>  			if run loadbootenv; then
> --=20
> 2.40.0
