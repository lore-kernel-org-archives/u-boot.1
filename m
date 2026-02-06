Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005A6EB28D6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5DE8382A;
	Fri,  6 Feb 2026 09:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="UtbKGt6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A866E83AA9; Fri,  6 Feb 2026 09:35:55 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B476836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8380F1FE3B;
 Fri,  6 Feb 2026 09:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770366952;
 bh=7adWTG0Zui5OjjktL5N32zOlabHqT8WgBo1hl3eyXwo=; h=From:To:Subject;
 b=UtbKGt6JVgSCq6n9ka6XsLG7rD9Bq79EUgELM/iQ936qKc9u15WqYNIgQ/DyWoTau
 SSRaNCzeofzGjO7gNNIX96RIxS3E689nQ7x+Zu9pQjXwpKZLD84gOg5UlTPXmJNa60
 YoIDAqlc8OXEDpPlSAwQBUcuagPXY8+RKVqT0bG6tTQMCb3aDlA6KNrsex0B9StcQT
 IQNeKmgsYFdSXc3j0WorSXneIvgqjAyZswvvCXZmguC4QBYK/ozZv2kOOuuE0UlHRv
 symo1IzvUOrP0xYVnajsG1ECial5GbDU2/QFSiGFqZcZc6M3Yq42OoVHo23/eQ2xjl
 j+k1H81qSq4pw==
Date: Fri, 6 Feb 2026 09:35:48 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Message-ID: <20260206083548.GA17806@francesco-nb>
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
 <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
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

Hello Peng,

On Fri, Feb 06, 2026 at 12:25:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Rely on serial driver calling clk_enable to enable the lpuart clk, no
> need to do init_uart_clk in board_early_init_f().

It seems we copied the same mistake from your evk on our board,
see board/toradex/smarc-imx95/smarc-imx95.c:board_early_init_f(). Maybe
you can just fix also that one.

And I see init_uart_clk() called in a multiple imx8m board in U-Boot,
any comment on those?

Francesco

