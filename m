Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0F9CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 19:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2BB80107;
	Tue, 14 Oct 2025 21:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="BUFR7AD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9639807B1; Tue, 14 Oct 2025 21:41:35 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADE0800D7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 21:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=Qajaz/K6P1tnUFudwWsHmyrJdctTZI+5ddRWLqTl4t8=;
 b=BUFR7AD6LXJ0tVrUfPbVoHP91ZQ2GE5Ypl873nTwU1LsB9yfvb3OA6SiYnL0wAurlob3fXPtv0MdierbvGS81o25GiE9j7emNMps+EBgpOZKneYbyNUrnZ2Gv668ojaOhmePlihn3DRCev9dPQXvpqxnAvTIYZuMgjT45wMrWKWg3ndEtK+57/HIVuMlHMYVcUe3MSPnmUAc+aUCpGKw8Zn9/T7AH5nrHaVqcng93f4mxC3VjakQNE2uCT
 iuUm4FMLge9j+M+mhlcxDuGXWjfNBkcUKE0EsUr9gUBfFTVl4yG5VUG4hfhb5r3GrAHPa83Fwn7m3Yb7gBLXW74ej07A==
Received: from GRAPHRT (188-24-192-7.rdsnet.ro [188.24.192.7])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 14 Oct 2025 19:41:17 +0000
Date: Tue, 14 Oct 2025 22:41:25 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Subject: Re: [bug] can't start watchdog on RK3288
Message-ID: <aO6nZTCUtgnZdN7G@GRAPHRT>
References: <aO5F+z0n5ETHZZGt@GRAPHRT>
 <CALeDE9M1nfBSM6jLer1uqtzf+b8eZq_33ALA7_mSKC5k53OoQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9M1nfBSM6jLer1uqtzf+b8eZq_33ALA7_mSKC5k53OoQw@mail.gmail.com>
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

On Tue, 2025-10-14 19.12.23 ++0100, Peter Robinson wrote:
> Hi,
> 
> > I have a bug to report. I tried starting the watchdog on Asus TinkerBoard S
> > (Rockchip RK3288), but it's not working. I investigated a little bit. Here's
> > what I found so far:
> 
> What version of U-Boot is this? Does the watchdog work in Linux?

Github master from 2025-07-29.
In Linux I can start busybox watchdog and there are no errros. I can see
class/watchdog/watchdog0/timeleft counting down and being reset, so it appears
to be working, but I never tried to let it reset the system.

