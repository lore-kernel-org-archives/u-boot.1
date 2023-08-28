Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49967C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE11086505;
	Mon, 28 Aug 2023 17:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="4aIzaUZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50FA8652D; Mon, 28 Aug 2023 17:27:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5993B864D8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so31216025e9.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236454; x=1693841254; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a6klCPKXOjaKM7xkxatJ4lnKCpNzjryXj7G3s2i4y60=;
 b=4aIzaUZai3++TbI/GyHVnePaBIlKK4d/aknattBAWlmHR4+GPDnecHas2TtxfbY+yh
 0c20vWvBcxF+KLlI0jdFc6SyfOqNXnCeOaxAyxb+A9ler5kbKkGgDg4QkM+3crDqM2XU
 wLSaZywCiAFDKDFaT39XzPjuwfHJrbiKiT8wMX4CceCCFmDRE1XkEGdS20W9Yq42CTbh
 HCn8fqdfJGRmNFaZlufJp8SiodbFD+Erf8ooxjzbnFULAa3KysZRwHRvEvsr8CF+070d
 UNZMm1VQBRKKqYhTdozZACs4kmb9QSS5XNaixHXpyBZd+TMJjEuSXs+0PvV+QK0coMcF
 WHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236454; x=1693841254;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6klCPKXOjaKM7xkxatJ4lnKCpNzjryXj7G3s2i4y60=;
 b=MetjIkaKIEfcglkjUtwLO8twsua/XSkI1XMfuvlRykihKvnC9loKio81kpUu2d3Z8z
 A0n1WLQsE+NV01udl0e9PDJL+TbZ7ufTWAvMwqI+OxyiXpY5gm6Xtt20J49ve/FEXK+z
 SFcSQigWBTMwH4g3DWWiVg8ulo8Iru9HUA6f76d8ZbvYYdykWlZjpVTt3WUZKCPpCxLD
 5EYJpR4yD/5M8PkXuDwWbNphHr61RuJfvTiH2OUjxdT/dzdARRv1Vajdf1kh/8kIFZ3s
 zTDagilXPhHE3eYI0CPNEIEm2FPeJ2DG8gqXXXyGIW0I3f25ZmISCciz/k02JSrJ5J6q
 GOuA==
X-Gm-Message-State: AOJu0YxvdcWb5VE+e+Vmk97vs+wlB9g1rdOfaDwas66jrlCyCO+pUSLh
 q1AATSCng/9OfhKYrqxq6AqOmg==
X-Google-Smtp-Source: AGHT+IF6JPUWb2AAA196IZCcVzUpThKUAR4OHNUYd79F2BuQNxRaWFg0GUQkQX3YSHkJASltTTpKxQ==
X-Received: by 2002:adf:ff8d:0:b0:31a:d4e4:4f63 with SMTP id
 j13-20020adfff8d000000b0031ad4e44f63mr22409501wrr.18.1693236453822; 
 Mon, 28 Aug 2023 08:27:33 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 z12-20020adff1cc000000b00317f29ad113sm10892820wro.32.2023.08.28.08.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:27:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 05/20] include: configs: am62x_evm: Wrap distroboot
 with CONFIG_DISTRO_DEFAULTS
In-Reply-To: <20230825180305.69515-6-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-6-nm@ti.com>
Date: Mon, 28 Aug 2023 17:27:32 +0200
Message-ID: <87edjnw5jv.fsf@baylibre.com>
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

> Wrap the distro_boot options with CONFIG_DISTRO_DEFAULTS.
>
> This is an intermediate step for us to switch over to
> CONFIG_BOOTSTD_DEFAULTS and drop this section in follow on patches.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change other than picking up reviews, tested tags along the way.
>
> V5: https://lore.kernel.org/r/20230824031101.3460411-4-nm@ti.com
>
>  include/configs/am62x_evm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> index 379e0c13a395..81d7658cdb0d 100644
> --- a/include/configs/am62x_evm.h
> +++ b/include/configs/am62x_evm.h
> @@ -9,8 +9,10 @@
>  #ifndef __CONFIG_AM625_EVM_H
>  #define __CONFIG_AM625_EVM_H
>=20=20
> +#ifdef CONFIG_DISTRO_DEFAULTS
>  #include <config_distro_bootcmd.h>
>  #include <env/ti/mmc.h>
> +#endif
>=20=20
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
> --=20
> 2.40.0
