Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CDC83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 18:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F3F83599;
	Wed,  9 Jul 2025 20:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aqOF6tx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A842835A5; Wed,  9 Jul 2025 20:35:29 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9EB83564
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 20:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5562838ce68so111503e87.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752086127; x=1752690927; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNQJbUFLjycgbFRJjw8JGS8vA51VO4RHzbqfv25oJk8=;
 b=aqOF6tx5zk7ZuhUeM72cniiEuLOLqBYCepJbPWBlHXA3w0jb+iBvIRsVkCxztFWir5
 KPyA/OZG6e1Pb5N6S6fUkBYZzxNCcmd+rTh3wYQhuKwSuI8uaMwAI+ShCVa4MtkDr1YB
 gnPfx7C/QQFbJJjDWlfz+bT3a+ypjt1ZB6PgBWdM3mxLBQz4K5H9k69XhR8NHQInFtRk
 melxhkevBYhtKVf0tEKwmOMpJ9q1UTUwDN0pb0nmOOqURWI6ovQP1JEjnKD6DxjiFqec
 PqKnksmTLdHB5s7SmEkrybAEV0COfggWJNhlPNrzOKFWSj0NsgC5mOZY8Wo1QsXX8ZS9
 B/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752086127; x=1752690927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNQJbUFLjycgbFRJjw8JGS8vA51VO4RHzbqfv25oJk8=;
 b=hPmnZBh8I9gu+5sBZn0X30Odm5qqOgeyLEl9pNEsR0NBJpM8WciIcqJQSHdPEw/MsN
 VerNnJLiSt+F4vI11LuCJcvEIURi9FwL9iTkwG/NADYdZgM0gHEY97JJ2dvJr7Q7G2ib
 rawmiUmPytigE8R8rGD7isOVVEZuwNd3/fGg0urRZubr3aAKmMogurLSODqjAiZUADAG
 /ptzfNMm8lGRv2mvd1sQQwXM7gVeN6A68t+Q3Q3RQzS02RAOoXHqwGxDxbukf/OrITr9
 lvztcByjd3U/i0TadZkmM6wjs9U0oEKkrvS1w7f9qGSI6If1eyGvwQS4Y3d8mnbEzC6D
 iITg==
X-Gm-Message-State: AOJu0YzJNtWPNDbqQ3qciH/yNDBph0Nw6XWamULybjqH1JkmeTG5F//o
 Kf+tBZn+Tqv2DWhFD7l1fTF4sTmDODLlFt4+H7hx8vv5deVl0//Q1VjFNEaKPAa7SQU8CWIwkgs
 iwFXsEWPC8zrM0xS+ztBzgWdOFk/xDE0=
X-Gm-Gg: ASbGnctFcuxFKoVtCf4dH/K5FIlogxXz2mydQvM3zjcO+OnV5ep9k61GNHshFr+/Qkk
 Cea+4aoVS13KNnldqIMoLBQ4upC5t1vC7MaV6crAMxTpBd06Uo5h6NRkWMbLt3WFRpkL57o0tiS
 SDkqUU7nT0sbmvy3FtOl4Pg4YXeWNb2vszSMtbZjlHv9mnv4mp7fZz0J8PVGlZHZWHWfTfvo6Y2
 g==
X-Google-Smtp-Source: AGHT+IGyJ5yEkKUMVwqwfgLdvD2pwy/cFSWHc4UwqGOax2F/Vb0N1I9YVUZXaoTo7ntl8Vzd5XVZXmxR+NkuZLWfwEw=
X-Received: by 2002:a05:6512:2315:b0:553:d17a:d01d with SMTP id
 2adb3069b0e04-5590004d044mr288551e87.14.1752086126248; Wed, 09 Jul 2025
 11:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250709183217.3392140-1-tharvey@gateworks.com>
 <20250709183217.3392140-4-tharvey@gateworks.com>
In-Reply-To: <20250709183217.3392140-4-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 Jul 2025 15:35:14 -0300
X-Gm-Features: Ac12FXzEE4yaqK7LoBeuKq8pqxWUYvMxH_FErKKSPXlHyKoIFmV0p8yjkNXyca8
Message-ID: <CAOMZO5DsDXkEziirU_BPBVg0Z9Ky08Ucdc+pWZH1hzj1u2OBJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] venice: display DRAM MR registers and decoding if
 debug enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

Hi Tim,

On Wed, Jul 9, 2025 at 3:32=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> While this is interesting and useful for debugging there isn't extremely
> useful information so we will only show it if debug is enabled.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  board/gateworks/venice/spl.c | 61 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
> index d9bc593fa0d5..5f621ade9287 100644
> --- a/board/gateworks/venice/spl.c
> +++ b/board/gateworks/venice/spl.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright 2021 Gateworks Corporation
>   */
> +#define DEBUG

I believe this DEBUG definition was left by mistake?
