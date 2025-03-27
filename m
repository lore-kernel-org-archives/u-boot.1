Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC37C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F0181E60;
	Fri, 28 Mar 2025 03:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O3RyrT7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C6B8082A; Thu, 27 Mar 2025 22:19:50 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4900805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 22:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e643f235a34so1179586276.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743110386; x=1743715186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCtrrkQ2+tSdAd5jdeMocl1pOeBn3vHfDqajDWw6+Q4=;
 b=O3RyrT7LkoSWf151zipmCcgXwVAcKmjQP/GF9n9KAZM5aeJ4oT7bXxxj2towSLbq/v
 LE/C9yd7oaqC2CCUiXnJBI0/qGHni8UDAqYC4QCpmGD9zyyUysMPDzCHoh0sOHs4sEIt
 NhxVOse4fxzTl44Cug5TQ7WuU2+/hOGAzzq+ThxF4QC3u4QBU1VY9ZeS/4Zw/3xCLoEh
 Qlc/iZAQRe4bJqJz2dWXSmj7NesyCQ9wWtLmH6glTAGTCC/zEjZeomXRgyvXWuQsP7Q5
 DJD9X8A7NqxJCmNzH4DrFJz/6aGRfvzO7niw/1X2cVsdY+kk59utmNe/r/R+S+i4rDbB
 xkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743110386; x=1743715186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCtrrkQ2+tSdAd5jdeMocl1pOeBn3vHfDqajDWw6+Q4=;
 b=FlsB6k5UyQeZh77VvkllT20JpVD038cr2oysLU/pLPOovr9J94Rpboo+yLyPpKwShE
 B4LrtNVyDu/cMzYWwj9cDTDcyQsQNRlpLUCWR0pOFn4ylNzZ2N3WbureB9g7dZOQ0rX8
 uRNsWFpSkaHXqBB8e7wbV6LQU/36NL2OjBwwFIIeI1nh6jMawG537Fv9gmfdQtWztbB+
 oGRGgfMQhBKozebLGKI1rlMPoHBGbOR7QVVlu6RLVOpjsLFDXQ57t8g3IEl0DzMeqy4I
 wHPPaR25cuBfDcOYLHR9mAenJeqoLHAaEglPDqj6nQTV+huNhfjKjYYcZQFs2qBA0pQv
 PIvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+RhOZYeYBH3Z+yarsv7EWG3T4Fh17X+dbhjAHipLdelsY2E/QWTxCES+a8RI4km1UJDFjG1M=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf7Nu0iyLW+EohVEo4Ayw8/FVzRpkRnwJqUE5Xpk1NcKkmn/9u
 npMgQeX4CZEgIUbhGXimIcRP1KjYVjpjonRHfEv1nIADYI7aZpuUAs7JHcD9TH0RX5tR538w3uJ
 E3Git1AwrHVV38Kp0ZisRgzrKawsXfpIAnnyrPQ==
X-Gm-Gg: ASbGncsXEL1jl/EGtWV4j5NtoLRg7NfmHQcD+HkQHsI5wl2uf0NWDDmrIsSiMN8o341
 hao+72smM3BYAKd3375VCAtcclkTImZVMx+Z3i/WzyT5sZLDvPGELKob8MsbMGlVUgiERN6MYcN
 HByPO8ouiXUsswl0/waJ+uQUNi
X-Google-Smtp-Source: AGHT+IEzKjqpBs4pv2Zhe5nFV+IMR2KHYrZlEXsCYxUvbivCFDkk78CVi2yJM5aS48knodZfzkUjlOpzl0BOn1aZNfg=
X-Received: by 2002:a05:6902:1085:b0:e5b:1b55:1325 with SMTP id
 3f1490d57ef6-e6943656293mr6785695276.25.1743110386316; Thu, 27 Mar 2025
 14:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
In-Reply-To: <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 27 Mar 2025 23:19:10 +0200
X-Gm-Features: AQ5f1JqiGXoFSpP_OXtYKjDUwD54vMBuPRVxwH3aSr2qgWmMcAMsZ5ZpLTERIOE
Message-ID: <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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

Hi Simon

On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > >
> > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > >
> > > > The EFI subsystem defines its own bounce buffer for devices that
> > > > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > > > which can be reused instead of defining another symbol.
> > > > The only limitation for EFI is that we don't know how big the file a user
> > > > chooses to transfer is and as a result we can't depend on allocating the
> > > > memory from the malloc area, which can prove too small.
> > > >
> > > > So allocate an EFI buffer of the correct size and pass it to the DM,
> > > > which already supports bounce buffering via bounce_buffer_start_extalign()
> > >
> > > Looking at
> > >
> > >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > >
> > > in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> > > enabled by the device driver. Only the scsi drivers sets bb = true.
> > >
> > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> > > to blk_desc")
> > >
> > > Which device-drivers of the boards mentioned below do actually need
> > > bounce buffering?
> >
> > Unfortunately, I don't have any of the hardware to test and I havent
> > worked with that platform much.
> > That 'bb' variable and the fact that EFI needs bigger allocations is
> > why I ended up allocationg properly aligned memory from the EFI
> > subsystem. But as Mark pointed out, the cache flush is a no go for
> > now, so I'll drop this and see if I find time to rework the bounce
> > buffer logic overall
>
> There was quite a bit of discussion about all this in the context of
> my attempt to just add a message to warn the user[1]
>
> We might consider adding an event to reserve memory before relocation,
> along with a way to discover (in board_r) where the memory was
> allocated. That would make the solution more generic.

I am not sure what you are trying to solve here. The EFI bounce buffer
after the LMB patches can't overwrite memory, nor can it be
overwritten.

Thanks
/Ilias

>
> For the <4GB case we could perhaps add generic support for that in
> board_f, i.e. the ability to reserve a region for boards that need it.
>
> Regards,
> SImon
>
> [1] https://lore.kernel.org/u-boot/?q=%22Show+the+location+of+the+bounce+buffer+when+debugging%22
