Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27C4CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA97F808A2;
	Mon,  5 Oct 2026 11:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YqSyUf40EUF; Mon,  5 Oct 2026 11:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D4E7F8085A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200735;
	b=Ndn5nRi0rSgerY4iMKvXMcm7sI4mc7Sf/GCDnGwsKXGdn5uqZ7Jkr6HxBxobYEyPVPfA
	 UpdpFnwbHu519oe0FWJHg70Yn1jn7XhHyOsU+x77lVAY8kP41LzFvGdChM7kNc2bM4JDB
	 qt/ciC4PGnogb+aV8pi6Lp1l9p1l+8TMUdyQKbFtdlPQBY9bYI6STBsUIPsQUQZOmYjeX
	 uNs7DEGM5nVjcBaK2CoM63jqOVBuboKCucxBuXL9mANqOkvlYt1Mfjgu/F8Ah/2BQYkSi
	 HRQmp5DkREyja5NYxwIakRvji/caWVnd4PK8VqfttOvIhNcL9BKIm+11i0YX0CBvL0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
	b=tW6pULE2Cdy2HoqrtjgEsnl7L8wadczIe74pPxxUi92drzeo3/qY7xcTDWNeQiYKLQBT
	 jHmnFnwRHLXnLyickLZ4udvIexWjBZs5YYiNTGLx3RxEewDzu64AEGee7COMPfjhXnKNL
	 Mhft5naJ7PAgkbkJblgPCvqdm2MvtCMQoaRANi0Ytf4gSi/fnL7EsQVk0tjrtPpO+jrzw
	 XJaH/7niiyebEKRuHyt9UN86ig6vVlbeWPVy9w/FjC/HHMaAixxvRrr1MIAf4JLFyFk6Y
	 bXP4pfK1dxRmte6isETCxrmLiZSJlcg5EGhaRpR/K4ogtZCokxV/yNw4uERL/xQ8J4g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QWjdeucJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200735;
	bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K2fbB4F/4YwohNuzZWyt7mi03/U0lrqs7n/Qw68h1EPB/m5rcrMO032i+5o+ssmat
	 u4qtoMhDcmkHZzl/TuyMGOLYRWmW+DWZd/c7YszNt9Qr0qsuIoTueBb0WvEGVPsFwq
	 pt8WxF7ViRlfogFSf+5DKyRoBeEpBZrSyaVCVtoEsQ5irFqdtrQXWV/AjhMSQjp6nx
	 W12VT4TzUoz90nsUiYm2EvSFlutmiLKiqQkcQT79WFtA95c8NtZDiVGd3by05/X7pt
	 LaPPrS2duKOPK5MBZqy808zkrM27LpU5Dp3ZZYrKtKCN5N4PZYE0zszrwN4XSkBsGz
	 g7CbjGrHd+6FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E7F8085A;
	Mon,  5 Oct 2026 11:45:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE93734E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A04B68084A
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iD-gCXmR6Oml for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFF228083E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200607;
 b=iz/RdACgCGmBjfrPCRtUBHMcduDMzKMd42ShPq83QPLycHIfarf6O/32PE7P8EarRXXC
 K7/+Vja5Z+HOZewG7gxJjzF0Qt6DFeuD/G8MaSn2cGO1L+YyzkE18LTupfmfvK2iFsB+x
 kceUHGpeHMXT6I1Vybke5EoFUBwisI2ICVhAl9wjV/of3y0jNSqFDY12SDmXJuxleeH9Y
 uwFvtrZPIGFOLacK+CT795RPB7lWkHJs2EmZx+CRfQSV8oCmAYyfdoN4PeoPOnSLXDgIz
 FQefXHHtftcx2d4Yl3zD3GK1xa5eF0NKo2fZeJM9FpPHZm3SbPI9XyvO7bITJP7/eog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200607;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
 b=MElOrijhahKN80hUwfGM/dZNLgZI0gMUnLPOXzpeo3DkNtZQb6Lol3asZ4ygvi+zOM/M
 1XbxKrcnBVCffr6n5xShlSJle3rCa7Aa+ve/mq6M+Y4t17urA8IIstKWyE5NLfIf1vIuj
 TKtORqHU0PRjIC5mZ7Jx4Swi93kfY+7pA/ubG+3MffCp9NExcbbRyWc63Kymq2TWJ35RC
 s7dcJRu8pLxQqRDtauzFQ2XoJLgT0J+4KNJZ21LoX/mTl+z/xewTax1VywPDKiuEpM314
 1VNw7vT0qi9hCOGfLKkt/la7JoS/Ntf5wUFUbvPfQQwA0BDh+8IRcuIhe5x87Vwdh5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QWjdeucJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QWjdeucJ
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFF228083E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:43:26 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6afbfed31d1so1570104a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 04:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791200604; cv=none;
 d=google.com; s=arc-20260327;
 b=rT1fG+1cSaH7AmBID+nyy7qV3pF88RBONk4/GECRfoQUvXqnPUbKoWdyB/4wpVjSfp
 Xx641cS4z9TFwTabl/QY5E7J44L8AKQjkvcIcWuY6EN3zIndCD7y2glzEblf1dRMj+cM
 wmmf9o/Pb1CFY4D5ElbcGWlT1j5oQSvRgOMhct7DW0WirXA6xp6q5HxEdMq/s+KeNDBh
 FczvvjNJIwDDRO9OMxmGO1AM3oNN8feP1UCC5Y5jbKJU7wPLccytaSRcbY1EbYo7nVFr
 ZsUnZ1gI0YadRmiY/+RXak1aJS9G3mjLKvjnZsJ48eSCVc6hXrdQG6iQVMxz56C2GwP9
 Vvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
 fh=TDqI2SsAa+O6I+y5YyUAkd2CqyAjZE2axYKvqlJ63ek=;
 b=V/lKFgUiWoP057hhbLIHW3LcT21x9wFCUPgfJYkgl3BKzFoJ9oItdcOvKqnb6+vfwZ
 41+0s5Rct5hvroU3M422u6FL3TQCWSsM3hMleC0tF6i4c7P0ugRRYsJFlX7NWSX92cDv
 wTcpSVCQMf4Gd1MnhVFOgxZNrVa7jroQ5AO2r/VUyrYQYYaYd5cYDa2AsQkAw47Wxq3L
 A7nLGyZImkgLX2XnrgbuhrhlzsmBIzKXmfTC5lWVoyd6bbERESodjpfGI0MLnx+QM7xq
 mh3qBMyCvE0+zHibiIZmS4wYZ9KewiX+VYmcWofAW5Jb2YKi88GzFOrkD/wbq8n3MAvB
 KZVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200604; x=1791805404;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
 b=QWjdeucJAc80EIDcqg64dvbiU9YMypUvVccLFHyCLupC6AZlPh6YW8qibGffDW+bsk
 H0qWRZey0/BuVXxHEvTk+uOekhAAJJeEL+2k2BnDyJyKiNIc6otWeLQwsFhUrehCT/Rh
 Uzjaw5Tuig0tcGiXVy60J5IS4rv0E98LPaqAfHtS2wQRuXJK6SKF3Lh/p9t2KBXU7vp/
 7k38SKGwYfdvZ2Ky9VGcA9d5x8pyuUJJM5e24dn2PM0WtqFVsM9CdCthbHrRSl+JD5dN
 TOH1SmraSXj4ZOGH/laG7FzmV01+O1dntkuEy1iVWHdAw7zLRlDB21tYn98SzfsA8ID5
 ZsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200604; x=1791805404;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dkf23pGIKXLIvvyLDimzbB+D3YhY4D6vGw+qDpdAcwQ=;
 b=h5/Pi0f7AYpOvi3ehwsp/4qPUxw6slQJ1mcJLTxvT1COWXCt6Fr9kQTjhcAMTtnTtS
 lnkfhAyw4T91a8JUWLS9oLURn2ZBoJWc8xzJnTkhsl59pUQbQlLq4CbAJhKoXsbheuNv
 mgjaEBoSHK/xgkEnUcyf7auynhI5PU8jt2n4k7Fx2AjjNJER6ccFGvxeXd5bKaRu/Wtd
 Kj/ihJsehl+zmn5Hg1F4ytE+jo/hHzlsvnkX1CYBL4/6BfaxrBpIn2gixbJQmRjNSvww
 sny/hFvaPJtPWF8sa9RPPOVDWM4GaGEDoR+bc2Qft9Y3z0grny/lq66llXd4x2EaXGtc
 E5Pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxjGYICaF4VfJd59U+/xrT4liCxz6AHlLNL5GTzcrgGbtzBaqUiwyTssP+XU3zQi6gFOOxiG0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nDXPYNmaW6geKL/z1Nj2nLF/tLYlFOLXgN2rqTRw8a+u8jhmcs
 /pLo6k9eH+k5G/AjhhiL1DBnZIRoB40ndtSaySOqn07Ux5uyHmaWlcmlcgNvV2TXzjyFizC3kvk
 ftVxOBy5x5uuPzl4YF38DOXs30iHtblU=
