Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06DDC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81E487F25;
	Thu, 14 Mar 2024 05:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389750;
	bh=CCTq2lYxuVaBTVAZ1kDXcMLK5VgHawjlkcADNiFuUhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUTK0nl65wRZkZxPYgIm2bhWKw8z82v5UO4x1yI2ak1XlVR0995LS8gBzne7J6pJH
	 U4CEkCTKR949syUsvziEN/PU3Pin69Jw3kJzlANwR+wt/zMZc2/AkLwb6wA1tqr5am
	 dovRCkJzvIu6q2dUgHWnSdH+rbdQqRSqjmXG/9UI2uDb2rBbrMu80o/g/e7AthPeTt
	 rp/VuAPxM40tTD/xWRng64YkOsK9ymcuNcRCfL8oTl4Vi2yBKtrXpizsq8BgYoFfGx
	 w41dpqkMzQ5k79mjfJSmqpzK273QIEiXx0aD8ZJIqSE8oG34tK8phKtzlUZpd+dhPm
	 DWGT6h7NlHMrg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 90CD287EE3;
 Thu, 14 Mar 2024 05:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389750;
 bh=CCTq2lYxuVaBTVAZ1kDXcMLK5VgHawjlkcADNiFuUhI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fIt7TK1VLenDE1g4PS33ao/y9fQZDmSnMvo9xlG/SKTqXXnLNeAJjg8auHg3Ph9vH
 LQPwTiAMR6BoBdj7oOoJ/TOHnw6HmwV0t/Z9ygyuVgxCEOTjB+RPguE0HMmqRGI3zL
 ak/p6VHyMcbhtTg0I5T42EfRwO3siCsgXdNVXY8wsBzOY84fuQkz5vBn1nKXMmibnW
 4pwMYm/VsET+6QfU3jH90RVXnF6KFpuS89syj/NL6/v6mC68n/Shp5HQXgsHkI4uSi
 uSogxqmyJ4j0gGceySUR7V73vZvV4pzJTN+4OxgJ1Zw8+JPkES+KogUvuWztYyeX0+
 RKeKZBRMR0Tzg==
Message-ID: <c86c5713-97c7-4ce6-bb75-15dcb3fcdcee@denx.de>
Date: Thu, 14 Mar 2024 04:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] reset: imx: Add support for i.MX8MP reset
 controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-4-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-4-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/12/24 8:03 AM, Sumit Garg wrote:
> Add support for i.MX8MP reset controller, it has same reset IP inside
> as the other iMX7 and iMX8 variants but with different module layout.

iMX8M , iMX8 is a different SoC .

> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/reset/reset-imx7.c. Use last Linux kernel driver reference
> commit bad8a8afe19f ("reset: Explicitly include correct DT includes").
> 
> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/reset/reset-imx7.c | 101 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 4c7fa19d495..90d3d75255e 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -10,6 +10,7 @@
>   #include <dm.h>
>   #include <dt-bindings/reset/imx7-reset.h>
>   #include <dt-bindings/reset/imx8mq-reset.h>
> +#include <dt-bindings/reset/imx8mp-reset.h>

Keep the list sorted (P is before Q).

