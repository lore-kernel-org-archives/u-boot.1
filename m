Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B362EE7716A
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 00:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4B38005B;
	Mon, 16 Dec 2024 01:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HM2iScvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D372B80092; Mon, 16 Dec 2024 01:25:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCBA80050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 01:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso456166766b.2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734308737; x=1734913537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgaqZ6tOcybwWhuG/3ud2NFCw8wIbLb13lw1Bpnwboo=;
 b=HM2iScvb/vG0kdYWB3SLAmAy37fyF0ZzpUydjtGqO3xLQOsli+pXwxYgvL++nLrVMx
 OudWXQg/aTkpfQ0dt1XcR7UTw3HX43UdtwEx5fklxFU7dRhnenSUol7Q3Onk/zdYg515
 rPY2aGUg9Tp+jUfKpB8zcBWGPlv+it47x4V+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734308737; x=1734913537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgaqZ6tOcybwWhuG/3ud2NFCw8wIbLb13lw1Bpnwboo=;
 b=TOq5OOxW8RyMCUL+XxVgDsL3Zr8fNv6GzUmeySy3fqhdql17vnxhDENNhKg6KG+iIp
 7ZC0iGQVHg30CgCso4DLZ8L2TEyaA6QQzZYlq8JAWuKVmINqCds/ZfGCtQtLiIoGwbzr
 cHA7Cb0YSjMQ3wggftyjrUcP5qmz+sZfhB2TDoimWfgm7dqIcEBD02XqnGzgRTuky31E
 21IYvR3ZEu2Q5cpMBY/l9ye/sY66t2ZiqCgGcJdQU/r8OfB+Fg+2KuYPTPMJm/r3YmVO
 Ycl6z+aLkLyYkjI2SBFUyvIEngmVTcHqotr+pdc0p71ZczletUIK9vMAWzj1AjIo2wEF
 7aTg==
X-Gm-Message-State: AOJu0YxWsv+3C4K1QsZoLe2bFNqAUzBvUzqaHfXqsUGDdsBkbwiAMKTF
 rDuaX2tF3sg1Cu2NNnetQt2UlnZBABDyFw+URXTaWZNKkbXVPuo7eRWjtWxeK07NzQAxcoKW0rb
 S77iVw4Gty+70PrXPfyvCyeMKbbVV8GexYpOD
X-Gm-Gg: ASbGncunV5UAzCeaN77HwjO4ygk0UOAmN4ZdIsI4SbSnS8kltK7h+f99LVv8AsuZau0
 3/Aww8JQwmaVVeR0Q7SWWlrwNEm4LA/dzg3w3UN6bbZLivP9A0UM1UB8rQzjGkwGinj2g8gI=
X-Google-Smtp-Source: AGHT+IG1Ca0rGx8KVwPorsyionGTMO5om9uBaMtFPMcPdWLdTIi+1R479QDGVDOAQ8+gAsG7YJf4sPcRE4O1xG60H18=
X-Received: by 2002:a17:907:9710:b0:aa6:90f1:a9bb with SMTP id
 a640c23a62f3a-aab779aa8a9mr919598466b.24.1734308736578; Sun, 15 Dec 2024
 16:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
In-Reply-To: <20241213170736.GW1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 17:25:24 -0700
Message-ID: <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Introduce an option to control if we expect that a prior stage has
> > > created a bloblist already and thus it is safe to scan the address. We
> > > need to have this be configurable because we do not (and cannot) know
if
> > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > on-chip memory and so it may or may not be safe to read from this
> > > address this early.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > >  lib/fdtdec.c   | 11 +++--------
> > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > >
> >
> > Since this is the essentially the same as my OF_BLOBLIST patch, which
> > was rejected:
> >
> > NAK
> >
> > The issue is not whether some 'previous stage' set up a bloblist. For
> > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> > that TPL set it up. But it doesn't mean that TPL put the FDT in there.
>
> This is wrong. The root problem is saying that the bloblist is in
> possibly uninitialized memory. The code is quite happy to NOT find the
> device tree in the bloblist and continue searching other paths.

But until the bloblist is set up, it doesn't exist. We should not be
looking for a bloblist that we know is not there yet. The bloblist is set
up by bloblist_init(). You seem to be imputing your own semantics for
bloblist.

In SPL, init happens in board_init_r(), i.e. after RAM is set up. So don't
look in the bloblist until it is set up! It doesn't exist.

In U-Boot proper, we look for it before relocation, so we can relocate and
expand it for use with ACPI tables, etc.

Take a look at this patch, too:

3d6531803e1 bloblist: Support initing from multiple places

>
> An alternative here would be to better document the requirements of
> BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> someone is inclined to move DDR init in to TPL, or someone finds a
> non-main-memory address to use for BLOBLIST_ADDR or switches to using
> BLOBLIST_ALLOC.

Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It cannot
do DDR init in TPL because the DDR blob is large (160KB?) and there is a
ton of setup to do first, in any case. When CAR goes away, its memory
vanishes, so you need to have copied the bloblist somewhere else (the
bloblist holds the MRC data which needs to be written to SPI flash later
on, when possible). This all works perfectly and there is really no need to
change anything.

Again, you seem to be imputing semantics to bloblist which don't exist.

Regards,
Simon
