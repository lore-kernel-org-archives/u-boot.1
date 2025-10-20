Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40736CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 11:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A618282C84;
	Mon, 20 Oct 2025 13:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TY989OnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE64E831D5; Mon, 20 Oct 2025 13:06:45 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7419A807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 13:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3466825FFD;
 Mon, 20 Oct 2025 13:06:43 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_8nl7xF5xsy; Mon, 20 Oct 2025 13:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760958402; bh=71d3Vbzn+f9i+m/G5L7t7IpOOn+wdCRkU6K46y5L+Wo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TY989OnBgMRYT7FNKeg7PxVag/TONAJpmG/ZAE0k2wSheLdmmfdSZtWasGQdpKek7
 T5bLuW4PcBjzwcOGo1KI8njz/XqLD/npY2PPF0TjsVP2s8dHruI/2NGYMMJ5EklvGG
 jkGtWtz+zgpzJeREaeOqKIlibFDz3M2kY4fTIXmX+xb/PYQdwa48kFmzGyL7iL1dar
 ng7bBp5JN5zbQje4CgLA04EijBu8vMpnFdeJmWwEprM3m4G/sJwNkSSOe5Tfi+cyV3
 xGBUvCcHCbB3pGjUbkLixpLspMt+xSHkFAdNz43/nYsZRAPQaXG0pyqdMEY+Vrs1UP
 na8dnEKpostYw==
Date: Mon, 20 Oct 2025 11:06:35 +0000
From: Yao Zi <ziyao@disroot.org>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>,
 Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: Booting from SD-card on StarFive VisionFive 2 is broken in master
Message-ID: <aPYXu9HsnCO49riQ@pie>
References: <aPYUlyni65Ux8xpq@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYUlyni65Ux8xpq@pie>
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

On Mon, Oct 20, 2025 at 10:53:11AM +0000, Yao Zi wrote:
> Hi there,
> 
> While testing the behavior of my previous patch on JH7110 platforms,
> it's found that StarFive VisionFive 2 fails to boot from SD-card with
> current U-Boot master "a58089ad2e4 (fs: semihosting: Use correct
> variable for error check, 2025-10-02)" with messages like
> 
> 	U-Boot SPL 2025.10-00669-ga58089ad2e41 (Oct 20 2025 - 10:29:30 +0000)
> 	DDR version: dc2e84f0.
> 	Trying to boot from MMC2
> 	spl: partition error
> 	Error: -38
> 	SPL: failed to boot from all boot devices
> 	### ERROR ### Please RESET the board ###

Forgot to mention it, this problem was also independently found by
Vivian Wang in later September, so here's also

Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>

Adding her CC as well.

Best regards,
Yao Zi
