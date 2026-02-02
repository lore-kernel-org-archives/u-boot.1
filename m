Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C427E7DEEF
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 14:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3BB83E8E;
	Mon,  2 Feb 2026 15:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGN+wmrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A606A83D7A; Mon,  2 Feb 2026 09:11:41 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B79D83CEE
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59b6c89d302so4536167e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 00:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770019899; cv=none;
 d=google.com; s=arc-20240605;
 b=E9iRU8h7m2L5mx2KlOU8Id6XEEfggulaRaEzz12ez5WpJs3Bk1Hf5VjJ6IcjadABJ/
 dilGtgbBBDaRQfIDWIqzZx1a6nvmA2GrlZ/ziZTzSMArS+gCI+CYCGdFIWL2oZd472Jf
 f/afrQSV20hd7OvhJ1d0G2qsgEXiQ8DpNoFpvVqb3IeVXJsKraZC5nDjWhImvi27VtZi
 IlNF83bG3eIsf5T5Cl88y9BS8hrQWCTf2s6hg53lOTFRlsTB2pDepL2ZmWTe+I2wnKfB
 kyePmFxOubWCAtWIGrUmLy5kteeFgxpPxXEcqtqdg7Hffj8/Xj63LcEfrPY875oxvcYW
 ys0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UrS6jd2f9IOSrBu3iL/j5N1p0gyTUkeblirkM2gQJb4=;
 fh=APeJgXyC23rnxokhuFV/xFl/IxtYzqG1YL7DmYO7g3o=;
 b=UwH8Ro5whE8YKCT+x4mJHXjOBasxn3FIT/3vUA4Ba3lmKkLFzltor8Vm7ZU/WMjXqz
 PGwfJCtKLJLV0q2LwvL94Th2v4yyKAaKR/C9LEMJ+fTIPKJKgpyFRgEohlt4YX9bVtgM
 ApC4byyqyMYB8NRz4/lJJzPqfEYpNxBnmmOgJWuzTMU337PajcQZDGxwxnM0/aJBhMF7
 fOxCvlfCXqVfvy0T4Qb3ClicpjkDWlirrubBAqxIPGm0mSBP1NufAUGiMylxkV3m5G1X
 dXIsLv6oVgHvq1cI4bXDdChwc2QjvCVlX426RcoEqvK5zS5m6hTKgcYNKtSXc/Acxead
 9UyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770019899; x=1770624699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UrS6jd2f9IOSrBu3iL/j5N1p0gyTUkeblirkM2gQJb4=;
 b=LGN+wmrqTSFLv6jStMMTt7W0QUoEErGsjlEE49pYwAw4SeyJFmYSYxdn+9cJJo9jAj
 CEZ3ebY4LuYKzYnsruqXhYOkaZW+OIOiguU2NZF9lkJzHLPuk4Niq3VYy+D7n7/Hy9jz
 nxWSO3t7JhNMD+jxoSUt+19GibillfRtOl1ZuDI+gjAsC4dTYpK7HWLznBJCS7i0uFys
 i5YyF/ZR/HsyWO0XRSMHPFE6F2HJ9SNDbsf3VehnGiecXWI4m8uZ7MvvsKLEcmb14qGx
 e1F0pizkztGmRL//gsWUCCML1zI1uLRkjmLzPRCZSbEMSBkxOwPnXoD6gq4jAn8WdCse
 fpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770019899; x=1770624699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrS6jd2f9IOSrBu3iL/j5N1p0gyTUkeblirkM2gQJb4=;
 b=EnwCDVxKAp3/K+rk4L6UNx4IL9tmClOAavVukhfC1ID6D1AXGVvdfusp+EFph4RRG+
 5Lx8Dfpg/WbLGK6rAzWFqNLnPMDya4+E6RwagbYduujpGJv5WsV/br5wKblHeZ+skPb/
 GZMkdbxOeg3Ec085uh470Sw/kNmBwA2PVChSmXpw76a0kq9/nmMcz7W7iB9rvf4upwLg
 WTw8A0yecLcYNM83U6oKTdWs7BgpeFobvj3GqpLhuj1iJYbFD9kYZB6cNHhzgWNyd7WR
 /XwZE509jIAEA13VHesOb5eUE8iv5nlcFYDeoTOoINA5bWUNkQcss8x/JEVK4hh3ohVm
 3GXw==
