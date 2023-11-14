Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5A3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9EA870E7;
	Tue, 14 Nov 2023 11:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TsLHlRdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7598715E; Tue, 14 Nov 2023 11:42:01 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A50870E7
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-581ed744114so2452258eaf.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699958513; x=1700563313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rjtHabw4TGk8M9pxj1XIGZRGnt4Ho8fUgNimAXX5/pc=;
 b=TsLHlRdE1cIxgLe/cUcCrw3XzheVLj0DWKKcXkZvJtK4oo2IzRPRJabCe0Asanf15N
 Jwsk2/u++vQ1NYCelt3jFcu/cD3/r7Dcl+dQLQVlnRfLe5/V6kgtQ5sfC3kM3WWBvhLu
 1SmivfVfTQsEEVELE88Sh+2EcTtKD7Ppja87mEFVjgg3fsobL1O/sFXZgGE2jVxP4i41
 nN56CZIOig+2njYaUdqqYYMVVAhCZ1aY1N5AvWANkdWll6fTcvptwP9h0R1BPdWFTACS
 Bqq2RLP+nWngnk3jUJAUYmqdH+oI/RpZnb5D4WIzWUyf1ygBsca6DXqfyyBuDeuJPmGx
 Ubcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699958513; x=1700563313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjtHabw4TGk8M9pxj1XIGZRGnt4Ho8fUgNimAXX5/pc=;
 b=wgfsI2OhvMNGk/GSXZ3/1L5Gm2A4Zp1A3QFHq26ITDioatYSpu2SB/H7LphmELjMhk
 35zKunCtCbFvmVelgE1inNFU/bTCJ/IEC8lI2VvssuRtwX9aoJObtv4AwnM7vE7Cr25h
 mxp3x0X7iTkpjj76UIqsdVXC3CkzcrRLL2NLi/VJzEi73cWZtfyz2OPC+Si+NFPjt3Pf
 +e8hYZGf2dT8do8htFaKsGdFAKesSjuHG5yzHzTwncMmWihfAPKdEnL7b7Xk6uKKwCBf
 3U8xnT+vJFyVQ1ldMY3HPBl8hUcs9mRMNB0mTmG2MKMdhRToj/48dzZddeZPxEQjkJsD
 lcCw==
X-Gm-Message-State: AOJu0YxW3LZHX204+9/YySf20JxZfnMGc2Gfsa4/6Ipmvmu7P2PBQU+P
 krFbTMn87U7DKoRVuAEUc0n6eVNVYWMmfsgNVI8=
X-Google-Smtp-Source: AGHT+IFmqAX8H/RXGP0ohssrIZc184zA9bvt/fNGSFYrLkHycXDGU62okjfsggAPsN/vNVHngUmEatDdSKoS2yU6OEQ=
X-Received: by 2002:a4a:621c:0:b0:57b:de27:28ed with SMTP id
 x28-20020a4a621c000000b0057bde2728edmr7881638ooc.6.1699958513265; Tue, 14 Nov
 2023 02:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20231020214633.30883-1-semen.protsenko@linaro.org>
In-Reply-To: <20231020214633.30883-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 14 Nov 2023 19:41:41 +0900
Message-ID: <CALrBrZ0Zmk-x3ZeF13SPFcu=9ATLdNgeGfQcOa4+oV7hp9RkRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] exynos: Include missing CPU headers
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi


2023=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=ED=86=A0) 06:46, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> During porting a new Exynos-based board to U-Boot I faced a couple of
> similar build errors due to missing <asm/arch/cpu.h> inclusion. This
> series make sure it's fixed in all places I found.
>
> Sam Protsenko (3):
>   arm: exynos: Include missing CPU header in soc.c
>   arm: exynos: Include missing CPU header in gpio.h
>   watchdog: s5p_wdt: Include missing CPU header
>
>  arch/arm/mach-exynos/include/mach/gpio.h | 3 +++
>  arch/arm/mach-exynos/soc.c               | 1 +
>  drivers/watchdog/s5p_wdt.c               | 1 +
>  3 files changed, 5 insertions(+)
>
> --
> 2.39.2
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
