Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D4606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w18B2rDn;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mX4CDgiv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F38BB607A0;
	Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Apto21m0bUgT; Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E18D60A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439233;
	b=XUEpvLLclaSHpW1ZD34FL8zi4IRQox4dpENVDBbihiT5aNFfAhx9XYyD30HnoOesNczo
	 Mw/GsGOIQ5E0F0MWxT/In/LVAUJo8fPqNuyIf2FrBft7u8tNrLJDN7+ib9gsTXlLsQv9C
	 E0yYzG31HYaHWIDu1bOl/TDkGZWRIFLfdPA8gA0MezNB1TTXuDpY6c3Ruf98M0lVre1BV
	 +wO2G7eEE+31UNRLYypyfh6OAIntpWDmIJ8GTz5w1WHrIQ6gG1iIKvPHlSpXESHj+0345
	 Hkuv5ru0DwM9vPwCWI/CcUs326Xi04jLdHLNZ+MGwBvxHdi5vtyfFKAe9Je9SCi4sRQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
	b=mUg+BHoewVnWHDKBtY+LjKkHhT4vAGAZWa4TP6WxlfXh970fEAFW5AqByCs3z2HfuU9M
	 xCA7kwp7VV2GTujp+tgSxa7kRI2v0rZ2ecC6zCHcMB6uI+IPRmZCsBNeB+y7niv65VSZk
	 hgDs4lh2+/UmZywAEVB+8rMynJtQizd004ViYrYER1Lu9YgNnID7q4j7SBEJGhQuzm4b3
	 b+jaMtrlpczPiUs7FBeofzrLt2yP0er+SY2BAJrN0fZoieWxemctJnLmWZKkkPkrh2I3Q
	 NtVSXAmmt/fX4TFjDTHMOn8K2gf1h7SJGASOgX+IYMrkln3PywC1n/DNAOYdL2/VH8g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mX4CDgiv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439233;
	bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w18B2rDnuUoDTAo6MwPu6m0h2B4mupPYTyZhIg0rVFDQtVUhGW7Nlk7ZlcwvHtmzW
	 pivEnIjAxuOih9FZmamPeD2iO/zozJGmtZPUSwweFrbO/IKPSeM3kTr3UbUaKnX8fc
	 sHxGoxNdo77R5v6/eU2ifcsb+J+MulzZZWn9YOHFXtBOmahToucKtJpQ3Coyu6w16f
	 BT1voud9I2Vr5h9tRNTdUPeuquPE+8i3HDVyTSL0yfudS4cugMbk/xuuX3kmbRxNnB
	 ysgOB7RpGRBhux/lt+EKnOUesRucj+abqg3j0YNIQ+URxE3vwAOyTmpCmD/E7TShYp
	 ZBbqpgx6QbbPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E18D60A88;
	Sat, 31 Oct 2026 09:33:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E169156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A9D060A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ric5cNEASwPP for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A321607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439226;
 b=s6CWqInqcNWJlWrRd7/2YQhAQdm0qPlSzD3zIeHLMSgIuNEPTeJk7Kn2y9fDlxvjXyE5
 SZ9i+7XORMrUjQ/Ns9Xynp97fpTnfQ7O/4GctgvsjbVedG/J/kaYCTtAnHZ5rrPEGdC2O
 +7uABwLJX6eXi1Int7p9DFR9qjXirEVgpZBQpG7PXWCurO5MgrOHUaeYkwGivU0+gWoX0
 YE18C+Fyx5fds+99X2GG3y0FteHgxNLWyeKPHdY9UemlXcMMs4h0SBJmFNHm6z+EFQ9MO
 x5YwukI+FH3JdjDIlOpB5Rvx3d0Iq9GZyOypya/HcrPk+/EfwAzNnQDlfNIvUA8U89Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439226;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
 b=rxcLepN6J4K1V9QLbaL2GJuL7+Wt5PenbjX0tS5J/CN1Cw7HCh7VirLL3OCyoi0TPhgz
 rc7qzF4FcelZtZflbDmfwCG0gt6TdiopZbXEZnTr0ZNSoOnqDQov21DloO9j9w4L6BiRl
 HnErQ+spaUNiFwUJ3T5isXfx1DvZE+ksZML7EUr2B6CruUCXZ2RXk2tLtzVGxuHZphRUm
 BUPEkpiFPhEty/i3NQkVNpR8SL4Y4MGazcbljVrDvXpQ1OcSqKRfXR09y3V/3msm8QhBr
 f7paTwx9W4hS4OAX8fnynNVcGYIvUa43D+aWLwtjPVpV+qx9ZxpYMGFE0Lm3YN1z81A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mX4CDgiv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=mX4CDgiv
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A321607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:46 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e985106c0cso14882705ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439226; cv=none;
 d=google.com; s=arc-20260327;
 b=kYcG6iM+Jy4DF8yg0iIByW+lvXCuPgL6Hhz4/78WtE0secCsj4QGJuRwlIQaqMKkII
 sHEh6v/t1lKjLhlcXWOPtZX03CJX7i4AupE+u6tFuFKvwz1tiy/oOeXUxS2FIm9KvhZX
 x1TnUuw9tfjQSmc7BWUBg9jXR6LgCKFt7M+l/giY6g4YC7Egl4+JR/gOyquMad86P4N3
 trmwWEu5Hj/INY9kwMzxe0NJ0wXJ/GAq/ZQka5D/NrNa28rxu5/aAWMCnMdvvBYEO8jg
 Dc63Cn4NrlZDsjMquLZZUZA9cfAHoMHzoaETxc7ct8Kahae4w9tdfhXtkbmR49fABwBs
 OjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
 fh=R6Ge5/cOz0VN57tSSGn4d4bWocut/SwX1wSoHF0t224=;
 b=kjWBQ9zES38nj4J44BjIuajMc3vIbGITG757s1d9GT2T4m6upKBLh3eVw/wcGBg8ki
 I+2q1zkvdYn/6fNVTQ2ysjvTtjK6BRK318RYlOhCCsp/kaN/uxyq/FsyJYiwirivE0HX
 yHcwl3aCDssI4qhzjtfhHuKC44c4as8bzoWNsuL3U7haYkJ9nZfD4xoXM8EdJJouj22c
 tfYf1YWl+IiMUHK6qnYLQU2uLFS8yDTJToGoEVVdp+Qk57JsHwqlHIdyI3ZV5DeopkwA
 ceWWAPF/zRgW9/ktceEOenRGjKyv9gw2RjbpRsvF5spjs9Cbo4eqjSWg+0bwPGmOKKc3
 8ekQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439226; x=1794044026;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
 b=mX4CDgiv4D4E3FsSO3coKWuNL59zhskP/euOQnMwMnzjnu9ZWgYC74iFK6WnqQIqSP
 BhV+8VYOEMnIAKZyBhc5pLBQULPjPWpEd7XYUOT+RcjngyJykXuZhsR5ih7dGnM6axCg
 MXHbR/iu3xsuvCY6djlj7GL6hmiJ00rk8suCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439226; x=1794044026;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EjhBKof9PORmKYBl8MGkQZmWDsXiyPZSYsX29rBYtmQ=;
 b=gjBpWzRsfWEBKCMQwFd5yS6UdjbYwFhPc7tFSa8HV74IRsoLyHCW8nY9o+zRMByHd3
 YBUEpmZCFFwF9sLQ/9nruSDAOJYuzYaq95s5L9PbgtMyN5dkL1dAw1d9R9qwUoC97kK1
 CcF9iB2R5Kaeme7/Okwo1EWO8sjevixUAOitAJQWZZR2GyP1QbRPDLSOLhc7TDk6rAZU
 rIBUYfXt7i+uh0vMuwIv86R3ypHKrX3HK1FbvNfF2Wmd82XlsLtEEw5C8NbkIO4rny/B
 Uj2wxYVtoKLMb+jsVwGZ7zcP+NMO8OfhtDcRNQyCdh7NW6bkbPJ1wSxupnuTa3sYBR5i
 x6iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvexumX3byItWcx6RAPyujCI/ZvUkg3RoBrVvJKqltO45oN1sfxAhfvJmfAQWkTIEcIGUPxRY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxaZS6GzIRkGqqV5l688dFFr582nqvMfMGxfc2qlAZrV52UR4n
 gwtlr9mCDnjIW8BJh26YsH8GYb/4qbLh8BQVLYCDu9rBB1K+tAR0twWGOuFeNivOzQpc518CZE2
 5U1TxtTs6Dxe2q2iwTy/k3RvonYsd1jI2OGDU5Bgh
