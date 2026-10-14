Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345FDC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 18:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0330680F92;
	Wed, 14 Oct 2026 18:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9J-48_QwE-M; Wed, 14 Oct 2026 18:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C07D80F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792001264;
	b=OvgpIcbiNTXdAmamxm917TNojLQG8JtEltMQD76HVHekaEzul48gV+gxT8jM20KIeWwO
	 YTxGoq0hwiLmuDYiIsbEpvBNJgSLiSopzMDPjeR3++l4lstqlsY0YV0zz04JBppesCkdn
	 dMTXBLrQJRqzEQ6yHRMkozTbIHowwkJJK1wSwdDhxeqQWAH15wNpTG5e56AsLJDDNWwXT
	 131GtNTn0coshbVQMfAq4OuyCbVZGJQ1g7QOcSklegw3ZTpxlPFJ4chyRJCM+6wo3CL/4
	 SOYnDcbzwhRJv6ah9Fih2kIrJvPkkDR1qLW5V2M4B7NrxfzC9YRvRf7EwS45sCJCsYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792001264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
	b=kvVKEmVObq2ZK9M97raSghYuVSOwg7rVuKcHa60+Mkk4LwshaX+Y8Pj8GWaz7DVml/1V
	 1WZ0IT8ytEpTyX7QOA/X5PCyIvbWoa5X/vrl4GQ11tadOblh0Y07NzsYRHUGHC+3fjcno
	 01OqrpZ0lxSNyFNbhvLedKQpRrZPzJ/vXjPQz9Lw88AGhR4hgrZJI304CW54R7jMg7oqv
	 zxp8xJBz3F3Nr3HxPVtCXQ1PLZaHd8+zGbVQEpjhaJFJdk1dV3XPlgy2MKy2j9FJHP+AM
	 eHFXZ/M5Qdtke3DRitNjn2QJ2aQzQ0Hi8y0t7IIry8MhbGNMtLYWBJTYelK1+yQUAYg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792001264;
	bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Neha9AhUItd/5ufQWnZQEXX2we6rQDCEVd4oZqcgSuamWTrgao4V7W0ssYjJ5YxnU
	 W3rn+IiiETLzdR5fCExeMJVZaxBUui3HKKAzJ31eTOVUoB/kZwcl0qCQmioi79gChT
	 EU+ibi3lVSRcWDwmFcnCI51tJqBLkFLHzrgNXenNJZzyfCpCABPbRaS72rLpWPUrvr
	 i0UKn6v21iOT1OkMlR809YgF+Vxc9bkUAqGy+hno2vqF7Q4K8aZwTt+3CZAugQturB
	 +M2O5eZxV9o4q+XbTBThBFLi0AYVGFGNr7QUZy6tmkQBnV8fLjzLwtaV1x5YH3JFM9
	 44ql8f0H8gAXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C07D80F88;
	Wed, 14 Oct 2026 18:07:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 071C24DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C24F360866
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sz9HpbFpW_9I for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:07:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D974760828
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792001261;
 b=JqLthbRU03i3bCOMzLIM0zW9sU9P+Au56vuI0HqxcW3V1e6qS9S1f83seHnCwgp5VxnU
 /qtD8JWKZUWm9HN2c9j9UOeWVwRMF+iZshldNhZQtUeNekPsWBWvzri4alNGv9URtXIGz
 lc/dtZeBhs+4w9QA0imRkVWhZtwCPdMqgGN0GlwC8TI3mzROmaoBKM4lr0pOmJYn8iX7p
 vH60QoeB8bzRNW9p/IOwv8hmY/6bmm8OKzawMPP1LST44imSCpCfM9Q0DpE1hRLd5vlAi
 xDbpf49wu0aQnAgWw0Pk5T6zUXonWXQ243YrB+oJn5k/ghHGiOaWO9DhXZ77FpNjbxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792001261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
 b=lDvGs2Zmlggp+QBsvLiclvShNFItfngZ41MgEBIFe1wWf1z2UjddY/DLyuUKDTPGc/Rg
 KB3NTf71npBYFmk/rab2MiKjIkf9g2/hhZF3KKF8lhf/4XFWi0J8t1Y7/S9tl3h9gVPo5
 5q01ChxRakNlErBIT8y2h5qMrvs4IhE/rpGemsZww+74D9k9nm+L3CypWGEM0Hm1Y2yIZ
 OUIHwswdWJ9YnkK37KUE2Bvn14aJQ2ZLJac0qLzIUu3FSb2rQS3+Cr7GOYHfNS+IKBpEb
 dMOOV2NSQ+zPxotKu1PlNxAodxyCWpLZ5mOfTwrqkoNyyGitVwALszc4w1KWTpeRdmw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PbrjSO20; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PbrjSO20
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D974760828
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:07:40 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso245333666b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792001258; cv=none;
 d=google.com; s=arc-20260327;
 b=Xoh+dJAioAsz7DbeDaP2Ih/oIPqVNXa3Lp6iykJDtnw5infGgHPfNM0uYUyhZ1AYhG
 O2XYnHgjGb+cpTOlLrr107WGwyR6On8/XmNGL5rB+DKgnKO8SNsJJhwaCNOrDDLt3ttp
 pVuIRbziN+H/hpWBb15XRIIramKWBaPlMyRPTLyv3yuuj/jl5+vDgQm+0i4rkF7mYa03
 HhszRI/ItAor0lyRoYrY67u1Ked30bjEQ68V86F/V8qX7e6lQcfq0O4rkQc9H4A/rhuY
 9kQI40jkHfKCxaWnL/QJGeRvCXtoIRVPbYekEBlhcX6CCQWyEziGjWBFgz7uVHBH+EPi
 BHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
 fh=PVeYiUanvaa3QCmcz1IhswLwI/9rldlPUwZUkfFIoBA=;
 b=ViCqz8/IivtZcGhz3PHYoZdkzzK/3QchixHDOyMhkDbnSNEuH7WWOxX3bRtbp+JI/3
 uv8zhJyFbeBJdaaNsnU0oeyLWVODwf1kqVgCptDfGF+N5MnDAyWsakoGxJgH+Fzgxeqr
 lB4ogIghqqslM9dJuaonEtTAEhkJSLWqc4rjUUSgdL5tqszoZtNeOeFSXUvot0/WGW4G
 BcnMCB3ylaTZSyl/rU0iyFzVM2cV63AoDOxnTv48y2NSQe7JQDqGzXpzYcYCy0QZhSWh
 0TQDdDtOs0dNUajT4IaqIqkyMvbKVpwEvpA1sZ1qWdQuZIBcok8iae0I5a8+VwMMrloO
 +YEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792001258; x=1792606058;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
 b=PbrjSO20dNCRKqKpIBAGA2MK6KN82hmG7b51feoPviiSWpXwzvjDOaC4LEuTjGHFlB
 ow6YO0mGWg/nZ5YfPgY6tzvaw55tAI7Nr+gQCCnK/ix2nNBfjll2SpnXXIyDi6SCO+EZ
 wwt7FWPXhN46dvAfvMC42yQZJDSHdjYB5uXaDXsfgvU9/AWDSzVcwsdRE8QBd8vwvSSP
 99dC3XkKWJbg/Tp4Ose2PzF/6xYQpHNNTD7mHHVmFAvTyqySVvlIwjhQSi7GiDngPHoW
 JGoux2jgNfrl1u2JaXpBNRAx3j/F6XT4X7WwBb7bm+dqsmosAqlZf3/VyVje/8tXaB+6
 OThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792001258; x=1792606058;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XB8+1Ap6B0AlYFQjCzy+90dvhq33x6+WKF6DE/uS2sg=;
 b=GYBF8vmFqHzQ29XiuhMYxwsn7bD17rkFTUtzWN0afxexisrTFnCOBSLpXN1JSlMkDR
 c9xkBOllJxRBtNCG5kBmUKRaA0N55Kb84fiA6RDTA4NS/Pog1Dbf1ZSPPu9XaJkgfV0Q
 FoXK98kyOqzIsbj/5P3IlHStnALfCvYAU3urxhkV9aCNkCL8IEOFOcCxnuOrXwUX03GQ
 +EKS8gNBscp1rfHWRRcKoYaNvPnxH1GFQXx9OHArSzXjaJA1XLpsA4ACI9ZlFjSaSr6V
 aVsEFTvzMMMRYovu8/vLBM2u5CzKA69LmBpZgXuIkaUSTSIxOcJav/xFbfjBD5ba5tO+
 xRRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPZCdNfKYdcnHVpKkX7rf3lUuxNyv5YaZ7HFqaNjDobyw8viIJh1vLzqarBpsnJcN5JfkqsPU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOH1fzgOzv+jXVnII8OoDeKRTJYF+7dMgkAQ+jVus8RbqW33k6
 vF/5dkzU5XRXYC3DyFRzv0rO+u1Pl9nDNp22Q5hZdTRWXDWmzg8IC3vRa2YgEIOnDAlnR8/GfbH
 8l81jBwrKRJiD2v+7Iav1Lc488KrjOus=
