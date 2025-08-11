Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D2DC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 08:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7264E83330;
	Mon, 11 Aug 2025 10:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754902663;
	bh=715SuKEjH89KAPxGYp33A7n3ORLjyBdj9HaXB+lAlOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEIYDEzCMMKW81+Kxb8gWJanBZ1DvZSUCJcvdad3fMGC8JR1PoUo6TkLnG+tl2kkp
	 0PmnI8F+9ZmQGjnK+jw3Sj3EaCEnrOhNvXmbzYj9JIM9jnd3kVy+DBFhBRP7enpjgU
	 MRbiroqepf3mud13iSQZijqeqUpi2/JfaKwV5dEz2Bz+nQ/5kRZVzWAfIc3RLmb7ey
	 +d6M4MuXKMtmH42YKwkXuOQn++FuAaqsuIitl8q75gxBYBm10Pn7LyP9D67mwEo1MX
	 9dHmP4b4wcga6C8R1phkVEn4W+NR2byrT9Fc1Ts9uCDCin8vTncBlC0oohJOmzLMnz
	 Qd5t3J/oNaTWw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026F883335; Mon, 11 Aug 2025 10:57:42 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A26083323
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DH4eJ8a4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 877BC1038C11C; 
 Mon, 11 Aug 2025 10:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754902658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=715SuKEjH89KAPxGYp33A7n3ORLjyBdj9HaXB+lAlOU=;
 b=DH4eJ8a4HyPhas+Nk2dZ6Y3gLqOQK5gOrHJsnRKEB4auAZ+cGpL6bM/uJfIM1uoa/yjsvy
 0WGIHd0eVJ0UFP6iY+j1nXKnP61H4sxEuO/Os4uDZadIoZiwMKfO7QB0MbKQR6Q7lJFugS
 jQ5WKMsvdOwahcgnnoiVtH6+QAgOMwTbHw4NaP6SnDjXWCRoRyyogix0XLnC+QIqq9dBx/
 N0J/L/OAPQP0fjnqjqyLAqqwOntK1Jm8Mo3Qn+RCyTOOb50dc2rWai8/Y3bxmEe9gzmNum
 CKL8iJAydtie/QNlF9DGhxC864qrZL6nAVGbFc+OeKp3ndZ0E8pq8iJnv3n2Eg==
Date: Mon, 11 Aug 2025 10:57:32 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2 3/3] Image size checks: Simplify help text
Message-ID: <aJmwfBL48AzuFra8@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-4-pro@denx.de>
 <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org>
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

On Thu, Aug 07, 2025 at 03:41:57PM +0200, Marek Vasut wrote:
> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > For coherency, use the same help text for all related size checks
> > options. Furthermore, simplify the depends-on logic.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> > 
> > Notes:
> >      Changes in v2: new
> > 
> >   Kconfig | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Kconfig b/Kconfig
> > index ec20603883b..490a706101a 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
> >   	default 1048576 if RCAR_64
> >   	default 0
> >   	help
> > -	  Maximum size of the U-Boot image. When defined, the build system
> > -	  checks that the actual size does not exceed it.  This does not
> > -	  include SPL nor TPL, on platforms that use that functionality, they
> > -	  have separate options to restrict size.
> > +	  Specifies the maximum length of the U-Boot image.
> > +	  If this value is zero, it is ignored.
> 
> This makes the description less accurate, sorry, NAK.

What about using just the first half:

	Maximum size of the U-Boot image. When defined, the build system
	checks that the actual size does not exceed it.
	[plus/minus treatment of the value zero]

And dropping the remainder "This does not include ..."?

I think the hint on the separate options would be unnecessary, if they
are placed placed just below.

Best regards,
Philip




-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