X-Gm-Gg: AYBFou38OcaVTmDIe+5kXeLkPfWPRlvf/MRC2HhHenNsnXL4yyblIbr/L1FjB42eNfo
 1A7SPVHBLejOUiE8TqRdJGv1qFj7y6guUPOl6SDHOMASl4d7kpfyqNUrcrjlDcTbn2y5yH4DRM1
 54JE+SQ2cxTL3zpkfVFyCm5t/oTcwjXzz99p5TwHHriiukZfzF2FbjTsxwqVgAxRGTc6H3KIg+q
 iMjKS1BjlIW6xaWxmBWgIXxRQuNOSvpVVy2/JWhQnTxfUHmNY66FCl7UGqLDjry2HTvX4GJ95Z9
 ISQ+v8o0jPJrPvA6FP8t1Gt+yzYbDXeRIxoITABRRIfyDoIorBTWmgtZaNOyXRV4qbLxPKg6W0/
 tWWWFCAZxOw20nEWKgWnYUB+CqaqreJeY7V6+PgSyAKEN0PYVUneojLdw3ty31Me2wgjKPLk=
X-Received: by 2002:a17:90b:1b08:b0:3ab:5832:727d with SMTP id
 98e67ed59e1d1-3ae8982af58mr3964656a91.35.1793439225715; Sat, 31 Oct 2026
 02:33:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:42 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-7-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-7-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:41 -0700
X-Gm-Features: AclHuK-xKf5qifZ9qoK2uo8EiRlSilZL4NXyjiA_0wN3Uq0SsgIkKLpgyi22CQU
Message-ID: <CAFLszTifejRcixnLWF0H_=cR_E4=5RwgywifBN80yFjNm6zNgg@mail.gmail.com>
Subject: Re: [PATCH v2 06/37] clk: rockchip: pll: Limit special rk3588_pll
 handling to RK3588
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Elaine Zhang <zhangqing@rock-chips.com>
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
> clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
>
> The rk3588_pll_set_rate() function contains special handling intended
> only for PLLs on RK3588 that are also applied to PLLs on RK3576.
>
> This special handling should ideally be moved from the common pll funcs
> into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
> to limit this special handling to PLLs on RK3588 targets.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_pll.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
