Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF2EF3ED78
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 06:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9F5839D5;
	Mon, 13 Apr 2026 08:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="ex6fkj30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8019w0ID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDF383B99; Mon, 13 Apr 2026 08:18:37 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32478352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
Date: Mon, 13 Apr 2026 08:18:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1776061115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAYcpSoENvtyeV3nhiHmEpMFQZ7XR4+aEK8jX/JAFEo=;
 b=ex6fkj30a+4vIczIoz06rOkna16aF4DQKVRxJb3R6LljyFtm4w+zdbcacYTuMAIuTS4A/0
 A3b88RJvrSEmzId93xMOquT5VEXBZEFX/LXuq0zZWs6MA+FX/4bNb4l0/TzQpEjTWvA20h
 Agpb7RKAbjGJ0gJOaqBJdb5aL/6mECXUSG2eiVNyfQLv4ppOu8zUk1XWZVKqkanr+uPaNw
 zMtjBSu9Y/FWJ+VJM1d6GRh+19i9t9EDx2DQTBbAxZsT9O93j43KoD4WxD66lgcfdDqZIE
 787J45ZDsmMpIDEwfvRkbyaUdvOs5wdvJ8ORZrXcJZRPiS32NX/fEf4aTMgReg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1776061115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAYcpSoENvtyeV3nhiHmEpMFQZ7XR4+aEK8jX/JAFEo=;
 b=8019w0IDc/Y7D4LK7Mg7/+7g6lxmmSCWoR1U4keCDshEsP7sgbGjNiU3YMEiiFc3crGbmG
 Psj87i6Q3B/BN7AQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] cli: flush stdin before enabling cli
Message-ID: <adyKucgpN0v4ddhA@gregor-framework>
References: <20260407063453.18679-1-gregor.herburger@linutronix.de>
 <20260407063453.18679-2-gregor.herburger@linutronix.de>
 <CAFLszTgOx73JFqH9+ES4w6oVP=DeM81QJFqQP9dR4_g4eOm15w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgOx73JFqH9+ES4w6oVP=DeM81QJFqQP9dR4_g4eOm15w@mail.gmail.com>
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

On Sat, Apr 11, 2026 at 10:41:00AM -0600, Simon Glass wrote:
> Hi Gregor,
> 
> On 2026-04-07T06:33:10, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> > cli: flush stdin before enabling cli
> >
> > Currently there is no possibility to flush stdin after autocommands are
> > executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> > serial, it could happen that junk characters sit in the fifo and appear
> > on the cli.
> >
> > Add a option to clear stdin before starting the CLI.
> >
> > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> >
> > cmd/Kconfig  | 8 ++++++++
> >  common/cli.c | 4 ++++
> >  2 files changed, 12 insertions(+)
> 
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > @@ -47,6 +47,14 @@ config HUSH_SELECTABLE
> > +config CMDLINE_FLUSH_STDIN
> > +     bool "Enable flushing input before starting cli"
> > +         When this option is enabled the stdin buffer will be flushed before
> > +         starting the CLI. This is useful when stdin is changed during boot
> > +         (e.g. from nulldev to serial) and junk characters may be pending
> > +         in the buffer.
> 
> Thanks for expanding the help text!
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

I just realized I didn't collected the Reviewed-by Tags from v2. Should
I send a v4 with these or does a maintainer add them?

Regards
Gregor
