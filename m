Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740BDC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 15:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155178622D;
	Sat, 26 Aug 2023 17:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="H0L5CIHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D677D8620C; Sat, 26 Aug 2023 17:16:58 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E568622D
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 17:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so12677595ad.1
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1693063012; x=1693667812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kr2XLVdoNi3Ms+y/fdDEfE95vFiaFC7On+38TLZNbog=;
 b=H0L5CIHt0WTYFkI/ykfbAbjAgt7sRb6TBZ4MCnBKgxoy12SNLu0Koye3+I/Exyn+uj
 cS7sim/VKfwWfoeaF/juFH8VA9Odxlwun8hMGKoqaiuMlk7/8TH1EqKTe4tQzOuyEh+V
 ranZBZzpvqlAZEHE+ZdXvI3/DUUY1iEB/XRnKGj7dl9agI4yCpu/0nTwNcDIe6ZyrsNY
 kW0hxJ8NFwpQx8xpC1zyBiCxFFyzaQpNXO64QBR84yQ90leQ1ZGaIgZbRj7w72fZJOfq
 BpukcsCT9DzBgSQBUc47QMdVEXeXCmvpyB1eMZPtTtZswydpdgHhulBeM4Ftt+bia4HD
 kIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693063012; x=1693667812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr2XLVdoNi3Ms+y/fdDEfE95vFiaFC7On+38TLZNbog=;
 b=Qz2RKGxNiF3/1rPO62vInpz+qa8KGh6jmYlkuf8o/vzZK4xm+RtVtaU/eqjQBQ2F99
 xzpSvI9DJn3hCnTOM7v4mZcBPDoJk/MlRuaTpayRYLz4cbj+AmEH0JS/+dsE+AzDKm4p
 Ii60KpLBjbRspFKnZ7YkbnFwH/Hj7mgCosiscHYzYSclxPxkLOKYHGYX0q2mF1P7zy7V
 MRMF3rlD3OfNnm8J8ga17pJdqu5zWn5De3wNL7azvJcBADsbNbjinhN/uUfAZ66LQUG5
 g+LUPxyHWnp1J5CsYPG/hn7IZjGGaiCydyvFDp9uBV9ocGQ97dBjlqvPsj4rhWyMSVPy
 J47w==
X-Gm-Message-State: AOJu0YwSFfooUqe9VkdWQ3ns3hW7bI0sN6qOSeNoF07/Bqmb3gB0Oub1
 UIP4YjyzwW4SC+1dL6senIaTfNyblGNN8F1STjwPnA==
X-Google-Smtp-Source: AGHT+IH7buXepg+t94YgZtCZs382YtGjHWHB6xFaZXuAGfSn/7qEccdFbXQCaSkGK/XdoXtQVnJxNNtVBPvkN0hLS/A=
X-Received: by 2002:a17:902:bd87:b0:1c0:cb31:d66 with SMTP id
 q7-20020a170902bd8700b001c0cb310d66mr5833132pls.7.1693063012100; Sat, 26 Aug
 2023 08:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
 <aa9044e9-62a6-4bf2-a390-eb6d3d5d9bf0@gmx.de>
In-Reply-To: <aa9044e9-62a6-4bf2-a390-eb6d3d5d9bf0@gmx.de>
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Date: Sat, 26 Aug 2023 18:16:36 +0300
Message-ID: <CAOF=9Asr33iVjGANQTPLYurxJn+QjDXuNE09dN66bBuKc6SHFQ@mail.gmail.com>
Subject: Re: [PATCH] mach-imx: bootaux: fix building with disabled bootelf
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, 
 Stefan Agner <stefan.agner@toradex.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, Aug 26, 2023 at 4:46=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 8/26/23 15:24, Oleksandr Suvorov wrote:
> > If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building ends
> > up with a linking error [1]. Select LIB_ELF for all cases when
> > valid_elf_image() is used in the imx_bootaux module.
> >
> > [1]
> > ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
> > arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_elf_=
image'
> >
> > Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > ---
> >
> >   arch/arm/mach-imx/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index d94b5828d0d..cbe62d6b8f9 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -32,6 +32,7 @@ config IMX_RDC
> >   config IMX_BOOTAUX
> >       bool "Support boot auxiliary core"
> >       depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 || ARC=
H_IMX8M
> > +     select LIB_ELF if !ARCH_IMX8 || IMX8QXP
>
> For CONFIG_IMX8QXP=3Dy arch/arm/mach-imx/imx8/cpu.c uses valid_elf_image(=
).
>
> Shouldn't the IMX8QXP case be handled in arch/arm/mach-imx/imx8/Kconfig?
>
> config IMX8QXP
>         select LIB_ELF

We need to select LIB_ELF for this SoC only if IMX_BOOTAUX is enabled:
the arch/arm/mach-imx/imx8/cpu.c guards with #ifdef CONFIG_IMX_BOOTAUX
functions that
call lib/elf.o members.

Cheers,

Oleksandr

> Best regards
>
> Heinrich
>
> >       help
> >         bootaux [addr] to boot auxiliary core.
> >
>


--=20
Best regards,

Oleksandr Suvorov
Software Engineer
T: +380 63 8489656
E: oleksandr.suvorov@foundries.io
W: www.foundries.io
