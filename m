Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01E4C36002
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1673D81DCD;
	Sun, 23 Mar 2025 13:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJ6+ULct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D890581DD6; Sun, 23 Mar 2025 13:15:52 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0D980548
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8f8657f29so30352296d6.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732149; x=1743336949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb1mvFP2lGRkiznc149z3tKA9A75A3HPaTIb1rD6G3c=;
 b=DJ6+ULctn2Jj0KfqmYTYwcdZpM0uYxn7y4MKc8yQryhxiCPEmeG/URJPyjETCu2Hok
 sUabiIJqrojDasweFjzlZnTu2zNeBr7KzSlD9DWHLpHO3cME5SfpLpciOJuJrAZtVTcZ
 acUIf7GQT+w+WZGqcINr+JQZre/+Wzv+v2atKE81C63cpT4N4mISPvDcffIOoogJrlSu
 4pxTwY8J30wSmBDGoJqoHocvOp0uH9FaCGYVCgOgljlerc3DZE6bV1u3ByTU9EOML3gM
 7kgWMlhif17/+XvubfewY9D27cDufvRX2L2ISkS4PDMu6D/me8Ti1wpU8/znpwZeT5N7
 HPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732149; x=1743336949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb1mvFP2lGRkiznc149z3tKA9A75A3HPaTIb1rD6G3c=;
 b=lAZj7hwNYldhVnOEi0sqOuI9UvmolkYOcp9BSG3mDe32eR4Ol9k++0cjJf2MsRRKb0
 HwtbuFnnWEDfAlFG2FRcaRbiLGvBT0o2+ZYAUX45XfkbOLPU6r300yESl/awyFPAAT7l
 3bd3ep/BwIV7pojWJ67GvU3110a26qYoQodbEiKORqS+j6YFflcHP6aYY7ZwrMPUDcyp
 gjj81BQtszeTi4pQfZ8qal64HusvVovXwgKw9bEXd5RXTNNi5YbETEgdKDQiEyzRqq+N
 Gp9xYpoQYRX4fB8ktYU9tlV/dtW5mmYy69LwqsixfM1XBY3lKq4nJX+pGwohMm94XBn8
 71gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+o/et2x5LvUPul3DZT+hUAAJTnRayzWXLZP3SV5+L+R3H6TzfsSVqunePx1afd+qf7TyhRgQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6io8LYFp/4JFtbB3ftTCNfQ/rYYPrneoUHAQ1+hl/TMMKnM+b
 jq4fe6L9f9VYXNrEkz83x6xSVPWkUGmhbLogr+ekchKfVDsGP8Gp
X-Gm-Gg: ASbGncszUeStNj5IxdqhCwIVRc8hcHWPqOmdsJuo2Yl4t+wsHutBvQNhIhDt2W1ROhH
 7Jc6VycMDnIxuwuac+lSWZ1kG+oMaa/P66+rX5kAQzJI7ObSr0N8pDuRDX5m+bQHgw9mszuitt6
 evhIq7NORjI9Hl+uUw5GK+Oa5FxSv9E3Xns6LC1L+aI7Ia+QG23xqHhqlfi1XAc4O87X4qsHrNy
 PAXeeoll6PSxdmFM7UzZ0KtaDq4eh3dZbtLyAI+e1vX0FMUyHosOHhxfklQVoLlYUBP5lVRIOlj
 +KfS77hS2tqMAjbkuzRn8kUHoPk7tX1LQbJFdnQbI527a6TkspxxMGzA2YpY1cg4yrzpM+6Fysh
 Kb4GtjGr+9yLHcIYVeKe7
X-Google-Smtp-Source: AGHT+IH55rxZr3I5xwuhzw+Sd6vVT7ck6sOx5bdvALxBSmpLBk4xYTXNYaEpyFa104EZRNwdb+Bxuw==
X-Received: by 2002:a05:6214:d64:b0:6e8:9e8f:cfb with SMTP id
 6a1803df08f44-6eb3f2e309bmr105818336d6.24.1742732149487; 
 Sun, 23 Mar 2025 05:15:49 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3efe0c9csm31660146d6.95.2025.03.23.05.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:15:49 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 13/34] sunxi: spl: add support for Allwinner A523 watchdog
Date: Sun, 23 Mar 2025 13:15:46 +0100
Message-ID: <13723892.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20250323113544.7933-14-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-14-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:23 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> The watchdog in the Allwinner A523 SoC differs a bit from the one in the
> previous SoCs: it lives in a separate register frame, so no longer
> inside some timer device, and it manages to shuffle around some
> registers a bit.
>=20
> Provide a new struct describing the register layout, and adjust the
> address calculation in the SPL code accoringly. This is guarded by the
> MACH_SUN55I_A523 Kconfig variable.

This one is missing SoB, apparently by me :)

> ---
>  arch/arm/include/asm/arch-sunxi/watchdog.h | 12 ++++++++++++
>  arch/arm/mach-sunxi/board.c                |  6 ++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/watchdog.h b/arch/arm/includ=
e/asm/arch-sunxi/watchdog.h
> index 38e2ef2aca3..96d5725141e 100644
> --- a/arch/arm/include/asm/arch-sunxi/watchdog.h
> +++ b/arch/arm/include/asm/arch-sunxi/watchdog.h
> @@ -26,6 +26,18 @@ struct sunxi_wdog {
>  	u32 res[2];
>  };
> =20
> +#elif defined(CONFIG_MACH_SUN55I_A523)
> +
> +struct sunxi_wdog {
> +	u32 irq_en;		/* 0x00 */
> +	u32 irq_sta;		/* 0x04 */
> +	u32 srst;		/* 0x08 */
> +	u32 ctl;		/* 0x0c */
> +	u32 cfg;		/* 0x10 */
> +	u32 mode;		/* 0x14 */
> +	u32 ocfg;		/* 0x18 */
> +};

Anyway, since you announced battle against C structures for register
layout, it seems contraproductive to add it here. What do you think?

Best regards,
Jernej

> +
>  #else
> =20
>  #define WDT_CFG_RESET		(0x1)
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 701899ee4b2..89aea61e8e8 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -495,6 +495,12 @@ void reset_cpu(void)
>  		/* sun5i sometimes gets stuck without this */
>  		writel(WDT_MODE_RESET_EN | WDT_MODE_EN, &wdog->mode);
>  	}
> +#elif defined(CONFIG_MACH_SUN55I_A523)
> +	static const struct sunxi_wdog *wdog =3D
> +		(struct sunxi_wdog *)SUNXI_TIMER_BASE;
> +
> +	writel(WDT_CTRL_KEY | WDT_CTRL_RESTART, &wdog->srst);
> +	while (1) { }
>  #elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) |=
| defined(CONFIG_SUNXI_GEN_NCAT2)
>  #if defined(CONFIG_MACH_SUN50I_H6)
>  	/* WDOG is broken for some H6 rev. use the R_WDOG instead */
>=20




