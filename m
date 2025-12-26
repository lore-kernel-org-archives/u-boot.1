Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ABDE8FDA6
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 10:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983768412A;
	Fri, 26 Dec 2025 11:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g99NV5q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4648415E; Fri, 26 Dec 2025 11:22:54 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B1883B95
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20C944036C;
 Fri, 26 Dec 2025 10:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC695C4CEF7;
 Fri, 26 Dec 2025 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766744569;
 bh=Lnad35AYdtUj5qm+dEh6VThBL93e26m6fJLeppJJCmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g99NV5q7FJ1hnPrp7WUhT0jLsIPP4PbrNohGi6yBcOC5P5uJtKRerbIiQ4TCsUUpA
 aobtKhvv+8FrN6MbKstLvIBg0xOcEdNMf1cCXfe8VDTieryAuTN6axhTEexUS11sRH
 3LKHwgNwlyEj8Q6IUcTQcx9YoMyLSW2MaowgJKBiDIs/tFHU/0TK/pnQdnNNxr+bUf
 2VBCza4DK1llUuIR3xpXuXTmW4jae5AFuEy/lAmFXuTniTTGG9GQDOQ2vacxnrUwcs
 AlZwo2HlsKwxhVoKnJAtKakywOiwRd6Ma3EtwkZnNgijeiPnv9IxoLRySjf3gy67TM
 Ih9mC7TKWy1Kw==
Date: Fri, 26 Dec 2025 15:52:41 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 1/3] arm: dts: qcs615-ride: Remove unsupported USB
 clock reference
Message-ID: <aU5h8TrvG7GALEMc@sumit-xelite>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-2-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114063804.3835132-2-balaji.selvanathan@oss.qualcomm.com>
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

On Fri, Nov 14, 2025 at 12:08:02PM +0530, Balaji Selvanathan wrote:
> Remove GCC_USB3_PRIM_CLKREF_CLK from the USB controller node as it is
> not implemented in the U-Boot clock driver. Keep only the supported
> clocks to avoid clock warnings during boot.

Rather than overriding DT, why can't this be implmented in U-Boot? And
how why it isn't an essential clock for U-Boot operation?

-Sumit

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> index 68fffc70fcb..d8af124cc27 100644
> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,18 @@
>  		      <0x0 0xc0000000 0x0 0xc0000000>,
>  		      <0x1 0x80000000 0x1 0x00000000>;
>  	};
> +	soc@0 {
> +		/* Remove GCC_USB3_PRIM_CLKREF_CLK from usb_1 node to avoid U-Boot clock warnings */
> +		usb_1: usb@a6f8800 {
> +			/delete-property/ clocks;
> +			/delete-property/ clock-names;
> +			/* Keep only the clocks that are implemented in U-Boot clock driver */
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
> +		};
> +	};
>  };
> -- 
> 2.34.1
> 