X-Gm-Gg: AYBFou31rNpYOwB1m0UO33ubEd/4ZmLOAe1Qc3Ns7ghC9LLlwe8vlv+CpFO+82E9Kid
 7p0boDbBZrdacKSfriqJHQSP6LBqdCX28rhxssXQk+lhs2eCJhseUP+vIeL1FF2nOC18fowpJLZ
 Ce1fA11Y4XmpD7rpnU6SOfFUkqFCfwyKPPv0LmK9AMBgOnvFAOaveGpbI/StIjnyysQGoGFbW9P
 zwsK50VQrwhGTQY1MS8IxnIZlGraa09EpDA28z9lnRCX4S1aJH4XB+N3XQ//snRHIXxeZjVcd91
 BTIITPd7PVQjkpG4lG8RlXGBFWfqYzW+9vgp0C7lDBhplzQIYUubXEc7
X-Received: by 2002:a17:906:7955:b0:c2d:d1d8:b220 with SMTP id
 a640c23a62f3a-c2e4b29578fmr850430166b.42.1791200603635; Mon, 05 Oct 2026
 04:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-4-11bb20983682@gmail.com>
 <1f7854c0-ced3-40a3-a903-c3f63ce620f1@kwiboo.se>
In-Reply-To: <1f7854c0-ced3-40a3-a903-c3f63ce620f1@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 5 Oct 2026 13:43:12 +0200
X-Gm-Features: AclHuK_XSQ8W4WsWqzURgNV67egMrXBe2BBQHR0CZSQhlPzEAB2fwWeoPk_MKFQ
Message-ID: <CAC928HZ4pB_Qpt2DV0k2sEA3=k5j=EAAaNp=faiUS-nox=so7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: rockchip: Remove useless SPL_SHARES_INIT_SP_ADDR
 check
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

