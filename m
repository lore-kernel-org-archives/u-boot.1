Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9ACA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E40D26070A;
	Mon, 12 Oct 2026 21:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALHbPdK9cytz; Mon, 12 Oct 2026 21:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5B75606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791840053;
	b=W0+JQ/8f4VRWcJ/dxO2twCkAylFO6k3P7lAIbXNkc7oDJlrINUQxOFZzEJJPVm4dxNxF
	 0GwHsTXh3HVWmRmkBe46t8KZqRt77biSyT+goxjjqu5Ufv5SbjreDnvfPLKytmTYUmnId
	 hFoi64D7GoqsizW+xLbLqtZUhYpnuFQcROSvuKgWqNhs/BW1IQ4AViz3qm//HosMV/EQb
	 R441g7xZsIbxSh6epE+p/XpvfT8BXwwlgC/tiRkUzw4ImIQt2cJJ8E9O9Gt3ZsY8sYi2v
	 b0jwunzDlztwOoqEbNpYCoZ9sTV5yG53wCk1uziH03F7N4dBeH50lUGKvShnjbUd8XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791840053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=clgC4f5pgq2K1ox22WEf5+8YFMEU4oiPEEJHZ972Goo=;
	b=k/I/YTrTauTZ9mzmtMtxrM8Iqmp7jY1Bkko/Pc+4MllpWYT9aZbaWNchKCezeSp4zgfW
	 zbl+A283fx4t3uRPPPatUv8Jfn1M+CrRHjplpE7ZE/CWM7VioKODj1tQfnaQHH+ZVKrE4
	 0C6U1M+9JFeGghKJyjI/YXpj83QgZyKP1dhWf4jqfbjlpiRw1a0M1s+otP0jqWm0oFQsX
	 AOKnXkcWR/rP9H+9Yb62A0CAnZXj15CF69qS/cmgUfM55njnGpFR7TyNWE+5lXdnfCcUM
	 yVgSZuX+WHPcvB5WKJALrUQy8/dj8MwteAoZm2KjVct7XhVJbxGxLh4iJginVzGRO1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791840053;
	bh=clgC4f5pgq2K1ox22WEf5+8YFMEU4oiPEEJHZ972Goo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VvaxZ/4T/amEM0tsy7EzXVbuSL2mV82LTOvC0/S3ozwQMBomvNRB/2fSF8Em9IDcK
	 h5KfiA+QMvAxOpHiVAN+QHDTIRPdrervV5cDCiNBHZkSKlnwNSpSgrHopgkSwBzrfb
	 cXD+zSLI36/OOeIgLvnug4P9Lfierzm/h48MRvEwsqAt6Sfb36NMuHJMRff5WRTs9j
	 o7tej92D0UgUo1UZbvONVqZhy646bhvJf0etWibzuPUEqqdEq+Owl/PKTXhs3g3qnd
	 op2nSLB9ZViG5cOdgRdkRW0+mBvZDWdRSMzBx746V4DYwVjIyXGu+Jes2oFBaHgedw
	 rJcxuRaLyptzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5B75606F7;
	Mon, 12 Oct 2026 21:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CECBA1399
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC77980AAB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjdwZGPkRhwJ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:20:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D980780AAA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791840051;
 b=HHGzgRsTDNZNrDV5up097sb+LFiHfDA9FSuyIAckFK1L3Gl3QrOTSwndN6GWGnfAqldo
 aEywtL+i8CDcd6U/R6chMMnclkk4Od2Be1/zr4CPFIcjJWU2R6oTWB+JThNDJdmuPWyKg
 TioX+UujHeJ0/Sgh+qLv8HP+14Ea5WQ2dmq2e9yc31mdPkiOg89rdm+/ofkkw5ubki4gf
 RLBbtpX4wIC5mDKCuWu/kT6rOhhhLMjjkAoQ1XKdqvnv6/RbgfX7Wtxs0LzcsAc3yPnCG
 Ixbgy2RQ9Y/EobQAAkpgHj/zjkA0L0jSALgkusBHVibIAmkm0ebNoBz0jCk+eb6UdxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791840051;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=clgC4f5pgq2K1ox22WEf5+8YFMEU4oiPEEJHZ972Goo=;
 b=DW9cTgjwGygSBinZ13wsVrPJjYMJCmJZTAHD4LdUlLX2YqTDNozZr0YDFBE1slReLvOd
 cZt+mlfDTWxDfxY3y0ZkwXb6wnG02fxLBVP05T7Urr9bR+s03euJzpZp0nxN2j1CFQElZ
 BSRhuRle+rWiEZO4yeBrw2D3xvH24r4OTtJBtQ1iRmzTfMVmwkoLvtvA0Yqv0HY4TRpBB
 KWKrSWtxxCmkrQuH+zuccOJ0YkMrP0KSOTcufGpq2CuMuweOiL9rRkeSb/wVsTM6gmtVn
 tSrJFICJn9RDjJSSicoGFLIZZKuoFQd8iXq5MWAgLJdN3plPoonJE1Pf0R7MkgCJKFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GdUUKVw4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=GdUUKVw4
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D980780AAA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:20:49 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-821b5c73292so1664886a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791840048; x=1792444848;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=clgC4f5pgq2K1ox22WEf5+8YFMEU4oiPEEJHZ972Goo=;
 b=GdUUKVw4sNR8VYlIp8yGYrj2mftvwSZQEYrwve72aCDBhsVMKlaJqR6ifoiyNK5Bzy
 k2d/TyZ+FwolRjYBCClMps878tOof6MciFb5ogxA2Mdb4FarM6WGqAZSPO1JfVptRt9W
 74WYUHupWzyExGXZH8yl8ScC38W9aSKqSUu9UJ1rkLlK2PbBE0KWklddRbGNPxY1wZfV
 c6G1SF4/vb15ie8dYqZAI8nkglGDO+qhi/WEQlkXsq61wzfCS0k632vIWmaftmRCtOiG
 GxVVOKlcqxyWby9n7J7/sttCug6fkAedGfAg3F/cadgC+rlQKjo1GiD4+CkaMsqnWaCT
 dflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840048; x=1792444848;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clgC4f5pgq2K1ox22WEf5+8YFMEU4oiPEEJHZ972Goo=;
 b=I0afqBMu2QQMvSzDwbwBWi3pbdI5KR352Y3TSzzVmYWNfQnXaL++dvrFQRnPqEyhPh
 MTqlO1yZcw3JTLbJor/L8p2Y8zoY+8J1TQMp+ymvkFOQB67n3j3PlR8cu5gxhlhMPBKf
 qGM0FPN2x2MPRhsik2lvXMPSc0uxEKnpWMaWgDo2yMfaaaX6EQUd0CNLEGe7b79IsNoR
 EEEmR9YrSi/prOOfwh2OIqAz0zZX7GTDaLvjqFL9HTa5LanA+S2mkos7y2wVcf4VZd6y
 aT4gDx0naiLPyWtDwRoBJjbt9DZwqdIdVh6dB7F2Rip51xdqGNcOeaN9ejyxnp8N605P
 V+Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuNOnqYqganh1XuD4Kzc/XFwUJDOBrTBF/FzOp514Niqmmj/w2WwscYEybTNho12Vwr/+TO+4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL5sYedllkGkyTMUgIsP7X8IXKDeMYUFSloyY8VOg55lt9NHko1
 kPLTl98dGMqW5TOsRnS1Dy5Erj1Q1FJgJPhk2gljO674X4XSU+z0qe/Y5qRQs4/K1+Q=
