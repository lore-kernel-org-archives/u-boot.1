Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85FBC88E41
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182FE8408D;
	Tue, 27 Jan 2026 15:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Y7H3dt5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD30F8407B; Tue, 27 Jan 2026 15:52:37 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A070C8405E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 15:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 2539422BCD;
 Tue, 27 Jan 2026 15:52:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1769525554;
 bh=q2qTQRdyeMIfZpkVmQLlU9vSHTYoahu0+m+96PsvmtA=; h=From:To:Subject;
 b=Y7H3dt5SZXF8khqa6kRzPhbZ+TgyqoUZ3BrzRiDgFjLlsZSYCuj4mHqFXddSxGPtz
 M52Q5pRZTCeoNZBA+/hRkpVUnu8KCM9VvO8QE5pUKfX6ICQt0sCyWMCh65lkQRDeiv
 OCIm0vK7aAcuKKxZM42HthwNiiAiQnMOJzl9nPhFQlItfavTzII/8qjSxZe9azhdvC
 DVFGgr7uQBmv6O5/3MIUj8a4aOwD5uyfZHk9XwXNAPklJBwxdGYEDps/FO3DMeNi0h
 SVKe/iIRrVbEiqlEEFrgr0GCgnpp0K53/+oz7NfkcKQS27QUtm5Wke2RtQNWyFNH5I
 +0eDSHHBRhpaQ==
Date: Tue, 27 Jan 2026 15:52:23 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] toradex: aquila-am69: fix SPL USB DFU, drop
 obsolete clock
Message-ID: <20260127145223.GA63483@francesco-nb>
References: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
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

On Tue, Jan 27, 2026 at 11:14:10AM +0100, Ernest Van Hoecke wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> This is a small, board-specific series for Aquila AM69.
> 
> Patch 1 fixes intermittent SPL USB DFU gadget enumeration.
> Patch 2 drops a stale MCU_CLKOUT0 enable for ETH_1. V1.1 hardware uses
> an external 25 MHz crystal, and support for earlier revisions was
> already removed from the DT before upstreaming.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

