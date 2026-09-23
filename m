Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49932C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDF6181F6F;
	Wed, 23 Sep 2026 20:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4UmcEYzCprY; Wed, 23 Sep 2026 20:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E047F81F43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790195612;
	b=glJeoOs/3ceo3guW1y5wEVknHyUV1mdrG+ouMDGSjNxTRnYCtlK7VIZFR4OOWydPqtKp
	 DZxMvmP9b0h/WeIUbEt0qkNHFafoQ6B3KxPo+moGgZwqEiwoEMy1M0iZEVmXcQTw8gDmb
	 3mmrGWWHR0azY9MVx1AbOqlZeEvIqlHFFcZX8xm/N2M6cwKy8Isrlk9PrcsvI0UNnis+d
	 ERsTwIv4oEjddugY4c2BXzeI9UqJtyVlkIpxQNe/2E1I/MxS9F5PQ9XZnAktsbDZKaf6z
	 1A4R7AnicgolnjJdvppGwWGDvPeNApmn/lbp2hNC4zfBm4t5fpGasxnswYwu8Gng76Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790195612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LVU+kr0OFnrfROu+jBSt7e2B4OUcKdifmJ4pfA2IPaE=;
	b=CyNp/ZX6VGuq/u6gqr6CWwG3uCjsUk5j2AZBZ9oqeOon3adoVOgj/2tFjyo1fkeyJgyD
	 z100zwgsAk9tOVpohjsury7ivw834TjOxhNhKsx49mLVy5rwS8lZPY5V/Pcv0Py6qX2i+
	 p0iz3q96bUDkcWWowFivwulFAQtpvd7gfP68NLWvDOnsw6z9HV6fbY30TR8Uxq0A7CXwV
	 febFF1HcNHO+UBWr3wOADBLk5ANSdBG2Kh8E/IuTruqJeRzbIGNQf/krHGv69ojxqFCVB
	 GSbSLTTNP0b0Tk4Q3o2QOdO/EIu3BUQk2OU+0WSlotIei6WSgFmx6rg03J8FxSD3dEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790195612;
	bh=LVU+kr0OFnrfROu+jBSt7e2B4OUcKdifmJ4pfA2IPaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0JIoUrIo1bnuklULqRvbP9207FAxk6nYf9rLx4j/PK7k+bMGdVufZHraULUqQtxv
	 i3q3Y+wIQffl2SwcJWaa2ylTUm+3aYMWb5EUUEOYy5E1iBmwj7gO5CZt1LcHwiOXVM
	 q7qvn30HVYpdUG5zCPVBF1tXduT02ogLu/5YM7kO0HVTi55VNVbbc18Zz9P7py0McA
	 lqXlk9cONIBaETq+3k6o5hGdmi0AF7IZ1wEgDrnUgZTdngB1qTY7CaQA1EvcgCdqGq
	 bx9CV3JB9BLGpEBbZHpXfwe9ONz6nZD8MvHFcopuBse4ptdlx79FWgv1nKZl0OaVxQ
	 S7EBADIgMCRkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E047F81F43;
	Wed, 23 Sep 2026 20:33:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2532132F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07AF940270
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQ5BI2BPP_NS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 760CF4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790195610;
 b=FMKeoJW7TM9CLSnWDbNCH7flodw848XEbcB/79DihotsMyxOq2GqFKE3lcKbO7komIGh
 esKHOrlsgsSCvr7SDIchBMYWuPXJiR7Gl66xjSjpaz7ofWtozOJfw8baNeDOqeI1rJSYm
 17dMtPtSGHoG3eAntNXblKWP6PYH8/gGxNnsY2BADFdC7+seTziu0T6ME2NsNnWsqUxBv
 XdIZcxuciKJEFjpfoLAC6n6ON3p52Bbiq/bKT3GScTqDVewi6EJdKW2UTwu+ui8YPFDSn
 lO9h6meWCveRjCk9H/cVqUkp7+NYbdK9qyYZcOoYx3BkKjxqVcnzGhT5GRPerqI15jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790195610;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=LVU+kr0OFnrfROu+jBSt7e2B4OUcKdifmJ4pfA2IPaE=;
 b=dk88UU2A3FXHOkg9nVnLXBScqXwLbcksRdLx4PFHEEau8rhCqLtzAGq2aYWLvXUL/StH
 YXsNOIu1wRaaFHrXRZz3AIyhbMmpK+JbLuI9llr/DPzjfHbWovmpRV5dGrDCq0tcURnW3
 80ujeh5cODc/cBAy6nC5agw43Ay0RP9OtigY3daC9eGaUolI99MpFByBQN35TlcOIE+VK
 GCTtbnASgJshApJU0fUZDZskNup1l+q6tMRujelL0Z6hz7yInOYWN/KqJu9IGKek5nMeE
 vXw+4fsEt2btnHCsw7JpJ5nctRBoKPjGm78BaYKTgdBKs/IPJzZlwoscRyYO83xPE6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oRSNE22M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oRSNE22M
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 760CF4008A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:33:28 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b5c61966d0so822742b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790195608; x=1790800408;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LVU+kr0OFnrfROu+jBSt7e2B4OUcKdifmJ4pfA2IPaE=;
 b=oRSNE22Ma9QwuoQYc5tvE+80xXpV8CAcPs8Z817ch8yFoF6TUd9P7DhEEmXNEDknzh
 UyVpOofSaCODLSgNbIW0N10XZokxcNjxCyC/jvcL33YJH7lQMxpb4yygfrSDCirCqoa4
 y06UALs2+4oPQgfDOnNv6PhbiUBm7iDqhi5TL7RsFM6cohdUL1Z3OwbAayAmSEwIGodQ
 AfF1v+4s+O2CFiwb0ickaFkJrga+xPcNStHRYd169veXaJoFSafBOQw+N5PZ9tn4CKgE
 eXXvHctaKP0noObtk8zL5Safu8fSubGsT8rwCT2UWDQR7exJLkEf5kZkrURLEBrHRWJ1
 HpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195608; x=1790800408;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LVU+kr0OFnrfROu+jBSt7e2B4OUcKdifmJ4pfA2IPaE=;
 b=mNajRvgD6yDL3IHH0X4b9ajiU5j/3bBnJVQVtz5Z71RCmE0GT87qcWvC/HbKGmu+Zy
 IAgsgeYHmAxPLvj4BPe1UNAfGi3KRKW7zZ7UZQLiR8KSRPgIh8F3kruzwNyN0HALRVRl
 Q1PCxufi0nXH/Y5eKaA+HYdz2lwBtlnG/IooIyoOwbe0oiEkwxYYGv5A9SvuwEK2K4hK
 27OqMeUmbeUdZzNzhAzE4gn8ECfWEEfwSlDg6A39hKN8g6QFJ1tEW1/QCOweYV8sk+/F
 QG85/LGXgauEiNkKQ3eZe4RFZ4+gsrgUaVFnYmLW8/i9MU1dUoWGm35OYSmgnPCcg/5W
 byYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3ESCofjQU0maH6cBbl2RFlXt8zoWTRlQ5oBCJTMEJhPwB+Fleq+koGnR/5uD1DpaVo6Nr3j0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mlUy8x1bv1ei96g7qU1FffaHQoBPN5UgISzzT+BMcQPWNE8XPd
 LroddV/wDhPa1EDjRhB06ysdxDxSeT3Ke70iYNxKU7HBZZsRL0IuLZ5oqpgxiu7Frbs=
