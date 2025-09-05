Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94696CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF04583807;
	Fri,  5 Sep 2025 10:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1757060146;
	bh=UxzCuuz7JjUgyLKAnpbJKlsGqpacZPPv8fuwnfGnSrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FMtdt9QjtNv/HJvcTW5ZEYyr08ltBcdDTbixb0aeJslbTLB4vjdcuJRQWKodp12/c
	 ulLWxtKA0jX+7O5cDQppDmcVMuPWZ9HBey/yx8i+zPMmHzuTu8rwnp0IQe0PRB3+XP
	 yc2deePeVDnrg37mWfJbszpymUs73x2TbQHPwYWJlsM5hZ/Gy/aMeCZKwayKBSGB2g
	 /gFhSKi5+vKC97132JqJ23DovjHSZ7Scy2SHUKXWx5GQYb6rHpNrsfYFOz6wT80DyN
	 NIuY60gzvvWEUIjoqG2xPnegBM9n3N+0AikXI629WwteVZ9TeELafXTlYS6I5Zhccg
	 998YwqkvvZQYw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1C383870; Fri,  5 Sep 2025 10:15:44 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E990883390
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BSP7LhZF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 04CCD1026E167; 
 Fri,  5 Sep 2025 10:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1757060142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=UxzCuuz7JjUgyLKAnpbJKlsGqpacZPPv8fuwnfGnSrM=;
 b=BSP7LhZFtkjWugFrZV9aM9sQy7I3nZfUYQPkV2M9z6xevrQiUO6Riz+Cc9WbrppVXdCJeG
 grQWsbnJj3+Eia8A4OhOgQ/4HgF34ygwv3YxyptNOY28BCro+lIpUHXzX58tfzLFnACiDd
 lITreIEd1xBESOSuI9mG6+1nG24CT0l2kub9xoVJloe/wj1jlxG4XmgsURC2lkWjPmlTMP
 +KinHY5zdvooC6+wcQmXhOhceGbuyMS0jWbBpqwbLPKiprQ2W6+/1OhQbIlPPSM2LRoJvo
 G1zGgdP/MGNpSmm7wlpfVYq7NpbqCskrpXNG0knxvkBWcqAGZ1EBAOM3oElaHw==
Date: Fri, 5 Sep 2025 10:15:38 +0200
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
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <aLqcKkrCryVNCAQX@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <d1b371f3-df96-421d-8f26-635ac0382666@mailbox.org>
 <aLlLdkRkqrfLm2FY@aristophanes>
 <7826abc2-ef93-4b76-9478-f4be1dd05246@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7826abc2-ef93-4b76-9478-f4be1dd05246@mailbox.org>
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

On Thu, Sep 04, 2025 at 03:56:26PM +0200, Marek Vasut wrote:
> On 9/4/25 10:19 AM, Philip Oberfichtner wrote:
> > On Wed, Sep 03, 2025 at 02:51:44PM +0200, Marek Vasut wrote:
> > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > 
> > > > diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> > > > index 05853317fea..dfac96379ce 100644
> > > > --- a/configs/am62x_beagleplay_a53_defconfig
> > > > +++ b/configs/am62x_beagleplay_a53_defconfig
> > > > @@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> > > >    CONFIG_SPL_BSS_START_ADDR=0x80c80000
> > > >    CONFIG_SPL_BSS_MAX_SIZE=0x80000
> > > >    CONFIG_SPL_STACK_R=y
> > > > +CONFIG_HAS_SPL_SIZE_LIMIT=y
> > > How much of this massive config file patching can be done using some
> > > "select" in Kconfig file ?
> > 
> > I'm not following you here. I'm only adding CONFIG_HAS_XXX_SIZE_LIMIT
> > wherever there already was an explicit CONFIG_XXX_SIZE_LIMIT in the
> > defconfig before. I'm not changing anything here. Can you please
> > elaborate on what it is that your asking for?
> 
> Can this massive configs/ update be avoided by using a default value /
> select / imply in some Kconfig file ?

No, I'm afraid it cannot ...
