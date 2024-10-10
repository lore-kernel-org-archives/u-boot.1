Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC91CF07A0
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 04:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F45687042;
	Thu, 10 Oct 2024 06:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="UTqC+dpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD8387042; Thu, 10 Oct 2024 06:30:37 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D67585B66
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 06:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
Date: Thu, 10 Oct 2024 15:25:20 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1728534617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3n9VjxXtOgWrN7LV1lv8vdvCjY5hSyaXqNluwsfqBbY=;
 b=UTqC+dpVVEBajYOtGnYetkiLMSc/rqbLclmRhrQVZmzAX6je7LrcoguVbnd55bMgklqN/4
 ZfWC1txATnLYhugk7p0I2tE2Asr35Gkvs5+tx3o2qq391Y/WLsrbbqnofMH7SR7k27/UMh
 N81blLtcLjLMTwkDKmwuHz0hsSomgq0Mhj+p26dl8dqk7INSEpGy1IlJpe05RD7TYmZqKp
 kQdGZzrqkGrNGwAdHEQtGE/bqvVRBucUs6YHPxPQ20PNgogR7B4fMsvv2mIhZXndcH3eh4
 fRgEq+7vW9RdrN/F7QP4XoGq0VKaAqXem2jmvj6g3o06E4P0NwYzMPswrDaqlA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] spi: Various Kconfig fixes
Message-ID: <ZwdXMGwrSl_BSo-d@titan>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
 <172851469550.3580955.13258224579239542355.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172851469550.3580955.13258224579239542355.b4-ty@konsulko.com>
X-Migadu-Flow: FLOW_OUT
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

On Wed, Oct 09, 2024 at 04:58:15PM -0600, Tom Rini wrote:
> On Sat, 27 Apr 2024 15:40:39 +1000, John Watts wrote:
> 
> > I'm doing some SPI work so I tried to compile all the drivers on my
> > sunxi board to try and avoid some regressions. This failed, so here are
> > some fixes for this.
> > 
> > 
> 
> Applied to u-boot/master, thanks!
> 
> -- 
> Tom
> 
> 

Thanks.

John.
