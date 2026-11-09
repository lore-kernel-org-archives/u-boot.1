Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E30606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vLVz5wU/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i1NNupuQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 776CB40721;
	Mon,  9 Nov 2026 21:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuNdYuW76MAx; Mon,  9 Nov 2026 21:23:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE35F40660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794259427;
	b=FmyMNbxsv9DERaNVrW74Be+ahx8QetvH2BgefPOmGTnfDaqIURMIz7DtKzsXUwNK3qD5
	 d9xn7VUio0+1c+BnqlQUAs2Q0kh8AawzP856yWNl+w3tfIHrzYy9wg8heZDF/fCRMmK8i
	 QBe+mqvBs1Vwb4l31A5DHnqkBGAxKo6sF8QwEFUoIsRwGBszdkYbSo6e0zQZjxekHtlaV
	 sLCkfFeJGDjF4NrmKyY0YmkuZCKDZHzJIjXrDtLdMze180tie8SRFlEk0abqX2vAr/k7S
	 0dL2DP7oeZib0cjC/F5Ouw0ogCSEnLjttXbS7smGUlU4COrK7gd6XTUesOVeoTmjBqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794259427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QL/vht6xVU69fyl7qJP+T/XDEq83NRGSUdljAo0hGBY=;
	b=E5gKRqCgkhHsxTJy4F2xPzDsZf6X2P9hFaQbrMK8RPWDRDhcBqJbxEG0hgZReNx7mzrr
	 erILmg7FqK7e38wPf8Zu3GYdVZVf21O8gd06l2+oTgFIBRMmU4KJn7qm9pAUumvReBp5O
	 7COCoW5gXY2V410oL7UG1TA4Qt3kzH3kSQ3/c+Vl4wWndba3netWpB/F1eHI7FB0sbl/R
	 1TUQTEp/lGjfVt18yQV37B/nu00FqJZkSf8FFaEsJI5190yul3WGiShwdCoxru5gLWpys
	 ynBsai31E0kpp3dgoUvwwyCFXRNlJXeRSUBehAVofbKSf/BaTF7azDA08scjZgA/QBA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794259427;
	bh=QL/vht6xVU69fyl7qJP+T/XDEq83NRGSUdljAo0hGBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLVz5wU/PPT7uHVy3m3qn/rhNasfVOsUX6Yilkvj+AzZPabhLdZcGpT6SKwh8oMrx
	 Hxw2Ptg8EpH4FeyT9fLpWmLZPJOyf2c162IOV7JfMeblcbTSYCEB5YpDLhho4uOcsf
	 JLOXUQnDZbIEN0PDQsqP8zf8IWWlB98yI9Idc5KZf1ErhJlGP1it98NAGf9n0DePDc
	 lfbMftFlU++v4Xa6gT8vYumrd/aRBNenikBbq/reInBJgUnriWGTIgxyq7A4s31Cn9
	 ZbTOlaBpPPg0Wuh2uCqD1glQsZlxDY/W1QkGu/iCUMfpPm7iHQvuomCSWNELOvfXQw
	 drx0WYH/xER1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE35F40660;
	Mon,  9 Nov 2026 21:23:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A65E3AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BA8480E7D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXcSPOhqVoH9 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8166880F38
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i1NNupuQ
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8166880F38
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:23:44 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-717080a2d50so886764eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794259424; x=1794864224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QL/vht6xVU69fyl7qJP+T/XDEq83NRGSUdljAo0hGBY=;
 b=i1NNupuQQ58Z5xHRTpNkKNJjRXQtuF+qZmdSmecwBl1RoBqrulbsFaWR+QoWpYdvXB
 AUGfWFy5BxGnhVOlXmmjRIKJ9SN6P7l+n8FQNckJI8uFCWCGCGWPnQILvILEyl5bFp6S
 e3+UjZCbRDeL1RmboX59eH2XGJjWkMrJbfr2TD/b7VbMMnhT0Dv+p4u0mfFb16iZuJjh
 8riACAEdsb7QRgiCsSzII9GKnYq0QiMeYW4S9cW/j72cfEi64+Z4mMt/KiX5rxFc7Kud
 eb01ofWfnvgYmrszHtzT+2Zibvt6S9+tauuH1S4K+JrYm6nESNvtFxWDgY08uKkuOcrE
 f52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259424; x=1794864224;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QL/vht6xVU69fyl7qJP+T/XDEq83NRGSUdljAo0hGBY=;
 b=b3VvVggTG0kxPBxrHwJE18f9LaIMdEhJU/VlZm5ltC7SD2d30vzL2uRsiXK0RaaLw0
 VNtbl/yOYn8EZ3n/y1UQY/J6LFS1+AxjE+nMtPL52acy5XfF4mpDAPNrXKXrEPAIuUwF
 O1vkY/02zHGi/J5HFoX56iaqSNF5YK9KvL/qPpPdq7FlHJL8XR+B3f0UODTpmNkgPrqK
 xqn8+F/8kWzSnqS1g07BxlqRfRbD6QvSgSAof1cOhflwJShoA0oUZKHGPThwCoXQqXBz
 em1iLw7iZB5aRGGf8Rh/sTlcSnDgGQgWj0f1jQ67e2hwrqSxsFR+AQmJYAQH48dkPL8w
 K/Bw==
