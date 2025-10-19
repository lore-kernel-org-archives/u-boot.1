Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6077DCCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 08:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7FE83771;
	Sun, 19 Oct 2025 10:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="NbFGKMqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3E28382E; Sun, 19 Oct 2025 10:57:05 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A562836D2
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 10:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sun, 19 Oct 2025 10:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1760864223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jf/jOJq3lgMhDZ537XtTsPT0Z1HPZd5zjyvSNQ/AgT8=;
 b=NbFGKMqQlYerA186dqCzq6FQ2815A/9dGEQ4nWWCTrohGcVkWT15TSvUti1MHvyj/HeRgS
 +Bp6z0E0/cA4EHVPI0zoRMZofdFILFpesR6JQ/S5bxKVOmJ/+GAjiTDMfCX4yfFn98zwCN
 bez0e+EE56lPBSaRRXCv0rkzbecGoUA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Lukas Timmermann <uboot@timmermann.space>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/2] Modern pinctrl for Exynos5250 devices
Message-ID: <20251019085700.GA58128@l14.localdomain>
References: <20251013231542.821799-1-uboot@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013231542.821799-1-uboot@timmermann.space>
X-Migadu-Flow: FLOW_OUT
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

Hi Lukas,

On Tue, Oct 14, 2025 at 01:14:00AM +0200, Lukas Timmermann wrote:
> This patch adds the necessary files to use a modern pinctrl driver
> with an exynos5250 SoC. The changes are well tested and are working.
> GPIO isn't implemented right now, as the older s5p_gpio driver needs
> to be disabled for the newer driver to work.
> 
> All changes were tested with soon-to-be upstreamed DTs for the
> Linux kernel. The tested device is a Google Nexus 10 (samsung-manta).
> U-Boot was ported to that device and will be upstreamed into U-Boot
> soon.
> 
> I don't have much experience with the mailing list workflow, u-boot
> or driver development in general. I apologize for any mistakes I might
> do.

For future submissions, please use the ./scripts/get_maintainer.pl
script to more easily send the patches to the maintainers, reviewers
and others that might be interested in the patch. Alternatively,
please consider using b4 to arrange and handle the patches, it has an
option --auto-to-cc which can help find suitable receivers.

Best regards,
Henrik Grimler

> Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
> 
> Lukas Timmermann (2):
>   gpio: s5p_gpio: Add config option for s5p_gpio driver
>   pinctrl: exynos: add exynos5250 driver
> 
>  MAINTAINERS                                 |   5 +
>  arch/arm/mach-exynos/pinmux.c               |  18 ++++
>  drivers/gpio/Kconfig                        |   7 ++
>  drivers/gpio/Makefile                       |   2 +-
>  drivers/pinctrl/exynos/Kconfig              |   8 ++
>  drivers/pinctrl/exynos/Makefile             |   1 +
>  drivers/pinctrl/exynos/pinctrl-exynos5250.c | 100 ++++++++++++++++++++
>  7 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos5250.c
> 
> -- 
> 2.51.0
> 
> base-commit: ebf4cce0b009e45b1d4e778603b74fae5ea29678
> branch: lat3st/samsung-manta
