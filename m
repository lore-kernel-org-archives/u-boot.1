Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED9FC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 11:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AD882045;
	Mon,  2 Jun 2025 13:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748862087;
	bh=Er9Gd9m/a8zVNiTBr99vpVwSEEpd+k67eAgksWCHBKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Us2S0+bs/jlEMzIzN4gYXJzHsX4HCKk6yQG5k4CFe0j267PABS2j+/S/5JzWbT68n
	 jGjx06y9f5r6GabYoUZ0lUGXNC5LPR1uvKlCIN77TThk6kyt4ZYc2Hh1BGl2amYWxY
	 HKqGcjh2oPHJvPOZGVnrCd3Pd4g3Q30tMyCj4YOwLNh0r19ZodyBH8gZ9Leekh6ahD
	 i8uoU3uUmCOulfeulJ3EPn3H1bh0bLikAQBs77Tt+3/t7Leq0xxhKUHRtWuNLMeri0
	 urRv9SsDtsAg7JrU5ts/RjtNts0dPazBjq9uk1kYGM9Arxz9aLk3E+GEZbpJI5Qizx
	 +ryK3ra93baHg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC8F828BC; Mon,  2 Jun 2025 13:01:26 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D1581FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 13:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="H2V1cQ72"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D24B10397298; 
 Mon,  2 Jun 2025 13:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748862082; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Er9Gd9m/a8zVNiTBr99vpVwSEEpd+k67eAgksWCHBKk=;
 b=H2V1cQ72/W/sQET8alQRJKJWkkvvMzalhRtvVhgk5K0Up3XIIXRmtIGFTQrufc2Ipy44ju
 PWZlyIF0tw93daxc9ycLM89hgAaT16elhGwcgE3CQsOup0N65mrOSClAxpD+sI0McYJ+b2
 gBlslhgzUngBfN34dGq0UoRgYdmyP0IHERnjkOxy2orNeZ051T74TM/MtLO/n2Gbg6P7W7
 6iZFlx97ufLQY8oHvR4zcmMvLSwZZgYn4bSPjScXW2T5UaDJPyfQiu8Drqnw2fBMiRLJB0
 TjjR7kvWJpvWno4S9rh8MY6YMQGiYrcL+j5tlGq/kvEPmLouRRLWYy/3B5SYmw==
Date: Mon, 2 Jun 2025 13:01:18 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] spl: Add size check for u-boot-with-spl.bin
Message-ID: <aD2EflR9DRYG-MY5@antares>
References: <20250527121049.106825-1-pro@denx.de>
 <20250527121049.106825-2-pro@denx.de>
 <20250527134906.GI100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527134906.GI100073@bill-the-cat>
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

Hi Tom,

On Tue, May 27, 2025 at 07:49:06AM -0600, Tom Rini wrote:
> On Tue, May 27, 2025 at 02:10:48PM +0200, Philip Oberfichtner wrote:
> 
> > Introduce another SIZE_CHECK macro for u-boot-with-spl.bin.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> > 
> > Notes:
> >     Changes in v2: none
> > 
> >  Makefile           | 7 +++++++
> >  common/spl/Kconfig | 7 +++++++
> >  2 files changed, 14 insertions(+)
> 
> So, for u-boot-with-spl.imx we use BOARD_SIZE_CHECK and
> CONFIG_BOARD_SIZE_LIMIT. I think for consistency it would be better to
> re-use that option here and expand the help text on
> CONFIG_BOARD_SIZE_LIMIT to note which build targets make use of it.

Thanks for the feedback! I've tried that, but I have the following
issue:
	- 402K for u-boot-nodtb.bin
	- 152K for u-boot-lzma.img
	- 191K for u-boot-with-spl.bin

The end result, u-boot-with-spl.bin, meets the size restriction of 192K.
Nevertheless, an intermediary (uncompressed) artifact, u-boot-nodtb.bin,
causes the build to fail.


Instead of introducing a new Kconfig option, it should be fine to reuse 
CONFIG_SPL_SIZE_LIMIT for u-boot-with-spl.bin. I'm not sure which way is
better. What do you think?

Best regards,
Philip


> 
> -- 
> Tom



-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
