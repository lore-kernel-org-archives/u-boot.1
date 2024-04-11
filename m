Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0084C001CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 21:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369FA87F4B;
	Thu, 11 Apr 2024 23:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="e1eu1kQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B62C88005; Thu, 11 Apr 2024 23:00:37 +0200 (CEST)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com
 [95.215.58.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E3F87E91
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 23:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Fri, 12 Apr 2024 06:58:04 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712869232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OG2/x6humJsmhnK8OM6b7VCuWaFjnKMlY/yFSHm0FT4=;
 b=e1eu1kQ2nlenegCptyMZmFO7vb/cG+mUgNPBF/BVEyywHtOpqDFrWTnMandTfpuUgwatV5
 1ZEoCts7fximdMlcW3wm3Uyh9Eb17GTaAKHFYXKp2eTainOYvuh7F+K/yltSzdTQX2Pl9T
 r7RmEcROY3olaoZjRdSmwWedYRMOi1WV/dI0+9F4SsHxGCJPDy0eu8emuJ5C5mT+xpXswS
 jJbAHc/jIoqDnW7+igaFkS7XANEKWDp8XysGJZG1L+HAAoOoQNuE2YPRoxnjaigf9GbN5T
 A+xDVcgVmbKh5Lz4xcgTc9RoECUK9SkyKLSWPaug+OQ517wlNhvX2M0OaFDTXg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jookia <contact@jookia.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] sunxi: Support UART1 and UART2 on the T113
Message-ID: <ZhhO3F688TvkEyvD@titan>
References: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
 <20240411133738.3209aa12@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411133738.3209aa12@donnerap.manchester.arm.com>
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

On Thu, Apr 11, 2024 at 01:37:38PM +0100, Andre Przywara wrote:
> Hi John,
> 
> > The T113 supports UART1 and UART2 on PG and PD pins respectively.
> > Add support for these in U-Boot so we can use them.
> 
> So those bits are just for the *debug* UARTs. Traditionally this is UART0,
> with some particular pinmux, sometimes UART2 on older SoCs.

Hi Andre,

No board uses this by default, so I'll just carry this out of tree then.
Thanks for looking at the patch!

> So is there a board that uses those pins for a debug console? I want to
> avoid making this code even messier than it already is, without good
> reasons. Also please note that I tried to clean this up here:
> https://patchwork.ozlabs.org/project/uboot/patch/20240103001239.17482-20-andre.przywara@arm.com/

I'll give this a test and review for you when I can.

John.
