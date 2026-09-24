Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EA3C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 18:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D1654085E;
	Thu, 24 Sep 2026 18:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CM0xx8-UZfF; Thu, 24 Sep 2026 18:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CBD9F40AA6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790276134;
	b=YleI/ZXu8S1PiN02D71s+zHHuNulCSJEyYcHeSxcbD90Qod2ktgOBIGY2PosfMK2tWWO
	 sZaAEHkhv17lF1cq6H8LM0BBEn1EcyTYVd3arrxVp7g/84QMo8uTTdS4bpdpMLEpEA9zT
	 mYy9+VajIoP4ZJYQFoTxApFSnHKjXmlmTiNfqE2hXardcp1ETzVIP0uwrR7Ty4FhTm1h6
	 3UVULP97tN/MNAOlNLtCcROqVcJfDR9TUP+QkZ5a14oCvIg0S9wnvBg5nGASo3haCq5yJ
	 KexfXrRvxJYc+lzvkeTt1D/fMTqF9W55PqDBtdTxew5i2ddRTSFZ67oVyaOB/kNb50w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790276134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ggyCXQucSl1HNPBasURkZ0Z4xrn2/e/0OsSRXUyuV3U=;
	b=WzPVxV7TqVMxC5ZjwRkQ9kWThFZXITrXjtVCsp/9S530tMsITy9ue2Vzp/KM1puIxOJv
	 QPObWHZmqzBXpfsADungctZxIB2QWemJ0KhkTpf0ExSeLXZorqjI4zUZMLKCJLcCEic0A
	 3CdGVX1yznPIMXb4XR7GB9uloptcnKFrvaOmd9ixhYRXIwiKXSIzF1ldiw1DFe+/Jno/d
	 Klia2zYovHFzd8NRDvy87KHjngkunt5K1tv7HRE9xbTTrRy96VUWF3USkiQoK1fbjBora
	 Xn9nPbGP0SVdgJe32Dd9Px0kDsIen8Edr16bVAoo3BdQ8tT505ADcbKOpU2TGnbk6sA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790276133;
	bh=ggyCXQucSl1HNPBasURkZ0Z4xrn2/e/0OsSRXUyuV3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kk0PnjncQFpLgx1/TxXDue1+yB65h1VgN0Ay1qnpdP8EbAMLEL26tvhJmHnZXRexv
	 PI7kj5HZjKQRTYl4vpxnSPJbaUasn8Vx54vZqjKC9oIoZtn70ibsEcr/TLFr6olwpd
	 YhSHOWQ0ezIzMeqRhGB3GQXSeWzam8ELDF1pFWSLBCTDS/P98vCms9Yz/DtH62d/VN
	 pGtIoaje25xqDeaEHnY71VUl5WgW16MEER4qhnY6qEa+SVXxLSsuNKq4A64cElTMAg
	 iTc1pSLSIxhbRv5gnxuxodwIxNGlH6WjTIq5PytLSLZWj6SJe6IBbm+lQRQAnXZWDa
	 RIJo2PZWP2/fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBD9F40AA6;
	Thu, 24 Sep 2026 18:55:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EC28328
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6065D404B1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHLA-Mj8saln for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 18:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4DB674017A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790276131;
 b=FlGAAPWuA8qrIYwyys35zu+9tQPTfQbsXx/5p2zc9dIQdxs1BbZv19UxGGp0Yq5AdndS
 IOoxPbQALwep4e18mGziHYeK2UycrbXj/9jCHHxDpU9mpSaMADUYW9hM4Tf4H3goy7l0+
 mI5xk+kU8zXCMuwa5ZQRv7ZNx7Hm4qsu7L+nCL7NT9jRVOXG3o4XV/JypvGY58/qF3BAA
 SIHbQlGpwtj8XkgwUPUD8PMc4YiGVzJs3AQYViAG+hatPWEDgBZ7mmAyK9/QWwhQcgpfF
 6FlUW2UjbfvaQK6p1zyhuXK9Q+T+G4rQJVymrXgzh53wsVhhTrGdCLfgyaeLDuzftQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790276131;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ggyCXQucSl1HNPBasURkZ0Z4xrn2/e/0OsSRXUyuV3U=;
 b=Xrs8dBf7ZckmF4WnvU9De+qdIggRe9w/5gCQjC/DlrzJzTC4B5Ey+MA99QLXTOtsH0oF
 hSTwpdLxima25aoh09MWLFi7rq1orus5AZV6Gup5DWYJyD/OUUa2/qQUudo+MqBFHCwfV
 u65lbtVN20eGqMaIJPRsTOCwAiN6g4ELz3wdV8JNfp4mKo9uIRs49l8aQMl/V/tEf3jYD
 Qvg0j6OlBJZXmbaeZTMnG5w+61+AwVDX7OrnpzOhHf1w/bZ+GzbQDAc9sneWxPDcrc/mj
 l4OBuA0+xT7/vaDWXfyZFomwcv0I04TyUmzECH0EJgGJH8GXZXdMToILv5to7ABBWkw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="etUizoK/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::f;
 helo=mail-dy2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=etUizoK/
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com
 [IPv6:2607:f8b0:4864:36::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DB674017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:55:30 +0000 (UTC)
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33c3735125bso32190eec.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790276130; x=1790880930;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ggyCXQucSl1HNPBasURkZ0Z4xrn2/e/0OsSRXUyuV3U=;
 b=etUizoK/DJON9DJFFr7742E1+WFNG7dZCcB7U6gdJGxdwuVesaMh/yQQcOAa414DkX
 etYaDA/zfmak5ELJutZKjUJJORR1lbVz9tU5uH0gGjuDlMB5UsOV7J101aQN47BE+bNB
 ZoPD8JoL9jDD572hKcnMvWsjN1fpV2xT7ln1e1opmUeM2iAdN4UBbN9S2o2/du1Ephck
 JW/buJctTUHdgDjIBadeGxL6IadmeZ8NgSqju7XYYpm5GHqbuwH4QGkEZrNHdyNsKLt7
 vVLygO2sgRFTOJvh18XZUIjFWNXdkU+eKpfBMYMWPrznBOFsI41dg2KU4KvO2PqNDk4k
 6/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790276130; x=1790880930;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggyCXQucSl1HNPBasURkZ0Z4xrn2/e/0OsSRXUyuV3U=;
 b=L94HZfBkSyJK4xs/poxRGeRyO264GZAb2vKAusZaZN8MIIiLrYd8Br1AFTA3ECTWWP
 ljw/sXQrYnY6JSOdqtRBJEohplsj0W7k10+M9/hAVQG1UPe15ge3BtR6wXTSQsovFvZJ
 EE33d5VMFLhsCPUyYxa5roOaT/d26gdWbreWQS2VdxS3xv8hV2v4V8A4jo67bCziJVHw
 VrHbhRtr+KyoM0TDW4kGq6wgon1w5+rnfVcwfjQGwQ4ET58GWZ42eYyEzHLvsBZe+bdq
 WOIaXINC72fnGx9nXka7slMQxOFsO1dmbKxMe+EBGIhmr20m5r6UNIKG0BDMxRT74STR
 zHoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1+IaTsO7QvSDjr1fGqgduPYcz4yrYLdBCL1gjB0kbIa2ZOuGAiBTKYNcyp91Ax7PMDgId4B4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++llmSvilzfseaA9GjfAcJeoWuhcKNDdTnI1DZhMgAIhpB4/o6L1
 XP3vxE4I8HBua7LhD4eQmGsarvnRuqkuDonJOfqqwazaI1XoznFmnw5gms73y0pcGAo=
X-Gm-Gg: AYBFou3cyk/sbpR94Hw6oRkk9sUzWeZMNhCUdsaXeHLab5HJu9S7rHCS7Jp7twUChU6
 GhCNvPycFi4jgpi6C9yKLAaz1ufM4rE550SWreUNStZJTrTMHaEVwDZlH2jYKiz/FimOALSSC5U
 01C018OQUoXrHQ1+v03AeTHFvxWsGVXX2UkzjJPU75LvPcBp9hZfSUquXGhwn0Ik/S0q8iUzR01
 TbXUPtrGT4EXhATlasBtS85ImUYTWsAcxhMTcKkvuJDlsdfn5WcAnc/i1lkGyg/tjS6aktIDPaR
 lBV1OGWqGws15joYBr/fCOSIVwNE7JrvIOjNoUAhVf0vRSpY7jb2uL4jrqXeojUax8YU2qFpJbn
 yX/j55cOEeovfo89DC1/vOl1ctCGNI4r+6TF55hWca1DF8CfGG3EEQEoLGZ5l/1A9qcC4UGskyc
 LhzOXNrH7J8RizXgqaiRkDzZSZ6J0w8Ix5ssUy+LyrAfbDS+grfa9x3JFZqN8j8xqHgsLX3XE6J
 JKqPuEo38j9xh6AvBaVZFpjCQQF3s78VRWCYeiZuZTu1aLU
X-Received: by 2002:a05:7300:578a:b0:33b:e4ec:224d with SMTP id
 5a478bee46e88-33ffe44d800mr3595852eec.3.1790276129404; 
 Thu, 24 Sep 2026 11:55:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ded:edd5:63dd:4102?
 ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm504618eec.28.2026.09.24.11.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 11:55:28 -0700 (PDT)
Message-ID: <f6f9edde-a3d0-4124-af8b-9dd68868e20c@baylibre.com>
Date: Thu, 24 Sep 2026 13:55:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: mediatek: further increase max number of
 base addresses
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>
References: <20260924-mt8196-pinctrl-v1-0-4df08627ad64@collabora.com>
 <20260924-mt8196-pinctrl-v1-2-4df08627ad64@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260924-mt8196-pinctrl-v1-2-4df08627ad64@collabora.com>
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

On 9/24/26 11:03 AM, Arnaud Ferraris wrote:
> MT8196 has 16 base addresses, ensure those can be handled.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> index 1f97f3cd7b0..82577b0c43c 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> @@ -9,7 +9,7 @@
>  #define MTK_PINCTRL_V0 0x0
>  #define MTK_PINCTRL_V1 0x1
>  #define BASE_CALC_NONE 0
> -#define MAX_BASE_CALC 15
> +#define MAX_BASE_CALC 16
>  
>  #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
>  
> 

Logically, this patch should go first, otherwise the other patch won't
entirely work.

