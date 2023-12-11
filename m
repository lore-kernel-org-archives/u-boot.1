Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39036C10DC3
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5C6877AA;
	Mon, 11 Dec 2023 18:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oRzvrCF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7D2877AF; Mon, 11 Dec 2023 18:53:18 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC4C877AA
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbc1efc23f7so3782402276.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317195; x=1702921995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u3zHdK2jGh65uFjrLVJkbTmBsy2ocIM74jVwTPaKKL0=;
 b=oRzvrCF5PaKO1y3lbSOxaEvw/0rTBl+AvRoCz8eq6WA1VvuzT117MnKpmDqXi/c87b
 ikD1j7Q4RuYmf8zdTxd1sTQsw67z5GhElcJ0fCT8fC7NNtN7x72pK2bpspqSAsO90cjg
 HGpUAE59zHDueZdJmb3MPBAAe8FmwrDUAOzHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317195; x=1702921995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3zHdK2jGh65uFjrLVJkbTmBsy2ocIM74jVwTPaKKL0=;
 b=n6GJm4vebnTjPxgUREEu87XZIZbw29jhdI6Ttc681FLAx0chTtb4yytDjg9NJg6T4M
 SV8m/HjfJ2zB7rjmYD7cBc9SnoLB/umR/2gWZNNLkjKXUWDm8/aYePQyzkzBiGfmZvyX
 /DV4/THXsigjFTQk/lVcR5sCaJZkSmmzeTxz8NsbloI3ygSew0YnDcBowI40aDWU6e41
 1Vp3FGI7tT849B0LPyTz9IDz2jb/LhYXug97cM3yaBLA+9bYSmpMqSqERixgVabDBgC6
 gYSNWFK2Yj9QpSa7q8RbuXiFk8XQ2v6/855hxQJxLGeu7oWTtcBI7JYDSctA5JqI9pM9
 miuA==
X-Gm-Message-State: AOJu0Yx7hGQLuFjwqT25vYU1huZUZ8yKW5tRyZFuTGjNf4TIYN8DvC33
 HrsXYrVIFrPHl69R0ILEAyWMacP7SGWWVzejfcQ/Pw==
X-Google-Smtp-Source: AGHT+IEocEIYpxv+/p9FWcicUd8ed5MfM7vRDDzHTCSDglJLOxJKFYw2wsqwjU52kbUBwgtTxZhovBTj+yNTjVP2NZA=
X-Received: by 2002:a5b:7d0:0:b0:dbc:50df:b9bd with SMTP id
 t16-20020a5b07d0000000b00dbc50dfb9bdmr2617175ybq.51.1702317195094; Mon, 11
 Dec 2023 09:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-2-sjg@chromium.org>
 <20231209183912.GT2513409@bill-the-cat>
In-Reply-To: <20231209183912.GT2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:08 -0700
Message-ID: <CAPnjgZ1Xc6zBycm_ymYXb834WpegpJTWuq-7T9NQYv0F=PPf_g@mail.gmail.com>
Subject: Re: [PATCH 01/14] boot: Reorder FIT and BOOTSTD to be first
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>
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

Hi Tom,

On Sat, 9 Dec 2023 at 11:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 03, 2023 at 05:31:25PM -0700, Simon Glass wrote:
>
> > The boot menu shows Android first and then a timestamp option. Move
> > these later since they are less commonly used.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/Kconfig | 36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
>
> Meh? Maybe this should be alphabetical instead, and some menu's added as
> needed.

I like to see common things first...although I agree if you know
nothing then alpha can be useful.

But when I look at 'make menuconfig' it seems much better with this patch.

Regards,
Simon
