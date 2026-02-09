Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A299AE78D45
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 08:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D7183BC9;
	Mon,  9 Feb 2026 09:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="h69FaRFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8DC83BF4; Mon,  9 Feb 2026 09:45:36 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA40839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 09:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 23FD01FCC0;
 Mon,  9 Feb 2026 09:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770626733;
 bh=jme/jfoFu64sCW4VhNx6nCQMwwt2/zjNGZwiK+af8oI=; h=From:To:Subject;
 b=h69FaRFT/Lf0JhxgaOMNthJFSahBQaP16Hp39erUrN3zHXEisJ40J1STIJCgf6lYQ
 19aGvcsrBlTZ9ft/VFXGY/6se4qaKp/GNaRVDE5u0PBEiG7vIUPC1uo36xkSvEZm4R
 7vBIxLvS6zQwHiPUcGMSSIgLXFSML2GD5g58cNqkjTsqo2gERkNgPxPTmQg6WTf9Zb
 k4HPzZIXqIJwWi2FN+4RuANBZ7jGyDoJkSw7x9XhVSBaMpmqF8uNuzeH44LeBwoJ/B
 Z7Dsaxd2j1N8VuXKo55kytMFyUSSKdYVT9j8l1W+y5nwnKCVjCbGYLuWlzykqL/VDM
 sL5n7Bf6iQb/w==
Date: Mon, 9 Feb 2026 09:45:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Suhaas Joshi <s-joshi@ti.com>, trini@konsulko.com,
 vigneshr@ti.com, n-francis@ti.com, s-tripathi1@ti.com,
 k-malarvizhi@ti.com, kamlesh@ti.com, vishalm@ti.com,
 d.schultz@phytec.de, w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209084529.GA12200@francesco-nb>
References: <20260209083855.GA9367@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209083855.GA9367@francesco-nb>
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

+ Bryan, Anshul

On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
> everything was fine with b5213bbfdcb1.
> 
> Looking at the commits between the two revision, I would say that the
> issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/

We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
nodes to k3-*-r5.dtsi") that might be the root cause for this issue.


Francesco

