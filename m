Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0399DCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9980260788;
	Tue, 29 Sep 2026 12:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3aPa79gf4r9; Tue, 29 Sep 2026 12:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9842460786
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790683707;
	b=RsTNgZL2d8Q5g1/Pt+CNR943wrqE7/vEw+cLCFawsw6Jv27tTSLi6ZnIcdQwVIDGQ5MG
	 s37MntbPIhifvUo9zqaSQ2XxfP+zWGX2yaNJEI2fZ6xPUeqqVKBj7HtWF1u4lpDvswOG2
	 tYJL8kJvEvtC9nr/eS0/cktWT/2qHJ1hnS/6cjS/kHhryODedWEYv2f4jU9dEnP3Xq7Zp
	 Om0HPqP5YBuLjHv0FsNiod1DfeTaOthBv7mkdJxTYfahW/YiqiwWlpDQlrz4rdC8tRVXl
	 MhDb2blQuPb9ejGlwsRwwrOhlM8ngi99Lxm25EM7vMvtolv5YssXA2Jcodtqd8d9oCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790683707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
	b=n6+9Y/hokTsG340R3/5dTh6r2yejLROiv0boSoo57aE21bi/njPbUD4zEAkZyUCsDcoA
	 G8c+sYXlhYEaEYwoVnD8x6qL0KdpCr5a4uLSF82B8ytxwM8kyYzqvQbLk9Ya1zVvczPxz
	 YvYLyFRzyktt7E1brfHPwVFGXUKxR8KG5Gi0KWqoiyoZQYTBd8mC00byoyPwRP5QjvltJ
	 Cujni26R+Bvgs1cBSExBa+FfKj1HfZ7fVuWO+1iRYDk88Q30t7Wk0kWVZJLMWGM/gxfnN
	 Boc2rLmxiWanJ4przZ5fiLIJfZjneKk/v1IVgXdFMXR5b6kpbgPg95hCVnQtpZDAllA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790683707;
	bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AW3+ouL73O576WDcV7G3ITKgt08/id8qGcjroCnjSZmPxRq0W/1pbTrzUqwZPrQbP
	 SqrO5LeH5sqm7M8ZbusCsE9jmphX/DTwwmj4nvScjeBirbe7wiWg1jytB78Wb77qHl
	 C+lWBmxryWb0hNIKcfd8kbca9oV6IhQbBGcF0Zsg7438cPh7zLdX1E5iimmzB9wP2b
	 zLWxMo7LB0xjGsm3A0yFhc7MtGbEdyDoNTgzhKz2eL/jh0D3kRx1euwje5oWXlLzHM
	 Nq8+eKc7K4s0cKXuJtxunBpRu6LiRzsCoXmC41ZqbjMGSg3skvKiB/8TmMRNu/RJgd
	 wmr7ywKRnBm8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9842460786;
	Tue, 29 Sep 2026 12:08:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C59032F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E5DC4069D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6Yh1ElxE6pl for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 492E140636
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790683705;
 b=XPwLGsYHzzrEXNUwuHMNuuu0eM6dMrq0Z370Z0jm07y5QpuWjbxRnozZzTPbD77NGUpt
 vPeJ74mTAGszf3T6i2Bn8n0dIbq3InKxlSaD/YWF5hlSQyQvcVIApnci8pilOOxvbVK2N
 Yi5UyCKOCiDZnveojdbH7B03mhbg1+r7ot4oe9XkoO6a32N1vo331Vg6s3fLKXc00Pl+y
 TlufKRE7S+cvKw1KmJD5JOHOrdXhz/VotwdN/DPwzlTwD8dTb5/az0dB3xKM8zH7K1JY9
 VPwLTrEZx8wRpNPbJ2buRITmckPo9+vuEM1tWsbIvz50bzdLrlJh5I+1gPUbofL7+1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790683705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
 b=j0jGEPcpVfY4tZPl8z0filNXhTgkCWJ9/xHf5fkfrRBYGdQfyvTKaSQc407OBMR0g9fx
 QRZR5A8TyZi9ba+NjIj9uEtnlLRvQUTHawGNiOpk4grai0MkLHDMsgrPSVeSBH5nzSMCR
 MWPXGXUUxlWxLNy5Hxvg6x5s5ZIItZ8pmOfXp+jQG8kkAGvlnDat4c9sdeSoacbYTFsa1
 /e3XjQk9K/GmujYbu10tOGJjw+gyPTUKh/fi1AhhqsMOrSSCKt/gfhnpsCgYNPnys5hzy
 tfaxQBZEOGGkgTkdoHf6yLLo7i/YNWuP6TmSb5ygjrL6qiRzuxJhuFmvIKcz4AYjMsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nv201GFE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nv201GFE
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 492E140636
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:08:24 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c264788fd58so588816166b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790683703; cv=none;
 d=google.com; s=arc-20260327;
 b=f7Nruv+UYEGxNwcYaf2ppOhCeiJbqlcajl64aVlZYmVEkYTOIanUwjQf8s20wCa3U3
 nLPwXhJpd5yUpz2UPdsc6gUr472GdNSkNE+MZsFsyrvMz03rV1DolK7mg9rhqRs17HY/
 bYC0bYzqHQs+QcgHlBFKEAgaCv//j/SZEQfLHLk9Vj7nttRbIlMXdB/8GI463dEdo0Kt
 9V5BrBaiqxuSS1cxa2/LfarjFqba/UxdEZ2rY1n7Ef7wio6rAnlTiVdWhi9OSgDhLLUh
 8/okwCBm3+o3HMx8+ExosW8Zk9D1hB+9f4uC1wM3bgTYR+v1BPvqekdp9ubn4c3YCY+D
 9H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
 fh=XWvLSzuXPROIbgAVl6kW2eDPyuUKVU7lUZ0rFJULyus=;
 b=SYmMU/duRQl1gTGa+vDDxblzxd23BhpPshpOgtiZCk052dKGSEQHIY9dBEhoPVjhJp
 8vNN1Rt1J4nK58HoZW4tyjtIGBtWFzRUGiBp/5nO3HTfB9a21d9yCbOyeB0Z+DP1V9NX
 F+64xyahWUDN/GlLuQlKYSf6xGjDj77FiSEufl8W5ScsP2XmVWqoX7rlXQiT1COqH6NE
 rxKJA0f7yWygcQ4nEEHSTLXot82zMutrbQ7NmPDItEqz3Pfi967bCpgzp1PYM2Uak78w
 OGn9GH0QuyN9m4dZiXC8Dzls9TU3hZp2tY7vuaWYT6hPgOkSWmye89B5TGlGUvPQE8EG
 3XjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790683703; x=1791288503;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
 b=nv201GFEGgD0GP4a2vw5Gh6dYpE9rZz002JoafPxB/zlnPQOsWuS7fJURSTwOz1IWN
 R3oYCrr9h9YxSTD8neM8AzlKKWC0SsIWKrosCGd8O1RMmE8i2zYcp+O52XWCw/soQmqQ
 A2WUuFOmC6l/76fbNyGWYT71qhYPj6RCbw9AOd0agkRRyaUGXVN39q8KkmB4bDNIghYG
 xIJDHfzMD6IOJPCDTp6dkl4w/ju92aY0zt1ZpNBmI2M9jor8ZGn2vY5Iki10N4mtcCiY
 /TMrLApugmlQIgPwoJia9RrUGuHHZbQnRdGyH4OpwX5Cktq/rhUvCukC/Kg98ULG+Ii+
 Zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683703; x=1791288503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3n8aKbg+IKlsdqBdeIvtbSy/jUMm19yMkoiAAGEjbYA=;
 b=imdjNZcEjA6YorDIoOEDP9nzW7o6wiXYylaXy3QncGxggY2juv2tlAZbkKId9Byjrd
 UxSETV8STe/H/59lgwsK2mCz2ZtufKl7eqCrl9++ki8lZgHMdT1c/utTy03HMmlgkXOe
 lNVlwoIH2CHSQ8t26e8VqOS7JKXGndtqn0hB9NsoaoR2WhF67FiPG8kPO2DK1KyY17md
 pN/3s1JybxcRPV2lPwNRxQLBLt6mpz79+eT/U0dx+bSv9xunheOjUDjj487FGxgm2kWx
 Mro0aQaumDsFk7p48wgp1oO0I8beidyb9+M+j1f1G5fV/dnzlz10y9Qk/vGQYGyv7Tb7
 2idw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlyUoku+Q/uTqWEvqiGsnUrZxnlU6REimCqAeLEvT5/2fmwXSK2Tj/24fdCFFV+dYE5YkYTrw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mZ8bRH+zEmHLznroyFd36xB5RvUHVK7lPTkfIg+pVvzEcp+6dE
 rZW/QFn4mbOeZN2r38VVV9mN09yL2M3LNrLHPSM8qT1Xl7s2IbDqM1r9CZeOSKtthuH3iwJrabu
 McH1j3+cQj/wSgS5OYsKndfpCVOTow60=
