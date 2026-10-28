Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A61606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BtwTyFVF;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ImoymxiZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 391826067D;
	Wed, 28 Oct 2026 07:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbiVk0DD8zyJ; Wed, 28 Oct 2026 07:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7579C60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172998;
	b=dmeHDDz6xpmcokyRlPT7Xg2APZaX2lNhygGU0nMoHr44Ulf5buLk7DAjhHzC2pFAjiui
	 TnsbGT8TA/4adKQ6giCAo6Qg2+xxgmN3XksL1o+Ngy5dzEvVPl/ugoePDj8mMh0ZVA4MG
	 HzMmQ0OHteJwJfgwyFFX3Zl7arKVVSuBqbvTDfhMPAKrdlviV3ahB9RTi7Ul1RITFBuRP
	 OnA3CD5cW+/hQDVIwh5yt0UwnnuB2QVUmgKU8J4CHLk8iQp8ze/DkUuNgI3ecgieqmWjB
	 Ns9KfkoPZQ2FGCs5Wt7I4JRMii+AewRdeMd1Y7CJqYUmDYN0EiAsqKgmagdsEK48CIA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793172998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
	b=Nl++5MPO5TJt8VTC5UElgM5oWfMabMaOtbimrpmojQxlGMih1qGoAY3ugi9XtFuWfgBQ
	 PvmsRs2p1/4G4wZ8MzBc/3O7UZQg9cxxecCPzMhMwYE7WfKzTY18TrT65CAQk7SvGq21L
	 SFmJtsMUAsaMW91W18oFEbaA0fXKBHkURZe+AV8WREQRK/oCgIW2IoFE+YBAZeuaEPxMj
	 xCmj/R2gtOrOuceo343eucDE35nC3VZCk+Ho18vhXl3K0X+da/o1Ln1a+ccu6L8bzXblG
	 1S0WXwT1hULBZyO8HR1QMjvGTWmjPaD5/4zoREMxw0DYtnNG9gTwxYoPPHkMsKPU0+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793172998;
	bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BtwTyFVF11NyzPJb2jNaJoH6EgjAOXEHp3qntQlfmTuCb0TycCKI34a1hYRweD6vu
	 e+eUpqzxIUdW/9wVAj9se51/jVN9uXZogwawfT9ILDUiOWue7rTDKGJ6B6tVZVl4iJ
	 VzWWgRqJ0c73cFYed01oHeb/seW0jbeOCxx1RB4/UOKwbkszQb849GytsGoxCc2YBE
	 ctqJUlFAhfSzUuuw2braUrJGiqAJ5h1dGZeHggX7f+GA6jL1oaMrXQ+Qgh9dp9aT4n
	 3FOPIXPt4WG0qnHpL5hA3Dj1ooMdLRpa/AoRghDev7mxAo0HO77aPt/ZY8grqDk0cn
	 bTY+tJKFXX/IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7579C60600;
	Wed, 28 Oct 2026 07:36:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A048DD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8667F405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDvHm5YbrZqt for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 478A1405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172996;
 b=sJ9YRJx/hD4VPj3exBGcudigfu+K6/IR4BG8TLgDow36lZOPwxUx+ZYzgf9bofrrayxc
 fGAmxr3ESXU2tRYtPLetdb2/l7LuxiIg55PQS99s/KlcnL1ettdmgJjkgDxJ5nB5JoifG
 dTbWJth65mi4dvhubqXPY2apktWp8rjybAc5/UirRTXbdykAoq6UlNh9fyTSLdp33RpaK
 mnMxfZAl6Mk3cUQp1uC6mwyOGdDwhE+2sYpfL54d3q4EM+uvZAS3r+XgQZvWC7KLmuxWy
 wGYoLe61/1irYBlgOBNXs4zSGNvPzOVAy9T7GQb6ZUUJWataPRC2x938bJ2DjK/7GGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793172996;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
 b=OREtNPjmxD2fY+aKtJo2IYRb8cQ14aABtG3hAWegdkpVpBp7bnD7rJWwYQN4YbM0tt33
 WAmJrEfU5waimeXA7MTDwRgJVaqhEWntjR9N7SWHoi9Ewb1jFofivXLPgMv84mzvD5tyn
 m+Buhfkz9JQj1sYVkKQ9Kpw6n0FgC5qf4R4qwrUXyJ9AG6uawzESuPX1SLLOytn9CYX+0
 hyPvj24rsBjzd/qn+5ZjJq+6tTJnuG5NrJV4w+fhx1mB2905mYqV7CfycK0jr8E9K+JC2
 SygEsNu3K2RuLg5Ne0Za5F3GOzMhlV/jdidXcoUsZQJJflZuXzMXqR6dkxTZMCgj73Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ImoymxiZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ImoymxiZ
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 478A1405A6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:36:35 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso786472a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793172994; cv=none;
 d=google.com; s=arc-20260327;
 b=npAK3++CmDY+ok2i4Rc/y8y0OZeEf1vNBsBZ1ONIkD+Sa5FBOIen7F4Tzs5hkiRWjE
 fRp0i945h5e87HmVDWfoGV3K002bQuBsus6ygI8+YbvDRl/xLlW4hKQ1G2DIT9TIWkoU
 QYBuysRGgOne5f9V7b0ihkQjyJ1W7tpVodwAgulyDryrM5Ywbwgwe9UhkmOBTMZGTLis
 j+6eU7vwF+jcgyp0vYWjFq2L0QqcFPqtyqyKRL7PPEDzCIQAF68HvWM90Z4vyQ/pjow8
 v0ty0voiNYAOY1M3xV40fzf+fB5NfnFMCnDutl6L//nDPyQnkJKFGu876SyICZbCvhnH
 ov6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
 fh=ECeO7daiajrBUNWzV1rZ4+ukjyK9C2yG2Vj7JIB4lUk=;
 b=nSLiex8ud5ZsVsQftRm+eGUSHrDMIFgaPd9awTuQ4t6QNbUkRQU9gDyfSDJbp7x0HH
 V12uEc31N07MQn01LVc1tI4FV0eFJhwpooSSLjPQ+SPLAtcdxMNFFktjrQ2fvzILt4Y+
 KulvAnO6g7SVMCLsa/9ZhwkR/rbib7udx/7MVkFyvO6BBRkI4ymNd9Yh2SKTfZoz0Kjt
 +yEgoGg1v3xxzkQsU3hL6IPlFlLeIKiU/6Pba1rTR3K2Du8wiIvVnWxAW44sSEuN5ftX
 lpgyxTVDmBfir6TcfLxCPC3se7axNQ/KkOA0sve9zQKSDaQoRyA2SoueLxc7wVV72o21
 9nLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793172994; x=1793777794;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
 b=ImoymxiZJT62+Vi+IZB3oUxtdEkXJqnKzbnBBpgsintNmJqaqGv3Y36XVHxZ5NGHZd
 36PVh8n2DLXdEy7heQSLFhJBvCQTIzaNtQuAmZge6/xYvybp0YTHA0aaFCgWWxmgLQ8g
 vdzrl2frfLLf/YUkig6tS/OVF15Xx1HL1B17I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172994; x=1793777794;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0IgfZBY4UBEuWfy7X+Pju29CvWppaLYkGoH4FuibAts=;
 b=mjzfzaJFYUGRvydpVnbccCAU4sWHRejabZux/ER3Ngugg1tKNjvL1F+3unw6pCX3/T
 xvArx/21sltt/8fpOIZYg3Pp3MDYXV+VGCsQUqbMltROEZsv7wkW2DMcHhROsrRbSN5D
 PmIS0N2Dw0jwn/oDFZNj6Axpbk74mIhSYT/QzZQr9yE11InFP852issS9EToe5UX+Nqz
 AQm06e9n/ufF2WZ0OjDb+rBoDFWF9PIh7RHiGCh25SHL9zizSXFMHt6OFB8NkHf/XahL
 0wVEZVCAOzr5JsPiQPKX5KstkXBtC2T3oFwbscWIw1jJt2AyOvgJ/27V1Ew0wKcAhqnp
 YsVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZJ6BpZSq8i9HlqMud/oVS1t7oqDeE3RFuAGvaRJgcea90/OyH7etm8PD6yLCdMp1sYUjJwTc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1v283D6xR4n0/AiLrPJwSyi/re0fzuAF+JEyEQHaCO/H+2Mb4
 RoKQ+cdDhJC87tTplHfaIBVv9+ZTeCFk1gc2bDZ2uXU0A909D2oxSow39gAvqjB/EGIk8yiDBfh
 RL/KDNda2Fdc4FYyWgvGCLUwRJUz9cU3p3rGXoaSI