X-Gm-Gg: AYBFou3HUEiF54aAKNCFQIyM4G9rkkVd214OuOybEO/SXcjwfXAAzyzxOaBaPMJPmKN
 O5lkQZJCsr870IQdzZWWeycKfZAplgA5HSLf+CcRpWlwRYZUDyTGplBTnnN1f8HZTLXQ4P6Liye
 eA28lcOOcLi0lZf1ThC2rbULUV0Oxe2hjl5J4KNTnHvrJOTgwZDh0APIEge3pGCQk3MSVvx56dT
 RXfhvYwueb44VyGhRkhF9Vm/JnyYPKvCERzjKKeZ83yrzVBXJTc/6CqjpzB20sy+/gtpANz5I7d
 8vWE1md2y+f4mYJiI+ormWioJXWK5Op9+ClEvIn0NjomSez+JPHcvQkOgxd0DJly2TDOljQC47L
 3gCfNYWNxnWhcBUV11GhB2JrBea3fr7jWWrSkx58jj08MGHaWX1Myz5TnYF31BFg1zuKebgDQcR
 eB7MHN7+DbR3Ljnyg7BqufUt3zNreusgcXPCWxC29+Tn2v6RC8qLFgBR5lBfeVUMX/jFV+dCuOp
 elPTF2luqochGO0sHVePlolGG5Q8ngZqaenWHIPrPTbQnCv
