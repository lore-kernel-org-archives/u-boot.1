Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9902606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lW9YwG3w;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tfm6LMny;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=qC++5U2A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13AF04075F;
	Tue, 17 Nov 2026 17:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZyQodn9K-IB8; Tue, 17 Nov 2026 17:59:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B6EC4058B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794938384;
	b=Fk3MCveCmrAi7kP6chu5kTL0MmUCbDO57Zv5PY3fVX9gOvhZDefz8l5JiBoosDj5f5OB
	 2rtD2xSyu5ZosOyFMCJGDnfEtlTNvtiB02Ve+Q6KpdsInwtXCKhhPa7gyoK6rG1K5EqkV
	 rpEAuvZtL1/PVbVeT6I6S24cvfzz6FJPQGG8NR41eMZnjKlGwqGSVdzIfutqGWc+HZjlr
	 8SMu5O4dEvWfJRTRaUg1TyV7JpkRoXcCfcNyRKBmRzrII3bdYPnFySrcahlj3po+mpWMQ
	 Y8iFSxeKurA7gAaRrq8eczKJ4TQevlIsAG3BOOgNPxJ4F4NXQKrJ5Z7SFuG2VNy6ArQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jbjcw2wghoeNc224PzZstPVSUnhcpLCuJt7uEyJ+d3A=;
	b=UJft3Zoz5xfbphWCmF20l5OrpDAkV4ucReigh4XH8LlKoW9XJN2xhYd1natfgr7TtdKn
	 9k0aVnwW3q/YgPVicrRLZgoOcIUIsphbfzEXmxVAzbwcl9AfcV99l+OK3Jy1RZK7QcBg1
	 THJ/eLEFr9ursMy7FE0HfZIfLmKCjEc17VA6InbCrcxjqVvPDqI0ohp9kCciJYUw/R87T
	 TytqL/1Tq167geD9dDFY4myGLenYfduZsgtT1AGC2hS3Xh+eCBmJa3+icmVZHptUTGp7E
	 oTFUeqRLHi2JeYy/vhBHEpNOTuJrgyEUtXt4QtBXPGG+gFW5mWo//BnjvvQ4URLZPiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794938384;
	bh=jbjcw2wghoeNc224PzZstPVSUnhcpLCuJt7uEyJ+d3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lW9YwG3w0L56BS866vxzRqzIfK7vtkjFhtVEwor7IRGBgUCsW+w23yxeXrfhq8l3m
	 poxhmb/AtMB5z5NAJ+Brr7dnj+9ybz0KzGLD9zq0bIvTdAlo+EoVCRyLMyEjEyM1CV
	 nFGzKBB7HGAs5RWrDAGY94RKkiH/SHNAtbFoNXjUeyQ1xFm6jWC3ryNz24CV21exUX
	 UGMK+YXfHnCufQXO4x5CY/48lOwH+iVF9A1y68DjExAY11sLoKajePOhReKtJyR+JM
	 SnnWsPTYqHwFqDOY6LKCYDv75dc9OmHyv4oVfpsWzhyVna2poZU9TwSi3MI7wtk3Nh
	 UE+EkSQRP3SWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B6EC4058B;
	Tue, 17 Nov 2026 17:59:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D51149B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EE6181140
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7PQqhk52t1U for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 17:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C9B18113C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ff8=jh=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tfm6LMny; 
 dkim=pass (1024-bit key,
 unprotected) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=qC++5U2A
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C9B18113C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1794938378; bh=jbjcw2wghoeNc224PzZstPVSUnhcpLCuJt7uEyJ+d3A=;
 b=tfm6LMny/E2K/4U8wb8CYs6K2CND+oZq3/4IICAq4QVsg+MHYS/svyzOaI84kj3pX4c1pPGno
 HH/3S3Q2HB54LPNoaiYKmYnfo35H1uI+uPn6rW2xWuKvHv6UMuTi9MrxUTeiVX/xQOMI7fORJJi
 FTC0ZnZtANn/y5n/Yijai0uPULe8CIBZH7I+FGPQp1C58GFLQSE5fif5xIcJZlWGJJ08V8B3j8o
 C7d++O5/I7ziCYVml/5+NyWYQXj1d8PIjLDAvsqO9atDktAvGjspfbGId9BaGlKO1OZyQjIqeQ3
 24MSwDd/4w/CEXnutOTm4BK0uaZiduiqj6iL3t40bpRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1794938378; bh=jbjcw2wghoeNc224PzZstPVSUnhcpLCuJt7uEyJ+d3A=;
 b=qC++5U2ABL58xCJ4ZPp5s2lqD+zOBM69bTAndaQozmS6wo2h7GBEHWkczQn3P94jzqnAZ0Sdp
 Dh3tlZQSM9pwPnqkFeJxWBIXPw0Ntu7M1H63NPimz3VtNi2reFj4WEXPqsqTKScGwTBDak+BJm1
 5wnK1bbRrLMRSw1a6YiHQQU=
