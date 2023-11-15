Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC578C47072
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 03:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C187D8716E;
	Wed, 15 Nov 2023 04:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E9uQR2NX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13ACF87169; Wed, 15 Nov 2023 04:11:58 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24B087120
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso921772366b.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 19:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700017915; x=1700622715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vxBItg8CcEdVdggmOnFOiffVSzm/WEprNc5xWerf4/Y=;
 b=E9uQR2NXY+U3Zk/rmaAIt4L69AQrCfDArXxSR7Rn5ZtjNsrTeeva5GI23VQk0yAd1t
 iwDlyzA6uaapzsg44p3LtcLPtsAG/RwqvgIlqp/rGvvKwpMJNjksIIZvVu/30nxDyKey
 i6CZaNEybVvy3vVP5hbflzZBVVwO0gXWV8SGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700017915; x=1700622715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vxBItg8CcEdVdggmOnFOiffVSzm/WEprNc5xWerf4/Y=;
 b=IfR9tnU967UXQckkA1XqQevR8QpHrF6ekv+5bK3c/gDxfK/NBEUFP33/5IRfGs2KfC
 utXUz4XwdpFX7dlEn9pIhHLpEuWKi751wQlyd92IcfsVOHRMhg7DTjuFxYamj6LRRnh5
 iK2vGGQ6kbzo4EEXbAmV7oLNtnl0KgTLY2GaLR4+IEWp4xVDEaEKZ2Jvus/XEmYfNTfe
 hoTb+dOSLdJ+rF2fJSqaGUyNyxd17Xu9HhKw86Fs4T2WkUJZmkiI/r1z/Jq4CwBZYK5M
 VmrgYh/milH34ine7FMcuDy+ZYHCljUqG0xYOAdrCO+exP1liUJRX4SfpuSEngJc0ojV
 7lmw==
X-Gm-Message-State: AOJu0Yx7EmzAUlK2V6ci9c0LSJ2oWRUAC+aFS5rhMASxPnN9dVgPcjxc
 7c2b3qbKzAAkuT3JZM+KcJNfyTQOisLQjbS29Bq/3Q==
X-Google-Smtp-Source: AGHT+IE3kNBVFhgJ+2MhKaZ94iByr7T+1Dec4nuVR4GMnNX6O/stwEPt+UAyROA6rnZtatQLMq9yE60ZBz1RyaqVJaw=
X-Received: by 2002:a17:906:f6d0:b0:9e0:5dab:a0ec with SMTP id
 jo16-20020a170906f6d000b009e05daba0ecmr8193797ejb.76.1700017915006; Tue, 14
 Nov 2023 19:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20231109031448.138723-1-randolph@andestech.com>
 <CAPnjgZ2_JUdLXvUM7DdhjyqEOA4o+pSPKnSnYMQ6m3Ca=N35YA@mail.gmail.com>
 <ZVMTDF9vGNm_cRGk@atctrx>
In-Reply-To: <ZVMTDF9vGNm_cRGk@atctrx>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 20:11:37 -0700
Message-ID: <CAPnjgZ1nHW-WRawOycg6qiav+gtE10XziWjizCjzXcOKkJW7Ew@mail.gmail.com>
Subject: Re: [PATCH] riscv: binman: fix the load field format
To: Randolph Lin <randolph@andestech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, randolph.sklin@gmail.com,
 dylan@andestech.com, 
 tim609@andestech.com, Yu Chien Peter Lin <peterlin@andestech.com>
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

Hi Randolph,

On Mon, 13 Nov 2023 at 23:26, Randolph Lin <randolph@andestech.com> wrote:
>
> Hi Simon,
> Thanks a lot.
> On Fri, Nov 10, 2023 at 04:50:24AM -0700, Simon Glass wrote:
> > Hi Randolph,
> >
> > On Wed, Nov 8, 2023, 20:15 Randolph <randolph@andestech.com> wrote:
> > >
> > > The #address-cells is now equal to 2. The format of the load field for
> > > the Linux kernel doesn't match.
> > >
> > > Signed-off-by: Randolph <randolph@andestech.com>
> > > ---
> > >  arch/riscv/dts/binman.dtsi | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> > > index 6b4eb8dc7b..5117d7c8c9 100644
> > > --- a/arch/riscv/dts/binman.dtsi
> > > +++ b/arch/riscv/dts/binman.dtsi
> > > @@ -50,7 +50,8 @@
> > >                                         os = "Linux";
> > >                                         arch = "riscv";
> > >                                         compression = "none";
> > > -                                       load = <CONFIG_TEXT_BASE>;
> > > +                                       load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
> > > +                                               U64_TO_U32_L(CONFIG_TEXT_BASE)>;
> >
> I just see the #address-cells changed from 1 to 2 in commit id: 5a348ccf0257.
> In my last commit for binman.dtsi (commit id: d311df8b3169), it is based on
> the value of #address-cells being 1. That's the reason for my patch submission.
> > Does this work?
> >
> > load = /bits 64/ <CONFIG_TEXT_BASE>
> >
> Yes, it works. We use this way for the DDR memory start address above 4G
> platform. We find the example for 64bit address in the document
> tools/binman/binman.rst and use it.
> What is the method that we should continue to use in the binman.dtsi?
> 1. #address-cells = 2
> 2. append /bits/64

I believe these go together. Using (1) means you have a 2-cell value,
which is 64 bits since each cell is 32-bits.

Or perhaps I misunderstand what you are asking?


> > >
> > >                                         linux_blob: blob-ext {
> > >                                                 filename = "Image";
> > > --
> > > 2.34.1
> > >
> >

Regards,
Simon
