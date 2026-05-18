Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A650CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D8983EF9;
	Mon, 18 May 2026 14:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d+nUDKyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8C58460E; Mon, 18 May 2026 14:53:27 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3BA83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A7D7D438D7;
 Mon, 18 May 2026 12:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD95C2BCB8;
 Mon, 18 May 2026 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779108803;
 bh=KnKY1VDgaF5D6JZhMZK+EX6DjJgBHiJ2c5tuYTLW8P0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d+nUDKyxu1ayN95guXrnsKAGRt2+YDguBZO2tRK5Cf7PpJ0HnoDrLt3wx6uZm3W5E
 M0axv4wRNzcZhDhpaiJXdYc7iW+xzXzERRVZC5lqFLgDidbS4fnrMfjAvGnvcEGpuA
 bRKRnhOgts5OwEghlf2Nt3gf/n+74CiUrLfJ0pjhG+7EJaenaJQCtAewaHnyYvgwqj
 e5U0lAemOil7yYux/IVyxCeJcG0zi8yZlWiDMbPLLbFjrTC/aoc+smKt7uEj4RRfLb
 Mn8eE7UsXDCcK9bmeOBnt1vewmqsMp95BWcCfNjtxETJOsgXTABuQQsB6y8GuMRFQg
 xiNLJBW7KFcGg==
Date: Mon, 18 May 2026 18:23:12 +0530
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
Subject: Re: [PATCH v2 11/15] soc: qcom: smem: add build infra
Message-ID: <agsLuDcrd5t7aK5q@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-11-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-11-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:39PM +0200, Casey Connolly wrote:
> Build the new SMEM driver port, and select it when ARCH_SNAPDRAGON is
> selected, since it will be a hard dependency for Qualcomm platforms.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig  | 8 ++++++++
>  drivers/soc/qcom/Makefile | 1 +
>  2 files changed, 9 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8243805e46a3..cdd9e30f43e5 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -24,5 +24,13 @@ config QCOM_RPMH
>  	help
>  	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
>  	  if you need to control regulators on Qualcomm platforms, say y here.
>  
> +config QCOM_SMEM
> +	bool "Qualcomm SMEM support"
> +	help
> +	  Say y here to support the Qualcomm SMEM (shared memory) client driver.
> +	  SMEM is a shared memory region that is used to pass information about
> +	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
> +	  staged and the OS. If in doubt, say y.
> +
>  endif # SOC_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 78fae8bbfa16..f4102f9155a8 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>  obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
> +obj-$(CONFIG_QCOM_SMEM) += smem.o
> 
> -- 
> 2.53.0
> 
