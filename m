Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B3CC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 20:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12078811F;
	Thu, 29 Feb 2024 21:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mUVKx2pV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373C388121; Thu, 29 Feb 2024 21:50:26 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A50B88119
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 21:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=krzk@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6DC7D6130E;
 Thu, 29 Feb 2024 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD51C433F1;
 Thu, 29 Feb 2024 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709239822;
 bh=9gWe/9QdHbp8CAct8/iqyJFuthrBnM9nVpOm096KfwI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mUVKx2pV/TU5KRVz/9IPc0z6BN+A4pa3sZ/MhuwCo6twPZ4vXC/IeslnMTJwpblFa
 /PwyyvlWZpFru7clb7lPbvaraAwmdwAkokbSvR/R+uNQobeSfi+q893J+qlbMTbn/i
 UI9ll288B0ah5P6zvIcNbnmNSOX5DyUYFOBOd4Ge/3OTc8laCH3F7zr+y0LZthcrGC
 nAzFBE995XoOCwFmk9ulovJmydV/1o5v9aFmaZNU2gJ9PtMTro0Nz66KsxsQBKuEhs
 OUok4PqHFAnl7tvRQv+xC/zTFsrHauF43fm984sTHJxO8ZWA83txeSXVDWT+WYuwO/
 imRQ/g3wo+gnA==
Message-ID: <4fa5cede-def3-4ad0-8433-72495e4c8e3b@kernel.org>
Date: Thu, 29 Feb 2024 21:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mach-snapdragon: Add support for IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-2-quic_varada@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240226100807.1095607-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 26/02/2024 11:07, Varadarajan Narayanan wrote:
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/ipq9574-default.dts              |  167 +++
>  arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
>  arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
>  .../include/mach/sysmap-ipq9574.h             |  252 ++++
>  arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
>  board/qualcomm/ipq9574/Kconfig                |   15 +
>  board/qualcomm/ipq9574/Makefile               |    4 +
>  board/qualcomm/ipq9574/board_init.c           |  326 ++++
>  board/qualcomm/ipq9574/ipq9574.c              |  170 +++
>  board/qualcomm/ipq9574/ipq9574.h              |   75 +
>  board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
>  board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
>  drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
>  include/configs/ipq9574.h                     |  111 ++
>  include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
>  include/dt-bindings/net/qti-ipqsoc.h          |   20 +
>  include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
>  include/dt-bindings/reset/ipq9574-reset.h     |   54 +
>  20 files changed, 4266 insertions(+)
>  create mode 100644 arch/arm/dts/ipq9574-default.dts
>  create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
>  create mode 100644 arch/arm/dts/ipq9574.dtsi
>  create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
>  create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
>  create mode 100644 board/qualcomm/ipq9574/Kconfig
>  create mode 100644 board/qualcomm/ipq9574/Makefile
>  create mode 100644 board/qualcomm/ipq9574/board_init.c
>  create mode 100644 board/qualcomm/ipq9574/ipq9574.c
>  create mode 100644 board/qualcomm/ipq9574/ipq9574.h
>  create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
>  create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
>  create mode 100644 drivers/clk/qcom/clock-ipq9574.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
>  create mode 100644 include/configs/ipq9574.h
>  create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
>  create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
>  create mode 100644 include/dt-bindings/reset/ipq9574-reset.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d9725030d5..8931dfa2aa 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1523,6 +1523,8 @@ dtb-$(CONFIG_ARCH_QEMU) += qemu-arm.dtb qemu-arm64.dtb
>  dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
>  				corstone1000-fvp.dtb
>  
> +dtb-$(CONFIG_TARGET_IPQ9574) += ipq9574-rdp433-mht-phy.dtb
> +
>  include $(srctree)/scripts/Makefile.dts
>  
>  targets += $(dtb-y)
> diff --git a/arch/arm/dts/ipq9574-default.dts b/arch/arm/dts/ipq9574-default.dts
> new file mode 100644
> index 0000000000..501c9492df
> --- /dev/null
> +++ b/arch/arm/dts/ipq9574-default.dts
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	config_name = "config-default";
> +
> +	aliases {
> +		console = &blsp1_uart2_console;
> +		uart2 = &blsp1_uart3_additional;
> +		sdhci = &mmc;
> +	};
> +
> +	soc: soc {
> +		tlmm: pinctrl@1000000 {
> +
> +			sdhci_pinmux: mmc {
> +				pinconfig;
> +				emmc_data {

No, please use upstream DTS.

You imported here a lot of vendor junk. There is no way this will pass
any System Ready tests if you hand over this DTB to Linux. Plus really,
that's ugly DTS to look at.

I am not a maintainer of DTS in U-Boot, so up to the folks here, but I
really recommend to NAK such DTS. It just re-adds all the issues we
fixed in upstream kernel!

I suggest using dts/upstream/qcom, but if you cannot then please import
kernel DTS.

Best regards,
Krzysztof

