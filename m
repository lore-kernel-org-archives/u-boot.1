Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083ECE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F9F83F5D;
	Tue,  6 Jan 2026 17:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EClT4+Pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2075283F5D; Tue,  6 Jan 2026 17:22:18 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3D283F01
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b727f452fffso461210866b.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716535; x=1768321335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cl/2IFDbLGv0JLuT2zseePANmammFP9aJchY6gcfJqc=;
 b=EClT4+PdGj03F27BieNvE1Nq+wS3iHscmRFdjY1aWrjg91GkCCVM+nAr/pRi88n8Ic
 Wkf48ZWVoorbEWW/1DWyk7iH0sdjxv/pujDpGVGRK1IWTDK0AgxR/DxZG042pE6vWAFt
 gEmbszDp63kQRTeukz7ux93/zMN/m9P6Vj0KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716535; x=1768321335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl/2IFDbLGv0JLuT2zseePANmammFP9aJchY6gcfJqc=;
 b=QBc+f8Ts7PXGTXjO6lCqhNJZH/e7768BYqu6WU+aEWK0a2Low9zQa1KLNnumd1KasV
 HuAfJ/4BAh/X0de8ZGaCNuUECta61BEzdn0DNeStIKtSjQTtp560cA7U0zmPdvBE5tYm
 /l8+06m9mnrKLmRT6KDV1SUXs4V1aZPi9I4JPLMOoXxDXSdKgtW0np7No9I63nrMYgGa
 TcYb9Xvx+3pbT0mPfJM7d2phsA7f2eyBRAuieSQ3yyqmssmA3Ksh5txDev8xeK7e9eK4
 yBfnyXBE7C9v/rK1TyhreZmVik8eH1AN5vVg79FPfPKMLO/gkUubUOf7e4Kw/wpVmRmb
 nmpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWhYJppnAkLarjWI/GAdGD4TiAoonvMvIYldr6A+O1Mhr8SKuJQ5oe6EyWM9wyNxOW2KKjgRk=@lists.denx.de
X-Gm-Message-State: AOJu0YwWQsx/cle86zuMPEyGNeIJ8oxqu08IPv7fNtHXE6yyv7ThoTvn
 XDVQUlN7DCn5Rab8WkwTO7jSEpTce6mhFK9eTU9tthVdmQQZKV3k07KpsltzmZYjOotdgCq4HF8
 RipZlMTe0jekPkF0vfa+TgHrrGscZySJTHN3BV8x9JSOURvDeH5w=
X-Gm-Gg: AY/fxX4rD1wtHXDklb5iYLxYTP77VIOnpyEi1/Bqdp/JousWYvsJ9Th2s0ySeA1x2M/
 JZvlddSTY+puDxSqglVN8bl7K2xhodM60PQJdNzlXcE+Sf7NHkV4yLX3KhuJsP7Es2g8+Nqivch
 xJNYSaqZcqgY/KFKakKiu0lmaGUs3ivvWQBXdc6jFKbpAtJwzo6EfVNea1dKSxu3mzn3UrL2tNS
 1JpHdpZsWaAhP3JJUP7xdlnWXT4NSqQOWp5ikDY3n9h6HdehIziQpUnvGyQp+drTsrdCA==
X-Google-Smtp-Source: AGHT+IGCC3f5r9B5rM/mgc8dH7Wxnz773SYuUhI6D6yxdIEJdkYMI0PTyc0x1DlMuWqRSgOBIYunyoru1UuA7w7lgtM=
X-Received: by 2002:a17:907:3d11:b0:b80:3fb7:8e68 with SMTP id
 a640c23a62f3a-b84299be630mr352293566b.21.1767716534763; Tue, 06 Jan 2026
 08:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
 <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
 <20260105234725.GA3416603@bill-the-cat>
In-Reply-To: <20260105234725.GA3416603@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:01 -0700
X-Gm-Features: AQt7F2rLhQromG1LXXdZHKoMoceFmspC2umL6t4LQjhCp6fv9UVeS04dzCwZKvs
Message-ID: <CAFLszTjW=wwSh-+MowTCaNLJQ_O6HninAJXrd_MQuuUEKd5Zyg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
To: Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 5 Jan 2026 at 16:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 05, 2026 at 04:30:26PM -0700, Simon Glass wrote:
> > Hi Kuan-Wei,
> >
> > On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > >
> > > Currently, the Goldfish RTC driver exclusively relies on device tree
> > > to retrieve the base address, failing immediately if dev_read_addr()
> > > returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> > > being used on platforms that instantiate devices via U_BOOT_DRVINFO()
> > > instead of device tree, such as the QEMU m68k virt machine.
> > >
> > > Add support for platform data to address this limitation. Update the
> > > probe function to fall back to retrieving the base address from
> > > struct goldfish_rtc_plat if the device tree address is unavailable.
> > > Introduce a new header file include/goldfish_rtc.h to define the
> > > platform data structure.
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > Changes in v5:
> > > - Rebase on u-boot/next branch.
> > >
> > >  drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
> > >  include/goldfish_rtc.h     | 15 +++++++++++++++
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > >  create mode 100644 include/goldfish_rtc.h
> > >
> >
> > You can package your own devicetree in the U-Boot source, to handle
> > what you need.
>
> That's not helpful feedback here, the correct path is to use the machine
> as QEMU provides it and not start yet another pointless argument with
> QEMU. And this probably applies to some of your other feedback as well,
> thanks.

From what I understand, QEMU does not use DT for m68k. If it did, then
we would not be using platdata. Am I missing something here?

Regards,
Simon

PS: The QEMU thing was certainly not pointless, even if the 'argument'
resolved nothing. We still have this work-around in the docs, 4 years
and counting:

https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html#merging-in-u-boot-nodes-properties
