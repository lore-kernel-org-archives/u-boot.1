Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB46C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375F4885C8;
	Wed,  1 May 2024 22:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gr2YpaMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E008A88AE9; Wed,  1 May 2024 22:29:29 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF3388592
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so6887680a12.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714595367; x=1715200167; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1qJhkYTN9FB8yyGvtivNTExUbX+WD2ojZZqzWh+RFg=;
 b=gr2YpaMC1la5fL1XPuFQQ55p/EToCYYxrEdomG0Xjpa1e1yxyLR+jgoqyJOIfnGlNM
 +sLk0xvGfWFlhT+avSsEls1Xpu9vw5FG1AKoipRbDbg/C0bSkfrEkSLd0750UuvjvwA8
 ioFv2MRPhLuKbshj1WZHDrkzaXNthZ8Pnnwp4KBN0WUqAKZVGwFIO6qPifl2+j4dziMY
 rG0pteyeNzRsz0UHvpYnroMp/bP9rCmi3dv55eT239lHbTZavbWpUEN+n90Q1WYr8Xn2
 hQ0okJL6YEzw6EYip+57N0VD9tMKOTc/uCaO8pqxfMIY9BS9WGgtLk53fdsJER8+FsjU
 bgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714595367; x=1715200167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1qJhkYTN9FB8yyGvtivNTExUbX+WD2ojZZqzWh+RFg=;
 b=bjimHe0tGSHzGeHe8UNtklPVYZWUdzjhXFJdVCOw6wEeZQ/gqgYyE9VUf1zwwqYESk
 cPwYc/npsjxiRr17y6RnzgcTRpZ02U9A3AhXb2D43Rg9khW6lfylvnmHBcgm4RdpB1QH
 pfgTjm8KOjOKCYCFhw2WOca3OBai6CMTbhGKwKBvAwOEh2ouZtQ3V7oz3Cj+mvuGQiGB
 ZE4cumzg3hUdnFjgerLVVcHogR8yrOhNbjbSknYfj1jET2KrzhZ14bBe9QV5aKmzJSab
 xIGLvBHJaJaIBpFI7mNgr3cPac1IbHQSFS5LVtz4oUnZngS/sqNOmGtvjHQ8hhU6uAA2
 WqUg==
X-Gm-Message-State: AOJu0YxFMAMzMWHxG3/dE5TtXiLdiMeDPalvJJim42kF1WzEWpLoQu6J
 3x/8iU0N+NgsCZmx3xh9laOFr0Jm74rJTYHOLSSjTtq+mngwUIT2l9Ti69NC9D9TNQM4/chvOxQ
 2BZjAEFFvwu1TpoBs7FbIgC5UGnM=
X-Google-Smtp-Source: AGHT+IFh8v7mPl6/t41KbFNFOBagFyV7xbKdOV8rhengxrJN9hqzCKPdEzEAqBj+bnGmX4+oUDMs2100/lV3iwxvQPM=
X-Received: by 2002:a50:99d4:0:b0:566:2f24:b063 with SMTP id
 n20-20020a5099d4000000b005662f24b063mr2533795edb.23.1714595366610; Wed, 01
 May 2024 13:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-149-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-149-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 13:29:02 -0700
Message-ID: <CAJaLiFz8Lev7TuLa9STxiat59sJ39_JsPg5YzAgXS6gya8q40Q@mail.gmail.com>
Subject: Re: [PATCH 149/149] board: zyxel: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Luka Perkov <luka.perkov@sartura.hr>
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

On Tue, Apr 30, 2024 at 7:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Luka Perkov <luka.perkov@sartura.hr>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>
Tested-by: Tony Dinh <mibodhi@gmail.com> # on Zyxel NSA310s

> ---
>  board/zyxel/nsa310s/nsa310s.c | 1 -
>  board/zyxel/nsa325/nsa325.c   | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/board/zyxel/nsa310s/nsa310s.c b/board/zyxel/nsa310s/nsa310s.=
c
> index b3ea6608914a..d018b5738242 100644
> --- a/board/zyxel/nsa310s/nsa310s.c
> +++ b/board/zyxel/nsa310s/nsa310s.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2015 Gerald Kerma <dreagle@doukki.net>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <netdev.h>
>  #include <asm/arch/cpu.h>
> diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
> index f5f63ee5d3b0..38340b33c8bf 100644
> --- a/board/zyxel/nsa325/nsa325.c
> +++ b/board/zyxel/nsa325/nsa325.c
> @@ -14,7 +14,6 @@
>   * Marvell Semiconductor <www.marvell.com>
>   */
>
> -#include <common.h>
>  #include <asm/arch/soc.h>
>  #include <asm/arch/mpp.h>
>  #include <netdev.h>
> --
> 2.34.1
>