X-Received: by 2002:a05:6808:3a05:b0:4d5:27da:a492 with SMTP id
 5614622812f47-4d72e36fa15mr333339b6e.44.1790195607854; 
 Wed, 23 Sep 2026 13:33:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81603fc79dcsm4045346a34.14.2026.09.23.13.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:33:26 -0700 (PDT)
Message-ID: <9cfe24d0-cfca-4d15-9aed-d1d9e0e2b9c1@baylibre.com>
Date: Wed, 23 Sep 2026 15:33:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] clk: mediatek: add a helper to declare gate-only
 clock trees
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Chris Chen <chris-qj.chen@mediatek.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
 <20260917-clk-mediatek-cleanups-v1-2-4dccf8ed98fc@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-2-4dccf8ed98fc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/17/26 7:51 AM, Julien Stephan wrote:
> Subsystem clock blocks only provide gates, and every one of them
> declares the very same struct mtk_clk_tree boilerplate. clk-mt8189.c
> already hides it behind a local GATE_CLK_TREE() macro.
> 
> Move that macro to clk-mtk.h as MTK_GATE_CLK_TREE() so that the other
> MediaTek clock drivers can use it too. The tree name and the array of
> external clock rates are now passed explicitly, as their names differ
> from one driver to another.

I thought I had cleaned all of these up so this is no longer true. However
I still would keep the argument explicit just for the sake of better grep
results now that the macro definition will be in a different file.

> 
> No functional change.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8189.c | 23 +++++++----------------
>  drivers/clk/mediatek/clk-mtk.h    | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
> index 3724dffcc3a..8df09f4a129 100644
> --- a/drivers/clk/mediatek/clk-mt8189.c
> +++ b/drivers/clk/mediatek/clk-mt8189.c
> @@ -1994,22 +1994,13 @@ static const struct udevice_id mt8189_vlpckgen[] = {
>  	{ }
>  };
>  
> -#define GATE_CLK_TREE(_name) \
> -static const struct mtk_clk_tree _name##_tree = { \
> -	.ext_clk_rates = ext_clock_rates, \
> -	.num_ext_clks = ARRAY_SIZE(ext_clock_rates), \
> -	.gates = _name, \
> -	.num_gates = ARRAY_SIZE(_name), \
> -	.gates_offs = _name[0].id, \
> -}
> -
> -GATE_CLK_TREE(perao_clks);
> -GATE_CLK_TREE(imp_clks);
> -GATE_CLK_TREE(mm_clks);
> -GATE_CLK_TREE(mminfra_config_clks);
> -GATE_CLK_TREE(ufs_config_ao_clks);
> -GATE_CLK_TREE(ufs_config_pdn_clks);
> -GATE_CLK_TREE(vlpcfg_ao_clks);
> +MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
> +MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);
>  
>  static const struct udevice_id of_match_mt8189_clk_gate[] = {
>  	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 9244542a2a5..e3a7ff75734 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -8,6 +8,7 @@
>  #define __DRV_CLK_MTK_H
>  
>  #include <linux/bitops.h>
> +#include <linux/kernel.h>
>  
>  #define MHZ				(1000 * 1000)
>  
> @@ -274,6 +275,27 @@ struct mtk_clk_tree {
>  	enum mtk_clk_tree_type type;
>  };
>  
> +/**
> + * MTK_GATE_CLK_TREE() - declare a clock tree made of gates only
> + * @_tree: name of the struct mtk_clk_tree to declare
> + * @_gates: struct mtk_gate array backing the tree
> + * @_ext_rates: array holding the rates of the external clocks
> + *
> + * Most subsystem clock blocks only provide gates, whose IDs are
> + * contiguous and start at the ID of the first entry of @_gates.
> + *
> + * @_tree is declared static, so this must be used from the file
> + * defining @_gates.
> + */
> +#define MTK_GATE_CLK_TREE(_tree, _gates, _ext_rates)		\

I would be tempted to put _ext_rates first so that they line up nicely when
the macro is used. It will make the lines look less noisy.

> +	static const struct mtk_clk_tree _tree = {		\
> +		.ext_clk_rates = _ext_rates,			\
> +		.num_ext_clks = ARRAY_SIZE(_ext_rates),		\
> +		.gates = _gates,				\
> +		.num_gates = ARRAY_SIZE(_gates),		\
> +		.gates_offs = _gates[0].id,			\
> +	}
> +
>  struct mtk_clk_priv {
>  	void __iomem *base;
>  	const struct mtk_clk_tree *tree;
> 