X-Gm-Gg: AYBFou03taiwKTo0OVOXWIU/zsf7lZR5rCWCOdFDAGye08Q0Apaf1O6rjEFXjbGmivb
 phS0kGopx7ihmzGGZECiGsefUUOz2/lhdLFGliBhKjzyvKd69Qq0J4J7YaZUnL41LnGQLTwlE4/
 A4dgdZU8kRS6ZSH1zA0uwognFqfGbwm/SCcFACjAyoYs1JJjSCVRam6eS3g1RiMiQZ4NRHYyjVc
 UMRCmn1P67men1xZF7mE4Hcyk57x37oPAzSet0Vb0HwVUigsVZoRR0MPRBuFOiR7Rgk08Ypd7Go
 enEqArjqcHMm5MVIxwvN23CSLdnCakWUVsf/G8See3sV6JbExQscOLi4erwPWEtS8I6X8mdOZ68
 8kbUsnJ5IvdXKFRDCPsKkhtpgQiABrXnz1AUp
X-Received: by 2002:aa7:c74b:0:b0:6b1:ef9d:9d72 with SMTP id
 4fb4d7f45d1cf-6b49cbf945dmr567580a12.30.1793172993883; Wed, 28 Oct 2026
 00:36:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:36:32 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:23:07 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027184105.6534-1-oss.patchbox@gmail.com>
