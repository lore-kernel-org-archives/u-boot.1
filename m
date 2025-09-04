Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E141ECA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B50683734;
	Thu,  4 Sep 2025 10:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756974231;
	bh=M3fioKzC1RjPCaRJuD0/Xwaf1+Rwf+49EP3oD//zNA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VeQRHGPVu+HbH78nTOVIKb8p4MGwWJwICGzCNxgM9B75hvKEHi5NGkP7RJfRJla+R
	 kSN3lbl2bUAh4ToRPCqEhdZ0xmDIjLsFSGBOF1LauXOZDdIM51+C6Jn7v0Wa9FvZWg
	 gBYgvLbzL9QpkRJX7Rz0pir8Q4T4sowUFKkyzftZFl1EWNoucXmYr5bACPWH7R9ofB
	 P1q8l3I2KUDcJMF6+KytBKIOA0gVI/wo7981ll3Y4vH2MwzOz9L2Xcdy8jddDxrzHQ
	 iL0zT2jFPh+zwbQWfOrqqzQG1wb2LqCTKf6ckF68r+dDNQ9NNHQFNpt5+kFjrKfwiW
	 vLyyuETPPpcyQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7DC583754; Thu,  4 Sep 2025 10:23:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EC383622
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hBZcv1MZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 345201038C103; 
 Thu,  4 Sep 2025 10:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756974226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=M3fioKzC1RjPCaRJuD0/Xwaf1+Rwf+49EP3oD//zNA0=;
 b=hBZcv1MZUBk9ofru+gwo8CH5yk0gxFUUNlcul1+h0J7rjm1H6fBMU6XIn18KD13EgF58eP
 0gZ4SRyBvBn+97RyKDuM1MTXb6x2CBZoAUBPjTZE122lpj4dt58zr1o1jQLSRK9I+LmOCv
 UlscA4SbCpoJ89K9srgAyHKWk9lQkEINpApBnDDu6gyDf+nHCf33kDtMmXpPIopIk5o8Te
 lLXOGCRC1h1XAHXUyW+VYQGy0ZoRfYVEbfrSDGPeZ1TQQyLEICsDhxwn4VgTJxM9dWzIeY
 KJPuYcmV/MN7MftaCszvzXMTaqQh2VvEUqmUr5ja44onrrSikPTjyXeM5ntCsQ==
Date: Thu, 4 Sep 2025 10:23:41 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
Message-ID: <aLlMjQb0Qs-VkiaX@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-6-pro@denx.de>
 <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
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

On Wed, Sep 03, 2025 at 02:59:01PM +0200, Marek Vasut wrote:
> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >   Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Kconfig b/Kconfig
> > index aa00669ba20..343299eed50 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
> >   config SPL_SIZE_LIMIT
> >   	hex "Maximum size of SPL image in bytes"
> >   	depends on HAS_SPL_SIZE_LIMIT
> > -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> >   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> > +	default 0x11000 if ARCH_MX6
> This makes it less obvious what the other case (!256 kiB SRAM SoCs) covers,
> why is that an improvement ?

This was originally Heinrich's idea. I personally find it better this
way, but I won't argue about it. Can you please find a consensus the two
of you?
