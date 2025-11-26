Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9A1D10F4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E3E83B72;
	Wed, 26 Nov 2025 15:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KRVtUqtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D715183BEF; Wed, 26 Nov 2025 15:03:47 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B2183B55
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E4D791FA7D;
 Wed, 26 Nov 2025 15:03:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764165825;
 bh=icOl2DBc1A/mktn3ieTv2uF1aI8sWPPP+srLKJIjbDI=; h=From:To:Subject;
 b=KRVtUqtqBJqrez4W+Xnby6jzspToS5ThFc/hkUlxIuq736iZyllBvDkzJALjSlBUb
 aj8wfR8Rdbjdt1UTyNwQ06IC/wH3T8PzCskaxK3BmqcMhEt8avi7jwL8KpFvhPfVjI
 mIi+Dlpkk7m/3PSg9o0SlJkYCsG6AeNN7W0ngvR0PXK8qVqEe3B+u4DTuj6mrfxXbV
 iq1+4kZBi3m9r+jt727uRr0zfvHM8zoCRnNjr6J42J7UD9zTVQJLcOUgGqQPm+UBH2
 moC7MUW3ZJk0JOsBsZbHzmhuHTEgmzLMLKwZ0DgoUOSLaj9CHoPXqt8T2pVVExpty0
 rDsJL36IcUT6w==
Date: Wed, 26 Nov 2025 15:03:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>,
 Alice Guo <alice.guo@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] configs: toradex-smarc-imx95: set spl_stack
Message-ID: <20251126140340.GA45401@francesco-nb>
References: <20251126134107.2969608-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126134107.2969608-1-max.oss.09@gmail.com>
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

On Wed, Nov 26, 2025 at 02:41:04PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The SPL_STACK config option now depends on having SPL_HAVE_INIT_STACK
> defined. This made savedefconfig dropping SPL_STACK when sending the
> initial configuration.
> Note that SPL/U-Boot are able to boot linux from mass storage with
> SPL_STACK not set but other use cases might run out of stack or
> overlap with other RAM use.
> 
> Compare with:
> commit d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")
> commit 25fefa05d732 ("configs: Resync with savedefconfig")
> 
> Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

