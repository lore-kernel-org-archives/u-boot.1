Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12AAD3E2A2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 18:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40606890A9;
	Mon, 28 Oct 2024 19:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Qk8jGUQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2D5890DF; Mon, 28 Oct 2024 19:49:17 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501798909F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p7+sjT0NdoOeLPH0DkWf6Rrf1Ei1tmRk/2LpyUMNvOw=; b=Qk8jGUQP0VVdUjuX+EcrCBH/oc
 s1I+9VPZYjOdRByqsNAiO3G3x1l/JFmBDNn9wV0FQTjPwEPxxMt3FpnV5pHocfG3r8BHpNzqdG2lT
 VSHvIAvVlGJblNL6znXi6NKuTTWS7il3f/IK9O1gpBTFt2sR+QB+4MeVrVPZ1oqrrcS+x4Pmdl+tN
 F10EIyYfXfru8ZU9DiXCDlmDZh70+g6M5GDadwVTfBOErVbJOb8urRhjsGxeQ7a3IqLRB7vd9hS5x
 yXfCu9KmLDj+N+NBJ/K0zoSoLp52rfO3gX37pBqS4ackQ8qak4TX9L/cVyOzORCRdS8kNqEhkVT+o
 ZLnHGUsA==;
Received: from [185.156.123.69] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Unh-00082D-Ro; Mon, 28 Oct 2024 19:49:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Kever Yang <kever.yang@rock-chips.com>
Cc: ukleinek@debian.org
Subject: Re: [PATCH v2 18/18] board: rockchip: add support for Qnap TS433
 devices
Date: Mon, 28 Oct 2024 19:49:12 +0100
Message-ID: <2882551.mvXUDI8C0e@phil>
In-Reply-To: <17d20d41-5546-4b11-92b2-b51bfa076bc5@rock-chips.com>
References: <20241013192424.84280-1-heiko@sntech.de>
 <0673c284-fc0c-4495-b44a-4c9e5e162b39@rock-chips.com>
 <17d20d41-5546-4b11-92b2-b51bfa076bc5@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Hi Kever,

Am Montag, 28. Oktober 2024, 09:39:27 CET schrieb Kever Yang:
> On 2024/10/26 10:39, Kever Yang wrote:
> > Hi Heiko,
> >
> >     I got a ci error for this patch:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/929839
> >
> > +Image 'simple-bin-spi' is missing external blobs and is 
> > non-functional: rockchip-tpl
> > +/binman/simple-bin-spi/mkimage/rockchip-tpl (rockchip-tpl):
> > +drivers/net/rtl8169.c:320:2: error: #warning cache-line size is 
> > larger than descriptor size [-Werror=cpp]
> > +  320 | #warning cache-line size is larger than descriptor size
> > +      |  ^~~~~~~
> > +cc1: all warnings being treated as errors
> 
> The other boards are using below Kconfig to fix this warning, which is 
> suggest by the driver:
> 
> CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> 
>   307  * Warn if the cache-line size is larger than the descriptor size. 
> In such
>   308  * cases the driver will likely fail because the CPU needs to 
> flush the cache
>   309  * when requeuing RX buffers, therefore descriptors written by the 
> hardware
>   310  * may be discarded.
>   311 *
>   312  * This can be fixed by defining CONFIG_SYS_NONCACHED_MEMORY which 
> will cause
>   313  * the driver to allocate descriptors from a pool of non-cached 
> memory.
>   314 *
>   315  * Hardware maintain D-cache coherency in RISC-V architecture.

thanks so much for this pointer, I started looking into the issue
today, but your pointer made everything so much easier.

Thanks a lot
Heiko


