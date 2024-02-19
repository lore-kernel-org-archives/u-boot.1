Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E1DC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 17:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446CC87F2C;
	Mon, 19 Feb 2024 18:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="mJqmwJOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525C887F3F; Mon, 19 Feb 2024 18:26:53 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F163887F1C
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 22AF420A86;
 Mon, 19 Feb 2024 18:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708363600;
 bh=5WNyvZVut/SA7gFdaGqAIxluesGmH0xKXl3P3J4n5vU=; h=From:To:Subject;
 b=mJqmwJOWpN6apfKUHJoQI0HIXr4ODZyMecquUtv6FJzrv1cciVyBJdRurLDiEv27D
 iwSV3GdPnvF2LFDKj/0jemc9U9UZEnkQwhxGamu4/LG8xtSxSe3Ki4ZBcU8IiUuMDG
 EA4IaPo8nqbmlIp/EJgAAuFwjwhNJMkfa26RowwhT1n/FLIPT7Orw7hIMEjLEInfEQ
 f7k51Syjx5HKBvaszw2PZ76Ao9wEUnldRWC2ycKDyAtrDBKyl4A4vf+t+E19/zXskD
 +ykWkPAKZ0lu53NA+/x+DtpwbQ108gFvlEiM8KgcvBSYaXTJSy3JPvy3GwI5vuTE3h
 mjQuClvnP0nAA==
Date: Mon, 19 Feb 2024 18:26:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, u-boot@lists.denx.de,
 Vitor Soares <vitor.soares@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 1000MHz
Message-ID: <20240219172635.GA12616@francesco-nb>
References: <20240219123408.22054-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219123408.22054-1-ivitro@gmail.com>
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

On Mon, Feb 19, 2024 at 12:34:08PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The same U-Boot binary is compatible with multiple Verdin AM62 board
> variants. However, some of the SoC models can only operate at a maximum
> speed of 1 GHz.
> 
> Previously, the boards with lower-speed grades were running at
> overclocked speeds, leading to kernel complaints about unsupported
> configurations.
> 
> To resolve this issue, the operating speed has been decreased to the
> maximum allowable value across all Verdin AM62 board variants. As a
> result, there is a regression in overall boot time, increasing by around
> 200 milliseconds for the faster SoC variant.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

