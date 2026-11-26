Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B4606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wo7k5bjI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrEJ3w/N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFB8360A82;
	Thu, 26 Nov 2026 13:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mB631AITLyNh; Thu, 26 Nov 2026 13:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ECC42608E6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795701072;
	b=lS5K5+7KavZAyPwyreZslTc1yM1Kr812TF9k7XLTPQYXWuFkHICRuv04lgcYJ46GBxME
	 2X1YVZRezv5imZ+lexbtDdU/J2aaoKnTI8B0uPqEGaHLPOzKRbetWa3sfglSX8bNSvy+D
	 WYLHDCLsOipeeMoL6A7MSJHZM+BF/C2EGnWbC81XzAZOGqpZE/QS0Mm6Ny/54VHrpr1EL
	 kacXOpmYLIIQpLqrkcMOFPqbGrBxA2IYgoyxkQxZ4IFIrDq4KVHtQ5VfR96lBV0dRpQXy
	 tzQQtQqQCArd85nXLe/1JWv3bTwQ+7/lK63juzZBAjLrGjjIkIJOLltsEkS2WzEyO/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qMtWGFsPpbebQhcpN07TxK3x28J1y1SIwiujIMg2ZYY=;
	b=pUpm11GHWIeSKKTFPMAFhqoYsmN6S4QWQy6i3TfxPjgbdoBDSIykKLqBcVGWWuZ2+NhE
	 TazoyWNmM36zKYw0dpvz2qQ5rcOibkhYYQUw8ph2W+EJ63hcEVbfRwm8aaB+lfk52CFai
	 5hwbFvpD3w4RYtPEqUD1maqJ96RfwPouFat0Dun4sexc9CkGKsHs+oyJkbinZXAEdoZno
	 eaH9B3Nwu4/d16dXK/D8ecAL9/3PVbpCtP2eVza6yZdZOoeBRaGdb7+GAz9LFn0/U9K//
	 p8J8CuRd+UeonQRV8nqkk8XvzynazrcVq4O0bcd+oH2Ay8Yw29+wdMCMICUqAwEZMkg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795701072;
	bh=qMtWGFsPpbebQhcpN07TxK3x28J1y1SIwiujIMg2ZYY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wo7k5bjIKw6wDHIP8+xMzsmaXPONw5ECFHo3WqO6P3CLau1ycUge2Pdz1neOyusTf
	 q8GZN3NtnN02oDEfIvmmAV0Bovyd6nYrFw51wfDfSMylz6GfHR09PaPC7ayx7XNKjB
	 vM0B2zfSNBKZbSN0aWv8vUuoHzehhpnxIs8WRFoLfYD4dGlJ0h6GPV8hfi638HbNuq
	 597SZk+02rAys/Qb5eyw3E4wqyY5n3iDNjdoNFIiMC9NO3BaKsIN0Um9kcvYkWHzwx
	 Krfyxj3D//8lBz5RUOJaMS4mEeKQmwESMD3Gn8mibzrUTK8toD3ajE73io+MEG4yT4
	 tq7fNyggizulQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECC42608E6;
	Thu, 26 Nov 2026 13:51:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7697E311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6822640907
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0kJXhgYZTRI for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C24F9408E1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RrEJ3w/N
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C24F9408E1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:51:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A83A46000;
 Thu, 26 Nov 2026 13:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE891F000D4;
 Thu, 26 Nov 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701068;
 bh=qMtWGFsPpbebQhcpN07TxK3x28J1y1SIwiujIMg2ZYY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=RrEJ3w/Nbe/GDss9FGY/1akKx1Gxn2eNbBe1AoG0su3YmmyGlsGY2A5FrKGpPTyMv
 vnBj3e6rm/9LgAF3eLsCFdhniH21JK65iAP/+y/Yolme5fZC6aybtJduUUdDjwtFa0
 CPDgCn88gZBqzKpXy3UyzP5GboVfYprQLpPMliTC9sDX/+weCKcxihy3IbZ/MDn+Y+
 RAaUT/xeqEyD+ldWLf5rgLanzD9PtEqEAmM+AUTuXfQRAMGh5qeezbJFtqsZlIug4o
 JfAuBFbaHOh0DttUgzF2Y8VdPU/1WFTBiG5kuDC9SinwdBZGiOG3VhupqXhHykt5uH
 5cXOElc+xGWig==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: qcom: qcs615: add USB2 secondary controller
 clocks and GDSC
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261116-qcs615-usb2-clocks-v1-1-ad6256a70eb3@oss.qualcomm.com>
References: <20261116-qcs615-usb2-clocks-v1-1-ad6256a70eb3@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:21:03 +0530
Message-Id: <179570106317.130558.113202621256360784.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-16 17:19 +0530, Balaji Selvanathan wrote:
> Add the GCC clocks and power domain needed to bring up the secondary
> USB2 (HS only) controller.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcs615.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index d7fb6abfd25..21a4bbb415c 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -18,6 +18,8 @@
>  #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
> +#define USB20_SEC_MASTER_CLK_CMD_RCGR		0xa601c
> +#define USB20_SEC_MOCK_UTMI_CLK_CMD_RCGR	0xa6034
>  
>  #define UFS_PHY_AXI_CLK_CMD_RCGR		0x77020
>  #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x77048
> @@ -113,6 +115,14 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_USB20_SEC_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000, "Unexpected rate for USB20_SEC_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB20_SEC_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return rate;
> +	case GCC_USB20_SEC_MASTER_CLK:
> +		WARN(rate != 120000000, "Unexpected rate for USB20_SEC_MASTER_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB20_SEC_MASTER_CLK_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0);
> +		return 120000000;
>  
>  	case GCC_UFS_PHY_AXI_CLK:
>  		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
> @@ -158,6 +168,12 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0), 0xf054),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
>  	GATE_CLK_POLLED(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0), 0x8c014),
> +	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_SEC_AXI_CLK, 0xa609c, BIT(0), 0xa609c),
> +	GATE_CLK_POLLED(GCC_USB20_SEC_MASTER_CLK, 0xa6010, BIT(0), 0xa6010),
> +	GATE_CLK_POLLED(GCC_AGGRE_USB2_SEC_AXI_CLK, 0xa6084, BIT(0), 0xa6084),
> +	GATE_CLK_POLLED(GCC_USB20_SEC_SLEEP_CLK, 0xa6014, BIT(0), 0xa6014),
> +	GATE_CLK_POLLED(GCC_USB20_SEC_MOCK_UTMI_CLK, 0xa6018, BIT(0), 0xa6018),
> +	GATE_CLK_POLLED(GCC_USB2_PRIM_CLKREF_CLK, 0x8c028, BIT(0), 0x8c028),
>  	GATE_CLK_POLLED(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0), 0x6a004),
>  
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
> @@ -241,6 +257,7 @@ static const struct qcom_reset_map qcs615_gcc_resets[] = {
>  
>  static const struct qcom_power_map qcs615_gdscs[] = {
>  	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB20_SEC_GDSC] = { 0xa6004 },
>  	[USB30_PRIM_GDSC] = { 0xf004 },
>  };
>  
> 
> ---
> base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
> change-id: 20261116-qcs615-usb2-clocks-ec13e6cd0ccb
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


