Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2025C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 10:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378C68808B;
	Fri, 12 Jul 2024 12:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwKoicTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 698088871F; Fri, 12 Jul 2024 12:22:10 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE8B87FCD
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 12:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58b447c51bfso2333666a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720779728; x=1721384528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJ8ejE0KRAgaLS7buSmDK0VBe75UjT+BFqb4Jiii2Rc=;
 b=EwKoicTbM4F7Q+aCFuQbhql2ymu2wFNYw4B4iUCFfC8li44qDmvFUlHl8TMwEAL2uB
 ppSXolc5Wt4xp3wX2yKnffuYD/TjJculzLbvghuDQ8E1a2w+EyZR4/vA2miDLxs6eS6l
 qUDqp2SH1ANfTVnEzbVFBhJniZ1ltI01SYMbe4BzcdoCUq4SmfO+gLZPD0QNeXyppTVK
 bwf/Y2s3IrftkX0+vDu5wuu8hBzx+5ngiAM4hDuhBwCVz2lfg22XOAaLbm4bq77Ll+xq
 9l5tiX0uEi4m5JGEtKXmjf+H4OS7fuTl0Fz0Ol7FNjLQ/xzLQaYj5G9GXlNQOqE5HK9t
 b5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720779728; x=1721384528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJ8ejE0KRAgaLS7buSmDK0VBe75UjT+BFqb4Jiii2Rc=;
 b=KyimIa1WfGTlacg0I+8WllA4V1hf68UzRDh7f0Mmy4719Vh9iEKMZXwiGy8o+Sp1jy
 iZfCyK+N5p6VBaKF8slhE5qzpfs+FFZqJy9C6CvtpuTAaUi73LqDmoFWNlgB84/Kwsb6
 Esry/qXQOjdNRKBl64LzGZaoi7nUUUkNRSkMvpqeDLQPJgA8n6DTiwo6oGY7F1Ujhj3F
 GxA5u6FJ6GXlN+2vy3eQbVa9ztHIdHSqN2/gG/d0ybXeJjQ6PLdF9QG3VTe9axCSZD/J
 EyKPC30Wznem36uJSGVhFefvJu2qhiBbVcwzfwEze8BsKpFoP8hDGiU647ls0EA61JOg
 bRSw==
X-Gm-Message-State: AOJu0YxVzvMMnNgW+5vQD1fsv4dg8vmQXmD5f2BwCqk1po7OgmWTBGZv
 eJtFdSliFB4turGatjx0BRLiUPLghgRr5vuJZA/Kms+umGG2XseTLYceKdzGmOL1b/UJqv6AZ5S
 UmelhRHM8z9sbhr5gOVT5R/XOpEs=
X-Google-Smtp-Source: AGHT+IHA+WNEbyAObOgLj25PrpdLusz+iqT5Zyo9GHl4lfbwhhzom60PFXdl8/TpUJY744KA/geTyDLYc/wP/Le7sK4=
X-Received: by 2002:a05:6402:524f:b0:585:357a:87c0 with SMTP id
 4fb4d7f45d1cf-594ba98efdemr8913031a12.3.1720779727819; Fri, 12 Jul 2024
 03:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <20240712090725.2093317-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240712090725.2093317-3-rasmus.villemoes@prevas.dk>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jul 2024 11:21:56 +0100
Message-ID: <CALeDE9O4X2_kKP0+gM1vmSxxq+Qv85vkMWMJXkAZqvh1cm+FTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: rpi: remove leftover CONFIG_HW_WATCHDOG
 block
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
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

On Fri, 12 Jul 2024 at 10:07, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> This was added in commit 45a6d231b2f (bcm2835_wdt: support for the
> BCM2835/2836 watchdog), which did do 'select HW_WATCHDOG'. That
> incarnation of the watchdog driver later got removed in
> c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x watchdog
> driver and its references), but this block was left behind.
>
> Another rpi watchdog driver has since been added, but that does not
> select HW_WATCHDOG, so this remains dead and unused. Remove it.
>
> Reviewed-by: Stefan Roese <sr@denx.de>

Thanks for the cleanup and updated commit.

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  board/raspberrypi/rpi/rpi.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index d996eb0cf69..9a83cf2d6a7 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -493,10 +493,6 @@ static void get_board_revision(void)
>
>  int board_init(void)
>  {
> -#ifdef CONFIG_HW_WATCHDOG
> -       hw_watchdog_init();
> -#endif
> -
>         get_board_revision();
>
>         gd->bd->bi_boot_params = 0x100;
> --
> 2.45.2
>
