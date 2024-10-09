Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BCBCF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D59F88DBF;
	Wed,  9 Oct 2024 03:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S1CAIuIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8B988FCE; Wed,  9 Oct 2024 03:57:25 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0598482BA7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so44522506d6.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439042; x=1729043842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QrToeNnLWhFCXBrJowlGUS3xYHP8LEVTARehmFhUZ4M=;
 b=S1CAIuIEyDZJoW7mJst5x4OOimnnNmi7i9IeauOhrZXNuio9tnc0qou3EqYW3EYK1p
 o0+pfqLJOLljB3vei2STKN4IFeWnKpmFyf1AL5BP7LYAbivnxcVlH0yUbxPFum6DNSZ2
 8TNH8s58rV04pUn6gmNQWKZ9FZpzqH+Wml6To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439042; x=1729043842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrToeNnLWhFCXBrJowlGUS3xYHP8LEVTARehmFhUZ4M=;
 b=MKyGtCXVkhIQkuRCA6TU5U0e8U11tG2k696+1jWDJJzs6J2BsSZLqBrmC45y3w6WQr
 vWzp060Lla9GO6utprb6Y9l5nuFB4VtpWvckfpxaEBipg422q7Oz0jgdFuwtHrv+54OB
 kcvrhWOZf0NXfhjNHVMcqfdEKG53IEX1WnWSqhfoNTny9P8taYn9FxRjS+2jJ8EIlUKF
 VVr/QTzfTIYMGLie2ibcFQ3UhAq3AmIaywVaZveFwVVJF9sRHx767+rpQYNA+htWw1IP
 xSrHf2o+ZN+cAHXf+qX3xTbImF3DL3IVlqRxzHYatMIq333TeYSYQBJe7ve/95Y7SpTz
 thQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCGixHNnmWVG/dWQzJEhAwnOYVa2xR25Uy8ewxxMRC8r2a3fWc0kUaD/QQaIERZlBqMnlSPKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzywW9CM3X9irRrtZxmVHzaT+BC1F/TBYNYf+l146FOVC4e888R
 g/q/OJgBvn33zHnv3ydldNpFzSpA9etgC4O/DILkYACP/Lbj7gFKPdSQk0La0F2+Nl29j/ZCEkm
 ivCOPk2IGY6XTEUsbrakOXr8nvUQfStBnt11i
X-Google-Smtp-Source: AGHT+IFxmwduG9fUnrkNd1X4nGAgCXedTXlCGuOpGBBqnlMYtQJq18wkHkuzgZHE6VobpEvW4eh845LT6ko0F8TtWpM=
X-Received: by 2002:a05:6214:5404:b0:6cb:83a5:8403 with SMTP id
 6a1803df08f44-6cbc95d8082mr15947626d6.50.1728439041966; Tue, 08 Oct 2024
 18:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
 <20241007170551.GB4737@bill-the-cat>
 <PAXPR04MB8459A692CF21AA616DCDA7BA887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459A692CF21AA616DCDA7BA887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:11 -0600
Message-ID: <CAFLszTiAU2QR2nkuk+tX3XTCy1YU8V0V1tP2i8OHODs_HXx0BQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm: global_data: add scmi pointer
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "judge.packham@gmail.com" <judge.packham@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 Ye Li <ye.li@nxp.com>, 
 "festevam@gmail.com" <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
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

Hi Peng,

On Mon, 7 Oct 2024 at 20:59, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v1] arm: global_data: add scmi pointer
> >
> > On Sun, Oct 06, 2024 at 05:52:28PM +0800, alice.guo@oss.nxp.com
> > wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add scmi device and channel pointer for i.MX9.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > ---
> > >  arch/arm/include/asm/global_data.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm/include/asm/global_data.h
> > > b/arch/arm/include/asm/global_data.h
> > > index 45401d5e3c..d04359f167 100644
> > > --- a/arch/arm/include/asm/global_data.h
> > > +++ b/arch/arm/include/asm/global_data.h
> > > @@ -108,6 +108,9 @@ struct arch_global_data {  #ifdef
> > CONFIG_SMBIOS
> > >     ulong smbios_start;             /* Start address of SMBIOS
> > table */
> > >  #endif
> > > +#if defined(CONFIG_SCMI_FIRMWARE) && defined(CONFIG_IMX9)
> > > +   struct udevice *scmi_dev;
> > > +#endif
> > >  };
> > >
> > >  #include <asm-generic/global_data.h>
> >
> > But why is this only needed for i.MX9 families and not other users?
>
> i.MX95 has some code that communicates with SCMI platform,
> but no scmi driver for those code, saying rom pass info. So we need
> a global scmi_dev.

Would it be OK to find the device using uclass_first_device(UCLASS_SMCI) ?

i.e. can we do without a pointer in global_data ?

If we do need it, I think it is better to have the condition just be
SCMI_FIRMWARE (and live with the extra 8 bytes in global_data). We
really should not have SoC-specific options in global_data, or even
drivers for that matter.

Regards,
Simon
e
