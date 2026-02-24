Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF5F3C991
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873F882BF2;
	Tue, 24 Feb 2026 16:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="tSa3MGd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203B383642; Tue, 24 Feb 2026 16:26:00 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF3580050
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id A322D1F96B;
 Tue, 24 Feb 2026 16:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1771946757;
 bh=Hy8uBKWfmw7DbMwoNVVxxlylvrpp3YLesEb2lGvg/dQ=; h=From:To:Subject;
 b=tSa3MGd7fklK1a50mUS0dN45BRvUc6VBAUTlMT9CLzothyulyqEslEGPAc9zgauJG
 6HRWI3QYdPiUqKKSTe3FzlXnD86ogUPkTLAg73Dhb/BcEjlVhucNW8G183KNVu3V3H
 PsWqusM/ZEF/abNFG+RDgTGbn7Cc9Zk9015wG6N6YzfD4O0RuNM8iN4Wfv0Q5KgTvF
 /eEf2Q72evS/ZjWUJ5RPbt1D7OxWqIEbX6WfIT3RnxSPqMEp59XIO2PQLsC0pkmXrP
 hvvqpjDtbQds6zR1iceqyv04iYSk//w93C85ZrBqo0NPlAxBFTY5E1stV1ead6F5XY
 tNo+f6sWtyqyg==
Date: Tue, 24 Feb 2026 16:25:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 praneeth@ti.com, francesco@dolcini.it, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com, bb@ti.com, anshuld@ti.com,
 vigneshr@ti.com, n-francis@ti.com, s-joshi@ti.com,
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 s-jain1@ti.com, r-donadkar@ti.com, sen@ti.com
Subject: Re: [PATCH] arm: mach-k3: common: Clamp RAM end address to
 board-usable region in spl_enable_cache()
Message-ID: <20260224152555.GE340942@francesco-nb>
References: <20260224134557.2067046-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224134557.2067046-1-devarsht@ti.com>
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

On Tue, Feb 24, 2026 at 07:15:57PM +0530, Devarsh Thakkar wrote:
> commit ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from
> end of the RAM") switched spl_enable_cache() to use gd->ram_top directly
> but omitted the board_get_usable_ram_top() call that limits RAM
> configuration and provides updated RAM end address per memory map
> used by board and impacts subsequent allocations and reservations.
> For e.g. here it impacts how high the TLB may be placed.
> 
> On Verdin AM62 (512 MiB), the raw end of RAM (0xA0000000) is inside
> OP-TEE's region. board_get_usable_ram_top() in verdin-am62.c returns
> 0x9C000000 to keep relocations below it, but spl_enable_cache() never
> called it. commit 42b3ee7fa524 ("arm: mach-k3: am62x: Enable memory
> firewall support") then enforced the OP-TEE firewall, turning the silent
> corruption into a hard hang.
> 
> Fix by calling board_get_usable_ram_top() after computing raw ram_top,
> consistent with setup_dest_addr() in board_f.c. A weak default is
> provided for boards that do not need to restrict the RAM top.
> 
> Fixes: ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from end of the RAM")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Link: https://lore.kernel.org/all/20260224102121.GB340942@francesco-nb/
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

Thanks Devarsh,

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62 512MB

