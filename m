Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ADEE77166
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB84E88EA3;
	Wed,  4 Dec 2024 01:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XPMultp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E813D891E4; Wed,  4 Dec 2024 01:18:45 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4C188E42
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241204001837epoutp025f758d78d66692d96d2b61ce2f0086eb~N0UMHB5K30160701607epoutp028
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:18:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241204001837epoutp025f758d78d66692d96d2b61ce2f0086eb~N0UMHB5K30160701607epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733271517;
 bh=eK4xCTPZQfT38tH04QaD92MKdrkRFcIuznx1zZz/GC4=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=XPMultp3cvLycyMp2jzE9PuFAAFUENekRU72Wr/aY2AR0/f0xE/MpriuOcJXhjtvj
 DT2937yOQXK3nwrB1VlewHZAsTLkyQhC+MpprNmh/9F4Rfml0Zfc2FwzLUnsxYnC0r
 u7jxs+S1ph8uSFzr5W+UNAlL+wWsNTCXyMRixkmo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241204001836epcas1p22d672ccb884d784fc74006f8c2ecd13b~N0ULQVePO2605026050epcas1p2N;
 Wed,  4 Dec 2024 00:18:36 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Y2ymW3D7fz4x9Pv; Wed,  4 Dec
 2024 00:18:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 A4.18.24218.BDF9F476; Wed,  4 Dec 2024 09:18:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241204001834epcas1p13794d4af1200d70ee4cdb66b5565f9a0~N0UJ2JEXT2406624066epcas1p1L;
 Wed,  4 Dec 2024 00:18:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241204001834epsmtrp2ad5bb5ec28da1398c5d833a2bc3bed4e~N0UJ0WaQC0327803278epsmtrp2b;
 Wed,  4 Dec 2024 00:18:34 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-1e-674f9fdb4908
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7C.3D.18729.ADF9F476; Wed,  4 Dec 2024 09:18:34 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241204001834epsmtip1d872dc446146ed063f3a772d0fed9fea~N0UJgNXdv1043010430epsmtip1C;
 Wed,  4 Dec 2024 00:18:34 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <bigunclemax@gmail.com>
Cc: "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 "'Tom Rini'" <trini@konsulko.com>, "'Wei Fu'" <wefu@redhat.com>, "'Yixun
 Lan'" <dlan@gentoo.org>, "'Peng Fan'" <peng.fan@nxp.com>, "'Ilias
 Apalodimas'" <ilias.apalodimas@linaro.org>, "'Simon Glass'"
 <sjg@chromium.org>, "'Jerome	Forissier'" <jerome.forissier@linaro.org>,
 "'Sughosh Ganu'" <sughosh.ganu@linaro.org>, "'Greg Malysa'"
 <greg.malysa@timesys.com>, "'Linus	Walleij'" <linus.walleij@linaro.org>,
 "'Raymond Mao'" <raymond.mao@linaro.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, "'Kongyang Liu'" <seashell11234455@gmail.com>, "'Marek
 Vasut'" <marek.vasut+renesas@mailbox.org>, "'Jonas Karlman'"
 <jonas@kwiboo.se>, "'Wei Liang Lim'" <weiliang.lim@starfivetech.com>, "'Kuan
 Lim Lee'" <kuanlim.lee@starfivetech.com>, <u-boot@lists.denx.de>
