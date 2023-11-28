Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF1C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 03:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE28875C8;
	Tue, 28 Nov 2023 04:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdBSAriu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5F2875DF; Tue, 28 Nov 2023 04:02:47 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC0A8757B
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 04:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b861a3be3eso1616259b6e.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701140563; x=1701745363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YcRGcpWWlh7KAGPPgpDwbxBrWCzqzE1r9SmN0VqSy0A=;
 b=SdBSAriuGw9HdP6vAs2NlbGG3bxONSWP1zG7re3sKjBRMI2+20bAQzMuLNdRRBVLeW
 1Dncii+chg0FGF17XzVSM9LXZj60PbqI14nedlmIrEAuuT66bMpcqsxfsYvsSAJ0Sn72
 KAFzwzWYLOCbH0piW8Drp01KQyJJuOs+HsQlQGAJoFlzCIrq/MiyCKI1rEalsy/JO3fn
 Ov9JzX+ZwkLL3FmeyzNiZdrhwn+lxAlON9QuILdwJ6DsgjXDvUm67pgyvlJPH1qY7PjC
 gIQRj/yWKlVNlW6x++DDl1rS2lbxnioxLnhYX7tLGkMMjKgH0A2hBM7NzA7gGez9bRyT
 /ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701140563; x=1701745363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcRGcpWWlh7KAGPPgpDwbxBrWCzqzE1r9SmN0VqSy0A=;
 b=XS+Np097wdWdrgGMI4TtiqNCJU+6AhoWU2bz2KeuXi6aypy9gab/SonG7G3NM1UWfA
 qiHq9UCjtpKcLgoc7h/YPr8eGkr0l+3uey+fFHVdXNxLbEOq8EadtUliK6s+2GkFdfN7
 eJXcvgzLWguVAOl8LU4trqET7ecrMnHr08HLijEj4g2EOURL0ba5DPe0eDIU3nRA4Fpn
 ETwWuaOqtXDoP5fb0SvGhzzHGqyejoWdM+btS3I/Mp+1TPfPK/y2ByDPvQHoq7APtxOW
 JgT23w5zfTbi4eBSw2NRgu0RXFL1BQQEsefvOixl0F8gn03FCZMuIdxnJR9/41va0dv8
 gLEw==
X-Gm-Message-State: AOJu0YzYzfe+jDoyBx0DLVBGDJWwbokK0kkHwRA2+ZBsbOlJ1CkNR+EJ
 c2fXnx47BtPYZBjLyx4gGM9/VeYMHUz+EUSUeHk=
X-Google-Smtp-Source: AGHT+IGAam36YVll5eHnJbBBFyDhhkLU+bZmxDbYlKvotfD75pFyCY42MPdPhpKfDZ9mw/Nb4gPfYHN58UlGeKboPSg=
X-Received: by 2002:a05:6808:16a2:b0:3b5:656b:f962 with SMTP id
 bb34-20020a05680816a200b003b5656bf962mr18924864oib.5.1701140562999; Mon, 27
 Nov 2023 19:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20231109201313.29791-1-semen.protsenko@linaro.org>
 <CAPLW+4kFgeUP+bvbPcLbTiakF-SmcnNj7Fu-H12Vtm_xKVbS6g@mail.gmail.com>
In-Reply-To: <CAPLW+4kFgeUP+bvbPcLbTiakF-SmcnNj7Fu-H12Vtm_xKVbS6g@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 28 Nov 2023 12:02:31 +0900
Message-ID: <CALrBrZ0Fgv-zV9dvBZ7LuOQTYE-jVch3i70AJ4oe6Q04WGEhnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: samsung: Fix SYS_CONFIG_NAME configs in
 axy17lte Kconfig
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, Tom Rini <trini@konsulko.com>,
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

Hi!


