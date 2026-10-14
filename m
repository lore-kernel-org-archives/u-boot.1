Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BBDCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 18:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BED2E80FB0;
	Wed, 14 Oct 2026 18:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ID7zDyDayFEB; Wed, 14 Oct 2026 18:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1CE780F8D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792002345;
	b=Rve2e6YxlqBwLVYHSDdcu7DkNTANHErHauYth/NFd8KQgoCpTcQOs/lvE/5frLPmfML2
	 y9cZPh49VOe2IN+Vma3zBAHmVcU5+skaq0+ZWOowwbv1ZOeKm8rmj5GHX9/HhSy+aWECM
	 9itJsyM9Lad1vxomoZiD3jTBb8MpCgVFPfadRP7NAY6WnGrWdzBO3CY8mefohvFDWiUGM
	 AzYyhbcvKxUQodPMAl0ql7C+V4PuxxVF+YpgYvDHk2w8hT8cqIi0ygWVHtwibTtkfg67o
	 avkZhX1/fwX85ycUoa9jLHT7MZ1Dl0O2mM0Y/yuUObDnp6AkMGkGNHER0i4/rsJtwQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792002345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
	b=Eg9EkWSMANv8bSEslVj1jzjUZ9Ik887/UMbVBlp01x7NHulmBU+8PjXwt36B2Xo2GLht
	 NX12V3dnLvggl0bA02awhlUiUvFPCXv6sBZWP67WiTNKL4tktLH6Og2lFTZLQyVTb4KbI
	 GNsi4AyDiv5RA80fr79Bd9AMfFwlwro2/VgM3nS83wSH39gWqecVtfnLS586SrZKsvMxU
	 Y61Lo79C8hDAJq7/fOb+L8b11Dgf+O8XvrxqB6+5He+uSJEQOfFEn8SP2vZXr4Yh4HsTW
	 zhBWsZOZkuc2ya4RUPWJ2fafeoD1dhg+607fu0gwU8Ziovyx5U1+up8ubHP9u8B7Syg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Aml5K/BS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792002344;
	bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=whE8oiqPJthKP6v2XejTJ0i8oaSR+g/WOZTE47uDokyLzgv4ph3TGvd1u35ZDxYV6
	 hR46X0602PL7wXpu57HPMQzV08Sj5GgfWhtatbXixqy/ZtOWVA3TyEW0SWEVtCH31G
	 Sfc0u/WTuos2ZyqBaAGCQ/czCnR7xK4/gSk5U6rfUOX1WctsjDeOn+eYGhaeNfNhe4
	 1QDr0UCF437Pw7dzPt4PSRRbwtnTAquu8liw9LXNLVE0MU854CbQz6+/rvP+HXTkby
	 Vl9m6nTak8MBaE6tc33IuJmalKJqItcDrWlsysNpTbTETviabu4hNWHeII4ugeyOHd
	 wRYmVZ9e7i0Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1CE780F8D;
	Wed, 14 Oct 2026 18:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3203E2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F38380F8D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErJuqjun-JoZ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECE5680F8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792002342;
 b=E2kr7b0xM1gQ3lETLpYhcLzgk54/PGWrH8et1Y8O7rdjAKGJaToRawu+xuPS2Ok86wPy
 eB5Cu6StiC/3ZyuJND9eJhqe0IFd+NbU7KPJk3itDFGxWUjti8DwSs+6Fwoh5fX+PlkkY
 0qwFAsf/SHf0pFb8VQTL1/viDEGnVPSxS+LO7L+afSAXlYvsPXu2AMU94WkInyDas221z
 WGb3J/8xh4jhZhXg+zHJhPIS/22+SGwBUhbJgUkyDcR4mi5aJrghdKBBP148pews3s44F
 aKEHfUkBSlIjB8bErapCAMMs7THOWWXlhEXByMxqN1dQpdbCFvuvVMGggtITm3l29/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
 b=C3hi5EwyKP2Rnoa5Q0T1jTZqvZiRklv2ZWjAqzkyGC7ZkcafbHokJy5SFlmtfPYH+emN
 3BI0v6Xg5SNsU5MAvv2aSf3YApZIa1x0pISJ+yrlNqSWgaA8Vxy86o3yA3TIge5JA4r9G
 q0Y98bzzRKg9/2lJSKU+HFBv1i1zo6sFWZtRbe4DZRm6ckmHDAUJYtFwTYOILDUeAZlwh
 0G3SSJg/qhTbe6bi9mJeMNOR0sTC6F4kTquaZGEq5KnYJ9JPmsMyheA4MF5D3HXSV+zZ2
 4yCabF0yDqVolM3+JQ9f19FlNUtkTvikrWI1pchO23zDaBxAzJB0se/0U5c05bDqqcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Aml5K/BS"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Aml5K/BS
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECE5680F8C
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:25:40 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2e8e738ae0so790252466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792002339; cv=none;
 d=google.com; s=arc-20260327;
 b=B3ZBG8AM9GJZg2D4AD1XbDSlP32ElA8UgTx0/BRyXEZiQYdm8GEEwi5ruox9DapZcG
 sLwbTutZRM2LSpGcqSLv34nEUY+u0moEARaODEIdg2uNJcftDr5UwuFPZVNZK/POaP8A
 hEgwn8FbYka2PtxYhK/4rjuy6jqRUFpeJqNmBPGzdGmTd9LzkxxPCyg4SD0e9kZXGctG
 X3TNdk077w7m2uqbBV1v1rsgaUVygyr59EzwvMd84NbONrUbb5tQAUqpo0Wk2RMJXZdF
 SeTTDSQG6o86lPY39dBZAOaZ2+ibkhChcibD/qYtK2d/Hy8G8tDbun7VDfgyKMCVJYok
 zH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
 fh=yZbDj3PUQbZRtKnJT8zvZbTrfcWd/E470RhFn+CNkNE=;
 b=f7MxueHszPdKQD54EIAz8HGOcxt7BSpqQVjgcHqdmJkuQqz7E+CIuT3oGG43+bLPCw
 9qKfcv4C27ZEIeSXeAhDKTPIU2pJbwWX2lvDH+8GRlmHT2LvZEZlJI1Crl3iWNbm6v8T
 ff+USoG7qiMS8TRGHh2IgeSrytduzsjEss5rC6nQV+o44l030deqn3lQExln1YSEOBQy
 d29ZyzCTHKrIpURbF+opIhT7iLarroZNrUbzm5y3iJn7iOVOF1FF4epNUlm9jEvxlXfe
 ArYhT+p10xC9s5noSwAMUtAI3YR2aPz7yLI/HY+WDQK1ZmyVe5s2xUz/03l6TpR0aeKz
 igXQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792002339; x=1792607139;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
 b=Aml5K/BShEsjik5LLqi+utUledT1J5EldhMDlXR6KMrKffgqwX3CX1Vm7TNyM5k09J
 O45c11LvBZy+VtYbhs2MJNIVRB7zqAsQE3wpFpmAqzwPtdEC5RdJp60uwzJKsSQJGdOw
 4eUT9uQvVLn1eaWcWN2xMoPT/U84zahRgS1iJSVBBqqCa2+bCyr/GtWcwHHplrT7WtGf
 IzU6SmwrgOGAxNBtEWlgZFBNixDaHl3j8AOOhoRD58F4wkz6Hn+9C/v2DrrmGUx7ifHy
 dsD4EgJzQ9YYyCCDXC8mPplyrzuYJNMciNBQm6HgDdI3/BVulHpKVAHSOTJUrmfJy44t
 b5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002339; x=1792607139;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rzctBeA9t19alAi0GDaWD5i/ZtqoWyW2o75Li6AlJ0A=;
 b=xYa5FxPtrKUKC1w5R/SkFmP3yAjRuqGbS9tCYJhkOia9e4w/iVIM8RjpMSMC2gMa5f
 BjTj0O/3J/Bnf6AJUIqnnHuIv4PzP43nUqcOBJK8n60AYqv6Z5In0T05qJDuRKwmI3kl
 Kw9yDRF+mK1VrspVtz0BeHPw/DRh7YUwIXr4KYnDK/MoGYlStsogYCGgV30dGyd+xr1a
 VS+XXd+8HMWgKz5ZYY+V41tTZTWc9qZ93x8pnaGS9z64yyUL1krqWADaxYz2bbMPS7bN
 PvCi5A7dvKu5sV55jIXm9eQuf8C73lgPKGFCC4UQ5yrmlk3HzyTox/KVDmAeR7kISrja
 ZiGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWkbSJPrz48P3GB4yzP1vw1Z9IFK7Me8yAOLABsNyDv3TDAg2S1dwQGOJKLq2JgG00A53bR/U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL6oauUqOQy2pelMFMruU63IvAugFPPLnnbxPTER4v0s68T8JQc
 6AjnHePR78d7r3Vh+ADqp8IBgmyCrtT5RDVr1C4eCHXZOqnwEAVJEWoW+/lhDco3IeueaplpGSN
 fiRTn8HYrSU4jueYOOg8CiOS5FDF1Cbo=
