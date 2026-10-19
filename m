Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D613BCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BBA040712;
	Mon, 19 Oct 2026 11:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZDdP9cYxUEa; Mon, 19 Oct 2026 11:23:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C9E940629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792409001;
	b=ZAenqK5nMzEgfoaqBGItrxoHab6tT3VdVqfaVZEwRPLxYhABrk5EffuMSEehrnfudr8E
	 JlyuASEZb3iv+RykqTpXH7ZfpCt8da5lgHAM0rbMqwF2FpUFWJZrF2QAaNohb/uBJbOsF
	 yklyxKW/E/+VmbjunRWa3hX1IRUL3nFjmmuTtCbxHqxsVsDdOicDdgoXTSxPoLZyjrlr2
	 MnMaV781nhYzrOLCYQGhYH/GQ080gRpMEV1hYkmdrErHl6craQG4UDLQHaQtVoxeGo+7R
	 DLvZvU+qab0FJ4J181iViWNb+NdFuIuKJMDtuP56n39mijpCbLCx0gSwccB+3llQQ5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792409001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9qKTRWPXou2pUoYMP76ROHflwFeDMPWWub2/5eH/774=;
	b=lOcxoggcvgL67ujB8IzQGT7BtrS/S7PsJ91H4QjmTlb9mSzIO9oP/8eddGnXf0JlO/0q
	 mSoIo8heBMmY9QqltE/i3RXTuxxubqNpGi1FKOQHyQeP+uqfdotk2xHq8olUJx1Wn28/I
	 O3O8un9zLMO5MF66aJ48D+JKLO88wDCfvPnLPTy9Ooc+cGXB3lN1ntA0ifhDvZqY/D3ji
	 Z7RiYno/bvjkfj1l0KJRnbHTfucpORLhho8DmZektRMbbgYoaEIdsbiXSsBOsgyGFoAwc
	 YazYNkJrABQmmEwWP9p76SCePIlX9jOQXPh/kxmjumjglELcnfHqYESFGTQglgjesyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792409001;
	bh=9qKTRWPXou2pUoYMP76ROHflwFeDMPWWub2/5eH/774=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jnSSSIFVbYTAiIXLkoXjeZ5mRmdWWFJz236PZXsAlLR5A9SpHRYCwhDlqbp89IHcH
	 xMVM5zGOxzQiRcqHdelUEI7OxjKN5mDMwO1gz5jxa97hPv1d/cyXVP/+UfiVwx85Np
	 ItBYQzQIw1yWleugD8Q/sMzvrQoGYyI6gtrk2YMryR2lhAmJnY61l70rBZ2SMbuxXz
	 U5ZrM79fdf9+UXE3LGRS7JdMNj2EtFR/DuONtnalskMB75jxQF3VhbAt+dmf9DekJd
	 0QSGgcO/nLHEOBx8Xt5630MHJhtngfWQJiCVBgFm2bP7wIJge/kwzJ2MMjdN4EXX9W
	 hA8xFwHeEkQ+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C9E940629;
	Mon, 19 Oct 2026 11:23:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2582769
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93FDE60603
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLrPQyulnwHv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFB4660600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792408998;
 b=NfaTpaHzbdkQU53Ni9h4IiHw/y0OYSu4wzGwDUPYzBcxhihoVgPWLNCz50AQbCDDAvJU
 g6HdEzQLA0KnRVZOX3SEAm5WJh56mmTrxIqdzqouOQ3scgnS4xn8qnEPsXBnsKD0ae60k
 MYa8QIgtivp0MgpzzMJMSakJvgruUStDm8f3xPFZyLoG9JoG5zZcXeH/0Hpfdz5OreKL0
 3DiYAM+iZLpla0d1ZdosIZrS+9BYngwKMPd2CObMPp03Jhpp6o4QKeEdkj0oMepISqF03
 kUzzffFhPsATtthU3gAAM4so7SOeJZmsHoi3qeeg0D+mCNsZq4EqhRGeLcMsyy6ILlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408998;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=9qKTRWPXou2pUoYMP76ROHflwFeDMPWWub2/5eH/774=;
 b=rMubbuBHNNHcf2DaF/9+8HEbOgDBt9NpZ5xOISjppHOEWSkxoRTFS1Vz0mXVPT1U57jv
 WE7xyd1MnPjNrpM3ejJEqle0dzzFAB2Q4u566V+PJjzr5/qu+VJCO5nHlIYG/+4jhr57p
 tnOYx+MkPIjCi4S9TcPgos3s9I+rh4FBQ6W9zV3Oa7Jky9cLxgvBPDc9nBd3u9ARkVJ0V
 wLpZi3fWc0oiJPp7JmSlRAal66aK1QGTqGHwB+8fGb+AxDE4kpbzMsSTQOqNJu7xDy/P0
 J/YEWhohBtEBF1MaJbh2K+qDiDHePSlYg4TV1mBaAQ8SYlX5E3zyzucl5GypFyCHbuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=xs4all.nl;
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=GKOKyqAg; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=GKOKyqAg
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFB4660600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:23:16 +0000 (UTC)
X-KPN-MessageId: 78797b94-cbaf-11f1-8627-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 78797b94-cbaf-11f1-8627-005056aba152;
 Mon, 19 Oct 2026 13:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=9qKTRWPXou2pUoYMP76ROHflwFeDMPWWub2/5eH/774=;
 b=GKOKyqAghVzOYEqEEOJJzDYbfVATg9v6NM+9OyNU10u93h1Atbv9i0eKdR1W8FIdO0TQSjPMpyHqr
 R5Q2LV9a+0KOKhckAsQ/H3BKS3EspfFBGr8Z9v7wuVzViI9LZuxHCmW30ZqExCBkvJEcDT3xgvrhaR
 KW0jrLI5mH1Rr7k0yntjQVSoENUOmNrUdUZHmoKhL1hQw+x48vFLwyKUbYelHjCrBcYoyaKc9age1t
 QAEezx6fvvGfFDEWyHlZEyJJByj6JphcElW4ZnquNSJ4GxiK9rqEglDaaGpF9bpB6pqpWHwygFMhVF
 m05+icHFnUs1ZLEZ8y4OVpKfXA8atKA==
