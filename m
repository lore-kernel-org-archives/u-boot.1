Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AC0D78786
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 14:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF80080077;
	Fri, 19 Dec 2025 15:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XGg6XYQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFCF7803F5; Fri, 19 Dec 2025 15:41:44 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B518180050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 15:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A45540D5E;
 Fri, 19 Dec 2025 14:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BAAC4CEF1;
 Fri, 19 Dec 2025 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766155300;
 bh=8UPPg1KnyPkKQYhhd7Oi7TyuLcv5qFG6uBFj9LlDNlc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XGg6XYQsLzgFdBqz9uE/PwpXc7CkWFFRiEID2gAZ7hCSlJJNStSuaEcnajo/MUwgp
 fX2iSQjOcXgGgas5GghOoxoU8504Otryah7ge7f6e8UWUZt5UlPiCld+ih4XLurGXM
 057Pj8zodcMrINyFR8yPVt0ZKUI/jvdEyeSIWupyzVOKx/ziifYEfOMtVw93vkrt0w
 0DUyIDV94lgZNieWdFW9wdAQq5mwvpaIZPIh4X/ygEphnIdu3ZfUqVlm5T8t+NNTOA
 aF6C7d49VIdIVrtL+5q6I0Krq9FxmygyfGjLEs7CJB41ydS0t3ZXvii+/IhSLXw4ox
 adi0KpFyMMcSA==
Date: Fri, 19 Dec 2025 20:11:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 5/6] dts: ipq9574-rdp433-u-boot: Enable USB device
 mode and MMC
Message-ID: <aUVkGe7PSVF5wble@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-6-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061557.1999367-6-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Dec 18, 2025 at 11:45:56AM +0530, Varadarajan Narayanan wrote:
> Enable MMC and USB device mode by default to be able to use
> fastboot for flashing images to IPQ9574 based boards.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> index 390e2338d65..9f04c0c1077 100644
> --- a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> +++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> @@ -22,4 +22,10 @@
>  	 * reset done sdhci_init() times out.
>  	 */
>  	resets = <&gcc GCC_SDCC_BCR>;
> +
> +	status = "okay";

Why it's not enabled in upstream kernel DT?

> +};
> +
> +&usb_0_dwc3 {
> +	dr_mode = "peripheral";

I suppose then you would rather want "otg" mode in upstream DT which
will default to "peripheral" in U-Boot. And in Linux you should then be
able to support both modes.

-Sumit

>  };
> -- 
> 2.34.1
> 
