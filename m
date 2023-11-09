Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 20:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F2987525;
	Thu,  9 Nov 2023 21:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zb5XwOAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B83D8754A; Thu,  9 Nov 2023 21:16:32 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27A787522
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 21:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5be24d41bb8so35989a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699560988; x=1700165788; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7lZxSbvaOpmdpq8ycIwnkFNI4Iui5J3DbQ3+ITEJWI=;
 b=Zb5XwOAMUIEgYx+tnLOmQYakbfhFu4yycKHYT8Nrf9+61sAKC8W/OzT8+6ruvL3oVk
 go7QadDXnDGJLdIKUNfJAR91hiNExLkYTDZBwMu2fEb5zT+lDC6JPyJ9AOP70hLINJdE
 mcmfpcQ2t4bizX1QpfRNBshinZPtM96KR1OcF6kHx/UwVuMCEzIKOKojYVkiCxh+PXUN
 Zl/bshyQEdxwB1Vqbh0Vg0DJ8f0z24TY4qg8jiEYLfAhsW0sZ8UlvwLdWb9U3o47n90g
 PbxCME641beqqIVy8O0+Ve2s10sAR/2Jtgqsp13BAVBmbNaiMBBUPOw42RwSiimbjikN
 SVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699560988; x=1700165788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7lZxSbvaOpmdpq8ycIwnkFNI4Iui5J3DbQ3+ITEJWI=;
 b=Oqe6X1pGWl2HxTY1nBPi1oYksou2ylqcVR96Kankb/PGapJrfziNEzDWQWqTlUevj3
 iEkG+c1VhvNzLWZvf4BPaVVV5oNMsDoegt3duBV89428eehh34x74NuA9WZ5SjLf2r1I
 HNreOWNcH/QoRxSrWHg+dT2pOyISUFl50MoSTTOUqxales24XWlfdI2MHKOMlOiB9RQG
 Z8PvxC3Mi9vArQ94aUGKsUyWEgF7kKTkJRYlcZkBgTvlinbe0bveQTMmd8U7eop6HQxy
 6yPKl2Ww61CVUIsKcPE3dWFJ+ylQa5HpxuZrdHDNi2HSPXGQ4XI/1Z5rPV7h6b9HOInz
 9bvA==
X-Gm-Message-State: AOJu0YyZ401fqoC/EiVJQIRQQOMugkvN56SrBaCEvWHEpFaHVC7Tx99X
 mbUW39PDj2RzmayBYkgLpldwyE5lRpJzHIL3eg+efoGcC4SUJFx77AwW3A==
X-Google-Smtp-Source: AGHT+IHC25WpBpiCHRKS7uBFKd3+O5UOQCHFQ6OKJmmPVW/mUnfNIGbuv9ZtpZ8HcvNSfER95DY7VMnYojePWeN6DlU=
X-Received: by 2002:a17:90b:4b46:b0:281:cb6:a0fe with SMTP id
 mi6-20020a17090b4b4600b002810cb6a0femr426175pjb.13.1699560987860; Thu, 09 Nov
 2023 12:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20231020184253.21915-1-semen.protsenko@linaro.org>
 <20231109125345.GA6601@bill-the-cat>
In-Reply-To: <20231109125345.GA6601@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 9 Nov 2023 14:16:16 -0600
Message-ID: <CAPLW+4m0wf8Jz7jtd5NWTiT=t+0_QcxKmJwth6n9TpXgE3irBg@mail.gmail.com>
Subject: Re: [PATCH] board: samsung: Remove incorrect SYS_CONFIG_NAME in
 axy17lte Kconfig
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <promsoft@gmail.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
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

On Thu, Nov 9, 2023 at 6:53=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 20, 2023 at 01:42:53PM -0500, Sam Protsenko wrote:
>
> > The global SYS_CONFIG_NAME in axy17lte Kconfig overrides SYS_CONFIG_NAM=
E
> > for all boards specified after this line in
> > arch/arm/mach-exynos/Kconfig:
> >
> >     source "board/samsung/axy17lte/Kconfig"
> >
> > Right now it's the last 'source' line there, so the issue is not
> > reproducible. But once some board is moved or added after this line the
> > next build error will happen:
>
> Good spotting on this one.
>
> [snip]
> > diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kc=
onfig
> > index a018547ff5d4..209394a8a5a8 100644
> > --- a/board/samsung/axy17lte/Kconfig
> > +++ b/board/samsung/axy17lte/Kconfig
> > @@ -1,11 +1,3 @@
> > -config SYS_CONFIG_NAME
> > -     string "Board configuration name"
> > -     default "exynos78x0-common.h"
> > -     help
> > -       This option contains information about board configuration name=
.
> > -       Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h=
 header
> > -       will be used for board configuration.
> > -
> >  if TARGET_A5Y17LTE
> >  config SYS_BOARD
> >       default "axy17lte"
>
> But this isn't right as Minkyu points out because SYS_CONFIG_NAME isn't
> set for these platforms now. The fix is to do as
> board/freescale/lx2160a/Kconfig does for example and have
> SYS_CONFIG_NAME under each if TARGET_... stanza, even if we're repeating
> the value. It may or may not look cleaner to do:
> config SYS_CONFIG_NAME
>         default "exynos78x0-common.h" if TARGET_A5Y17LTE || \
>                 TARGET_A7Y17LTE || TARGET_A3Y17LTE
>
> In the file directly, instead.
>

Thanks for the review! I just sent v2 [1], hopefully addressing your
and Minkyu's comments. And also threw in [PATCH v2 2/2] this time,
reworking defconfigs accordingly.

[1] https://lists.denx.de/pipermail/u-boot/2023-November/536981.html

> --
> Tom
