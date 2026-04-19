Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CBBEA719B
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6663839D9;
	Sun, 19 Apr 2026 15:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="bE0ph7Sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF4D83E81; Sun, 19 Apr 2026 15:54:27 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720DC836AC
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 15:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fz98W16D4z49Q67;
 Sun, 19 Apr 2026 16:54:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1776606859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Csml1EOqJN5PhipgtBm6nuoTv7jjz7hG3T7L5Gwu8w0=;
 b=bE0ph7SxkNUdiC0nMotEIkctS+fS7OWXII1MuTIIOL51Ik2fLYonaTiVgp0+gY3URHoiq/
 W0vWC7+KKqpHh78hLxylcYiOBmPknHgr/W9c/9L0TvG3/HZyoboFoPPTcoIL4hyhKoL72j
 G2ZYGHQlYCVSGmTR9MHtLKMkBhh/IZnYGhqtqDqSH1seF56tZ6zOHrNUeHQSCGSTuJRq+O
 TNIJGCsbcxoKNgc3+0S21Wb4YCiuv09vBHC9hqKvj82MGbEBGCIFnjXYUeiDEwoBNMn78L
 ndJBkw5H1DFCuYOog7IFDAUUw+BtonH+97CPvaKxG6LCDo9lssK/SvHvMRkhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1776606859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Csml1EOqJN5PhipgtBm6nuoTv7jjz7hG3T7L5Gwu8w0=;
 b=IMZDsJvC8tV4NYDnJCLzgv1AW+UBgCH+0KJxB0we2QB28bHeHDZxSwpCU2H4UK5UYGLCZY
 6r7YPnmzkVB3W9nh2d/Ni/LM18JCs51DQ7H6TX2nI+JsMIqkJ4TV+/YTyFbrpshoKwUOAO
 Sq5draIgadHosqxD5PZxu+9dCqU9VjjsaHy3IHWw1wC94XYIZZljEHJyaj3N0kpBdRH/ix
 1s/ihVo+ww/0Gvjq3b9JhdQQ6ytrjrWp4qgBUZZAEb82orNI8e2DWhBDcZXpNO/6nfDMhF
 tAv+PA3T+dqsq4WphVCDj2nhJ+HYEAmWmGnSzoTGWgR+4i0SDotPVYBNHcFBfw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776606859;
 b=OtB5ayHJltju//FJanVf2Y1mrZ1q5Dy13HndJm9/IbjIHQafFRfbxtVJ3fG5o+GauvtPdk
 ZuPA/vx/j5xX8KPPzb+bVepH1XLUoyCPCfYe2XaTyl2BYN9lV80fh2L4fjMaWoK5i7n9vw
 fP+MeC8NMU5k2uuMA6JOsqIMH+QCZyD/59ExgVSalNmA6grqKd+KH4OFewSP1OHRmvaz+A
 qaxom0HzLLZspNaLuLW1fy3bkAGUnqyBQjqp3E/xMtCo4NADvMg72lXXTiRcSI3Wj4Ot6H
 +eVhn2rlU+rQ2SjZBU9L/JnjuQ+BHQj6pxHRN9+rp7UcuMszwpR9WWXcKehTxQ==
Date: Sun, 19 Apr 2026 16:54:17 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <aeTeiZER1IJar_w6@kehys.lan>
References: <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
 <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
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

Hi Robert,

Sat, Apr 18, 2026 at 12:53:59PM -0500, Robert Nelson wrote:
>Please don't upgrade to the 12.x.y.z0 branch of ti-linux-firmware
>
>After this commit you can't even upgrade to `v11.02.09` without other changes!
>
>https://github.com/u-boot/u-boot/commit/7403d26bea36315f2008ed3ef80125b094c0bafb

I downgraded to firmware 11.2.5 "Fancy Rat", but that didn't allow me to 
see any further messages.

>I'm pretty sure OpTee 4.10.0 is safe, but otherwise this is my current
>stable branch:
>
>https://github.com/beagleboard/u-boot-pocketbeagle2/blob/main/version.sh

I tried to choose the same versions: OPTEE 4.9.0, TI-firmware 11.02.11 
(strangely, also this one identifies as 11.2.5; I should always build 
everything from the scratch), and TrustedFirmware-A v2.14.0 a.k.a.  
lts-v2.14.0, because I did not find any tag for v2.14.1. The U-boot fork 
that I'm trying to build is already the same one. The boot process would 
seem to always hang at the same spot: before switching to the 64-bit 
u-boot.

>i've been away hacking on other projects so i haven't been back yet to 
>do my 'stable v2026.04' rebase yet, on Play, AI64, BeagleY-AI, and 
>PocketBeagle 2 yet..

I'm looking forward to your update.

	Marko
