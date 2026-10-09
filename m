Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A8CCA601C
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED48381489;
	Fri,  9 Oct 2026 09:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwD5qhRdfAb4; Fri,  9 Oct 2026 09:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E7F181471
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539864;
	b=PLbVuml2RKr5oLu27s5f2gIaqCOyxxP2NSnTFe8yrSOAsyvy05EokEzRrD+5+uhx6yZO
	 r8ttpW789+n4ZRjk+BGEtSCXP2jSG4ntsByBhZqD2BbAOA6PNbqLgaFBj0BwilnAYftPO
	 nnKNo/oQnFi/ICRu+JyXzjoHMn/QE4comQ9jD8IHfna8EpTR++v0VwWSUghWR4jEVFhfT
	 MleVT98aJO1ZsN8dpPEDwPlMtYBhbddSe5KyzQ/EqB5NXlW3p3TxW+G+Da7Ye+oBZgiNw
	 x2bu10jkUWPY4RNm6xjVyzeDhbBC0BxbyTi0pVPgJnIWcxEcrQnDX/YIyLh8s6Gp/Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EdwRYS2qCEXB2UTtWrzkG+uvkzI2TnTUE2wYJ00k+uM=;
	b=FYVY+vHp3Jy+UdFCbpuYJKnCWamYPFycr7E5zTEDVuzKI4I5ed38HnvNkwWpQfRVgmVn
	 jRuJLKvEa0KGbllH+dVqPkx3mF40p0e/qnQ/dxXDhIO4JtaTDDxgklYCs5Ok0Rc/bzx2L
	 P83iq62Uv097J7mUIcpoPrGuO8upAsBeA+lIh1qOiOu2uvPMQnqkOHwsuRPEyeh18Rfnu
	 sggZRT35NeQACZImytObp4xlycM9rxy+1vJC2Tj59KYvm1TkQvaNh3AybFGy4T0SlJ0Oh
	 dooQWYciHJsp12+6h14a4yEHetAKa8j6DVqBq9WYEitDZ+8duP8bDn6B1couY35RCtQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=e0NmuDKU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539864;
	bh=EdwRYS2qCEXB2UTtWrzkG+uvkzI2TnTUE2wYJ00k+uM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0gzRdxBJhSJTSvvGzJagBaLJJmzKctXznETWaf9/bsexW6Jssb1jTARV13Le0I49
	 IyNymV9NOXWIlHO/PHdXJWbMcV8PbQX9Ctfg71GHYUcpdaJThrFPi1N21hrGQc83Re
	 R2lRAat4LtLR8uqw2sWQgeeHmfwmDX2+GrBdC+EerjwwbioauJGnBkbJMSjN7qr8IS
	 D9qYQ5zZji15p4Jl+FVm1BZxYZywTX+NggdKvj/BndJquBhRqNGndI4TDvz0YgrQCh
	 1HQVuD/wHZOEtysXrEVXFFT0a6HUedPGFVSWPaExJUrkf3m9/aWburlZbIxOFE9rz+
	 NwAOmt2XQF60Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E7F181471;
	Fri,  9 Oct 2026 09:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2C9575
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E423181352
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C210N5zO3_P0 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA011810E9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::8fae"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791539861;
 b=nnzqcDK7D9ZQt+UziLZKDsU76R286BN7JVhSW0UP4VlC8mz/+V3Tn1sralfeqbp6sTse
 E3PoFfV6iljrqOtyEuMY+bh9u8NFG6BXIN5ejn4+ON5ckz5DEnrI7SZqsxvHR2OXAhtMr
 5A3DYqsdxg/9tyQNAuSr9J4iyc3LrUnEwMG0mcfOnEEleulHUFOY4i8VcshF+ysQWUr+w
 W+TzSWJSgMPeMLOoxLL9MZlz/X/v5Z/qx8DSfR6Z1iV1hBasWhk4K7H59r282XNyVYWx2
 s2bBJQGMqzatsJ+/HlPBGcercN87Fnk6KzUzwnIkx93HOZMpxmwd7ORsw/+TWPapIrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539861;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=EdwRYS2qCEXB2UTtWrzkG+uvkzI2TnTUE2wYJ00k+uM=;
 b=jBr8A+B4spJm6S+ChT0myH9OPDJZ9BBAYemtCVGa1M1dJ0hvbpZMm4W8KBdnxvo4HuTA
 9Vr817jkxH+bTc7ycb1vIZe1Apl1+Up2awZX7SOmQvgo31EJ6N22RIdAL32QNYVCoIez2
 M92+rwp4DJebxLs00XEf6myXcAufhkzkwS6Dv5FkHBOjEiI+xyfjzutcruoHNF4QlBYTo
 wEsT9RSkFLvHbBeC/QOw2YiqfnlqKe6DMm71/NPmquV+4hGHsn5wF0TfN/FkFfnfpFx2e
 EGaI9pNusB9lkQDv5zZhr1z+mEFiLOFKbI+E5Ph3tHa3NRmjgGXpXpS+/oY0vrtk++g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=e0NmuDKU; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::8fae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::8fae; helo=smtp-8fae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=e0NmuDKU
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::8fae])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA011810E9
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j1MjY1zTKzqyb;
 Fri,  9 Oct 2026 11:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791539857;
 bh=EdwRYS2qCEXB2UTtWrzkG+uvkzI2TnTUE2wYJ00k+uM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e0NmuDKUdOA1bOM8R43toJQU7XVKV73CY5ZRhNwgIX8353jgjgXooSnRjOJG8XQcF
 kQy0VaxP/FybyL/K7Xa2bbXZy+eIddzuTjnj5EvZFUxKgtgki300qsWsxb89jTggua
 J5jT247840vVIGl+hUBecMCcDLMPIeHGkT3Z8pFRlGhLJkSiP0YTyfdghtdcCLaCOE
 XjflCONEirTmufkP9nDmurtmZlEL47Rl5IpIqEjcyB3EDTQiYSkH42PhU3O2SdvMRt
 ruz158BDXw+JYcmWn/jQyOVRhb7xpoto67eyl1tgyNC8SpmT5/3GyyAas+UIBOC5sf
 wN7yy+xqtwdMA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j1MjX09mFzF3n; Fri,  9 Oct 2026 11:57:35 +0200 (CEST)