X-Gm-Gg: AYBFou2wxWK7hJyOSZBIL9l8URC6jtye9+pGE/R0s4BqqM33znnyEIh/WUkIBtdQZRb
 0W1W2xdojbn+hWPtB3gIST29XHe93eV3Lz4KvPt18nolFoaZGRw4+LY48beirR+3Z0hcJRwK+qH
 sWvX8tJRNK9Efigezdcw2JiWXm7fVNUnPEeeQGeK6RnAwOQmAQBLlSK+D9V4hMC/XPwAV0hR3ts
 li2JLcxG2ivgqL2QDo1Q1OTGoj4lkT6nyEc5uCLcob6ItyoXl7HjiA3xXYQAjrwrv4e1kbdj5Pa
 8IHoH2ArYsQrXOm9KAsCyyNS9orjiN9o/mJZb3aTbOb8tAAa7OKCrSZd
X-Received: by 2002:a17:906:f5aa:b0:c2e:3abd:aadd with SMTP id
 a640c23a62f3a-c31aa093e85mr1445289266b.37.1792001258084; Wed, 14 Oct 2026
 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-2-11bb20983682@gmail.com>
 <f142680e-b94b-47a8-ae9d-f793a5d043fd@0leil.net>
In-Reply-To: <f142680e-b94b-47a8-ae9d-f793a5d043fd@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 14 Oct 2026 20:07:27 +0200
X-Gm-Features: AclHuK8V6JlDXYgWMdoZif2VHeW3O_JgTyrR8vBr3MCXX59TzAj45hHaIYj-_ew
Message-ID: <CAC928HYUq6rijik177mTxMt7Khu8QBwywrt2H2f6CX8z1r0aVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: rockchip: Avoid TPL_LDSCRIPT configuration when
 unneeded
