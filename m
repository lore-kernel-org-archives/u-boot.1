Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3865C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 11:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E24588003;
	Tue, 26 Mar 2024 12:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gy0w3j80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7247288003; Tue, 26 Mar 2024 12:14:30 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 570A987F39
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 12:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-221e6bf537dso3311171fac.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711451667; x=1712056467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7bKp6rz7umao5IGhmco9rwd/jYcJUGaE7B09gBQ9ytc=;
 b=Gy0w3j80hJxt4D7GpL55UlmCMF2CsjJg6A9LMbo6AoaJkPBs6XYtlmJyozSONpJoER
 aW537DaoDwgn8kVVgpN/Z1lcB46cYjVkNf4vY4KuNErUo7alSXPjYqzp+6PQYUICA3L1
 6Qb+kFD9Vx5QP5vlvks/ReNHjPWBUQZOa/iNwnS58Nkj7EJgDLld6hWMzWEqUN+ffrQn
 YKX466i8X1TRIwhMqRHTEOPyFCNAmvT5qLhD+AHHldUt/xtvwSd6FY3C8cfdWhlHJfrV
 aosyjDACMJyoVAm9GM9fmyXUVevAmzi/uRa7E1CTH94Vy6q0/SzMBlsHLkM0J8+HhCx8
 nBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711451667; x=1712056467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7bKp6rz7umao5IGhmco9rwd/jYcJUGaE7B09gBQ9ytc=;
 b=wUZPu32Ze9TE0uPd07Eaz+E8tpkwPikUMdePPAxox5LbMp12R8Rf0j6sQCCdDWULgO
 aHa3J7T1J1kLEAQ4Cf6O6jVSCMlh3Gwq16KHO8C3/Z25UXYNm2/yMrI2uRfmBF4copL1
 fthAiKjwA+iIpZh8irKqDk8ktl+zf+gJeGLjE4s6ZXiqCEKeWgSzaNPt+zJ4pPKRkNpv
 Jpqwxzcwio/yithPzOSIaAD1TPdnMaP3bcjaSzL6xyurLSYkxugBli+/vBgudw0G1836
 su6zrjWZMXBYzuJcowIQXwzpfAFoMAsHo9i5OlJViVFqMHlYsLbgenOv88Aws5JeMfr6
 23ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpJ0Y1sbWLA2OtCPhBZlQNRoPKLQzAfy9AhS4QMeXI8fsMs8eonWZTshSnmw9/qcm9DNxLlSYnJlwGjcbQB0OND4bDpg==
X-Gm-Message-State: AOJu0Yxn1XsBXHKdc2v/6wkjrJ5nwAxt7vEadzDMXevnqojWluJJpq50
 43wAmczgSqBY2p31oTX6g3U/VaivnsoiTTVxU8ol2OiTneAthyjmvqrHAQLgqJgSTL/l3PnExMI
 OC9SAJFItGGFd2bJSzVhNvGFNJw8=
X-Google-Smtp-Source: AGHT+IFT+NEuvbumI2/eVrRkZLOm6IyCC/b7ioOO3aGul9A67Yr6zVyUT+lmG/Jrf1eSOJpAQG5c9e7F4LruiXNyVxQ=
X-Received: by 2002:a05:6870:a686:b0:220:941d:18b7 with SMTP id
 i6-20020a056870a68600b00220941d18b7mr988825oam.59.1711451667129; Tue, 26 Mar
 2024 04:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240308021858.28249-1-semen.protsenko@linaro.org>
 <CAPLW+4=j88CCjkWK163iQSuW3RiV9q7DrsixrmWKpjhQzFmMvA@mail.gmail.com>
In-Reply-To: <CAPLW+4=j88CCjkWK163iQSuW3RiV9q7DrsixrmWKpjhQzFmMvA@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 26 Mar 2024 20:14:13 +0900
Message-ID: <CALrBrZ2TbMWPgvwcEJG6-=Mg6w5tygCqV2Whz8LwtTk4SwBX3w@mail.gmail.com>
Subject: Re: [PATCH 0/4] clk: exynos: Prepare clocks for eMMC enablement
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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


2024=EB=85=84 3=EC=9B=94 20=EC=9D=BC (=EC=88=98) 03:44, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Lukasz, Sean, Tom,
>
> If there are no comments on this series, can you please apply it?
>
> Thanks!
>
> On Thu, Mar 7, 2024 at 8:18=E2=80=AFPM Sam Protsenko <semen.protsenko@lin=
aro.org>
> wrote:
> >
> > This short series features a couple of Exynos850 clock driver fixes and
> > adds new clocks needed for further eMMC and SD card enablement.
> >
> > Sam Protsenko (4):
> >   clk: exynos: Re-arrange clocks in Exynos850 CMU_TOP
> >   clk: exynos: Don't expose prototypes for not used functions
> >   clk: exynos: Fix incorrect clock lookup for non-top CMUs
> >   clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850
> >
> >  drivers/clk/exynos/clk-exynos850.c | 326 ++++++++++++++++++++++++++---
> >  drivers/clk/exynos/clk-pll.c       |   6 +-
> >  drivers/clk/exynos/clk-pll.h       |   6 +
> >  drivers/clk/exynos/clk.c           |  47 +++--
> >  drivers/clk/exynos/clk.h           |  70 +++++--
> >  5 files changed, 384 insertions(+), 71 deletions(-)
> >
> > --
> > 2.39.2
> >


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
