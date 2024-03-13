Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373EAC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A6087E7F;
	Wed, 13 Mar 2024 07:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RZhWv16j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AA287653; Wed, 13 Mar 2024 07:45:24 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B1687E91
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-472d1912f80so1614787137.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710312318; x=1710917118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KPeSW+6V7uOiaYGQlJf/b3FqOJnm+oy1/p6cDsUoEMA=;
 b=RZhWv16ju8Z9NmVHolovtR3JkaFkd73FPr8wMwtThrzcBn81JppozYJjtvm3bMRXwG
 5+5JAg3Oa8gXat/JDaL2LO6xTtnKl8mP4q2RZ6k20azPmKeBMfeIPL4Ky3sNKwVB3Efc
 mxO9T7ZprAHsZcenXOfCAqOljLTFkMOs4QLvTbtn0o/9UFCRQFnAUdsPK/wslwZL05gp
 hxCyj19ISHYZNOiUG5o7NVNfau6WRzHIFjLPvKE+tDx5ePxpyIJgRu/+l/K1uommiXvj
 ZMEq3uzgwe2Fsj7xLEaaESgGs7T4naI9osackRhugqI0Qi9BBcfRWMsEwzg4W8YwdHC2
 G03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312318; x=1710917118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPeSW+6V7uOiaYGQlJf/b3FqOJnm+oy1/p6cDsUoEMA=;
 b=FuXPZDoSqdAFcBMEfSYVSKiEFkjXiBdOZnywmgoL12LWHst3CU8zXGTwGnAj3vxDtT
 a/6EqP6SKm+M2cxGkqX2CDKnvFsdpuCanVD3BiFZkyPzltp4uiaL3LI3Z20ztDNB7tkv
 b74fMv57i8f8LXAVWg1+Gzi5LX+0xAXakY0X+tmXxIwjNFiDH8j9UQkyTdKkKeCrq9UW
 CXGe7BfWqqM0fhjNn84yTwzekvZW0ebx6luuU7ZBIkVQdLWBEtN/kKbqemdi099LQLDf
 E35SmCobYlZjnyqQBSyW17o8IOsngwXFSvsOFVG1+w9t0THXacH9EHbbnI5r+P4tC3pv
 rBkg==
X-Gm-Message-State: AOJu0YwPiV1FOByEEwwbxDCAwxvwU1gbn04y1p4nalNKYP5DiUS59BOT
 IdNt7d6mzdadbgI0JKS5tsOpJAZA4YNNH736Y8me5jM+YovNfKg4nVTUnbWzuVhADXI1ZR7f83i
 RrICyB+0I7dZ9S2qu/GMZDfAPAtWySfPn3DBjGw==
X-Google-Smtp-Source: AGHT+IFejaCxTTDJ5U3eKpJfBSHSUPMvgRGK4dFYlXkapSu5CHCQ4TGbvx+8BxEEvAQMabqGLE3YLvPb8wR4k+FT+j8=
X-Received: by 2002:a67:ce8b:0:b0:474:cf76:ec14 with SMTP id
 c11-20020a67ce8b000000b00474cf76ec14mr853239vse.15.1710312318420; Tue, 12 Mar
 2024 23:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <CALeDE9MkbeTOBgArDH-+VxdO7D2iAAb1Mh+gCb6tnm2vg6LOFw@mail.gmail.com>
 <CAFA6WYMmbL52TF-2_JCb-uhbM87Ytdq1nTnr50Z9Ojg9O49+iQ@mail.gmail.com>
 <CALeDE9OmQj0L0HkYUsNVBpDjP6dTyKWRdtT+hqRSojbD0mGJrw@mail.gmail.com>
In-Reply-To: <CALeDE9OmQj0L0HkYUsNVBpDjP6dTyKWRdtT+hqRSojbD0mGJrw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Mar 2024 12:15:07 +0530
Message-ID: <CAFA6WYN5iJ=g0EORtgMnge0FmgYHRWC-r2nfEeuZiqsu6AVfYg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] imx8mp: Enable PCIe/NVMe support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Tue, 12 Mar 2024 at 15:30, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 12 Mar 2024 at 09:55, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Peter,
> >
> > On Tue, 12 Mar 2024 at 15:13, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > > pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
> > > > rather tied to quite old port of pcie_designware driver from Linux which
> > > > suffices only iMX6 specific needs.
> > > >
> > > > But currently we have the common DWC specific bits which alligns pretty
> > > > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > > > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > > > add support for other iMX8 variants to this driver.
> > >
> > > The upstream Linux driver is moving towards a single driver [1] for
> > > imx6 -> imx9, would it be possible to add support for all generations
> > > to this driver and then remove the old driver?
> >
> > Sorry but that's not in scope of this patch-set and neither do I
> > possess boards with all the imx* SoC variants.
> >
> > > That would allow this
> > > single modern driver and removing the old imx6 specific driver.
> >
> > Folks interested in this can build up on this patch-set and port other
> > imx* variants and then we could have a single modern driver.
>
> That's fine but I think you  should document that this can be future
> because the case is that these devices are clearly related.
>

Sure, I suppose it deserves a header comment for the legacy pcie_imx.c
driver. If I don't see any other comments for this series then I can
make that as a follow-up patch. Otherwise I will fold it into this
series.

-Sumit
