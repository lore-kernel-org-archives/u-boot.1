Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hoHjMIin;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=njJFpOre
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 472B260A88;
	Sat, 31 Oct 2026 09:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pv9PTs9-Pegi; Sat, 31 Oct 2026 09:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DCA260ADC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439362;
	b=j9CDCMAc/5N+wgXfxB2l3joW+NiVVkvbkQZ6aAB5ajwNFuB/J/ZmtgC0a3F5iov2jGRG
	 Cehccgb+IRFol/JVq7E9NyTARh82ao1K+aaazjD5RcX3+hrGp+9h0iWot2iWbQ2nwPdXu
	 UDnp7oD4MwgZhvWYSWWcbPL5k1yC1s2tCvyCdwCoGiavK8oAuZZgxbTtF1uCFwaKZTgl2
	 yIO5bhzH89ntpHIyO/WG08N1bBH212PnssPRPy+Q2b0RJ97LMzqVTCYyx2nrAA08HnguS
	 ZVgqdGhhZn8L8Qoqdz2Ndm1XvQ/ZAGBDW6eUdH1WWzMMxnIvYRNuek7m1IRf9ZOW0aA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
	b=POP2VPApxEkCCgia2/H0i8n+ZxNh0myrFYvceDBq1SlVYeYXIFdVvXVx1kHir1Z7YAYY
	 m6THwCgn7R9gFGdc/ZkUGjcYpfz63z6CZtyfFQVv/noH2/uqldcwUADPAd/r3nWFgd6uT
	 /03rLAGQsfsCJB0JOvLXmjaUVgCYkWgXGR2cUDBGKKq0tqX97YccT6+G3JY5HWgFoItyG
	 nHOp9oEoP74AdgeJwkfggrrS2xgiIai+Z7yDa6bcjwALuGu6xouKn3bYUkuPUuYqKNbet
	 RJF7yDgqYSNyq43lyZcOo6rsWh83q4Em4+hQWCzC2/GdNsIGsE5wFZPMfiaIUxbYq5Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439362;
	bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hoHjMIin6ewtLLEB9WUJQc/ePzQuB2pth2e68PvVp8KlSnwKSK2CYlEW1o09QG0e0
	 0W0BZOCubPHXv9IK9BMcwg9mWnAShb32PyRPBn+obibmlYd3DPxNgxRhQUcxoW1lub
	 D8sXWrwX6xixHdAgPJhJvRuuQGRxkTMhfOT3Cmpnp6hC3fIMytanEqPgmIxkIKvnuS
	 BCnzbz143rjFoQWVvZmXdb5YTwxaTZ+1oUP3dRsbB2OHYDWVgZ0yEDt4465Qcza2tZ
	 QOc0czi8OLBpOiaLcyiMUrgtsUffAIO5Bov7a5RPajseitwhNNui9Wx81ISSoztKg0
	 gZV5yafXR5wsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DCA260ADC;
	Sat, 31 Oct 2026 09:36:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3179A362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E05B8117F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYzd6dQc8GXO for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52C5181166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439356;
 b=XgtKYzlPNUicS4CdYhq+xNP1JtJ4NabAyE0cXiLylLmEGZEZJ9lJmVB1OcGsS4Yqcw+B
 WqVd8zyIMpxHWmKwab7DxRkziAHV95vPThHrEEBp9yu6mP/HgNQzsw8vaIRVoQHCQKFSn
 toN90K8KsB6/VofYCzVbS7tfg6NoX/N5nKKIqpVAPIDKjqGE3qHq7UKsM1ejLtkBF4wOZ
 WzrHIgpvoFiOHe7Mp2ONHZGxwHUsiQ7TOJtYGFvGFsmrcND6sQaDV7fdNrMqLydUHdHve
 XrH1TN7ra0bQTKCMYsYmtuJe5TCwzgGIoVqTTHRxIjL7S6cJLzNpBGVONFdVerflqTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
 b=IYSVE4jKxE079OssAncYiJlX/SXpdxqiwaVlxnHXyhnNzkXPepKCjeqxff3L0k+red0K
 1uSq3uh6CTW7TeHcMboTA92fhY3zDRM0ASylh9l6/G5DSyYkft23YaIKO7ROjrVoTTFCT
 biSLBdRcGbeN+fe2iBNqX5LQ0D2DUkMgMeWoZcAZgfCdq023FNKQWYP7pjPiJIeOPzBAb
 xsXiY5tjgPqCGqve7R6rCvXlOIBxP/67kHkkZb8X1hX9fTvxVKhbJZWXYaNSPcrMO2yLF
 BjmZl/+lLJPTCXyqJ3g6sgalxZi8APdz9Sa53kgyh+PIHTrMUetuHhuyVqphTdM6Fqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=njJFpOre; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=njJFpOre
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52C5181166
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so1909648a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439354; cv=none;
 d=google.com; s=arc-20260327;
 b=mzyrXp+SwZkKvTtud04h5VHxYUw5OkMh0274GCZ5GpwaciSW/+8VgYrf2PaDo8WrI1
 gzb2Eq2JoB5T/IsWRWuQgJkq8btuAtDbKd370zt5j7zUGSrWpwlwtSZHIfbFw65rrQ9k
 m/S2kt+09LRsh6LyxELh1h+SJf2x2inwgqspXgUiAYwHajY5Xz49vFjNuzF1orJYDUI8
 oFC4zbKMiGBgCFR4FVUnKJDquCycXyQIWlAPuBwlCqBQrI1DdVBLNG4TT3CVcSMynZQC
 w37hexrqyrinpZw87VzZDAZ8juuYDUmBwdD0NxCrqIXvETSPX2onr7pdrbCX3rEqsIfU
 gXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
 fh=bL2gDWqh57swqPxoRI47odLecFAaBLh8srwU6OupXk0=;
 b=GN8gvZpGjQ9mf7ei6i2lXLHBvEacbwIA4uvwm50Osi7prgAuGnN2fp4RgpeKVNb0Di
 FVD7YMgzgSH2LRYnmKuWwh8w2ecRdRpwpHbeu2Tp+/brxTT3geNRfUwaVsBouv92z/bW
 0TPLWqetXCvvGt64BjnHtOJRuZ2A4Fkn4dv52i7+jYLUUpFJ/siY1zXqDJePJgc+osaY
 vY9i72Pu2eeUEOzKPtDCubP+XBrpmYYVm9SXryQbDKsZs/wyNYXZG+lwZb5r98jy/vag
 rHSQpcWuYnEooCeinEwwamutnF76fE/hopcONeQaWIcz6lGKy6Cprzvmk3uKkY3GUDN9
 mVhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439354; x=1794044154;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
 b=njJFpOre/FbPRlWfHYggTizCuIYjCcoisLnZd15OxBF+JBnrf4J6fynG8ZsFK9gfZQ
 dPXN4RJKDicU+vtdkwgjwGRRzeCwutOW/88k5ALuyqP4wqNZnsK59/4Its8fbqMt19aO
 XXxWSzAm4IEfFnB0bKXQDJmZj3bu+39XZskVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439354; x=1794044154;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NyHVeGwYQPFPbRxfsOaZHpa7kZBN4GUgMFjTje2Y78I=;
 b=uKWmJ+cktx19z+CxQV+QLPUtBQ0cCuwwsTkBoD5z7LrjtMI9zCc74jhTHBuVSNHzug
 vNu2yqdw1DO4HPuz1JW7r27gUr7uiCste/fqMl8xvd1+wjorWttypogc9e39/hAoy5++
 KL0JP3Z/S1Nvamcldb5pM/UjopU+FqnN2TCd3xXxCdQidOPg1lTgJkhgs6rdocqDfcsH
 GwvCqxyfrki/ZDRLC/nMB0xjNBBJL+xmTOXilMi3TqMvrV0NoUb/A/t3T6vjCYCkR5+u
 ca0EGhKYztRHag/oHl+6/gm1ns/wg4/fGRDiy2k889q2XtrznNUvUAdNjX/xjOBBhvsP
 IRfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0FkKNlsvTSBtt63I/JWRdT/QA1UestKUCXLJL1JDDQxfiu+ADMHU2qG6c4i/ZvuKHp2vLdbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLs703aWRsu8PziwDnFYfJ0sKYM5yyIum6fOu+uNs7KOw4gPXiK
 mpMp2YqpHZCnyvJXdyMc2zqRIsRfnGCJ66MxFunP7T4Zsq2uY5jDFlyBpeUXUZPHXZNeh487lgK
 e3Mt52oVqaO01KoIhfp9uxYeA+yIv/FczBNzqooc9
