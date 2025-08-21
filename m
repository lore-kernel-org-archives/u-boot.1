Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2501CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 00:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EBC82B07;
	Thu, 21 Aug 2025 02:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="iC12qZuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD0082E34; Thu, 21 Aug 2025 02:51:57 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D9D81E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 02:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30cceb3be82so505611fac.2
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755737513; x=1756342313; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfV/132JC5dMN905UUqh85JDxc9Gs7KQ9CX9vap+Cl4=;
 b=iC12qZuI1sRFcV0dVJ3PpHUz6Kcjf4vUBucntQIwcOod2nRAa2viuMkqGztmXw3ddt
 QT67c8/WSkpSv4ApQNNSSzOIrg0HUQCfTpRQkZ3ji761dpVo4wJ+Grgr/8QTsTSWIO24
 UnZdJ0Gp00tOyQCDpip+Q2sMR0zxm5vHiLHn/l2AZ1QR+GTixAJlWMcc/DqvbTvlLAb6
 Ta1NB76HDN4Lrjx/6218IuBccsZ1Grkg2byE/6ff6ameXU46ZYSL1f3qB7hDabNsE/Lb
 +W1mEm6mKFQ7WTD5Ad+g5XtWZBRNXvI3miI5NBjJRiWZdPwAimW9CeQu7KtRMC5ih8uR
 Qopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755737513; x=1756342313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfV/132JC5dMN905UUqh85JDxc9Gs7KQ9CX9vap+Cl4=;
 b=gQTpXqXgyKC57hsyLJ6iRcIbyg24jifQFsmxFWyp8nXRt/tkNRW5OSaE3sNvS/kVTK
 9ohGSVubrviqs+8cERiQMOWTawS3Pz9bIaJg5p3W9mnRQmecxRh90K9uFzzhQImKPIVY
 Uwx4evTPKPnzu7ObiAC+2IjlwwF3JlXgHGf43b9i0FgXw6UF18KYB7+vcTInVWfUKbZ0
 XY+QigSgwCBC3N7wN2dLWPO5OPXRqfdMSkM3r9NTRv9SWy4uR/zuSm+Nup3VzqQeZfGr
 untq3l+eDUn7133xq/9vFH4fVqhLSrxSIuQhWFwVfNAe4nLVhf0K+VEvu2m9bn3866co
 7Ijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvBmDR9wDUpq7KM7fMcllsRjRsmoZCF/EAwX1Z4Pj+oi4qKd6Lj1/Z80+zrkZzp9RVAuevCnk=@lists.denx.de
X-Gm-Message-State: AOJu0YztGsgSxmA3xVXZFbMO+bhx+2Kp8+t3rZGq81TJMtANHIf2BWuk
 zoAQuqD88PSQtEBipYRyXLCJGUVbnmmQR+Ab09RqBrWiV/nWtRVCAIiltIeQoPjPANxX+hwKwOF
 jBr+C36gDBd9X0ggXUNwDVKsHkKY1lTaJ2umTOI5Tjw==
X-Gm-Gg: ASbGncvwNYUMIAv8CF2sJkH/WqN5aXuSV5l9lZ+Sb7iN3jUcOUvpY3gYRV8mtkDk8No
 nUTnMLI15VKOzsScSc8w+oVLjAJhxi1vyeDYbQhVQ30cOdgCS+GHzj67zG7nuC9m9pOye8ugxwM
 MXG97RADuBGGEhp+SWwvYVHj1qaVdroQnqHxrr+uns0FGwBhN8dP3UmsRJL8l48lNLQyMnkM2w/
 fP+VbMT2Z17qTo+Xw==
X-Google-Smtp-Source: AGHT+IG4foq8lQSqgv5s4aIL8osAemuzFzI7MfJPQgzBJ8zYdrNEgTm+uB4XmWcrfSQ5WYwe5L78d2+n79uPPU/fJ7A=
X-Received: by 2002:a05:6871:4cc:b0:308:fc2b:b78 with SMTP id
 586e51a60fabf-314c656715emr373855fac.41.1755737512889; Wed, 20 Aug 2025
 17:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
In-Reply-To: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 20 Aug 2025 17:51:41 -0700
X-Gm-Features: Ac12FXy1Qejs6frCXly_yxIlPluhJmCFsE24XkZ_VqU6JobLkP2CU_yJUtK40G4
Message-ID: <CAJ+vNU0q4ogZuNSxCMNPwXq4-ojqi7ss8ABYip0Q-BfSkvaidA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ye Li <ye.li@nxp.com>
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

On Wed, Aug 20, 2025 at 4:05=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Changes for v3:
>  - update the binman etype to generate a configuration file and a .bin
>    file
>  - update Get ahab-container.img in imx95_evk.rst
>  - rename configs/imx95.config to configs/imx95_evk.config
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (2):
>       binman: add a new entry type to support .bin file generation for th=
e i.MX95 platform
>       imx95_evk: Restore support for i.MX95 A0 silicon
>
>  Makefile                                  |   3 +-
>  arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
>  arch/arm/mach-imx/Makefile                |   5 +
>  arch/arm/mach-imx/imx9/Kconfig            |   5 +-
>  arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
>  board/freescale/imx95_evk/MAINTAINERS     |   1 +
>  configs/imx95_19x19_evk_defconfig         | 153 +-----------------------=
------
>  configs/imx95_a0_19x19_evk_defconfig      |   2 +
>  configs/imx95_evk.config                  | 150 ++++++++++++++++++++++++=
+++++
>  doc/board/nxp/imx95_evk.rst               |  42 +++++++-
>  tools/binman/entries.rst                  |  12 +++
>  tools/binman/etype/nxp_imx9image.py       |  85 +++++++++++++++++
>  13 files changed, 338 insertions(+), 191 deletions(-)
> ---
> base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
> change-id: 20250809-imx95-10b5b18e0ad7
>
> Best regards,
> --
> Alice Guo <alice.guo@oss.nxp.com>
>

Hi Alice,

I have a board with IMX95 A1 silicon - with respect to this
documentation should that be considered A0 vs B0? Are there any issues
with A1 that would make the oei/sm/atf/uboot not compatible here?

As far as I can tell the only part of boot firmware that needs
compile-time configuration based on silicon revision is the imx-oei
and I only see special handling for r=3DA0. If I build with anything
other than r=3DA0 the OEI does not run for me whereas building with r=3DA0
the OEI's appear to run fine yet I don't seem to make it to U-Boot
SPL.

Any ideas?

Best Regards,

Tim
