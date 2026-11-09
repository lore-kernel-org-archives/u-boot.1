Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DC606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=szfvhnjy;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bgSAhsMh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDF6F80F55;
	Mon,  9 Nov 2026 21:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEq3iukVJFso; Mon,  9 Nov 2026 21:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2725A80F6E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794259411;
	b=Cn+q71rvBHv5tOylrZnYenYcP8GG8UCdB6XceUOlWSiV/p2EdNPPhjOFFnkrKbb5y5k/
	 qipDbBJFtcaBT9Cywnejj5Cd8v3Elt1wS+scDD/A+78CTiU3kIsJNjV/il3XuZEhC4tGv
	 ZusLp9Tys1iBaE1qsPYaI7jvfnQinOMZUhVmr0RJTpVIxBeNKKkq0B6mfAzxDgACbZO8n
	 dWcjsbNvChTRGfQc1MxGtjX9FbJCqaeAluNV0nkzhKwqZOIZEnbCX+M9z/QluALSMzIIF
	 /PhSmSUtMQun8OXFyf1mWOGS3TsQT8nvsZIKZyjc05z4CqZhPVBoOqZ1MwtO462vQOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794259411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ajDqoQDxeibzw3mMhgG7XzlHELZFkvPp9DoM/3pZvdo=;
	b=ewAoE2Xm+dxklKhd/Xh0EhG+a4US/o43UoTJuahIElNF1fuEi69v/XR7YmvHUCPAXSrC
	 mvkSC+qOxD8opivT+eB11KuZLc4X4IEwMGTocMTl7wLpYq75f9/T0nicWuc40mNOnoLgG
	 9Ui6Rq5Hu1Y1nh79JJRRR9dI6ekOvCYph4cYVcMgvDa3zcuNqcbaK41BKLihfQjTlkeEH
	 qgTVhFdoFJDj7n5Y1yE1j8WBX6a6ayL+PfFXUYIXr0wOYqZRbB8MR34v/2blH7FKvKMY/
	 jVdZoMV3TQWikJ6zEqENy+8rFNv0FvUOazX+KEPAb2a3MuTxCH/Ni9Uek8ij92/l/1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794259411;
	bh=ajDqoQDxeibzw3mMhgG7XzlHELZFkvPp9DoM/3pZvdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szfvhnjyPHCrsappjutW1mqjh3uOV0uL0RJ+dLbSgu2IyqH2q9SIhBD/Uw/J4IzNx
	 BhFclwclpsH+KCrnPZ164rGIVkKNP3s3LAkxcCgIEvwgo9D3/n8Hq9oXN/oSJUArlO
	 KW9MyPjRXW01p2eFUqJNHlHMTi3NFMP/2O75pgUZNhN3e+pY02sDQTyerOn2cqwcR3
	 3wr2BLX3WH20MasyuQ0/3nubf1bLkbHlUWllGj78e5SCrsBAjFDFFHK9bry3uzf865
	 YdAm2I0M22WFEkcNk9BEG1KKgjU4Hv54wHfbmav0g1LFkUInotVTfMHVuh60Bis+nT
	 DUqObtasF5iYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2725A80F6E;
	Mon,  9 Nov 2026 21:23:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4CD8AF2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA9F3405A7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEFxA2iIEAPo for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FAC1405A2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bgSAhsMh
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FAC1405A2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:28 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6f74f6b46abso522939eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794259408; x=1794864208;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ajDqoQDxeibzw3mMhgG7XzlHELZFkvPp9DoM/3pZvdo=;
 b=bgSAhsMhBiCje0aOOinBqj1lx5LrlJS3zo1LSpbcTK/uMhRAAk6n4OTi7VYsmrnMTT
 tnB12wPhwabnXvQzX7qy/stT1Ikq1FeuRsUU/UZynjQYmQiJ8akdLWqLWLAevb6nrabS
 Dtxsuao/oZwXXW5kuNwckJL3lRyJLyBOj/4rjBNW3/jLiDmOTm6d6f14JwsmGeOFxop9
 PoXyZpdXcyfwivOyckmobuDsEqzovtquTrhfkwTD5qSAN10FaVxaN/zpZoz2Kimzbpjp
 UbvLdg1EF9q6rSXo6D2Ez7+Cx+8PRC/oYnYZ0m0c4TqwRD5QEPbTk0Cpj8GaBUiP095q
 1BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259408; x=1794864208;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajDqoQDxeibzw3mMhgG7XzlHELZFkvPp9DoM/3pZvdo=;
 b=N9oWjR+018h0fWEq5d6z54AcojZ8KegoIGTntfhaAtGmAjZID5iRYXTHoxQ2oRYuKH
 eq6hfwjxLUpcE1np+TFRnyeAsdC6e/V2nY7rF3l14NXBREqWYttzq4WIYSs8682fiU15
 G1x9GlKU7m6dDj6cy2hJfkURgjxhxUm1WuN8yJSwhpGEvWTd6p5aVexogESFEx7JXQ7M
 z5k1mZuaRMkn7BLzQPx0sLVBI3bc0+M2wlSF8b735oTylAFDM5LHHgVksHWlPn4Ws63r
 bhBHKaXTh4jUe9cfNp2G+IupcX0BvavVML7nuU4E2DzO1oYBfUV8NBrpbxrNX3fCk6qu
 7XGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE2/3hHNNIrTvZElKY/pEWGYqube1C6vgC2iaV+VF3hYgXYcGYpcduoWJpOAvgR4bwrNUdyXlw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ls7JWHAUC8yGLg5Zuro+GcURV+VTnyVueSFu3VVHHuyvJrSPp
 +7S16752pn2WLSLQbxb5IKujAXM+NXGS147m3kSqvlNeJmjfpmdBDmNUlCL81dVmQLo=
