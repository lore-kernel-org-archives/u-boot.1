Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6748CA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DAC383622;
	Thu,  4 Sep 2025 10:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756973956;
	bh=40YxKAXFsdnmwHBEP3yZ86GbYXiG5S1mtzN8/FAjY/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVJqoZ2Nxi6t2vQqUVj3jkJKia9md6DC7l4Hwrr21G3AUmRAQbJQozv/GjT2ekSya
	 T5C4rzKAB90WM7FCdjYVpd18CzAJvPcFT4HynORdFtcIaU4vtAihz46GcezKXrN3L9
	 sYGDsfUWxmJEesd3nkwLxf8/4lAmPzLwxg51+Vhce7hbb1vFTsHLXO4e/hoPHfZQbo
	 tmkfrW7lI1UOfsC5sz9DaKc2qMFMZGl114nJlibWMxtmb70c5frejotCwIspSP2bd2
	 Fv8UaIOIxKAzwIL66jP8CYgiZbpO4mcEekr75N94mFHAqcSyfRcn9ziGka1gGto+U+
	 TlEbO9CywmzlA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727B1836AC; Thu,  4 Sep 2025 10:19:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E613835EA
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JCLBiOlk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4F51D1038C103; 
 Thu,  4 Sep 2025 10:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756973950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=40YxKAXFsdnmwHBEP3yZ86GbYXiG5S1mtzN8/FAjY/Y=;
 b=JCLBiOlkdaLJjb+gMqs72HsRz3yczlvzN87r3ZOlE8F1EyiXvCbLy6uKr4sfAP7M0xIuna
 3p3/sCil3IvT1ujBWlNxOVhPjfCY0x/TbWPp8Ugya3ACm4H2vtEqYRH/vDs/0O9tettdez
 jz7O7nIvKPHTkzVqwveXV1plPwYYJKbUW3gEfsqo5NOKpnkJnVMjfvdggvi7Cn7FZh2jM7
 r/2PX+BUXJjrZDou3MQuOTQgXVC3vdtk9eHCYOtMQZp3MPHjh6gbTuODo7R83MAFBqNYI8
 T1SE3NfLovQtgg8GT7Uh0DOOhSlYzBlTwgpkeE3gvSFCb02yHRc1RPukFUvl9A==
Date: Thu, 4 Sep 2025 10:19:02 +0200
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
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <aLlLdkRkqrfLm2FY@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <d1b371f3-df96-421d-8f26-635ac0382666@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b371f3-df96-421d-8f26-635ac0382666@mailbox.org>
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

On Wed, Sep 03, 2025 at 02:51:44PM +0200, Marek Vasut wrote:
> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> 
> > diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> > index 05853317fea..dfac96379ce 100644
> > --- a/configs/am62x_beagleplay_a53_defconfig
> > +++ b/configs/am62x_beagleplay_a53_defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> >   CONFIG_SPL_BSS_START_ADDR=0x80c80000
> >   CONFIG_SPL_BSS_MAX_SIZE=0x80000
> >   CONFIG_SPL_STACK_R=y
> > +CONFIG_HAS_SPL_SIZE_LIMIT=y
> How much of this massive config file patching can be done using some
> "select" in Kconfig file ?

I'm not following you here. I'm only adding CONFIG_HAS_XXX_SIZE_LIMIT
wherever there already was an explicit CONFIG_XXX_SIZE_LIMIT in the
defconfig before. I'm not changing anything here. Can you please
elaborate on what it is that your asking for?
