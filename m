Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D7FC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3AAD81DB4;
	Thu, 27 Mar 2025 15:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kZcg8l/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C3681951; Thu, 27 Mar 2025 14:33:16 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5AC806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so189356566b.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743082393; x=1743687193; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=80l8bjMsmRffl6OVXm6A0mXSoLZ2i4gFpN1LMNvuOiU=;
 b=kZcg8l/hp+OzKNszTfHaI61y4bcOGsfsH4JnCPRGD6oshh1Od66UEBJ58EykoiP9pQ
 KjNajorJt5Sk+lHw8lXHp95MXhLt69Z10fW/FNUHWO5ZUBHpJHTYT7mURrSspmHhfUM2
 6xvh8ATFiwBMwq1H1oc3PpWDrit0CJtVULo0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743082393; x=1743687193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=80l8bjMsmRffl6OVXm6A0mXSoLZ2i4gFpN1LMNvuOiU=;
 b=qky5UZ/Tkcj/wK28BjP4+wJl1dwR20P9JHa1+iu+TaXEgdkl4greu6Rj19zUwKAqHb
 LURFSmC1dZygXAnJO2A8KyFOBoTGzBHurzhBv8j2ft8Qbw/uet8+ILpSQGInHkZ7VA+3
 u0VESJpwFvcNolVbA0mDIkflZGyNVgwzOumAf8qzyYabHVF0PjVEQ/4G/FT6GN0kS6f2
 NXt5uWKuYSCnT9x/YztZyHPax6xu3hem7RcSuoH7KMC8Uf5HRBYrngKNojBTLAbD2yw5
 ek307oM26IM2MzvKU1Gbs2EKFzVkks1dNV/ULm0yjzAmavLz+4t554s/FdbYmtwoBt6B
 H8Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3JTYs1Kbzr23mFy1DzLvOie2Etm9d0dsfDrvdulquOeCTrykJXSx4Ew9HzWciIyBwuvY+1M8=@lists.denx.de
X-Gm-Message-State: AOJu0YykiGzPMofpqRGTKHzKQqPMaUhwOdfWt1loWUxyYuP2PNkxoIH9
 L3wfqgp2m01+yZ6DAgbETBgzH/quKWe4CEZnOBSHwGz+/5ECA53qaElicqsmOysO3iKU2M5bKBY
 OElt6dZAaYPNNpZAnJofPHrD1X2cgXIONcoMM
X-Gm-Gg: ASbGncsnosHitAhhNxN9SRPbaRRuE1hV35+jQalMbMw5kfhIncnpYf0XWP1G60GmRo4
 8flFBqo9EG5wfiG7Z7rbp7Mw+CZOxAJTgxquFTJ+VaMLmrX/L+QJVU4ESBP7kMHkNsKKEPzBS/n
 hknfNtNKCXsWt1GUumqtgSBgzb90A=
X-Google-Smtp-Source: AGHT+IHvZpe8R9Oj977ZPnxHAJEiaw53yrZvBdkYM+CyD3OGIUwHJHMy+qsSqvpXQo+Oemn0vQwOkXhIGfDJwHV6PHI=
X-Received: by 2002:a17:907:1c0c:b0:ac6:b639:5a1b with SMTP id
 a640c23a62f3a-ac6fb14ec02mr315007766b.45.1743082392835; Thu, 27 Mar 2025
 06:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
In-Reply-To: <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Mar 2025 07:33:01 -0600
X-Gm-Features: AQ5f1JoIaUtS4OUivQs5fFZmEULB8BgMcajPppp5U1BBcMt9EVq3_10n3wCf_Mw
Message-ID: <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 27 Mar 2025 15:07:52 +0100
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

On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 17.03.25 14:38, Ilias Apalodimas wrote:
> >
> > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> >
> > > The EFI subsystem defines its own bounce buffer for devices that
> > > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > > which can be reused instead of defining another symbol.
> > > The only limitation for EFI is that we don't know how big the file a user
> > > chooses to transfer is and as a result we can't depend on allocating the
> > > memory from the malloc area, which can prove too small.
> > >
> > > So allocate an EFI buffer of the correct size and pass it to the DM,
> > > which already supports bounce buffering via bounce_buffer_start_extalign()
> >
> > Looking at
> >
> >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> >
> > in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> > enabled by the device driver. Only the scsi drivers sets bb = true.
> >
> > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> > to blk_desc")
> >
> > Which device-drivers of the boards mentioned below do actually need
> > bounce buffering?
>
> Unfortunately, I don't have any of the hardware to test and I havent
> worked with that platform much.
> That 'bb' variable and the fact that EFI needs bigger allocations is
> why I ended up allocationg properly aligned memory from the EFI
> subsystem. But as Mark pointed out, the cache flush is a no go for
> now, so I'll drop this and see if I find time to rework the bounce
> buffer logic overall

There was quite a bit of discussion about all this in the context of
my attempt to just add a message to warn the user[1]

We might consider adding an event to reserve memory before relocation,
along with a way to discover (in board_r) where the memory was
allocated. That would make the solution more generic.

For the <4GB case we could perhaps add generic support for that in
board_f, i.e. the ability to reserve a region for boards that need it.

Regards,
SImon

[1] https://lore.kernel.org/u-boot/?q=%22Show+the+location+of+the+bounce+buffer+when+debugging%22