X-Gm-Gg: AYBFou1ZKhJxwGG5afEeUuocJjnCcRtLwc3lubHerGMBZ1PTby1CjKs/5CPU3LRd7D2
 2YLoK4wfc95UUUIaIJFwMYuhas2q33NgVPK1fTDE/4Y4sSS7/AEG+vg2kFbIaYiiTvBx81F5w3y
 pP4p3U/m5g6nOx1C/Z1bSk2gnOIG/ABL+8kBJ4m+qUOuIHCWbPvPK2sr//9bp9sfw0ux78o8LVK
 UACudsq6ltVBwhSjX4fDepjW27tZQkgyfuIxx9ENvnUqJCcPr0bw0fWoKTLCVU6Jh+PXxElHXkM
 Ny7xNTsNEpqFDYLnKHtegWqES+3sJBTwmIRKGhm4WIP0soB4GsruzuGHIG4wJ42argNtBeG3h3m
 nxE8sdsc5V+qhsQrg8VAk7tOIVGEdE8KGjwAosJ+06dKC1WZdghCfP3nKhC6CzShP6dyl7NeMpt
 vB6uqhyNmefmCs/AvtvJZ5EWCGn6H565HTKJPMOCZmKCI2JfSyCIKYAF73wmBeuU5XxACJqggZ0
 GBLzEwCaLbdxtTELlaNCpKU51UAftwnv6vPaD7gQoxQTtF90i1wgsXv60DNQQoloilObIwrmURj
 LoQEkhAaBdRziNd27IQ28Pve4Zj1bEOcibY3ZMWeXIFVpwdmdaYA5KVLFwKvZdg8BH8jc8X8M9j
 tPw==
X-Received: by 2002:a05:6820:c2cd:10b0:6b7:46fc:1dc with SMTP id
 006d021491bc7-718a683de37mr185360eaf.59.1794259407705; 
 Mon, 09 Nov 2026 13:23:27 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a9458d1dsm234258eaf.7.2026.11.09.13.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:23:27 -0800 (PST)
Message-ID: <7a142599-6c0c-4656-b23a-bf339f40c4b1@baylibre.com>
Date: Mon, 9 Nov 2026 15:23:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] net: mtk_eth: an8855: fix bitwise collision in
 RX_CTRL_8 register
To: Mikhail Zhilkin <csharper2005@gmail.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-2-csharper2005@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261107142441.2104669-2-csharper2005@gmail.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 8:24 AM, Mikhail Zhilkin wrote:
> In an8855_port_sgmii_init(), the bitwise operations for
> the AN8855_RX_CTRL_8 register contain a shifting error. The code
> attempts to set a value at shift 16 (0x200 << 16), but subsequently
> applies a mask and value shifted by 14 (0xfff << 14). This creates a
> bitwise collision where the second operation overlaps and overwrites the
> bits configured by the first operation, resulting in unintended register
> values.
> 
> Fix the shift offset for the lower bits from 14 to 0 to prevent
> overlap and correctly apply the exact values used in the upstream
> Linux driver.
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  drivers/net/mtk_eth/an8855.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
> index a2589a2ad31..eb037ec1382 100644
> --- a/drivers/net/mtk_eth/an8855.c
> +++ b/drivers/net/mtk_eth/an8855.c
> @@ -627,8 +627,8 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
>  	an8855_reg_read(priv, AN8855_RX_CTRL_8, &val);
>  	val &= ~(0xfff << 16);
>  	val |= (0x200 << 16);
> -	val &= ~(0x7fff << 14);
> -	val |= (0xfff << 14);
> +	val &= ~(0x7fff << 0);
> +	val |= (0xfff << 0);

nit: we could drop the << 0 and ().

>  	an8855_reg_write(priv, AN8855_RX_CTRL_8, val);
>  
>  	/* Frequency memter */

