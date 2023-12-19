Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B92C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DD186EA6;
	Tue, 19 Dec 2023 09:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF4787032; Tue, 19 Dec 2023 09:29:57 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC49886E82
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1C55E207C9;
 Tue, 19 Dec 2023 09:29:54 +0100 (CET)
Date: Tue, 19 Dec 2023 09:29:50 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: fix DDRSS configuration
Message-ID: <ZYFUfoeGyltimGqD@francesco-nb.int.toradex.com>
References: <20231219082533.8399-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219082533.8399-1-francesco@dolcini.it>
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

On Tue, Dec 19, 2023 at 09:25:33AM +0100, Francesco Dolcini wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The current DDR subsystem configuration occasionally results in write failures,
> impacting memory stability, on Verdin AM62 Solo 512MB WB IT 0072 SKU.
> This commit addresses the issue by adjusting Drive Pull-Up/Down and
> Write Latency to improve the eye diagram and ensure reliable write operations.
> This configuration is shared with all Verdin AM62 SoM and
> it does not introduce regressions.
> 
> Configurations changes from previous / default values:
> - Drive Pull-Up/Down from 40 to 34.3 Ohm
> - Write Latency from 8 to 10
> - ODTLon / ODTLoff latency from 0 / 0 to 4 / 20 nCK
> - VREF control range 1 at 27 %
> - tFAW from 30 to 40 ns
> 
> Configuration is output from SysConfig [1] web tool, currently at version
> 1.18.1+3343 (DDR SubSystem v9.10).
> 
> [1] https://dev.ti.com/sysconfig
> 
> Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Hello Tom,
would be nice to have this in for v2024.01 (... I know we are pretty close
to the release with winter holidays in between ...).

Thanks,
Francesco

