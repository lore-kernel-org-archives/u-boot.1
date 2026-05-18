Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CDCD4F50
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DB683EF9;
	Mon, 18 May 2026 15:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZ0DWlLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A9B83FEE; Mon, 18 May 2026 15:15:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31AC83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 281CB41B24;
 Mon, 18 May 2026 13:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB825C2BCB7;
 Mon, 18 May 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779110115;
 bh=oPlgFCJmKSWD26iUI+qj19O3zxL/YGN88hM/L/RIB1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bZ0DWlLDUTV156GTzp9uoI9aKZCv+VBVLGfOiN55wFD/vfVfhH4G6vK2r9nAlf6hh
 2StpMpwNBupnHIUxoBsf4/Pc3igP2xX8VJE001bW8OXvGUWxMQP/Gz4VKX3yfv1s5K
 VbHts3ANnBKXc2N8IPAfJT2datYgQUQf1HMVBc3M6BLKIlVQBvAEW1E22em41XJGbS
 bw3XdigVKlF9SVdE34XyGXpIgLmkDZrNMQPqzzHr7VNHldznkRfXvdEOJMHa/7AUIi
 L9xTuerNXr+XCYZwv1bQDnto2OAyMb76GQY/D6ZjTfp8OFME5C/Yv4UskD7yH+n1od
 xspx3QPM9izQA==
Date: Mon, 18 May 2026 18:45:03 +0530
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
Subject: Re: [PATCH v2 14/15] mach-snapdragon: fetch serial# from SMEM
Message-ID: <agsQ12o-onyqT3vS@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-14-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-14-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:42PM +0200, Casey Connolly wrote:
> If available, otherwise fall back to cmdline.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 7610891191fd..63055a60af44 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -31,8 +31,9 @@
>  #include <fdt_support.h>
>  #include <usb.h>
>  #include <soc/qcom/smem.h>
>  #include <sort.h>
> +#include <soc/qcom/smem.h>
>  #include <time.h>
>  
>  #include "qcom-priv.h"
>  
> @@ -251,11 +252,16 @@ static const char *get_cmdline(void)
>  }
>  
>  void qcom_set_serialno(void)
>  {
> -	const char *cmdline = get_cmdline();
> +	const char *cmdline;
>  	char serial[32];
>  
> +	if (!qcom_socinfo_init())
> +		return;
> +
> +	cmdline = get_cmdline();

I would suggest to merge this whole patch into patch#9 when the SMEM
based support is added.

> +
>  	if (!cmdline) {
>  		log_debug("Failed to get bootargs\n");
>  		return;
>  	}
> @@ -473,8 +479,11 @@ int board_late_init(void)
>  	else
>  		memcpy((void *)addr, (void *)gd->fdt_blob,
>  		       fdt32_to_cpu(fdt_blob->totalsize));
>  
> +	/* Initialise SMEM if it wasn't done already and ensure it's memory is mapped */
> +	qcom_smem_init();

It's rather better to move this SMEM init to where it's actually used as
part of qcom_socinfo_init(). That way it's easier to track dependency.

-Sumit

> +
>  	configure_env();
>  	qcom_late_init();
>  
>  	qcom_show_boot_context();
> 
> -- 
> 2.53.0
> 
