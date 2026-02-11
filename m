Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF4DEB596B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 07:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD11F83A5A;
	Wed, 11 Feb 2026 08:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IOhmDSuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE4683BF4; Wed, 11 Feb 2026 08:20:35 +0100 (CET)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6548367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2b82c605dbdso3602788eec.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 23:20:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770794431; cv=none;
 d=google.com; s=arc-20240605;
 b=RRbiv9+F9FFsZJ8TW1pEg+gS1hgYLtkSSAJfc5r0E4YN3sgOaECm8NqQJmsDEXJeMe
 Dilbpd62hHLW00yqayPzkQuyGQ+R6h8mpdhb/g2UuJhJMMK/KORzM/udwxMVZ9qSLEiY
 6rw8hoECTPGLe0IcGB1SGf1s9TMDNSCGgs1lYnuJ8Wraxrszby+cFMcYB6rMQg5GxewM
 da22+SF1cN2L48Jii0y3OFvQkW4cZ07FBsZTBtM8umH9O9W0UFfpNlqY1Ne4mfqb1yJo
 mejMAeUoLAVmD9+ZxJT14TsyAL4Gf3nvG9X1uG28WttDZfct4dI70o1x2aHfZzbd0nRR
 c36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9iNKT6ZhpJpmgFkBM2rHbaZhfbLbFdZsg7dvWgZ/JiY=;
 fh=6kPG6ZKds6QQAQW9kh+rLrQdwbPhMrxKMrmS61k4qP8=;
 b=iLg8HSB/N8Mn3YX2/5AZwMOpzCYj/6N8Vh6/yyfNR/yECsI2wlmKQLQH23X+Ts8T+1
 lKaDbltqVaR4PlxaK47CgDKCgnarM/+hlzO1PeTyiA8ADn/MxjavSbgPbPQdAqguPcM8
 HzKeRWgHzo121xsbp1RoCiM3zyThFyddBSvxnAwaVW4G7bjEQAh8iT31rrtEXskpvb98
 3m8hXWFFcxF5R1aSF4OVaRddUBN0zRxrENP0QtLIP9EiHJDvJmLQ8ZtgFZD930cHAZ5a
 qoGRgt9K/XDoUU3UkDUb225YRhj5zAN3g7jpOHMUYIYo3Yt1ZfEdUj9mNFvjRA7TQ66e
 G9+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1770794431; x=1771399231;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iNKT6ZhpJpmgFkBM2rHbaZhfbLbFdZsg7dvWgZ/JiY=;
 b=IOhmDSuS+E2i8pj2+kIrYRRSJjTUIO/kbohOZrxBfV3bxRBdgLkgYTHVhuWStE6qKw
 4wXG0WOLcj7UJfuR03yZzIWDeOTwZWpOo2gquvg8MItch0gUs+g1Lyt2QeFwY68iSLCr
 v1wtJGDnl5Nmr2uwQjZB7WDp0rPE3RZvEdcJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770794431; x=1771399231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9iNKT6ZhpJpmgFkBM2rHbaZhfbLbFdZsg7dvWgZ/JiY=;
 b=lYRTFaAiui0EQNIEWsz7+SrUmD+0sfhJ376rNyuNru4XWTa/bqxEPfKTJG53IiBkN6
 7KehcUJZTdonPlLU2PNbO8K3ofG/V1jBO1vf33/p3Z3CRrbzgdbq15Gc5DEyHlFCvHOB
 A6kFGAY3zmq2pJZp7oC51zIs9CtAITAltYz0OEm2rktZXaVxduJK7AWasrbI7+FSgcJq
 HqE3xqlWr9T4Pjb81DmX3R0vmKuqYYBT6pGpH9neKDbmUYGKnlFd1N7Lmnc8swThGqd+
 qH7PDXtWt+UqweAOim/r30sHZzjGDhiJO2HRRCR6fq9C6fvunindTZPeqKgQJWPYs0ve
 yafg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy5ZeAqwM/bCR9xiiJHK9B7xEvKetuo4Ymgv44WIGlmFd+UtGPy6fxymqPBZJZ+/UGaBuTv/c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7KoMlYCMjhxzMgee9QajlR7oryC2WVwrRfsFE+YehP9QCWfOg
 04KSJCx61Xuw/aNlIFMJGONrxyCM33oQmBoXsC2J09RZTn+Bj4wBXZHmWTs1a5NT5wVFhVcQSMf
 bDciRqStlf+fCCTP5nsFcHnZzMEy7fCeSiFZs9v+xPw==
