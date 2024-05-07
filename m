Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF06C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BC38872F;
	Tue,  7 May 2024 16:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Ssxge2vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B947C8872F; Tue,  7 May 2024 16:47:02 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B9088551
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a27e04a9-0c80-11ef-903b-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a27e04a9-0c80-11ef-903b-005056992ed3;
 Tue, 07 May 2024 16:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=Uw6Is1CXhHy+talK0U+OnoyZoBgNbDIcHqiV1OIeJm8=;
 b=Ssxge2vtWYhJvuncVQM4wx2wsZnjK8s5qSl5tXCcCWT1hjxLRwbjt7mS+mMmIp+kd4YZllCM6RkT1
 FPY1t1K5kaVEl5IDzJivywzXydjCaPE49bukCSQOtDY+quvQXNDdeDvqWQFAalh1EW7gO60LWS94HC
 GcqCUJvZKZ9hk6h9Ik9OzLlOrmS39Kejhjkp6w0w7uhlJMbwEJ4lDxF6qTzAZuSFPhr/DBG8txhe3H
 En1nxkaPjx1os/+M6x/TevZmtfhkaXesliguzO+ZJA9QWHZjIe4HSUtLIUr9ZofpdCghtJyBZFAfn3
 jsnZH2RNPH2qEPZoOOSxqTQl0B91u1w==
X-KPN-MID: 33|jm156B0XwDa9fOtcMlhKy57srHZQOfDV/2qLE93EruEhlK0PkT0ZvCTYYmtp1DS
 geGx82o+wQPEPzgltXMVhW+FsR1fh1YNnjTPDLpSbGBY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|62kXG24JhabMj9SJ9Tto6ajjrHsxgDJQ8Ta+6cM8j9Fnuii8CuABI+r2WiZnF35
 Z3V1ImLV995PergNnPaYHCg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a822f19c-0c80-11ef-9bda-00505699772e;
 Tue, 07 May 2024 16:46:59 +0200 (CEST)
Date: Tue, 07 May 2024 16:46:58 +0200
Message-Id: <87zft1he71.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: antoni.s.jankowski@gmail.com, u-boot@lists.denx.de
In-Reply-To: <CAByghJZx=KFcygY2=N13=Tw94e3=7+gg7h6Usad2McjaBV2KKw@mail.gmail.com>
 (message from Igor Opaniuk on Tue, 7 May 2024 16:30:17 +0200)
Subject: Re: Distro Boot instructions with examples
References: <CAM4sPk-un78JmrMQpAe24nWMp0ytrieyL3zrZd_Qg9HOm--gtg@mail.gmail.com>
 <CAByghJZx=KFcygY2=N13=Tw94e3=7+gg7h6Usad2McjaBV2KKw@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
> Date: Tue, 7 May 2024 16:30:17 +0200
> 
> Hello Antoni,
> 
> On Tue, May 7, 2024 at 4:14 PM Antoni Jankowski
> <antoni.s.jankowski@gmail.com> wrote:
> >
> > Hi,
> >
> > I've recently learned about the Distro Boot feature of u-boot. This sounds
> > interesting, however the official instructions are sparse and examples seem
> > to be non-existent.
> >
> > The platform I'm working with at the moment is a raspberry pi CM4, are
> > there any examples of how to implement this concept? Distro Boot seems to
> > be suitable for updating all the rootfs at once, including what usually is
> > a separate boot partition.
> >
> > Best regards,
> > Antoni
> 
> There is a nice manual from Toradex about Distro Boot integration [1].
> You can also find a bunch of examples of integration of existing boards
> just by grep-ing:
> 
> u-boot.git$ grep -ine "config_distro_bootcmd" -r ./include/configs/
> ./include/configs/pico-imx6ul.h:86:#include <config_distro_bootcmd.h>
> ./include/configs/kp_imx6q_tpc.h:84:#include <config_distro_bootcmd.h>
> ./include/configs/imx8mp_venice.h:21:#include <config_distro_bootcmd.h>
> ./include/configs/stm32f746-disco.h:30:#include <config_distro_bootcmd.h>
> ...
> 
> Hope this helps.
> 
> [1] https://developer.toradex.com/linux-bsp/os-development/boot/distro-boot/

However, "distro boot" is being superseded by "standard boot" in
recent versions of U-Boot and the raspberry pi boards have already
moved on.  See doc/develop/bootstd.rst for some documentation on
"standard boot".
