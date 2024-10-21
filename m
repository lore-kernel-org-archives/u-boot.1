Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FEAD17129
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 19:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE77888DC8;
	Mon, 21 Oct 2024 21:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uVjqJ4BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FB088DC8; Mon, 21 Oct 2024 21:36:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C384B88CC5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 21:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B4E63F5E4
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729539380;
 bh=LhU/xm2tMdYfYHQfLnbzpmuC46+HySLxo96FaFqYUkQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=uVjqJ4BXTQ4PVzf0HhEfPIemTT+h//aJ2HowBGucNg700wLS0GW0WewfOXJVFGo26
 VQTuKITdApfghD0yqTtoo4vs4c3l299dLOFsHVe5BpE2tWnQwLPK6K5pKzs09see8O
 XTC5erX9gagqb1DI6qIFVySvn5r5xKWDN6YPdYA6V8CY/o2Z/orhL6tWzfWCF9rp5U
 a/9w0zD50k0egrcsCmU5PWuqmvyJATgsbbyHu3W4eoJ6hFpfHcWXeBTtmu8qH7quph
 Oq6JdExklxIALk00UmElhr5tDiZsuEawA/tnu89tjCI/5JDqdptHWx1NiZW1WD0dXz
 02i115pBiRysQ==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e2ca403f5dso4561948a91.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729539379; x=1730144179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhU/xm2tMdYfYHQfLnbzpmuC46+HySLxo96FaFqYUkQ=;
 b=LBw5/Vl1l6prMeJlbYKDCgCc66V3aGJPvhwP6P4CFf/2ZvmrRl9ajaDfsMSX6rd01P
 DtrEcekNuEkYAHvFp7gHwV4cCR0EMQrLCRZgQG8DwENFtZXgsL/EeP5W/j3tEw/tnb6s
 KB5ajuy5Z6txfWoNqOP/diyS0Gm+85Yc+ANHnU4zGu83EWmD2JY1iID7QnYdVXiWMVWY
 HsOePB5kxAzoo0IC4rSmAY6BDOs9apUSk8dk2b+rdxNz50JGdYyCyZ2tyo5pnFzFhW8M
 a9U1X+xy24W68K2lJGIaPcDFKqd2QYBss0bRUo3ii13WPaZx49ASSm1/wHpOzzAqvcZo
 2Q6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkZL9gPd22d6rmHm89qHqXjIjmV5elIN7QtrjDezFJPrzth89vOj1v+Cbk7D6NXlTmGTTqgQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu2tkxcVIUYCwHNqcdo8zLbGnvwy13jP5QkXAYLzd//sR5L5QN
 /4KtWU7qqjhq0czR5dIKxy/C+Zm1O87NKkB5P7JcizLYsdbRiL/fyrItpKTvSJDVVGyw5o2JF9g
 XEud5YDdABe9jcYGFS98vE46LldP/ED9kjWE+Lm8XBszzvT5oof9rPTNbUkMBdl9r+Zh+yKqwFt
 RNwmL/6KVJdeSIUsaw/5r3AnuN2gJ4AGenYESky8i45g==
X-Received: by 2002:a17:90a:d508:b0:2e3:1735:ea28 with SMTP id
 98e67ed59e1d1-2e56172b2c9mr14594647a91.33.1729539378990; 
 Mon, 21 Oct 2024 12:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz8OD9LRipchYS3BBVZa67aH0hcPp8IB8aW2awMq89OBbURaclPW8qaQfc1w8hR3CoFCmpL3jfBUgpKze6yfw=
X-Received: by 2002:a17:90a:d508:b0:2e3:1735:ea28 with SMTP id
 98e67ed59e1d1-2e56172b2c9mr14594623a91.33.1729539378617; Mon, 21 Oct 2024
 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
 <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
 <20241021181234.GQ4959@bill-the-cat>
 <1e9609f3-f237-4aa7-9f9a-4eb30243261f@canonical.com>
 <20241021184249.GT4959@bill-the-cat>
In-Reply-To: <20241021184249.GT4959@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 21 Oct 2024 21:36:07 +0200
Message-ID: <CAM=mAOkx8XyaL9TrPzExDhkjy0LUzHSu+nc07gNRpANQMRFjzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: do not include K3 boards twice in TOC
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Tom Rini <trini@konsulko.com> schrieb am Mo., 21. Okt. 2024, 20:42:

> On Mon, Oct 21, 2024 at 08:15:45PM +0200, Heinrich Schuchardt wrote:
> > On 10/21/24 20:12, Tom Rini wrote:
> > > On Mon, Oct 21, 2024 at 08:01:01PM +0200, Heinrich Schuchardt wrote:
> > > > Sphinx writes a warning if a page is included twice in the table of
> > > > contents. Use references instead.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> > > > ---
> > > >   doc/board/ti/k3.rst | 11 +++++++----
> > > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > > index c3513f0aee2..5d01f487622 100644
> > > > --- a/doc/board/ti/k3.rst
> > > > +++ b/doc/board/ti/k3.rst
> > > > @@ -32,19 +32,22 @@ K3 Based SoCs
> > > >      am62ax_sk
> > > >      am62x_sk
> > > > -   ../beagle/am62x_beagleplay
> > > > -   ../phytec/phycore-am62x
> > > > -   ../toradex/verdin-am62
> > > >      am62px_sk
> > > >      am64x_evm
> > > >      am65x_evm
> > > >      j7200_evm
> > > > -   ../beagle/j721e_beagleboneai64
> > > >      j721e_evm
> > > >      j721s2_evm
> > > >      j722s_evm
> > > >      j784s4_evm
> > > > +K3 SoC based boards in other sections
> > > > +
> > > > +* :doc:`../beagle/am62x_beagleplay`
> > > > +* :doc:`../beagle/j721e_beagleboneai64`
> > > > +* :doc:`../phytec/phycore-am62x`
> > > > +* :doc:`../toradex/verdin-am62`
> > >
> > > Can we just make the changes to :doc: links be inline and keep the list
> > > sorted/ordered as-is? Or does that not read well once rendered?
> > >
> >
> > This is nothing Sphinx would understand:
> >
> > WARNING: toctree contains reference to nonexisting document
> > 'board/ti/:doc:`../beagle/am62x_beagleplay`' [toc.not_readable]
>
> Hmm, maybe toctree is the wrong keyword, given where it is in the file
> and the rest of the contents. I think the whole list is intended as
> "here are all of the K3-based platforms". This however may mean that a
> bunch of boards then need :orphan: added as they won't strictly be in
> some other ToC list?
>
> --
> Tom
>

I would prefer not to break tree navigation. It would be best if the TI
contribitors stepped in.

Best regards

Heinrich

>
