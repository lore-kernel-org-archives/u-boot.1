Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D5C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03EF586B59;
	Fri, 25 Aug 2023 20:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eeXkjUkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31BB86B5B; Fri, 25 Aug 2023 20:06:23 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B29F86B2D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5008faf4456so1832875e87.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986780; x=1693591580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KLo1TS6yP1mh9byiGjBCIAn/owd7nzTqirIBz2edMGc=;
 b=eeXkjUkDtC+QrIQRF38Mzha9v6Ou1MSs6Fo99wGr4jTuK0yo4UA6cUIwvC0GBSmI8/
 KacNpEky7BVuoyspGxzk+8pvYvQzrElPYv84p5vtTIlaBgp8jQ8qvi1xbBKv1gn8y2Ra
 SnCk14pQblod7UmKPQ8H1d1nKuv2ACl2OP+KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986780; x=1693591580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLo1TS6yP1mh9byiGjBCIAn/owd7nzTqirIBz2edMGc=;
 b=R6MYJRuhZpALCSZKcYB33xyrVfW+AZVPrX/1ssdNvYdtRR4ScqlEGH2fEprhIA8fFq
 WC5juDe9i9qdx+Jqo49GSzMLHemGfuMNinTRx8ZTiOEmKCUKgOmebmJkSLCEEASvxdt3
 Wsd8OGZ1qjCqv9/Olm0QPv45OzsMPkC78wUe8viW8kyiecJkAGxvEH/lJEh9Ac+77J6r
 JXW7QOLsPmiIV1LQrBuWw0TOb0Jvmbq6MH4FGzkGiGPctnDn1Z15D2iAKXEmenqaYTe+
 hx6lJ8VAJjLSUQF+iq/aBz5HdP51ZBzsH0zqZ+SxCLYDE+OP8on+Uw0yuOv9IgmLZnBb
 pdyg==
X-Gm-Message-State: AOJu0Yxot6KKQjmrzO+/ZOeq015GMx8J7waQHvL9JnUu/qwAYOD6djAA
 RaCpjnnFbW4yyCYf/4bbvd7bvmzgjHJNzFc1MHS8dA==
X-Google-Smtp-Source: AGHT+IHpWyQ4EeR7fOZjrbyohvThIvTKL0sb60EuNxjJHd4gBMdU2m0M/7hY9IPdx9oT0DsqZlYvnjMkGdteLPQpyx4=
X-Received: by 2002:a05:6512:3b97:b0:500:9d4a:89fd with SMTP id
 g23-20020a0565123b9700b005009d4a89fdmr5684114lfv.33.1692986780335; Fri, 25
 Aug 2023 11:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230824182337.1666435-1-sjg@chromium.org>
 <ZOiLOkGpI87jAZ7h@smile.fi.intel.com>
 <ZOiqBvuZ6Z1gWd4h@smile.fi.intel.com> <ZOiryc6qOuentDqF@smile.fi.intel.com>
 <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
In-Reply-To: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:08 -0600
Message-ID: <CAPnjgZ0ZwAQXrri0j1inAttmvNi2TcM9LA7hfULoMNLH8GRs-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Reland "x86: Move FACP table into separate functions""
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Andy,

On Fri, 25 Aug 2023 at 07:27, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 25, 2023 at 04:25:29PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 25, 2023 at 04:17:58PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 25, 2023 at 02:06:34PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Aug 24, 2023 at 12:23:32PM -0600, Simon Glass wrote:
> > > > > Each board has its own way of creating this table. Rather than calling the
> > > > > acpi_create_fadt() function for each one from a common acpi_write_fadt()
> > > > > function, just move the writer into the board-specific code.
> > > >
> > > > No luck, but I have a bit of time to debug more.
> > >
> > > Okay, after your patch even U-Boot can't see those tables
> > >
> > > => acpi list
> > > Name      Base   Size  Detail
> > > ----  --------  -----  ------
> > > RSDP  000e4500     24  v02 U-BOOT
> > > RSDT  000e4530     34  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > > XSDT  000e45e0     44  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > > CSRT  000e5490     58  v00 U-BOOT U-BOOTBL 20231001 INTL 0
> > > MCFG  000e5610     3c  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > > SPCR  000e5650     50  v02 U-BOOT U-BOOTBL 20231001 INTL 0
> > > APIC  000e56a0     48  v02 U-BOOT U-BOOTBL 20231001 INTL 0
> > >
> > > Because the base is badly corrupted:
> > >
> > > -00000030: 52 53 44 54 38 00 00 00 01 95 55 2d 42 4f 4f 54  RSDT8.....U-BOOT
> > > +00000030: 52 53 44 54 34 00 00 00 01 eb 55 2d 42 4f 4f 54  RSDT4.....U-BOOT
> >
> > Length -4 bytes, another checksum as a result.
> >
> > > -00000050: 00 00 00 00 90 54 0e 00 f0 54 0e 00 10 56 0e 00  .....T...T...V..
> > > +00000050: 00 00 00 00 90 54 0e 00 10 56 0e 00 50 56 0e 00  .....T...V..PV..
> >
> > Missing pointer to 0x0e54f0 which is... FADT!
> >
> > > -00000060: 50 56 0e 00 a0 56 0e 00 00 00 00 00 00 00 00 00  PV...V..........
> > > +00000060: a0 56 0e 00 00 00 00 00 00 00 00 00 00 00 00 00  .V..............
> > >
> > > -000000e0: 58 53 44 54 4c 00 00 00 01 7b 55 2d 42 4f 4f 54  XSDTL....{U-BOOT
> > > +000000e0: 58 53 44 54 44 00 00 00 01 d5 55 2d 42 4f 4f 54  XSDTD.....U-BOOT
> >
> > Wrong length, another checksum.
> >
> > > -00000100: 00 00 00 00 90 54 0e 00 00 00 00 00 f0 54 0e 00  .....T.......T..
> > > +00000100: 00 00 00 00 90 54 0e 00 00 00 00 00 10 56 0e 00  .....T.......V..
> > >
> > > -00000110: 00 00 00 00 10 56 0e 00 00 00 00 00 50 56 0e 00  .....V......PV..
> > > +00000110: 00 00 00 00 50 56 0e 00 00 00 00 00 a0 56 0e 00  ....PV.......V..
> > >
> > > -00000120: 00 00 00 00 a0 56 0e 00 00 00 00 00 00 00 00 00  .....V..........
> > > +00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >
> > Same reason. So, your code forgot to link FADT to the main tables.
>
> By code analysis you simply missed
>
> +       acpi_add_table(ctx, fadt);
>
> I'm going to check this right now... Stay tuned!

Thanks for digging into this, I really appreciate it!


- Simon
