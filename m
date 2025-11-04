Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3ABCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657B1808AF;
	Tue,  4 Nov 2025 12:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1762255735;
	bh=XAeZhEVWDJkvsRG/0E0gt4ciGnUhbj3STds0ifmEzPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjwDFvlyjKpqMaPJqqV58348WtzzSU6MNiHAnFzaZFYP6/7k3HIqp6CnI6gOTLXAB
	 jeYZJc81WCUSG+ROFOf8fy5D0y0c4QMb8d1s22S7V8s6y+dNvAdk08NcEo6JxNN+5a
	 +5bUYfVffnFCP8uXQLsoVpQq6JMAYzZGURnLTdXkl4oQDvsclnt59MF21i5EPAz4wA
	 Za6+Uh14oLJBUNaGhdqfKtmruRuOUL6UJj2EABy58s3Puh+1HNkN6mRhuo5b8db5LI
	 3aPYbY8k7XzzIny/THszYEg4Vw5lX3ndHIRJRvqzO4dMYvYFGvsBvA144nnsxXt97/
	 J2b6+R0XKJRfQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8A38144A; Tue,  4 Nov 2025 12:28:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A29FE8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Degl8skm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C23D103CF29F; Tue,  4 Nov 2025 12:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1762255731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=XAeZhEVWDJkvsRG/0E0gt4ciGnUhbj3STds0ifmEzPk=;
 b=Degl8skmzjpfIMU9iKQduBQFDTvBep3/N0AGnxab28O16qJckCmIO/MXRL1mU9cyZWgDne
 z0L54sM7soR6CZhDkFufuYdGE/Dt/oKCzFGZlrfU+IioYUZkmjG/N0nZzhm47ol3S21VGC
 NCImLnFuPuJfNvbrg4VmZ2Gf257VvdKwRNyCJk3U+Y21hI4GK0QbU1ZCUsHmfteLQljCmq
 S+tBl/KfTGANhFTKQAWQjNWpWzrP3vSG3w+6nb/7V1KhAfq4t8OtyDAdUmUAGlScqCHqK2
 NI9XP54QkOPwzS91VhWze3Po4EIq3Q5a/iimyYGA36Zp7jUDYzOD9c7oz9V9SA==
Date: Tue, 4 Nov 2025 12:28:44 +0100
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v4 0/3] Harmonize image size checks
Message-ID: <aQnjbE0nAG7AFJlG@aristophanes>
References: <20251015012320.2331007-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015012320.2331007-1-pro@denx.de>
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


On Wed, Oct 15, 2025 at 03:23:17AM +0200, Philip Oberfichtner wrote:
> This patch series aims at harmonizing image size checks, which are
> currently represented by the following Kconfig symbols:

Hi Tom, Marek,

I think I've addressed all the points discussed in V3. Do you have any
more comments?

Thanks,
Philip
