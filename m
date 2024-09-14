Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE3CC35FE5
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 05:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4F088D8D;
	Sun, 15 Sep 2024 07:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBQT5xiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987F888C7D; Sat, 14 Sep 2024 22:15:07 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7992488B55
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 22:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6db8f7e52eeso1498867b3.3
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726344904; x=1726949704; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pdvbi869NE/IHxK1o+GZkuPOJxJEGLIhLwTGl06+xDw=;
 b=GBQT5xiFiBcR2FZ5StK8Sd25egiBrMg81iwVuPo+4d/4ol0wJHwNVeP0aOP9F4/ljf
 ncuEXqyo7NeNUWMxWMIzBZDokhGqA2o6mlXzI6ZPCMzszDPdr0s9nT8pdXDnFzdNPsOw
 dPSVfYEODtIXy3A3CIsALNVo2Ww3zeKtglT71Mnzar5r1/qd5Cn5L4Tfxwl3te4z6f4C
 QoiiufG6aKcHBjn6RbDIuDEJ0+Q/noA4dm8ViUmLjdcSt+LFK17KYrn27QV71UDonvYF
 LThvX/qEXL4VAsgBPbCsFncWqiDtVBBlUYd6MBWoUy6kU6WF4pf2Zg0rt+J5GXZRtYTx
 VP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726344904; x=1726949704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pdvbi869NE/IHxK1o+GZkuPOJxJEGLIhLwTGl06+xDw=;
 b=DZt9i9YXkWBcHMbg3A0QBJ+2bVkzN6LV507eUkjorPjbaSSbPg2mLvGIM9OeuUoYBb
 nWWksTIbSfysv106CoXGx1F6nbsKhhLqtsHHuWNDBu7mKM3qQyNj9gmNczR+s7cRFnBp
 jE4BX9QmkGoBJJjjJvE3fiJwFvgUFStdb55OE82yUyUKdR6l7x0mvD037L0pkOiLEZzm
 88MNUlauoMl9U7u/n9fOIgf/ESOMCsebfMR4C/wUhNw+IOfomNYzNZHYQ1w3th3qEm/M
 u2ZAT+KHJjyUxjaAr6MTIMWj/jljZEafex9T1QdJUR6eapymDOi+lQy8DeqOT62KD2oe
 6RMQ==
X-Gm-Message-State: AOJu0YyRkDo+NTtYcfe0EGFP0g9obP0ttsDSnmcatd0OQrE96c775Elj
 jxkI6jkSAydT8p9/MRwbWrnL6jQYj4FxrWM7ltwHdwiIxwTV32qOtCk/isfX1bzM4sTgqb+HGSF
 XuzgcYkSubjgPbHtMAM7HftozEYJu2w==
X-Google-Smtp-Source: AGHT+IH3yyVxsZdcASImo5UpwZCxSHtr4FmkMK4iM0RPyZ/HHcl0ejYkhIpgNUTd7OdUZ7yKiWRKCePRHBARcAtrqCM=
X-Received: by 2002:a05:690c:2016:b0:630:ed11:e751 with SMTP id
 00721157ae682-6dbb6b06ac3mr35936677b3.3.1726344904218; Sat, 14 Sep 2024
 13:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
In-Reply-To: <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 14 Sep 2024 22:14:28 +0200
Message-ID: <CAFXKEHZL+Stv2zWmNYTBexHUatVqi9rn5fhEe9v7VUik3-_aQw@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Sep 2024 07:28:04 +0200
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

On Fri, Sep 13, 2024 at 1:11=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/12/24 8:06 AM, Lothar Rubusch wrote:
> > Introduce device-tree files for Enclustra Intel AA1 SoMs and related
> > support.
> >
> > - Mercury AA1
> >
> > The setup depends on a selected boot mode. Various fragments for SD/MMC
> > and QSPI flash boot are provided.
> >
> > In combination, the following Enclustra carrier boards are supported:
> >
> > - ST1
> > - PE1
> > - PE3
> >
> > Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >   arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi    |  14 +
> >   arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi    |  14 +
> >   arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi    |  15 +
> >   arch/arm/dts/Makefile                         |   2 +
> >   arch/arm/dts/enclustra-aa1.dts                |  32 ++
> >   .../dts/socfpga_arria10_mercury_aa1_handoff.h | 307 +++++++++++++++++=
+
> >   .../dts/socfpga_enclustra_mercury_aa1.dtsi    | 179 ++++++++++
> >   ...cfpga_enclustra_mercury_aa1_qspi_boot.dtsi |  18 +
> >   ...fpga_enclustra_mercury_aa1_sdmmc_boot.dtsi |  18 +
> >   .../dts/socfpga_enclustra_mercury_pe1.dtsi    |   7 +
> >   .../dts/socfpga_enclustra_mercury_pe3.dtsi    |   8 +
> >   .../dts/socfpga_enclustra_mercury_st1.dtsi    |   8 +
> Is there any chance to upstream these DTs to Linux first , and then let
> them all trickle into U-Boot through dts/upstream/ ?

This is the tricky one. In principle, as it is supposed to be build on
our side this is not the case. For the kernel, we prefer to work with
DT overlays (.dtbo) where on the u-boot side we only need some basic
functionality and not everything declared. So, currently there are
differences.

Another point here for me to understand would be the following. If I
upstream some DT files to  the kernel it might take time until they go
to anything released there. So, upstreaming u-boot would wait on that
kernel release, right? In such case, I really prefer to upstream the
DT files as is to u-boot first. Then / In parallel try  to upstream
the files to the kernel. And update the u-boot DT set to point to the
kernel DT files when they are released. Could this be an approach?

Anyway, it might be that next week, I might discuss that directly in
person to get a better idea what could be a way for me with those
u-boot files. I'm coming back to this topic then. If you find some
time, please let me know what you think about it.
