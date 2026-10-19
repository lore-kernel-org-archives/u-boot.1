Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C6CCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2941B80E43;
	Mon, 19 Oct 2026 11:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bK_SPCAvRn4m; Mon, 19 Oct 2026 11:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9002080E44
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408788;
	b=Xd027C3GM5d34mAv6wj0X0YcDO4YklCgNYUshNmSySa04T99eQCifr7fpuYRMHLitt/O
	 4FOj5ivbfp/vPx80k9I0LUj5TK5ysjVQnvexpXz2VIS8XoHXmyeTZpQx+kj7s9C+va7I7
	 YUAfj+V+H1YYetb4We6U6lMdaZKNKWi+1m8QQmnPQdjXXFgqt9g+2+aFoXscPWYtxSGmY
	 65zdpIBeHPfQLXZELPrCdUZx5L461MtIiFdCC/5wiBbRbT4ay3qHAMYXprKxen1hJitwG
	 gCmSrSLDqEPWq+544+xWCrdfzRLwyVWv70mxs87eASneVBFk9BXa+ow4r7BexKrCoqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wt5ocYb+wtAikdetWG/PtghRsme5LtymJEWIkM8xwI8=;
	b=DFNgZh4ZgPViOu8uAwW+EynQBli/bRxTvpqlXBRY4Mx1hgm3z6pPprQw3uZEDNsh5nSt
	 wGikSGGAc5ayzUGn4p7O2uR1rJIjbn4fffv6+G+29c3mo78nVp9cgCQtoHVTDB45g1n3r
	 mK/tfskIsZMVcEoqTOsiPGkYn7zhuAuUvT+v/vXHRJJHrLUvhGvxmf7pZu++B1/IJqOnu
	 nK+Pl9rwcTAzcfUEWR9rF2/00aB8jlpZ6Ff9Vw0Jl+i1h80+9YdAiwTKecPPEYnCg8sUw
	 47+I3/7CGLfrCZvzKrSWD498Vr4HlTg37DPCVsHpN+SbpLbLv6i2AQpkixif1Tatstg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408788;
	bh=wt5ocYb+wtAikdetWG/PtghRsme5LtymJEWIkM8xwI8=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddUO0IGhFHvr1C/whrOq4+AMGDmr+0ilqLsdrI8BuiH/tq1lUKdCnyFWUiyEuyd1M
	 7D+vlFIZTaST8KTDXMepLHyd//+h7kMmLLJoAn6rTSzuUNIBY/73LGZBtB6za4Q6RC
	 ZGSkcTIsS6yDkripFl3rI2BFMAiKcK8fZw7uAHOBs3Dxn2jUAkwjrfwi3dKzaqV7Z8
	 VhGb9EdZqBHe1OjVP9pZeftIAvzdFpMj7ZKpBgqzmmJAJSH1pXoXoxPlFYXn9fNkhU
	 f2XaiI/2KXURJCPaNiVt1/AdXcZWYOeDe/L0p/extJkzGjd8olVdtse22vCOzaffS3
	 9sMj2q38jes4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9002080E44;
	Mon, 19 Oct 2026 11:19:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97E1F1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A53740080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40vx9kLBocXv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 389C040079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792408785;
 b=ET9mBHqdL30w6GtPJop1trN5ChzMxK4qglUacikp+ylhW6HGli/fwtmKKEvPAY9W7fS6
 O7G3MXRrhHIRmaQb26jFCJBvhBu0TAEDwrtHuCabxdiRN5ilayNtQyrxVUNA2Wh9PU+dO
 SVYrDZErwMRNUxv2WAqnv3RBKKWEtuvKBMSwF6b+tEcwvpJ7kfl+Pz7g+VeJa3uUzjNB/
 Odt3bLZqXE0ZkwQXdF1RdLQlg4GMNX5ZuQKjPIZ1oeXdv03zJvYEYnynKiPRqvUfTvude
 4DxPMqIDKmPJ89yZcfywqPvGSa2pfJ9Ww6zJO8jHcF8HLWqfjCj6Tg46NHtUSDp6IeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408785;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=wt5ocYb+wtAikdetWG/PtghRsme5LtymJEWIkM8xwI8=;
 b=HK27O03v1yHeJ3nfSnohWvK2KgqquJnIlYfucQHcc3Xf5RAl043V5m2+/G+vmT7alyDF
 prCwQ3Y9C1JW3p23OqgHkYYKtgMM/l8MU4X7R3R3obk6MaPRZ6Wy0SojqJgHQo2p84a/+
 uc2mkOSs8i37I94pkksVTG8Dj69GIJeo9BBd3bt/oFbQb8Qh5unUXQQlWBz2jERPZDAsX
 IZ/riBXHCDNk1o/lpX/Jt28LtYi7KYMQ/otgJQJV+rs0vpyTiA+G5WeVGoY/CseLAxKNe
 2OVikwFFtiOY/fQfifEta8cLQybvtGFYc1b+vliFjsLwNeom2QUWzWTuhIyhocoObmA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=xs4all.nl;
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=klAw3z6Q; 
 arc=none smtp.remote-ip=195.121.94.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.169;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=klAw3z6Q
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 389C040079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:42 +0000 (UTC)
X-KPN-MessageId: f8060ea5-cbae-11f1-a05e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f8060ea5-cbae-11f1-a05e-005056abad63;
 Mon, 19 Oct 2026 13:19:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=wt5ocYb+wtAikdetWG/PtghRsme5LtymJEWIkM8xwI8=;
 b=klAw3z6QgMOKtt2faqc0ljWyDl7fQMDIttDgiAFmr+M5BUqPx4M153T2XKcBs8i4k6tHp1gONJJEw
 OoRhHgygkbtkyu48BTa4EBU6Br1KV1UnX02XrKhZvUy3SIa4OH7/PA6Gl4XwaBBFsYCqCM2rZP82+f
 tTYuRU3SKBG8u/NHTtuf6vyziReBl+xNUCIzdu4JlYJsWnFjoa/lNZ0XTce8aVGOY92Vgm1C5qtZgr
 a8KCxIUP9i6v+22zVBMZcTP5n+YmNcl0wDCSphTpMMYzK7o4xlIFA/auVNbiR47nOcBiV7RP0L8jCv
 3xItnbIaeUEgIrVx9d3dUxQNA9hxsVQ==
