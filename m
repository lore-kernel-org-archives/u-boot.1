Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EDAC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 15:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D62887E7;
	Wed,  8 May 2024 17:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZoCuPns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8BB887E8; Wed,  8 May 2024 17:14:34 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7238588760
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 17:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2b6456f7e94so328947a91.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715181271; x=1715786071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fFwHCNItf/E9oTI03DF4yqrQpuE55SS6vpPE4ahYIkE=;
 b=BZoCuPns55AuFht9o2HUCCYlVrp+f6bh0Z8GbiZyzR8+yjD+xyO6LW8KVN+7da5U3i
 5Xl0ZX/bXt9AoHHIx0Kn0v8YWycMVtYHDrsbFZaOg/+EkRUaA8GQ8udMVOdrmJW/ArkC
 WfBeJ6PtDk59zmY5CnrKmZ19DMSPAwKB0qwa8800VVQigiprhWwMda9lKr7UAIrhiEbb
 1WPtDy5A1AYYqACfjKkteK88bJE2VhZUjK2knkdvb4894UXrLNx3wezff1zBtwi0HrqE
 L8mFaxpPRHSlNCV0OCKnv2DRYmBXaORY8vFJIBc7HfLzHJSjWm5e+k+DK6XBFFdb6UJW
 x36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715181271; x=1715786071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFwHCNItf/E9oTI03DF4yqrQpuE55SS6vpPE4ahYIkE=;
 b=hvKq0EOyeyFDDcacK7zQk2R8atjT46OLvMQg1iMrbMrFjDZ7zOWIbtqdEZZDeAG5f2
 ya6sol7AwpzyPzjJTU0/tuEhPlrcG2dqtebs5ha3K9csrAAgygs03IKw6E/wBCRyJhsD
 YrWLe1QMNxLNNBfp+koBcVLYm4qjnZ5LvkMgQL6sTL6TqdTO3p5HqozX5BHAnq84I3It
 MFB+VnZqu6TLucAP4BEPa13J54gjTlu8SQY3F8ssns+6ViU1iKzCIj2HUGJIjQCCEdHo
 saZwVPd8aKp5C5a1/Q2f4Uvsf5ne2hBSi6U01HJC+imlohPhY2ZjTxl8+tqL3EnKqZcR
 SYiw==
X-Gm-Message-State: AOJu0YyZjMAzRlnwK3R93a2H1+ohsXqCcWHWrTz1v94ZO02mcXgCyIo2
 DEZOJNprjgvlGtKSECzrjYSpmdO2PDSXGOndsws2637qEubS4vyClihDBORVUKTFGO5g11IaHn+
 60wkT9rmY8AuTrf2vMbFy/lnkAG/fJenYNVIabQ==
X-Google-Smtp-Source: AGHT+IGnNzsrMX7VJgxfc4p4yEZEl586/HSu0fglZErWNDTr/ln09tKf85IWv+CMdi307+RwgUrwCRkZ4Kz8yLesa4A=
X-Received: by 2002:a17:90b:94f:b0:2b0:9544:59e7 with SMTP id
 98e67ed59e1d1-2b5bc2c9156mr8165150a91.23.1715181270825; Wed, 08 May 2024
 08:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-6-raymond.mao@linaro.org>
 <CAC_iWjKmX5pwrSe_e3L+V6GTVEO_122zWTfQpYntQha2aZ7T9A@mail.gmail.com>
In-Reply-To: <CAC_iWjKmX5pwrSe_e3L+V6GTVEO_122zWTfQpYntQha2aZ7T9A@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 8 May 2024 11:14:18 -0400
Message-ID: <CAEfUkUK6W5LLE0oNAJ5bjnac60i56ti-Nu3i+x=vSYko8NLd6w@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] image: remove redundant hash includes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>,
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

Hi Ilias,

On Wed, 8 May 2024 at 06:14, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 7 May 2024 at 20:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> > u-boot/sha256.h and u-boot/sha512.h
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - None.
> >
> >  boot/image-fit.c | 4 ----
> >  boot/image.c     | 2 --
> >  2 files changed, 6 deletions(-)
> >
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index 89e377563ce..1efc39f4408 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c
> > @@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
> >  #include <image.h>
> >  #include <bootstage.h>
> >  #include <u-boot/crc.h>
> > -#include <u-boot/md5.h>
> > -#include <u-boot/sha1.h>
> > -#include <u-boot/sha256.h>
> > -#include <u-boot/sha512.h>
> >
> >
> /*****************************************************************************/
> >  /* New uImage format routines */
> > diff --git a/boot/image.c b/boot/image.c
> > index 073931cd7a3..e57d6eae52d 100644
> > --- a/boot/image.c
> > +++ b/boot/image.c
> > @@ -26,8 +26,6 @@
> >  #endif
> >
> >  #include <asm/global_data.h>
> > -#include <u-boot/md5.h>
> > -#include <u-boot/sha1.h>
> >  #include <linux/errno.h>
> >  #include <asm/io.h>
> >
> > --
> > 2.25.1
> >
>
> This seems unrelated to the series of mbedTLS. Can you send a series
> with the fixes independently? Tom can pick them up before mbedTLS and
> it would make the review process easier
>
> I can send this in a new prerequisite series.

Regards,
Raymond


> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
