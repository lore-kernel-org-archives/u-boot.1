Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD96C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 09:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D5281760;
	Tue, 17 Jun 2025 11:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RWyNe+6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB21182B0F; Tue, 17 Jun 2025 11:49:26 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FEB080C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 90307A4EBC5;
 Tue, 17 Jun 2025 09:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB1C4CEE3;
 Tue, 17 Jun 2025 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750153762;
 bh=v3GrJ5LAz2q8QPoiYZRsdn9heSZNcj9wSQIG0TLXOoA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RWyNe+6Mgj4bYRZCkvC3572E0AaBrzt7TxRWJ7KWgqmm2B7xS5yuoTUeg8gdIBipf
 GBAq5zB4Fjlg4CBDnjGWW45MyofL4BqBdTukBYwoQS9UN8OWmwVPiPgQ2RvboLe5Bp
 YW1m6ZqbeOMEELiLilBehM9XLk7Ua+MnfRizZqi6KofLrudvYDCHBnJz0N/+zygv2o
 CzWXAZpqWWkj480fZWwNLw+5vmMO3kMNjyvxJFxj7nMnPhEkCyM+O/r04tzMsMkGKJ
 UvmHEfzJzTjWb5Ie148iSqdpiINeoS+vVKgo9rngsmvU+zZc2lAzcsuzOhwUG8y4yT
 SOnB1tJDS4ytA==
Date: Tue, 17 Jun 2025 15:19:16 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v4 7/9] WIP: rb3gen2: describe micro-usb port
Message-ID: <aFE6HP629Ocg3Fj6@sumit-X1>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
 <20250616-geni-load-fw-v4-7-e7df44205505@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-geni-load-fw-v4-7-e7df44205505@linaro.org>
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

Hi Casey,

On Mon, Jun 16, 2025 at 11:44:49AM +0200, Casey Connolly wrote:
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

I suppose this is an unrelated change to the patch-set and I don't think
this patch as it is applied upstream since the manual patch isn't
allowed for dts/upstream subtree. You can rather have a *-u-boot.dtsi
for this change.

-Sumit

> 
> diff --git a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..a9689f126cc7f94a01921fe2dc70efb83774610a 100644
> --- a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
> +++ b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
> @@ -881,8 +881,25 @@
>  
>  	status = "okay";
>  };
>  
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "peripheral";
> +	/delete-property/ usb-role-switch;
> +};
> +
> +&usb_2_hsphy {
> +	vdda-pll-supply = <&vreg_l10c_0p88>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +	vdda33-supply = <&vreg_l2b_3p072>;
> +
> +	status = "okay";
> +};
> +
>  &usb_dp_qmpphy_out {
>  	remote-endpoint = <&redriver_phy_con_ss>;
>  };
>  
> 
> -- 
> 2.49.0
> 