X-KPN-MID: 33|vkDL8VoR8EAtSdVM7gwabo+IKZ07Ucr3zqqIueNt0/Mm8Eb1x6lvbOso1fUQqdi
 5y2icZb4tJbyVSTmYwsvtCDS8x9gRQ9WUQ71UKlB248o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ksWR/1+52KPoPQE00MlW6pNzMcMRtrfU3bV12QvXFHRjkhmA5+AN4vXx5PuJIlj
 2joB5hh2ViOMw182XH9ku1w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f78d9c24-cbae-11f1-a8c2-005056ab7447;
 Mon, 19 Oct 2026 13:19:37 +0200 (CEST)
Date: Mon, 19 Oct 2026 13:19:36 +0200
Message-Id: <877bjeym2f.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, asahi@lists.linux.dev, anshuld@ti.com, j@jannau.net
In-Reply-To: <20261010-apple-t603x-support-v1-2-ca529f301a62@jannau.net>
 (message from Janne Grunau on Sat, 10 Oct 2026 14:13:58 +0200)
Subject: Re: [PATCH 2/3] arm: apple: Add Apple M3 Pro and Max (t603[014])
 support
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
 <20261010-apple-t603x-support-v1-2-ca529f301a62@jannau.net>
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
> Date: Sat, 10 Oct 2026 14:13:58 +0200
> 
> Apple's M3 Pro (t6030) and Max (t6031 and t6034) SoCs are similar to
> their M1 and M2 predecessors. The MMIO blocks have been extended but
> M3 Pro and M3 Max still share the same overall layout although they
> aren't as similar as M1/M2 Pro and Max.
> Most of u-boot's existing drivers are compatible with the hardware and
> M3 Pro and Max device trees will carry "apple,t8103-*" as fallback
> compatible strings. Only apple-atcphy-reset will use a new compatible
> due to USB4 and DisplayPort changes relevant to the Linux driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm/mach-apple/board.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  doc/board/apple/m1.rst      |  6 +++
>  2 files changed, 103 insertions(+)

Acked-by: Mark Kettenis <kettenis@openbsd.org>
> 
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index e74a5a76919a..bd0c69fcb512 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -750,6 +750,99 @@ static struct mm_region t8122_mem_map[] = {
>  	}
>  };
>  
> +/* Apple M3 Pro and Max */
> +
> +static struct mm_region t6030_mem_map[] = {
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
> @@ -799,6 +892,10 @@ void build_mem_map(void)
>  		mem_map = t6022_mem_map;
>  	else if (of_machine_is_compatible("apple,t8122"))
>  		mem_map = t8122_mem_map;
> +	else if (of_machine_is_compatible("apple,t6030") ||
> +		 of_machine_is_compatible("apple,t6031") ||
> +		 of_machine_is_compatible("apple,t6034"))
> +		mem_map = t6030_mem_map;
>  	else
>  		panic("Unsupported SoC\n");
>  
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 4ed275f7ea8c..002f4926ed5e 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -16,6 +16,8 @@ the following SoCs work:
>   - Apple M2 Pro SoC (t6020)
>   - Apple M2 Max SoC (t6021)
>   - Apple M2 Ultra SoC (t6022)
> + - Apple M3 Pro SoC (t6030)
> + - Apple M3 Max SoC (t6031 and t6034)
>  
>  On these SoCs the following hardware is supported:
>  
> @@ -87,3 +89,7 @@ supported SoCs.
>       - 0x2a1200000
>     * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>       - 0x39b200000
> +   * - M3 Pro (t6030)
> +     - 0x289200000
> +   * - M3 Max/Ultra (t6031/t6034/t6032)
> +     - 0x391200000
> 
> -- 
> 2.55.0
> 
> 
