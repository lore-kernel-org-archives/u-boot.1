Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F3ECD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2171684885;
	Tue,  5 May 2026 12:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dDKPk6KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7EF84893; Tue,  5 May 2026 12:26:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588C88487C
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B13F60125;
 Tue,  5 May 2026 10:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FDDC2BCB4;
 Tue,  5 May 2026 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777976784;
 bh=b1KYj/2HjiFb6vsFqCVnZRyktbnFBUcP2IOx0Tqvm6Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dDKPk6KIKvLnDPZCy0U+FxLOI1R7SShe0ry06ksG3I+yOxAUOhvFgaxR5PE/DTnKw
 zF6OeXuscmLdjnF8GEH3CgpOcSLkhZkMCw45ZjFlmwUD+TVnDln5u8E3j129UCMpJF
 su70nvY4tvyDce5QFAaoX5KPMLhXibuDiwC6D49oj+J3lSFboOOGO1yeWYZ2oZNXbE
 WvNtvs6Q5AGTfLbJTOjYh/QCbIik2q27RynAIPjP/P1UeuOOQLsYZB9BZJHGyQdixr
 nkc7g2D53UPDgy22zr7uYOX5Mf1B20th0QwgCJ6QKSgJYkcSYX4ryzlKNgq7fomoLd
 NjO19u45RrO2g==
Date: Tue, 5 May 2026 15:56:12 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/15] Revert "test: smem: add basic smem test"
Message-ID: <afnFxC7eOiJ5Orfb@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-3-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-3-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:31PM +0200, Casey Connolly wrote:
> This reverts commit 20e7705764c4e5ea924f1ea54bb36ebbbeffffe7.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  test/dm/Makefile |  1 -
>  test/dm/smem.c   | 26 --------------------------
>  2 files changed, 27 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 771b703b737d..ace149d4a2b4 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -111,9 +111,8 @@ obj-$(CONFIG_SCSI) += scsi.o
>  obj-$(CONFIG_DM_SERIAL) += serial.o
>  obj-$(CONFIG_DM_SPI_FLASH) += sf.o
>  obj-$(CONFIG_SIMPLE_BUS) += simple-bus.o
>  obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
> -obj-$(CONFIG_SMEM) += smem.o
>  obj-$(CONFIG_SOC_DEVICE) += soc.o
>  obj-$(CONFIG_SOUND) += sound.o
>  obj-$(CONFIG_DM_SPI) += spi.o
>  obj-$(CONFIG_SPMI) += spmi.o
> diff --git a/test/dm/smem.c b/test/dm/smem.c
> deleted file mode 100644
> index 89e74cccc574..000000000000
> --- a/test/dm/smem.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#include <dm.h>
> -#include <smem.h>
> -#include <dm/test.h>
> -#include <test/test.h>
> -#include <test/ut.h>
> -
> -/* Basic test of the smem uclass */
> -static int dm_test_smem_base(struct unit_test_state *uts)
> -{
> -	struct udevice *dev;
> -	size_t size;
> -
> -	ut_assertok(uclass_get_device(UCLASS_SMEM, 0, &dev));
> -	ut_assertnonnull(dev);
> -	ut_assertok(smem_alloc(dev, -1, 0, 16));
> -	ut_asserteq(0, smem_get_free_space(dev, -1));
> -	ut_assertnull(smem_get(dev, -1, 0, &size));
> -
> -	return 0;
> -}
> -DM_TEST(dm_test_smem_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> 
> -- 
> 2.53.0
> 
