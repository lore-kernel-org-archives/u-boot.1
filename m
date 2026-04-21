Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433E6F8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4AC83FFA;
	Tue, 21 Apr 2026 17:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="pQK+h8DG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C84840A9; Tue, 21 Apr 2026 17:41:12 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E8083C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-33-72-241.ip43.fastwebnet.it [93.33.72.241])
 by mail11.truemail.it (Postfix) with ESMTPA id 1DA4A1F94E;
 Tue, 21 Apr 2026 17:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1776786069;
 bh=BXq/RK5NZy2FYL/j362FcfnmJ5g2YFPp7HilE9Pa1/c=; h=From:To:Subject;
 b=pQK+h8DG4aHR+QXau0xdA8oaCzhP8Cr5ayBmWEYCFXfKKFZt1SRBGlojjr55QEJj+
 ZBFAh5ryn1XqiBNUvjnglLYl0Qxuj6nEoeEPRT+cpcj7cI32P8/TbIYlfkWI4gq1pq
 Cu6tTOjS12brauoLemB0MLVk9XYbUGPkNzrXeJDfmjFAVoKlB/pObOzsNbLXeckmcR
 5wLZWnI7BJMeY0SWBpjS626AjAaTWOZLGwDQhjawEqJj2kRJirBx/sW6FXz4Ytdcc2
 Qu6sPzKjQgLXO+SkMSK+g6sQdTgx36iiYq8D5V6I1kHKQZ14/OdGUdV2GQSdKCPXBg
 v5afxpnDrAyBQ==
Date: Tue, 21 Apr 2026 17:41:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] board: toradex: aquila-am69: Fix 16GB dual-rank
 DDR cfg and memory size detection
Message-ID: <20260421154101.GA94432@francesco-nb>
References: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
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

On Tue, Apr 21, 2026 at 05:15:54PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This patch series:
>  - fix an oversight in 16GB dual-rank DDR configuration 
>  - fix the memory size setup logic

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

