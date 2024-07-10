Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787A3C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 11:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2A8886B6;
	Wed, 10 Jul 2024 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="a+HB3P9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CFD9882F0; Wed, 10 Jul 2024 13:02:26 +0200 (CEST)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321D0886B6
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 13:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EiCMby0fHBRLzXkVON6DK+gnjm4mazyTzQ1zCvWbALo=; b=a+HB3P9hDjgwYJ4fvKlYVj/l0p
 Hva5/q7nHWMSOwTOmYmFqXo/BraYWBAssvoecIkWhM2tjrVZZmHB6OD4X1PZqAdasqiu43F9XLyqy
 BJNGCAANEdJJornmCbaBv8Rg+9rvwyqIQ3bO2n0VWLI1CMQ2b1NiSD+YyryvTbD9tNN2Kxj6tzMvL
 YCa82HzvHN86dA/1k9yt1sk2JtloC1CzAj/m354Dcr6ZpHsLLyMQwxNV+/0vr7mIfNYBwFVclFxwd
 rQGMUyhb1KgHkuCqds7eQBnNOuSJY6w/K+V0UR1XBjuZzss3nPU+HCLo2aMIAbk1Um5YHjtGV8mii
 yGZpRsFg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1sRV5a-000000004lU-2sAb;
 Wed, 10 Jul 2024 13:02:22 +0200
Date: Wed, 10 Jul 2024 13:02:22 +0200
From: Phil Sutter <phil@nwl.cc>
To: Stefan Roese <sr@denx.de>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3] arm: mvebu: Enable bootstd and other modernization
 for Synology DS414 (Armada XP) board
Message-ID: <Zo5qPkxGoz6hsbC-@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240708043904.5100-1-mibodhi@gmail.com>
 <1866ab7f-eee5-4ae9-b679-70f0d431499f@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1866ab7f-eee5-4ae9-b679-70f0d431499f@denx.de>
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

On Wed, Jul 10, 2024 at 08:26:12AM +0200, Stefan Roese wrote:
> On 7/8/24 06:39, Tony Dinh wrote:
> > - Switch to standard boot (in include/configs/ds414.h and
> > configs/ds414_defconfig)
> > - Implement board_late_init() to ensure successful enumeration
> > of USB3 devices
> > - Remove unnecessary checkboard()
> > - Updated IDENT_STRING to indicate this u-boot supports both Synology
> > DS414 and DS214+ boards
> > - Add SYS_THUMB_BUILD to reduce binary size
> > - Add NET_RANDOM_ETHADDR
> > - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> > 
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Acked-by: Phil Sutter <phil@nwl.cc>

> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> @Phil, is this ready to be merged from your point of view as well?

I still want to investigate legacy bootstd integration, but that's
follow-up work anyway.

Tony, thanks for your efforts and the good discussion so far!

Cheers, Phil