X-Gm-Gg: AYBFou3w14zUXSUCqQVVmSWVpjP4xwVRKZHLCr28yo9hiWLQQorNvq/W1UMFRs3rv3a
 ltS+bz/xG7MYfckwqm3Tw26MDFZxXRWbyaDueCZ8H0faOALDAqH7WtQyRxxF1bRXteycJjESouf
 giosEhbqrDksFCqiYVIL1t3hgRUysQrZn6P2CI16CBMFveaaEZpl/yhCLCx8OmGAVbzNfQdImQ1
 EhzFimsySCN5MA3RenspRULXJjWplWrk+Xo59CviEcWeIajHNuQ7SupHUftysKLUpAIiCMPO6Dk
 TeZr3QY6P1trhyQxmNF1hbGtmTluC30PIQVmKfbL3Wh5t3L2uZCwuA4n
X-Received: by 2002:a17:907:9691:b0:c25:ee92:2d0d with SMTP id
 a640c23a62f3a-c2ae97a1113mr982000366b.9.1790683702512; Tue, 29 Sep 2026
 05:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
 <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
 <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
 <d96f1848-bc26-454b-8bc1-4cd5f8994e57@cherry.de>
 <CAC928HYf7zobjKPt+qQA3=fQSzuvfKqM7LvD-kG5tPBM=+Y1Gw@mail.gmail.com>
 <269fbd75-55ed-4051-b4ae-ed136dc36af1@cherry.de>