X-Gm-Gg: AZuq6aIPAdWdjQEgWHnvRvvQbNtOS+miOPhja+kZrqJt9BQbln9P4OB5DHKoygjg5wt
 ZKOffEDy5Czftzp+IOLcn8lJ7YZ6epT8QMeeD581ARP/7bp2XHS+ZVLd7V3A2TXlx3WlAlww9UA
 R5SFyUYAVu1FsTWACDaUFDhlnStTkoj/dCvp2yPnU3KOtPBAOouZOghXZWdxIQAbnerf602ccz1
 RQaELiVaQbcX1cpm895fzpRYqykrqQx20LqE5sabagd9YgcqtRzw6Ty/Ic3BZKYQhInKmyr+rbZ
 NPqFuWn8M30N7vX2kyImYOK/wtkuxo7xL6EiMw==
X-Received: by 2002:a05:7301:169a:b0:2ba:7526:f752 with SMTP id
 5a478bee46e88-2ba752702e9mr3584996eec.25.1770794431282; Tue, 10 Feb 2026
 23:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-2-dinesh.maniyam@altera.com>
 <20260203145742.GH2603314@bill-the-cat>
 <074a310c-5ba3-4304-ab37-2c85d8cd58da@altera.com>
In-Reply-To: <074a310c-5ba3-4304-ab37-2c85d8cd58da@altera.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 11 Feb 2026 08:20:20 +0100
X-Gm-Features: AZwV_Qghho_LjffoTG5sSOTqLeLxwfAHoIoBei0iRNl59MwXCXxSXCfkjba6SDo
Message-ID: <CAOf5uwkE_hfjLkxbOn-O2o3sYSGqAV0TVdZ7yg6eZqJgWGjDCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>, 
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>, 
 Alif <alif.zakuan.yuslaimi@altera.com>
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

Hi

On Wed, Feb 11, 2026 at 8:14=E2=80=AFAM Maniyam, Dinesh
<dinesh.maniyam@altera.com> wrote:
>
> Hi Tom,
>
> On 3/2/2026 10:57 pm, Tom Rini wrote:
>
> On Tue, Feb 03, 2026 at 03:47:17PM +0800, dinesh.maniyam@altera.com wrote=
:
>
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> The SPL NAND MTD framework requires working driver model support
> and sufficient memory resources, which are not available on all
> platforms.
>
> Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
> platforms to explicitly advertise support for compiling the full
> NAND/MTD framework into SPL.
>
> This avoids accidental enablement of the SPL NAND framework on
> platforms that cannot support it and provides a clear capability
> boundary for platform maintainers.
>

This what I have asked in the beginning, for now I don't like to have
this change
in the framework unless we have more consumer. For the patch that you sent =
for
make simple spl load, I will try to start to apply on one of my board

Michael

> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/mtd/nand/raw/Kconfig | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index e0ff28cb21b..d73d8ed4404 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -809,6 +809,36 @@ config SYS_NAND_HW_ECC_OOBFIRST
>   bool "In SPL, read the OOB first and then the data from NAND"
>   depends on SPL_NAND_SIMPLE
>
> +config SPL_NAND_FRAMEWORK_CAPABLE
> + bool
> + depends on SPL_DM
> + depends on SPL_HAS_BSS_LINKER_SECTION
> + depends on SPL_MAX_SIZE >=3D 0x40000
> + help
> +  Indicates that the platform has sufficient SPL capabilities
> +  (driver model, BSS support, and SRAM size) to support the
> +  full NAND/MTD framework in SPL.
> +
> +config SPL_NAND_USE_NAND_FRAMEWORK
> + bool "Use NAND/MTD framework in SPL"
> + depends on SPL_NAND_SUPPORT && MTD
> + depends on SPL_NAND_FRAMEWORK_CAPABLE
> + depends on SPL_ENV_SUPPORT
> + depends on ENV_IS_IN_NAND
> + select SPL_SYS_NAND_SELF_INIT
> + select SPL_NAND_BASE
> + select SPL_NAND_DRIVERS
> + select SPL_NAND_IDENT
> + select SPL_NAND_INIT
> + select SPL_NAND_ECC
> + help
> + Enable loading U-Boot from NAND in SPL using the full
> + NAND/MTD framework instead of the minimal SPL NAND loaders.
> + This provides bad-block aware reads and flexible offset
> + handling via the common NAND/MTD infrastructure.
> + Platforms enabling this option must also provide working
> + driver model support and sufficient SPL memory resources.
> +
>  endif # if SPL
>
>  endif # if MTD_RAW_NAND
>
> This still gets it backwards. Whatever depends on SPL_DM needs to add
> it. The max size is something that needs to be set for your platforms.
> The BSS requirement is not correct (there are platforms today without
> that set).
>
> Thanks for the input.
>
> Understood =E2=80=94 the capability-style symbol is not the right approac=
h
> here. I=E2=80=99ll drop SPL_NAND_FRAMEWORK_CAPABLE and instead move the
> required dependencies directly onto SPL_NAND_USE_NAND_FRAMEWORK.
>
> I=E2=80=99ll also remove the SPL_MAX_SIZE and BSS assumptions from the
> generic Kconfig and ensure the appropriate limits and options are set
> in the affected platform configurations instead.
>
> I=E2=80=99ll rework the patch accordingly.
>
> Dinesh



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
