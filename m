Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B688EC47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB0787A0E;
	Thu, 18 Jan 2024 08:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZtwfAWMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9022287B5F; Thu, 18 Jan 2024 08:35:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C4F87A00
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705563314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pa93PT82KI9iyZlh/Njw33AcENTMVm0Uo3N5jnMyhD4=;
 b=ZtwfAWMzsS18FabULN84SpScpeFr3b4bgJmeNUws4kKMGDv8A3kLeUg6ijqjINtWP/ITb1
 pENxNAqUR+5ErG5clwwxZPzl+M2KHeXTOiTO0u2YEV8EqZt0OKpzcF4fWwnyRq777UdQDw
 hyS0VjE47IWpVt5DtnqucBO5mVTvcA0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-ena_lzSvNei6gp8KJ_NurA-1; Thu, 18 Jan 2024 02:35:12 -0500
X-MC-Unique: ena_lzSvNei6gp8KJ_NurA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2107aeb1fa8so3087769fac.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705563312; x=1706168112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pa93PT82KI9iyZlh/Njw33AcENTMVm0Uo3N5jnMyhD4=;
 b=d84f2Dr7STEOcuBoYnpHq0ome0lPWGnPCpF4YI/3AXP/gCgX/o2qoJwkQghTvr16PC
 N3X8HG2eLzJtXzo4VoLbDjvpkrW+e7mpz3DRGIac7b0UmBov2NlcspXDbwLcXdOPxR3Q
 TafNIdUblOR8t0JrWa1xc+V4WcwGuj0H3uZTyS2sORZiwQJNl6Ftkb9lvNjEDLtUEpNO
 ERfB25xFGfd8gKM9CRyycw8jnDJOJkTpT/jbyZZFIs04vBjcI6HYTt4DDoVyf3yT/ELg
 oGjAq9vgBuyeoA/j5uM94aLkgdABGJ4/tbdkLYEyySCr28keKm3CmUAt3WyohGUy5oVG
 StvQ==
X-Gm-Message-State: AOJu0YzmqEZttAp91fzAXXa5hyFwYUZOQi7O3OfxunW/7PIv90jsqivP
 294ZioxG07niHxEh1pPSTGaHLTbjoZa5/IyKcUZzNO+1G3ZV7ij/5MoXFDDBdpASofdjKBN5UdB
 pKyVoSE4+A18gbsfMlYZmSZjrPxIoq1j3PORrCfRl5xBjWj2+bUggWrTmN6NUkpxT965gR8hNjq
 bC463Ik+EQCavEpsQN5my5oHG6yA==
X-Received: by 2002:a05:6870:8290:b0:203:c5ca:533e with SMTP id
 q16-20020a056870829000b00203c5ca533emr437319oae.24.1705563312270; 
 Wed, 17 Jan 2024 23:35:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtTemmYgQfX/e3EGI66XJyy6je8ls+Qq3GqHy9r8NkgSIA53VqekH4qQW9V5b71kThQAjQ7BYoQ0mkuhIB5Kc=
X-Received: by 2002:a05:6870:8290:b0:203:c5ca:533e with SMTP id
 q16-20020a056870829000b00203c5ca533emr437295oae.24.1705563312079; Wed, 17 Jan
 2024 23:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20240103153715.43kvt4ma7u7gz76y@sandblast>
 <20240103155324.cr74b2plb7kjan4t@richness>
In-Reply-To: <20240103155324.cr74b2plb7kjan4t@richness>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 18 Jan 2024 08:35:01 +0100
Message-ID: <CALE0LRvBz9DVvKgyHbbrJ-_Z4pc1GmdtsKuUKAJyMT2v5f7GJQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Introduce initial TI's J784S4 and AM69 support
To: Nishanth Menon <nm@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

Hi Apurva et al,

On Wed, Jan 3, 2024 at 4:53=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 09:37-20240103, Nishanth Menon wrote:
> > On 00:45-20231220, Apurva Nandan wrote:
> > > Hello Everyone!
> > >
> > > This series will introduce basic support (SD and UART) support for Te=
xas
> > > Instruments J784S4 EVM.
> > >
> > > The J784S4 SoC device tree patches are taken from kernel patch submis=
sions
> > > and will be updated as they are accepted and merged to the kernel tre=
e.
> > > All other patches are specific to SPL and u-boot and do not have
> > > dependency on other trees. Appreciate a review for acceptance to u-bo=
ot
> > > tree.
> > >
> > > Here are some of the salient features of the J784S4 automotive grade
> > > application processor:
> > >
> > > The J784S4 SoC belongs to the K3 Multicore SoC architecture
> > > platform, providing advanced system integration in automotive,
> > > ADAS and industrial applications requiring AI at the network edge.
> > > This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> > > raising performance and integration while providing interfaces,
> > > memory architecture and compute performance for multi-sensor, high
> > > concurrency applications.
> > >
> > Tried to apply this series on top of:
> > next dffa6d0210f5 Merge tag 'dm-next-1124' of https://source.denx.de/u-=
boot/custodians/u-boot-dm into next
> >
> >
> > $ git am -3 v7_20231220_a_nandan_introduce_initial_ti_s_j784s4_and_am69=
_support.mbx
> > Applying: arm: dts: Introduce j784s4 dts from linux kernel
> > Applying: arm: dts: Introduce am69-sk dts from linux kernel
> > Applying: arm: mach-k3: Add basic support for J784S4 SoC definition
> > Applying: arm: mach-k3: Sort SoC JTAG_ID entries
> > Applying: soc: ti: k3-socinfo: Add entry for J784S4 SoC
> > Applying: arm: mach-k3: j784s4: Add clk and power support
> > Applying: drivers: dma: Add support for J784S4 SoC
> > Applying: board: ti: j784s4: Add board support for J784S4 EVM
> > Applying: board: ti: j748s4: Add board config yaml files
> > Applying: board: ti: j784s4: Add boot environment variables
> > Applying: arm: dts: Introduce am69-sk u-boot dts files
> > error: patch failed: arch/arm/dts/Makefile:1411
> > error: arch/arm/dts/Makefile: patch does not apply
> > error: arch/arm/dts/k3-j784s4-binman.dtsi: does not exist in index
> > Patch failed at 0011 arm: dts: Introduce am69-sk u-boot dts files
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > You will probably have to rebase this series once any review comments
> > are addressed.
>
> Looks like public-inbox in kernel.org is missing patch[1] #11, but
> patchworks[2] seems to have a copy
>

Yeah, I was also hit by this one, I checked again and the patches
still apply cleanly on top of the mainline u-boot. Apurva would you
mind to address the few comments that the patches received, add all
the reviewed tags and resend again? Once done, I think the patches
will be in a good state to be merged.

Thanks,
  Enric

> Comments to follow..
>
> [1] https://lore.kernel.org/all/20231219191537.4039361-1-a-nandan@ti.com/=
#t
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D387428
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
>

