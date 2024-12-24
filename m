Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCADE7718D
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 13:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189C480711;
	Tue, 24 Dec 2024 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEfm/7ON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0153D80786; Tue, 24 Dec 2024 14:33:34 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70CB6802EF
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 14:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2167141dfa1so51123995ad.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735047210; x=1735652010; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+6DIyjqH9/SymuFk0f8/Umway3SPdkAQ1MElsBuGfbU=;
 b=BEfm/7ON0IIz5CGRDYt7ulqmqIqs0T+m3TJfEnwcDPzPlDp8YUXX03ImVneT4exRke
 1IQ3eQS0opnlq3+p3yfY2KI8xHNtQUdnNsPOqKggA9LCOVYrj294HBDjCGB4ijxToQzP
 ACgWoty4vxBr2BdUDL1vlB2ejEaXnlb9OQmzXZc2kDTuabhvWHkfSAu/DXBGiccnTngS
 IvJf1xkhW85qyKWOnQvU73CbCkucvTjrlmyuA8oTW8wEgopmj8nSHSviQE5Tx6WYMGZf
 8flPMY/nsFew8WUETnIXYAH5V8nYgAGy3/ebS0WzbJIRBwR0fBxY+jOaOSPs6iYTr97A
 dO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735047210; x=1735652010;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6DIyjqH9/SymuFk0f8/Umway3SPdkAQ1MElsBuGfbU=;
 b=TQ0e/EeYpNt0pIVZ4QRPBAxoYofjQF268DS1SchmL9QTy7zJ7L547BjDejO9FmAvPt
 9Sq8meI9AnpJCtfIbjsmEtzkBPiOJBRjV5RCHjZOY0s2Ru4o7eY/ZsTwPg563nlaCkUR
 6uK80aEJi2V/wixa3vBYAo11hgmtZVEr3+9Mz8ttI/u0a7IWQ1lNxjC7UA/oYlFdfRmD
 i7CaiWHIg7qPFkqplvvC28/vaFDjp0OtSZFJ846BODD+aXqLWbDI8ejdrwTRehcuZb/H
 j6TDCcVWQxK5R+zfnLuTidaLbpDi4cs8jLkSDdbejC2S5J5RSWE8wOhsqpzA2iYSlS5a
 KcWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2QhOlQVbl/4csHHFsYIeog+u1Cl0GmnGRlN2Jet4pUXrJCd8HjKHz03BNj/g7pLzL92TD70=@lists.denx.de
X-Gm-Message-State: AOJu0YxTZ+ThWRPMiSSfq/1PESX+wHxW+IPAe5MRmlt4suXTyM5PmGhU
 AR1vLPMrB335hTTmmt4nKbAcLukFwRsWR9GPfTczBsi7zVHmVoj9
X-Gm-Gg: ASbGncsBxEcuLWbbIzKwuFKZdvAnTWKnH1hDhxeNboHx8T0zGIS5nYCfc4g23OhyMj+
 cTEmje+sof6huWqsIRxrviGCTdLqvJrYe3663Oap/oYgT4KAyOJ08Crh9pDNrOcQjzxTkD87vOE
 fE/uUTj5pHeomc7STzyUYULcLTrhzKeFgjN/6ygLnXDgIVGoNEI9llqIqB+ptoYQs2RS8G3A2BT
 8MvSm4FkgsulDjNpRcAuaCK9oVulafInBpy20E9c4zUanhCnAVpSNSSS3lQYf4oON5rYg==
X-Google-Smtp-Source: AGHT+IG5cqt0vhi1LFt0n0sD6/l5YTG+WX7TMwA9i/9KL1JMBWHaly/RvpzYX+GEOY2NdFxY/84wQA==
X-Received: by 2002:a17:903:41c8:b0:215:8847:4377 with SMTP id
 d9443c01a7336-219e6cf8584mr263611665ad.15.1735047209801; 
 Tue, 24 Dec 2024 05:33:29 -0800 (PST)