In-Reply-To: <269fbd75-55ed-4051-b4ae-ed136dc36af1@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 29 Sep 2026 14:08:10 +0200
X-Gm-Features: AclHuK_9BrJb8CusEpubDjENGhNLeY8snSFF-d9rfNZWSfcQ35ik0Vc371Y72jg
Message-ID: <CAC928HYbxGVsNGBre-xRASOy=-bEjV1my+-9p5ZeSZ3uP3RJPw@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
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

Il giorno lun 28 set 2026 alle ore 11:10 Quentin Schulz
<quentin.schulz@cherry.de> ha scritto:
>
> Hi Massimo,
>
> On 9/28/26 8:42 AM, Massimo Pegorer wrote:
> > Hi Quentin,
> >
> > On 9/24/26 12:03 PM, Quentin Schulz wrote:
> >> Hi Massimo,
> >>
> >> On 9/23/26 7:52 PM, Massimo Pegorer wrote:
> >>> Hi Jonas,
> >>>
> >>> Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
> >>>>
> >>>> Hi Massimo,
> >>>>
> >>>> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
> >>>>> Hi Jonas,
> >>>>>
> >>>>> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
> >>>>> <jonas@kwiboo.se> ha scritto:
> >>>>>>
> >>>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> >>>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> >>>>>>
> >>>>>> SRAM addressing only seems to use 14 bits, meaning that reading from
> >>>>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
> >>>>>>
> >>>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> >>>>>> reserved region for its global data, malloc area and runtime stack.
> >>>>>>
> >>>>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
> >>>>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
> >>>>>>
> >>>>>> Current memory layout possibly looks something like:
> >>>>>>
> >>>>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>>>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>>>>>         [..., 0xff0e08c0)                       stack area
> >>>>>>           [0xff0e08c0]                           stack pointer
> >>>>>>         [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
> >>>>>>         [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
> >>>>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
> >>>>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
> >>>>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
> >>>>>>
> >>>>>> TPL currently does not touch the malloc area, instead the reserved
> >>>>>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
> >>>>>> the TPL stack addresses deeper into the BootROM reserved area.
> >>>>>>
> >>>>>> Using current offsets for global data and stack does not seem to cause
> >>>>>> any known issue for BootROM after TPL returns to BootROM to load SPL
> >>>>>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
> >>>>>> could theoretically change this and cause issues for BootROM.
> >>>>>
> >>>>> Here with "any change to [...] code" I suppose you mean any change of global
> >>>>> data and/or BSS sizes, correct?
> >>>>
> >>>> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
> >>>> global_data' would affect where the TPL stack ends up. However, and any
> >>>> change to the code may change how the stack is used and thus possible
> >>>> write to more/less/other data inside the BootROM area.
> >>>>
> >>>>> As code size itself is checked against
> >>>>> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
> >>>>> of doubts about [1]:
> >>>>> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
> >>>>>     strictly less than?
> >>>>> - shouldn't be more correct to check the TPL "footprint" size against the 10
> >>>>>     (or 11 or 12) KiB limit, instead only the code size?
> >>>>
> >>>> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
> >>>> this patch only tries to address the issue with TPL stack being placed inside
> >>>> BootROM reserved area.
> >>>
> >>> Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
> >>> configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
> >>> adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.
> >>>
> >>
> >> I had never heard of that symbol before and went checking. It has never
> >> been used (there isn't even a Kconfig symbol for it!) so we would need a
> >> bit of work to make this work (probably not a crazy amount though :) ).
> >>
> >> I'm not sure we still need arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> >> though. It's only used for evb-px5_defconfig, all PX30, all RK3328, all
> >> RK3399 and RV1126.
> >> I think it was necessary when added back in 2019 because
> >> arch/arm/cpu/armv8/u-boot-spl.lds didn't allow yet to remove the SDRAM
> >> part in it (c.f. 3cbec0ad090f ("rockchip: add u-boot-tpl-v8.lds") which
> >> claims "we don't have both SRAM and SDRAM in TPL" but we have SRAM
> >> access in TPL, don't we?), but that has changed since 2024. They are a
> >> bit different though and I have no experience with linker scripts so no
> >> clue if it makes sense to merge them (if at all possible). I'm guessing
> >> the additional asserts would make sense for everybody anyway.
> >
> > Me too, almost no experience with linker scripts. Anyway, I had a quick look
> > at arch/arm/cpu/armv8/u-boot-spl.lds for TPL building purpose, and IMO it's
> > broken by design because of SPL specific configuration options dependencies:
> > SPL_SEPARATE_BSS and SPL_RECOVER_DATA_SECTION. I will check more in depth.
> >
>
> We can always migrate those to CONFIG_IS_ENABLED(SEPARATE_BSS),
> CONFIG_IS_ENABLED(RECOVER_DATA_SECTION), CONFIG_VAL(BSS_START_ADDR),
> CONFIG_VAL(BSS_MAX_SIZE), etc., if needed.

Thanks for the suggestion. I will run some tests and then try to send  a patch
to fix the usage of u-boot-spl.lds for generic XPL cases, as a first step to
eventually drop u-boot-tpl-v8.lds later on, if possibile.

>
> > BTW, the .sram MEMORY segment definition in the script would do the game: here
> > the size that linker would check against TPL_MAX_SIZE includes BSS (consider
> > the case SPL_SEPARATE_BSS not defined, of course), while u-boot-tpl-v8.lds
> > checks size without BSS against TPL_MAX_SIZE.
> >
>
> We would have the same behavior of size checking if we had
> TPL_SEPARATE_BSS enabled I believe. But if we had TPL_SEPARATE_BSS
> enabled, then we would have an .sdram section too, which is the reason
> for having a separate linker script in the first place.
>
> I'm also not sure about IMAGE_TEXT_BASE (set by CONFIG_TEXT_BASE) only
> used in the armv8 linker script and the first
>
> . = 0x00000000;
>
> in Rockchip's TPL linker script.
>
> But maybe we should really have BSS part of the size check.
>
> I'm out of my depth here though, no clue what would be proper.
>
> Cheers,
> Quentin
