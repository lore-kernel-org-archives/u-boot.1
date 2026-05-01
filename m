Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3ECCD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73B2842D7;
	Fri,  1 May 2026 14:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BgTo3+c8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1991A80F0E; Fri,  1 May 2026 09:35:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CFC80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A867A405FB;
 Fri,  1 May 2026 07:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81712C2BCB4;
 Fri,  1 May 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777620942;
 bh=hJ14pFGaPavw6Aor/Qaz5TbNx9T5MOTagFZWZB/c8xM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BgTo3+c8iVIszRFmwxpVVVdbF+vocIoqLe18V7KnyHWDHOXs+LLH9uhSMD9F36UUa
 tXtsmQqK0nF9VtYSJJ//DL1IwhnR8RjKRmVv/sb2sves8l8Ffed3OflLy8+5nuuIU6
 5m69eDiUTT+6QfleXQeq4fkjoCI7bBy53YfUILQVSzlxUSDxIzhiEIGiQxAUTWKkbO
 /58bo5rOYizfI815uaaKZcJheHTWP0h6agYLP7R+FW0njB3k2pUoN2YtCwqrt8NV02
 ZZgAOEgWv2Tq2rQxOrR4xNr8Oz89dJWr09X1pTUXFelJEYqengSn5iGWE135JGpIpF
 WT3pGOwIGs32g==
Date: Fri, 1 May 2026 13:05:25 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v4 11/11] dts: add u-boot specific sdm845 .dtsi and a
 .dtsi for shift-axolotl
Message-ID: <afRXvbwdCbz_TQeb@sumit-xelite>
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-11-8cf4133ff883@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-qcom_spl-v4-11-8cf4133ff883@seznam.cz>
X-Mailman-Approved-At: Fri, 01 May 2026 14:38:15 +0200
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

On Sun, Apr 26, 2026 at 01:26:13AM +0200, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> The board .dtsi just includes the SoC-specific .dtsi, which
> adds bootph-all markings to upstream dts nodes which are
> needed in SPL.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi |  2 ++
>  arch/arm/dts/sdm845-u-boot.dtsi               | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
> new file mode 100644
> index 00000000000..d41210ab23a
> --- /dev/null
> +++ b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "sdm845-u-boot.dtsi"
> diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
> new file mode 100644
> index 00000000000..b029264555b
> --- /dev/null
> +++ b/arch/arm/dts/sdm845-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +&gcc {
> +	bootph-all;
> +};
> +
> +&usb_1_hsphy {
> +	bootph-all;
> +};
> +
> +&usb_1_dwc3 {
> +	bootph-all;
> +};
> +
> +&rpmhcc {
> +	bootph-all;
> +};

Can we have these DT overrides posted to upstream kernel board DTS?

-Sumit
