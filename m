Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B1DD3CCB3
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042D682C7F;
	Thu, 15 Jan 2026 08:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="itPNzMjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE6F83015; Thu, 15 Jan 2026 08:06:56 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B2680077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A720960167;
 Thu, 15 Jan 2026 07:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9E3C116D0;
 Thu, 15 Jan 2026 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768460813;
 bh=fBVfzxX9kb4wJE6OfTRzusSAfZ1aGUr2YwyCBIeaQrA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=itPNzMjAhiclFuLkENkR2n9nk4ZKdp3vxYiLPu2o2r+bJrhAdMqbkPQKHrGpPw516
 ZdTdBfnKXGk8U3kzj/5w+hvkilO7wzkA7yfXFL2NPf+M1LCiG2XQFVVl8cS1oOz1ip
 Hhb209YhhYzEfq5ac8DQduEZkqlJupJUsAltgCki0WWMtVJtZe/CZOyI9bZ3wbFdKw
 Cpvs4biekF9IC8xgN3om3fL1YqdQCBGTHWOfRoQTrZ41tU9Hlbrhosf9snHePLbeNN
 i07DHXFoAOlOC8HcdQEJfSYErna6H1/IR/dPGOCcUQ8Ua/RwCTSkCbSU6+Skp7uFuD
 SoRBaN66KSgYQ==
Date: Thu, 15 Jan 2026 12:36:45 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru,
 danila@jiaxyga.com, david.wronek@mainlining.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] qcom_defconfig: Remove redundant pinctrl driver
 selections
Message-ID: <aWiSBZtLMGzAkT8m@sumit-xelite>
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
 <20260107154745.571319-3-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107154745.571319-3-aswin.murugan@oss.qualcomm.com>
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

On Wed, Jan 07, 2026 at 09:17:45PM +0530, Aswin Murugan wrote:
> Enable PINCTRL_QCOM_GENERIC config
> The pinctrl drivers are now automatically enabled via Kconfig
> defaults based on PINCTRL_QCOM_GENERIC, so explicit selection in the
> defconfig is no longer needed.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Enable newly added PINCTRL_QCOM_GENERIC config
> ---
>  configs/qcom_defconfig | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index aa3902f5627..fe5880de1fd 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -113,24 +113,7 @@ CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>  CONFIG_PHY_QCOM_SNPS_EUSB2=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
> -CONFIG_PINCTRL_QCOM_APQ8016=y
> -CONFIG_PINCTRL_QCOM_APQ8096=y
> -CONFIG_PINCTRL_QCOM_QCM2290=y
> -CONFIG_PINCTRL_QCOM_QCS404=y
> -CONFIG_PINCTRL_QCOM_QCS615=y
> -CONFIG_PINCTRL_QCOM_SA8775P=y
> -CONFIG_PINCTRL_QCOM_SC7280=y
> -CONFIG_PINCTRL_QCOM_SDM670=y
> -CONFIG_PINCTRL_QCOM_SDM660=y
> -CONFIG_PINCTRL_QCOM_SDM845=y
> -CONFIG_PINCTRL_QCOM_SM6115=y
> -CONFIG_PINCTRL_QCOM_SM6350=y
> -CONFIG_PINCTRL_QCOM_SM7150=y
> -CONFIG_PINCTRL_QCOM_SM8150=y
> -CONFIG_PINCTRL_QCOM_SM8250=y
> -CONFIG_PINCTRL_QCOM_SM8550=y
> -CONFIG_PINCTRL_QCOM_SM8650=y
> -CONFIG_PINCTRL_QCOM_X1E80100=y
> +CONFIG_PINCTRL_QCOM_GENERIC=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_DM_REGULATOR=y
> -- 
> 2.34.1
> 
