Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B581FE9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E6883CEE;
	Thu, 19 Feb 2026 19:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQ5eGE/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFE283CF5; Thu, 19 Feb 2026 19:44:13 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB1683AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso959001f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 10:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771526651; cv=none;
 d=google.com; s=arc-20240605;
 b=YEa97RryhsmUDfpq6I/7WRH/DUiSctyW+RoNq0V357F2F7SumqiG8nXOYOAoM8jRBG
 PbSwb2EFGNe2bXqF/sar8QM/ftXcFF2naEHTp8sp9WbGlH0F76YD58jRZ/e8NJ44OyPk
 5hNpCvEVBCw91UJ8fJ/1gqmlg0UMEFdj3CeLUa/pUsUN/QkIQAVjSVRCRv+uIvPh37gW
 9fGZLJYj+13YoEoTrYJkVpv5pUCKTCLtvkPmhWazKvedfg9QslGCkyOmsiwRuVdDej0f
 1ffC48XOdXkFq/iJ+xoCxjWC0lxZjrnUpNy5KJ6R2V/Sq5wELwFLCgCTs38Zv2ats+6j
 R9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Zq3DNaPwP0vy1/unaMj5K20rAFP9lqxMwXmJTi2J3Q=;
 fh=WZ/iznGajHfAm06l1xALJemT7ZcyWWJror9vDFh3CEY=;
 b=W19fgqg0nRl1qMP+rN/R3ObrP374OPw8xffuLyrWc1AAyisWXwU0HyIPx1xMTYH9No
 Yg2ndjm5KyHpNJeJ9edw82i5NShXGFOodh4Zlf4J/xouz+Jap6JM5QGyNSSL/2/PX0DG
 tvJ42aUdXEDR5wQjHFwJsrz+YKUWzr/1oQf94sgaNljUtSnLvUoNPSITHTzefbZQegnV
 rSKJ7fXlbBTL0QX612axd+uR+ub9YnpYY1Gd6pielws0VRhRt0S2sbqdl++VMVS7j0vW
 OBcjVCWCdGX0bLyy7mWy10NcxAiuZQ9XW/Jq8QvmjaeQJGBY0rqZkPZipklfUy0bHGUI
 Fsdg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771526651; x=1772131451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Zq3DNaPwP0vy1/unaMj5K20rAFP9lqxMwXmJTi2J3Q=;
 b=KQ5eGE/bqlNKSzPpnDFoCGRz+cTGRSY6z2PV3U/X7p+dPfhKndHtqeFQW/zaaCI4/S
 2gKianrkmHVVDelsgOUogyj8d7wkG9DTxt08VuWQFzaKix9uDJck3a1isn1/i74oRq1D
 C7yu/UvuhY1WvnsjuDMwNBxnqnWbPFcXSMNDxUhxh1qa6BruJLgNNVmq7jn5yePQ5Kkm
 d+6LWcCfu2HMZlTJdvFYbNPq15fzUtM4rTsrLSK59SfPSImrhnQVIMTIp25cEWg7bDdg
 1maTzhQr6Fmj8WeKOMSzr5z1mBAuKwsiar4bBK3WN5QdgsOtBDyrlw9zGBYMkECjbkj4
 nKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771526651; x=1772131451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Zq3DNaPwP0vy1/unaMj5K20rAFP9lqxMwXmJTi2J3Q=;
 b=ascGKzGdl9qEODCX/XRQMbUACEKuvjeFv5JqwW6nyWQsBwBmCEAGFw08bE0e6DJf3j
 GXBqpqHwifGhjemS+mLuQIIODF70ehyuww0Rq3FT4jpeJICojJR3xA/mzr9Yqp3F6eNN
 PBYCqUzkx5AbJPEv+AX5xNOVN8Ga9FPbtGUBWSD+EgRCYqPDp//HSV4pL2HiPpxpBlN5
 DR4O3jUCWjH3zjOPtp2tlMnvVq528SRWVbyoJRBqAlJyvAkovhXi7nxv/4FCpoz7FRZW
 Pmod/dNwCRUSNGy6rnDozs0vxPQ01NvgORsVbSPtCY0Y/OYQ6AjL01qzAiG+Uv3aKMKf
 aN+g==
