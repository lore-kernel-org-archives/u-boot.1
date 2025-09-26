Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA3CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52710835FE;
	Fri, 26 Sep 2025 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQx8aRNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5C983621; Fri, 26 Sep 2025 16:48:16 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8DE835FD
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63163a6556bso4800260a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758898093; x=1759502893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TkNb3rKWfD2SzoY+G938pJeMK5UPHxYCV23Cx5y93xg=;
 b=GQx8aRNzoW7Vhfxbk/GZQMsTVjRtFEU+A1DUd8JXL99LysBV/WC7W5X2CWVqHzE9Um
 vHG3K8PCLcAGC3LI5pYNv4Cq25z1W4CjmbqH5jCaWzUTWKcjc+Iznkq+elXx5g3fVybL
 SEspcmy97VBphOIoXkLilD4inPsEj+8QKX/38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898093; x=1759502893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkNb3rKWfD2SzoY+G938pJeMK5UPHxYCV23Cx5y93xg=;
 b=sQDQ3b8PmDAd0D7yiDYH1cNLs8Dku+rUCV6L6VWqy2wrhleedexBgFYKe5AK8Hs0LR
 dnDG0a5tQVHGwbU+9wQohJ0dVQ4V6QlMkgxUyPg1GKQRMFsP7tBk38VY1eaPkajKlbB0
 h395QZCoacj1g+cl9FBOC1mFjUaNByC0EZsIFpjWQyN1AEURlGhWUe/gDAwBTsN1ig8w
 XcVKelxT3i8LK4ZsTThIkyxOvgQ5MV1uKnAJymJNouupJPj/zj1D5V/8z57O8HVjcINm
 1UgZUd7V+OqyHn3rMD+RiDoVj2zXS7D1Myz8O2E4O0xCLVQ7mx/6Lr92P1h0kdy0ehzo
 4eyg==
X-Gm-Message-State: AOJu0YwUMcVLpNpF+FJQnkDSbPotmONkaMTbSql2kqIB1IgW42wlz8Zq
 a8VDCFTW8Z33VjFwduRMl6dHKQnj0Afo4Bqk0a7hOWj04DIHKsNm/SuPw1NBRGJX4MZ4hYyOuTO
 7ofNEdIXsNqVUP780JctV7fQobTPBrVNoZKMa0hJUv5crNg1PuKA=
X-Gm-Gg: ASbGncsY4janBD402U8WqdBIsELR3Yvg8AK+BU/k1IBLP0PsPHY+e1ozjEsHxmwcTgb
 xlHsUiVFr4CYs5Iew/TTd+94cz1f1JKsW1sNZTQJooOgN9tQ9swqZkq96CwW5yNJnb9u6P5rezF
 +dcoQHnsKnDr4BQjnrCojewcWgf5sibEdJ0BJ/S9S4/8H1ryYMXH3xDXBIFja056EVh4ifL+7Ct
 tVW6Xt9gKIfVxQeDR4uImsgfD0=
X-Google-Smtp-Source: AGHT+IFEE/9MbvRxBdIgc6Q938dkqbsKiGsd1BCozzIZheCvym5HWXqmcWQ1YlFp2OHUwpZHMP6S1Oq0LXZYYnS8+NM=
X-Received: by 2002:a17:907:9618:b0:b04:97df:d741 with SMTP id
 a640c23a62f3a-b34bb8f1220mr810073366b.44.1758898093290; Fri, 26 Sep 2025
 07:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
 <20250924163413.GJ197373@bill-the-cat>
 <CAFLszTh7so42FH2pms7dqzXFSz0vbOcab-GRmFCOaqLe2DL6fw@mail.gmail.com>
 <20250925010615.GK197373@bill-the-cat>
In-Reply-To: <20250925010615.GK197373@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Sep 2025 08:47:59 -0600
X-Gm-Features: AS18NWCU9wfLkXGnpipnIwHDhjR6z_PlEL0xalVsFTf94pJzFs43S2XEhP77pBc
Message-ID: <CAFLszTg5oOzt5poKdify8Hf44WVgy-uyb1tcmaUZ--auTd-xqQ@mail.gmail.com>
Subject: Re: Bootstd for sunxi
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 24 Sept 2025 at 19:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 24, 2025 at 06:34:53PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 24 Sept 2025 at 10:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 10:28:45AM -0600, Simon Glass wrote:
> > >
> > > > Hi,
> > > >
> > > > After the discussion on the call this week and Andre's suggestion of
> > > > putting FEL as the first global boothmeth, I took a look this morning.
> > > >
> > > > I created a new v7 series without the 'efi_loader: bootstd: Drop
> > > > bootmgr for sunxi' patch.
> > > >
> > > > It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
> > > > enough. The FEL boothmeth is first, which is good. But Heinrich did a
> > > > series to reorder bootmgr which hasn't landed and specifically I had
> > > > concerns about this patch[1].
> > > >
> > > > Given that Heinrich can't make the calls, I'll talk it through with
> > > > him separately and reply on this thread. For now I don't see much
> > > > benefit in sending the new v7 series, but I can if desired.
> > >
> > > The biggest blocking part of the sunxi series became that it showcased
> > > the more generic problem with integration of EFI and standard boot [2]
> > > so yes, getting that resolved first is the next big blocker for trying
> > > to migrate more platforms. It was unclear to me then, and still unclear
> > > to me now what the value is in exposing more platforms to what I believe
> > > ends up being a less than optimal experience is compared with what they
> > > experience today.
> >
> > I'm not sure about the less-than-optimal, but I suspect this is the
> > bootmgr kicking in and checking the network. Heinrich has something
> > for that and I'll talk to him in a day or two.
>
> Well, that's not how [2] was summarized, but it's hard to know without
> anyone being able to try it.

My understanding is that Andre wanted to disable bootmgr for sunxi, or
have it look only at devices mentioned by its boot variables, but
Heinrich did not.

>
> > > But since no one can actually test things out and see what is or is not
> > > different with the switch, yes, you should post v7.
> >
> > OK, done! Something wrong with CI, but not sure what.
>
> It seems something is going on with docker.com.

OK

>
> > > [2]: https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/#3418689


- Simon