Received: from joaog-nb ([2804:1b3:a803:dbee:62a6:d125:b6aa:ee66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4c06sm87491915ad.126.2024.12.24.05.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 05:33:29 -0800 (PST)
Date: Tue, 24 Dec 2024 10:33:21 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 joao.goncalves@toradex.com
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
Message-ID: <20241224133321.gzhoc6vzl4zag4qc@joaog-nb>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
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

On Fri, Dec 20, 2024 at 10:55:14AM +0800, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch adds i.MX95 19x19 EVK board basic support.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 ++++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/Kconfig                |   6 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
>  arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  54 +++++++
>  board/freescale/imx95_evk/spl.c               | 117 ++++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 178 ++++++++++++++++++++
>  doc/board/nxp/imx95_evk.rst                   | 109 +++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  36 +++++
>  15 files changed, 875 insertions(+)
> 
> diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..5c891518448d24204f5ca2a00957b47a0a24bd70
> --- /dev/null
> +++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifdef CONFIG_BINMAN
> +/ {
> +	binman {
> +		multiple-images;
> +
> +		m33-oei-ddrfw {
> +			filename = "m33-oei-ddrfw.bin";
> +
> +			nxp-append-ddrfw {
> +				oei_m33_ddr_image = "oei-m33-ddr.bin";
> +				lpddr_imem = "lpddr5_imem_v202311.bin";
> +				lpddr_dmem = "lpddr5_dmem_v202311.bin";
> +				lpddr_imem_qb = "lpddr5_imem_qb_v202311.bin";
> +				lpddr_dmem_qb = "lpddr5_dmem_qb_v202311.bin";
> +			};
> +		};
> +
> +		spl {
> +			filename = "spl.bin";
> +
> +			mkimage {
> +				args = "-n spl/u-boot-spl.cfgout -T imx8image";
> +			};
> +		};
> +
> +		u-boot {
> +			filename = "uboot.bin";
> +
> +			mkimage {
> +				args = "-n u-boot-container.cfgout -T imx8image";
> +			};
> +		};
> +
> +		imx-boot {
> +			filename = "imx-boot-imx95.bin";
> +			pad-byte = <0x00>;
> +
> +			blob-ext@1 {
> +				align = <0x400>;
> +				align-size = <0x400>;
> +				offset = <0x0>;
> +				filename = "spl.bin";
> +			};
> +
> +			blob-ext@2 {
> +				filename = "uboot.bin";
> +			};
> +		};
> +	};
> +};
> +#endif
> +
> +&{/soc} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&aips1 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&aips2 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&aips3 {
> +	bootph-pre-ram;
> +};
> +
> +&gpio1 {
> +	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
> +};
> +
> +&gpio2 {
> +	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
> +	bootph-pre-ram;
> +};
> +
> +&gpio3 {
> +	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
> +	bootph-pre-ram;
> +};
> +
> +&gpio4 {
> +	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
> +	bootph-pre-ram;
> +};
> +
> +&gpio5 {
> +	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
> +	bootph-pre-ram;
> +};
> +
> +&lpuart1 {
> +	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
> +	clock-names = "ipg", "per";
> +	bootph-pre-ram;
> +};
> +
> +&mu2 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&osc_24m {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&clk_ext1 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&sram0 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&scmi_buf0 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&scmi_buf1 {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@11} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@13} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@14} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@19} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart1 {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_100mhz {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_200mhz {
> +	bootph-pre-ram;
> +};
> +
> +&usdhc2 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_100mhz {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_200mhz {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_gpio {
> +	bootph-pre-ram;
> +};
> +
> +&reg_usdhc2_vmmc {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_reg_usdhc2_vmmc {
> +	bootph-pre-ram;
> +};
> +
> +&elemu3 {
> +	compatible = "fsl,imx93-mu-s4";
> +	status = "okay";
> +	bootph-all;
> +	bootph-pre-ram;
> +};
> +
> +&wdog3 {
> +	status = "disabled";
> +};

Hi Alice,

Would it be possible to factor out the common parts of the U-Boot
SPL/Pre-relocation device tree into an imx95-u-boot.dtsi file, like
U-Boot already has for imx8mp/imx8mm? From what I understand, the binman
configuration and some DT nodes (e.g. soc, aips*, scmi*, elemu*,
gpio2-5) are required on all boards, as they are bus parent nodes or
needed by the SoC implementation.

In the downstream kernel, there are already other boards apart from the
EVK (e.g., Verdin-EVK), and we’re also working on a new SoM family
(Toradex SMARC iMX95). Having the common parts factored out would make
things more organized and easier to upstream.

Best regards,
João Paulo