X-Gm-Gg: AYBFou3ZYVINa66p6Ok1P9ncbJlvmB5CS6tX7u9oZoSBBTK+rvxrutraG+b+PAkJo/Q
 lXQZGo3LXk0Mpsvr0Uv+QuygxmXbq9/rFJM+vwzHVlUW/jR6ZF6qgi1JncPsFU7qQxUBqFaELty
 X6Bk90/yUmNPuOUswvnoseV7C7NMcaw0GHg3Fejxk8XFfmV6pGaAWAF10N9h+6L3QlFNHpnSbzb
 HWfoU7A+HRKti5v/XRS/A76kFm6DnYMbxTN5fUCTItaK5qQstSoijfIWvChuUlKPQjcuHG+4+VD
 DX8nNBHKJdu/ZVG7SdgFwz+Bmh3oVOHl9HZqNr+DDzrBv7sVQ8sP+1LCJ7NsaImY4bwLVwIcJ9d
 xRdIwLT2I3XHsc3fyev9L9vh3VKFEg+5hg00wgmgIrxsBDkOY6gnynYAoaH15S3WfCJTOO78GtC
 KPd3R92VZBpVmw6gYhuZ0gn3A/xau81hYXpWT2dzVO9qG12GIo5DXf/qB4HIH5KFX7iYkInZ9jl
 fjRytHU+qZJ3UOzGS14PWiMkBA4QWX2MWni/4WZ2REpjCWw
X-Received: by 2002:a05:6830:411f:b0:80c:d34f:5f65 with SMTP id
 46e09a7af769-83098b1e66dmr11391397a34.30.1791840048431; 
 Mon, 12 Oct 2026 14:20:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:926f:d0ec:bfa4:a539?
 ([2600:8803:e7e4:500:926f:d0ec:bfa4:a539])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8302f625a10sm10740983a34.0.2026.10.12.14.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 14:20:47 -0700 (PDT)
Message-ID: <30ad0f93-a971-4acc-9c5a-cdac831b3fcf@baylibre.com>
Date: Mon, 12 Oct 2026 16:20:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: mediatek: mt7986: drop duplicate dt-bindings
 header
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.u-boot-project.org,
 trini@konsulko.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com
Cc: frank-w@public-files.de, daniel@makrotopia.org
References: <20261012162656.6918-1-lucienzx159@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261012162656.6918-1-lucienzx159@gmail.com>
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

On 10/12/26 11:26 AM, Lucien.Jheng wrote:
> From: "Lucien Jheng" <lucienzx159@gmail.com>
> 
> include/dt-bindings/clock/mt7986-clk.h duplicates the binding header
> that is already provided by dts/upstream/include/. Since the U-Boot
> include/ directory precedes dts/upstream/include/ in UBOOTINCLUDE, the
> local copy shadows the upstream one regardless of CONFIG_OF_UPSTREAM.
> 

Nice cleanup, thanks.

> @@ -526,7 +526,7 @@ static const struct mtk_gate infracfg_gates[] = {
>  static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
>  	.ext_clk_rates = ext_clock_rates,
>  	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
> -	.fdivs_offs = CLK_APMIXED_NR_CLK,
> +	.fdivs_offs = ARRAY_SIZE(fixed_pll_clks),

I noticed this is actually no longer needed and we have the same thing in a
couple of other files. So I sent out [1] to take care of that. So I will
apply 1 first and then this patch so that this line change goes away (after
the customary 2 week review period).

[1]: https://lore.kernel.org/u-boot/20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com/

>  	.fclks = fixed_pll_clks,
>  	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
>  	.flags = CLK_PARENT_APMIXED,
