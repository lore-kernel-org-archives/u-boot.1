Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38904CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34A6E810B8;
	Fri,  9 Oct 2026 09:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUTuFOFJTxMM; Fri,  9 Oct 2026 09:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31A7B810AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539855;
	b=PxOB1gVqPZoQNbIGAivOgDJPlR+z82SIiTgru1QG7PMP7st7PerPt5yvP0ZlF17VJu3P
	 gJEVN1iRLQ28exgMPJAy/PZ6otSm4nRGEkWhwVQaivxwEyyJuLDgtnxBUqmKJg3CRAFob
	 7VaFot8PqvHXY6I8knU+IinOKDZFMUZtfb6vprCSYuo+ku6u0OgHLrQek1NpI8JGHY6nE
	 tdN51GDbwe2Tr/9cflBJorbXGvTbHbIprHhj9rcLy5pNeChPvok8Bfw02c7UoZssFU5W2
	 bzEjILbEb+jtN3lEJyhgDZdF8hAby4oX/Uz5l740x6jMQmFM709m3Enb7vtmK3YXegg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cUGh4CZCkPos0/RPBeDYWEP/U8fC9tUOFuHBTAfGlnk=;
	b=LinWyrgH0UtTFwdgePFdaa31WRWBk+vasX0CS4GaYV7U7gm3LBjQIznu1vbqyChRKeeb
	 sYQ3GKwjup192wAY/GKVPLvoBsuv6MRTsHWx5gJNeIQr8DF/7NR9/X4dY/xs924vVWo3s
	 ynfZOv8QFMN1NrzM5X0xmZRFOSpSUyVkWPn6lAuTLUEZs7a+HPPnLaV8oHF/dPdPxBENl
	 ixeXYgE9EINi1p6+rb+cDtjM8sht+1aNSM2KWHC7k5bI9uNjCf6g9r+cIc+HWufA8X/D0
	 NYTvOyTGIQPQH6mVDwZ+qF9rkUkF/khwrhwsUgdMY9LEM51p5f9QTVNesRi87i+ksCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=MP9lhVcJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539855;
	bh=cUGh4CZCkPos0/RPBeDYWEP/U8fC9tUOFuHBTAfGlnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1ZVF0hMOHzyiDOp+Eeb4VIb0lsDiJ06nA+Bd3huWObFH8WsfmWLf0j7F2XmcILSL
	 bcoZx7IfHTy2jnrBVKWw+U7FpgQ8OR4GD+D480K0UdU8FP4O5M5KmusPfLbZ6zbPw6
	 IIFC385kxpQZi0UJFfqirZ5UpChUmYNoyTonYTTxUSHpFhqUlK6esTMeAV5R/jks20
	 KSkKyGmM4dmhW5idQOh2qrUmo0MaKFgZef6l5Z0xvMo4qG+SbYfi+DDy53vyBl5b95
	 f9WSCLMYlPuceRnafpflqVKOlhAvm6iHR2spAnzNYn+uyKUF3bL3ivbIm1NXAx1Whp
	 GNcYHPoqMZKbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31A7B810AE;
	Fri,  9 Oct 2026 09:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF7CF184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D54D0810AE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cd1GwugbOj8M for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AFCA810AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791539853;
 b=iIZKsMdR/9hkGBVcrgexHoxZv8Pv7jfhNKIQEBlGHE7LqcaM2Hym7thn5qBxeLvAdkMY
 bxEHYmUMXE0nChDU1QZKsaSjWF5e4TO5dkUu49C3UeYD85csR1LKa+sFqUIU0B7mZPwxM
 DHKzXgVfC5m217mSNNK5IkbcuES6vxACHEZgMAFnqZdTmlVxdWtj9FsrQ+e1Bq/rFQWbg
 SBV/ATiuSgnODgjXujl+p/FqmZPnL9ax9bzjbyHUjzRvV2GS4U9Sm65fQu7d7DATt4kPA
 18QqizfUT0EIH4S8H5hwf+A6/wX8eIzl34f8gA5W78RwHw4aVNKL9/Ym39nkIQuS4TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539853;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=cUGh4CZCkPos0/RPBeDYWEP/U8fC9tUOFuHBTAfGlnk=;
 b=IZojyWdIg2Gmg0hOpe+1si68d6xEeqypFV6z9IFC23wDZKagOy6BCjhNKXcgpfvE9qfv
 1uQcIr+b/oLjh8ykYGXf8qzujSWSvIO6F/oIORlg2rfxg8LMdueSl3DpVkk75MoouzBGt
 cxzTG2epHIoMoFGK/FEhacme4yGOawh7dOEJjVUsVjxnPZ/NkCZ920SnjIIyc6glUtBNm
 j4HFMg4RLo6Fm8zpKFBAynJqJM+xTMA/EouKOUtlFMiCvcRPUATDnS9wNzMqkSrylK3KZ
 2bZ5A7OejNwoV9vh/3/ohQWoqj+2xbXJYbTNU3Hh8/fFQBLTwZ5GeqES5hHOSMldI0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=MP9lhVcJ; 
 arc=none smtp.remote-ip=45.157.188.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.10;
 helo=smtp-bc0a.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=MP9lhVcJ
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AFCA810AC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:31 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j1MjN00wLzrXZ;
 Fri,  9 Oct 2026 11:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791539847;
 bh=cUGh4CZCkPos0/RPBeDYWEP/U8fC9tUOFuHBTAfGlnk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MP9lhVcJIENkkgVl/HqrZlipEiXa4+VzySrWQNuwQfSuUIE02smn/KPLJtd1WmGgZ
 JECqKtDhBnBI9XGj/bKFSUqAY5lJ/o9OZoECAMBmVv1jbEiZdGA87VT8HxsQyMwRJe
 HwQ3Uk6g7KVnhgGhjoCfy/QZjrNp0n/DPEOAOQ6rWAhkqXr4oVjXSHnFm17tU/fyJ4
 CuavhW3uu6jIM0zqPyAvHoiHT7WJ7pmmuQzKYvBA6s9P1Q7ofEsGvTr7gW/D12cNY2
 E2T2napMmfmjP+GbRjd0q39ikHo1hOZPZCYedUM4weIr7jI4pNewfHTtegVA1vkUUg
 sTviPs5RauMzA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j1MjK5M7VzSnk; Fri,  9 Oct 2026 11:57:25 +0200 (CEST)