CFBL-Feedback-ID: 6afc96071ef38157fa77a6b2:35e5c51b7ff0abb83da7a4fdad8d94b9
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6afc96071ef38157fa77a6b2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.27
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
Date: Tue, 17 Nov 2026 18:59:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Quentin Schulz <foss+uboot@0leil.net>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/17/2026 12:37 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
> lookup the header file to know what exactly this refers to.
> 
> Use new macros that reflect the names used in the TRM.
> 
> No intended change in behavior.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
>  drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> index 9ddd6215fc53..331b100ced54 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
> @@ -48,7 +48,9 @@ struct pll_rate_table {
>  #define RK3506_SOFTRST_CON0		0x0a00
>  #define RK3506_GLB_SRST_FST		0x0c08
>  #define RK3506_GLB_SRST_SND		0x0c0c
> -#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
> +#define RK3506_PMU_GPLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
> +#define RK3506_PMU_VPLL0_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
> +#define RK3506_PMU_VPLL1_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)

Please consider something like following:

  #define RK3506_PMU_CRU_OFFSET		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
  #define RK3506_PMU_GPLL_CON(x)	(RK3506_PMU_CRU_OFFSET + (x) * 0x4)
  #define RK3506_PMU_VPLL0_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0020 + (x) * 0x4)
  #define RK3506_PMU_VPLL1_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0040 + (x) * 0x4)

That would closer match what I had prepared for existing and have
prepared for new SoCs, i.e. RK3562 [1] or RV1126B [2] ;-)

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/arch/arm/include/asm/arch-rockchip/cru_rk3562.h#L79-84
[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/arch/arm/include/asm/arch-rockchip/cru_rv1126b.h#L90-93

Regards,
Jonas

>  #define RK3506_SCRU_BASE		0xff9a8000
>  #define RK3506_PMU_CRU_BASE		0xff9b0000
>  #define RK3506_PMU_CLKSEL_CON(x)	(RK3506_PMU_CRU_BASE + 0x0300 + (x) * 0x4)
> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> index b0c9f311461a..ddfb96ddeb36 100644
> --- a/drivers/clk/rockchip/clk_rk3506.c
> +++ b/drivers/clk/rockchip/clk_rk3506.c
> @@ -58,11 +58,11 @@ static struct rockchip_pll_rate_table rk3506_pll_rates[] = {
>  };
>  
>  static struct rockchip_pll_clock rk3506_pll_clks[] = {
> -	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3506_PLL_CON(0),
> +	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3506_PMU_GPLL_CON(0),
>  		     RK3506_MODE_CON, 0, 10, 0, rk3506_pll_rates),
> -	[V0PLL] = PLL(pll_rk3328, PLL_V0PLL, RK3506_PLL_CON(8),
> +	[V0PLL] = PLL(pll_rk3328, PLL_V0PLL, RK3506_PMU_VPLL0_CON(0),
>  		      RK3506_MODE_CON, 2, 10, 0, rk3506_pll_rates),
> -	[V1PLL] = PLL(pll_rk3328, PLL_V1PLL, RK3506_PLL_CON(16),
> +	[V1PLL] = PLL(pll_rk3328, PLL_V1PLL, RK3506_PMU_VPLL1_CON(0),
>  		      RK3506_MODE_CON, 4, 10, 0, rk3506_pll_rates),
>  };
>  
> 

