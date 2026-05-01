Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E6CD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6936D803C6;
	Fri,  1 May 2026 14:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PVCXnetE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE6E80F0E; Fri,  1 May 2026 14:07:21 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B8080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 14:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DEA86015B;
 Fri,  1 May 2026 12:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42824C2BCB4;
 Fri,  1 May 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777637237;
 bh=AOVCWv3aCG8rwpNMm36RAZsY3mSiMmX+mM+lBztKfR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PVCXnetE/OyoiAsjTgz6h5Kc1JSQQwIqlRRqxic1kxSrLqEZP4DYyM26HyB8h9vVL
 WAtp5V6TPkxmKIBdBeu349jbvjQRMdzU1RNbXVtKXBlJkbPIQqFHbSMiVgViCRytlQ
 mmol22TCUEQzB0aVYijvOQfyuM/7WM0iWqZdMMvjlqevki7UU42LpbPFMZMg3+h4zn
 nB6uPf4wXGnIgNU1CM36fDSOOY8tCrkjataxrQB780givJyJyqc64Oki/iRePTG6/h
 I3tVkTKD3fxVtpTF63BErlMB9lPS+n+wwqCtET5lHoHt06NvazTvCbj81DVWM/ETMm
 OxcqD7HQ/GhvQ==
Date: Fri, 1 May 2026 17:37:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, mchitale@ventanamicro.com,
 maximmosk4@gmail.com, jonas@kwiboo.se, marek.vasut@mailbox.org,
 quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de,
 yangshiji66@outlook.com, funderscore@postmarketos.org,
 hs@nabladev.com, kory.maincent@bootlin.com,
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
Message-ID: <afSXa7q7hJC_ZW07@sumit-xelite>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <d786d7a7-0601-4680-aa73-96334ccad320@siemens.com>
 <afROIxgv7NYnXiF-@sumit-xelite>
 <07b731ba-adc2-4538-bed8-02c12eaa1936@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b731ba-adc2-4538-bed8-02c12eaa1936@siemens.com>
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

On Fri, May 01, 2026 at 09:39:53AM +0200, Jan Kiszka wrote:
> On 01.05.26 08:54, Sumit Garg wrote:
> > Hi Jan,
> > 
> > On Fri, Apr 17, 2026 at 02:15:43PM +0200, Jan Kiszka wrote:
> >> On 17.04.26 14:09, Aswin Murugan wrote:
> >>> This series adds dynamic device tree selection from FIT images for
> >>> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> >>> appropriate DTB based on hardware parameters detected from SMEM.
> >>>
> >>> Qualcomm fit based DTB format is documented in [1]
> >>> The fit image contains only DTB, while the kernel will be part of UKI image.
> >>>
> >>
> >> I suppose you know that UKIs (systemd-boot, EFI Boot Guard) provide DTB
> >> selection as well. However, that is a fix-up for the case the firmware
> >> does not provide a fitting DTB. This here is supposed to support the
> >> firmware DTB delivery, correct?
> >>
> > 
> > I would say instead that it's an alternate way to bundle multiple DTBs
> > in a specific DT partition which are used by firmware to select
> > appropriate DTB for the board the firmware is running on.
> 
> Right. We (and likely not only us) implemented that kind of DTB
> selection many years ago for the IOT2050 boards with existing U-Boot
> features here. But we embedded the supported DTBs into the U-Boot FIT
> image so that they naturally become part of the secure boot chain.

Yeah but this apporach of DTBs only FIT decouples it from how kernel
secure boot chain works whether it's based on UEFI secure boot or FIT
based or any other approach.

> 
> > 
> > The source of this DTBs are from kernel only where the OEM has to take
> > care of 1:1 compatibility among kernel and DTB. This approach has been
> > deployed for Yocto and Android based systems but I do agree with general
> > purpose distros bundling DTBs in UKIs is surely an alternative option.
> 
> This is just a workaround for broken vendor firmware or vendor kernels.
> In the ideal world, the firmware delivers an upstream-approved DTB to an
> upstream kernel. Any update of firmware or kernel only augments bindings
> and DTBs, adding features or refining them in a compatible way, not
> breaking them - SystemReady.

Here this multi DTB isn't part of the kernel image and nor part of the
firmware image but has to get independent updates which surely have to
be aligned with the kernel to avoid any breakage. However, this approach
tries to acheive SystemReady in that way.

> 
> In real world, premature vendor code gets shipped first and only cleaned
> up later on via upstream (if at all). Then you need to fix up the
> mismatches between in-field firmware and upstreamed kernels. And all
> that obviously in secure, updatable way, therefore UKI embedding.
>

I do agree the DT incompatibilities are always hard to manage however
the vertically integrated stacks like Android or Yocto which Qualcomm
SoCs supported don't always want DTBs or overlays to be bundled alongside
the kernel image. However, surely we want the general purpose distros to
be supported as well which can always over-ride DT as needed.

In summary, from Qualcomm point of view, we will try to support both these
multi FIT DTBs approach as well as the UKI bundling. In the end it really
depends on the OS vendors to choose whichever approach suits best to
their needs when it comes to in field updates.

-Sumit