Il giorno dom 4 ott 2026 alle ore 20:40 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> Hi Massimo,
>
> Please use more neutral wording than 'useless' in subject and messages,
> e.g. unneeded or unnecessary.

Sure! I will reword in v2.

Sorry, but my limited fluency in English makes me numb to such semantic and
usage nuances. Any suggestions and lessons are really appreciated. Thanks.

>
> On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> > The ROCKCHIP_COMMON_STACK_ADDR configuration option depends on
> > SPL_SHARES_INIT_SP_ADDR, therefore the logical AND of the two options
> > values is equal to the to value of ROCKCHIP_COMMON_STACK_ADDR.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >  arch/arm/mach-rockchip/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 5ed774159be..8e377066a43 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -798,7 +798,7 @@ source "arch/arm/mach-rockchip/rk3588/Kconfig"
> >  source "arch/arm/mach-rockchip/rv1108/Kconfig"
> >  source "arch/arm/mach-rockchip/rv1126/Kconfig"
> >
> > -if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
> > +if ROCKCHIP_COMMON_STACK_ADDR
>
> I am pretty sure this was needed with the older Kconfig, however I was
> not able to reproduce such issue, also possible the 'depends on' was
> missing during early work on this.

It is quite common for something to be needed in a context, but later on, when
the context changes, something that was needed can become unnecessary. And in
many cases, it is really difficult to catch it at that moment because it does
not break anything, it is just redundant. I've stumbled upon it by accident,
reasoning about the linker scripts' logic and implications.

Thanks for your review!

Regards,
Massimo


>
> With rewording this is:
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
> Regards,
> Jonas
>
> >
> >  config CUSTOM_SYS_INIT_SP_ADDR
> >       default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> >
>
