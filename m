Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F044ED43360
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EC88929D;
	Thu,  7 Nov 2024 14:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="MvktTawK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wVyqOSgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE2389222; Thu,  7 Nov 2024 14:54:17 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9C188B8F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Thu, 7 Nov 2024 14:54:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730987654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mKObTQJP6x0hpDZy1NM+xMucE+zCbkyqBv521WZjoEY=;
 b=MvktTawK48jRm2p0LILf8W5B5KAjrQKnMvS10C+RzD1Iu/CeZl7gR4DiTpVw4MhiF+UC4y
 wgSHrfmSSuwIis9jCv1iIzHJmQ+ulapPNdF+pnFFQjOZJaiZ1BCUCqYFvNQEEPljOM8XKE
 edc7/T5jZb/MHEucr+kHtons1GM68y/sfwkWwlsIVDz3tiLhDJ7J8h6HCNpiLBz0PBbhqA
 9kTmVGA2PVIXfdcHe99/PnmGVjwNwgXQ0g7FQxAPdjLOoD7UpgK68IGsal50fR07TAB7uA
 X2bXDm45b5634z3ot3qhFveF4ajpj3HoU/Rr4eXmSdydg7AFh+8WsLiNDK4qWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730987654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mKObTQJP6x0hpDZy1NM+xMucE+zCbkyqBv521WZjoEY=;
 b=wVyqOSgwSr8r6TclEzybBVb1DHfhxPXvrIOSRjAUoD1Pw+GuuLZ34G4ZLE/0xORaYGpdaR
 OwQyDjtzpTh5YnCg==
From: Nam Cao <namcao@linutronix.de>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] fs: Use ARCH_DMA_MINALIGN as default alignment for
 fs_read_alloc()
Message-ID: <20241107135413.hTh7wxp7@linutronix.de>
References: <cover.1730909884.git.namcao@linutronix.de>
 <eab1fcfd3165975fba61424441615782d9738fb7.1730909884.git.namcao@linutronix.de>
 <CAFLszTg28DUhw24--sVJV+JGxaTi5hXy0x4qg5q+CWTVd3bJtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTg28DUhw24--sVJV+JGxaTi5hXy0x4qg5q+CWTVd3bJtQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 07 Nov 2024 14:58:46 +0100
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

Hi Simon,

On Thu, Nov 07, 2024 at 06:44:32AM -0700, Simon Glass wrote:
> Hi Nam,
> 
> On Wed, 6 Nov 2024 at 09:34, Nam Cao <namcao@linutronix.de> wrote:
> >
> > The comment above fs_read_alloc() explains:
> >
> >     @align: Alignment to use for memory allocation (0 for default)
> >
> > However, in the actual implementation, there is no alignment when @align is
> > zero.
> >
> > This current default is probably fine for most cases. But for some block
> > devices which transfer data via DMA, ARCH_DMA_MINALIGN is needed.
> >
> > Change the default alignment to ARCH_DMA_MINALIGN.
> >
> > Fixes: de7b5a8a1ac0 ("fs: Create functions to load and allocate a file")
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> > ---
> >  fs/fs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> 
> Please update the function comment in fs.h to specify the default value

Sure.

Best regards,
Nam
