Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E636BFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F3AB848CE;
	Tue,  5 May 2026 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g5o2dbKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADC0848D8; Tue,  5 May 2026 14:44:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC496848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9255060142;
 Tue,  5 May 2026 12:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE8C2BCB4;
 Tue,  5 May 2026 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777985040;
 bh=hneXc7p6D2ukLUabBWpOFDCjS32j/19DYmJm723GJo4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g5o2dbKqlEk9qixbbnTHdLKgmGgs+2Q94QsOXk/vQYtr78Eq4q5Lu6eVc9lMgzNPH
 aJLh1ZIu+3VP0OpxahB8PNpWTQ18jYaMpoBZd6dQH+dLTHMVWGRsfCNuUIfdjvaZ6P
 rjS4FV/pmcWvXvfgXov6XnCfpFByp6rJo8fdT/+fvYZOdOXKfdZUSRCrH3q1/ZtO9f
 kLLS23YA/MmeTgTQPvqrubWk8Er2cWbuRilfHhxBGrhz13EDRADag4nUvju9woFxV/
 y22Np0Lf5zAIMXs1toTb6IKFygqCTyJ5VBrnLWLJ3OGWE8FR6CIS7tWQeEcZaFaRGM
 aqTf3WW1QcC8w==
Date: Tue, 5 May 2026 18:13:48 +0530
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
Subject: Re: [PATCH v2 07/15] soc: qcom: smem: adjust headers for U-Boot
Message-ID: <afnmBNC9zANetVXQ@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-7-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-7-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:35PM +0200, Casey Connolly wrote:
> Drop Linux headers for the U-Boot ones.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 8515b8ae7777..7143856e85c3 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -3,19 +3,17 @@
>   * Copyright (c) 2015, Sony Mobile Communications AB.
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
>  
> -#include <linux/hwspinlock.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <linux/bug.h>
>  #include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_reserved_mem.h>
> -#include <linux/platform_device.h>
> +#include <linux/ioport.h>
>  #include <linux/sizes.h>
> -#include <linux/slab.h>
> -#include <linux/soc/qcom/smem.h>
> -#include <linux/soc/qcom/socinfo.h>
> +#include <soc/qcom/smem.h>
> +#include <soc/qcom/socinfo.h>
>  
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
> 
> -- 
> 2.53.0
> 