X-Gm-Gg: AYBFou1/e4gD2tKZb2jKHwlB9zzOvHPymdLy5ZrL2mfD9ZXpwYDdKbHYC99lrHZmYmf
 n5wrCHNRlfdXPELW/FTnF4qbwovX/m2MhgiQJVgrRxG9ezBP4DTmysXjzKWZUsXUSRr3mNUt++v
 dPh4uTyZiXjmDsHlA0r1IIJes9Blw9+2Ryv/ID5KdX5Sb5zOrFEWR6OtRhz6QNjqyHXvEHEl/Om
 /wROt7M+SiItma/niVwtlCe3QJnyausmvBZG+ioQ5XqAiIiqMFypXotPqzPAmw24ROHqgsvJn+i
 38dfdskuL22xxZ0jyKuu297Dv0iAWDz735x8NtZ1qzO3WILexLACIWuEsKFC02QcJCfLiVlyAbz
 s7PnVFenjw7rzTDr9OfL11nbafaXSBOZGAq23vkQtAdxhOTwycJZJxLYPr8wI6VeffNZtCUE=
X-Received: by 2002:a05:6402:518f:b0:6b1:ce0f:eb6b with SMTP id
 4fb4d7f45d1cf-6b4d4d7c79emr3746315a12.31.1793439354111; Sat, 31 Oct 2026
 02:35:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:51 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:22 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-26-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-26-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:51 -0700
X-Gm-Features: AclHuK__DUtafWOtUs9XiltKNVRu44nVSGbrCB57hIQMaFpP9-hu258tNgIGNIU
Message-ID: <CAFLszThN917r4D8JfL3fVVHUBaWgemxH1r+kdN4Rm8LvXt+t+g@mail.gmail.com>
Subject: Re: [PATCH v2 25/37] clk: rockchip: rk3576: Use correct PLL rate for
 UART fractional clocks
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
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
> clk: rockchip: rk3576: Use correct PLL rate for UART fractional clocks
>
> Use the GPLL rate instead of the CPLL rate when GPLL is selected as the
> UART fractional clock parent.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
