Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7E606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H8K44nUp;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BA9CdZ5l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A527440B2D;
	Sat, 31 Oct 2026 09:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_xUF9nW1FTH; Sat, 31 Oct 2026 09:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF79240B2E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439354;
	b=QDDE6XOfBFU/G/uNXsdXBpfK87eIywLiPHaU7LlLJLJ0FzTn/D9cAXBGLJ8UhRnkgDr4
	 PwBXbn3hSuRnHbTQXEcvWzsKa8MD4RC/3OOyHr/kW3Hr+GalkdQTQAU3bPJYpkY+m5E8N
	 N6V/uo7ogSf4gwap+K01RG3PGpIg5Bjyl7gcjxMLYiuJKGem5f1fSWKvkWoBG+aNwQsUV
	 iXM4FPMiOy9aqDrmEjwiF99hTXNjtvYKspURkjrtA79xgJ0NqKJoWqoBuUehHPXqHtXRn
	 tjaLJIobzqbz0BI4kEWYDKzSwjQ8FGXUyP3G2o3o4rv5sTNaLi12lUktYg0+59oMLVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
	b=eUyZV0DwiivxfaM36cZZf7b4BBmWfFc/82GX27jaG461C2F4R4jOrkQgfsQ74dHFF3Ge
	 hncn1faLN3uhsTl+8VOuGDOhD6YXcdz8XcZ9EMxLsC5BgsI4/mq35WJsLK1jfdeEgx2tH
	 fCGBhAhHA5OXNjzEBfsVz3wWWXUsJLCeOXoJw9mxUS0NizhRDp5B8ky7G95oI9YVIF0xG
	 /d/Jka/mh6IJ44WLySPYheeeZzzgGHrqSn46+JrjAkT+hpqhSugf9RJSRUv5xNxuIb/5O
	 1MYE7TBLgSJlvKB0ssJNUQ48iznIb60gpnjpB41pAYSOQ+iuzHAn6N/E1MOMczTGEzg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439354;
	bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8K44nUp1CLSav58QNAqkXQ0d8a+uKOKri7qo3V28f7AGwuHnGfHxvtlwkSagZ0/9
	 iSqQAEODxhI3KoEQ1XReYYPG48+zsOBxQbyQpeHj6MdQegoO9k7EvoV8Eonz2V5U7D
	 KVpLsVFh6SL4Zk2OkH6ZJr7ECNJU42LAvOS52LLsYCFAXM1kLH//ymJC7cv5WKrH/X
	 TQ8E1/ZKQDZ0m4UIefTHG94/hswmayjaGyBJ5o/gyuDQ1xf/jMpUyz0UcdsRwQ/ohG
	 eE3GGjcLClfeDQ9MCo7Q7NEZeMpjkj5IMetQdHL9v0AESL+5qBiyhnys6wRXD4pywY
	 m3hutcr3YYqYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF79240B2E;
	Sat, 31 Oct 2026 09:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 187E432A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F260660ADC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PexyYOIlrylo for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0707660A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439352;
 b=mZi9LJR8EA2wWR68qlOVMbUBKUlgReYNtAwu707xOMplxz9udH/JmX+G2R/iXMHWwFJs
 ggybN2G/9CNepl4ePtTABloN+9CO22ip4I+mhF/r2hOpDoO1N20AaP7FN3u60OYM2Xl44
 EXBCCoRbPq1DLsSATD+TSze2TdFt22T/ITn+k0jtxPGaCuMWdbOdii40E7c5J0W8GL4po
 Ff++tIc4d3VDd41r2kooZtQrPy20zSY5IWqH1DcwGO3gpZTK42jOz45Uk007BqIOs4I2X
 9m/UqdfN5pbXu+a/fmi06ECoUMgKqYX2HouSUX6M6aPXYihwHNt7Rftmp2T/qtZCHgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439352;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
 b=bCP+qFSahm42xB5Gn25DvlDluEKIMe+e6QHQER0QDQgrqnee/56ry6I25Kn20GSo+l9h
 AtLI5aMaFTQD1kobmbrxeEarqMIZEmwOJFVuJI9huZCGgR9HTaLH/fWfFENIK4uOF1iig
 +FIlXXDq947j5IpgYMDlQvJTJjLhUeottM+EzdgKxBQLOeG7gJ3KAIwsSNhnk4Md7yoCX
 96GFDvWRvG+84GEwBCUtJdWIZ1a83yd41lQtI6AQsVgEGliugal9BPNbPzU46ODbC3u3J
 AJSLRdGUhQW2zRezw/adAxFrj4vOl5f8GhE5J4BDAZSDHAVw6VvhyAS9UqF3l1eiezQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BA9CdZ5l; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BA9CdZ5l
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0707660A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:51 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so2208929a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439349; cv=none;
 d=google.com; s=arc-20260327;
 b=aSmf4Kj5IV3EAU4qk09rMjMDynO/NY3oiyGFouxgl2NVHYaVoTN63PXDpFWsnMZeQQ
 Oe1QrHnQUq0seD6pWjYXrK9W+Qp2cLRWg8Ln1fT6oADVeUsj67u783aa+/hPXEPozm0s
 RJ9+/Wnq1hviXR6aqmaF4v3X0Cis/FYHZuyoxHN1fu16pFkn95AfNnF8Y7JYdH+aBgQV
 r3ovd0mHTlWxpauJJFxeKZeVmc23SleOrpvDBk0vbJWMZ5xNu4/MHz+qCC0AKyfwqnnf
 BbdYoZYagJifYCeGU0oxYxw76aurc5aEhRsx2r5ShlG0V/d6EzEFAMOsF/wdF3rF3rEM
 Zhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
 fh=se+tmb/kP9BN6OgR7vw2VXL1jMVfR3Bmh9OjAiW/MkY=;
 b=S7nPm2TUV+7GPK1oPjBXT2kBxiHQtzNhmr3OYf2Aw424wDAuaX4r4JI1svArvHXaKJ
 HzrW5ye4UDZyAimZPZfD3FCnQUm8RYmsXldOVyFAuyKiRtK96glRvAErntanCP7GWCuC
 r98jeZw4DM9bXxnZo/2uK5Sth1gD/7ROkBgDLResiYvx+t42zudaQy93pR4WRTxCcCD+
 CAYpq7yT5OrXKu1Umi9mvb1Xq6jpdXuR6nJpa2IAdZLXP1fVD5bee53aJsUYsUrx0r0x
 ieIXfGpMkvK/PbHggk+iwg6oeNxGjJScO0cLNXyY6jU3p7lzxU9m+XU+aQLroEq61KCg
 5xQQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439349; x=1794044149;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
 b=BA9CdZ5l5hOeGnEhJ0MmgG5ise+5+hq0D37XpXtSKyBR9CdyqaJm6n//OndiMguHSa
 cq+n/ATeGjzw+2XLpo0901GbkC60+0RKFsxzN8phsknDYJPLNyftqnw1j5/srJibRunO
 BSeN3UVKIy8FpbsJ3mosCLIKzb8vphNzEJg9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439349; x=1794044149;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fYTucb/GWBLbRz1tygEyzoDc7GrsfFhGt88WFpDkpTg=;
 b=mC+xO4HDhLtuDyL/Y3SisKn71ZdngxoZxtkD1oYgCeo2UR853QErEAk66Dac/obrXC
 GlQW+NcbznHLfTgmgDtPjYwaI3WVGbF1daSAr9qtCk42dkOZNdVEjLk42rzlh/mPErEo
 Pb7tFItCGo8AvYafgpr8JpkwMwtcxrkwPkqwRz/Hp9p6vYbsKMPW9RFRgjCbhyGrCNgy
 vh6knTlIZPFA8ky8lxaCYItdAJd9dPkIe50P1MAzgjRPWsCTpk70+Y3hB3x0dDZAOsBz
 YZOSJ2e7uRAnXrqgyl+BIFuiXzk5zio6wkp5zzu9iQEa83w9fkRB0RYaGW5G/yNIjd/R
 guvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/2EdmT4IOd7a/Lp2LfwIaDC/hlLKQ0ZIDDBYxG/lkOrsZAEv622PoQwdigf6vC9xrrCk0Q/8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJAOOyYNdKBIirf49dqn7rLheQ/dcFX0Rk92enInJJRqbsp2Zoo
 zcp9Czjm+7GN7iDgS3jsYnvwk5y8w53CJIOs5v/x79y3EkWp9iQYDzAqGhdYEh0/m32+R8D7174
 FMQ7tRQ6B8hBbamYAGO4HxoHn5havDKz1ePB5pHaz