X-KPN-MID: 33|nlMB/bceciL7WYirUKhjjJ9qwozPGKnquFilUcdYWpC8As/pm8XlaLeciMrlVN2
 feZQ0syp4gKavxDu6WOgMbA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iBg/d0SC4HewNveoPX/e3tcW9UNmsBkK4KfCW6iCziSjnwhy7Y30Na/alB6aPcr
 1uL59QPRmKPi3l/HZg44O4A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 77fcc2ef-cbaf-11f1-92b4-005056ab1411;
 Mon, 19 Oct 2026 13:23:12 +0200 (CEST)
Date: Mon, 19 Oct 2026 13:23:11 +0200
Message-Id: <875wyyylwg.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, asahi@lists.linux.dev, anshuld@ti.com, j@jannau.net
In-Reply-To: <20261010-apple-t603x-support-v1-3-ca529f301a62@jannau.net>
 (message from Janne Grunau on Sat, 10 Oct 2026 14:13:59 +0200)
Subject: Re: [PATCH 3/3] arm: apple: Add Apple M3 Ultra (t6032) support
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
 <20261010-apple-t603x-support-v1-3-ca529f301a62@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Sat, 10 Oct 2026 14:13:59 +0200
> 
> Apple's M3 Ultra (t6032) SoC consists like its M1 and M2 predecessors of
> two M3 Max dies with an "UltraFusion" interconnect. Since it is only
> used in the Mac Studio the mem map does not need to duplicate all
> entries. Two of the USB4 / Thunderbolt complexes on the second die are
> unused. Only PCIe host controller on the first die is used directly. The
> PCIe IO on the second die is used internally to connect the NVMe
> controller with the NAND flash.
> Most of u-boot's existing drivers are compatible with the hardware and
> M3 Ultra device trees will carry "apple,t8103-*" as fallback compatible
> strings. Only apple-atcphy-reset will use a new compatible as M3 Ultra
> has ThunderBolt 5 / USB4v2 USB-C ports.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm/mach-apple/board.c | 127 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/board/apple/m1.rst      |   1 +
>  2 files changed, 128 insertions(+)

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index bd0c69fcb512..d8ad925a00e6 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -843,6 +843,131 @@ static struct mm_region t6030_mem_map[] = {
>  	}
>  };
>  
> +/* Apple M3 Ultra */
> +
> +static struct mm_region t6032_mem_map[] = {
> +	{
> +		/* I/O */
> +		.virt = 0x280000000,
> +		.phys = 0x280000000,
> +		.size = 2UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x300000000,
> +		.phys = 0x300000000,
> +		.size = 3UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x580000000,
> +		.phys = 0x580000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x5a0000000,
> +		.phys = 0x5a0000000,
> +		.size = SZ_512M,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PCIE */
> +		.virt = 0x5c0000000,
> +		.phys = 0x5c0000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC0 */
> +		.virt = 0x700000000,
> +		.phys = 0x700000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC1 */
> +		.virt = 0xb00000000,
> +		.phys = 0xb00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC2 */
> +		.virt = 0xf00000000,
> +		.phys = 0xf00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC3 */
> +		.virt = 0x1300000000,
> +		.phys = 0x1300000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2280000000,
> +		.phys = 0x2280000000,
> +		.size = 2UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O */
> +		.virt = 0x2300000000,
> +		.phys = 0x2300000000,
> +		.size = 3UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC4 */
> +		.virt = 0x2700000000,
> +		.phys = 0x2700000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O ATC5 */
> +		.virt = 0x2b00000000,
> +		.phys = 0x2b00000000,
> +		.size = SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* RAM */
> +		.virt = 0x10000000000,
> +		.phys = 0x10000000000,
> +		.size = 16UL * SZ_1G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* Framebuffer */
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +			 PTE_BLOCK_INNER_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
>  struct mm_region *mem_map;
>  
>  int board_init(void)
> @@ -896,6 +1021,8 @@ void build_mem_map(void)
>  		 of_machine_is_compatible("apple,t6031") ||
>  		 of_machine_is_compatible("apple,t6034"))
>  		mem_map = t6030_mem_map;
> +	else if (of_machine_is_compatible("apple,t6032"))
> +		mem_map = t6032_mem_map;
>  	else
>  		panic("Unsupported SoC\n");
>  
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 002f4926ed5e..f1be55996b95 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -18,6 +18,7 @@ the following SoCs work:
>   - Apple M2 Ultra SoC (t6022)
>   - Apple M3 Pro SoC (t6030)
>   - Apple M3 Max SoC (t6031 and t6034)
> + - Apple M3 Ultra SoC (t6032)
>  
>  On these SoCs the following hardware is supported:
>  
> 
> -- 
> 2.55.0
> 
> 
