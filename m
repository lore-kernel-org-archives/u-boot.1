Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485F7C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A4F81F4D;
	Fri, 28 Mar 2025 13:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y+Fmqc20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C8F810EA; Fri, 28 Mar 2025 13:27:19 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8572C80079
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so2066981276.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743164835; x=1743769635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3gXJNeHoigOcUVFmwnvJZnQU2dSZTeimRSdsa6Jtuqg=;
 b=Y+Fmqc20bTfsAyKydGGkew2vXihGO2pq84/gpwMpkSorOLOuVE/JdZpgEHT6WIAxmW
 2hOM+keS1PuRzJLQuiGb74J3i6u8H1XRILgpDaiCbWZ8b9p0Ng6q0Tl7GgQw1J1GsMnc
 Hu2+C3vtj0DLjqiXqUNeB2jhyonkaSgBXiqtpKJObLMNuS7ypWB3CAmcc4Zu7XG4AJV4
 UUVteC8wwzq2AfoagTM5twzCtpsTgCeDzgPWP/CooEO0ILuHLetNrGQ+TVp4qZOzO1qk
 9ERlQ4WSsutLugwIUYWZwMFxIzQHHZYp//umORuxgGrkOKmq0zZ5KSyNY9xcVsomRF6k
 GPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743164835; x=1743769635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3gXJNeHoigOcUVFmwnvJZnQU2dSZTeimRSdsa6Jtuqg=;
 b=bv/dzfG+wALguzmi3Fa7bjvtk4wuxJ/o6hQAezXicIS34zUmCD/OliGlUbtLNP6J/C
 KlAYy7DHd1a3moCwd3/L0gF64T4pRxLu0kGMtn8UJqgdoYzmOiGIreF9FxOo9D76dmgL
 2lFqO+EI2nTmrHQkkuZHMwaZqi1BH3164ohNaJK2k8BpDzFlDbG5fIJaIucwnIcFs3Bo
 738MT61Ivj/rJdb9U3nqWy+ci+yLUicCqPAjxx6gEQ6qTIBtHMV0Te4iArnWZN4oElq3
 ddBCjbVk7xJ49qt7Iwf1ZCEqtHVEkxtCa2cNncVXbMGZlUEy/I9iF1SaAvEZi+cLj05S
 CVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuULTxmI9j5BXYAafE/NZ/aUBVDiP907INgVURiIlq2izKBq0QJ589fUIyB6FZSkkcN/peolg=@lists.denx.de
X-Gm-Message-State: AOJu0YynmkDITIwYQ/gioM5Ta2/zcFnDDfonj3S+aCOi/x3wO73Y4vMX
 AhAAZUWwg+w0F1RNJG/xnwIO54AJ/7n83eETc2cWglpBAOZRPYUyNHyJp+3EC5fa7/fSIp/HVDz
 DkQlC1wTQestmyz5B2dxMcCAKpLnp2GgeiOoB0A==
X-Gm-Gg: ASbGnctswRNwM34GdMYGiEeoeZCy+/5olPdccoS8JnwLRoX4AoQrWynoBp+r2zY+4HF
 HoT/jcbVth9byrAfRfuw48V+xcnt7nYJv/r0bvcvvdO+aMSkR+ciIF1mhMttODRKCWae0eKXb+E
 Z0cQs9nQB5iiTi4SOqH7u5N4uB
X-Google-Smtp-Source: AGHT+IHuCr4N/l8ppCD/CVxfjTnfKuALtC3ApEr3Pz1Drp18IhiT0vFmcbzQ/lh2uKdoDG/vKhbdIkW/a9qIyLY7HNE=
X-Received: by 2002:a05:6902:4810:b0:e60:87a0:61fd with SMTP id
 3f1490d57ef6-e694353efb7mr9125750276.6.1743164835100; Fri, 28 Mar 2025
 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
 <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
 <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
In-Reply-To: <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:26:39 +0200
X-Gm-Features: AQ5f1JrdtDBiVDeDyMwSR7s_zRoiEaXlLzSX8ImIiYXcv_UI35-iPSBu9BXBoDM
Message-ID: <CAC_iWj+2EsRUBT5ThAR7+wwxVkFSzrApCNDbTEEHQ-W658LwCw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, e@freeshell.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Michal Simek <michal.simek@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Peng Fan <peng.fan@nxp.com>, Wei Ming Chen <jj251510319013@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Mar 2025 13:42:48 +0100
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

On Fri, 28 Mar 2025 at 13:34, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 27 Mar 2025 at 15:19, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Heinrich,
> > > >
> > > > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > > > >
> > > > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > > > >
> > > > > > The EFI subsystem defines its own bounce buffer for devices that
> > > > > > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > > > > > which can be reused instead of defining another symbol.
> > > > > > The only limitation for EFI is that we don't know how big the file a user
> > > > > > chooses to transfer is and as a result we can't depend on allocating the
> > > > > > memory from the malloc area, which can prove too small.
> > > > > >
> > > > > > So allocate an EFI buffer of the correct size and pass it to the DM,
> > > > > > which already supports bounce buffering via bounce_buffer_start_extalign()
> > > > >
> > > > > Looking at
> > > > >
> > > > >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > > > >
> > > > > in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> > > > > enabled by the device driver. Only the scsi drivers sets bb = true.
> > > > >
> > > > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> > > > > to blk_desc")
> > > > >
> > > > > Which device-drivers of the boards mentioned below do actually need
> > > > > bounce buffering?
> > > >
> > > > Unfortunately, I don't have any of the hardware to test and I havent
> > > > worked with that platform much.
> > > > That 'bb' variable and the fact that EFI needs bigger allocations is
> > > > why I ended up allocationg properly aligned memory from the EFI
> > > > subsystem. But as Mark pointed out, the cache flush is a no go for
> > > > now, so I'll drop this and see if I find time to rework the bounce
> > > > buffer logic overall
> > >
> > > There was quite a bit of discussion about all this in the context of
> > > my attempt to just add a message to warn the user[1]
> > >
> > > We might consider adding an event to reserve memory before relocation,
> > > along with a way to discover (in board_r) where the memory was
> > > allocated. That would make the solution more generic.
> >
> > I am not sure what you are trying to solve here. The EFI bounce buffer
> > after the LMB patches can't overwrite memory, nor can it be
> > overwritten.
>
> I am thinking of we can create a single implementation of the
> bouncebuf logic which also works for EFI.
>
> I think the two sane things to do are:
> - restrict U-Boot to using memory below 4GB for platforms which have
> the DMA limitation

You don't need that. The bounce buf code has a callback you can use to
define the limitations

> - create (in board_f) a special region below 4GB for use with the
> bouncebuf logic

The only problem with EFI is that you don't know how much memory it
needs and we can't use the existing memalign calls. So if we replace
that memalign in the bounce buffer code, with an lmb reservation we
have everything we need.

/Ilias
>
>
> >
> > Thanks
> > /Ilias
> >
> > >
> > > For the <4GB case we could perhaps add generic support for that in
> > > board_f, i.e. the ability to reserve a region for boards that need it.
>
> Regards,
> SImon
>
> > > [1] https://lore.kernel.org/u-boot/?q=%22Show+the+location+of+the+bounce+buffer+when+debugging%22
