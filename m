Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A3EC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 07:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B815801DE;
	Fri,  7 Feb 2025 08:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jEoEv2GV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1742F80207; Fri,  7 Feb 2025 08:40:39 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0196E801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 08:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5E04148A08D; Fri,  7 Feb 2025 08:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1738914036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zp3kg5lr8txcivfCmLcP1Mb1TX0WquEYADk6xArpBc=;
 b=jEoEv2GVJnQ1keBieKugu2lQ3Gz8MY49SD7tBoHUuiKRMlYpBc9L93KqCeHzPoo+ap2bA3
 gxeWEbaqSmmfGa3oHQ747asw9yU2bNikQpSK3wfnkWf7XXDdRDSDNiLkrTVzM4PWodWCCC
 uEpKHZ/oOwDWPUDCtehw4t/+MPPQoxW2SsiheWoX/w+SM365r/B4bq2/11scSThVOBdlOE
 XMzM++bDITVvt60R/TWaYfMYyLynvAEPW+H+ZZjLKuQxAZGhJT1PVWck/KdtB2uDtpz1Il
 2C6h365bcUVThoBu18dEGlFshsU8Op1dJxPeXxNI4FyqHBwntYY0W3LRBXYgTA==
Date: Fri, 7 Feb 2025 08:40:30 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
Message-ID: <20250207-universal-eatery-44004ec073fc@thorsis.com>
Mail-Followup-To: Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>
References: <20250205143641.65430-1-marex@denx.de>
 <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
 <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
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

Hi Marek,

had a short look on your script yesterday.  Looks clean and well
designed, nice job.

Am Thu, Feb 06, 2025 at 09:38:58PM +0100 schrieb Marek Vasut:
> On 2/6/25 1:38 PM, Simon Glass wrote:
> > Hi Marek,
> > 
> > On Wed, 5 Feb 2025 at 07:37, Marek Vasut <marex@denx.de> wrote:
> > > 
> > > Add implementation of mkenvimage written purely in bourne shell.
> > > 
> > > This is not a replacement for mkenvimage tool, but rather a simple
> > > implementation which can be used in environments where mkenvimage
> > > itself cannot be deployed due to various constraints, like hardware
> > > manufacturing plants, but where bourne shell and basic tool are
> > > already available.
> > > 
> > > The external dependencies which are not shell built-ins are gzip
> > > and grep.
> > > 
> > > All mkenvimage parameters are implemented and compatible with the
> > > C implementation of mkenvimage.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Joe Hershberger <joe.hershberger@ni.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > >   tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 126 insertions(+)
> > >   create mode 100755 tools/mkenvimage.sh
> > 
> > Would it be worth adding a simple test for this?
> Sure, is there an existing test for similar case I can look at ?

I thought about testing yesterday, but had no good idea on top, but
now it's discussed anyways …  How about throwing the same input
at the c and the sh version and assert the output is the same?  For
more sophisticated tests it should be tested with both variants.

Greets
Alex

