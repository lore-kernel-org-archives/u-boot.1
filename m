Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F0CCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 07:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08614839B7;
	Mon, 10 Nov 2025 08:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1762760829;
	bh=LS8Gmej63tKT5NT7Q05EPGsKWWpjSDz5pVqkIlZ90Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3gbo6gHKo+ff5pQ5raj0aFXNcyAKyt9PdupvGb0QUQ2M+wevjeFOMtUNM/zOpE/G
	 yBqo+jvJVSLjz8bbMWc9I8R4JvlkUKhcvh0d1cmgTaAsmpna5f4XMAe1hER9GvQ/Sm
	 lHUzd3Vodxrisu1iuE4cRvLR0QjNnikqY2TmCzSjrireBu6Mbi1eN2tDFYOHvKAayg
	 U67ZDbPl0MAF7AYfS33aZ37hxjz/aySuJ/riPFqhWyCNgZQKQT98E1aoJVzvJWyjoE
	 CVLIcDmEXoT+oLisywMur8tmiwPzJj6jOBZZhtWNo+8fQB5SqQ0jljYSXAS1Lgbiyk
	 qPUlD+JiBcF4Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819B2839B9; Mon, 10 Nov 2025 08:47:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5B8839B1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 08:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="M5gPtQeY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2BA8A103CF2A2; Mon, 10 Nov 2025 08:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1762760824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=LS8Gmej63tKT5NT7Q05EPGsKWWpjSDz5pVqkIlZ90Cg=;
 b=M5gPtQeYXrLKi6v2eKUFCdmDH23XrENb8PoI25CSfVpaxRN/K6hz0z/sY2DXjd4VRh7ZJM
 FmGka/ceA02x8ugmhbZM0XUa81lf8xaajWxt9rdFV8vTZN8ZvhbIqZW4QLOOB7/bcnXVrk
 gMffF2KpbtHF4dRP6tfcmfUbkmxvZj6J0pJXJrkiNTHN+xlK6YVuKnXjmrNUVtwKT1fWJn
 2LwzVUz1e69x5a4p6GRSAJMm+VuMA2KbklRpEUTbSCCxaKKt46HkJmcE7ABUwbGhBMyPkk
 Z/pBzVh1b8JADjOhHnR9ovtJ5FI2p8KZVvGxr0eBmrg9vz/Z6sYru+m/dkMr+w==
Date: Mon, 10 Nov 2025 08:46:57 +0100
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
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v4 1/3] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <aRGYcTQQAVVJQGJa@aristophanes>
References: <20251015012320.2331007-1-pro@denx.de>
 <20251015012320.2331007-2-pro@denx.de>
 <73d7e852-b2c3-4ef2-a9f6-af4e37941ceb@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d7e852-b2c3-4ef2-a9f6-af4e37941ceb@mailbox.org>
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

Thank you for the feedback!

On Sun, Nov 09, 2025 at 07:41:13PM +0100, Marek Vasut wrote:

[...]
> > diff --git a/Makefile b/Makefile
> > index 2402f9313d8..e68dce2c1d5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1109,19 +1109,19 @@ else
> >   BOARD_SIZE_CHECK =
> >   endif
> > -ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> > +ifneq ($(CONFIG_SPL_SIZE_LIMIT),)
> 
> Why does this check not use HAS_SPL_SIZE_LIMIT introduced below ?

You're right, that was nonesense. See v5.