In-Reply-To: <20241201150704.44462-3-bigunclemax@gmail.com>
Subject: RE: [PATCH v1 2/3] riscv: dts: t-head: Add sdhci and emmc nodes
Date: Wed, 4 Dec 2024 09:18:34 +0900
Message-ID: <000701db45e2$0e92aaa0$2bb7ffe0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKWNLOKvs2bV1RfzKy+BBIXkYaGAIPIOUdAeLYv++0V4I+kA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRjv3Lt7d9dpmTvLEsdlArw5FEw8Fhc8lFSik5dklDEbxzJxh70t
 xL7aXUCrabYJec0a8rIBRBACCiOSeArsylIqAlY+YI3HFAiByztRnFJi92L13+873/f7fr/v
 O+fwcdEkIeEnaoyMXiNXUcQGTnO3f2DgUNleZUiGRYyuPm4i0MhwHYZ6l+wcdCLtLxz9dLyS
 h3pmbnFQdsM8hgr+rsHQ8a+HCbRSe4+LZqZKuWh2qh+gS98u8tD9xmaARge8UWHe9zw025nF
 Q2nWAg6a7yjhoe7CBYDGbQ7sNQ+6o7cYp0tMv3DoGw9mcLqteIRHLywepu9erOXRV05ex+jh
 gQ6C7h9uBXRbiQWjz8+1YvS85RZBD/UL6c6WFSzW7e2kbQmMXMHofRlNvFaRqFFGUrvfjNsR
 FxYeIg2URqCtlK9GrmYiqZ0xsYGvJ6rW5qZ8U+Sq5LWjWLnBQAW/sk2vTTYyvglagzGSYnQK
 lS5MF2SQqw3JGmWQhjG+JA0JCQ1bKzySlFB+s4Sn+8HjaPO4g2MCk2Q2EPAhKYONvTUgG2zg
 i8hWAHPrx3hssARgxRdN68F9ADPKq7FswHdRHNcCnGwR2Qlg+R8pbM00gGO96cCZIMgguFpx
 FndiMekFTz1qcEngZB8BmxbnXQkB+TK0X+13YXeShmNZlS4yh9wM83rOcZ1YSEbAtro7XNar
 L3w4Uc1lm0bBCUsfx4lxUgxLstJxpwAkcwRw1NSBs4Sd0GY9R7DYHd693MhjsQT+OddJsITP
 AKz6sovLBmYAH5sG1xlboLUq3zUzTvrD+gvBrJobnFs2c9lVCGFmuoit3gyvO6axJ/1H7qyu
 m6ZhxWA1YNdlBbC148BJ4FP8P9/F/wmUA6wWPMPoDGolY5DqZP9eZbxW3QBcDz4AtYLS2YUg
 G8D4wAYgH6fEwpr63UqRUCE/9iGj18bpk1WMwQbC1jaZi0s84rVrP0ZjjJPKIkJk4aFbZEga
 LqU8hX03UxgRqZQbmSSG0TH6JzyML5CYsLJNRXu9HJdPvSBOSx0PuzB1tpdSDyn8n1uu+S7n
 4bHUg4oJzUR0bk6e49kfP+j22VUVvb88I3jp4L4xP7/VfFnaCrDH/lZWpE20PE1MVGGHCoN/
 naR+T7rXwLy/6S3gOSco+iRKV3DgvZZXT8dQoe7TX3W962VvD/bU197+uHH1RI/6THhspiGp
 1Kz/fDqybo/dnNqVIxofbfe5vRzlc+nwflH7o7ZxVfqRfbjVthy9fYcotCGreP6a28/PRwRk
 un/jl+1t5dzAP/J+kFo5OHvR7pUn+XRrV615QJI7JaDqtl8xcfjnd9WdeefQGy+KKa4sVTfV
 fFRlMbdsNNbkx2xMBk9RHEOCXBqA6w3yfwBpqAZJeQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnO6t+f7pBr/Xm1ic+reVzeLunbVM
 Fqc/3WCx6G35zWxxvnUxu8XJN1dZLLo2vWeymPJnOZNF68o7bBY/Vn1htXjzYi6rxdsXZxkt
 jq37yG7xbcs2Rot71+Qspk7azG7xdm8nu0XL/iksFu/3zGa3ODz1A6PF40OvmRxEPfacnsXs
 MbvhIovH5e9vmD12zrrL7vHhY5zHqwOr2D1OTLjE5HHn2h42j7N3djB67Jy9j8lj47sdTB7v
 911l87h9ltdj7/YfTAF8UVw2Kak5mWWpRfp2CVwZC67MZi84Ilqx7fFrlgbGZwJdjBwcEgIm
 Eq/PaXUxcnEICexmlJixuoOti5ETKC4l8fnpVDaIGmGJw4eLIWqeM0q8mzGTGaSGTUBP4v+i
 hWC2iIC0xLS/mxhBipgF7rBJfPl7mxFu6r/meSwgVZwC1hI3Tp0F6xAW8JB41LmYEcRmEVCR
 mHRyNSuIzStgKbFz7RNWiCsUJH4+XcYKscFJ4um+M2BzmAVEJGZ3tjFPYBSYhcRdwMi4ilEy
 taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOEK1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe5eu9
 04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwbUxnOcsk
 v1XM8vSL49Iywr2M/0WbLKX+RL3K0+1lrY41v7pfQKj08B+GJdWXKr60XjjNLKl9MixmbW/4
 VDnLIPPtf4U/iLFeVj1VEKvJYSGSuWuvyNQ1F9du+/bJ3ZZdbgOHvdA5vl11n3eeLTXZ//lF
 fIRbt6DPa+0AvX8Tn+qE2PRpq/C0quxYU6996YrnnwTbKwlVa1YwPEk+f+6aW7jpbaPlcRfa
 jt254LH1t4KTwNvml+E7T8+sK/DZqdB18YR1xMT82pIb816sWyZ39ZJOg0Py3mVnF2598WLN
 L86yzSsuBPvU6R29nKC0967L3frQpC3zTv495s+uLyMvxdu34eWVGV2qQapG/xfLKLEUZyQa
 ajEXFScCAF+oHMk/AwAA
