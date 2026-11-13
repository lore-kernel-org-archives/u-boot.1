Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EF60A6F57
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=adwmU00T;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=HkyvxoMZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90376409AF;
	Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67Qp35LWs_YO; Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2FCB409E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794588032;
	b=BBI5g8jgjge0MQ3uY56JXag/hlOW4RaSwj+HBz2s84ONn/ov5BYMIzCBblDAEUzslmNG
	 MtRwK2ZOwH36O7hmEyavmqvZbloYubN4tUD4lRw10RYx1tlWMWsw53jrvcll9e4g0K46z
	 H7GKRj1pvu8R2TReZts26/rse8/SGroA+DAts66XlahbkdGEcaQMUaVQAQW1cX63Gi1rw
	 llZKaM+JUow/OS27Kcy/IjgOiehit1zelJ+nw9GgYpqfOGtQHd6to2xkuxyZUaXhmkbzv
	 eJTy36V9cqckBm0NDx+YQ/DHFYky0Ny/xLNmdn6vGzB8Reg7zyuQ6Qv4l88Dijm9cXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A+ur0QVpFHD7ADYOqG7Oc2Q6L1cIJ4+1UL2xoe2aaz4=;
	b=gM+RfVA7ugbGi8r0wcfxn+7olkxs6c2HBUkweSyzOPx9ax07EH5Raf9Kz+MUc2QVZK1u
	 pVmYP1kLyRwcSYJE4PA8q25yNd/FkHI9194WDi3mX4m0nljBnKoPEkTivlnMMgzxGg9GY
	 76lhQI4vRLK/f61QYCmzT1tszJq4MpJ3ihXH83NI0KH6dVOO7Wy2kkGQAM57MwRorgXyy
	 6Rf9xctWZZRzIHrOPAcK3aPwo4N2mCceJ0HM/xZzYEKEJE+Mw3qJXI8eQzf185AM8SobF
	 7XCM47sQTK06AletTal6aN5/I4PNajlcP87eJltrCnlxxPAxm19yCwEPv8OF33aFx0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794588032;
	bh=A+ur0QVpFHD7ADYOqG7Oc2Q6L1cIJ4+1UL2xoe2aaz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adwmU00TIGiQTN08e4bFAbYguf6SbaJun65mxwd6twWbk9eyUGmIU04hZTjw9JdPE
	 QUFCejsy1X0kZJIPxeQFPJxStHuLfR5usCzuXcR5i9sx/XBZIiMNIu3X+l8R1SZrqA
	 I4Vhk2bkpbZVtnK7QYbm0W+jc1FyZ8YeM9RP1t2LZ/oGw+0jrABZMRuKW/ZY3AShzL
	 JVyZGJQ3ul/ssl7k9+EFR+WpkIkSiy0jXvjb5GiUXlE7/s7ODpwM1mVk5EKJQte5Or
	 2Yyn2vAgWxKGrJ9BhwwHLPxa+AmDV92PGRuTHbIASkVX92PxJy8PleME7nm4vZEYOa
	 eulkLM9figg3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2FCB409E6;
	Fri, 13 Nov 2026 16:40:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A62D235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87907607F7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YcKA-GsDawT for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6000160733
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=83.166.143.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.168;
 helo=smtp-8fa8.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=HkyvxoMZ
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6000160733
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:40:28 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR30C1lVPzdsQ;
 Fri, 13 Nov 2026 17:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794588027;
 bh=A+ur0QVpFHD7ADYOqG7Oc2Q6L1cIJ4+1UL2xoe2aaz4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HkyvxoMZwYwiMUZ3E705oUWi5D0xe/C+91BZFGylhMwAtixxMZWbFEMiDx7drxsOq
 Pm/bwAsf3L3Wbstl7VLYSlTzWbB1wXEG+C+lbs3aLT+sNBMkZnurEQzOGndds54HZl
 Dmu4dPomuaw2R/MBA18UhRI+tnaDdRp4bcT80Uq+9z/IL2cRUodPg6DjqeHyCjk1i0
 9NUiofDXLbWozxEUZOGuWCDH1VuQZF07pENYZDYRet/Un9tyxlEduLydiX+zZQd3jR
 EkZE0O78cQ0+MxZBcrXavbF9nqk5tplTxLb4k+ElZsskWn3Ij52bjb41zirn75VYC1
 UXY5lHCaz5paw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR3095RPqzMGZ; Fri, 13 Nov 2026 17:40:25 +0100 (CET)
Message-ID: <ffdd97fa-13f2-4488-8d66-193f01ee029f@0leil.net>
Date: Fri, 13 Nov 2026 17:40:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261111222834.157842-1-jonas@kwiboo.se>
 <20261111222834.157842-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261111222834.157842-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/11/26 11:28 PM, Jonas Karlman wrote:
> Use 64-bit arithmetic for f_frac << 24 to prevent truncation before
> division when automatically configuring fractional PLLs.
> 
> This closely matches the vendor kernel implementation.
> 
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v3:
> - No change
> Changes in v2:
> - New patch
> ---
>   drivers/clk/rockchip/clk_pll.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
> index 74b7ff5faa03..5cb0e954ba4a 100644
> --- a/drivers/clk/rockchip/clk_pll.c
> +++ b/drivers/clk/rockchip/clk_pll.c
> @@ -114,7 +114,7 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>   	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
>   	/* FIXME set postdiv1/2 always 1*/
>   	u32 foutvco = fout_hz;
> -	ulong fin_64, frac_64;
> +	u64 fin_64, frac_64;
>   	u32 f_frac, postdiv1, postdiv2;
>   	ulong clk_gcd = 0;
>   
> @@ -156,10 +156,10 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>   
>   		f_frac = (foutvco % MHZ);
>   		fin_64 = fin_hz;
> -		fin_64 = fin_64 / rate_table->refdiv;
> -		frac_64 = f_frac << 24;
> -		frac_64 = frac_64 / fin_64;
> -		rate_table->frac = frac_64;
> +		do_div(fin_64, (u64)rate_table->refdiv);

issue: do_div casts the second argument into a u32 anyway.

refdiv is also an unsigned int so u16 max, so this won't do anything 
anyway. If there's an issue, it needs to be fixed also in the member 
type in the struct.

> +		frac_64 = (u64)f_frac << 24;
> +		do_div(frac_64, fin_64);

issue: fin64 will be cast into a u32 even though it's a u64

I think you want div64_u64() here instead no?

> +		rate_table->frac = (u32)frac_64;

issue: unnecessary (and incorrect) cast

frac is an unsigned int (so u16 max), therefore this is misleading. 
Also, the cast will automatically be done by the compiler, so we don't 
need that.

Cheers,
Quentin