X-Forwarded-Encrypted: i=1;
 AL+hErE5fAF8PHOZfBZm+s37pmaPjeeOBRxGPmYnRS8l1OrunhUi6OnvVM1fpOh4ayMG4lCBRE9V690=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+PcaJegPadmcof9KALPfKvu19LKFlud9iggkd5g3YiPZgpSguK
 /VdYYhdo9m0s2NrSGd5h58jgLc8Vv/sqBlT1OV7Th+ym6g4Jh1GEFDaC/tfFVp9jdNE=
X-Gm-Gg: AYBFou2Q18tgb7IO1MnwnDFOjoX7MEmXPVv+zBeloVibj8Rx8ztHnhUFWHr3bCnQrhy
 ckTWAS5alJpNu8q1Hf3uI8bIyOT5gKzj8BFQeDfyQt48f5/k86f449mdOUcSMdNeHDdT1NPgHzf
 XK+4FUhytGOlamfP+YXy4mxMzt5sjH6rRzlVeeTLimg0VJf85suwOvUaZLmrC3vH883qpJKjn3k
 k7jHSndBT5KmIpAwVZvARAJi5hBW5SO5uhLUFgX+wBXPScU3+ECr5L4Aj8zxGSMBjzymeibbsmv
 NgM16fqG4+6esY9AVlxRDggVU4GLqoR0zi1VKtSvN27tylU4NvgEVRZ+Pj8AGsMTeowMN6H9sMs
 gtrTiO6ZKbtXZHQl5Xe/XADktOTasdKf71kRLT8Pq5l98R7SS1bp7k6oANxxP7LQ6Ew5mqCCRzh
 wnA+fI8JnLf+qr+61NFJQPFHcZV1fSj2vuxrYgnG4UPeOZTLtV3+TGcw5sM07xTmmFEi7vDg9c2
 qs+U6X0Aozx7e6U3kOzpVArtXV5rH+5lPLcI6smuhE7v0lDupKrAZYO83CYlrSIjzuMY7C7rLsr
 E8akzSDQig6TU3wCkyti69mwFqgpVCw2yxHe+Sv/jz0YnI2RqWdyr6qjbVze7ss2I4zWOjPcbvB
 SoxI=
X-Received: by 2002:a05:6820:c44e:20b0:6dd:6d12:22d2 with SMTP id
 006d021491bc7-718a2a4533fmr173278eaf.7.1794259423973; 
 Mon, 09 Nov 2026 13:23:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718aa03dbeasm249102eaf.12.2026.11.09.13.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:23:43 -0800 (PST)
Message-ID: <14306a07-86f5-4309-930d-5668f361e73f@baylibre.com>
Date: Mon, 9 Nov 2026 15:23:42 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] net: mtk_eth: an8855: enable link error recovery
To: Mikhail Zhilkin <csharper2005@gmail.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <20261107142441.2104669-3-csharper2005@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261107142441.2104669-3-csharper2005@gmail.com>
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
> Sync the Link Error Recovery configuration with the upstream Linux
> driver.
> 
> Currently, the U-Boot driver explicitly clears the
> AN8855_RG_LINK_ERRO_EN bit (bit 23) in the AN8855_RX_CTRL_26 register
> during SGMII initialization. Setting this bit instead of clearing it
> matches the Linux driver behavior, allowing the MAC/PCS to gracefully
> recover from momentary link errors on marginal hardware rather than
> dropping packets or the entire link.
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  drivers/net/mtk_eth/an8855.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
> index eb037ec1382..513f4534701 100644
> --- a/drivers/net/mtk_eth/an8855.c
> +++ b/drivers/net/mtk_eth/an8855.c
> @@ -599,7 +599,7 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
>  	an8855_reg_write(priv, AN8855_PLL_CTRL_0, val);
>  
>  	an8855_reg_read(priv, AN8855_RX_CTRL_26, &val);
> -	val &= ~BIT(23);
> +	val |= BIT(23);

It looks like the proposed Linux patch also clears BIT(24) here.

>  	val |= BIT(26);
>  	an8855_reg_write(priv, AN8855_RX_CTRL_26, val);
>  

