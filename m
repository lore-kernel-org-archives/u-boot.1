Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4660C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEC0360BDC;
	Wed, 23 Sep 2026 20:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBeRsO6IdkIB; Wed, 23 Sep 2026 20:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 31C2660BD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790196426;
	b=soqLoaMMna21lL21VyG8Gj/bmtc85CylzG9z0YotL4YVIp3r08JyhHUwQvXn+Xfg3O8o
	 tIb+RdX69brEekt3gK8DkBrQar7rGYUiipsqxbbD34zYqqdf2lN1HhR+nkzo9arOvgb8A
	 6inggPX8J0tt7UEBdp0dJ+gmI+IovxtW4M4m/oD4KOI8jJAfZ7cqExgMDGtPI52r187US
	 K1G7DoxNGfF6ARuUHX9NUHduaVJRoVabYEGhJWNYQ+Ssgri3RhM8ocz5E7AiMNztvq2k7
	 5rC8lc1FST9Jp2I0vTAbwDkNf2IWOWAHBhSfEApmErEtnbHGaWpt4iRcXa7Ksrl5AVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790196426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lq8dXV6RcN4IFygS1p1F3XscrFc0OUHOyS3jaORG1a0=;
	b=B4Cz5P7iuAADKT88KmtH6TaW8pqP7xNFJBHm+8r6JjbCN4yqvoVKja60KPLcR+UXVwrO
	 B6y19WAtZXtxHb40ZfKkcsyjDcia15zKvEu8uZkYDv6PzXBwMbD9V+Tlua/7tSiP9qW3L
	 dvEeDvajEzTevzUoOGU4gFN4YR5H7oFZhskWCr8OhfPvJEby9cDV59UwaeLW5z+3iH7F7
	 0PG+zliRiYLACQK+q9Ad9IjRXNz/LyKeZM8X5XKhHyeHRKNrs0XNImDpPVMHyEHWuJNCU
	 cF/gVlHykYrLyXdWa7IQIXzhKl8mtvdzPgtUifP/3i/gfzJmBTqVawlkU6dEDkQJB3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790196426;
	bh=lq8dXV6RcN4IFygS1p1F3XscrFc0OUHOyS3jaORG1a0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IDmeT2P0LvHPIdgfKqjDtpSMXhDW+A4vZRIhTgLUmBUfmbyk13cCaxSPlXyEgCyHE
	 +6s0gziWy/aQN5qsZEBZ59Mp+lCu7aza1FbwRWbBxjI2CJLisgUZaN/mBCpHAJXvtx
	 OrFRKN6u6WaTBXFLRtdl08EGvVtBXETt3BNMPYhBTvU49n1P0Fir8+/YoUEYHEGIeH
	 ewOVtyn1WqTOYNZ0qp+nHdWzEpNV7LBmH5QqC9UjS/UC/3WOxiNXl+27j+OJ13OgKE
	 0ti5LShdXvscXaQusBgbQkrRQDTGXkOkMGSiqSw2Z0/eZ6OdR48mnbB8+7MUMWd3xH
	 Ip+CwNwQd3tmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31C2660BD8;
	Wed, 23 Sep 2026 20:47:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B74532F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CE7940270
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7LFVXy5PVlsV for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 35DBD4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790196424;
 b=Wozw1pO8topeyVXqIlgepMPbQ4dMP4Tl/1SD+3ZB/RenTFhlpB+8uAPEe33gRYdxgCpz
 eNdq+HFwyVkAo7Ofi5syaWPkN4lqP44KuBVeYvvJoknubdtRMBjGSsnZgPRbyuhMtLBue
 auJ/7ipjUHIR/b8mzOTfmwpmIBvQgHiQ+e3NCc175BxGuXG3nS5oXiA8/bBwz1mbf5MF1
 QZr1f8qe+JrMVMBbDAyFe+m1U/bARnC9Oyp6MjFkiLByaLO1jzpUolBnjf+kCVhZSQXnz
 OLWxiZyuU5cmlX51N280ckT+JJR7OMFOl0k1HRjxFCVv3phRtFPrjHn4kNt7UL+lhfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790196424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=lq8dXV6RcN4IFygS1p1F3XscrFc0OUHOyS3jaORG1a0=;
 b=Q49o9jdD3qgtWbCKTOoyrQcG09C1V7Lqcp24J/LOtwu+b1PAqXT02tDAA8zPVfrJRd/l
 /XGa/NqOi4iA5YbeoK+lpQ9k7ZVP2uVhc36ICiUHgzlTvXqqqxTfh8VsdEQWPC/0Vvoj8
 NNRgItTgiRrQiH0etMPIUfu05R7b9u9M5it3VfVcjj9crXUmO2fwr+z/VRJ9LQUmY+0VY
 umpH5EcvXX7y0/qrcyofz7MwWrqkRgQpeJKet1P+z8oZ6ZmG1t6sKybll49xIVniHBVeE
 a2h9a93m+feFHEk4KNjfgHw+qDKUJEAlJIrAKoPFykiAtsvWtIJvJViUdYQkwMPdgKw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XvgwnO0B; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XvgwnO0B
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35DBD4008A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:47:01 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-4693691fde7so969527fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790196420; x=1790801220;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lq8dXV6RcN4IFygS1p1F3XscrFc0OUHOyS3jaORG1a0=;
 b=XvgwnO0BOZ6+VunQDFH0a95PpRpt0xudipKtytp/h/f8lGOkNCVEtKP80tc6yNHfrW
 NoI3w+RrPDBSdBv0g/o0lRf547viuGPudIeC8dSFGl8132kyNzMp3FDQuZ0g6wNf/ZF9
 dhtTZcpGrf816bww6n/0YyfP4JV5GmoS59RygUQRSBHOdoDAF2QwWQhr44CvOm/xe2XU
 4Q2F0tLmdkruVoE0/Y2rEUEm5dPxeKBSIRW3Hx95tI3vt6T+ZS70jLhTZaSwrzOEGHWG
 0Fa9HlLlF7api348TDe8S7jyqBKtiAESxRSfjJhU+oYiykhUlYlam3/W4onph1KDnttR
 Qytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196420; x=1790801220;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lq8dXV6RcN4IFygS1p1F3XscrFc0OUHOyS3jaORG1a0=;
 b=Um09Hf2+eRGtJI8HNtJu5FXpU2ldaZqtoTsWtJgpsSt7MytBt2BMmXaTfYdBV5nQej
 ulAXZMhwac/vn9CjnYHHJEM1vLuCkoze3FdLI+KWp8BpxQwz8OTimKpEKi1qhv021+Hs
 EIbEkLuAiXT1XhgirvA4uG4uBr6zHLsQ0/oVVqfDSHllj9FsfcmrNNTEHBIiQ+8M6jb5
 8qHXk5d5uBwbAoNVA8+KDS15aiFRoHqL0ubwJqwYc8dZ+Ot6PYVuB6Qi8lNHAzZuHihI
 kD3b5SY1jLz4Ls7OrxY2gC5kEs/4mG97en2s93BuYktC06cEtV6MM9fxrkpN7EdSh5Jl
 /L5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqCorE1/FS6ZPLr2YqqRBD8887rEcj0xuGHm/vH7RiwAVyYvWq/TtFpGJ3GMWJVoFh8+eL2r0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nnrqvSY5roAoSeQYBxsBMWvIUFbZAkRrvBVK/g4uAACcqoxace
 1qkr/1RI35FgCn8zHFCGYTJUwj70OWSbCrEoT5try+2jNaKSexE5NHc83uebxjRL9sg=
