Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E961C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D19F81F30;
	Fri, 28 Mar 2025 13:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UM9ef1tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38669805C8; Fri, 28 Mar 2025 12:34:51 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9C0809A4
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso333106166b.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161688; x=1743766488; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4aFwvL7gyifHzpc0klq/Pti/yD4vWJJws4d/4dOrLAI=;
 b=UM9ef1tnLGx6+PCLdMVzB5jY1MZeHM68fCt6l2bCvmmeeKH2kkY38YQoMc8vb5AhQQ
 FryvrOZodR883Z45miSigciufVY4GJQYjdF0L8cMIF43PVXkLZq3JWHmiozJQVbuK8KO
 GpO4cMoAGJ396Q6ZWmCkF7jD7zperhWngFNrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161688; x=1743766488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4aFwvL7gyifHzpc0klq/Pti/yD4vWJJws4d/4dOrLAI=;
 b=Hff86LpoRp26+IOnoTYFX/xx+ZqxXw++adXdTVsuBrZSE/7fiUQEdIsr9A/YLCklxo
 5DoSDsdm9bCUB8hPbpgD8QR/jdm3SQL2jvhGOa86jwO99cH7HlcCZzHx3y1ab6e/uxkN
 Z5+HeIX2xsDPElTXZdGNSPzr6TRBUfTT/HDOeHK+RtgTJk4z1sshFZQXdrPHT+t/NHDg
 S9DoW7ZWzQMPuShOPYeuV5JXw3G2sGsodwu9kcYN5Df/Kh6e3tzGMXFZ0aLuJEBb2zWO
 YydcfsIeSo8G4D9YjXHZQSf2lTuWrKdaEfrfkAUpAelmwDqdVO2H+DjkoS5xS82dD1NS
 jb0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ9y3Qz1QuFKHCpaR6F9vTiFlS/pies7FKes3hhNrcJQu69D11WfHwqroIojINTPK8RG1w2ec=@lists.denx.de
X-Gm-Message-State: AOJu0YwPKNKHLZgUihelp0lPyrNO4FCJh/mjkMqUn/CucRTqZdgPQzxt
 LahFSg9WEKqh6vaLcTMNSkhPEBx1nzD9+Zmm3t/qrEdCW4RaVyy7PCYQ95NXzt7IIip4Jj8qlgS
 kmbAfTp12P/XlOTNcOa+6qYB+BP+sM+lDrygI
X-Gm-Gg: ASbGncuBYzKCokkG8k1gKxNZQqskUz/24bWf7IGrs18irFRQPGDv8EIh8JfyJgm+nzW
 F8LXKXLjkIZq07nEqirC8XMxrRUhkiRxGk8Zg4evdgX38T3cJYivMwe9qYTNnio/Con1rBdjDHC
 pghNqdg37cxVppPemtIgyJbrMuQ9n9u+2/Ve48Yg==
X-Google-Smtp-Source: AGHT+IHJku0Sbo3jwI6acgZGfszf5R9A9mz+uQNN7jKCD3FdCgGjNkdRoL+TsInv2HnuxmQyzrtJpfd4hDZEI2RiKk4=
X-Received: by 2002:a17:907:7f06:b0:ac3:1b00:e17d with SMTP id
 a640c23a62f3a-ac6fb1606a6mr708919566b.54.1743161688119; Fri, 28 Mar 2025
 04:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
 <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
In-Reply-To: <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:31 -0600
X-Gm-Features: AQ5f1JpDpXaCd3wqLaJ5MWS8n5h6ctazvZFOheWacyKDSnmR4T8mWPNRJzEkiJs
Message-ID: <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Thu, 27 Mar 2025 at 15:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > > >
> > > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > > >
> > > > > The EFI subsystem defines its own bounce buffer for devices that
> > > > > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > > > > which can be reused instead of defining another symbol.
> > > > > The only limitation for EFI is that we don't know how big the file a user
> > > > > chooses to transfer is and as a result we can't depend on allocating the
> > > > > memory from the malloc area, which can prove too small.
> > > > >
> > > > > So allocate an EFI buffer of the correct size and pass it to the DM,
> > > > > which already supports bounce buffering via bounce_buffer_start_extalign()
> > > >
> > > > Looking at
> > > >
> > > >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > > >
> > > > in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> > > > enabled by the device driver. Only the scsi drivers sets bb = true.
> > > >
> > > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> > > > to blk_desc")
> > > >
> > > > Which device-drivers of the boards mentioned below do actually need
> > > > bounce buffering?
> > >
> > > Unfortunately, I don't have any of the hardware to test and I havent
> > > worked with that platform much.
> > > That 'bb' variable and the fact that EFI needs bigger allocations is
> > > why I ended up allocationg properly aligned memory from the EFI
> > > subsystem. But as Mark pointed out, the cache flush is a no go for
> > > now, so I'll drop this and see if I find time to rework the bounce
> > > buffer logic overall
> >
> > There was quite a bit of discussion about all this in the context of
> > my attempt to just add a message to warn the user[1]
> >
> > We might consider adding an event to reserve memory before relocation,
> > along with a way to discover (in board_r) where the memory was
> > allocated. That would make the solution more generic.
>
> I am not sure what you are trying to solve here. The EFI bounce buffer
> after the LMB patches can't overwrite memory, nor can it be
> overwritten.

I am thinking of we can create a single implementation of the
bouncebuf logic which also works for EFI.

I think the two sane things to do are:
- restrict U-Boot to using memory below 4GB for platforms which have
the DMA limitation
- create (in board_f) a special region below 4GB for use with the
bouncebuf logic


>
> Thanks
> /Ilias
>
> >
> > For the <4GB case we could perhaps add generic support for that in
> > board_f, i.e. the ability to reserve a region for boards that need it.

Regards,
SImon

> > [1] https://lore.kernel.org/u-boot/?q=%22Show+the+location+of+the+bounce+buffer+when+debugging%22
