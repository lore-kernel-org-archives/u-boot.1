Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE6CF3C995
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93FA83642;
	Tue, 24 Feb 2026 16:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="rVLhGh8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFBF83981; Tue, 24 Feb 2026 16:24:12 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E8982BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id C48B91F901;
 Tue, 24 Feb 2026 16:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1771946647;
 bh=umP0Gv6A7VZzykA8OZ0Y/U9+joIOFjiKNPlrjHTFxtA=; h=From:To:Subject;
 b=rVLhGh8y+xveNd1tm0b/HWhRT98qEgG3xvnQRTKdsJjPp4XlhyZVby7VucLJ3LKC3
 HzWH+oc5fhx5UF8tO5tJ8WgcLWDiJQUBI5uWMBnbgttrkT7L/TljWTsyJjLPlgNAjN
 R9cYFNAmGM8Ue5k4U5W+YH3cIW5O/J3ojEr2cKYLGr8SbxOp4CNkcQpmqTIvt+KVVB
 kCXjtPNeyUw7DQMVqGpmEuNrUO7j13tvqRwogBwUlEIjkXUF1QDdD+UarIukBm8Qe6
 jaIsEdDGMDxdK5T9CukiDypwCCvKkYjGIG2WMPC2GZtyW8KQs+/UuzBr4oji0JylIp
 yF44yAEomNInw==
Date: Tue, 24 Feb 2026 16:24:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: trini@konsulko.com, Francesco Dolcini <francesco@dolcini.it>
Cc: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Suhaas Joshi <s-joshi@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com, n-francis@ti.com,
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 vishalm@ti.com, d.schultz@phytec.de, w.egorov@phytec.de,
 ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260224152405.GD340942@francesco-nb>
References: <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
 <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
 <20260219193044.GA203975@francesco-nb>
 <20260220010527.mpji63idcn7vj74w@bryanbrattlof.com>
 <20260220104621.GA15099@francesco-nb>
 <20260220132342.did3zsxh63tlw3hd@bryanbrattlof.com>
 <20260223155816.GA172267@francesco-nb>
 <20260224102121.GB340942@francesco-nb>
 <20260224143806.GC340942@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224143806.GC340942@francesco-nb>
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

Hello Tom,

On Tue, Feb 24, 2026 at 03:38:06PM +0100, Francesco Dolcini wrote:
> On Tue, Feb 24, 2026 at 11:21:23AM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 23, 2026 at 04:58:21PM +0100, Francesco Dolcini wrote:
> > > On Fri, Feb 20, 2026 at 07:23:42AM -0600, Bryan Brattlof wrote:
> > > > On February 20, 2026 thus sayeth Francesco Dolcini:
> > > 
> > > I was not able to verify this yet, but it seems that since commit
> > > ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from end of
> > > the RAM") the ram top is overwritten and our
> > > verdin-am62.c:board_get_usable_ram_top() is ignored :-(
> > > 
> > > So, the change from devarsh broke it, but before the addition of the
> > > memory firewall the memory corruption was not leading to a crash ...
> > 
> > I can confirm that the issue is around the board_init_f() that is
> > overridden on the k3 architecture and spl_enable_cache(). It messes up
> > with gd->*ram* variables ignoring various config options, including
> > verdin-am62.c:board_get_usable_ram_top(). Any comment on this?
> > 
> > Trying to get out of this regression, one solution would be to move the
> > whole memory map as it was done on the pocket beagle2, as it was
> > suggested a few email ago.
> > 
> > Or fix the spl_enable_cache() implementation.
> > 
> > Bryan, and TI folks, what's your suggestion on the next steps here?
> > 
> > In addition to that, no matter if I do a quick and dirty hack on
> > spl_enable_cache(), or if I move the optee at the beginning of the ram,
> > I get this error once every few resets
> > 
> > ```
> > ...
> > Authentication passed
> > Authentication passed
> > Loading Environment from nowhere... OK
> > init_env from device 9 not supported!
> > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure.
> > This will fail on Security Enforcing(HS-SE) devices
> > ```
> > 
> > and after that a freeze. I am starting to think that this is another,
> > unrelated issue.
> 
> Yes, I can confirm that this is another, but related issue :-/

...

> On the other topic I am waiting for TI advise if they plan to fix
> spl_enable_cache() or I would need to work on revising the memory map
> for the various firmwares + U-Boot.

current master +

https://lore.kernel.org/all/20260224134557.2067046-1-devarsht@ti.com/
https://lore.kernel.org/all/20250314100734.23777-1-eichest@gmail.com/

fixes the boot failure on Verdin AM62 512MB variants.

Tom: does this looks ok to you? It should solve this regression,
finally.

Francesco

