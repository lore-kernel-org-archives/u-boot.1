Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9E606A31F
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dxzjQ7e/;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E3SAiObg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B78DB4059C;
	Sat, 31 Oct 2026 09:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SdymY5YKFHLa; Sat, 31 Oct 2026 09:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E18D40AAD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439204;
	b=O/RGk1nY5mfPHqUBuZ99ApY937mjoExg0aGHmkGSx2ceRrvoADtIK/vwkuBy9yiY+A0w
	 vctTyY6n2CNSUQfFxMG8cgatjgOjDeWgbAaqsW7tNnvS7Vefm8C9VX8vBFLBagGegdZGK
	 Dv0xhsshXTtIVe06rvYGXJY0E6SYNdEzHDfjyliNjhyFeiVF4ynXxprCpbwixxX0kYhFf
	 UwwSm+stTLos5nEodOCRad+0bxdzZVTXUzaqNWcwnu9MW3YQwtNBW2yk7Udx0a73QiGwO
	 joywOBHTa/zgbSgF/DWx+3E+El18vVclmESfVn8ZuNqCR81X4dzSo8OwEqyqoGP48vg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
	b=awtZXEhoxZofIYrBoCXlTzlDlXbW2vihFKPbMtPD+bQSD8N6Whu+tvygu+ac0/unS0CP
	 F83GdY9VvP98yn4mGcaoW7MBt2yVbQQBpWnb1SCmCeblLjSxx6GVRAiy6mzpuS8jHTtzF
	 F8nL1BaWT/2e3RlSBqqsB+wA0JzB+sOk7UIX7xy1p5+82sV19uzCfySAR1J5FDcKcOipy
	 YXadsLjIJwhEdsVEJQAB3otk3qmIWMwO88S2wAgreYp6MTTJg4IpNSN6AjBGD4IDwAoEu
	 JlONtXf6lz3LMblfGUewIYfNxLg1FSUfYsVav8bDfnfhIHXfcw4nBS5XbKxCyVhaJ1Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E3SAiObg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439204;
	bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dxzjQ7e//33+CztkWZEs7D78cr+We7Y9s4V+6hqi0gXAV/OFrkoGHwFLN0o/Gy5g2
	 bXa9bwztugaI9QKx4lpa/hp+TTGi4U3wNovjSZf5NnjN0N5rLaoWHoisZ4g47UqYdw
	 aNN406xMLB+2Cd80I1tZjwx4EoDBAdcEjKKaywbLxxYcgJydq/QdVBhWNCNxWBfveW
	 ohAk19PnhTi5pTrrdE/p2rzdZWyavlGL3bafLIKGsgZA4U4aL+Gtpc3lUr4HqU3XEE
	 NnBz8IqIljwy9wBu34JzJ1T2Zb8sDYKwOz/VuRD8wMzNE4F0QTtyda5la5kCo4Fobi
	 mCBYNb9ywt5rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E18D40AAD;
	Sat, 31 Oct 2026 09:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B7B4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8627140AAD
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msXpsEwvsdGD for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ECDF24059C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439198;
 b=KP7Uco7jHJo3B/ufL1thE3iKNCW/R3uILtPlc0guSGS+bIWVGaXVvQmkcrGQXtZm5317
 aJG1M9bJWCv0BidZ937WLInh84EbKVFfzhxpMigSI1N5yi4BTjl14ksmsO9s1VW0oZmlO
 b8AIyOAH0WY/QCF/T2GN/7LZT/dvqShyOdpxIX3OwgFCJrmvsdJMl8ftfuScrf0Jp+P3w
 zzsa+59PCFhJEGWVztGVwIv2e15O0irxlorps7V2NFi9KStpQFPHRlQ6pYZdNcZQi/P4c
 fbNbOnYII39R+2bDy4hRIRBETf1LUcYxryyjGZgUNl6VxLh3HdJRlG6zUF7VUmCQdqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439198;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
 b=iWwstbUch9yuamg5V9xB8X2Vr6u5cUTG230WrhxUONgGbS2q4+BBowrELTl8VjDYuLEk
 IpUZkC4DTTORFaRiq7OesoHzUboMrIktDx7frFQOpprjBUQ91H/0jSxtxI2ToNxYLGNw4
 AZHFTpDSxuNWmbQaw+9EyOFU+026aqOMG1NWwaWbV3sfvrPR39uP43eFq2ihvWXSsVLFu
 cyEAZIxB1HZgY19fDa+HJE+dMy/A3S5rzUyHviOWUOWSZWPdXc9ws1bt3+uxEgEw4GSEq
 mZmH0jnzgHre1n6so+JP47ceDyBbKC+r7HeaIWwRig7Hc2qDo7BxC0JjnXkyDSnU/lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E3SAiObg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=E3SAiObg
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECDF24059C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:17 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso539842a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439197; cv=none;
 d=google.com; s=arc-20260327;
 b=WwjZh1mNnNSIonj7Ke0WH4lnRpe6lu1Ixjb+QamuztGxsJqS1pqlKnTPV1YfzSnLq2
 1504UHh8SmnNG9v30Ppds5FjqOz1M+EwuciZesI6lLK6ywKDtLoe63vovuWf+TKhoUIu
 0l8V3rxw2kE64oYCs4sZquRTaeoV9JHMGzjhOGJI635k3tOdYj5YSfnkvOWDN59J2r3q
 UQJUo0C/aV8vrot144tc/IDdKvlBQUNI2sQIvabMT5PyNmiNxrZ9bKxhprPUbn1QggZu
 naGaKZoKwxBjYsp6VCkGL4N298ORb/ZBhvUYlXFRe/JYF6o3FG1WvVw5ZVvp5OcLAcL4
 Mlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
 fh=DTsnTjtIOxm2ZR6x9L1QrLaJh39UCQY8gFdXigJ86Ts=;
 b=kQ1Co8qtys8Bim9BSunJLuJr8MTAzCskYAGXvpuxCYRLoUxonF6nMYXNwEofzYIZvv
 rr6wDFN12EFj2bOS/gdAKVcTdtbTdeHZmqTZ72vR79+FxAGKTQo/JVOCdYxNV49cxD2X
 p0nDwFzFeGiTnt4u5s28NLZh9xWFNg9j6ifkVuv5FkGcBpa9cueYIOea+u4pDI7Rn8dZ
 NTQ69/ZM6X96qaeoe4ojcL0DMKL+SCkHLOH3csiO/44KgI2AosXNFJ+yJihQ3XlAgXud
 vQ957L+f2KVo8IeJxhs9l/N/Lpf6IpZ2wYuJnQWOr89dQQBj9yX6UVnuT0ZNowX+fCuU
 MDuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439197; x=1794043997;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
 b=E3SAiObgH2+fzxAHlVKAz37Cv1nfcbO5HTN4Dek3W+FhCy+3isrB1Lxu+mfEyy9qIJ
 /aKn0h9J5pH71cmqffBdTmVBF9XUgwT1aVCbqc4nlq7G1oB7W1o+HOtOAAFx+KM/eWV9
 cbvZnYBUU1pZ3SIyoe9ZHML3b6NbTFnCc8zrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439197; x=1794043997;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p6TLqS43Cd3ylprrEP75FWjWBsC5XWRGDp2QrZeRn4I=;
 b=dLwcbHVwPuZNkl/nFht1IGgB74TsENM3Eyd2yP9DfFxSOKDdM2n3qvz7Oa7lbJa6oF
 +HXYyVFT9QoV03VFX/tB01ZL2vY2Z60UVZHijfVhjIo07bNmfOjpiuAeMWqwYV67zi3E
 eEYu0S7oLHglo7kmmZgPTJmoNMO1S61ShuECAOh7g3+U2auX54EoeAO4jfDZzBNAENw+
 pdzYHVzC6CctUqcafdpFqbJuMUj0d8ci/p0vozDUeuUwaw5GKae6KjNf6pFDhjV4kcVE
 bcOFMqydqT1XEwmeJ4Hej18XtYuocUnkjvSLz9FLiJonCVj5fNNZ/27hIN4FsxZjW/H8
 jPhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuR5ye4rSyhZokOTKfZTVTzFl4cpFBmK0YtcOo+0BuiPf+4q6yo/jqLRzDHGLHBnnTn1Krw2Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIj6sWeLBB6nLr2tH0zDdavCWqSRVKiK6tLASLPrirUnA8fbtQP
 Mrc/l16iRUWt+vHoIHHYQJvbWxytSQ5SgP/pyBR1HEfZv4/yOChy3YQ3BOi5CIr0Z1U69fyMg4y
 9QbwForPtJPuo67xMulbLm8BXD+g94iVbyWIMZsMnZAFRDyKh8DRAFg==
