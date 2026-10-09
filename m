Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E778CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A10040880;
	Fri,  9 Oct 2026 09:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ee51y1uonpG6; Fri,  9 Oct 2026 09:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3AAF40885
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539869;
	b=MLcxI865z/Yf1ik7iqmd7JsbmV9JpGfIBD26a9x4ftXxHa5TL8Epo01p9oyy0glmuwBL
	 gOVw8I9zKlv1pec5N4p2EI+f8S8k6YKcv83DCZsz68UjgtEtlWLyrRHpqPB0o1q8HXX8E
	 Xuj5haYxLV7/ss95I9rR/6gI0yJVIF5SdSYlfp4H5T5yqXEp/7RNSSDOUG216DYtR503H
	 8hu4OAFRbZWkrqlF8z4uOMUdZPcBcgf0UVarOg2zYBC9pnp7HEfdvucSAvypGj/qAQKUU
	 naBiPeWdhZScjxQBIkT7AAq/z7fQFCBv7isrM4ysMJ+AAhWUwJwTq777/RaB/cM6WmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7zI/cEL8gZ4PhnZ3nio0kIlghZWwXFoJ1DDBGcXhq7c=;
	b=HekXN6nO7klWumjtAPD2zBw31M+y1CjYrSYgeQYD4ARZhpyTbKxOTMEKhuwcuoplpazq
	 FcM3XyO4lv+WTfeo5ZxySalAHQoE/MgprsMy798EtHH32pZ1QRifhcBXu3svUHi1BeNID
	 8lwueALyn+Jf7020wCV7HxxGxVrJ5Y5Qn7LES8Tci31oaKWfF2PVdhAfoi/Zg2ka36nYP
	 On4u4Meqfi0jGiy0PFP9+4/Mnjz1UMrdR14NGt26gidXFoFfjlCtVQT6jbpTDINF07NFb
	 5yp2LzdcHIv2KF9Ds+FWv+F/K4as2kylF3xClU2ZRG4DrNqpTJHajaX2x8wyIhMk/sQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=nAtd1Vkv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539869;
	bh=7zI/cEL8gZ4PhnZ3nio0kIlghZWwXFoJ1DDBGcXhq7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nswkHBjvxKTjt/A6JytBWtSM2b+69xO3+LnM8jCW9vYdtZLG1FHZaavKfaj5UG7q7
	 zyZ2mCOCTXS97yH+OYlqkv2KHFBrPZIlPk/lbjNNF2ZZw+wZqq1qo8vBbpi2h9NsO7
	 7Slr5b5FL4nCrM5Jng2FsfqEg6cfRee76C7ONVnvBXVMMlJqJs0DOwCAf28Uu2EqUY
	 ++Mq6i+YIgS9V95/yyUfou3QWQgxwG9DU1IZyZolJqUq2No30bzh7BzwcAdmYU+w10
	 DcmafM2MLbJM8LllrzdJyqHyy2vg3zmo6vlkZjndSMdc6ZmHAlW6lra2JVzel+y2L6
	 XFOJ0pWat7zGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3AAF40885;
	Fri,  9 Oct 2026 09:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14086184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED7E540557
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8ul8eWpldbj for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDCF640880
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::bc0a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791539867;
 b=T/p1wzjKGX8yILAv1hhs22D2/zL8QkBLwk4dkpUfnNtCnEMJNBdOYIn4aCW52MMW1mw8
 Fc5eJJPQ9wBcSJz26fgaZyHPLbmgty8ePVqWhzHTK8GtxAlWZww93FBgACfqChpCA3d2b
 RFbri4UXtIlqL2jZkpod6WLp2cKe7H55Yvlg0sGWHUov60dWpc62X5qrds3txzeO1XrCt
 Nn2bLzoBETEUopIq7rUb2Nv9TYCNLp6seOov+kex5iWBLKHIo+1w7amfVDbEb7jcZ6pPe
 C0GK2IDuSuVLLBnNYXLqZmerZ50O0lbjTcpnYbMYqE6xHYAU7161eVnhxU/RcIdBHWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539867;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=7zI/cEL8gZ4PhnZ3nio0kIlghZWwXFoJ1DDBGcXhq7c=;
 b=jjLXqlklZviRIBNQfgPf6sE87xD/nY1UeEx/uyiksaq4sq8GTazzfw9wxa7h0Bb+qjBh
 0tApRqcDPHvhilq2z9sxW6LJwgY+S2HznPGxdr4sBRRUGvGchldUZ9HgTLWvYMqnqehIU
 lu3jPoJXgssCcFWNEma8GA7Wd64EpPMkw9PAmxP3dtyZguO5ote1+0Vb4KvOCzDzi2SwT
 Y/wuRd6T7zVf8GOpq2CBH7OI+Gr3Uu1Sxz4KwP8XBQCD/H+d66FTF6SQFHb7G8V3Hdlk+
 4a7L8Lb8itPwrMinK0e3Z2IzdBAz7VJZgm/vwXqbpk9QoxtPspIBwbty7pE+RAXUM2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=nAtd1Vkv; 
 arc=none smtp.remote-ip="2001:1600:19:38e0::bc0a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::bc0a; helo=smtp-bc0a.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=nAtd1Vkv
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::bc0a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDCF640880
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:44 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j1Mjf1ykyzq0Q;
 Fri,  9 Oct 2026 11:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791539862;
 bh=7zI/cEL8gZ4PhnZ3nio0kIlghZWwXFoJ1DDBGcXhq7c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nAtd1VkvZYOhqbWk16jf8H7fyeatGuPLavF9DioJoVfvDi5BVUpyTrBNd8ItryIyj
 eZt0ZaTJAlmbPdcwB8jzw+V523bx6mRkEvJrpAh3vLks/vnuXKhalCRBO8YwUMs3xB
 COGJvNUQDAB+72HQUK8ZEs9Gc1MMFTYIzEgbjBtHXmbczcAGF23ED24SB2Mmb45omU
 IbvOxUowb6de04lsMXEzvmpvoC0Tgju6IpYlXbNzwlt59moYYdSOIyfa0LrgYwmZVM
 dXLKVq3ckNqVaX1rGaF5QmxU1fwgN203NiUe5T040FE/Tdg6iep2AFYjKe6UfE0I10
 qS3uHaBk0WiZA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j1Mjd0slzzFLw; Fri,  9 Oct 2026 11:57:40 +0200 (CEST)
Message-ID: <af324bde-f2a8-4425-8d57-944ae5567c84@0leil.net>
Date: Fri, 9 Oct 2026 11:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] rockchip: rk3588: Remove unused rockchip_get_clk()
 helper
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804214442.2592597-8-jonas@kwiboo.se>
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
> The rockchip_get_clk() helper is typically used by SDRAM init code of
> older SoC generations or to help get the CRU base address from the clock
> driver private data.
> 
> RK3588 has no uses for the rockchip_get_clk() helper, let's drop it.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> index 9b112e45f1de..272d28e973b3 100644
> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> @@ -3,15 +3,9 @@
>    * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
>    */
>   
> -#include <dm.h>
> +#include <linux/kernel.h>

Why do we need this included now?

Otherwise looks good to me.

Cheers,
Quentin
