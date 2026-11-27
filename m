Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D7606A327
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aaVBwk+Y;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=aIa1uz1t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2322D81183;
	Fri, 27 Nov 2026 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjFDiFy-E4IU; Fri, 27 Nov 2026 11:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99F0A81161
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795778809;
	b=inWy2impgPH2hUnqfKRIU2+IhKOuhleaQSheg+c8CbCkuucRy04IrPObS15TZsq3nQoa
	 77hLDyugttkqWqKNuKZH9dczgmDTAP0w7VwuF1aDTlZXkl5gaYt4XKXH/rBsxYQrAXL+8
	 PW7tuua+BibsyeOvVslkVMld+x8vwcD+1xqqTaieG4gYdsDa3OUeCd5dd3kglMJSTphGG
	 0ZbAR+oHB3SXov+5DzfsqvNCDHI/EP7v8MQqZrGIhAkm8/d/ozX9hla1XruN6SziZuWdR
	 KOUtrM1ax7Jjcdg2UsL3M0xLAxy3cMWZZiBf0llVb8vybUKlFvNYFpzqViZk8LT28BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795778809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=76PpeCxrAuhY43OBPP4FBY77bpr00Sa44BXAFEcL/GA=;
	b=Y9aX0UfXhVqc5MfCU7gMAiZyRGMRhwiylglIWsEVV2z/LwIUkAowO874wSsr6ZfQ8ZWR
	 zRCntXhHOvHKkTzo4bQzADxs6zU7fYHwbVq7+7pOz7nS2KkCTxdEOdzYIpFciJ9woUOrw
	 Lv0AUUpUUxA7EO/iofH4OPsw2v0qQRZFL5PCyfLGt6IH7JXBmem95vD947CDRST5l7Vqr
	 cWFBJdEOP9uHZvAp9O2hGkRtYMmfLHI45pjRYoEbF0/a/QVlmSVnsu9aZbCfyxcpDlr1I
	 Iq89gOdqMrH6AGsfCJR+Y7ZHIHcnaGzKDVMYR2dAnMI6M007f482l9AHyjFbd23wntw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795778809;
	bh=76PpeCxrAuhY43OBPP4FBY77bpr00Sa44BXAFEcL/GA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaVBwk+Y33GiDhia7cVKDxxMdFCuzjnwpR2kF56P49WS1fDdd/8o8/bg6RWD3FMrM
	 XganvWpH4EznI6I32TDgClX/O6qPgiLDr65c2pUvy2o/jfR9gKdste7gAwkwClVWzp
	 GgezAbn6tkrWL9IAs/9ybLF3tmTDIg0NGQ7aUo+SGDVCyqYxdziPgxHNEmZsnvj7FR
	 2sJKSnr0InrkIzLr9CI8ZKivIftB04QfNEFOKIc//5rHkpm/L2BndKrXffMHbG0j7t
	 Up8hp86zxIlsDFgczbyLPKNrcO+jCIB/XK0KaHiqG0RvTOZyDHsbP2GwJCyuVs9mgA
	 gaFPc7Aq+dltg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99F0A81161;
	Fri, 27 Nov 2026 11:26:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D90AD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7CE060AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23qc_XOck6DG for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EA7560AAF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aIa1uz1t
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EA7560AAF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795778771;
 bh=76PpeCxrAuhY43OBPP4FBY77bpr00Sa44BXAFEcL/GA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aIa1uz1tVV7lMy4JapLPJ1ZO11P2LdJgSrWnF1eHHiMHY79ZEkuH1yNKxRvd7vaFt
 7DqDyf8zZTOtzO5JwzWGAOFuAYCQtjjZa4egyJh0acyAmKz1z1/hWn59aAuVsZ2hZn
 qv3agRtPfZ9HfIKAtV4f6SwgNPZf2RIYQE5p5BCyHBG3NrcAAd6ss7enrL/F5Zzp43
 vT8MatazFesMQyejxpTks7l0Y1LbS1ZtsjW6+t1C0KIWFOS0r78lP+ne44wFazTXtV
 J6Jon2p1ytvlugvMLzEUZc3FmQeZ02KAe+DCPjjHX44I0gtXrfrtZtYX4vIj5TW5Z0
 UQg5ymbMfTpiA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 536F2B221938;
 Fri, 27 Nov 2026 12:26:08 +0100 (CET)
Message-ID: <3c8b9195-6d18-4399-b1bd-e6ac1ad37246@freeshell.de>
Date: Fri, 27 Nov 2026 03:26:05 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] riscv: dts: spacemit: k1: Move common U-Boot
 properties to shared DTSI
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-4-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

On 11/27/26 02:30, Anand Moon wrote:
> Move common U-Boot device tree properties from the Banana Pi F3
> and MusePi Pro board-specific DTSI files into spacemit-k1-u-boot.dtsi.
> 
> Consolidate early boot properties for UART, clocks, I2C, eMMC and
> SDHCI controllers to reduce duplication between the boards.

No, this "reduce duplication" increases the duplication of work in
future and likely broken outcome, also making git bisect confusing to
compare. If a node sits in k1-bananapi-f3.dts devicetree-rebasing and
needs a bootph-pre-ram hint then it should get the override in u-boot
k1-bananapi-f3-u-boot.dtsi; if there is e.g. "k1-common.dtsi" included
by *some* boards' dts then it is still per-board and not
spacemit-k1-u-boot.dtsi specific, for u-boot override purposes. What I
can think of that should be in spacemit-k1-u-boot.dtsi u-boot override
are k1.dtsi specific nodes.

