Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N7BJQSlG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fpcUhYSG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BB9440B01;
	Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5LYPJ76vlK1P; Sat, 31 Oct 2026 09:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FA1D406A5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439245;
	b=sWkzCWjEDzDSUvsUa9L610gjVbmmZp92qK8Xka7A+8Ry6ibcRrStJj1Oxy0dDgNIAQqR
	 +BXsRNN28prGTwYjzOZwk8kyA5yZ17NDXznF9+Isls1Qio4Eb2nZB0K7UGEaS5xoFbIMd
	 MAXTHgUbd0/gNrVqSn9t7pO+VYqXBJK2t5B2PH7B5b0nDNKa8RbOCZoMdzLbPZAACvEta
	 54oIcl4zdDdTbnOXsMim6blOdgWoahw5m9mw9wUn9Nb5PWDns5R3smESYJEpBNpng10/x
	 rTWRtc8F5rf+MZEorJmAPerY7gncIIi3toloCCci2tWrIZAZyX2Y6lfd2BtbOGYPjzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
	b=PdKtraORs09FBSrsasfpovgeeUfZ95TcrJgzRAY4GM4YOQvQ0ZOYJFh1YAjpNHiPjusf
	 Kq97Bz0o7kU6IVLJrHzc83ayeqiR8/7mPRTDewSNKBKB3i2UoG2JYvsRGD3MTmhO5n2p1
	 FhWj5usqyFUrNLPLsGWmaEXxyHZeV0W2P3wcDh+GBUDM8EfCF6LzADvtBwoBWfBcJIrlV
	 Egry5mIUL4pJofjvMOCQS7hBvMP3homKmLJlZ2CN4wIrEY5fN3MW+Yo1P4Vf4crIliQN0
	 GrjFAn6tlPM8uupWPrex9UXaffzsWZJ4EjgB78vyp4Mq5dTbzwP3mvZuDNyd2Wx8Zdg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fpcUhYSG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439245;
	bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7BJQSlGgAUXU7qcrVItibVkAPavtmyzdOXdmnb7U+gTIp4jtplIxkAA8trNqUh5o
	 MpiT5h6pKluSwR9TYtobHcrEaqdyExLXjJk94csA40gVFaJCt0LoO3Bc7TQUlw+1Lm
	 6GJfLxUnrADF1RhsRgJ0huH65XQhDbXmKqhhFgQ98wGKEdcp7FtS2KyR0NBwTfEg0Q
	 v7kDSnSFQyODfc0UhHxLv9ubyTfTHxXgqFazCZWQlDieQaqyES15rMqQw68h9iDVwg
	 L7WNDG4rgJNP7JZYw39WVdvFyTNssFYU7YXoiv+cNwxUdxq1PLAjhfum0R8nL8Xndi
	 ahGgF8yDXQ64A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA1D406A5;
	Sat, 31 Oct 2026 09:34:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E74D82C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8F5C40B08
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUSXRI9lhfYr for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42B934059C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439233;
 b=DBKCEJDAVlKuhAKAaL2ORPGiKG4R0w9z3OktsoweCt94dmVHjjI5+DmcFRbtllvCApZh
 j+OgOxjpRVrCltkWTEIvD2VJacYqHgvPwqUXy2JyK1bra/lWjT5SARGk5crfxKtmBT/LP
 BhD/xRXdke7Gx8eBVj/ddeIlptgfQ2vkHtkNJrZqqjp0w92c6apDypg7+SNdffhPVPULM
 g6Y1t6dU1Pf4c4FrFrN8JezCwFQ+PTz0M+eXIm2xG+2RsW4uUzltRrBDy58PNuJIhzCxZ
 Kjm+9Lcc9mrGzxW5/Bwsyn5toGjF1C1zv8V/LOUDzTmgmXujXCswFB394rHbeDJGwug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439233;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
 b=IYQz1dLgZpvxmsyxWLm2iA+v+8NCo0ogIyJWQrifXcEytKx4yUwFt45VPwHeR6p2tYf8
 eeLZHUivtyHbLk8LSaAEJBqoL0+oL+xt6Rz26pHPxSNHhSO7f3sQLCArHm3UwPjJ4yUJW
 IKguDEkG3qpHbBoktEJErzjok+4OiAel+F+5tX7th/i5BF897r2QSAtK5/sIzafqTPCF6
 5zqBwsZPOhOM4W73PlMtpX4ylGZUQHVjNWMHpYn9GK4pj9GzPY+mK7pGgkIp94o3eYWAG
 MebVa3RBjn8i74PwZc+odYBI0ExSthbsKC3VjcAioujKrNr4MX9aZAk6RwOo3O7BhEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fpcUhYSG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fpcUhYSG
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42B934059C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:52 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so573433a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439232; cv=none;
 d=google.com; s=arc-20260327;
 b=d+09TEopTiaw98ynFmULeiP1spDjUo5JcP87hx6yL2azdNXGYCOdUIaE0XP6osQizH
 oRRBdlI2SewiI00isvTE/z6a4luSu6nRM/5cP96ZAXCQxU6MWD6TEP3kLXQyC51JkVxY
 z8NN6TPAX/zFZ6p0IF7uEwrjJ/YOQVrHeRt8o/9zWBlxPOWLzQ6D/RgqBf0vg11423fX
 5NrfMNxtZ9BqUBFNx+IJRwbjp6NZwXkwBqE0dGbIq1KuDJxJ9Zwldbl1NMcbTRDz2P8g
 9q2q3yn9zR9LyRqf2xJIpx6Nw/LLKwmo9zOhziItgJC/Tgun12mvjrItLviTPBsS7o/R
 jTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
 fh=EFq5yomzqY1vMbjeLRX/3HQlewpt2zHVKYady7WJBSg=;
 b=G0DMxS7rqoNZJWtRdSoTG1pvyDcYbnwH0cjAbV3EoumMxxkIifDrMMOYsjhpPMiBEs
 bo+oqMkuubIZEaoT5wgOoGiOWOlLUtQwRuqKFGGvSsS74aqHjq2rREmAzW8z/ljDZk/d
 tvF9E9cBEt/xTjlvOY5JJqm5XTXrwzTIryArm3Wv4iD6B9PujdhfDufPsdMKLf85RcWu
 oh9qupS8RB5zePYSS3JSLwghblKo5uL3RNRgNf6mRTAh4jww5o45aN9qei1ZC6KYH9gb
 g3HNOlgq1x+oxWq96xNo/uQLPxbP9jN8o/hssbj/5XcuhL9qs54F4mo+83HtuonldImC
 gdOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439232; x=1794044032;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
 b=fpcUhYSGNm81D0s29X4ZQvgbKfG70AFf8XtWgJB+kYabPqBJs4AqKyLtvMBBKdMboX
 /ZxnD5yF4eBuq5Tw3RXV/8eIX3V00vasiyLfHeXIK4X5JvTOnb3l7rRzwDocZfLBatcM
 GdioQGNvPvdsBD7Sqgl3mf1Akw67YlOQ1LWQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439232; x=1794044032;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8rcfhSckoaurYmEi0HrvtOYnZVU/4FfYsGjO2mSS914=;
 b=lb+3kdcv2cqrI4VqPOdptm1FCFc+DZF+m96S0b/KWZh2W42SLRfkZKedJLWmaKLhKI
 RHgfFxiHzGgUws0iW+OChAvpGShrKx7Z5aUABnu0TwLD2GNB6+nGM7m1OBBo6+TRRSX6
 TNH+vDl+smxmmJwvhzyq0IRsn4+zEq3S/xFJ3eVwFAvfush6/lBBxpnpwBeyYEne2zem
 dt2Rz6gt0Sxs41hY/4eFfdvQ98h3Y8HMnpQKzRoRh2EPA/afV6uUpOu8Myfv3WMP5DNb
 ikAg9QjUwND4sM6wgRFTCSBLSWxiuxK+FMQF+QLNE6KYjjh0RcweZbjxhfWECD7HN0LR
 0ZQw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJwVPo3Cbci/4kBtd9L2NjD7iOFP1s7sgCLgYo8rFaYTmRP2DCSBR6sP1li7kRSNewdUCkxzA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIM2D7eSMTmdZ1I6TDNub1v7X4jDPEQKNbf+f3v1vpcOdzf0S8K
 do6ncHBpVpxlGfMgRXXdvN4JbNDK8X/5BBm26IjL+zEZ3GcCCSaVww3rb7BPuHge0Sv/gdpf/vZ
 IxjW56b/lw/2bAx3j7AJqq4+gm7QrTuKphqn6PiGP
