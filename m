Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959DEF48F3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383A183015;
	Fri, 13 Feb 2026 10:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bi0Ohucp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011AA83936; Fri, 13 Feb 2026 10:15:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8DD80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7819A6132B;
 Fri, 13 Feb 2026 09:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E35C16AAE;
 Fri, 13 Feb 2026 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770974119;
 bh=hvTvlY9SoseIwh34Yctu0HN5ACzyFmqknCWDcMav3uw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bi0OhucptjEb7d3/XZ6EP0KKnHuBTZvQoyXsUmgrJvyGDIVnWgEUA3Eojr0Hnnwxy
 OzYAZejxpTSiVFJ6Il7ao99J51D/Go1SzghCVSosqjT+HX1Mqcn3ylkVHxRB3g+tRn
 6dwt5t9aUh5u/5AOJ3xdizxX9dE5ElL5SkYIq7VPmUiM24SOGu8pJX3oLaAzI9d5hU
 pCBaj5UptPvUbpYepCEtoTraHMJThgO7Pov0jkyWmZbYXk//ZZSNCz+IISsJZf1XOR
 34bSTOO7i+W1U8Jr+w8AkhO9iwRafu1OUol6GMcXvIAjzfgJaqp4C/Adi5G9nE96Ds
 pTg0M9w/6MKkw==
Date: Fri, 13 Feb 2026 14:45:11 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: [PATCH 1/3] clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK
 support
Message-ID: <aY7rnzQvYkiOV65V@sumit-xelite>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
 <20260213-talos_usb-v1-1-4c4355d61437@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-talos_usb-v1-1-4c4355d61437@oss.qualcomm.com>
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

On Fri, Feb 13, 2026 at 02:31:18PM +0530, Balaji Selvanathan wrote:
> Add support for GCC_USB3_PRIM_CLKREF_CLK to the QCS615 clock driver.
> This clock is referenced in the device tree USB node but was not
> implemented in U-Boot, causing "Clock 152 not found" warnings during
> fastboot run.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Add support for GCC_USB3_PRIM_CLKREF_CLK to the QCS615 clock driver.
> - Removed the logic of removing GCC_USB3_PRIM_CLKREF_CLK from DTS node
> 
> Changes in v2:
> - No changes in v2
> ---
>  drivers/clk/qcom/clock-qcs615.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..65b8db04020 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
> 
> -- 
> 2.34.1
> 
