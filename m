Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D09C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49FC8007D;
	Tue,  6 May 2025 09:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="aKbyD5CP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF69C800C1; Tue,  6 May 2025 09:18:50 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24EF80050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id B315A1F8F8;
 Tue,  6 May 2025 09:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1746515927;
 bh=away2QK/P1zCDPLI37GYdYhO9YNov7pV7ZAHK5iRQhQ=; h=From:To:Subject;
 b=aKbyD5CPK9/GYwxKAlGiH0oP2CpknUorJQskM2RCi0LrAUSsHL8Y3zTF+sMOPCnnj
 /lDzqKxEJUxPcFwgRcbTb4NJ1naP9afdQLihdWDrlAMRAChSSW967/FjEhMnpN7jsQ
 MtSfFLN2TvTNy5j2QgxOVd8VY5bM7EhzHFc61bHu+9YdvKAB1A0MJnyH+ehSaf3Uhl
 o9llpJLoQ3oJpI+/eMUzd60vK4ir71c0Yp46Thftar2bPFgLyUOjjZrq0Q6AIHVbSz
 2B+IfiOAGOzFB/7GQM8sghZXSaksTr6YWiWEXt7YPrtXeMHgD25cvL8lkht+WTm6FR
 iTEtig1MqW3BQ==
Date: Tue, 6 May 2025 09:18:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: verdin-am62: Drop unused or redundant config
 options
Message-ID: <20250506071843.GA11423@francesco-nb>
References: <20250506070907.1267279-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506070907.1267279-1-ghidoliemanuele@gmail.com>
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

On Tue, May 06, 2025 at 09:08:59AM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Several Kconfig options are enabled but unused or unnecessary for our
> use case. These include features such as SPL FAT support, YMODEM, and
> USB keyboard. Some R5-specific configurations are not used at all,
> as U-Boot proper is not executed on that core.
> 
> Cleaning them up helps reduce build size and simplifies maintenance.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

