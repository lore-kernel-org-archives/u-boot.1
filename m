Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52136CC6B30
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 00:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA301407E0;
	Thu, 15 Oct 2026 00:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YXUtDiMW51l; Thu, 15 Oct 2026 00:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C45144073B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792025520;
	b=FIRELoe+Vy0ji1R69XQFlZs8zz5gua4AyAPOgOSApGklsZbgGOXXuuu9cFvieGr7z+EA
	 5rv8b7V/diQ6OTtgwI58uGN8NIsx6wdw3uom2cNrrDVMEcW62mVMGUXK/cgTNMMrNsqhi
	 ZOG7yBoYXT7ZVVriBJh7Jz0N28hVACP/ooxDmCb/GgWV/PLfBXq1EitA59GfBGaviInSH
	 cI+94Q2u/T2NrEj8L52ThLaCoKamHhTdBJY4lrPFukKheu4lpR7jfsf1nuRAXHTntxVY6
	 cVSL5kXeY1eQfEQ4UUrZUG68QaAo2AHaSjDPw4fkZPbWmD6bE38eXp1nc90uqAp6MTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792025520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Debian-User:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JiQ9j81ZEUYWY+7iKd8rf7i5LrISPZAIwVdHuPjBPdc=;
	b=XVUmXyuD6kABDoxKA+rys3E2l1y/kTh7JQKZvTIaL01wyDdkIOkq3lV/uj1gZIz+dKUc
	 PB8dhbj2owoxYRhtsuj1AUiGMRgnVAk8aMyZ2CoVCYIdgegfZ2KlXvOswVvZwI/QbbFkm
	 9ViaTr4SsPo8oVaU4DaVB+QsPL/2GEBL/i4N1MzvG7oPNcn1r7wM0ml/o2QXRHXb3K7x3
	 D7QpY9Nj9MfhndQAJbFKU/8pgbb1hZ/pjTz1q0XmaIfj7WVtZnqQO1irL9PH7axB1A2IK
	 LN7x1t2Yx1Mt+brJDuij+EknLyD+6V0TCcjGwGGoXfHbjiSIwOvJaS2zqrGsRB0qg9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792025520;
	bh=JiQ9j81ZEUYWY+7iKd8rf7i5LrISPZAIwVdHuPjBPdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEJBw1Z155zZk081wEjx2I93OrfmMFE5kHvqLSjUq1m2hG/48XlBebKH2Mbown3oO
	 sB4jnhJnKeJppQqJ7r2+Ytp4wtFpzEUwCZn+j+G3vE836IpegYC9Z1EUCy/XkDiEL9
	 CJ0okohW24gQciS4z/gHba54lYMUZHgmTT/nD1ViqNGGnGqyRUNik4vzHoi//ah9Nw
	 4TgmXiHQW8/CtcbAYixOd7WJ4T3lBezVxaRPNnQeOg6Mx0wGiSwt35ranFKCOs5sef
	 NFAF2NgNMWN4AKdlIrA/aXj3vDB8sU0IfYOam+ox0hcYGAfh60h1BKOzM26oTEXZii
	 kQS+IycGGAung==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C45144073B;
	Thu, 15 Oct 2026 00:52:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 951012E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B20B81005
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfHJzV9x-5Ce for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68A3480F71
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792010303;
 b=WjMFTIugY3CntTb4ermfHaAXBEBIy83t1ctFsBYnGImphIabh9rmyKWv9QkDCbTdWVIB
 zh35BjUOCO1HQuTMZMNRl10hztu/+CQnsHlBHrdV4P29Yh2PLd9nK8syyyF1skLBq78+T
 lBfxxN7+VIt3odeeyN1n3ikxEwmC4afvyv2OQQzdI+Z2eEL4FytHEn8mItVX6Xw26GZqQ
 Y90JkRbSJaQ5IKhlR3Zw4oLZ2yOKpa2VEudq0psLHet8Ae1dnErIvVu4XpvfIli4p9Epz
 Jlf89lmcGlpC+FQwgpCQyfJ0a8hlUF6v6IDgId9iF3goadle94tvrZbi80luRmrjijA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792010303;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Debian-User;
 bh=JiQ9j81ZEUYWY+7iKd8rf7i5LrISPZAIwVdHuPjBPdc=;
 b=UhTA5jGYn3Hx9tFCaQ6GsAnxaMYmqmSbibRQyu6wn6z1Zahlhk4mcFSejkunrNw2xxMz
 67u3zKPIz6CqzBHCNodkeDCjPDt3oaeOwOwvsp5BGgThLNVXG00xz4Y6uSmkk9uF82RJ7
 KPUljMKXH5oeg0LYcYOQYgxGjhWqwd09IVfzVrOL9+Z6XCv9691PupNyCFI4VLYq+hN/U
 INt9AsbgmydSIxyUykbHTizZmMkZsITXmuQtCoAYDsjVxeYvr7po5X0EhK958aqQE232D
 1Dw4PP5CGuE1dWrjFAxrlZq6xRoDE2Vk3ikpNRmFKDITVlGYx/nvRjizgG00OWADTSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=fatal.se;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=andreas@fatal.se; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=fatal.se
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68A3480F71
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:38:21 +0000 (UTC)
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <andreas@fatal.se>) id 1xH5jq-004g9M-2b;
 Wed, 14 Oct 2026 20:38:15 +0000
Received: from m1pro (unknown [IPv6:2a07:5cc0:4750:8a00:ca89:f3ff:febd:8b38])
 by pi.fatal.se (Postfix) with ESMTPSA id 9225F80;
 Wed, 14 Oct 2026 20:38:12 +0000 (UTC)
Date: Wed, 14 Oct 2026 22:38:07 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <vheanflup2men4bi5bmhm67pxdk5kq54hzgc6dxtfx6aw2lbog@ahynysqlf55g>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
 <20261014174957.GA152546@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014174957.GA152546@bill-the-cat>
X-Debian-User: ah
X-Mailman-Approved-At: Thu, 15 Oct 2026 00:51:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, Oct 14, 2026 at 11:49:57AM -0600, Tom Rini wrote:
> On Wed, Oct 14, 2026 at 09:46:44AM +0200, Andreas Henriksson wrote:
> > On boards with >3GiB ram, we can end up with transfers above 4GiB
> > which is not allowed by SDHC driver.
> > 
> > fsl_esdhc_imx.c: esdhc_setup_dma():
> > 	if (upper_32_bits(priv->dma_addr))
> > 		printf("Cannot use 64 bit addresses with SDMA\n");
> > 
> > Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
> > (with systemd-boot as efi application) and print the above message.
> 
> Is this a driver limitation which should be fixed, or a hardware
> limitation that needs to be enforced by this Kconfig option?

As far as I understand it, this is a limitation in the (S)DMA design
of the SoC.

> 
> -- 
> Tom

Regards,
Andreas Henriksson
