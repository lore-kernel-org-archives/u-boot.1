Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D1FCEBF8F
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04A2890C4;
	Fri, 27 Sep 2024 12:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="etYJlsw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FA2890C5; Fri, 27 Sep 2024 12:43:42 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144D088FAF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb3062d9a6so13434216d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727433819; x=1728038619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=llP0v2JYYx/1eSaxlZ2AUNY0CHybS3kF3rewLoCfkGI=;
 b=etYJlsw1EhYY6xzhjF9ihLoPCOMI16XcawZoPszf2SZO1wGkuY4NgifK8K9BCjgFHC
 cMpSEx03/ray7Teg2cruiJZdBNEFpSxRN16Oh0bnM/JXyj5cN8+A1nPIEkvjhHIz3JSA
 rZZ879dS1BMA7RhmoijWnSDShIjkEPGtKa88A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727433819; x=1728038619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llP0v2JYYx/1eSaxlZ2AUNY0CHybS3kF3rewLoCfkGI=;
 b=dvs++wqm80Vlqd4j0snPEDy1XnEabBlrYrKmk1CJ9UiW02DwimfJQFRkUVrJKu2Tjy
 E+x0+cNv35X3WyZiF0Zdu0oWqcAW4ZIyohszFgfsxQQ6X25W6ltZCAy1DmS1J1NQihtl
 tFKZwBG4Hp30eFOABxME30Pf2r0h5D5h1uSC63iSi3TAOPq2mOsPUQz6tXkI7fdVCZr5
 fDz0IjJ46NdFQszESz/3l1UVFwu87fcAB8v6NhwKUHMrYPFiUVGG1qAeoxjgx8yfLyyt
 sP+tI8LctKo7SW+CaLit6tJ7r+ZtPn10c9DQHaVGw4P80F8OniO/MQ0UrpJtL39mBImd
 MS+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFL1cVLx44L8IpyWrvi469x8e+t/KSsn8tTjtpZiG9Pp96Q8XicI/ryE5RQnn3s9rQizX2FMk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/4lyKrFXJLMmamXDVfZuBoh5sFJ1WFnu3YM8Twnae0xXrxxJk
 dNqfnX+8Bmhc1HFwHbPCLbt8+hcKMSfIZocTrHvj7OjFq8cXwvnAiy/PT+NmdUOViDG1P7WFN/U
 qar0vQR58CIp0rr1LHnQh7bv9CYSobusAMiaN
X-Google-Smtp-Source: AGHT+IGXl/xKUk9eEQTPtPF9FCc2KfHppMy2mUS+qpH05li0gBJi3YIbxo2PaPNCIc9qruoGNDH1FETTshTh9nsPgNE=
X-Received: by 2002:a05:6214:5411:b0:6cb:20b6:f39a with SMTP id
 6a1803df08f44-6cb3b5c7d52mr47429616d6.13.1727433818978; Fri, 27 Sep 2024
 03:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
 <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
 <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
 <CADg8p96c161nrDDky70k_z+Qjza5Z8ktrvdaDrn6kruMxZsrAQ@mail.gmail.com>
In-Reply-To: <CADg8p96c161nrDDky70k_z+Qjza5Z8ktrvdaDrn6kruMxZsrAQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:43:28 -0600
Message-ID: <CAFLszTjUhLc5jzGDyCxc3x0hVM8X9bt3Aw76gPt4PJi683TffQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

Hi Sughosh,

On Fri, 20 Sept 2024 at 06:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 19 Sept 2024 at 19:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, 17 Sept 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Sat, 14 Sept 2024 at 20:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > > > reserving memory. This will then result in no notification being sent
> > > > > from the LMB module for the changes to the LMB's memory map.
> > > >
> > > > You seem to be using this in patch 3 and 7.
> > > >
> > > > Please, describe in this patch why you want to be able to suppress
> > > > notification.
> > >
> > > Will add the reasoning behind this flag in the commit message.
> > >
> > > >
> > > > In the EFI context we should use LMB notification to notify the
> > > > EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.
> > > >
> > > > See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> > > > specification.
> > >
> > > So, do you want me to use the EFI event signaling mechanism for this
> > > purpose ? Is my understanding correct ? If so, this will mean that we
> > > have an event notification specifically for EFI, and there might be
> > > one needed for any other consumers of this event. Currently there
> > > aren't any other consumers of the LMB memory map change event other
> > > than EFI, but using the U-Boot's event notification mechanism means
> > > that the same notification mechanism can be used if there were any
> > > additional consumers of this event in the future. In that case, we
> > > would have two separate event notifications, one for EFI, and one for
> > > non-EFI consumers.
> >
> > As I have previously said, none of this is necessary.
> >
> > Essentially all of the EFI setup that is done in U-Boot can be delayed
> > until we are actually starting an EFI app. The current approach of
> > keeping parallel EFI tables everywhere is causing much confusion.
> >
> > For EFI, it should be enough to read the lmb tables at the end and add
> > whatever parallel tables are needed to boot the app. We should not
> > need to keep things in sync through the life of U-Boot, since:
> >
> > 1. EFI pool-allocations should use malloc() until the app starts
> > 2. EFI page allocations should not be allowed until the app starts
> >
> > This whole area needs a healthy dose of 'keep it simple'.
>
> Except, the current implementation proposed by the patch *is* actually
> much more simpler than syncing the maps when the app starts. Because
> there is another scenario when the map needs to be synced, when the
> user issues a 'efidebug memmap' command, which dumps the efi memory
> map.
>
> Syncing the map from lmb means that the efi memory map first has to be
> generated afresh. And that is much more complicated than the method
> incorporated in the patch series. Apart from the ram/conventional
> memory type, we also need to include other memory types that might
> have been added to the memory map. So, this would mean, create a new
> memory map, add entries for conventional memory as have been obtained
> from lmb followed by other entries, and then discard the old memory
> map. And this has to be carried out every time a need for a memory map
> update is needed.

We are just not on the same page here. But I've replied to this point
on your other email. Also please understand that my objective is
actually to not do EFI allocations until just before the EFI app
actually starts (when we set up the EFI memory map). Until then, I
believe malloc() suffices.

Regards,
Simon
