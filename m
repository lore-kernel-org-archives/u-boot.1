Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77177CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE51983096;
	Mon, 11 Aug 2025 17:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCes6Dib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F346E8309E; Mon, 11 Aug 2025 17:34:54 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3E683093
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so2982436f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754926489; x=1755531289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pa5H7WjqtxlkYf4utEsbVoLUNd3hZDF6fSnW+rnO1uM=;
 b=hCes6DibNfDxnSNqqmQUUA/6vIH7R3gWgs1Jkrhgl80XMAp8zUUPOmEkkWX82JC+SL
 dlL85rRkvm7PAPvPiVJH/B0HOzdGv+GGE2W5kFvItR/7YQOp1lp2NSM/smoMseJSYLoX
 /CfL9mrrtwQ/xrXxNFuB7FZjFL9WeS1UIu1Sk0Sl7ZAEpKVFRDerSVtIWR0LVFN/2EKS
 Qi7yewSRB6iRxZNLmxxzyN1e5E+Z06oundh/Xx46D4/H3fqh7A0nVRwtmRo9T3skawSu
 WQQHMTe/1zNdTUjW5d7v7C3jPmBXe9V62WHaUqdB0svTHRgR+sGbHLHg+7MC9hKeai/v
 Qnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754926489; x=1755531289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pa5H7WjqtxlkYf4utEsbVoLUNd3hZDF6fSnW+rnO1uM=;
 b=VA8lEAYZuAtyJCHcBci3jfhWoQzIua4qril2xiGppycGV+xLzF/YAdTyNY4gSUmSHR
 UKtHFQgpAiNq759nUV9QCiezwSbcTMeoJNaR2K9Msi0oP4aCb+Z/oiWCh4qPeVtvSonk
 sdU1aiVF1CcTxcmt7cDs0fT2r7cFDQ5t7JuYkxvhlbGefvK78YdDfnG/L5uJX0WDcjtM
 kx75G209hWkPMlpy+DKrOYmfz7y2Z86S7xTa2/akntBdMSnxbYs4l493qDKYSY/7CoC8
 eKLKnnyCLivkYg0hGr51ZpbQvNcZHX9XTF5u1Vk9WxJIEkLHnc1cAUek8sbulo4u1X64
 KpYw==
X-Gm-Message-State: AOJu0YwZLFK5Yp7We/12FW2nf6NoIJiSV8sNO/MK1LXTnzG+MfRlTBNR
 I+1WVc/JM7AyUelTBRYWBtBPji7O0q7oxPSlQCva6dSSJvRTlDF8pBna0r2LCA==
X-Gm-Gg: ASbGncsWueO6yVDrT8aARhoL7KJCcVROE2ffpuF2xgn3o6d7luDckEpoGtXcJef5br4
 0WXDEvLaNYxhGJNGky6RAZ0yz1VnJYsftqCjtoqTn/abp23fYFbh+XcWwlPHfQtFa6SzG/Awe2v
 Dtm0cJvKDbzqsvm57+mQqg0xPKvqaIi9xv+H83FXzN5FBRBgzEjGyl621rUmYSAZRwfaBKvhv8i
 wHr9yw443EVrsbMhF7QWGl3Z5hGEdkAjPISulqxpKL7TzfGt8o0amfHfYRKNBevQ/CNftr8N7l5
 xq64tWoyTbaegWVAzgSWWAW/61dHaCkeaCw2yAyU6S7rWYUeu0khzpZ3IUsrgfLDij9tEKcQQq3
 CjA9XOzumrQhHHEWdxYHgzID8m2NSeS9hSGOG9+rM4C3aCAW2PzgPSE0iYyFd8vpirg8XJ5t4vw
 ==
X-Google-Smtp-Source: AGHT+IETlEYVakrIWts/SDtqOPgNj2hqtRJvrQ1zlCWcYtFnXYmFrusELUL1i29Rdm37CZhkmgKa8A==
X-Received: by 2002:a05:6000:25c7:b0:3b8:ef61:bab7 with SMTP id
 ffacd0b85a97d-3b900b503d5mr9112004f8f.27.1754926489047; 
 Mon, 11 Aug 2025 08:34:49 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459d712c386sm343161245e9.23.2025.08.11.08.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:34:48 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] sunxi: spl: initialise timer before clocks
Date: Mon, 11 Aug 2025 17:34:47 +0200
Message-ID: <3363499.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20250801234918.19176-3-andre.przywara@arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <20250801234918.19176-3-andre.przywara@arm.com>
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

Dne sobota, 2. avgust 2025 ob 01:49:17 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> Recent changes in the H6 clock code added delay() calls into the SPL clock
> setup routine, which requires the timers to work. When compiling for
> AArch64, we are always using the Arm Generic Timer (aka. arch timer),
> which does not require further setup, hence having an empty timer_init()
> routine.
> However for 32-bit SoCs we use the Allwinner timers, which require some
> setup routine, and hence we need timer_init() to be called before
> clock_init().
>=20
> Swap the order of the two calls, to be more robust when compiling the H6
> clock code for AArch32 or when using the Allwinner timers for whatever
> reason.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index fb4837c2082..432b1c10f92 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -476,8 +476,8 @@ void board_init_f(ulong dummy)
>  	/* Enable non-secure access to some peripherals */
>  	tzpc_init();
> =20
> -	clock_init();
>  	timer_init();
> +	clock_init();

I contemplated similar change in past. It works fine for 64-bit architectur=
es,
but I'm unsure for 32-bit. If you take a look at A83t clock code, it uses
sdelay() exactly because timer is not initialized at that time.

So, are you sure that this change has no unwanted side effects?

Best regards,
Jernej

>  	gpio_init();
> =20
>  	spl_init();
>=20




