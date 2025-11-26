Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015F0D10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E49841E6;
	Wed, 26 Nov 2025 14:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEg00Ttb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7198A8309A; Wed, 26 Nov 2025 09:46:16 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6744D82B20
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-37a33f49018so21491591fa.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764146773; x=1764751573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ow+nHlQ3BpUTJdAEZN6/VyBkps8D5D+YNO3hCG+eK+M=;
 b=MEg00TtbL8EiW24MAkLDe85mPayfuDf9JU9svUKtFGO9Dq/LINj0Tz4HClpOdNGwdm
 56yyqcA1tr7qJLpCAqGW9yA4GpZz5NstPJhhRfBQ0BnTIlHAZEASytNEBx+pa0KeV+pA
 MPH+pXnLm9sFYouTSk5bLEriwbFCLKTgrgcv3+YXPXNoGSmBEuAJ9Ok80AmLqa7tYhNX
 JwKFCfEqWNhjsy6FZU5KirZa2X64t/axp8x5mO8m/KOkWao0i2AR218yDPYbC19hlA/u
 hxghvRfhWmmnrxpxuaY/TAzB3jrZ/tLZzFuztovNMHCIxmFOKoqtnJIiibEsJWXjKlUY
 d7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764146773; x=1764751573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow+nHlQ3BpUTJdAEZN6/VyBkps8D5D+YNO3hCG+eK+M=;
 b=vRSuVuCwZ3UhbykpR9fh2JssRGhy0MAZlS3uA7KUkWu6E/COflCf9V6Bk44tVYLcgb
 TAZ7DXPx3C0BSyF+oyo3yovQjW0k7F+f49zxJkuotlc5h3CwsLiBsU4qme9KnjqUAm/e
 CQnk+PcpZHpviR1BJ/ukR5LZ1X79Tx8Kz5A7KK/JGIUxPEYXTcSv5lf2yvC0u8g3xAiF
 fFsP7WNyhQNbfWAUKBvLiWMSn/4EhF5ptJWWnGY+CrLahUxqTAlGP2hM5x+tdfCag5dY
 1j/4yf7zu0rtFdjEzKDpdMVh27uTK27Xo/t1Ky6U7Q1fQ7uRcnBMBY+4yol/OEdEjf38
 HjpQ==
X-Gm-Message-State: AOJu0YxhbI2oTsInYArH01djU7O8hbk3n/f4teVwBH8oxhVZjAiCLCBC
 EnX0QKRIWz7EwO1ecXmJKdnr72T7FzXRt3ASz3lD1rqXV/qSmFtq2Ljyi26PktCLABEzoJ1hg9Q
 +oVCXQM0RXSOtixNvsrnw9y2cQnQRIKM=
X-Gm-Gg: ASbGncsGwkwCXCk4uzxmxK633Hw0SYsUgwisjyugSd542rQ+5/ntwQqL2ww6VC7pFSR
 msEtCSK5V/6yzj20v8/WXN2gDThsBm5LArCQCJkSeXbi4KYUqZumAZBFnlZSfDHlkgocUyF9wP2
 Djci/jxpUp0f51htQ9aTu5wJvTUErWI56trjoEDtkme9uEQdz18pDsrcWISDriPsOVQoTFQxpth
 RPvVGnTq/HTd2OIbnysMDdqt3vyX0FwvMW7GGr73A4hx2RFBXN8wsvg+0Rp5/bZ4tytPpzVMUt5
 qNDgfGNYl0+wlAhp8HrpOHW7s861
X-Google-Smtp-Source: AGHT+IH4PD+zWnqIaPJzRgjpvPnLFbOWTE8SY3XTJApAf8AIm7L5tmeuPyCI9ul16pf18cez0ysN/rJFvCzXeXDG8f0=
X-Received: by 2002:a2e:95d8:0:b0:37b:971a:211f with SMTP id
 38308e7fff4ca-37cd929ba9bmr46198611fa.44.1764146773299; Wed, 26 Nov 2025
 00:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
In-Reply-To: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 17:46:00 +0900
X-Gm-Features: AWmQ_bm4Qx3rPGa2na9YTb3DdSbeFAO2iehrFjv__ELOCZrYePxbCsOQQbsUegA
Message-ID: <CALrBrZ1mMhGqBO_Otwe0V3aZn7Wdm-Lwb+GNWLsjq+1qAOwW=A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Support for Samsung Exynos 7870 CCF driver
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Marek Vasut <marex@denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

2025=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=ED=86=A0) 00:22, Kaustabh Chakrabor=
ty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This series is aimed towards adding support for the Exynos 7870 CCF
> driver. It also includes some changes to the existing Exynos clock
> framework, such as support for fixed rate and fixed factor clocks.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (6):
>       clk: exynos: provide device pointer to clk_register_* functions
>       clk: exynos: add support for fixed rate and fixed factor clocks
>       clk: exynos: add support for PLL1417X
>       clk: exynos: add function for Samsung CMU ops->request
>       clk: exynos: add support for Exynos7870 CMU
>       clk: use private clk struct to access clock flags
>
>  drivers/clk/clk-uclass.c            |   6 +-
>  drivers/clk/exynos/Kconfig          |   7 +
>  drivers/clk/exynos/Makefile         |   1 +
>  drivers/clk/exynos/clk-exynos7870.c | 929
> ++++++++++++++++++++++++++++++++++++
>  drivers/clk/exynos/clk-pll.c        |   4 +-
>  drivers/clk/exynos/clk-pll.h        |   4 +-
>  drivers/clk/exynos/clk.c            |  99 +++-
>  drivers/clk/exynos/clk.h            |  53 ++
>  8 files changed, 1079 insertions(+), 24 deletions(-)
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251017-clk-exynos7870-4de4be26f22e
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.
