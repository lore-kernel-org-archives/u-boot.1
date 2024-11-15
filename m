Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2897D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 22:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E1688E77;
	Fri, 15 Nov 2024 23:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Raytv6hJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E20288F28; Fri, 15 Nov 2024 23:48:49 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3CC88E32
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 23:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: c5a97bcf-a3a3-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id c5a97bcf-a3a3-11ef-93fe-005056994fde;
 Fri, 15 Nov 2024 23:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=KGURzVrixlbjIAvI0Xys2TOMNtq9/QcsAELKEa7Hcrs=;
 b=Raytv6hJXxjNiDf7nCLaXMkYFXR7po4biF6OGvCmscmsHlOoEuWRizsPFIu0T0xcT+CsQ9MkxdyX5
 GMzdTRqXUYqk+C74983F8b4wFvOo+nQMfV++HMybwOhY12IBExWSs8/bcBo6Qxwapi6Zjdls1h4pFe
 sCIXzOND89s7KbnkSSOrllx3eO2N/mYplkkpxxdjuGRSSCAGvImTih0UpZ5cUsT2/PQK/d5Sm6ESrM
 IeKShs8lFD2iSEM1+Wvj4dKxt64yuDRz+REGzN+gOyMoa2REY+cMOM3eEmPFblEc7SpN5y8Q5eqHq4
 yVJQmffIoYbtM4I9tS7dtzHOkMueBuA==
X-KPN-MID: 33|THlcZBdlSOUDmIu509ZCnh0L2LBKAmyeSU0KiKSu/YRiIUuMwbQ4ITfSbjT9Gmp
 HkxVz3wgIg9FQPcmGAk4PvjsBzweqUmqv0ikX/zVJ0dM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PuHL2xvdoNrhCWNE4m8QBlGzrfOPWyKv24RVZLWnk5ox42SPC82qHNY38nTe9Ap
 LxVSfSd6iwhiYamGdhORKvA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c517b92f-a3a3-11ef-8887-00505699772e;
 Fri, 15 Nov 2024 23:48:46 +0100 (CET)
Date: Fri, 15 Nov 2024 23:48:45 +0100
Message-Id: <87ikso15bm.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com,
 hugo.cornelis@essensium.com, sjg@chromium.org,
 paulerwan.rio@gmail.com, al.kochet@gmail.com, ada@thorsis.com,
 philippe.reynes@softathome.com, u-boot@lists.denx.de
In-Reply-To: <87bjygmhfe.fsf@prevas.dk> (message from Rasmus Villemoes on Fri, 
 15 Nov 2024 20:21:41 +0100)
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl> <87ttc9m0cm.fsf@prevas.dk>
 <87o72g1sbd.fsf@bloch.sibelius.xs4all.nl> <87bjygmhfe.fsf@prevas.dk>
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

> From: Rasmus Villemoes <ravi@prevas.dk>
> Date: Fri, 15 Nov 2024 20:21:41 +0100
> 
> On Fri, Nov 15 2024, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> >> 
> >> Or use getrandom(), which according to the man page has been exposed via
> >> glibc since glibc 2.25. Or just read from /dev/urandom which should work
> >> everywhere.
> >
> > $ man getrandom
> > man: No entry for getrandom in the manual.
> 
> I assume this is intended to inform me that getrandom() doesn't exist on
> *BSD?

Right.  We have getentropy(3) though and that made it into the recent
POSIX update.

> As I said, reading from /dev/urandom is probably better as that also
> works on BSDs automatically. If somebody tries to do crypto stuff in an
> environment where they've removed such a basic device node, they get to
> keep both pieces (i.e. the code should just fail)

Should work on OpenBSD, but it is still unportable.