Message-ID: <a3367c8d-6352-42d0-87d5-e325652fc225@0leil.net>
Date: Fri, 9 Oct 2026 10:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: Remove unused rockchip_get_clk() helpers
 for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
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
> This series takes the initial steps to try and remove use of
> rockchip_get_clk() to get the clock device or rockchip_get_cru() to get
> the CRU base address at runtime for the Rockchip platform.
> 
> This series is similar to the "rockchip: Remove unneeded syscon driver
> for RK35xx" [1] series, but focuses on CRU instead of GRF.
> 
> The CRU base addresses are fixed and known at compile time, yet drivers
> keep trying to resolve them at runtime delaying some operations by
> several ms.
> 

I would rather use device tree whenever possible, instead of relying on 
hardcoded constants. Considering the contexts in which 
rockchip_get_cru() and rockchip_get_pmucru() are called (that is, in the 
DRAM driver will eventually be called only in DM-less TPL so cannot rely 
on DT being present to fetch CRU from it, and in the sysreset driver 
which doesn't have a description in the device tree), this here is 
acceptable to me as is. But we should think about documenting the 
exceptions to the "please get the info from device tree and do not use 
hardcoded addresses" rule. A problem for later :)

Cheers,
Quentin

> In this initial part the RK3568 and RK3588 specific helpers are updated
> to use CRU base address constants, similar to the other RK35xx SoCs, and
> the rockchip_get_clk() helper is removed for all RK35xx SoCs.
> 
> The changes included in this series have no intended behavior change for
> the affected RK35xx SoCs.
> 
> A follow-up series will introduce a rockchip_sysreset_bind() helper that
> passes the CRU base address to the sysreset_rockchip driver, drops the
> call to rockchip_get_cru() along with implementing the get_status() ops.
> 
> [1] https://patchwork.ozlabs.org/cover/2280781/
> 
> Jonas Karlman (10):
>    rockchip: rk3588: Rename CRU_BASE to RK3588_CRU_BASE
>    rockchip: rk3588: Use fixed CRU base address
>    rockchip: rk3568: Use fixed CRU and PMU CRU base addresses
>    clk: rockchip: rk3568: Use fixed PMU CRU base address for PLL access
>    rockchip: rk3568: Remove unused rockchip_get_pmucru() helper
>    rockchip: rk3568: Remove unused rockchip_get_clk() helper
>    rockchip: rk3588: Remove unused rockchip_get_clk() helper
>    rockchip: rk3576: Remove unused rockchip_get_clk() helper
>    rockchip: rk3528: Remove unused rockchip_get_clk() helper
>    rockchip: rk3506: Remove unused rockchip_get_clk() helper
> 
>   .../include/asm/arch-rockchip/cru_rk3568.h    |  5 ++-
>   .../include/asm/arch-rockchip/cru_rk3588.h    |  2 +-
>   arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |  8 +---
>   arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |  8 +---
>   arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 44 +------------------
>   arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  8 +---
>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c    | 23 +---------
>   .../jaguar_rk3588/jaguar_rk3588.c             |  2 +-
>   .../tiger_rk3588/tiger_rk3588.c               |  2 +-
>   drivers/clk/rockchip/clk_rk3568.c             | 34 +++-----------
>   10 files changed, 18 insertions(+), 118 deletions(-)
> 

