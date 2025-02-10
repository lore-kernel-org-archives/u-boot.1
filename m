Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01362C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64802805C2;
	Mon, 10 Feb 2025 14:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KLAbIcw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B746E809A4; Mon, 10 Feb 2025 14:45:57 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2CE804CF
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 6F5511F91A;
 Mon, 10 Feb 2025 14:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1739195154;
 bh=537jnh2fHyL9NLAKIvpdVzvgH/NmgAJehXQakqM1apg=; h=From:To:Subject;
 b=KLAbIcw2VTD6UvtvyA6NDjl1qXynq04IkW2NVuZIf5PqYqcDPXgI6X5rmj31a3CyB
 LpfWACkIZ7PuC7npDzGd/VBFhyvm5bCNRhXVpAey5/OMeTZ8oaaL/y+TAqBlQix1/v
 Hb+gv5fHdb3oqP/5XRQnA+MM2/KIhO5MDXdg620ZyO8r1PZRNY9eNXNmu59yiqaw4u
 WoewoDrjQONlQS3ExXETZ8Ek0HGaB6AaZPZKrZptIsfb8Fh3vMSMAVPl4F+mfvJyq8
 jdN4FXMPbAILfJmzz/d5JvgvhqUb17JoZTpu91zh84HesBJ3gVL0u9245JZ0IS1TPo
 LQOL6M0I/2I1w==
Date: Mon, 10 Feb 2025 14:45:50 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com, s-k6@ti.com,
 w.egorov@phytec.de, n-francis@ti.com, u-boot@lists.denx.de,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] board: verdin-am62: add dram_init_banksize
Message-ID: <20250210134550.GA61512@francesco-nb>
References: <20250210072834.9135-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210072834.9135-1-eichest@gmail.com>
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

On Mon, Feb 10, 2025 at 08:27:47AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add the dram_init_banksize function to the board file to properly set
> DRAM memory sizes during boot.
> 
> The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> common location and Fixup DDR size when ECC is enabled") relocated the
> dram_init_banksize function from architecture specific initialization to
> the TI board initialization code. As a result, boards relying on the
> previous setup now require this function to be defined within their
> board file to handle DRAM sizing correctly.
> 
> Without this function defined the following error appears during boot:
>     ERROR: Failed to allocate 0x1000 bytes below 0x0.
> 
> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