X-Gm-Gg: AYBFou1aVfra7IGWVxOG353YnvqvzPwmHeayOQjmpmgsbZ1kiS2dlc6h97t0juOeZxG
 K0amOZY+toTgCc+Ern+y5PlgiRj1SjUH9/vFRMCrd1AIKS+yM7nQLboz5Q/A85M4StrmZE+nGCI
 9a6CH2Rep9bzDnbcwGRucJguZgpOL90fwq6NJUpt/cQG8FenHjvfz2p+jo44A3S+a/gDM4WQR3v
 wAqi1SPJj5uKXqsjmttmIRu3qQw1sG537H+4HTKbroXU5FWFpps/wgLUWmyYkTRnhi8qka1htan
 tru0egFt5uP+nqtylbp9i/m9KQT7HSJC7fy4obqHiE739pJTAeR88f59cQSr+P9dw+V0LIjdjKf
 qksugoWdVcG5Zar8bQwyo/J0/IG65n11umftJmrlk9pX4rN1ZSMXz37wqHcr0FzhWmqYP7/8=
X-Received: by 2002:a17:90b:2d84:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3ae8983517dmr3869099a91.39.1793439196812; Sat, 31 Oct 2026
 02:33:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:08:58 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-2-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:14 -0700
X-Gm-Features: AclHuK8tOmXg2hhPH-NAKvzJed2mYioSlT--U4euatoCdu19QwQxJ7qFYvLS2nA
Message-ID: <CAFLszTjBPOTfTSY9hTL-=5JVbq-ptMp1qzQRKg_ZMcDEPYxo9w@mail.gmail.com>
Subject: Re: [PATCH v2 01/37] clk: rockchip: pll: Fix fractional PLL rate
 calculation
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: pll: Fix fractional PLL rate calculation
>
> The fractional part of the rk3036-style PLL rate is divided by
> postdiv1 twice instead of by both postdiv1 and postdiv2. The integer
> part also loses precision by calculating in MHz before converting to Hz.
>
> Calculate both parts in Hz using u64 arithmetic and apply post-dividers
> on the combined integer and fractional parts. This also closely matches
> the Linux implementation.
>
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_pll.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
