Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC386C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5A683118;
	Fri, 18 Apr 2025 15:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="C76oPn1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD13F83121; Fri, 18 Apr 2025 15:41:30 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC138304C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3889A25D16;
 Fri, 18 Apr 2025 15:41:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wr4G1aVCa44a; Fri, 18 Apr 2025 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744983687; bh=c8+aq3PCnjWuORzJzIzFTHgcVVgfRhIdzm8ptAez0wU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C76oPn1hNFKztJttwJSXLwObX1OkEUDbACCiiF1naIUfbt/PwZkwW1fw27Ujn9EzN
 AINDiXLNIBm4s6NPSkSYhGBrXIlTvj+pBSJ6873bEEi6Zo/ralJoi2zPp7rxfD11bM
 Km6E7TaMAwQDZFxzg3evDCsqA/bGoy8XDxoZQBgXrKTjulBvvoDuZrX75ZpFMcltOV
 NaaoWexG80lBmcEAnmZrBo/lK6CHaapsi9qphe52FjUAHPZVK1nVawyFrvtYEDE8xw
 SOdm9rblAod4rXCAeUgxhL/ukRvsEuOHW7Jxp8I+uSqfd7yUetuEstGeRXfm0sGO+7
 B9gHjIA0fm1nA==
Date: Fri, 18 Apr 2025 13:41:13 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, E Shattow <lucent@gmail.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: dts: jh7110: add bootph-pre-ram for &pllclk
Message-ID: <aAJWeYJxo2IYwDR_@pie.lan>
References: <20250330162421.238483-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330162421.238483-1-heinrich.schuchardt@canonical.com>
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

On Sun, Mar 30, 2025 at 06:24:21PM +0200, Heinrich Schuchardt wrote:
> Since commit f98cd471f06b ("clk: clk-composite: Resolve parent clock by
> name") the StarFive VisionFive 2 board fails to boot.
> 
> Before that patch the SPL debug UART showed warnings like:
> 
>     clk_register: failed to get pll0_out device (parent of perh_root)
>     clk_register: failed to get pll0_out device (parent of qspi_ref_src)
>     clk_register: failed to get pll0_out device (parent of usb_125m)
>     clk_register: failed to get pll0_out device (parent of gmac_src)
>     clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
>     clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
> 
> The &pllclk clock needs to be enabled early.
> 
> Fixes: f98cd471f06b ("clk: clk-composite: Resolve parent clock by name")
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/jh7110-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Yao Zi <ziyao@disroot.org>

Sadly this didn't catch up with v2025.04, in which JH7110 SoCs are
broken...

> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
> index ce7d9e16961..a9e318c4a31 100644
> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> @@ -102,6 +102,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&pllclk {
> +	bootph-pre-ram;
> +};
> +
>  &syscrg {
>  	bootph-pre-ram;
>  };
> -- 
> 2.48.1
> 

Thanks,
Yao Zi
