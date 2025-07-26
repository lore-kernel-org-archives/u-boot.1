Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE29C83F17
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 16:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72EA8309E;
	Sat, 26 Jul 2025 18:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="R2IAYpg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C42830A0; Sat, 26 Jul 2025 18:30:58 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465F08307F
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f81d6706-6a3d-11f0-84d2-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f81d6706-6a3d-11f0-84d2-005056992ed3;
 Sat, 26 Jul 2025 18:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=7ie5fLSodXTZ1GJYctckcRTT+3765RAYzdAJ6teTi8M=;
 b=R2IAYpg3msdEIKa3GwTtM+qf2Rp/uMig0nXNxAgLOlGxwhkN4ixLfOPBgKLi086aGdbXvyj1BRGqJ
 QRuYQ1gJbvLoKQCNP48imY2EpqfHoGLvnzsIyRSl6k8LHPA2a90TMz+UBeFFUhLWUSOFzq5ctSe1tm
 FGsR/U8wnmYaBvgQpN6MenTQ9o/Adb1NvwO4ZXGccl21Z5NeHYqryOzy7ThOMgRN3TzDUGleLedygN
 rviRJxHn/BIUkVO7y+SbJlTyAfBsiv6/+G7rALPk+qkX3dy8gYdB6gg9KoI0fvMTfZiQZLh7i09d3+
 G84Mgdr4/UUROKOHF4XWHhf/6XYsJuQ==
X-KPN-MID: 33|0WwXs1jCYGYixFF3M2C6mVYXHkfv3eaOoGZmCMZhO1ITnkFK0Dw3ZZR+lnZEt0H
 gBAHo58TBqF8xoANi84aO8Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eXoboHxwORbmQs3Fad250E9dfLpQLZSltmWlIhHbrdufrTm7xkimPVlFpmW0mhW
 Rsc9GuGgmqBqYftPNG6mVPg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e6f955b6-6a3d-11f0-a618-005056998788;
 Sat, 26 Jul 2025 18:30:55 +0200 (CEST)
Date: Sat, 26 Jul 2025 18:30:54 +0200
Message-Id: <87freiap8h.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: xypron.glpk@gmx.de, javier.tia@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
In-Reply-To: <20250726154516.GG1807455@bill-the-cat> (message from Tom Rini on
 Sat, 26 Jul 2025 09:45:16 -0600)
Subject: Re: [PATCH] efi_loader: Add support for .wic files in URI boot path
References: <20250725173534.247188-1-javier.tia@linaro.org>
 <46A97A81-B04A-4BCC-A5EF-2639593DD86F@gmx.de>
 <20250726154516.GG1807455@bill-the-cat>
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

> Date: Sat, 26 Jul 2025 09:45:16 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Fri, Jul 25, 2025 at 07:56:39PM +0200, Heinrich Schuchardt wrote:
> > Am 25. Juli 2025 19:35:33 MESZ schrieb Javier Tia <javier.tia@linaro.org>:
> > >Together with current '.iso' and '.img', the try_load_from_uri_path
> > >function now allows files with the '.wic' extension as viable bootable
> > >images.
> > 
> > Why wouldn't you simply name your files *.img?
> 
> The answer has been lost to time at this point, since output has been
> ".wic" for over a decade now.

Note that other EFI implementations don't support '.wic' either.
WHich is why we switched the OpenBSD installer disk images from '.fs'
to '.img' some years ago specifically to support EFI HTTP boot.

> > Shouldn't we get away from the DOS age routine of relying on
> > filename extensions?
> > 
> > Just check if the fileheader is a PE header or if it is a known
> > partitoning scheme.
> 
> Looking in to a cleaner more general solution is worthwhile, I agree.
> 
> -- 
> Tom
> 
> [2:application/pgp-signature Show Save:signature.asc (228B)]
> 
