Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440D8C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6419587087;
	Sat, 18 Nov 2023 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDBZ9chQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65148708C; Sat, 18 Nov 2023 18:59:13 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518B587006
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-daf26d84100so3052928276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700330347; x=1700935147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hncm6TXRxRJl4I71CXA6RZyMnkh8gOYN0hylBoDKKZA=;
 b=jDBZ9chQxqP02cjutH4k+/h0gje8o9aVOAz96I5lMIyykrPuNIWoSReQ1JNgILRdzt
 uL5BVvUGzB0fZBKVvkS8cZ6IU+U0RIJSAnsDprAJlQyhjbLzW5NTzI9NH0TUGmLcyuOf
 15Qrgfp02jFYxgDNaZCvquwYOUwlydxNDJYkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700330347; x=1700935147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hncm6TXRxRJl4I71CXA6RZyMnkh8gOYN0hylBoDKKZA=;
 b=BiwSwUoVQY7fXZb5sDHEKFaiJMOM1k/Gdx3yz1e88wxJlh2SV7g1nZIfe8chfm3m3W
 aogDL9JK6cxAs0IZzv4SP5L7lWtLOL7xqY3m1BFIJWUBgeO7ud4IjBv9b5fs5flQlXbW
 DLlMyj9vvtkNU5Cj+IdOs5eNhUeg38VbH0DMiMBwM2AwRl15GNgtNWLzOpxByYudba53
 ws8H2OyizysWvv4Q/t5bvFBb0fNZziG6WCXasvjIgicl+1QDvWsL/VOvhKthW7ymKllj
 dicps/WvRH9nBlmV66Y7kmYnbO54TyYX3lNziBOyOgly/u9E4z6rI6nj6KWvugjEkaJR
 xJoQ==
X-Gm-Message-State: AOJu0YyQ6tEpkXD/JoZkxyat2Yb3o3e7yx6qOQP3Fmhu0kkhLeRk62Xo
 zsKsyvtR5ZyBfC5SayFVe+HfkdVYqKwrX0cyqS+hZEvRSZq/X8jcAoA=
X-Google-Smtp-Source: AGHT+IFZRwJK4O6u76+HtjiDEVkEpgMirqB5/jhIMGWC2m+jg9WkoNfqkLeHM3VvA0/PY6Q6Vz/GFyX2Xa5R46+bhj0=
X-Received: by 2002:a25:d3d3:0:b0:d42:d029:ff99 with SMTP id
 e202-20020a25d3d3000000b00d42d029ff99mr2737814ybf.55.1700330346776; Sat, 18
 Nov 2023 09:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
 <20231118174550.GI170968@bill-the-cat>
In-Reply-To: <20231118174550.GI170968@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:58:50 -0700
Message-ID: <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 10:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 18, 2023 at 10:09:55AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Remove and replace common.h and config.h in sandbox when it's not needed
> > > and add some explicit includes where needed.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  arch/sandbox/cpu/cache.c         | 1 -
> > >  arch/sandbox/cpu/cpu.c           | 1 -
> > >  arch/sandbox/cpu/sdl.c           | 2 +-
> > >  arch/sandbox/cpu/spl.c           | 1 -
> > >  arch/sandbox/cpu/start.c         | 2 +-
> > >  arch/sandbox/cpu/state.c         | 2 +-
> > >  arch/sandbox/include/asm/io.h    | 2 ++
> > >  arch/sandbox/include/asm/state.h | 1 -
> > >  arch/sandbox/lib/bootm.c         | 1 -
> > >  arch/sandbox/lib/fdt_fixup.c     | 1 -
> > >  arch/sandbox/lib/interrupts.c    | 1 -
> > >  arch/sandbox/lib/pci_io.c        | 1 -
> > >  board/sandbox/sandbox.c          | 2 +-
> > >  13 files changed, 6 insertions(+), 12 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Is it possible to move CFG_SYS_SDRAM_BASE/SIZE to Kconfig?
>
> Possible? Sure. But I think it would end up being fairly horrible. What
> would be nice I think is some Zephyr-style "convert
> CONFIG_DEFAULT_DEVICE_TREE to some defines" because we could parse out
> /memory to CFG_SYS_SDRAM_BASE/SIZE and that's something we _need_ at
> build time.

That would be pretty easy to do. But I would prefer to have it create
CONFIG_SYS_SDRAM_BASE/SIZE so that it fits in with Kconfig, just that
the value is set for you.

If you like you could create an issue for it.

>
> > For CFG_SYS_BAUDRATE_TABLE perhaps we could have a standard set that
> > most boards use, or turn it into a set of word flags with a bit for
> > each rate?
>
> We do, largely, use a default table. I forget which further rework I
> posted as an RFC a few years ago, but I believe it was largely seen as
> being uglier than what we have today.

I found these:

https://patchwork.ozlabs.org/project/uboot/list/?series=262148&state=*
http://patchwork.ozlabs.org/project/uboot/patch/20210925121958.26001-1-pali@kernel.org/

IMO the second one from Pali makes sense, but it was never followed
up. It doesn't look too difficult.

We should have a policy that if people complain about a patch but
don't follow up, we apply the patch we have.

I would like to drop configs/sandbox.h at some point and these two
points are all that is left.

Regards,
Simon