X-Gm-Message-State: AOJu0Yw6cn5M5M6u98WqyvdEiBwxlqeOvVoMoeNiqw+QZUopv6nHVQfI
 Q8cFPQSVnWw5HZgN6Gf32huI8S7HH24V7VoizaVMNJ4RCqBsYEPJwNS0bpaFtTO4iya0JBD9weV
 OYewqduC4hiGRIZme2pth36gM27aUFto=
X-Gm-Gg: AZuq6aLgsL/9LE6nMBlRs7TTImxNL9Q/xV+uNGCRb0HdaerWAk+W3sWY4CzNDQat8OH
 R1r4YHa+cJ0rNJq/v+AEZtse9yBXioj54KSDZ3VhZ0RwqiGCctHngqntxSRn1HAc5/tfqP2SCT6
 TifRdhPB4sFY+ctC05kAEOeRd3oz9LiqNPmOXeo9igKXykoFg4ItPy9TpA4nMidMVVi5c88d7oO
 u0sM1G2ACXMrRYsXv8awsWaRTuX21Yje6fel40NBy+jEewcsBC8Vdji9TkUUyZ7L7WjOcA/rvTH
 IhgXedVm
X-Received: by 2002:a5d:64e6:0:b0:437:7168:af50 with SMTP id
 ffacd0b85a97d-4395fd567bdmr6406953f8f.37.1771526650681; Thu, 19 Feb 2026
 10:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 19 Feb 2026 20:43:59 +0200
X-Gm-Features: AaiRm50moCKelt8X3yQGm2Bq93raX6L6smZ7BiwSEIveJ7BveiGb0s296IYUrTI
Message-ID: <CAPVz0n3E-v5EZ8THu76dXUeERrq1MCFyReib5rS9N3DV2Tkidg@mail.gmail.com>
Subject: Re: [PATCH 0/8] video: support Rocktech RK050HR345-CT106A panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 linux-amarula@amarulasolutions.com, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ion Agorria <ion@agorria.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=87=D1=82, 19 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:51 Dari=
o Binacchi
<dario.binacchi@amarulasolutions.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This series adds support for the Rocktech RK050HR345-CT106A panel.
> The initialization of this panel requires a 9-bit word length
> configuration. To support this, I have extended the STM32 SPI driver
> (including support for the STM32MP25 SoC) to implement the set_wordlen
> operation.
>
> To properly validate these changes and ensure the SPI uclass correctly
> handles the word length propagation, I have also implemented the
> corresponding logic in the sandbox driver and added a dedicated unit
> test.
>
> I have grouped these patches together to provide a complete overview of
> the implementation and its verification.
>
>
> Dario Binacchi (8):
>   spi: add support for bits-per-word setting
>   spi: sandbox_spi: support wordlen setup
>   test: spi: add sandbox_spi_get_wordlen interface
>   test: dm: spi: add testcase for spi_set_wordlen()

Hello Dario!

You should not need to modify spi framework to support 9 bit len xfer.
dm_spi_xfer supports this already, you need only stm32 support for
non-aligned xfers.

You can refer to ssd2825 bridge as an example of 9-bit spi
communication for write and 16 bit reads.

>   spi: stm32: clean up buffer length assignment
>   spi: stm32: add support for bits-per-word setting
>   spi: stm32: extend support to STM32MP25
>   video: support Rocktech RK050HR345-CT106A panel
>
>  arch/sandbox/include/asm/test.h |   8 +
>  drivers/spi/sandbox_spi.c       |  21 ++
>  drivers/spi/spi-uclass.c        |  19 ++
>  drivers/spi/stm32_spi.c         |  67 +++++-
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
>  include/spi.h                   |  12 ++
>  test/dm/spi.c                   |  16 ++
>  9 files changed, 499 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/video/ilitek-ili9806e.c
>
> --
> 2.43.0
>
> base-commit: 7dca54ef4c44c82bdc6716ac6cdc84c22c66e9ed
> branch: RK050HR345-CT106A-ON-SPI