X-Gm-Gg: AYBFou0trrAZydMVqDnCqBB4Vs5N8gOQT/6DNh2cgLNjcF8EaLuxXIYrVu6QbAACcMk
 dL5KgHj5tbkyxRBP9tqtMtRSbaslRuImEw0yGwlOzfagThlqVLlJlcygsOyy6iHOa9L5cAnpanQ
 NvOsXbDHfPbdfnWv3iq/tcU/WcxsAHZpU7kimlgNNiBG+ot8OftJY7Ifpfsv5i6X2UGTPOCVQYu
 hMe6k2Mmb6qq6sFvY4FSu6G+Sz3N9L/Ru7KOvwKaiyafTo9nwdH5mePnseA1kksd/r+ytgYIebB
 ptzN71lg8U/tXHwEEmM5wrHpPr1JuJ2pEsfrZhG040ljCFokb/GE1OH5
X-Received: by 2002:a17:907:a310:b0:c2e:4e08:19ab with SMTP id
 a640c23a62f3a-c31a9afb4b9mr1604864566b.16.1792002338544; Wed, 14 Oct 2026
 11:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
 <CAC928HYDGxPsRWz3SatjTP7-d4GPo5ie6EdRpijxF6GUKEVOGQ@mail.gmail.com>
 <8e917d4c-4c0b-46bd-bf0f-84e75c865c8f@kwiboo.se>
