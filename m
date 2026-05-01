Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB1FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 06:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2007380F0E;
	Fri,  1 May 2026 08:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tfUGfH8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4276681E18; Fri,  1 May 2026 08:54:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3592080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 69BC443A1E;
 Fri,  1 May 2026 06:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E5C2BCB7;
 Fri,  1 May 2026 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777618478;
 bh=dsjV8b+0MMeV3K2UHfik2vWiVl1tJW2MuLYYjd4Vi48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tfUGfH8S++ss+AYh0RnqyRgh/oO586xU8rQMs0XF59H/i7t2CXa9iQWuIi/f7nT2O
 SLGd6PjAX3cqLj6pp6eHQZJs0X6XXULCvo4j+sKf3GqrYiewoGmaKxk4Pma2olCEz2
 ApZKSCk8G+TDRuYDm4oeo2/+kA1Diuc377QalzjLyCFp91HI6T2lMGLkdK42/dniXz
 YrUlpffWHjXEXfEx1pFfF9OB70PezloZmwLf5tG0mgvCyZvmibNqmgg0quoRHt4CIA
 A57VZwI58XWOcsqpjKzmTwDZqy0d3j+5FQ1YJyXX0nL+pNQp0Gv1F2TNvFhWvHpzv4
 kNXANsi5ad1Rw==
Date: Fri, 1 May 2026 12:24:27 +0530
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
Message-ID: <afROIxgv7NYnXiF-@sumit-xelite>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <d786d7a7-0601-4680-aa73-96334ccad320@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d786d7a7-0601-4680-aa73-96334ccad320@siemens.com>
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

Hi Jan,

On Fri, Apr 17, 2026 at 02:15:43PM +0200, Jan Kiszka wrote:
> On 17.04.26 14:09, Aswin Murugan wrote:
> > This series adds dynamic device tree selection from FIT images for
> > Qualcomm Snapdragon platforms, enabling U-Boot to select the
> > appropriate DTB based on hardware parameters detected from SMEM.
> > 
> > Qualcomm fit based DTB format is documented in [1]
> > The fit image contains only DTB, while the kernel will be part of UKI image.
> > 
> 
> I suppose you know that UKIs (systemd-boot, EFI Boot Guard) provide DTB
> selection as well. However, that is a fix-up for the case the firmware
> does not provide a fitting DTB. This here is supposed to support the
> firmware DTB delivery, correct?
>

I would say instead that it's an alternate way to bundle multiple DTBs
in a specific DT partition which are used by firmware to select
appropriate DTB for the board the firmware is running on.

The source of this DTBs are from kernel only where the OEM has to take
care of 1:1 compatibility among kernel and DTB. This approach has been
deployed for Yocto and Android based systems but I do agree with general
purpose distros bundling DTBs in UKIs is surely an alternative option.

-Sumit
