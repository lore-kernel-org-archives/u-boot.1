Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B5DD1F9CF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1EA8405F;
	Thu,  4 Dec 2025 12:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U1SVs3c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7ACA84062; Thu,  4 Dec 2025 12:56:15 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D6E8405A
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-786943affbaso5965267b3.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764849372; x=1765454172; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ypfTwlaNfOmcjW/1jcEbIn+CugNCOZ1Gf6JO2JrvKnM=;
 b=U1SVs3c2UyURSFhZ5lOnlEWcIAG25gtGWjiDiZX9zo8DJFEiCVUpYMvNLiLuWz5xbT
 HH29sQKJSdPhsX+2aHjHoRJDWD99rrzLDSF1Z6yG6UyB71ntkBk5GFOJl2sBJHuUmovZ
 GEF8L/B02HJuEaMDSRw13UKuagosIsoMOpAmC3ewJTQ/4I4MsrRmI7L+L+x8nNSxF9jC
 h3q1AVrnMguHOH2PV9qYGdjURgI/saLXj4CM6W+tlqLGGskMODoFBxhwPTSt8KEMeQek
 6AgN6ZJvuZhqei88TSldoVJGu9+A+9+pS0fAOioOX6y8zTpc8o2iy49er+Q5sA5vq1eQ
 sj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764849372; x=1765454172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypfTwlaNfOmcjW/1jcEbIn+CugNCOZ1Gf6JO2JrvKnM=;
 b=gFSzxs/E24kdRemo50pegLlifiCNr+fHir1MPopPbWe5c93WyIHEu41vX+elz2+nmE
 LNkksXc1JhX9PmIFB0/mwg4QvVYNajnMqX87+Mz65mUBrFOngr+Kno3hC0d+EbHO9p18
 /ymGi6bze6StPIvEZwO+3CfkbiTYh2b3Arxh95SuWMRFQhsPLg9HAzHmF3xibVCIfNrp
 +Zyyz114qHG8ebf8/z05r5oLzioOYOTvtMSQlrEc7zL2DqBVsz655HjyDRXSicpdPcny
 mgzTsonHVVkcea85qrqGR2AeIEiTuVfUT5XW2cY72pzZyNqGh99PaUaaWdZMzsVH0ewh
 ODvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqjctuQsAA3nfCcQ4lP5uSiyUcbsxSauPTbIT27Dg0AqXhXSfOlGvBCbUDaWWtvQGSJG3Wd5I=@lists.denx.de
X-Gm-Message-State: AOJu0YxgzVh3GRpQiYmvM03ox+jJ/oOpcOZqI77ToonHHRyh/EYfy4v2
 I2bscuY895s2ehAzHTHxe6dxsswb6oGFz5DL0yWtyVlZ5YlVOGyc829tHkTEz+iR4tUMk4wkEsH
 8EB3d+HrciRnwMsyC6gPfFvbqs6io9s+MNcYuI8a33A==
X-Gm-Gg: ASbGncso01W+p1UWzOKfOUkldroKgswYhD16e9QclkRhIzZlcvde/K/lMZSw86Z0EwA
 P+goHT9x12PBn38xTmYDT31J2Md/tph8Etmfit2x0TngPrWkJ/umCWXDtxiOwXoSodSJNGMzDOJ
 kj8V59H6W3PrTvt579AyISFY8ZhbhNUGucaYTGG+qaCClE8yyEsNeHkSeUOZwYv+RIfbU1Vi4b/
 Vsf0b0Xn+veYpvXNKGT/mODBTkXd8EjFesI+7y/uaXDNQO92stK5AQp+y2C4m8bw/VVpyEb6wHK
 tKEAgsdGQdtfd9K60lQOx/GZRKstwYxx8d/Ho8Bcs/1tpVRn6hDHmLcYrvOervyyZfajSe2+suy
 khZY5KRo=
