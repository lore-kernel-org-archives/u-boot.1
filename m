Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1BEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7605286D01;
	Sun, 10 Sep 2023 21:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z/S3kBww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A1B86CF5; Sun, 10 Sep 2023 21:14:56 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3EF86D0A
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d80089712e5so4195725276.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3lt2nQbgCFKrcVN7kny6Kifh3lIy0Z9QqEjE83lYhwM=;
 b=Z/S3kBwwsPNSw8gwtSKoQ6dhf2jg1pFX5IJfO/bOc8s0rYpddvJ0zv7zWbOSzcoWxg
 MkOC0m9T3CAp7MPIYTDaFhuYNYk6wuneE6CKp7CBQesnFIVPUnLreq2CgHHZcqE6dCWS
 JUM2hXjGIg3JIvzO0mK8D9QEUwTS/WxyqD5KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lt2nQbgCFKrcVN7kny6Kifh3lIy0Z9QqEjE83lYhwM=;
 b=PiNN4gFRnpdL8gpdEVhcAe46i/6uIRv2S3Hs6wSbv5D9sboMzemv/iUDHkjxTEys4R
 lIi3hDK5DpyJm8UedVI4baKP/m0bFYY1AU5b2riilL6A3fj99CStv8boca46yG3HM8q9
 lcaK+sw8RFfagHB2/q16WZAjIXMkjCJbvLhTY3ITddKAHa+agoAjSGRlgaxmrrhY+JsU
 p/8zA8mp4cBSytNOjhpUQcG6OZJD7ZbcC1+Be4fPwHRSosw9Z5eQg/mspBCregT+FvWy
 6oYPX4NozOTtYkJgt8vTqDzUn/2ZZOqVpFZ7+5YTtuGzr78obrWxaeOlUJZKHDJYBByr
 pPdg==
X-Gm-Message-State: AOJu0YxZ+sXyS4glqGf6a3FfMuN6gvUoeb09AuAOIN6GRj7psnUeHtdY
 VsZoPUKnvG1ZBFMPjrW6rvbylGS8qNaJ23uQTd0AqQ==
X-Google-Smtp-Source: AGHT+IEgSBneeccGN6Y7ippfTTov80nP/U8ndmizqdMCh/CjfICWeM8O0ZEDfnUXJxOqBU69EYKtPitQV/uYS8ApTuE=
X-Received: by 2002:a25:ae09:0:b0:d7b:908b:183f with SMTP id
 a9-20020a25ae09000000b00d7b908b183fmr13363638ybj.26.1694373287005; Sun, 10
 Sep 2023 12:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
 <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
 <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:35 -0600
Message-ID: <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
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

Hi Ilias,

On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > > > +config OF_BLOBLIST
> > > > > > +     bool "DTB is provided by a bloblist"
> > > > > > +     help
> > > > > > +       Select this to read the devicetree from the bloblist. This allows
> > > > > > +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > > > > > +       The devicetree is stored in the bloblist by an early phase so that
> > > > > > +       U-Boot can read it.
> > > > > > +
> > > > >
> > > > > I dont think this is a good idea.  We used to have 4-5 different options
> > > > > here, which we tried to clean up and ended up with two very discrete
> > > > > options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> > > > > have a header of some sort?  The bloblist literally comes from a previous
> > > > > stage bootloader which is what OF_BOARD is here for. So why can't we just
> > > > > read the header and figure out if the magic of the bloblist matches?
> > > >
> > > > No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
> > > >
> > > > This patch is a standard mechanism to pass the DT from one firmware
> > > > phase to the next. We have spent quite a bit of time creating a spec
> > > > for it, and we should use it.
> > >
> > > Where exactly am I objecting using the spec?   Can you please re-read my email?
> > > I am actually pointing out we should use the spec *properly*.  So
> > > instead of having a Kconfig option for the DT, which is pretty
> > > pointless,  we should parse the bloblist.  If the header defined by
> > > the *spec* is found, we should just search for the DT in there.
> > > What you are doing here, is take the spec, pick a very specific item
> > > that the list contains, and create a Kconfig option out of it.  Which
> > > basically ignores the discoverable options of the bloblist.  For
> > > example, that bloblist can also contain an entry to a TPM eventlog.
> > > Should we start creating Kconfig options for all the firmware handoff
> > > entries that are defined on that spec?
> >
> > OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
>
> That's fine by me.  You can even put that under IS_ENABLED for the
> bloblist inside the existing OF_BOARD check.  So I was thinking
> - If no bloblist is required in Kconfig options we do the hacks we used to
> - if bloblist is selected and the config option is OF_BOARD, throw an
> error and mention that the previous stage loader should hand over a DT
>
> Is that what you had in mind?

Yes, that sounds good to me.

But I still think we need an OF_BLOBLIST option to control whether the
devicetree comes from there. Otherwise we will end up with people
using OF_BOARD to work around it. We also have the SPL case which does
not pass the DT in a bloblist...in fact SPL typically doesn't even
have the full DT.

[..]

Regards,
Simon