X-Gm-Gg: AYBFou3lMJLbZGASQJlTQ3wI71vi6fR23+Ks+CurVuzmxsOjfgp6RmhQgqv/kqdZze1
 mtt0cA81u4s0R4eJdjPJjxOtZ08QNinJq6z9TT+xOEnM2Plt/on5tUxGqv+5d2xoQ8a3JRppsb4
 uAxZlyUc6AR6P4FlmbnAJkOUh/8tedut4lLx/ohmDdiCWvFx4GW7OPO14YGbhKoZIVZlNvdS4jm
 0sn1/7XznmB36EnjwMIydLtJGq4hlgAMLQ2iaMtMuSJYKqvOXCsvO2+jZr4teaEBLwZp+fNueTt
 CtBXn2dM5fVtKjgpZB+i6bJ+yj4gGov+6XTBzAVgLmB3YE1dHtukX8ofFs9RgFdbGnzyel4RtAz
 ggQPvrhZw2Joj1fio/WLQb+3AxBJage8/0/N2uL5VDjdb74Ub0wpfEu9sfkf3XLINhLca1As4tr
 arBuSo4wyCnOvb+nQwSYPwq43tHjKwmdjfxtBc8gBpJreDxOUOYXJHBRNg7uBI8UJRlAI4BAhbG
 CIxpvUA+PYMPuYnsL0kB8fj12H41MQ6Lc3FNUcoJxMb4uJS
