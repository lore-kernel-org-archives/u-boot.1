Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AEEC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D23280C91;
	Thu,  6 Feb 2025 22:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KqY0wVz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87C980EB0; Thu,  6 Feb 2025 22:27:27 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B8280C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dcf0de81ebso2482341a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877245; x=1739482045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BP6uCiXM42EMDyw252wB6Q6b5PgWu5GJ60Wy43v+QHM=;
 b=KqY0wVz01NgiZZAiV5sRaa1gEAi/K71dKZpbQ82Nv2AGtnki7c9oSvpOUuAdLnow1T
 eJKAcZXfBuiEfGZ7w4B3IE6zAnTyOaKSLv71PCMM4lXkPac6bdrLnWUKIz8006lh2B26
 0CP+zZidRj4pSaO73e8l6NSUo0FfT/f3vtJeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877245; x=1739482045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BP6uCiXM42EMDyw252wB6Q6b5PgWu5GJ60Wy43v+QHM=;
 b=l9LPnQ4u8O4Xrj0Q3X0xALd7r81/Z4KWAo+3lHy/7NH7JGTMSLR29i0jtU4tvB74Gf
 FJGJNfNbn3poJPtuqRj9denUAC/oYh3bKhoYypwjsUKVerv79PZDRjpT13ZN786nVNpa
 HLDuxeJrP8CcsmOIuekwPLuhKTHBxdYG3IuNhwRCzfYiXU7pRjHfqrF8jl6y1VDnr/cu
 YlHdoVmPa3nQmbiA20H4Uacnc37dCjAfASRgQrmXq0m+htxTtHCpP8VmdmhfAK8qlwV6
 7Q/m4WKcatfIjOYtlAiPyF2k0JB7S9p2QSNrXFND8OJWUvvFj4fKwL5FybUxFryobzJy
 sAqA==
X-Gm-Message-State: AOJu0Yzy7JR4a8mLki5Sop7zirUo1OZrk01N7d4IVgADKEziMHNy5j/P
 woOETFtJlTP/fuBQC6wvRX6jUsFm1xIUnoulNvQhdfeSux4OAn2fe+O9cdh49kUTtgm2ciFVelx
 7kf98VNn8/wjcaVKrsYHb+NRTZfKoZQP7w3uD
X-Gm-Gg: ASbGnctHpBFMXhCj8IjIX1KdwIpmXPeRX3gTo4EfMXrBtq2sUrAIG19GI5vQHLdaF/F
 bA3ZHTpOA6Ku8jASk/eXHI8a1h8J5lItT6C8rB+UOQ8Inp6uRjMhLxFlII8NnLn+6GzmDx2bN+Q
 ==
X-Google-Smtp-Source: AGHT+IFUjlKK7j0tmYX04zhbTV3yR1Cbq+4zW1gZzPalWRVmYdaLQVbNM9ew+ev1RatgeIblUOYm/oWxWTOeLLyqjoo=
X-Received: by 2002:a05:6402:2106:b0:5d9:a85:1a59 with SMTP id
 4fb4d7f45d1cf-5de450d618dmr1120207a12.27.1738877245225; Thu, 06 Feb 2025
 13:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
 <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
 <20250206170745.GG1233568@bill-the-cat>
In-Reply-To: <20250206170745.GG1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:13 -0700
X-Gm-Features: AWEUYZmiYA6gRnUP9EshSdjytswc7V_IiYGiO-Edw2cldbo78MpYQfkFwvmpokg
Message-ID: <CAFLszTiJ_zB4_dCJNjOAbXtfBmM2KxbHXxiw4gpRMMsJdOM2hg@mail.gmail.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 05:33:06AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > > > >
> > > > > > This code cannot be used since EFI is in charge of managing exceptions.
> > > > > > Drop it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Why is SPL on in this case?
> > > >
> > > > SPL is enabled by a specific Kconfig option, which seems to have
> > > > exceptions but not exception levels. That seemed to match what the EFI
> > > > app wants, for now.
> > >
> > > OK, so why aren't you turning off SPL? You're not using SPL at all,
> > > right?
> >
> > Not using SPL, but using the same code as SPL happens to use.
>
> But is CONFIG_SPL enabled, or not? It shouldn't be if I follow you.

No, it isn't enabled. But we do want that exceptions.o both for the
EFI app and for whatever boards use SPL.

Regards,
Simon
