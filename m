Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D08CF5385
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 12:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773888925A;
	Wed, 23 Oct 2024 14:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="OLHCJETv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDEB8925A; Wed, 23 Oct 2024 14:39:36 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFFC88DD9
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 14:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 410541F945;
 Wed, 23 Oct 2024 14:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1729687170;
 bh=G1dj1fizPT1FooZydggjoEUyPJef0kX2fe9o0rVqBUo=; h=From:To:Subject;
 b=OLHCJETvVpN9MLH36A3jyHluTdrVj18CE7iZ/ft4daqf+mndGr1JAF7cEpLtUjbcH
 qmhlSnyg49+F6zZWQO7ItwIn9CK4ZYVKuu0ExgwIOFA+MVCQUCEmEWZNW1vtfzKmOw
 29H+CVxh3didQEFaPbxNrJLNMTx5tDl4mNR167EQOUl4XUP9DRN8nfUqBSH8G092H8
 2WADOLuIHTQl11+paSnwxflg6ACC5GhNy0Ug1vt6cGKkqG2E1kB4OzOGtzTM8mZF5V
 w0/aVE7vyi5LYdameCSS9jfndlCFsLtMMmV6dn9ElGmsjrVaivW4H54TOg1n9VJCKZ
 BWwhxRhWsVHWA==
Date: Wed, 23 Oct 2024 14:39:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] verdin-imx8m{m|p}: defconfig: update fastboot buffer
 size/address
Message-ID: <20241023123926.GA39313@francesco-nb>
References: <20241023115350.8413-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023115350.8413-1-hiagofranco@gmail.com>
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

On Wed, Oct 23, 2024 at 08:53:50AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Remove FASTBOOT_BUF_SIZE from verdin-imx8mm_defconfig and
> verdin-imx8mp_defconfig to use the default value of 0x7000000, aligning
> with other Toradex boards.
> 
> Update FASTBOOT_BUF_ADDR to 0x44200000, consistent with the value in
> previous downstream NXP U-Boot releases. This will make fastboot
> applications continue working with upstream U-Boot by using the same
> address.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

