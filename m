Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE5BD18139
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243E288CBB;
	Mon, 14 Oct 2024 19:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="SbO5Yw3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E4388D72; Mon, 14 Oct 2024 19:46:43 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F2F88A3C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 439d18dd-8a54-11ef-93fa-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 439d18dd-8a54-11ef-93fa-005056994fde;
 Mon, 14 Oct 2024 19:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=raDqxVbOffZfPRB4id/lCZrqV6GC0h4fwJ5cACvxzX8=;
 b=SbO5Yw3F7MHvnvwYfUEJuc/TOsHM1Fq9Xe0zvIiSOKNGtb9UThY4Nu1Nwe40HDkinQBiA6t0O+sRg
 ba4ExmZdEUopBSnZ+mZ60/UIfEYXBMzm4d60pQgPi22CJ8k7ilsgCHB9IyTcwhJEozRlDqj+rHgfrV
 GW8/oZvTCFaE75xF56tgQkB4Qc3CnaDLqKVILBqK97HfoI9Fh1McnKUn+5TGdIueolQrbeII3fhfKm
 LBNwANsRcDDy16fSXmi4e9erv20OlCVJUqpXW5gUZ8ddTpx2l5c/GAnpOX8It68jp9GrHjakjPoMEt
 qKDfmFpMDv08Kyd7qm1/ArS1/SFQs6g==
X-KPN-MID: 33|HnCdLn0546xYvl6pmrFCi/LW1cz3xk/GO7+oGhOVlDmWD0//Mo7uV2x5D2ftJUR
 aE3IVrSzWTzPS/GLJEapmw1auGAdVaBRKkkFSaTEoQXs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|KQcVQYehmN6UmE8QwJijNrcE7UD9b9dNOVdUFlWNMvAeaIsezH/F5FexKNrvf+l
 EZOsbfJs+5yoMMi6Z1045ww==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 445da487-8a54-11ef-9738-005056998788;
 Mon, 14 Oct 2024 19:46:40 +0200 (CEST)
Date: Mon, 14 Oct 2024 19:46:39 +0200
Message-Id: <87r08ik268.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: heinrich.schuchardt@canonical.com, vincent.stehle@arm.com,
 u-boot@lists.denx.de
In-Reply-To: <CAC_iWjJ6DPe9Fif0cbL12Fc54vhap6Z4NZ+JA0Phr_VthP=7jA@mail.gmail.com>
 (message from Ilias Apalodimas on Mon, 14 Oct 2024 20:16:04 +0300)
Subject: Re: [PATCH 1/1] efi_loader: provide variable BootOptionSupport
References: <20241011173341.24330-1-heinrich.schuchardt@canonical.com>
 <875xpyle5k.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJ6DPe9Fif0cbL12Fc54vhap6Z4NZ+JA0Phr_VthP=7jA@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Mon, 14 Oct 2024 20:16:04 +0300
> 
> Hi Mark,
> 
> On Fri, 11 Oct 2024 at 20:53, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Date: Fri, 11 Oct 2024 19:33:40 +0200
> >
> > Hi Heinrich,
> >
> > > The UEFI variable BootOptionSupport is required by the UEFI specification
> > > [1]. It reports if specific types of boot options are honored.
> > >
> > > We don't support any of these extras. So we should set the value 0.
> >
> > It also says:
> >
> >   "If the global variable is not present, then an installer or
> >    application must act as if a value of 0 was returned."
> >
> > So until we support any of those extras, we don't have to provide that
> > variable.
> >
> > > [1] 3.1.4 Boot Manager Capabilities, UEFI Specification 2.10 Errata A,
> 
> It does, but is there a problem with being explicit? Are you concerned
> about the size growth?

Somewhat, yes.  The EFI code keeps growing and I'd like to avoid
people disibling CONFIG_EFI_LOADER because u-boot no longer fits into
SPI flash or something.

Cheers,

Mark

> > >
> > > Cc: Vincent Stehlé <vincent.stehle@arm.com>
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >  lib/efi_loader/efi_setup.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > > index a610e032d2f..05d035f4eb5 100644
> > > --- a/lib/efi_loader/efi_setup.c
> > > +++ b/lib/efi_loader/efi_setup.c
> > > @@ -179,6 +179,22 @@ static efi_status_t efi_init_os_indications(void)
> > >                                   &os_indications_supported, false);
> > >  }
> > >
> > > +/**
> > > + * efi_init_boot_options_support() - indicate supported boot option types
> > > + */
> > > +static efi_status_t efi_init_boot_options_support(void)
> > > +{
> > > +     u32 boot_options_support = 0;
> > > +
> > > +     return efi_set_variable_int(u"BootOptionSupport",
> > > +                                 &efi_global_variable_guid,
> > > +                                 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > +                                 EFI_VARIABLE_RUNTIME_ACCESS |
> > > +                                 EFI_VARIABLE_READ_ONLY,
> > > +                                 sizeof(boot_options_support),
> > > +                                 &boot_options_support, false);
> > > +}
> > > +
> > >  /**
> > >   * efi_init_early() - handle initialization at early stage
> > >   *
> > > @@ -261,6 +277,13 @@ efi_status_t efi_init_obj_list(void)
> > >       if (ret != EFI_SUCCESS)
> > >               goto out;
> > >
> > > +     /* Indicate supported boot option types */
> > > +     if (IS_ENABLED(CONFIG_EFI_BOOTMGR)) {
> > > +             ret = efi_init_boot_options_support();
> > > +             if (ret != EFI_SUCCESS)
> > > +                     goto out;
> > > +     }
> > > +
> > >       /* Initialize system table */
> > >       ret = efi_initialize_system_table();
> > >       if (ret != EFI_SUCCESS)
> > > --
> > > 2.45.2
> > >
> > >
> 
