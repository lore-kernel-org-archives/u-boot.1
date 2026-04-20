Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650AAF557E6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA02842D2;
	Mon, 20 Apr 2026 10:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="jQQTq2S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8360A842E0; Mon, 20 Apr 2026 10:50:23 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFFA842B7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 1D0D51F951;
 Mon, 20 Apr 2026 10:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1776675020;
 bh=ZL1HvcUy/MlgeMJhI+efhxBSDqBz7QZb7v8EpHkePtc=; h=From:To:Subject;
 b=jQQTq2S60KLvKtcb44WTFLARMnmY1KOHumbqbdrrI9+5+2UKknqvpbl5ZVX6LAtIo
 juDajXnForE7ZEt9BVLfSXX48ouw/ziGTjfeWlJCbzkp9GN28fW/refwrtPCNwq15b
 DSvuz/H50phh2T1f7l140/vd4LZOiy71c2S/B0elDJHS1OBde2k3GyQv9agrM5+y5Q
 yCt458poqath+zcFgimCojuyaoEcxD3OoBJ8ucwR+YUdX/NcVabUehqy1cmLd82ZdI
 cR8GDiBcROpHDcQKdujyJO9j8uOEd9cptPaApzra9O9MhhwWM1hco6GezOFOIY3p84
 K0sinhB4wZuCw==
Date: Mon, 20 Apr 2026 10:50:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 openembedded-core@lists.openembedded.org, Paul Barker <paul@pbarker.dev>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <20260420085001.GA47182@francesco-nb>
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
 <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
 <aeXgdkBin5uz0-OH@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXgdkBin5uz0-OH@mt.com>
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

+ Paul Barker

Hello all,

On Mon, Apr 20, 2026 at 10:14:46AM +0200, Wojciech Dubowik wrote:
> On Thu, Apr 16, 2026 at 05:51:13PM +0200, Franz Schnyder wrote:
> > On Thu, Apr 09, 2026 at 09:47:07AM +0200, Wojciech Dubowik wrote:
> > > Some distros are using gnutls library without pkcs11 support
> > > and linking of mkeficapsule will fail. Add disable pkcs11
> > > option with default set to no so distros can control this
> > > feature with config option.
> > Shouldn't it be the other way around? Use of pkcs11 should be disabled 
> > by default and enabled if required. As it is now, it would still depend
> > on the the gnutls library having pkcs11 support and therefore still 
> > would break our OE builds with mainline u-boot if we don't change our
> > modules defconfig.
> 
> As far as I understand, gnutls is built by default with pkcs11 support. So for
> most of the distribution it should be ok. Security by default.
> I don't have yn strong opinion for this but default enabled has been suggested
> by the maintainer.

We are in the very unfortunate situation in which we are not able to run
any test at the moment in our CI and automated test infrastructure (not
in U-Boot, not in OE), and the reason is that we have pcks11 enabled in
U-Boot, and OE core is not picking up the patch to enable it [1].

Any advise to have a way forward?

Francesco

[1] https://lore.kernel.org/all/20260408130553.819420-1-fra.schnyder@gmail.com/
