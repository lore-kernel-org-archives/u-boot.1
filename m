Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FBBC54FB3
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDE582B53;
	Sun, 25 May 2025 15:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUGfZHNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B2082B54; Sun, 25 May 2025 15:34:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C706182B37
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so20724985e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748180054; x=1748784854; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dCx/y0rrnwLas+UsAYescBBNjx0Xb1dSwi/Xnb8vCE8=;
 b=lUGfZHNv1Roz3lnrzGwue26CLm8Igz5cp4eTSGEQMZH4/l0Pu01Y4hgMNFaal7mRWe
 4q0C0DxDSuM7Zm1RDEZHZEeV3jGNDNia+2jFRgLnnPFCNMShqe+iW9wI2wObO5Y1OjCr
 If83RYYdxUYsIEZJ8/fdT7Og56/uJp7ihntq4vgLcgQasNtLfQWws6Q20jWAfqx6/ktO
 g9hG4h7RcNUC8APP16TFY5XsfaOH89INmqNThkRdxCM5j941I7p3Hg8+wmKyIXXO/UxN
 lUWmLS4fQbgedrJFDHsPbeZ2jRQfpz1fZyvQ6TjAz6eVQ0dl/fWntS9lXzc7HAbGqo8t
 uxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748180054; x=1748784854;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCx/y0rrnwLas+UsAYescBBNjx0Xb1dSwi/Xnb8vCE8=;
 b=cFIGboGtqFUs68oLtLTC9wVPVltoP/n0K2vytH9iRE0/1RvTAkSPMGcIbGq/i4sht6
 S+4gIaglImMPAnPTaVvVx92leAd1t5q3szXg0OfcCKbcbIaopsnQJaQ+Wsqby3eMTGs5
 vDzH7cRumv25B6s/p40UZZmmzN5xtKnjNBQQiX+/NZqTEbrI+sVwSg0DQP7ZFqpew3QG
 bqIiHtHtgyMTuWzER6gZby1V6OHPKMWCrtWLuOf+L6ovnZjE23BBTC3Kpe9tzB3Ok1ve
 GyWZJ0sBNCC+styojhPaa4+HDZqAauDe7jV4JOAD8IvviRPrZOUIQo+dpf28XjPWAC72
 RzSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nMAPSDAtwutbaoOeeTui7ZiK4h7jaUZ/854IgXeCPa3SByxifAvOV2mpo5hPODaeapIaR5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwY3db6CVUOFMJ1n+A+2Gkg0AUFfrgEUofahbs/bYXG58zFmeOc
 kae+w0eOKjb32BYeazoqZ40+AuCMtZymLu/AqLgIi7D7m/J+Ifm/ilRw
X-Gm-Gg: ASbGncuO4cZADHU20ukLXyO3x9V2kpgzUzxZUyQsCzHP2BiuRR+5q5GE5fqBOhBWj8x
 guOYUGGOUz5xbjoangoTldB0p723QjNVBF+frHOuflSg1wI2LGXp/EfW41Ygjjswepe5ztPrVSP
 D0I5fuFzMo9hhqt9/mscuodf/sLuMdUkxIZEElwQB2K2M1MXOR9T5EoAlGAq4AtrqGIs4ZbSNTG
 NR8D3DITLIJqkKNmNcZxz9WHscR2l6D61r3WT9d8VT/HrYXKBvIZWEG4uVMnNuWe/WTM4vndtNe
 A00O0h41v43lnVb2jYF0uqZMKiGthEQqIsJDOyV77xSXq9y+BoYo+XNoR9w9Hcm2KqC+Z3tWbpe
 S8ZHBuDI=
X-Google-Smtp-Source: AGHT+IHx0dI2k8fZR2QKAXK4Kw8+QRLg9fz0Y+T2hKIBJkhJndKbLIoKx29emZVnBFyAubeoKR99Ng==
X-Received: by 2002:a05:600d:108:10b0:442:d9f2:c753 with SMTP id
 5b1f17b1804b1-44d5bb93604mr16639785e9.26.1748180054018; 
 Sun, 25 May 2025 06:34:14 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cf211828sm4208978f8f.61.2025.05.25.06.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 06:34:13 -0700 (PDT)
Message-ID: <68331c55.df0a0220.313bd8.4d38@mx.google.com>
X-Google-Original-Message-ID: <aDMcU9thtX20YvMl@Ansuel-XPS.>
Date: Sun, 25 May 2025 15:34:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: bootmenu: permit to select bootmenu entry with a
 shortcut
References: <20250524221313.10249-1-ansuelsmth@gmail.com>
 <aDMUzv2QIOdG+97H@meh.true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDMUzv2QIOdG+97H@meh.true.cz>
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

On Sun, May 25, 2025 at 01:02:13PM +0000, Petr Štetiar wrote:
> Christian Marangi <ansuelsmth@gmail.com> [2025-05-25 00:12:52]:
> 
> Hi,
> 
> thanks a lot for your upstreaming efforts!
> 
> > Permit to select a bootmenu entry with a key shortcut. This is
> > especially useful in production or testing scenario to aitomate flashing
> 
> aitomate -> automate
> 
> > 0 is always reserved for Exit to console.
> 
> BTW this is the only shortcut key which currently doesn't work :-) See below.
>

Eh last time bugfix and I forgot to test the 0 case... feel stupid
ahhaha

> > +		case BKEY_SHORTCUT:
> > +			/* invalid shortcut, regenerate menu */
> > +			if (cch->shortcut_key >= menu->count - 1)
> 
> IMO it should be:
> 
> 			if (cch->shortcut_key >= menu->count)
> 
> Considering menu with 4 items and user presses '0':
> 
>  * bootmenu_conv_shortcut_key() returns 3 (menu->count - 1), so shortcut_key = 3
> 
>  * With the original condition
>      if (cch->shortcut_key >= menu->count - 1)
>      if (3 >= 3) → true, so it returns NULL (bug)
> 
>  * With the fixed condition
>      if (cch->shortcut_key >= menu->count):
>      if (3 >= 4) → false, so it correctly proceeds
> 

This is also problematic since pressing 'b' will act as exit. I have a
simple fix for this, sending v2.

> > +				return NULL;
> > +			menu->active = cch->shortcut_key;
> > +			fallthrough;
> 
> Cheers,
> 
> Petr

-- 
	Ansuel