Message-ID: <6729005a-3875-4854-b6e6-54d64d5bc454@0leil.net>
Date: Fri, 9 Oct 2026 10:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] rockchip: rk3568: Use fixed CRU and PMU CRU base
 addresses
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804214442.2592597-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 8/4/26 11:44 PM, Jonas Karlman wrote:
> The rockchip_get_cru() helper is used by the sysreset_rockchip to get
> the SoC specific CRU base address, and the rockchip_get_pmucru() helper
> is only used by the RK3399 specific RAM driver. These helpers may
> trigger a full clock driver probe to get the fixed CRU base address from
> the clock driver private data, something that can take several ms.
> 
> Change to return the fixed RK3568 specific CRU or PMU CRU base address
> directly to simplify and remove the unneeded complexity of using runtime
> lookup in SoC specific code.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   .../include/asm/arch-rockchip/cru_rk3568.h    |  5 +--
>   arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 33 ++-----------------
>   2 files changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> index d72f241d0150..e2dc3cda5577 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> @@ -35,7 +35,6 @@ struct rk3568_clk_info {
>   	bool is_cru;
>   };
>   
> -/* Private data for the clock driver - used by rockchip_get_cru() */
>   struct rk3568_pmuclk_priv {
>   	struct rk3568_pmucru *pmucru;
>   	ulong ppll_hz;
> @@ -120,8 +119,10 @@ struct pll_rate_table {
>   	unsigned int frac;
>   };
>   
> -#define RK3568_PMU_MODE			0x80
> +#define RK3568_PMU_CRU_BASE		0xfdd00000
>   #define RK3568_PMU_PLL_CON(x)		((x) * 0x4)
> +#define RK3568_PMU_MODE			0x80
> +#define RK3568_CRU_BASE			0xfdd20000
>   #define RK3568_PLL_CON(x)		((x) * 0x4)
>   #define RK3568_MODE_CON			0xc0
>   
> diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
> index 1c6b2ece602b..ccd98a91cd16 100644
> --- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
> @@ -4,10 +4,7 @@
>    */
>   
>   #include <dm.h>
> -#include <syscon.h>
> -#include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru_rk3568.h>
> -#include <linux/err.h>
>   
>   int rockchip_get_clk(struct udevice **devp)
>   {

There's no user of that function anymore after this patch, so just 
squash the patch removing it later in this series with this patch here.

Cheers,
Quentin
