Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9481C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4351D80821;
	Sun,  9 Feb 2025 15:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C48Huqsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1BC80834; Sun,  9 Feb 2025 15:29:18 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EE280141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa286ea7e8so3071528a91.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111355; x=1739716155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1KPp9RGrRlxiFJzopPqhjgadc2FmXs01OrXjN235Ns=;
 b=C48HuqsmRba3VeTIb+7UqRTGm6LrjZaDcjF9F7NRKRSGmxV7ar/c+GNhAufj0OB0Y3
 mdRnyCz6Z1kAK00ido1fDWnw7xU9njtvNOCm1AebhA+yUJ7hqKcVkJ8wB0nFdVC9h2fB
 eu4JZBywjrTREfpLqFPCqfRzuVH26HiuGqcZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111355; x=1739716155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1KPp9RGrRlxiFJzopPqhjgadc2FmXs01OrXjN235Ns=;
 b=kzZjZriYUrIAy7/pWbh4NTwENk7IZA+UhtJ3XTBvl4Hy7XFBG9waBzDM5JcJMXN6E6
 LSs24HVQpRL4u20Mgx2nhlcS2jcuHZFB1lylBStbzfkWbkn7ticOc/yew81Vg/LZZjxn
 agBH1RRqDLUfkP3rG3GmNBrRaE0YMv0F1yl77Wdp5fuBHfaaIxNw0e6gm0cD7UREFVX0
 i7k7SzVhva2GO/CVW/5acOfp8D2rbmp0bkMStWIJm1ugy7uWcqOsi8s4ht63oXNWzHc1
 n50hsg3nnJYvJ5TEmMl1FFgJxiteWCqJj45hS92dUuZXdNe3ZUqYVYgFgolG/crun+be
 70KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOmd9aKPf24JetruL0DiptQsrG+GCpOsxaUAuXf9U/peVyfmYeBrNF6QxsQR5Cr8MT6e4IwIM=@lists.denx.de
X-Gm-Message-State: AOJu0YwihHy1re+Pxq92TvI+7Zne9wQIn1VeVItwWILcEZRsYZe8hxP5
 KKD7SvPQuvT66nm0U6O06ukr1Ez8VBLTr83dGsaVMEHKQlGZu2U2dmURNhsFEdND9hlDI7H9Y17
 02jDOOQnER9pnwBDc3NjNn2DjemEz/OIJxkib
X-Gm-Gg: ASbGncsajhFtOOO1JGscR5M+VGgF0L7L3h3+TVEH+s27Tpl34V9FqmxLY9MS8MPdm/J
 OWVcngQH768eyuTNJt/Ycfx8MTrt4Ec9fkqq3LW3awOufB8fcBbM8lLvtEqgzkdWvvJAgTT6Rcg
 ==
X-Google-Smtp-Source: AGHT+IHBLb6NzWRQPpp56mtwIViAWBQ5G8dhi8w+/0vN4X0symTJUm37pShdfAjFaLGIne83BUgou/PjcrbPNYxdo34=
X-Received: by 2002:a17:90b:4c44:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2fa24166e54mr16332593a91.17.1739111354717; Sun, 09 Feb 2025
 06:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-3-jonas@kwiboo.se>
 <CAFLszThaHxr6T5mj6jCWUUsieuSkCsmcWMDNu+td5jSimeL2PA@mail.gmail.com>
 <e2b0e629-af15-4b9e-b79f-79802ae08c6a@kwiboo.se>
In-Reply-To: <e2b0e629-af15-4b9e-b79f-79802ae08c6a@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:28:57 -0700
X-Gm-Features: AWEUYZmIScGdvkbbmR_j_-PWKjCHzERhZqGLSJ2NJZ5CoHsFxYH2JHX0HE5i-tw
Message-ID: <CAFLszTj4hW6SDEyosciXa81pydCP8Cr8MUoD7Q+zCmHA8dKNwA@mail.gmail.com>
Subject: Re: [PATCH 02/12] rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value
 in offset prop
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Sat, 8 Feb 2025 at 18:27, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 00:04, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Use the offset configured with SYS_SPI_U_BOOT_OFFS Kconfig option
> >> instead of a hardcoded 0x40000 for the FIT payload offset.
> >>
> >> This has no intended impact as SYS_SPI_U_BOOT_OFFS=0x40000.
> >
> > When you add CONFIG options into a devicetree, it makes it difficult
> > to build it. We have to individually build U-Boot for each target just
> > to get the right values.
>
> This only aligned everything with the simple-bin-spi image and prepared
> for moving the SPI flash payload offset to 0xE0000.
>
> If you are looking at this now, please also take a look at [1]. There
> where some questions directed at you there :-)
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20241212235735.164272-7-jonas@kwiboo.se/
>
> >
> > For rk3399-generic, this means I have to drop gru.
> >
> > Can we not use a binman symbols instead?
>
> All RK3399 targets having support for building a SPI flash image now use
> CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000 after these changes where merged.

OK, but why have this config option? Binman is designed to remove the
need for it.

Regards,
Simon
