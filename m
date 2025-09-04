Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E91CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA1383622;
	Thu,  4 Sep 2025 10:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756974025;
	bh=Kq9UeegZt/+NcvhRgRlFtdc7RDVd4+WXDMOGu2EEWdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HqUU8Og3l+Wq4vGJAknOCcauOnecaYeSTmueNisWrjWOgdAczX+JApNXSFP1qRZoF
	 wMCawA1GpkJ0ehMHY4LUkUxcgCtNn69kFdTUz6J8XuZA/3rKCM59Xb9kcwULV07W+i
	 AjuN3qrAYOGelJO1gCYKVBu1YJFaVgxcXjblsv0VgJEhf4W3aEAwx2LNnOK37920MD
	 kMqILAerV5/R8lCBJElucbgUGPgy1x89PW3jDs7RzqLow5/flN/D2kzxqd+/NXtFvq
	 qxNEqAGf0MVa1p6wAqAek2ExJGNW6GfZuz0L5XYUHsOxruW3nIF232odhDtCFzFZ6N
	 jnsQPtC8TukkQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B0D836D1; Thu,  4 Sep 2025 10:20:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17260835EA
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="id5twW1f"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9E4551038C103; 
 Thu,  4 Sep 2025 10:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756974021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Kq9UeegZt/+NcvhRgRlFtdc7RDVd4+WXDMOGu2EEWdQ=;
 b=id5twW1fWZ+E9xWt4RA3IivWRQSHjZ57xhNTVsUHm5ojzMkQVIBWtk30VnOGmxOl9Sd+H/
 VE+O9a1XNxUra1MRs0N8olX+uV8y/UpruuSj8X5pVvCoWVdQ/IXN0d0PU/6zvNzn24Of32
 pG7/HgGlSBCMudibibCEsGZqiIZoY0VjQ5VZDTiAGDZZZyNHTCVImt3//EG5QHiR95xhOl
 6aUPoPHnXgfbeM0wotAqV5cq7rhA1boN29EIZxFlc1ZYk4V+0B6+vAex5wQq7XXYg7XF9X
 vJutJCxvaousIBQXrzItL02pZwa067DZkNp18DmZI34e2A6leV2ol4XW/nmTMw==
Date: Thu, 4 Sep 2025 10:20:17 +0200
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
Subject: Re: [PATCH v3 3/5] Image size checks: Use consistent help texts
Message-ID: <aLlLwW-kSBnz_tjZ@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-4-pro@denx.de>
 <d527832a-6f39-46d2-abba-aac2a4cdc2ab@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d527832a-6f39-46d2-abba-aac2a4cdc2ab@mailbox.org>
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

On Wed, Sep 03, 2025 at 02:54:23PM +0200, Marek Vasut wrote:
> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > The multiple XXX_SIZE_LIMIT options use slightly varying help texts.
> > Their similarities and differences should become more clear if we use
> > consistent help texts.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >   Kconfig | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Kconfig b/Kconfig
> > index e73dd91a408..aa00669ba20 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -538,7 +538,7 @@ config BUILD_TARGET
> >   menu "Image size limits"
> >   config HAS_BOARD_SIZE_LIMIT
> > -	bool "Define a maximum size for the U-Boot image"
> > +	bool "Enable size limit check for the U-Boot image"
> >   	depends on !COMPILE_TEST
> >   	default y if RCAR_32 || RCAR_64
> >   	help
> > @@ -562,11 +562,11 @@ config HAS_VPL_SIZE_LIMIT
> >   	depends on VPL
> >   config VPL_SIZE_LIMIT
> > -	hex "Maximum size of VPL image"
> > +	hex "Maximum size of VPL image in bytes"
> >   	depends on HAS_VPL_SIZE_LIMIT
> >   	help
> > -	  Specifies the maximum length of the U-Boot VPL image.
> > -	  If this value is zero, it is ignored.
> > +	  Maximum size of the VPL image. When defined, the build system checks
> 
> The "when defined ..." part should be in HAS_VPL_SIZE_LIMIT , which gates
> access to VPL_SIZE_LIMIT . If HAS_VPL_SIZE_LIMIT is set, then this is always
> defined.

Yep, you're right. Good point.
