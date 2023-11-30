Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DA9C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 22:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7670E87707;
	Thu, 30 Nov 2023 23:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Z3J6oPqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F2D87707; Thu, 30 Nov 2023 23:39:59 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5A4876B2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 23:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6036e971-8fd1-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6036e971-8fd1-11ee-91e7-005056994fde;
 Thu, 30 Nov 2023 23:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=2OivNAWDJ/fDOL7LZYDg+lojuKIM5Agl15aqduX2omQ=;
 b=Z3J6oPqmokJeXABIxy4d00Th3Z3YJMTeX5mwa7TkiIl3kYnzwbfSZzsVI8qX7kPb+0zyOce50Ucyf
 UYL3+e+OthfVBS9yT6KqPG8dnt6Huf7GdoIEBSgsae03hP+yIDm9dTp0cZnTgNGgzcZV1A+TUe4YSy
 mFODDVqHDYfZ6ilnPyq3VHzc/fgdEDrAcpXGao6nQ+q1hEz/a+DyzFURBM+thqJm9I60Q0qt/l9Yuh
 6EowAyh9MEw55UcNlGf6LVO6GvZIMSxnNpQ2JbU88Rpm/J4WZuH41Cq0+HyNMD4MFrU7YSEudqwAAC
 n0fSErgYRcyR0d00alMibfopO20LLXA==
X-KPN-MID: 33|BqJ8hhLV5FdQ9krl4wlZCN+SkRxZnBl9BK89JJZ7ejubqVqr7Yg0k5RIN/gi1QP
 EoAnNtLYdX6/5GTALVEuMx/MeVYVioA9vf4dtw8jD+WQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|UxTze5NWJ0PikZvZnzhDqMXEy1pVUr/sb/MpyIwkk9ikWg/ld70m/xvOfgowfW1
 gB14CTIysFJrgIm2YVzfWSQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 620779ca-8fd1-11ee-9dc8-00505699772e;
 Thu, 30 Nov 2023 23:39:55 +0100 (CET)
Date: Thu, 30 Nov 2023 23:39:55 +0100
Message-Id: <87h6l227d0.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: "Janne Grunau" <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, u-boot@lists.denx.de,
 asahi@lists.linux.dev
In-Reply-To: <6ff006e0-941d-477a-b3d9-01986d317a04@app.fastmail.com>
 (j@jannau.net)
Subject: Re: [PATCH] arm: apple: t602x: Add missing MMIO regions to memmap
References: <20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net>
 <87jzpz0y34.fsf@bloch.sibelius.xs4all.nl>
 <6ff006e0-941d-477a-b3d9-01986d317a04@app.fastmail.com>
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

> Date: Thu, 30 Nov 2023 23:04:36 +0100
> From: "Janne Grunau" <j@jannau.net>
> 
> Hej Mark,
> 
> On Thu, Nov 30, 2023, at 21:45, Mark Kettenis wrote:
> >> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> >> Date: Thu, 30 Nov 2023 13:42:22 +0100
> >> 
> >> From: Janne Grunau <j@jannau.net>
> >> 
> >> The memory maps for Apple's M2 Pro/Max/Ultra left MMIO space out which
> >> was not used by any driver at the time. The display out exposed as
> >> simple-framebuffer use a power-domain controlled by a device in an
> >> unmapped region.
> >> Add a map covering this region as well as another MMIO region in the
> >> range 0x4'0000'0000 - 0x5'0000'0000. The added regions cover all MMIO
> >> annotated in Apple's device tree in this range.
> >> 
> >> Signed-off-by: Janne Grunau <j@jannau.net>
> >> ---
> >>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >
> > Hi Janne,
> >
> > Is there a reason why you can't use a SZ_1G mapping for the blocks
> > where you're using a SZ_512M mapping?  With SZ_1G the mapping code
> > will use a 1G block descriptor which avoids another level of page
> > tables.
> 
> no reason except that SZ_512M was sufficient to cover all devices in
> Apple DT.  Shall I resend the patch?

Yes please!
