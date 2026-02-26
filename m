Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37976FCE084
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A4383D1A;
	Thu, 26 Feb 2026 14:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JdGkZtrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB50383D1A; Thu, 26 Feb 2026 14:47:42 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F1883642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 14:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id BB11B1FBF7;
 Thu, 26 Feb 2026 14:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772113660;
 bh=uedQH1EOUNGdtayStZ2nfCFJ4P3aCysZvPe/mVrXanw=; h=From:To:Subject;
 b=JdGkZtrwAK3huDvQNSkqFmBUuPALiZfTqP0kXDx19QjwiS0T54jXueR8B8u5si6B3
 vRLqpPPnlPTGCxoJRLAcjQCZHg4woH1CsGfcUtsA07Hstl3Yj5Ftj4AxNE6R1K28p2
 EjCooGiz9kBF5Tl8+YetlSRegpMKpNBGhchVVADyHcesEYwciBbPpD6QyEOhwsM47N
 tob/TG5jSP01+i0KTG2ww8ZRNNFA/eCw/cg9xROe+fKFPROGMYIcoeBR+B209QZJz0
 74VV2RaFxX2LzyKT13tIAAh8tz5kRsobdhltEwdvSKaVcOs8FavvVTN6evmDdB4tu0
 3Dvul9tRw56PA==
Date: Thu, 26 Feb 2026 14:47:36 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1] configs: toradex-smarc-imx95: Enable remoteproc
Message-ID: <20260226134736.GA11208@francesco-nb>
References: <20260226092956.1098548-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226092956.1098548-1-ghidoliemanuele@gmail.com>
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

On Thu, Feb 26, 2026 at 10:29:53AM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Enable the remoteproc command, i.MX remoteproc driver, System
> Manager SCMI CPU and LMM support to control the Cortex-M7.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>