X-CMS-MailID: 20241204001834epcas1p13794d4af1200d70ee4cdb66b5565f9a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241201150732epcas1p3d8f36c50d8a0a8c220f63912d3904672
References: <20241201150704.44462-1-bigunclemax@gmail.com>
 <CGME20241201150732epcas1p3d8f36c50d8a0a8c220f63912d3904672@epcas1p3.samsung.com>
 <20241201150704.44462-3-bigunclemax@gmail.com>
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



> -----Original Message-----
> From: bigunclemax@gmail.com <bigunclemax@gmail.com>
> Sent: Monday, December 2, 2024 12:07 AM
>
> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> Add SDHCI and EMMC controlles nodes on TH-1520 SoC. And enable them for
> Lichee module 4A.
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung>

Best Regards,
Jaehoon Chung

> ---
>  arch/riscv/dts/th1520-lichee-module-4a.dtsi | 18 +++++++++++
>  arch/riscv/dts/th1520.dtsi                  | 34 +++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/arch/riscv/dts/th1520-lichee-module-4a.dtsi b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
> index dc00e3dfa0..86a81bdcf7 100644
> --- a/arch/riscv/dts/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
> @@ -32,3 +32,21 @@
>  &uart_sclk {
>  	clock-frequency = <100000000>;
>  };
> +
> +&emmc {
> +	bus-width = <8>;
> +	max-frequency = <198000000>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&sdio0 {
> +	bus-width = <4>;
> +	max-frequency = <198000000>;
> +	status = "okay";
> +};
> diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
> index d68c446a6b..9378de89c5 100644
> --- a/arch/riscv/dts/th1520.dtsi
> +++ b/arch/riscv/dts/th1520.dtsi
> @@ -141,6 +141,13 @@
>  		#clock-cells = <0>;
>  	};
>
> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <198000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -206,6 +213,33 @@
>  			status = "disabled";
>  		};
>
> +		emmc: mmc@ffe7080000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7080000 0x0 0x10000>;
> +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
> +		sdio0: mmc@ffe7090000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7090000 0x0 0x10000>;
> +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
> +		sdio1: mmc@ffe70a0000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe70a0000 0x0 0x10000>;
> +			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
>  		uart1: serial@ffe7f00000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0xff 0xe7f00000 0x0 0x100>;
> --
> 2.45.2



