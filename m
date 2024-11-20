Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E52D63922
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39043893F9;
	Wed, 20 Nov 2024 11:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="mH3BaGY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA36E8941D; Wed, 20 Nov 2024 11:26:31 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D184893EA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D50F6148787E; Wed, 20 Nov 2024 11:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1732098388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47+3J0A39lFfHBIlq4hP39txTSIQi7PEGMBclBI5xjM=;
 b=mH3BaGY/KjZgNVTqmo1R6EJeHPzgRy8wndc1G2ehIwukqNvH8uCZ7dWjb7ITdTTutVV24N
 zLS/dxOlwDgChTzQlg1dmUpKXXiR7FrtyCWPO1LVtcTDgu9GuEZu/L45mpugV+oTWK8RyJ
 ebbJ+JCra8VcbcYo+8PPR9hQagxgIHcLRRmW39ZCLGdW1Y4wTDKt0YTBwV1M9a3LxwSKXV
 4Xhe97xlz0ffw0DYvyseIuzX23uKfVWI+Ql7xpDG8hx4xnssRtsR3nAphMR5ok2G64Tobo
 /f9HuMEPwXMtug3wfKxR3U+fLpRl9WLI38h1NrzezLEV1AIfB8El5yD2qrbX8g==
Date: Wed, 20 Nov 2024 11:26:24 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 xypron.glpk@gmx.de, mkorpershoek@baylibre.com,
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com,
 n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, ada@thorsis.com
Subject: Re: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
Message-ID: <20241120-trustee-appealing-7c4a54657479@thorsis.com>
Mail-Followup-To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org,
 trini@konsulko.com, alpernebiyasak@gmail.com, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com,
 al.kochet@gmail.com, u-boot@lists.denx.de
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
 <20241120-employer-haunt-ff43822eb5f3@thorsis.com>
 <CAFXKEHaHofdP8ec4En1Our2a=mhewhxN+q0KxDs9sA6c+wcW-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHaHofdP8ec4En1Our2a=mhewhxN+q0KxDs9sA6c+wcW-A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Lothar,

Am Wed, Nov 20, 2024 at 11:11:23AM +0100 schrieb Lothar Rubusch:
> Hi, thank you all! This is outstanding, such a fast feedback! As I
> also just ran a tool over the texts, adjusted formatting and
> reverted/accepted some changes manually to my knowledge (I'm not a
> native speaker). Please, could you clarify the following?

What about mentioning the tool in the commit message then?

> 
> On Wed, Nov 20, 2024 at 8:15 AM Alexander Dahl <ada@thorsis.com> wrote:
> >
> > Hello Lothar,
> >
> > Am Tue, Nov 19, 2024 at 10:28:36PM +0000 schrieb Lothar Rubusch:
> > > Fix some typos and duplicate words in gdb.rst.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  doc/develop/gdb.rst | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> > > index 4e359c7f22..dc38435227 100644
> > > --- a/doc/develop/gdb.rst
> > > +++ b/doc/develop/gdb.rst
> > > @@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a running U-Boot with GDB.
> > >  A common way is to connect a debug adapter to the JTAG connector of your
> > >  board, run a GDB server, connect GDB to the GDB server, and use GDB as usual.
> > >
> > > -Similarly QEMU can provide a GDB server.
> > > +Similarly, QEMU can provide a GDB server.
> > >
> > >  Preparing build
> > >  ---------------
> > >
> > > -Building U-Boot with with reduced optimization (-Og) and without link time
> > > +Building U-Boot with reduced optimization (-Og) and without link time
> >
> > ack
> >
> > >  optimization is recommended for easier debugging::
> > >
> > >      CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> > > @@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual.
> > >  Using OpenOCD as GDB server
> > >  ---------------------------
> > >
> > > -`OpenOCD <https://openocd.org/>`_ is an open source tool supporting hardware
> > > -debug probes, and providing a GDB server. It is readily available in major Linux
> > > +`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting hardware
> > > +debug probes and provide a GDB server. It is readily available in major Linux
> >
> > NACK.  It would read "OpenOCD is a tool supporting x and provide y"
> > now.  This is most probably wrong?
> 
> I'm not sure if I got the point. If you can't find the time to answer,
> I'll simply revert this entire change and leave it as is, no prob.
> So, change 1) is "open source" to "open-source"; change 2) is a
> removal of the comma; and change 3) "providing" -> "provide". Do I
> understand you correctly, change 1) could be ok, where change 2) is to
> be left as is, and also change 3) has to be as is?

I have no strong opinion on 1).
I'm not sure about the comma in 2).

Let me explain 3) although I'm no native speaker as well.

You could split the previous sentence in two like this:

  OpenOCD is an open source tool supporting hardware debug probes.
  OpenOCD is an open source tool providing a GDB server.

After your change the first part stays the same, the second part
becomes:

  OpenOCD is an open source tool provide a GDB server.

or

  OpenOCD provide a GDB server.

It depends on how you interpret what parts the "and" connects (or
which redundant part can be omitted), but both variants sound just
wrong.  So if you can not convince us this is a real style improvement
in correct language, leave it as is.

Personally I think automated tools can help detecting language issues,
but the patch author should review changes carefully before sending
them to other developers.  ;-)

Greets
Alex

> 
> > >  distributions or you can build it from source.
> > >
> > >  Here is example of starting OpenOCD on Debian using a J-Link adapter and a
> > > @@ -124,7 +124,7 @@ with the command *bdinfo*:
> > >      Early malloc usage: cd8 / 2000
> > >
> > >  Look out for the line starting with *relocaddr* which has the address
> > > -you need, ``0x27f7a000`` in this case.
> > > +You need, ``0x27f7a000`` in this case.
> >
> > NACK.  These are not two sentences but one, containing "the address you
> > need".  Splitting that makes no sense.
> 
> Agree. This was already meantioned.