If they are indeed common then upstream would have consolidated this
firstly. I would accept a link to LKML discussion where such
"consolidation" has been reviewed and queued for-next in the case where
you are implementing this here knowing that, for development cycle
schedule considerations, it is going to be the same as the shape of
upstream development that has not yet been applied in a merge window for
the Linux development cycle.

> 
> Also move the clock configuration for the MPMU and APBC system
> controllers into the shared DTSI.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 54 ----------------
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 79 -----------------------
>  arch/riscv/dts/spacemit-k1-u-boot.dtsi    | 76 ++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 133 deletions(-)
> 
> diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> index bc117f5987a..4e9f2c13203 100644
> --- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> @@ -3,50 +3,6 @@
>   * Copyright (C) 2026 RISCstar Ltd.
>   */
>  
> -&uart0 {
> -	bootph-pre-ram;
> -};
> -
> -&osc_32k {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_1m {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_3m {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_24m {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_mpmu {
> -	bootph-pre-ram;
> -};
> -
> -&pll {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_apmu {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_apbc {
> -	bootph-pre-ram;
> -};
> -
> -&i2c2 {
> -	bootph-pre-ram;
> -
> -	eeprom@50 {
> -		bootph-pre-ram;
> -	};
> -};
> -
>  /*
>   * The kernel pmic@41 nodes use the standard regulator-* properties only.
>   * The SPL board code looks up the bucks that DDR training depends on by
> @@ -77,13 +33,3 @@
>  		};
>  	};
>  };
> -
> -&emmc {
> -	bootph-pre-ram;
> -	max-frequency = <204800000>;
> -};
> -
> -&sdhci0 {
> -	bootph-pre-ram;
> -	max-frequency = <204800000>;
> -};
> diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> index ddea04a8e3e..834d9f46b48 100644
> --- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> @@ -3,75 +3,6 @@
>   * Copyright (C) 2026 RISCstar Ltd.
>   */
>  
> -#include <dt-bindings/clock/spacemit,k1-syscon.h>
> -
> -/ {
> -	aliases {
> -		console = &uart0;
> -	};
> -};
> -
> -&syscon_mpmu {
> -	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
> -		 <&pll CLK_PLL1_D4>;
> -	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
> -		      "pll1_d4";
> -};
> -
> -&syscon_apbc {
> -	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
> -		 <&pll CLK_PLL1_D4>,
> -		 <&syscon_mpmu CLK_PLL1_31P5>,
> -		 <&syscon_apmu CLK_PMUA_ACLK>;
> -	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
> -		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
> -};
> -
> -&uart0 {
> -	bootph-pre-ram;
> -};
> -
> -&osc_32k {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_1m {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_3m {
> -	bootph-pre-ram;
> -};
> -
> -&vctcxo_24m {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_mpmu {
> -	bootph-pre-ram;
> -};
> -
> -&pll {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_apmu {
> -	bootph-pre-ram;
> -};
> -
> -&syscon_apbc {
> -	bootph-pre-ram;
> -};
> -
> -&i2c2 {
> -	bootph-pre-ram;
> -
> -	eeprom@50 {
> -		bootph-pre-ram;
> -		status = "okay";
> -	};
> -};
> -
>  &i2c8 {
>  	bootph-pre-ram;
>  	status = "okay";
> @@ -112,13 +43,3 @@
>  		status = "okay";
>  	};
>  };
> -
> -&emmc {
> -	bootph-pre-ram;
> -	max-frequency = <204800000>;
> -};
> -
> -&sdhci0 {
> -	bootph-pre-ram;
> -	max-frequency = <204800000>;
> -};
> diff --git a/arch/riscv/dts/spacemit-k1-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
> index 0d92edf9fc1..c084e15cb94 100644
> --- a/arch/riscv/dts/spacemit-k1-u-boot.dtsi
> +++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
> @@ -3,11 +3,87 @@
>   * Copyright (C) 2026 RISCstar Ltd.
>   */
>  
> +#include <dt-bindings/clock/spacemit,k1-syscon.h>
> +
>  / {
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
>  	};
> +
> +	aliases {
> +		console = &uart0;
> +	};
> +};
> +
> +&syscon_mpmu {
> +	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
> +		 <&pll CLK_PLL1_D4>;
> +	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
> +		      "pll1_d4";
> +};
> +
> +&syscon_apbc {
> +	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
> +		 <&pll CLK_PLL1_D4>,
> +		 <&syscon_mpmu CLK_PLL1_31P5>,
> +		 <&syscon_apmu CLK_PMUA_ACLK>;
> +	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
> +		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
> +};
> +
> +&uart0 {
> +	bootph-pre-ram;
> +};
> +
> +&osc_32k {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_1m {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_3m {
> +	bootph-pre-ram;
> +};
> +
> +&vctcxo_24m {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_mpmu {
> +	bootph-pre-ram;
> +};
> +
> +&pll {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_apmu {
> +	bootph-pre-ram;
> +};
> +
> +&syscon_apbc {
> +	bootph-pre-ram;
> +};
> +
> +&i2c2 {
> +	bootph-pre-ram;
> +
> +	eeprom@50 {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&emmc {
> +	bootph-pre-ram;
> +	max-frequency = <204800000>;
> +};
> +
> +&sdhci0 {
> +	bootph-pre-ram;
> +	max-frequency = <204800000>;
>  };
>  
>  #include "spacemit-k1-binman.dtsi"

As above, changes requested please.

-E