>   #include <reset-uclass.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> @@ -252,6 +253,102 @@ static int imx8mq_reset_assert(struct reset_ctl *rst)
>   	return 0;
>   }
>   
> +enum imx8mp_src_registers {
> +	SRC_SUPERMIX_RCR	= 0x0018,
> +	SRC_AUDIOMIX_RCR	= 0x001c,
> +	SRC_MLMIX_RCR		= 0x0028,
> +	SRC_GPU2D_RCR		= 0x0038,
> +	SRC_GPU3D_RCR		= 0x003c,
> +	SRC_VPU_G1_RCR		= 0x0048,
> +	SRC_VPU_G2_RCR		= 0x004c,
> +	SRC_VPUVC8KE_RCR	= 0x0050,
> +	SRC_NOC_RCR		= 0x0054,
> +};
> +
> +static const struct imx7_src_signal imx8mp_src_signals[IMX8MP_RESET_NUM] = {
> +	[IMX8MP_RESET_A53_CORE_POR_RESET0]	= { SRC_A53RCR0, BIT(0) },
> +	[IMX8MP_RESET_A53_CORE_POR_RESET1]	= { SRC_A53RCR0, BIT(1) },
> +	[IMX8MP_RESET_A53_CORE_POR_RESET2]	= { SRC_A53RCR0, BIT(2) },
> +	[IMX8MP_RESET_A53_CORE_POR_RESET3]	= { SRC_A53RCR0, BIT(3) },
> +	[IMX8MP_RESET_A53_CORE_RESET0]		= { SRC_A53RCR0, BIT(4) },
> +	[IMX8MP_RESET_A53_CORE_RESET1]		= { SRC_A53RCR0, BIT(5) },
> +	[IMX8MP_RESET_A53_CORE_RESET2]		= { SRC_A53RCR0, BIT(6) },
> +	[IMX8MP_RESET_A53_CORE_RESET3]		= { SRC_A53RCR0, BIT(7) },
> +	[IMX8MP_RESET_A53_DBG_RESET0]		= { SRC_A53RCR0, BIT(8) },
> +	[IMX8MP_RESET_A53_DBG_RESET1]		= { SRC_A53RCR0, BIT(9) },
> +	[IMX8MP_RESET_A53_DBG_RESET2]		= { SRC_A53RCR0, BIT(10) },
> +	[IMX8MP_RESET_A53_DBG_RESET3]		= { SRC_A53RCR0, BIT(11) },
> +	[IMX8MP_RESET_A53_ETM_RESET0]		= { SRC_A53RCR0, BIT(12) },
> +	[IMX8MP_RESET_A53_ETM_RESET1]		= { SRC_A53RCR0, BIT(13) },
> +	[IMX8MP_RESET_A53_ETM_RESET2]		= { SRC_A53RCR0, BIT(14) },
> +	[IMX8MP_RESET_A53_ETM_RESET3]		= { SRC_A53RCR0, BIT(15) },
> +	[IMX8MP_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
> +	[IMX8MP_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
> +	[IMX8MP_RESET_SW_NON_SCLR_M7C_RST]	= { SRC_M4RCR, BIT(0) },
> +	[IMX8MP_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
> +	[IMX8MP_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
> +	[IMX8MP_RESET_SUPERMIX_RESET]		= { SRC_SUPERMIX_RCR, BIT(0) },
> +	[IMX8MP_RESET_AUDIOMIX_RESET]		= { SRC_AUDIOMIX_RCR, BIT(0) },
> +	[IMX8MP_RESET_MLMIX_RESET]		= { SRC_MLMIX_RCR, BIT(0) },
> +	[IMX8MP_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR, BIT(2) },
> +	[IMX8MP_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
> +	[IMX8MP_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
> +	[IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
> +	[IMX8MP_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
> +	[IMX8MP_RESET_MEDIA_RESET]		= { SRC_DISP_RCR, BIT(0) },
> +	[IMX8MP_RESET_GPU2D_RESET]		= { SRC_GPU2D_RCR, BIT(0) },
> +	[IMX8MP_RESET_GPU3D_RESET]		= { SRC_GPU3D_RCR, BIT(0) },
> +	[IMX8MP_RESET_GPU_RESET]		= { SRC_GPU_RCR, BIT(0) },
> +	[IMX8MP_RESET_VPU_RESET]		= { SRC_VPU_RCR, BIT(0) },
> +	[IMX8MP_RESET_VPU_G1_RESET]		= { SRC_VPU_G1_RCR, BIT(0) },
> +	[IMX8MP_RESET_VPU_G2_RESET]		= { SRC_VPU_G2_RCR, BIT(0) },
> +	[IMX8MP_RESET_VPUVC8KE_RESET]		= { SRC_VPUVC8KE_RCR, BIT(0) },
> +	[IMX8MP_RESET_NOC_RESET]		= { SRC_NOC_RCR, BIT(0) },
> +};
> +
> +static int imx8mp_reset_set(struct reset_ctl *rst, bool assert)
> +{
> +	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);

It wouldn't hurt to rename imx7_reset_priv to imx_reset_priv in 2/11 too.

With the include sorting fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
