Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0871F3C982
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2321383981;
	Tue, 24 Feb 2026 15:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d2/2kLPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F8383D17; Tue, 24 Feb 2026 15:38:12 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E374A82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 456A81F93A;
 Tue, 24 Feb 2026 15:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1771943888;
 bh=t2/nucmcOR5OoPIPsocNyja7sBjCOs8sYUOkv7Z9BR8=; h=From:To:Subject;
 b=d2/2kLPPXXdWNWwl3vNOucyJ9cxGZazAAQySk4ssigaBtGAe/Txd939nHanmpeAxE
 rp8sw4C2+UbcNgLkyLEd+Z+qMgn95LmI3nWF2l40VtE6yi/nVsKVllNsitbdjMpw8q
 WWFTTVZe1e2mGJrAzPOOsgiXAuQUZDS1ZR6EpvCIP7rWEnVlTxvZ8VhegZKUEG9Z3b
 XCEdskVXcPwLIB8OLhUUS8jHZveExiXSRsiz2XpTPK3m7INJWQq7pd5n+QqultWr6h
 ffzFU0frhS3n4fwvUa8h94gxtcCknU/9Zi9tvZLl+0HMowH4wUh3UFSck7kmVnFG3J
 UQAUscYmdkLEA==
Date: Tue, 24 Feb 2026 15:38:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, trini@konsulko.com
Cc: Suhaas Joshi <s-joshi@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260224143806.GC340942@francesco-nb>
References: <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
 <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
 <20260219193044.GA203975@francesco-nb>
 <20260220010527.mpji63idcn7vj74w@bryanbrattlof.com>
 <20260220104621.GA15099@francesco-nb>
 <20260220132342.did3zsxh63tlw3hd@bryanbrattlof.com>
 <20260223155816.GA172267@francesco-nb>
 <20260224102121.GB340942@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224102121.GB340942@francesco-nb>
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

On Tue, Feb 24, 2026 at 11:21:23AM +0100, Francesco Dolcini wrote:
> On Mon, Feb 23, 2026 at 04:58:21PM +0100, Francesco Dolcini wrote:
> > On Fri, Feb 20, 2026 at 07:23:42AM -0600, Bryan Brattlof wrote:
> > > On February 20, 2026 thus sayeth Francesco Dolcini:
> > 
> > I was not able to verify this yet, but it seems that since commit
> > ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from end of
> > the RAM") the ram top is overwritten and our
> > verdin-am62.c:board_get_usable_ram_top() is ignored :-(
> > 
> > So, the change from devarsh broke it, but before the addition of the
> > memory firewall the memory corruption was not leading to a crash ...
> 
> I can confirm that the issue is around the board_init_f() that is
> overridden on the k3 architecture and spl_enable_cache(). It messes up
> with gd->*ram* variables ignoring various config options, including
> verdin-am62.c:board_get_usable_ram_top(). Any comment on this?
> 
> Trying to get out of this regression, one solution would be to move the
> whole memory map as it was done on the pocket beagle2, as it was
> suggested a few email ago.
> 
> Or fix the spl_enable_cache() implementation.
> 
> Bryan, and TI folks, what's your suggestion on the next steps here?
> 
> In addition to that, no matter if I do a quick and dirty hack on
> spl_enable_cache(), or if I move the optee at the beginning of the ram,
> I get this error once every few resets
> 
> ```
> ...
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure.
> This will fail on Security Enforcing(HS-SE) devices
> ```
> 
> and after that a freeze. I am starting to think that this is another,
> unrelated issue.

Yes, I can confirm that this is another, but related issue :-/

There is a memory corruption, something not ok in get_ram_size(), cache
related, that is leading to a memory corruption and therefore these
random crashes.

For some reason the memory corruption is happening calling dram_init()
twice and with 512MB module and with commit cb41b7c83444 ("board:
toradex: Make A53 get RAM size from DT in K3 boards"), I did debug this
with plain v2026.01 + cb41b7c83444.

This https://lore.kernel.org/all/20250314100734.23777-1-eichest@gmail.com/
solves the issue, but it was not applied when it was first sent months
ago.

Tom: you were the one with some concern, from my point of view we
should just apply it, any concern?

On the other topic I am waiting for TI advise if they plan to fix
spl_enable_cache() or I would need to work on revising the memory map
for the various firmwares + U-Boot.

Francesco