References: <20261027184105.6534-1-oss.patchbox@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 00:36:32 -0700
X-Gm-Features: AclHuK-o_Z4RswV6Mrv1cEouSJxFopiCECnwZCBu33BqAi1fZ5jxYDd9NdagtX0
Message-ID: <CAFLszTiPz_9AEeePdmqyG2AyJEinJbeUY+iooy_OnAH-GTyEZA@mail.gmail.com>
Subject: Re: [PATCH] clk: Disable parent clock when clk_enable() fails
To: oss.patchbox@gmail.com
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27T18:40:16, Yuho Choi <oss.patchbox@gmail.com> wrote:
> clk: Disable parent clock when clk_enable() fails
>
> With CONFIG_CLK_CCF, clk_enable() on a clock that is registered by id
> and has an enable_count of zero first enables the parent clock if the
> parent device is a clock, and only then calls the clock's own enable
> op. If that op fails, for example because clk_fracn_gppll_prepare()
> returns -ETIMEDOUT when an i.MX93 PLL does not lock, clk_enable()
> returns the error without undoing the parent enable.
>
> The enable_count of the clock itself is not incremented in that case, so
> a later clk_disable() of it returns early with "already disabled" and
> never propagates to the parent. Every failed attempt therefore leaves
> the parent's enable_count one higher, and the parent stays enabled even
> after all of its real users have disabled it.
>
> Disable the parent again when the enable op fails, the same way
> clk_disable() drops the parent reference when the last user of a clock
> goes away.
>
> Fixes: 0520be0f67e3 ("clk: prograte clk enable/disable to parent")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
>
>  drivers/clk/clk-uclass.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