In-Reply-To: <8e917d4c-4c0b-46bd-bf0f-84e75c865c8f@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 14 Oct 2026 20:25:27 +0200
X-Gm-Features: AclHuK_mhh3Wws-0aH3NF8-hL1hTl776A5h4HP3uJzVQDPkf5BnRTaj3r_2jhak
Message-ID: <CAC928HaHp-F2_-fCAihT0Q+nY4Hm3j9jbGzY988+vLM619W8mQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
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

Il giorno mar 13 ott 2026 alle ore 23:01 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> Hi Massimo,
>
> On 10/5/2026 1:44 PM, Massimo Pegorer wrote:
> > Hi Jonas,
> >
> > Il giorno dom 4 ott 2026 alle ore 20:54 Jonas Karlman
> > <jonas@kwiboo.se> ha scritto:
> >>
> >> Hi Massimo,
> >>
> >> On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> >>> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> >>> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> >>> common/spl/Kconfig file where they are originally defined. Addition of
> >>> a second config statement without 'depends on' guard causes these two
> >>> options to be put in the configuration even when the guard is not
> >>> selected, which is unneeded and sounds wrong.
> >>>
> >>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >>> ---
> >>>  arch/arm/mach-rockchip/Kconfig | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> >>> index 1a2e7847c9e..5ed774159be 100644
> >>> --- a/arch/arm/mach-rockchip/Kconfig
> >>> +++ b/arch/arm/mach-rockchip/Kconfig
> >>> @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
> >>>       default y if ARM64
> >>>
> >>>  config SPL_BSS_START_ADDR
> >>> +     depends on SPL_HAS_BSS_LINKER_SECTION
> >>
> >> This change is causing make to prompt for SPL_BSS_MAX_SIZE when building
> >> e.g. tinker-s-rk3288_defconfig.
> >>
> >>   Maximum size in memory allocated to the SPL BSS (SPL_BSS_MAX_SIZE) [] (NEW)
> >>
> >>>       default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> >>>       default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
> >>>       default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
> >>>
> >>>  config SPL_BSS_MAX_SIZE
> >>> +     depends on SPL_BSS_LIMIT
> >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
> >>>       default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
> >>
> >> Possible adding something like following?
> >>
> >>         default 0x8000 if !SPL_HAS_BSS_LINKER_SECTION
> >
> > What about selecting SPL_BSS_MAX_SIZE default based on SPL_TEXT_BASE instead of
> > SPL_BSS_START_ADDR?
>
> Unsure, the original intent of the BSS_START_ADDR dependency was to only
> affect boards that had transitioned to use the common bss and stack
> addresses introduced in the commit 008ba0d56d00 ("rockchip: Add common
> default bss and stack addresses").
>
> Not fully sure about current migration state for AArch64 targets, I do
> not have any rk3368 boards so never tried to migrate targets for that
> SoC to use these common addresses. Most/all other AArch64 targets should
> now use these defaults so it is likely these checks can be simplified.
>
> >
> > This seems to me more straightforward. As this configuration states, there are
> > cases where SPL_HAS_BSS_LINKER_SECTION (and thus SPL_BSS_START_ADDR) is not
> > needed, but SPL_BSS_MAX_SIZE is. Therefore, I would avoid a default definition
> > based on SPL_BSS_START_ADDR.
>
> It is likely these complex conditions have overplayed its need now that
> most AArch64 targets have been migrated to use these defaults.
>
> >
> > On the other hand, I've just noticed that the value is the same in the three
> > SPL_BSS_MAX_SIZE default statements, so it would probably be even clearer to
> > have something like (not tested yet):
> >
> > config SPL_BSS_MAX_SIZE
> >     default 0x8000 if SPL_BSS_LIMIT
> >
> > What do you think? Thanks for your revision.
>
> Please check current values used for ARCH_ROCKCHIP boards using the
> qconfig.py tool. If all boards use this value, we can likely just move
> this default to normal "config SPL_BSS_MAX_SIZE" in common/spl/Kconfig.
>
>         default 0x8000 if ARCH_ROCKCHIP

I will check. Thanks for your time in reviewing my patch.

Regards,
Massimo

>
> One goal should be to continue migrate as many boards/SoCs to use the
> common bss and stack addresses. It should mostly be older ARMv7 SoCs
> that I do not have access to that never have been migrated. I do have
> access to rk322x boxes, and have some early work for that SoC, but too
> much other work to try and upstream before circling back to rk322x :-)
>
> Regards,
> Jonas
>
> >
> > Regards,
> > Massimo
> >
> >>
> >> Regards,
> >> Jonas
>
