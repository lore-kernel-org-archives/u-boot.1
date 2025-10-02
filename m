Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F8BCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 17:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2201835A2;
	Thu,  2 Oct 2025 19:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFA383621; Thu,  2 Oct 2025 19:25:55 +0200 (CEST)
Received: from server.mars-solutions.it (server.mars-solutions.it
 [88.198.47.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88394834D4
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 19:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=apr@cn-eng.de
Received: from ws-apr.fritz.box (ip-078-043-169-169.um18.pools.vodafone-ip.de
 [78.43.169.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by server.mars-solutions.it (Postfix) with ESMTPSA id 21D2276A2059;
 Thu,  2 Oct 2025 19:25:53 +0200 (CEST)
Message-ID: <a47c21cc55ee6856a2c69ce20649e273ff32ef06.camel@cn-eng.de>
Subject: Re: [PATCH 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow - test cases
From: Andreas Pretzsch <apr@cn-eng.de>
To: Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de
Date: Thu, 02 Oct 2025 19:25:52 +0200
In-Reply-To: <CAFLszThMci29aiyCUfEwUpWjdncQ=KQZfvBsSz961=KYjy2u1A@mail.gmail.com>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <CAFLszThMci29aiyCUfEwUpWjdncQ=KQZfvBsSz961=KYjy2u1A@mail.gmail.com>
Organization: carpe noctem engineering
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2025-10-02 at 10:30 -0600, Simon Glass wrote:
> Hi,
> 
> On Wed, 1 Oct 2025 at 17:22, Andreas Pretzsch <apr@cn-eng.de> wrote:
> > For the RAUC bootmethod, newly introduced in U-Boot 2025.10
> > [...]
> > 
> While we are talking about this bootmeth, does anyone know what
> happened re a test for it?

Guess you refer to test code for bootmeth-rauc. Honestly, no idea.

I just came to notice that there now is an official way, so bumped the
U-Boot version to 2025.10 in a customer project. And stumbled upon some
details, hence the fixes. I've got some more in the workqueue (mostly
improve printouts what went wrong and extending documentation a bit),
but none of it will be ready before 2025.10 release. Needs polish and
testing. I'll send them in hopefully in time for 2025.11 merge window.

A quick look in test/boot/bootmeth.c shows some tests for extlinux,
efi, vbe simple. I guess the list check would be expandable for rauc,
too. The fixed numbering might need some massage, but surely doable.

But the real thing is to test the boot flow itself, and especially the
switchover and fallback handling. Which in principle is comparable for
all methods, but differ in detail. I can see you already wrote quite
extensive test cases here, respect for that! However I haven't looked
into them yet. But pretty sure this will be a task of days, not hours.

While I'm happy to assist here, I realistically won't find the time to
act as the main implementor.
But maybe Martin Schwan already has some snippets prepared here ?
Or we even might pull in the RAUC developers, to some extent at least ?
I know their codebase includes an outstanding amount of test coverage,
so there is appreciation for testing at least.

Best regards,
  Andreas

-- 

carpe noctem engineering
Ingenieurbuero fuer Hard- & Software-Entwicklung Andreas Pretzsch
Dipl.-Ing. (FH) Andreas Pretzsch      Phone: +49-(0)711-3908735-7
Tuebinger Strasse 63                  email: apr@cn-eng.de
70178 Stuttgart, Germany              VATIN: DE814841529


