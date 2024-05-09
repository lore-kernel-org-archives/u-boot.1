Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94975C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E131888096;
	Thu,  9 May 2024 17:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GrM9wmoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E353D88096; Thu,  9 May 2024 17:04:25 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC8888076
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso765529a91.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715267062; x=1715871862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NvuV70qfnaN/LhCSjurve2Pv4KeikAz0UbV2Fg7UcMA=;
 b=GrM9wmoHkRcJARPEM2UQhpPhQCpZfvybIZcOouXZu9eZOfMeRB2/h5xnI2KdDRDjGm
 OB9XE/WQrZ4e1uTxYgdz/40ya2xLFYLMhLuxmbvP3fqHZ2joFCKy6DkanC3CPWvkn0q4
 vx3VOuv0k2xSuvUVKi/qEZcqJi+19ioMGItDYzID7FZa+zRoONLxF6UNPS0ZxKnUWGtH
 xA3UeoyHnjlLAoaifp+Jqz7a8xnP6yV9GsPxq8rpNLTmgTzougKQRMD9nnh951Hmp7Wq
 R0kepzginz7SfeadRnV+S/vWzY4t3uAudTufA5R/DVp8VSuFtiqXfsFSG733IBVHVO/t
 OOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715267062; x=1715871862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NvuV70qfnaN/LhCSjurve2Pv4KeikAz0UbV2Fg7UcMA=;
 b=N1HG2qwmDDe41CSO05wLy2QikQka0Vac+f4JbVIJdLlLxKiEBgT6QDpV/2HMBaH1Z3
 C/dNP5OmB0x01AgySVbBo6wVvqknIQDKHxO+30fGlclwkjX9ZBKvJWvLWkITOm6yt/A0
 pY+5XucK4+eHq27GPuG7Ns+Fx/6z+KsueRQvmCMs1yQNo3GSvbAbMxYUlVUYVpGdTkrP
 /pNkL/TFuFdytv+XSyN8M+NxcCAl/N/TrLp/idSbgmTLMes2GNbG8OA6xJkChijK6qTy
 TU702hIJuBBfL/9/4dVlF9NgUf7Y0dVQrXPX0GDJPuF2kKwXj1J/Kc1tjOlkRb8ZkupA
 rr+Q==
X-Gm-Message-State: AOJu0YxH+6t4nOa7HIWro3i+liElGsgTcRDiVyHdZqCM8fJjkIdoPM/C
 MLI1YJ5EQpxsdIkeQUFEbFdpB75O/c2qmvEiUmy8nf92dW12Z4b+TxOf1qL/3+pwqvjx+B3zCwm
 0Us/K0fEey0SuV9gAQZUxgmGy8Ejn1k+SoAVjiA==
X-Google-Smtp-Source: AGHT+IGU0EgOe7axCerlNdHl1S/eaGEd/ZxHUbzwqpqjM+1vE49IWAjtVwm+Siqdur3xbjeQHK4JStuLaoqEfxrwsTo=
X-Received: by 2002:a17:90a:bf0b:b0:2b2:b4e8:ccce with SMTP id
 98e67ed59e1d1-2b6165a66a2mr6174388a91.13.1715267062040; Thu, 09 May 2024
 08:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
In-Reply-To: <20240507211643.GY2568172@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 9 May 2024 11:04:07 -0400
Message-ID: <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com> wrote:

> On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
>
> > Port mbedtls with dummy libc header files.
> > Add mbedtls default config header file.
> > Optimize mbedtls default config by disabling unused features to
> > reduce the target size.
> > Add mbedtls kbuild makefile.
> > Add Kconfig and mbedtls config submenu.
> [snip]
> > diff --git a/include/stdio.h b/include/stdio.h
> > index 3241e2d493f..874279c60dd 100644
> > --- a/include/stdio.h
> > +++ b/include/stdio.h
> > @@ -3,6 +3,7 @@
> >
> >  #include <stdarg.h>
> >  #include <linux/compiler.h>
> > +#include <vsprintf.h>
> >
> >  /* stdin */
> >  int getchar(void);
>
> Is this really needed? I know our include structure is a bit odd. Should
> we perhaps look at moving a prototype or two around to be more broadly
> compatible?
>
> Then we need to move  prototypes of snprintf, _vprintf, putc_outstr and
printf_info from tiny-printf to stdio.h. Is this good for you?

Regards,
Raymond
