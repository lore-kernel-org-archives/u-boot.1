Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC00AC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 06:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2177832EA;
	Mon, 11 Aug 2025 08:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NqfYFfo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6083E832F0; Mon, 11 Aug 2025 08:18:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7E6830F6
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E1DE943BD5;
 Mon, 11 Aug 2025 06:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D4C4CEED;
 Mon, 11 Aug 2025 06:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754893107;
 bh=dy6PpldQ6Tz8EC5JEWbVy1HOpoXlxzlvbKkui0wGm2M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NqfYFfo9frm+Lwa2LNqXfyfW9yQ0OUG/FKH7W653kLAoAGZF058uxoED/MYHIc94Z
 H0sG+DwASRI2LdqQa0aH17FuDT+Z5wBTxu7OxHT6WJEY7gxe5n6rcYLU83s1Vn1z5b
 T0OvbL4HeJWD301GvA9mACdmRa26B0ZfiB6Hh2LV5BLieDnPhfEutCjptSUPB2rXbI
 qUAMQuWv+FylgKUopuLf8raACyRGvpbmzHzQggfaRrcls0/LPEjmJ8vGld1T0rjyeS
 jp+MHtSV9EwureR4dN97b1xFLOWem6UiPaSXyse+5BWyh35kOSVamvVr2+Jp/dOKEl
 eWqv7ldbKKQtw==
Date: Mon, 11 Aug 2025 11:48:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] phy: qcom: Fix ret is uninitialised
Message-ID: <aJmLLmHvK7UNBNwF@sumit-X1>
References: <20250806-phy_qcom_snps-v1-1-5cda830026c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-phy_qcom_snps-v1-1-5cda830026c7@linaro.org>
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

On Wed, Aug 06, 2025 at 05:55:04PM +0100, Andrew Goodbody wrote:
> In qcom_snps_eusb2_phy_probe after the call to devm_clk_get if an error
> is found then ret is printed but has not been assigned to by the code.
> Decode the error from the pointer and assign it to ret.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/phy/qcom/phy-qcom-snps-eusb2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
> index b2655ac007c..28502c46f67 100644
> --- a/drivers/phy/qcom/phy-qcom-snps-eusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
> @@ -331,8 +331,9 @@ static int qcom_snps_eusb2_phy_probe(struct udevice *dev)
>  
>  	qcom_snps_eusb2->ref_clk = devm_clk_get(dev, "ref");
>  	if (IS_ERR(qcom_snps_eusb2->ref_clk)) {
> +		ret = PTR_ERR(qcom_snps_eusb2->ref_clk);
>  		printf("%s: failed to get ref clk %d\n", __func__, ret);
> -		return PTR_ERR(qcom_snps_eusb2->ref_clk);
> +		return ret;
>  	}
>  
>  	ret = reset_get_bulk(dev, &qcom_snps_eusb2->resets);
> 
> ---
> base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
> change-id: 20250806-phy_qcom_snps-3134f2c95276
> 
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
> 
