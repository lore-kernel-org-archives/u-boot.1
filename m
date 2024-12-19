Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18572E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCA38021D;
	Thu, 19 Dec 2024 16:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="doiroOZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFCD8022B; Thu, 19 Dec 2024 16:26:02 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D118021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4DD641FB66;
 Thu, 19 Dec 2024 16:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1734621959;
 bh=S6hg8GqyxKrbxEWos/BLsq3E5dmd7HJLP630b4fWUuE=; h=From:To:Subject;
 b=doiroOZbT2tEAenM3HhMgRCROz6Hyo2GRl7TRZ0UBYwVIs1FBPxIxZACXomRQPAu+
 uXBR+hiVqVCSYyQOvg1t2GanEnaGssrpfNSCzQxFBnCSkboxZKGUwzUMLR9taP+bjd
 osds/VMK5pEq+wwjMTXHI5kiazuuie/OIkwgpqRy1wAetSkhRtCxlghSSug+IfdH1x
 GQtsORTlYlmyldDg7PteOfwI4O8poMt0u7NUs4o3Jwpx0xFAIIL5JhIydQBZkKYZty
 GtQe91BhgqKDSAOPPHJi3d7ayFpeWEvrOQL2elQk4CjLF2msGj6cHbI34hyJ4ES3/n
 LFy934COQlSdg==
Date: Thu, 19 Dec 2024 16:25:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
Message-ID: <20241219152555.GA27386@francesco-nb>
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
 <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
 <20241217235411.GV1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217235411.GV1505244@bill-the-cat>
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

On Tue, Dec 17, 2024 at 05:54:11PM -0600, Tom Rini wrote:
> IIRC Toradex does weekly builds of top of tree, via OpenEmbedded / Yocto
> so there's not some bitrot here to be fixed, just smoothing out
> integration.

Correct, we do weekly builds from OE integrating the u-boot master tip
and run those on all of our modules.

We catch U-Boot regressions that prevents either the build or booting
our Linux OS (not much more than that, at the moment).

This https://lore.kernel.org/all/20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com/
is the last one we reported and helped debugging, and thanks to the help
of various people we have a fix patch pending https://lore.kernel.org/all/20241218090007.692815-1-ilias.apalodimas@linaro.org/.

Francesco