X-Received: by 2002:a05:6808:4fe4:b0:4d5:2b09:a6a7 with SMTP id
 5614622812f47-4d72f54ae49mr441845b6e.65.1790196420157; 
 Wed, 23 Sep 2026 13:47:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d5c43a24bbsm3116869b6e.7.2026.09.23.13.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:46:58 -0700 (PDT)
Message-ID: <464c781f-ce91-4088-b29a-f698f3d6535f@baylibre.com>
Date: Wed, 23 Sep 2026 15:46:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] clk: mediatek: mt8183: merge the clock drivers into
 a single driver
From: David Lechner <dlechner@baylibre.com>
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
 <20260917-clk-mediatek-cleanups-v1-4-4dccf8ed98fc@baylibre.com>
 <defe6ba5-2625-4e9a-9472-3ca20b0e1c2b@baylibre.com>
Content-Language: en-US
In-Reply-To: <defe6ba5-2625-4e9a-9472-3ca20b0e1c2b@baylibre.com>
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

On 9/23/26 3:41 PM, David Lechner wrote:
> On 9/17/26 7:51 AM, Julien Stephan wrote:
>> The topckgen and infracfg U_BOOT_DRIVER entries only differ by
>> their of_match table: they share the same probe, ops, private data
>> and flags. Merge them into a single mt8183-clk driver, the way
>> clk-mt8366.c already does, so that a new clock block only needs a
>> new of_match entry.
>>
>> No functional change.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>  drivers/clk/mediatek/clk-mt8183.c | 22 ++++------------------
>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
>> index 13fee7a75a0..08e06c60f68 100644
>> --- a/drivers/clk/mediatek/clk-mt8183.c
>> +++ b/drivers/clk/mediatek/clk-mt8183.c
>> @@ -797,15 +797,11 @@ static const struct udevice_id mt8183_apmixed_compat[] = {
>>  	{ }
>>  };
>>  
>> -static const struct udevice_id mt8183_topckgen_compat[] = {
>> +static const struct udevice_id mt8183_clk_compat[] = {
>>  	{
>>  		.compatible = "mediatek,mt8183-topckgen",
>>  		.data = (ulong)&mt8183_topckgen_clk_tree,
>>  	},
>> -	{ }
>> -};
>> -
>> -static const struct udevice_id mt8183_infracfg_compat[] = {
>>  	{
>>  		.compatible = "mediatek,mt8183-infracfg",
>>  		.data = (ulong)&mt8183_infracfg_tree,
>> @@ -823,20 +819,10 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
>>  	.flags = DM_FLAG_PRE_RELOC,
>>  };
>>  
>> -U_BOOT_DRIVER(mt8183_clk_topckgen) = {
>> -	.name = "mt8183-topckgen",
>> -	.id = UCLASS_CLK,
>> -	.of_match = mt8183_topckgen_compat,
>> -	.probe = mtk_clk_probe,
>> -	.priv_auto = sizeof(struct mtk_clk_priv),
>> -	.ops = &mtk_clk_topckgen_ops,
>> -	.flags = DM_FLAG_PRE_RELOC,
>> -};
>> -
>> -U_BOOT_DRIVER(mt8183_clk_infracfg) = {
>> -	.name = "mt8183-infracfg",
>> +U_BOOT_DRIVER(mt8183_clk) = {
>> +	.name = "mt8183-clk",
>>  	.id = UCLASS_CLK,
>> -	.of_match = mt8183_infracfg_compat,
>> +	.of_match = mt8183_clk_compat,
>>  	.probe = mtk_clk_probe,
>>  	.priv_auto = sizeof(struct mtk_clk_priv),
>>  	.ops = &mtk_clk_topckgen_ops,
>>
> 
> It looks like we are losing .flags = DM_FLAG_PRE_RELOC from
> mt8183_clk_topckgen. So there is a functional change. So not sure we
> want to make this change or most of the rest in the series without
> better reasoning.

Oops. Ignore that comment. The flags is just outside of the 3 lines of
context.