X-Google-Smtp-Source: AGHT+IHZOmrnxbDQy7Ji1XvZVtmyCC6a7an4f8Yku17zYSvqZmBD5RMkiIWYtAduD+EcK0TTHMzElZNKw0uiH5GIlnk=
X-Received: by 2002:a05:690c:3601:b0:788:737:4830 with SMTP id
 00721157ae682-78c188b2a47mr18689577b3.66.1764849372137; Thu, 04 Dec 2025
 03:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
 <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
 <20251203151048.GP303283@bill-the-cat>
In-Reply-To: <20251203151048.GP303283@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Dec 2025 13:55:36 +0200
X-Gm-Features: AWmQ_bm0Uo3cNRWmFOJBYHtihNaNd8ceNp7fWUeBgALPSZA9Rls-A-EHcvbmkDI
Message-ID: <CAC_iWjLbB=2FqXr5H5UdBNxyiEANUAJOdVO8Jh0BMVVbjQvocQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for fwumdata
To: Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Patryk <pbiel7@gmail.com>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

On Wed, 3 Dec 2025 at 17:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 03, 2025 at 03:59:24PM +0100, Kory Maincent wrote:
> > On Wed, 3 Dec 2025 15:04:10 +0100
> > Patryk <pbiel7@gmail.com> wrote:
> >
> > > Hi Ilias,
> > >
> > > > > > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > > > > > (Firmware Update) metadata from Linux userspace. It provides
> > > > > > functionality similar to fw_printenv/fw_setenv but for FWU metadata.
> > > > > > Users can view metadata, change active/previous bank indices, modify
> > > > > > bank states, and set image acceptance flags. Configuration is done via
> > > > > > fwumdata.config file.
> > > > > >
> > > > > > Made a few change to mkfwumdata tool along the way.
> > > > >
> > > > > Still wondering about the choice of putting this fwumdata tool in U-Boot
> > > > > instead of TF-A. TF-A is the boot part that manages the update process and
> > > > > rollback through the FWU metadata,
> > > > > therefore, this is where it should belong.
> > > > > Why, in the first place, mkfwumdata was accepted into U-boot instead of
> > > > > TF-A?
> > > >
> > > > The actual update happens via capsule updates only, which runs in
> > > > BL33. TF-A needs to be aware in case it's involved in the boot process
> > > > and fails to boot. In that case BL2 is responsible for booting via the
> > > > other bank.
> > > > But generally speaking it's U-Boot that processes and usually updates that
> > > > file
> > >
> > > If I may add something - actually for me this is not that obvious,
> > > e.g. on our platform we update the metadata directly from Linux, not
> > > from the u-boot capsule. As far as I'm aware, the ST, in their
> > > OpenstLinux does the same. I'm also not sure why it would be the bad
> > > idea to do this from Linux. Ofc the BL2 handles bank selection as well
> > > as rollback in case of boot failure on a newly selected bank.
> >
> > I agreed with Patryk. U-boot is only an update agent (as explained by the
> > standard) of FWU metadata as Barebox or Linux could be. FWU metadata is an ARM
> > standard which is related to the update of the images that boot after the ARM
> > firmware. It is not related to any project. As TF-A is the mainstream project
> > for ARM firmware having mkfwumdata and fwumdata in it seems more suitable.
> > I am not familiar with these EFI capsule update, does it not rely on TF-A to
> > select the boot image according to the FWU metadata state?
> >
> > Anyway, now it is too late and mkfwumdata has already landed in U-boot for 2
> > years. Not sure what we should do here. Put all in U-boot and let the other
> > projects (barebox) copy the code if they need it? Or move all to TF-A while
> > keeping a deprecated copy of mkfwumdata in U-boot to not break things?
>
> Perhaps in the medium term we can split that tooling out from the main
> project source tree itself, to make it easier for OSes to use this tool
> (and other tools we have). There's nothing U-Boot specific about this,
> if I'm following the thread right.

Indeed. However U-Boot was the first project to adopt and implement
that spec. So the tool was naturally added here

Cheers
/Ilias
>
> --
> Tom
