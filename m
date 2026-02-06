Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF10BEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD6A838FA;
	Fri,  6 Feb 2026 15:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JCxvW+Je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8E083AAD; Fri,  6 Feb 2026 15:22:48 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07FB836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 93C631FA94;
 Fri,  6 Feb 2026 15:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770387764;
 bh=jVK66ffe0QamFsR3PdotZ4boB/IOoBDgWxsFo0MU7Ck=; h=From:To:Subject;
 b=JCxvW+JeqHq1bQehCbOWxB6QBRcV1/AGgDWY5kjyXRqEfRzlRb+c+q6/DSC8PcEyI
 mavO+KEJone7ndU+04WFreXa3Hnzx3UdYLKjpx7WCh7MMv3bZew98gaAWq0gmbkQ0B
 3B6O6jdRIev64LM6cc6EGQ6RXCD6uj4veP6GzLCXUvu7vnwFbHgay+s3XNISoH0HyY
 q/k/FkAY5N3NEEhTY6/6HaVm7BRBC63KzziwpyixuDH4xqUgrQtTypTl2bk4PCMrgB
 rQSsBEICmhsMplu4kAKXLhL7ykqtbPxcw5WDN2BS37QaCkgE6w83/i2fkSNmSMM7Xl
 l/BbM9skWPcUQ==
Date: Fri, 6 Feb 2026 15:22:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] toradex: smarc-imx95: Drop init_uart_clk
Message-ID: <20260206142240.GA80787@francesco-nb>
References: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
 <20260206-imx9-board-clean-uart-v2-3-ebee8158586c@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-imx9-board-clean-uart-v2-3-ebee8158586c@nxp.com>
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
thanks for the patch.

On Fri, Feb 06, 2026 at 11:28:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Rely on serial driver calling clk_enable to enable the lpuart clk, no
> need to do init_uart_clk in board_early_init_f().
> 
> Also remove board_early_init_f(), because it is empty now.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

