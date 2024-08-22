Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC104C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732B3888FB;
	Thu, 22 Aug 2024 16:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIvpr+eT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CD288915; Thu, 22 Aug 2024 16:15:53 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01F988651
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c159150ff4so4362336d6.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724336150; x=1724940950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBXlNh0AT7Ukj9hCAf6AUklHjlOxFe3vu8P4EsoMjUU=;
 b=kIvpr+eTcbtRKgnmU4afZD4XsbdraGkiQU4SfKEoUtWpkvhMQ0JB3wcq+7hY2Sdn7h
 LTF9u+GWNFFE7XpZQUJqxIuYKa7QMgMhxQxQg/Y6HJrWU/RiJxUAsqbXqTvw9GbtFCIq
 XH8d5biB/K2S20ubUUmdA/3aEY6wIjmuEl2iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724336150; x=1724940950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZBXlNh0AT7Ukj9hCAf6AUklHjlOxFe3vu8P4EsoMjUU=;
 b=foWSmaTFXjfjfIi4FqJN3QuJL2bHFpqLhFgxSTa+saPyvmEoMhVVktQwswaARej/9V
 F+j2MXMApKPS6EjXxLXIdJ9b7fN2dpkz5M1FpoVtnW5oc0lwSfvzRN3oQvLQAWHTBaWa
 8gppcZsyOlxkeeTWYy7lgyU/2uEO8RnKHsTEY3DlKdI1bT87v5kDPVYTCECNNJv6nei1
 LxtEfS9hGO77RgZnNQIW0fwo9eyClZlvGpqwS5BXB4tDgTn12q0vwuSUnStzDw8pZGq4
 pCvxiDNzDoe6t5f1+JgatQx+/8H2kZP8m6zu9ZNCiGfl4/b36FFHsDbGeK+fA8DPUIH+
 6RCQ==
X-Gm-Message-State: AOJu0YwuvY/+rlu8TplwmNBFJ2VTGeS7IZESxWWzKN51wXqFZ2INW1KS
 4PmEYkI7geM58TXJGrpk3C0v5tWcQM40Oua9cT2EQIX7q20zD4UTk9e7DSIHKZ4Vxs6ShjmshWJ
 cToynlRLbwJeOQcJ6/vuLNA6RARfepF0OfKtJ
X-Google-Smtp-Source: AGHT+IG2A2wZIbHxMrCR1mKCWA+zGgOSDw4i8D80JyHUq+QRkIYef7/EkZN/hi/dwG1rSXXxsFL9LRIFWiQuqRj4WWg=
X-Received: by 2002:a05:6214:3a81:b0:6bb:8e2f:bd4a with SMTP id
 6a1803df08f44-6c16479b6f3mr16520346d6.38.1724336150561; Thu, 22 Aug 2024
 07:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
In-Reply-To: <20240822141013.GQ1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Aug 2024 08:15:39 -0600
Message-ID: <CAFLszTgPBO9dO9za2KaJKhp2Xq5RD3x6vCQs7X5i5KiF_tT-Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > >
> > > > > For most boards, the device-tree compiler is built in-tree, ignoring the
> > > > > system version. Add a special option to skip this build. This can be
> > > > > useful when the system dtc is up-to-date, as it speeds up the build.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > >  tools/buildman/control.py       |  3 ++-
> > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > >
> > > > We should probably do this more generically, outside of buildman. We
> > > > have scripts/dtc-version.sh and if the system version isn't new enough
> > > > (and we just need to define whatever the minimum version is), then we
> > > > build our (not currently that new anymore) dtc instead.
> > >
> > > Yes I think I did a patch for that ages ago [1], but it was rejected.
> > >
> > > I'd be very happy for it to be applied as I think it is a better
> > > solution than this one.
> > >
> > > I see that some poor sod tried to do this in Linux this morning.
> >
> > Any thoughts on that patch?
>
> I'm open to re-considering [1] again, but we need to handle the warning
> problem first. That means...
>
> > Also I do see one problem. Newer dtc version produce a lot of
> > warnings, which causes CI to fail. So if we always use the newest
> > version, people are going to see a ton of warnings when they run
> > locally. Am I missing something here?
>
> Well, it would be great to get our Kbuild logic anywhere close to
> in-sync again with upstream. But syncing up the disabling warning flags
> shouldn't be too hard.

Have you talked to Linaro about taking this on? It becomes more and
more important as time goes on.

Regards,
Simon
