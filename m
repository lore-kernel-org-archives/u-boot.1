Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBDFF34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EC98421E;
	Mon, 13 Apr 2026 15:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uCC314WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE6C83DC9; Mon, 13 Apr 2026 14:37:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2337F839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E72FF60172;
 Mon, 13 Apr 2026 12:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D1EC2BCAF;
 Mon, 13 Apr 2026 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776083853;
 bh=ww/4yMteWj6US2Z0S8osEy4M2FdwsClTbjXY9Whc2r4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uCC314WNCvEkTnKn/Rr4Mp2OwRASoUxzqF4FChPI5jjygJKOd1UcHhs52tusd5VRa
 yjH6TQta9uRXzLAcgbMfCmVebfZLxQon2333zWmIrzdhMCkjfeucVx3MbFvIr0UzlG
 dZ9/43SNy2gG3t+UjaQgO65KIl9liEHgWDH9GmjGNoDcCc8UdRhS2sIw4TBy2Y1qzt
 tAcejLDNqnDJ9VjOgpxSdS1NYQR4EFRusDlYqi9UnqUntgvCPsHI9tp3hP+05hyzUy
 gRmiuKierqGYo3Uc9oVKUOcMge90lDu+rnzNGYAIgD1ergADB9lYYgXEYMdCPYeqgr
 aN3JgGytZCqag==
Date: Mon, 13 Apr 2026 18:07:19 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 2/4] drivers: ufs: qcom: Add SPL support
Message-ID: <adzjf6IrtuV2p4p9@sumit-xelite>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-2-f7e0e243d805@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-spl_ufs_only-v1-2-f7e0e243d805@oss.qualcomm.com>
X-Mailman-Approved-At: Mon, 13 Apr 2026 15:49:01 +0200
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

On Thu, Apr 09, 2026 at 08:13:32PM +0530, Balaji Selvanathan wrote:
> Enable Qualcomm UFS driver to be built for SPL. The ufs-uclass is
> also built conditionally based on whether SPL or
> U-Boot proper is being compiled.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/ufs/Kconfig  | 8 ++++++++
>  drivers/ufs/Makefile | 7 ++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..a32d51cae1d 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -55,6 +55,14 @@ config UFS_QCOM
>  	  This selects the platform driver for the UFS host
>  	  controller present on Qualcomm Snapdragon SoCs.
>  
> +config SPL_UFS_QCOM
> +	bool "Qualcomm Host Controller driver for UFS in SPL"
> +	depends on SPL_UFS_SUPPORT && ARCH_SNAPDRAGON

Rather than SPL_UFS_SUPPORT, you can just say SPL_UFS which will
simplify below..

> +	help
> +	  This selects the platform driver for the UFS host
> +	  controller present on Qualcomm Snapdragon SoCs for use in SPL.
> +	  Enable this to use UFS as a boot device in SPL on Qualcomm platforms.
> +
>  config UFS_RENESAS
>  	bool "Renesas R-Car S4 UFS Controller support"
>  	depends on UFS
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..7056066ce25 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -3,13 +3,18 @@
>  # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>  #
>  
> +ifdef CONFIG_SPL_BUILD
> +obj-$(CONFIG_SPL_UFS_SUPPORT) += ufs-uclass.o
> +else
>  obj-$(CONFIG_UFS) += ufs-uclass.o
> +endif

..to:

obj-$(CONFIG_$(PHASE_)UFS) += ufs-uclass.o

>  obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>  obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>  obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
>  obj-$(CONFIG_UFS_PCI) += ufs-pci.o
> -obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
> +obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
>  obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>  obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>  obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
>  obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
> +

Drop un-necessary blank line added here.

-Sumit