X-Gm-Gg: AYBFou1TjQXMLM7j6hJ6GOxOqItGlRWxcHBSPCkSr/KFn4Wyi7rG8kWrmkKVpGPJDSN
 F2W5XmleNeDDOSpRaewYfU5i4XnuDbKPm/wyZK81QdbpMzeDXURY3XCTmrgXc3v0DUbzMkzbuSz
 eY/oJ/8DjHuLUnMjsndBKaHQ9M8EKQhLOZepOVLYmC6NDvX0ujhynE1l1CVyy7KB8iqiyvQCEWB
 iETij+LWPN5Vq1FG+489/NbLYWRNEI1yGmY+f0CGPXR6kkhfr8Zt6DlDZ3qoRlwsa5YN7hQLE8d
 exDOWEocv/Cna//XbAJG8ijbfiBFf/7YLqd4oW5j33JPnh2dCnkMGE8+K2NP6OkvPcoOAM+hx2e
 ACjkx8vo3ws0Xcvm/0BTYgskrffMB8gch5J3fJrfwPalGxrDCWZyMvLCBS3+LrUCU0F9oTilf0M
 60E9z03Kl7zuDxWKnn
X-Received: by 2002:a17:90b:3b46:b0:3ad:d4aa:8559 with SMTP id
 98e67ed59e1d1-3ae896f8266mr3516801a91.17.1793439232383; Sat, 31 Oct 2026
 02:33:52 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:45 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-8-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-8-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:45 -0700
X-Gm-Features: AclHuK-nfE5w0UfyS5HKyZT2aHvi-l7qrpBp_pld93yb1cmOPhhkGGF-ZCdghCU
Message-ID: <CAFLszTgyCuvYNiZDV6WXviPo1DAurbQdeZcYbydKEOL3uUb=5g@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] clk: rockchip: rk3568: Use correct clock id for
 GPLL
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
> clk: rockchip: rk3568: Use correct clock id for GPLL
>
> The GPLL entry incorrectly uses PLL_HPLL. Use PLL_GPLL to match the
> PLL represented by this entry.
>
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3568.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
