Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD61E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9E1801CF;
	Mon, 16 Dec 2024 16:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B5580141; Mon, 16 Dec 2024 16:00:16 +0100 (CET)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46428003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3043e84c687so5227281fa.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361211; x=1734966011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zW7bZzCvEG9vXH7hmhUpYlJcI+Z/kO6+zIFWocpGb5Q=;
 b=p8LKHkUKK/jkHe6kWmaCsdbK5/YgmEsEmdj8lzMMADcwblVtv+TmHFkS00oXSPhOSF
 VDRGNCZF38ZOqH2aJgUpkms19zJVZNR8O33XRgbkIebO/oU5W/5dtu7pQCcd9jW9jeJj
 nsC7DvcX7ZhQOSsh6zy3GVu+4eJ+eXFt59t0UxHWxF6nkIgR+LXDSz2nObBb4ngJu7Mk
 x/VM/AU5tS30ZKTJFU3o2mRgJeilwX4ngJSIgosAcvAY8FpsCmIH40RlGt2wVMUAsO/A
 QKLi5VeHo8syuvry7AER/A9wegMYdFVWPbwvMuHOHdJbzyX6OUhE7+1u/51cK6mF/sFf
 RK/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV+hVVe1uFES7kkeiOH0a7DQHB/+1JXX5ZNEcbrj6iPx088Csh2JvUaXljito6DEo788p7Qxs=@lists.denx.de
X-Gm-Message-State: AOJu0YzmHMT3nb09bCHcUaL607fhOkUuxqnMINhcGXC1U58B7w26vQjk
 Ytd6P9I3ig01rxxx2HP/ScoDoh1kFLZg0HOolFs3eC/yqYFYXpuoaiOOLr4A
X-Gm-Gg: ASbGncux2qkR0hmXbHgfD6+GwPx1cHefAXfZbDBJsGdfvRJb/DBxC7ab+xwYYm843qK
 h2i8kMbkle/oK4lBEiCQDbLMasHAZy2Q/QMcST3HG804cKjp+lsKIIL756YTc0oxu53K1E0svoG
 +RL8//IQNW7OKHFQjOYzxmCuYt+3PrOlOjZVzK51DLLKlgVaHgWSy7wd4WeKl13mq+ahvSfOV1Y
 8fXEe6OghW7k6JjR65gr1MVRBhinVkXEHoVPo4J+xogljpiTtO12HcO31wni+yy88W+jLPcza8D
 +NkHf3+NmS5kmg==
X-Google-Smtp-Source: AGHT+IHppcB+dBYaqR8bzjmbeMGbyCS4b7cR7YSBmCgilaP0c09aGLGqUpphVp3xtHdmadoZFd3Eng==
X-Received: by 2002:a05:651c:1994:b0:300:3a15:8f19 with SMTP id
 38308e7fff4ca-30254611fafmr53430261fa.32.1734361210418; 
 Mon, 16 Dec 2024 07:00:10 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30344175ae4sm9524711fa.78.2024.12.16.07.00.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:00:10 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30037784fceso41455481fa.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:00:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV0SVSLLFxoW6zH0MIwZrA6HbHCLzyv8AO3HE7eVo5PoJNtTQ/5t/nFLhWp//3l7Nw+GhrjdBQ=@lists.denx.de
X-Received: by 2002:a05:651c:2108:b0:302:3de5:b039 with SMTP id
 38308e7fff4ca-30254566a55mr47627831fa.8.1734361209666; Mon, 16 Dec 2024
 07:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20241215221331.28461-1-andre.przywara@arm.com>
In-Reply-To: <20241215221331.28461-1-andre.przywara@arm.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 16 Dec 2024 22:59:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Csz+cWY=oCr7fFWCJoeF5jOXBvThOJYBTWkp7qbn24A@mail.gmail.com>
Message-ID: <CAGb2v64Csz+cWY=oCr7fFWCJoeF5jOXBvThOJYBTWkp7qbn24A@mail.gmail.com>
Subject: Re: [PATCH] power: pmic: sunxi: guard DCDC5 separately
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 linux-sunxi@lists.linux.dev, Leon Anavi <leon.anavi@konsulko.com>,
 lhristov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Dec 2024 16:40:29 +0100
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Dec 16, 2024 at 6:14=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> So far all sunxi boards programming the DCDC1 power rail on the AXP PMIC
> also set the DCDC5 rail, so we could handle both with the same DCDC1
> guard.
> Some boards using the AXP313 will need to set DCDC1 now as well, and
> since the AXP313 only has three buck converters, there will be no DCDC5,
> so this trick is not going to work anymore.
>
> Don't try to be too clever, and just protect programming the two DCDC
> rails with two separate guards.
>
> This has the interesting side effect of fixing operation on A80 boards,
> using the AXP809 PMIC. Apparently programming DCDC5 right after DCDC1,
> but before the other three rails caused some glitch, which made the board
> hang during Linux boot, during the PSCI handler in U-Boot. Just keeping
> the old setup order (DCDC1,2,3,4,5) will make those boards boot to the
> Linux prompt again.
>
> Fixes: ffb02942fab024d4a9b6a ("sunxi: board: simplify early PMIC setup co=
nditions")
> Reported-by: Leon Anavi <leon.anavi@konsulko.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  board/sunxi/board.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 824c322a0dc..9c340908a96 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -577,7 +577,6 @@ void sunxi_board_init(void)
>
>  #ifdef CONFIG_AXP_DCDC1_VOLT
>         power_failed |=3D axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
> -       power_failed |=3D axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
>  #endif
>  #ifdef CONFIG_AXP_DCDC2_VOLT
>         power_failed |=3D axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
> @@ -586,6 +585,9 @@ void sunxi_board_init(void)
>  #ifdef CONFIG_AXP_DCDC4_VOLT
>         power_failed |=3D axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
>  #endif
> +#ifdef CONFIG_AXP_DCDC5_VOLT
> +       power_failed |=3D axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
> +#endif
>
>  #ifdef CONFIG_AXP_ALDO1_VOLT
>         power_failed |=3D axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
> --
> 2.46.2
>
