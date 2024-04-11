Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C2CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 21:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF10881CA;
	Thu, 11 Apr 2024 23:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="pQWOoqkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B61881D2; Thu, 11 Apr 2024 23:05:24 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA5687FE8
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 23:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Fri, 12 Apr 2024 07:03:50 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712869521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8oTnNzizMVkHbOsxmJarecTqZo2rV83ZWh4lBiq4z4s=;
 b=pQWOoqkL/E6ata17m4IToBc7HuXechBXpTOQDguZcnzJRsluAR+uyqpZgyRpYVMXYl5pFR
 GChhi9h97242meeYkkXlHwcwTCUfT7v/7/kGata6kuKsSfG/sD36B//Qi4TGXsoZq5CujY
 Eb4bT3fnpTl7S7cN1sSLscpm5SI4noPtQEE/0UYxdhPI/rYUZcOS8mf+6TGHKhW/2Uti8Z
 J7F56qsmlftPQpJJj3WxvMpuzCZkWJFIWtC8hNh1KqRT9w6g0Hu/MwTb0SthBosQIG3G+Y
 I5byrruppRlbADPNEtLITl5era6cpHZ9BpzXzOBcojjBWxa8xbWvmplviB/I/Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Pass baud rate to stdout-path
Message-ID: <ZhhQNhUdeTdp_1Eg@titan>
References: <20240411-stdout-v1-1-66ebe5bb152f@jookia.org>
 <87r0fcgci5.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fcgci5.fsf@bloch.sibelius.xs4all.nl>
X-Migadu-Flow: FLOW_OUT
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

On Thu, Apr 11, 2024 at 05:11:46PM +0200, Mark Kettenis wrote:
> You probably should fix this by making sure the device tree you're
> using has the appropriate stdout-path node.  Because I think the
> functionality you're trying to use here is deprecated:

Hi Mark,

Interesting, I'll go with that approach instead.

> ...
> 
> A particular case that I'm dealing with is the default speed of
> 1500000 that the various Rockchip SoCs use.  This doesn't work with
> many of the USB-to-serial interfaces on the market and is also rather
> susceptible to line noise.  So for OpenBSD packages I've decide to use
> 115200 instead.  But that means I have to patch all the device trees
> in addition to changing the CONFIG_BAUDRATE setting.  If U-Boot would
> tweak the stdout-path property based on CONFIG_BAUDRATE that would
> make things easier.

That's an interesting use case! Would you mind testing this patch if possible?

> Cheers,
> 
> Mark

John.
