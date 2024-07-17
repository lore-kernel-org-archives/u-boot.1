Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7452C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5003588636;
	Wed, 17 Jul 2024 16:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ftOxV13U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5917088766; Wed, 17 Jul 2024 16:22:27 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66F388126
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id CC1B62014A;
 Wed, 17 Jul 2024 16:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1721226144;
 bh=6aFmVUdtr+jn1/DxaSjc1sqMfne8BnC1t++YFoXCkOc=; h=From:To:Subject;
 b=ftOxV13UC3nqWywGkuiO0SxWu7o3QARpDkHMcWn7CxIQC9XT9kRY2rM9Flq0HmcSN
 8/O5hTVzF5D2MFjKwXSZjTnDQi4neiiTcywbrZ/n3bsrI7sJbEF/LypGYMPXRkI5jG
 ErBqes2xLcFMg4QA7BgzedDsEoQPrGGPxm+j/ADSJvOZGQsd6NH840vq0MoMFhppGe
 H7Re7FfbD9sJoh6iU4h72vL7Ap3RJpnknHAjtpBvPHDw0AZyDDHPUk9CeqaQLoCUJT
 ad/Pt5+YYgzjPqkh1zH2fZeShZhONrmZRKeQwVZu4xBeLKmc9Yt95wyBvO8kxEduHB
 MU21MvZeuZ4mg==
Date: Wed, 17 Jul 2024 16:22:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, trini@konsulko.com,
 u-boot@lists.denx.de, j-humphreys@ti.com,
 marcel.ziswiler@toradex.com, vigneshr@ti.com, b-padhi@ti.com
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
Message-ID: <20240717142219.GA48065@francesco-nb>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
 <20240716200555.GC85916@francesco-nb>
 <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
 <20240717140913.ljhoqn2thiuv2jkf@resemble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717140913.ljhoqn2thiuv2jkf@resemble>
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

On Wed, Jul 17, 2024 at 09:09:13AM -0500, Nishanth Menon wrote:
> On 09:40-20240717, Kumar, Udit wrote:
> > On 7/17/2024 1:35 AM, Francesco Dolcini wrote:
> > > On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
> > > > Increase malloc size to 32 MB to align with other J7
> > > > family devices.
> > > Is this needed for any specific reason? I am asking to understand if
> > > other boards using the same SOC should be updated to prevent
> > > $random_issue.
> > 
> > In our downstream version, we are seeing an issue , while using DFU to MMC
> > 
> > Please see
> > 
> > https://gist.github.com/uditkumarti/b8209f61eff3154f6eb288ba63715263#file-gistfile1-txt-L82
> > 
> > 
> > 
> > Since DFU is not supported yet in mainline u-boot, so I avoided to mention
> > that failure.
> > 
> > Also this change is generic, so i thought of pushing it now instead of
> > waiting for DFU series.
> 
> if we are going to repeat this over and over - does it make sense to
> have this in include? so that *other* board manufacturers do not need to
> re-discover this?

The reason we (our board) might be fine, is that we have

default 0x2000000 if ARCH_ROCKCHIP || ARCH_OMAP2PLUS || ARCH_MESON || ARCH_K3

from the downstream TI branch (the specific board we have with J784S4 is
not in mainline yet).

Francesco

