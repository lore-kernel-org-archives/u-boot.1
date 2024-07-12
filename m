Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCEC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 18:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEBB88763;
	Fri, 12 Jul 2024 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vJDQELW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89B188786; Fri, 12 Jul 2024 20:11:14 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08028870D
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 20:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E0296CE09CD;
 Fri, 12 Jul 2024 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E292FC4AF07;
 Fri, 12 Jul 2024 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720807869;
 bh=fmrpo/vsLV5V4+rLu0z2+mjO6AJexsXfw8O7g9/ET4I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vJDQELW3nFtyzDyqa0bInk3GxyW5JQP/8d37eZve4tWNoZTnXRDFwF3K/e+IxbRmk
 Gb8Ex50AMUZ5tZuOYSGFeSo3pZdnsly81DqqaJ8cOcfM9214VNZS00XtkTc/1iSpdb
 rGfdkBXrLTHffo76xclKGfCNpsSxJ1aUL06VWem5ThCcS4GcUNBiJC7Ok7Z7WMAOzQ
 IZDkwFwoIEWV0IiEu0tKYweRLSslovUpwBilsUv+ho5MTAez2dyHLZ4WBGmOvbcCKc
 27tLUSp/Pya/BVPeJXRK3FlmP5Bs7hYMuE8oBGhI+zO3L/mQnPvKzWDRC1qJKKEqKd
 fVrAV+JfxpXRw==
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 20:11:05 +0200
From: Michael Walle <mwalle@kernel.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] spi: sunxi: Improve the loading speed
In-Reply-To: <CALeDE9P05YN092mYQ15Kha+1sd6Yp97qkk-ODMyXASB2Ae_SVQ@mail.gmail.com>
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <CALeDE9P05YN092mYQ15Kha+1sd6Yp97qkk-ODMyXASB2Ae_SVQ@mail.gmail.com>
Message-ID: <2a736c4e1191d61953a74fa9e3776388@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

>> Right now, the maximal transfer speed from an SPI flash on a V3s is
>> about 240kb/s. That is pretty slow. It turns out, that due to an
>> error u-boot is setting the maximum frequency to 1MHz. By fixing
>> that another bug is unearthed: one cannot set a clock divider of 1:1
>> due to the handling between CDR1 and CDR2 handling. By fixing that
>> I achieved loading speeds of about 1.5MB/s.
> 
> Minor nit, should the clock fix go first so there's not a regression
> if someone needs to do a bisect on the first commit?

Sure can do for the next version.

-michael
