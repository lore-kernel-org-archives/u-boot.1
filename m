Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148F9E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E10C80384;
	Fri, 20 Dec 2024 18:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bSjb3Tnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72320803A9; Fri, 20 Dec 2024 18:37:01 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592F080381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aabfb33aff8so393801566b.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716219; x=1735321019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8sn+BgGZpmg5DugNTBIabzP3xJJImzqObHVYNSgRnDA=;
 b=bSjb3TnhxNfmHGasHY4WSieUrw9iZ/3XL4277wf8ThTltSWah6OkBHkIli9P/SH1mc
 z84o5Mxh1xB/fm4DwAUwfY/WjFgcVwp0wNDAYgENUl40kqfF2W356swK53nWCt9QE46K
 XEV9H1JgcxIxOOacZPul8cqKWWMC/zv9pKY4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716219; x=1735321019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sn+BgGZpmg5DugNTBIabzP3xJJImzqObHVYNSgRnDA=;
 b=curdo5lY235cpwWyZeC4GssboIwHN8c8SkdGkVKBJHY3z3+lrGq98E2zMmwi6JrgXS
 WGV1QzBMc6a6jaQFM7bqmIYg0ia0xLtNTSNVnFUrFSRp077oftFQERfibU9jjCoFi835
 ZkoHdtPnYqqPxXY43wtkaFFDn4Z63cjwAJDVJGx5nkZ0eRtaKLSuWJ5XJSgd0aFX+pyh
 gtJG8j+q6JK1HY/o3wYl/QY6+xA5MwTKHFkvK55/malbmesgy1nYXQXe8WUQICUUiV+W
 vnFUcjQnO3J9UfIP0k1ViBAZKXvFs/GqSslmMKmTnvuoF4JzlBX28puWUtCFciKwZqqs
 Uvdw==
X-Gm-Message-State: AOJu0YyhnvLncBpjbr8RjVswtBh4/FRPgGZooNE77Xje34KkRUeFNNkx
 RIdtHAeD3um2fw9nqVVBHsgy1qcSpGuBzN7f5w8LzRDqTzNwcK5DFjS9+Tc0tcmZaiI0vy8sOx2
 cusE9jiFbsV8HjlyznUYDj7QoEl9X1hKw/WjRZH+W5PMugkk=
X-Gm-Gg: ASbGnctMFc4ipRuPTK6LCKEr9yeSoN5Cw18sOHQtP6ZAR8w+LlYNGcBQRaaoKK6KHSv
 jtGf73YszHSyNxU+VhINrB29bDQT/XWFL6/C+M7w=
X-Google-Smtp-Source: AGHT+IGZCoaMH5vvcH3d3WGClx2M+XztJomaeq6NGVAf+d7lSHb8rCB+7jSSp2otTObJESJ2i7CEjlgYH7lVBFcGmUs=
X-Received: by 2002:a17:907:704:b0:aa5:b8dd:fec4 with SMTP id
 a640c23a62f3a-aac080fe63emr748932366b.4.1734716218721; Fri, 20 Dec 2024
 09:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
 <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
 <20241217235411.GV1505244@bill-the-cat>
 <CAFLszTgyScyRrV0pNksMYB5r1RxGN1dnJFO-96XaLtn=NLZu+g@mail.gmail.com>
 <20241219163754.GW1505244@bill-the-cat>
In-Reply-To: <20241219163754.GW1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:36:46 -0700
Message-ID: <CAFLszTi6kXagAgj1Dy+6kQ+9kdDe9O4nD++gceMvu=ag5DnQ7A@mail.gmail.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>
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

On Thu, 19 Dec 2024 at 09:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 19, 2024 at 08:07:22AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 16:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 04:42:30PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 17 Dec 2024 at 12:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > At present buildman only supports building the default target. Generally
> > > > > > > > this is what is wanted, but in some cases boards erroneously have a
> > > > > > > > different target for product extra files.
> > > > > > > >
> > > > > > > > Add a --target option to help. Also add a comment indicating which
> > > > > > > > letters are free for new options.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > How do you use this? It would be nice to be able to do "--target
> > > > > > > u-boot-initial-env" for example for converting and verifying the
> > > > > > > conversion of boards to plain text environment. Except the list of
> > > > > > > artifacts that are kept isn't updated with that string as well. And
> > > > > > > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
> > > > > >
> > > > > > It's related to the problem where colibri-imx8 doesn't actually build
> > > > > > an image with the default boot target.
> > > > >
> > > > > I don't recall if there's a good reason for imx8 not setting
> > > > > CONFIG_BUILD_TARGET to something, but that sounds like how to solve this
> > > > > problem. "make all" should work, normally.
> > > >
> > > > Even if it did, the build fails the first time. It just needs to be fixed/
> > >
> > > Yes, there's both the problem of CONFIG_BUILD_TARGET not being set and
> > > then whatever issues there are with configuring access to the blobs
> > > especially when they exist and aren't faked via BINMAN_ALLOW_MISSING.
> > > IIRC Toradex does weekly builds of top of tree, via OpenEmbedded / Yocto
> > > so there's not some bitrot here to be fixed, just smoothing out
> > > integration.
> >
> > To me, BUILD_TARGET is a pre-Binman construction and we should just
> > use binman to make sure that the default target builds a bootable
> > image.
>
> Well, no. Assuming that doc/board/toradex/colibri-imx8x.rst is correct
> then CONFIG_BUILD_TARGET should be set to "u-boot-dtb.imx" so that
> "make" just works like other platforms. If there's some other target
> actually in use, that should be what's put in CONFIG_BUILD_TARGETS and
> in turn binman will get invoked as needed.

I suspect the real issue here is that it has not been converted to binman yet.

But adding BUILD_TARGET just causes the build to fail...I already
reported that to Francesco.

Regards,
Simon
