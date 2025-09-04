Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14BACA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E1483804;
	Thu,  4 Sep 2025 10:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756974631;
	bh=ioiDU5MS32iokTk10QPYBD12527FyxpW0MxUfW+bX0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pqluOO7j8B6nGXXx/NWdSwzxJW312Dk93H8lC/bJ4Rq0Lu4EP8+QLva6z58dZumcT
	 7M1SLYlJ0Bsb3lQhsbSzbvfTDuAd+j87TObBBFLAHLOutQU6P+B808dTEuvtLne1n5
	 cAFsqgcqoHooMlRna5ICYAe6Cc5L38v3pj173hnzICyowXimMuw9Q68iZN9MldgYlD
	 mYD+Vyeq46ihkdI42F69fI8hUdLMmivIwVtr+tVqGI04qy26ML2L2sVb3bIg5QA1IS
	 Paubi3elxI/zptlWWpSs8nSBc36lR1IWHJIjWThnUS9IvHrkjCGO18xbEo2JsUtKIM
	 v0CkfoBtasJbw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423058380F; Thu,  4 Sep 2025 10:30:29 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4754483734
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Rs5wxzqe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F22C01026E167; 
 Thu,  4 Sep 2025 10:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756974626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ioiDU5MS32iokTk10QPYBD12527FyxpW0MxUfW+bX0Q=;
 b=Rs5wxzqenH6Cy0ji30w1cndBaQQSCKwwKRYnsITcP9cHmli1WoVwh73s2uKMpkj+jDtUlL
 FDWJsYS2wjcLjCpqbbc9NIMDwo3C/1cEZ+aNvL47bsOyC7+J6kDdU18R1N8fi0uAEScLAY
 LyYs4mHf1+fzG4ZdHOKf9a/IWFcF0VdF4p356SfPof7HqgzksPWJd5F5jQEYq/lTJ5KO+n
 4V/OlJv6jZeHeZkxNy/Da+DxJDM6y6YmswqzL8p8qPEM2fjb34uFvFsjZwb8u0UISjFvIO
 EBgyuDDC3gMbjVQhZ/Z5ys8ENeM5Spoth+TDSWcU6zduOHhB+edv0dOEURPf5g==
Date: Thu, 4 Sep 2025 10:30:19 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 4/5] Image size checks: Deduplicate Makefile
Message-ID: <aLlOG9of7r4sdLok@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-5-pro@denx.de>
 <937b1be4-68cc-4853-94e5-2f14cbcef194@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <937b1be4-68cc-4853-94e5-2f14cbcef194@mailbox.org>
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

On Wed, Sep 03, 2025 at 03:02:20PM +0200, Marek Vasut wrote:
> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
> > Makefile. No functional changes.
> > 
> > Note: To make this work for the special case of SPL, spl_size_limit.c
> > has to print an empty string "" instead of zero when there is no size
> > limit in place.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >   Makefile               | 45 +++++++++++-------------------------------
> >   tools/spl_size_limit.c |  4 ++--
> >   2 files changed, 13 insertions(+), 36 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index a17d8b57196..b6f01591ee9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -428,8 +428,9 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> >   # Check ths size of a binary:
> >   # Args:
> >   #   $1: File to check
> > -#   #2: Size limit in bytes (decimal or 0xhex)
> > +#   #2: Size limit in bytes (decimal or 0xhex), always return OK if undefined
> 
> You should be able to use the HAS_ variables to correctly test for and
> handle the undefined case .

In general, I agree. But this would mean to reintroduce the multiply
duplicated Makefile bloat à la:

	ifeq ($(CONFIG_HAS_BOARD_SIZE_LIMIT),y)
	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
	else
	BOARD_SIZE_CHECK =
	endif


That's why after all I preferred my "test -z" solution. Is there maybe
a third way I am missing out on?

What do you think about giving size_check another argument, i.e. 
call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT)

Any other suggestions?
