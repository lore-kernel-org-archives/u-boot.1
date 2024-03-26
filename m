Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE64EC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4283487ABC;
	Tue, 26 Mar 2024 16:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="rPyLCEMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B860B87FAC; Tue, 26 Mar 2024 16:38:25 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDFD8751B
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 16:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-609f3ca61e0so61227217b3.3
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711467502; x=1712072302;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NV+e7uR81s5dxC4L5vO3Rgm18M/fOfbxHWHfhfPFEGs=;
 b=rPyLCEMfaP7pUpezleb4ICsDDnkN7NWRud/F1ODvJjaz+n2mS8NWrlryQaVuXEKIuM
 qsS7Y8W3/TDEmgX6+bSGxL0bRzhFA8y96qu6AvldfbZJFQt2AAdIFNqdc7Z6C96S1/2v
 IjQvC1RsUPuBeXldXITXhzSLysVtU5N9Q92o0/TBO6kEQ2bZcRUxf0yRT9GxlXCr0jBf
 sDq3yJzHF9+JBl1KKiFELZly4WxDbhipos+2lkAIa05/XYZElochl1A1FLBR4kpHKpHB
 7IgrHUy9SozQdJFv9z4I75QvaGEx5DIGb3tCoYw1WHavQDWra8Ph0izrK2v819T/INw0
 4pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467502; x=1712072302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NV+e7uR81s5dxC4L5vO3Rgm18M/fOfbxHWHfhfPFEGs=;
 b=MzfPxifl8H0ZaEQKZ7bzLaV5gOgKTVyCr2xV2+BjWPSQEJ/dUxC6AEI3+7OZDaH1bA
 9gH3kJtBv5V3CCquTSnnUWq36NOH2zBNUrYi9B+UhtXhu6gcZmacCIig50l4tw3DGjFg
 mfEAaW2uxCxtm2IyLxylogyfoKJB/TVpSDF4Wx6LTxf/4ghLFIiTncKOTL3oriWGNLVj
 5jrPQXp3+ZMj8t2XmoTDI8H6bB9/9mYZp2pmpDSJLZFFKC7W17tlI4TlK/wgeWSqBPrP
 e90GJih/3BN8GPtpfKZGktsqZaZVO0SOUI4xYkY/ykhwTBwsTmCltIBmH8ZN1tUK0e9s
 7LVQ==
X-Gm-Message-State: AOJu0YyoPPWW8syWdyVxeM/q6vVYmx6iPGnkA18Ol25nKGvaiDZeIDMf
 sKe8rQ45j8HT9YP3ttEjGcFi4ufAzriOQ41/fwdOnifoVToATynn4xn8lfinqeCP6k661FgSWDi
 YzAIGCGJKcqOqmu0RqrzFGUfasJ+q9HWXRKiO
X-Google-Smtp-Source: AGHT+IEz7NJd68f3ednhfngDFtgh1xiprkDG7JYrpgeLCZcbwaSlwKJj2VVydEYeC9TTKG4GiFDwWl8z0JC/m2+tlgw=
X-Received: by 2002:a81:85c5:0:b0:610:b933:33a1 with SMTP id
 v188-20020a8185c5000000b00610b93333a1mr8287153ywf.52.1711467502042; Tue, 26
 Mar 2024 08:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
In-Reply-To: <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Tue, 26 Mar 2024 11:36:11 -0400
Message-ID: <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
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

I'd be happy with that change. Does anyone have access to the
associated designware databook (I do not)? We could also check to see
if those four bits are all always allocated to the 2/3/4/x version
number. I can submit v2 with that change instead once we know.

On Tue, Mar 26, 2024 at 7:50=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 3/26/24 3:32 AM, Greg Malysa wrote:
> > From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> >
> > This adds the Synopsys device id for version 4xx of the designware
> > IP block and extends the version check to include it to permit
> > new hardware to run. It does not add any 4xx-specific features.
> >
> > Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> > Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> >
> > ---
> >
> >
> > ---
> >   drivers/usb/host/dwc2.c | 3 ++-
> >   drivers/usb/host/dwc2.h | 1 +
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> > index 637eb2dd06..6fdde6a9a7 100644
> > --- a/drivers/usb/host/dwc2.c
> > +++ b/drivers/usb/host/dwc2.c
> > @@ -1180,7 +1180,8 @@ static int dwc2_init_common(struct udevice *dev, =
struct dwc2_priv *priv)
> >                snpsid >> 12 & 0xf, snpsid & 0xfff);
> >
> >       if ((snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
2xx &&
> > -         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
3xx) {
> > +         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
3xx &&
> > +         (snpsid & DWC2_SNPSID_DEVID_MASK) !=3D DWC2_SNPSID_DEVID_VER_=
4xx) {
> >               dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x=
\n",
> >                        snpsid);
> >               return -ENODEV;
> > diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
> > index 6f022e33a1..f202d55eb2 100644
> > --- a/drivers/usb/host/dwc2.h
> > +++ b/drivers/usb/host/dwc2.h
> > @@ -739,6 +739,7 @@ struct dwc2_core_regs {
> >   #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET                      7
> >   #define DWC2_SNPSID_DEVID_VER_2xx                   (0x4f542 << 12)
> >   #define DWC2_SNPSID_DEVID_VER_3xx                   (0x4f543 << 12)
> > +#define DWC2_SNPSID_DEVID_VER_4xx                    (0x4f544 << 12)
> >   #define DWC2_SNPSID_DEVID_MASK                              (0xfffff =
<< 12)
> >   #define DWC2_SNPSID_DEVID_OFFSET                    12
>
> Maybe it would be better/easier/futureproof to simply check if (snpsid &
> 0xffff0 =3D=3D 0x4f540) ?



--=20
Greg Malysa
Timesys Corporation