X-Gm-Gg: AYBFou0Jj2jdbgbZ2Mejzhf9xqj5eGKDdvsTDY8dnmmHUK7aNwW/DElyWFByYUYr5Hw
 a3Fv/TzDdYQovOpY7U5zqk8jUjvg6yxr5hutO1gvxG8PRhvV02VAjPMt6uJPqcLEb3l6U3D6OQk
 YGtGJUkd4tSZhXJAeTilIJ5SwZfkIkXDLbcPRHBdawINm31Udi5kw/rJ8TojEfgnmdOEF8Ta29v
 flEPOTPKvraE+0k8FByxi/IqviVhKS3HqatDhIw4sjJAV56TZMjzRVP6qFtZmb3SpJHk4cvkeEY
 kCS+j1hBQNOu0aNFa3oTpJeuGbcPEEfFhss3QVerN0xrkugyjNe8OWbC4fy+uZrN4NkMxFtFSBT
 xLZ/7I9NhLPq5c+anl4I/3nxAFSFd/svS5ydSJxZ5i/nwEyDb34oeHPS9Av5ln9cXwutbStg=
X-Received: by 2002:a05:6402:27d3:b0:6aa:9284:9a99 with SMTP id
 4fb4d7f45d1cf-6b4d33772b7mr3588296a12.6.1793439349719; Sat, 31 Oct 2026
 02:35:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:35:46 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:20 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-24-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-24-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:35:46 -0400
X-Gm-Features: AclHuK9XudhuuDmlh0AIoR0DzmO6Cyxy5XluwX-MzxbjcHwO5JUO9PbiKY2-eNU
Message-ID: <CAFLszTi2oHD7WRpXHDzW-Jg0JOw1C-L-HVfmr1LmgQjOFVYm7Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/37] clk: rockchip: rk3576: Use correct clock
 register for CLK_SARADC
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
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
> clk: rockchip: rk3576: Use correct clock register for CLK_SARADC
>
> Parent and divider fields for CLK_SARADC are located in CLKSEL_CON58 not
> in CLKSEL_CON59. Change to use correct CLKSEL_CON for the CLK_SARADC
> clock.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
