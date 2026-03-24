Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F2E9A744
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03A580212;
	Tue, 24 Mar 2026 10:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="tVp60JMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF4D8352B; Tue, 24 Mar 2026 10:19:05 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7A180087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 0FA45275B6;
 Tue, 24 Mar 2026 10:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1774343942;
 bh=UrTXau5OXCKaUdGB9DQobgaqy4zD4VN5JVKUn1woZhU=; h=From:To:Subject;
 b=tVp60JMGIH5px58bPVuAEZgAtXnuTE1Nb7JDR01FUPsqn5KH7L8iyQNhkuWuBkXAt
 jDhlCl1Cxbh6z49mlDVlYmvkZ5lDuz5HeMrnNkdHVM7f9xtVOaRyi8J6xvff+DnHVg
 rKY8QxXVFxQA5cxSFeK92CGo9p4UmjZwLjy9sB/fz9QiFtWzBqyZLszOtolyyeCPus
 TQkQm66ZGFTz39OKNlsREUdmiV0erjGI4byupA3KOsfmBDgvo5bYGG6hnDwHhO4/E5
 hU2TfZyFxrLLnThR3OLcD8HewL2L+ujq7Y+ZRcXhnhB4wQoagRR5iEhiogi51ddVNb
 /UN+6ooCjhnXg==
Date: Tue, 24 Mar 2026 10:18:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 "matteo.lisi" <matteo.lisi@engicam.com>,
 Teresa Remmet <T.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>,
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>,
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: U-Boot and legacy SPL power control on modern platforms
Message-ID: <20260324091858.GA22537@francesco-nb>
References: <20260320214518.GD502704@bill-the-cat>
 <PAXPR04MB84595AE69ADF07A9F9FAB7B1884AA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84595AE69ADF07A9F9FAB7B1884AA@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On Sun, Mar 22, 2026 at 12:26:46PM +0000, Peng Fan (OSS) wrote:
> > SPL_POWER_LEGACY symbol. Can the maintainers please update these
> > to use DM_PMIC, DM_REGULATOR (and SPL variants) as needed so
> > that they use the modern architecture, or let me know what's missing
> > here? Thanks!
> 
> If board maintainers would work on the migration, that would be great.
> If not, I will give a check, but I not have the board to test.

Thanks Peng, I have seen the patch on Verdin and I'll test/review the code.

Francesco

