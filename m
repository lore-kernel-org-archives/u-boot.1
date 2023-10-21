Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69736C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 08:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18027875B5;
	Sat, 21 Oct 2023 10:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="pzZsyT9N";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wf+fw4Jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27617875E1; Sat, 21 Oct 2023 10:57:46 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9370F875AF
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id AAAC45C014E;
 Sat, 21 Oct 2023 04:57:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sat, 21 Oct 2023 04:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697878659; x=1697965059; bh=O0clqO+jRUCfE+5NNjBa0AFyXaQaXaOluba
 ippYHMuY=; b=pzZsyT9NWnrmdtoxwzTsLQL/dXyFTCTPx2fsdWcXX0+qRLTJwBF
 2d1PnzIom5bvsSNUPvaBDHI7J3drIWozFvREBNcpm8UqhsE2c2LaWFls7rHA63xD
 WuawEvExYLqgkxZdSsiKSrfw0F0xoOWrriuJ2DG7y/E/0T76YOwzDATeG9PFOz5A
 9KQn3IXj7X9JTdAU/Ii/+sjjMv48YruO0rDIcmV1YfNbyRnqbWiV3mEJbNFPWnAV
 kdT3e9C8PHuGX3A1OweMbWSFTQwCb2JIQZaUaj/5ZEdXfE43auxS23xEJMowzTbM
 SUTtvmvGKy4c982cV2QUgffD//auP4UyS1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697878659; x=1697965059; bh=O0clqO+jRUCfE+5NNjBa0AFyXaQaXaOluba
 ippYHMuY=; b=Wf+fw4JvypGLU/CYlVzH90uEJtaGp/yzMe0FXcDa1KYR0JdD43K
 LN+hN7fm5vaiHhHaxoCS9aNTMZm9CrvUiFKuOq8q0k3VY2bFC2Dg4vrRstTy+5H8
 RueQC0pep7E8Eh3aFN+GYv4YOuQsoCmtD85XiQtda4Kmpns26CzKeK+cPd4Cniog
 g9kJIK9h6IUKeyrurVxDUAGR+FrHSvsJm8drQ0ICk2eLcATeEHYWhVUsGuxVPMvt
 EsfSrtRC6N5Bpc4WQ6gPbN4MtRxym0AaEl5kncprd49qcwwGJ7lThCRIsXtd9pOq
 qGiEfQESAFOEfHuX8JzAa1gFj6b4vhi3JMQ==
X-ME-Sender: <xms:gpIzZe0nwD2sSLDGiILk13xlyhgr2lA_CofhGMXGCXi5yDZqdj4rMA>
 <xme:gpIzZREKIovN-eYaNcoflIH0emrGT6kpwKsIfEtDKSo62SQsEti66qSnMLtw_f4D7
 Eqr1o7i8wvtCCexxg>
X-ME-Received: <xmr:gpIzZW7nlc8zxgznvFCBCVoLEd90jrzgb5T7Tz8PB5bFQLvYG-fgiacDyy6aLK4UTzNd2DvgZsO-AhZGrSskAfDv0W6zVM4EEOyHTI47nYkkPDfMmb2RnFPc0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddtjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
 jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:gpIzZf3JCxPtA932zsoPEmc1jO2wUd_HulSgAR4_rscBqf_402YaBw>
 <xmx:gpIzZRET_oqmd7MjOyIuz-lQLFLVslu4mf0fbYaSioSL31IiRFER8Q>
 <xmx:gpIzZY8A4kUgfNnXctBwJk8Ts5J99pSaxTE-TfuU6VFyFPe6AlJeEw>
 <xmx:g5IzZXaHZTaslVI9z3vS5eA2lHQrJjH7kbYOYWhZbYKue33GaPrBFQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 04:57:38 -0400 (EDT)
Message-ID: <a9d220e6-0b09-5c59-54cf-9104727527a3@sholland.org>
Date: Sat, 21 Oct 2023 03:57:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-8-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 07/22] pinctrl: sunxi: remove GPIO_EXTRA_HEADER
In-Reply-To: <20230928215455.28094-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/23 16:54, Andre Przywara wrote:
> U-Boot's generic GPIO_EXTRA_HEADER is a convenience symbol to allow code
> to more easily include platform specific GPIO headers. This should not
> be needed in a DM world anymore, since the generic GPIO framework
> handles that nicely.
> For Allwinner boards we still need to deal with non-DM GPIO in the SPL,
> but this should become the exception, not the rule.
> 
> Make this more obvious by removing the definition of GPIO_EXTRA_HEADER,
> and just force every legacy user of platform specific GPIO to include
> the new sunxi_gpio.h header explicitly. Everyone doing so should feel
> ashamed and should find a way to avoid it from now on.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/Kconfig                                               | 1 -
>  arch/arm/mach-sunxi/board.c                                    | 1 +
>  arch/arm/mach-sunxi/dram_suniv.c                               | 2 +-
>  arch/arm/mach-sunxi/spl_spi_sunxi.c                            | 1 +
>  board/sunxi/board.c                                            | 1 +
>  board/sunxi/chip.c                                             | 2 +-
>  drivers/gpio/axp_gpio.c                                        | 1 +
>  drivers/gpio/sunxi_gpio.c                                      | 1 +
>  drivers/i2c/sun6i_p2wi.c                                       | 2 +-
>  drivers/i2c/sun8i_rsb.c                                        | 2 +-
>  drivers/mmc/sunxi_mmc.c                                        | 1 +
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c                          | 1 +
>  drivers/video/hitachi_tx18d42vm_lcd.c                          | 1 +
>  drivers/video/ssd2828.c                                        | 1 -
>  drivers/video/sunxi/sunxi_display.c                            | 1 +
>  drivers/video/sunxi/sunxi_lcd.c                                | 1 +
>  arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h | 0
>  17 files changed, 14 insertions(+), 6 deletions(-)
>  rename arch/arm/include/asm/arch-sunxi/gpio.h => include/sunxi_gpio.h (100%)

Tested-by: Samuel Holland <samuel@sholland.org>

