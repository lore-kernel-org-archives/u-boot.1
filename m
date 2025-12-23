Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71163E6F06C
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 08:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACB183F64;
	Tue, 23 Dec 2025 09:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MPZHYGyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2CD83FD4; Tue, 23 Dec 2025 09:31:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6837583C28
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4914060122;
 Tue, 23 Dec 2025 08:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B2C113D0;
 Tue, 23 Dec 2025 08:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766478676;
 bh=NjYRSr3u0WbeDlPN8/T2ueVItecU9+q7y9RF4xtKPRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MPZHYGyIheHKDbYsJrIUo/QNTtflu6Z7Z0ygWeMFIoGF4yjLf6AF0LOCNCN5q8LN4
 q/QIrDbTcNyK0MvvhxxHlQtGkoFAjb6pwt/AsAxAil7Sp/TQ/0i1AduiaDSaGu16Ll
 6FHnV8/HlvZVA3a6oy9t7SPU9BOaIZGiQoquPNgNyY5YSaT/2VlBnuTl09Z8sX12D2
 hjmbui7LofiI/sPiC0b4XmiiXFnewJUCyERLiRkv/Ye6yCJmXXcZmzwicijd13qUma
 PVJ0CX+HHD0aQ2JeNlvGsF9q083ydFA9uA7hqM6KmCcKhfEh4HU8lnBg+59QLL0Dae
 Ts8Pl/NETDIlg==
Date: Tue, 23 Dec 2025 14:01:00 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 peng.fan@nxp.com, alif.zakuan.yuslaimi@altera.com,
 kory.maincent@bootlin.com, sjg@chromium.org,
 jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/7] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
Message-ID: <aUpTRLIiiJ1YLzNz@sumit-xelite>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-2-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124155503.2839766-2-balaji.selvanathan@oss.qualcomm.com>
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

On Mon, Nov 24, 2025 at 09:24:57PM +0530, Balaji Selvanathan wrote:
> Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
> the USB3 PHY on SC7280/QCM6490 platforms.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/clock-sc7280.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 55a233df394..a2af73cd976 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
>  	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
>  	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
>  	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
> -- 
> 2.34.1
> 
