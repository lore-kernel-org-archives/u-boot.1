Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED744C54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8868884F;
	Wed, 28 Aug 2024 14:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NUHbHLJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1D888874; Wed, 28 Aug 2024 14:28:37 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721C488847
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f4f2868621so65158871fa.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724848115; x=1725452915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NinaZYi4H8UYjgwc51GI4dgvidusHCuhuLQbNqc1wYc=;
 b=NUHbHLJUsSl7DAFb5xJ6tj3j97oue/rm5v5QTusrHMKglhiseKd4rKZvIJSfi59LBl
 bLxQVmf2lwqQE0ckeGe/JS7fgK2qIMgzeOcezU29e2ogEE9YCY9JcqO4Nlx+YR9N0aRb
 RamvHc5fAIY6uhtVzufMWHfyEHzILlaUi9+Cvv5aZf7SPQgh0gOBPH1W/wo0U7y2kbo0
 6mFrA9vlTcbkmUT5E6ThbFBsjz9nW0s/CdNbNXW+WCaQkgiogKr1D+xHg5CEUTV+5h+G
 LVBfaaYFiPLDZT4J8lhU+2AGYCJK6hRBG96VR44Gpj2tRscIklV73Gcqnfv9ZubyoN1Q
 JEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724848115; x=1725452915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NinaZYi4H8UYjgwc51GI4dgvidusHCuhuLQbNqc1wYc=;
 b=PpyI9ZpeJUkgfy+BQc+vV1+s8EjrvOuojwdbfB8iN1M3Tg/MUUTw4tUZg9C07Js2OJ
 Pv1wUOhaLpUKMm5M+g9LElLznXMJgvJapohSPhjYQqZYTbrqefr0UzG5DL6UjlNqP5P0
 CBlIDQAqnuUvwPtRfud/QsRMoTxh/mp8mG1Auh/O3abhlKH7TQ4PuMCZdet5GXuj+DZD
 XAzu4uwDT8tuX5dRFrsJVOvhmLcprXbSMuijb4ovLCZ1+f+TKAgwUN5VlJVqght+Xvqq
 Y0SBLBQ8sX7NNC+NzsyD9babyYoqrHH7OdLK40fq7LHqMXPyViBU3HrxMafL+HMS0NhF
 7nfA==
X-Gm-Message-State: AOJu0YwmexrKn7u1hYsilWsu/9NN+fAtMH0Um1voNKriKJYuaSKklAiP
 z9K32+eSq0+fLQR3/H3X2vt58qNMSQ6D3HlBijxnBsT8QGyR/VChi+ShylslKjMzCgeFhHhGzVG
 AWtZDAIkTSFu4soBxuMvIaVyRtl0=
X-Google-Smtp-Source: AGHT+IFiSw4j9t8/l6FCY65BljpAWIdt+/yXx0wDvf+Lawi0MwTnyxNTnVDIa/FHxf7XkZlddVXAjGSqbRgGOy6Gq9M=
X-Received: by 2002:a2e:9295:0:b0:2ec:55b5:ed45 with SMTP id
 38308e7fff4ca-2f4f576b20fmr99969471fa.24.1724848114168; Wed, 28 Aug 2024
 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
In-Reply-To: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 09:28:22 -0300
Message-ID: <CAOMZO5Cb3gpczg8EKbNna+evc-MphK172=_4j4rqGF_VAnWQ5A@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, marex@denx.de, trini@konsulko.com, 
 francesco.dolcini@toradex.com, tharvey@gateworks.com, aford173@gmail.com, 
 peng.fan@nxp.com, ye.li@nxp.com, michael@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Tomas,

On Wed, Aug 28, 2024 at 2:58=E2=80=AFAM Tomas Paukrt <tomaspaukrt@email.cz>=
 wrote:

>         regs =3D (struct gpio_regs *)gpio_ports[port];
>
> -       val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
> +       if ((readl(&regs->gpio_dir) >> offset) & 0x01)

This does not build:

drivers/gpio/mxc_gpio.c: In function =E2=80=98gpio_get_value=E2=80=99:
drivers/gpio/mxc_gpio.c:136:40: error: =E2=80=98offset=E2=80=99 undeclared =
(first use
in this function); did you mean =E2=80=98off_t=E2=80=99?
  136 |         if ((readl(&regs->gpio_dir) >> offset) & 0x01)