2023=EB=85=84 11=EC=9B=94 22=EC=9D=BC (=EC=88=98) 02:38, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Tom, Minkyu,
>
> On Thu, Nov 9, 2023 at 2:13=E2=80=AFPM Sam Protsenko <semen.protsenko@lin=
aro.org>
> wrote:
> >
> > There is a couple of issues related to SYS_CONFIG_NAME config in
> > axy17lte Kconfig.
> >
> > 1. The global SYS_CONFIG_NAME in axy17lte Kconfig overrides
> >    SYS_CONFIG_NAME for all boards specified after this line in
> >    arch/arm/mach-exynos/Kconfig:
> >
> >        source "board/samsung/axy17lte/Kconfig"
> >
> >    Right now it's the last 'source' line there, so the issue is not
> >    reproducible. But once some board is moved or added after this line
> >    the next build error will happen:
> >
> >        GEN     include/autoconf.mk.dep
> >      In file included from ./include/common.h:16:
> >      include/config.h:3:10: fatal error: configs/exynos78x0-common.h.h:
> >                             No such file or directory
> >          3 | #include <configs/exynos78x0-common.h.h>
> >            |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      compilation terminated.
> >
> >    That's happening because axy17lte Kconfig defines SYS_CONFIG_NAME
> >    option in global namespace (not guarded with any "if TARGET_..."), s=
o
> >    it basically rewrites the correct SYS_CONFIG_NAME defined in the
> >    hypothetical boards which might appear after axy17lte in mach-exynos
> >    Kconfig.
> >
> > 2. Another side of the issue is that SYS_CONFIG_NAME is defined
> >    incorrectly in axy17lte Kconfig:
> >
> >        config SYS_CONFIG_NAME
> >            default "exynos78x0-common.h"
> >
> >    The .h extension should not have been specified there. It's leading
> >    to a build error, as the generated include file has a double '.h'
> >    extension.
> >
> > 3. Each target in axy17lte/Kconfig defines its own SYS_CONFIG_NAME. But
> >    all of those in fact incorrect, as corresponding
> >    include/configs/<CONFIG_SYS_CONFIG_NAME>.h header files don't exist.
> >
> > 4. The global SYS_CONFIG_NAME pretty much repeats the help description
> >    from arch/Kconfig and doc/README.kconfig.
> >
> > Corresponding defconfig files (a*y17lte_defconfig) fix above issues by
> > overriding SYS_CONFIG_NAME and correctly setting it to
> > "exynos78x0-common".
> >
> > Fix all mentioned issues by removing the incorrect global
> > SYS_CONFIG_NAME and instead specifying it (correctly) in SYS_CONFIG_NAM=
E
> > options for each target instead.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Fixes: 3e2095e960b4 ("board: samsung: add support for Galaxy A series o=
f
> 2017 (a5y17lte)")
> > ---
>
> If this series (v2) looks good to you, can you please apply it? It's
> needed for the new Exynos dev board port I'm working on right now, and
> expect to submit the patches soon.
>
> Thanks!
>
> > Changes in v2:
> >   - Don't just remove global SYS_CONFIG_NAME, also fix SYS_CONFIG_NAME
> >     for each target in Kconfig
> >
> >  board/samsung/axy17lte/Kconfig | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/board/samsung/axy17lte/Kconfig
> b/board/samsung/axy17lte/Kconfig
> > index a018547ff5d4..64a4ffa7e673 100644
> > --- a/board/samsung/axy17lte/Kconfig
> > +++ b/board/samsung/axy17lte/Kconfig
> > @@ -1,11 +1,3 @@
> > -config SYS_CONFIG_NAME
> > -       string "Board configuration name"
> > -       default "exynos78x0-common.h"
> > -       help
> > -         This option contains information about board configuration
> name.
> > -         Based on this option
> include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
> > -         will be used for board configuration.
> > -
> >  if TARGET_A5Y17LTE
> >  config SYS_BOARD
> >         default "axy17lte"
> > @@ -16,7 +8,7 @@ config SYS_VENDOR
> >         default "samsung"
> >
> >  config SYS_CONFIG_NAME
> > -       default "a5y17lte"
> > +       default "exynos78x0-common"
> >
> >  config EXYNOS7880
> >      bool "Exynos 7880 SOC support"
> > @@ -33,7 +25,7 @@ config SYS_VENDOR
> >         default "samsung"
> >
> >  config SYS_CONFIG_NAME
> > -       default "a5y17lte"
> > +       default "exynos78x0-common"
> >
> >  config EXYNOS7880
> >      bool "Exynos 7880 SOC support"
> > @@ -50,7 +42,7 @@ config SYS_VENDOR
> >         default "samsung"
> >
> >  config SYS_CONFIG_NAME
> > -       default "a3y17lte"
> > +       default "exynos78x0-common"
> >
> >  config EXYNOS7870
> >      bool "Exynos 7870 SOC support"
> > --
> > 2.39.2
> >


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
