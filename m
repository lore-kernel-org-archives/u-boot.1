Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2327C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 09:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C98801DE;
	Wed, 19 Feb 2025 10:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="xark0BkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD9F809A4; Wed, 19 Feb 2025 10:25:55 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57B1800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 10:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id A64281F9C3;
 Wed, 19 Feb 2025 10:25:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1739957152;
 bh=dfkrpXavBKG25aWS7rMsALbO7Rvwk2fvyaeqa2mjpX4=; h=From:To:Subject;
 b=xark0BkPZHV+QAN5qnzbNGIK3PL0Hco1/gn5TohTtefsEpBdTM3jWWO0XcjWzqmgr
 ulUmqLZrUSrqm41RDdVrSnDHwvM0d4X+bzOgu/zD5opaJDa6lMkWmGgpy8iUS3oFhg
 zicY/npfer/kRYX2JdWm5DV/WCJutyQ4Vc3KzjVzOQMBQFmaLZ5U//LEJqTNc5WiCp
 V3bSktD1Coz5j+P+x+REwqP6zDbAgbX3g62g87VuUIVs5G0yxGW+ADWqqvL/vaCZxG
 vNGn9SbzHmvdTloCk9FVhOHFxWyYz8G4wih7i4SBkvVV1NaRpObw9NHcARc6g2/tnf
 vUx58Zds75EhA==
Date: Wed, 19 Feb 2025 10:25:46 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: francesco.dolcini@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, Stefan Eichenberger <eichest@gmail.com>,
 u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] board: verdin-am62: add dram_init_banksize
Message-ID: <20250219092546.GA16446@francesco-nb>
References: <20250210072834.9135-1-eichest@gmail.com>
 <173993068966.1662848.15295577849807842145.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173993068966.1662848.15295577849807842145.b4-ty@konsulko.com>
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

On Tue, Feb 18, 2025 at 08:04:49PM -0600, Tom Rini wrote:
> On Mon, 10 Feb 2025 08:27:47 +0100, Stefan Eichenberger wrote:
> 
> > Add the dram_init_banksize function to the board file to properly set
> > DRAM memory sizes during boot.
> > 
> > The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> > common location and Fixup DDR size when ECC is enabled") relocated the
> > dram_init_banksize function from architecture specific initialization to
> > the TI board initialization code. As a result, boards relying on the
> > previous setup now require this function to be defined within their
> > board file to handle DRAM sizing correctly.
> > 
> > [...]
> 
> Applied to u-boot/next, thanks!

This fix is needed in master, without it verdin-am62 is not booting at
all, can you pick it also in master?

We should have been more explicit on this, next time we'll do better.

Thanks,
Francesco

