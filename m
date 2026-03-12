Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2A0FED2E1
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A21D83F9A;
	Thu, 12 Mar 2026 08:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LkVyalQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115D183F9A; Thu, 12 Mar 2026 08:49:31 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2871D83F8A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF71A60054;
 Thu, 12 Mar 2026 07:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7631C4CEF7;
 Thu, 12 Mar 2026 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301767;
 bh=TYqtizPQvLw6sBHBu6CitoM/8185MTD0k9lVaP6FJcs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LkVyalQwjJmXWXNx85XN9JeU7LyRDr+9OyZ9NPlkub4irkqdxMlZLNpsf/VK/Y0Aa
 8Nr+I20Dono6Gsxuf0ECDbL/siCOGuPHcdVYqQj0XndKiyPOQtzjMstGf8OzPClpeH
 C2sHypJC8ImJeOpUYAo/S5cSyGVmDFUCkukDPtE8jv5Sbx4vfMGP+aujT/Nz1aoIkq
 NrLdOsEr9y9NddEe6xi4BjthI/NKd0ctoSTqZDyqAzoCLBlB1f3H02J50sKLgt/KKA
 eijz4GdItNqHjbVG3BefXqcO5edRlNpIDSH8qFG66P7+RZijCLX9U9fJ7RNZ8DYGHp
 WGOqoGlhhKxFw==
Date: Thu, 12 Mar 2026 13:19:18 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 5/7] gpio: qcom: Support GPIOs on PM7550 PMIC
Message-ID: <abJv_muULwwZ_78R@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-5-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-5-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:45PM +0100, Luca Weiss wrote:
> The GPIOs on PM7550 work fine using the qcom_spmi_gpio driver and
> enables the use of the Volume Up button on the Fairphone (Gen. 6)
> smartphone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpio/qcom_spmi_gpio.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index 1a7c7c48dfc..77a69140213 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -747,6 +747,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>  	{ .compatible = "qcom,pm6350-gpio" },
>  	{ .compatible = "qcom,pm660l-gpio" },
>  	{ .compatible = "qcom,pm7325-gpio" },
> +	{ .compatible = "qcom,pm7550-gpio" },
>  	{ .compatible = "qcom,pm8550-gpio" },
>  	{ .compatible = "qcom,pm8550b-gpio" },
>  	{ .compatible = "qcom,pm8550ve-gpio" },
> 
> -- 
> 2.53.0
> 
