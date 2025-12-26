Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2978BE8FDA6
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 10:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD9583980;
	Fri, 26 Dec 2025 11:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VPeF1G6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF3483980; Fri, 26 Dec 2025 11:30:11 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3468C83B95
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C8A30600AD;
 Fri, 26 Dec 2025 10:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B645C4CEF7;
 Fri, 26 Dec 2025 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766745007;
 bh=AZWlnLvESVoSH0qTBdtu8xMuxJNWxq07t7Mx3+IIpU4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VPeF1G6LUJcMbOOEZJisXgyyri49fiMwPvqIMMG5tlOzjBsCxkzzkPWH0Wka+CdTx
 DhZ8xSBPRFUlBrHnlxP9Aiv0YZDDHkijXE2Ddfejxw2x+U/wLw1bGGpbjSq2YDGjvU
 4oXs24DFCODhUemD86CW1BZtECTg6LzW0YuQ8SA290JBldQVcmpeeB8L0o9U5nEU1x
 0jIMstIdMr8UYGQA3Xe2N55zS7cEnH1ydJPA8vvrwih0XItMhZpfoOuYZms0a7pUOq
 pu9cl9av0ZwXQ8gMghCOu+iCf8weTm3qLhtqLtzN0hApKmrKZUMlOytMsMssUDW8zN
 OdltZAg7CphWQ==
Date: Fri, 26 Dec 2025 15:59:59 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock
 support
Message-ID: <aU5jp4CpXoDSgkHF@sumit-xelite>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114063804.3835132-3-balaji.selvanathan@oss.qualcomm.com>
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

On Fri, Nov 14, 2025 at 12:08:03PM +0530, Balaji Selvanathan wrote:
> Add GCC_AHB2PHY_WEST_CLK gate clock definition to the QCS615
> clock driver. This clock is required for proper PHY operation
> and eliminates clock-related warnings during USB initialization.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcs615.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..2b59c4d13fd 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
> +	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
> -- 
> 2.34.1
> 