X-Gm-Message-State: AOJu0YwWVRYAT5YTuSU1cRfeZ1pLulKFtGOPb1RLCGvtUmDOXYE5N8Hb
 lXxSPfN/Ur2Vog7P5ANTAzirzul8YQpMPmKl5bXYj/+5OmRJ9VS3qw0iBU3R4CwA7RHbgS7NTS0
 BVkHG2VqL4yOLogcuFwTq+UUpI0meP1HW2Q==
X-Gm-Gg: AZuq6aJI5+WagqGtxUOPLVG6eXDTg+5sLTlzVsrm3CV4wny4GpSK/zNZo5skPahTtL6
 Zwav4eVC+S+cW8X4LsUGEwFy3I9g11kjnTmM5VOvrTZ9xLhc/H2TmdTXFhbfsYX1BsUIT79+M86
 artBwFnfVhCKSeC+kVylj3Mwy0ChR68hH+pwt6yrax/SWqEAQwrdK9ieNUrtPLD/mDuTno2uD3B
 VrFQgjAm5ngl3Md7j1qfNS1vq/kMvjFFfzUARMvH4aq4v+bX6FT4XzbiNrhy5FutCYJkd5gze6M
 14WbZndEB6IVgYXOBa4w3ZTWwQ==
X-Received: by 2002:a05:6512:b24:b0:59e:9b0:165f with SMTP id
 2adb3069b0e04-59e16412c95mr4575398e87.39.1770019898283; Mon, 02 Feb 2026
 00:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20260126-dtsi-simplefb-v1-0-0f7b65968299@disroot.org>
In-Reply-To: <20260126-dtsi-simplefb-v1-0-0f7b65968299@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 2 Feb 2026 17:11:25 +0900
X-Gm-Features: AZwV_QjsjFwXKOat5EqCbpNmudPB_AGPwuonPc49wIz6OqLBsreQ_JNcS8aOQeI
Message-ID: <CALrBrZ2OmR4E5WONheUMixp67WncvgQHbiua1Zz+7=74QqqaJA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add simple-framebuffer support for supported Exynos
 7870 devices
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Mon, 02 Feb 2026 15:12:15 +0100
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

Dear Chakraborty,

2026=EB=85=84 1=EC=9B=94 27=EC=9D=BC (=ED=99=94) 00:24, Kaustabh Chakrabort=
y <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Since Linux v6.19 (and subsequently its devicetree-rebasing repository),
> simple-framebuffer as been removed from upstream device tree of
> supported Exynos 7870 devices in favor of Samsung's DECON IP for
> display. Since U-Boot lacks a driver, the display is non-functional.
>
> Add framebuffer support in U-Boot's device tree, which is included in
> upstream device tree during build.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (3):
>       ARM: dts: add dtsi for exynos7870-a2corelte (Samsung Galaxy A2 Core=
)
>       ARM: dts: add dtsi for exynos7870-j6lte (Samsung Galaxy J6)
>       ARM: dts: add dtsi for exynos7870-on7xelte (Samsung Galaxy J7 Prime=
)
>
>  arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi | 21 +++++++++++++++++++++
>  arch/arm/dts/exynos7870-j6lte-u-boot.dtsi     | 21 +++++++++++++++++++++
>  arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi  | 21 +++++++++++++++++++++
>  3 files changed, 63 insertions(+)
> ---
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> change-id: 20260126-dtsi-simplefb-c91f015e2e8f
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