To: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>
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

Hi Quentin,

Il giorno mer 14 ott 2026 alle ore 11:31 Quentin Schulz ha scritto:
>
> Hi Massimo,
>
> On 10/2/26 6:35 PM, Massimo Pegorer wrote:
> > There is no need to define TPL linker script file through TPL_LDSCRIPT
> > configuration option value when CONFIG_TPL is not selected. Avoid this
> > useless row in the configuration with no side effect on binary outputs.
> >
>
> What is this helping with?

If you make generic-rk3328_defconfig which has ROCKCHIP_EXTERNAL_TPL=y (and
therefore CONFIG_TPL is not selected), you will see in the .config the line:

CONFIG_TPL_LDSCRIPT="arch/arm/mach-rockchip/u-boot-tpl-v8.lds"

which is useless and misleading. As an example, if you use the qconfig tool,
it will report that generic-rk3328 is using TPL_LDSCRIPT. Indeed, the
generic-rk3328 configuration profile does not need any definition of
TPL_LDSCRIPT because it does not build TPL, being CONFIG_TPL not selected.

This is what I meant by "Avoid this useless row in the configuration".

And by "with no side effect on binary outputs" I meant that the build artifacts
are the same as before.

>
> TPL_LDSCRIPT should only be reachable if TPL is enabled, so adding an
>
> if TPL
>
> is not supposed to do anything. menuconfig incorrectly reports a
> dependency on ROCKCHIP_PX30 (or ROCKCHIP_RK3328 if I entirely remove
> TPL_LDSCRIPT from arch/arm/mach-rockchip/px30/Kconfig), but this patch
> doesn't help with it.
>
> > Involved boards being built without TPL are a subset of those based on
> > RK3328 or RK3399. Anyway, keep aligned PX30 Kconfig with this fix, too.
> >
>
> Yes, but PX30 force-enables TPL while the other two don't.

Correct, ROCKCHIP_PX30 selects TPL while the others do not, therefore the
change I made in px30/Kconfig has no effect on the resulting .config file.
Anyway, it is correct to bind any TPL_LDSCRIPT secondary definition (those in
the SoC Kconfig files) to TPL, because this config option is created in the
context of and to be used within TPL, as stated in common/spl/Kconfig.tpl.

In general, this approach helps to keep configurations cleaner and simpler.

Thanks for your review!
Massimo

>
> Cheers,
> Quentin
