Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1255CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 04:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E974C847FD;
	Thu,  7 May 2026 06:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Jebpzv1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75943849BE; Wed,  6 May 2026 22:03:45 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F16B84951
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 22:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id ACF1B27046;
 Wed,  6 May 2026 22:03:41 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlHsIihhJoxL; Wed,  6 May 2026 22:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1778097821; bh=b3vR+5ei9d6rSHRynQgepg0yz85+cvyy2KNw8Pzp1Cg=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Jebpzv1kmb8wEA0fgDCJpWYQwCN195wNHMYtpcp+LXxwXlg+jHTPykrkvE+MD5O8I
 GnCwUo4hCyFfx3TgInjrD5oi3G0AnvhudbMsSiuYRcatiVpI1iKzCWmxKhlA08/nrc
 x4MuzfvGlso7omrJFfCwOv4z/xnRFZxw3Nn6NOemgJTVRVKRVUz8ztZl5jiOHZfJwB
 b7CgWdDVZBii0t+EmlA8R7i/ioTMknWuvwKJG/770lpUckfyIP1KSt9RorR8oOMABc
 nLMfH9uGOiBEnI3AwI4gqAiGtVPBw3AEiEZD7GJ/mqObg3RwDOr+uU2HX51BVQpZlh
 h8hzJFWMxVpew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 01:33:28 +0530
Message-Id: <DIBV2GMI0TCA.2NHUZI89OJUA0@disroot.org>
Subject: Re: [PATCH v2 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Henrik Grimler" <henrik@grimler.se>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Peng Fan" <peng.fan@nxp.com>, <u-boot@lists.denx.de>, "Minkyu Kang"
 <mk7.kang@samsung.com>, "Tom Rini" <trini@konsulko.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Anand Moon" <linux.amoon@gmail.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Lukas Timmermann"
 <uboot@timmermann.space>
References: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
 <20260503-dwmmc-exynos-hs400-es-v2-1-3ff1526142a7@disroot.org>
 <20260505190729.GA6951@l14.localdomain>
In-Reply-To: <20260505190729.GA6951@l14.localdomain>
X-Mailman-Approved-At: Thu, 07 May 2026 06:29:13 +0200
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

On 2026-05-05 21:07 +02:00, Henrik Grimler wrote:
> Hi Kaustabh,
>
> On Sun, May 03, 2026 at 05:51:26PM +0530, Kaustabh Chakraborty wrote:
>> HS400 support was added, but configuration necessary for HS400 support
>> was left out. Add necessary changes, which includes:
>> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
>>   "samsung,read-strobe-delay", which function as per dt-bindings.
>> - Registers related to HS400, which are necessary to enable HS400+ suppo=
rt.
>> - Appropriate timing tunings for the HS400 mode.
>>=20
>> Note that these changes are loosely based off of its Linux kernel
>> counterpart.
>>=20
>> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and =
HS400 modes")
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> Reviewed-by: Henrik Grimler <henrik@grimler.se>
>
> This works fine on exynos5422-odroid-xu4 without hs400. I was not able
> to get hs400 working on the device, seems more changes than just dts
> update are needed.

Do you have any logs or traces which may be able to help pinpoint it?
I can try to figure out the issue(s) if you want me to.

>
> Best regards,
> Henrik Grimler
>
>> ---
>>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
>>  drivers/mmc/exynos_dw_mmc.c               | 81 ++++++++++++++++++++++++=
+++++++
>>  2 files changed, 86 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-e=
xynos/include/mach/dwmmc.h
>> index 4432deedef7..50081326c25 100644
>> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
>> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
>> @@ -15,6 +15,11 @@
>>  #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
>>  #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
>> =20
>> +/* HS400 Related Registers */
>> +#define DWMCI_HS400_DQS_EN		0x180
>> +#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
>> +#define DWMCI_HS400_DLINE_CTRL		0x188
>> +
>>  /* Protector Register */
>>  #define DWMCI_EMMCP_BASE		0x1000
>>  #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
>> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
>> index 7ccd113bd79..6558cdc803d 100644
>> --- a/drivers/mmc/exynos_dw_mmc.c
>> +++ b/drivers/mmc/exynos_dw_mmc.c
>> @@ -8,6 +8,7 @@
>>  #include <dwmmc.h>
>>  #include <asm/global_data.h>
>>  #include <malloc.h>
>> +#include <mmc.h>
>>  #include <errno.h>
>>  #include <asm/arch/dwmmc.h>
>>  #include <asm/arch/clk.h>
>> @@ -30,6 +31,14 @@
>>  #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
>>  					 CLKSEL_CCLK_SAMPLE(y))
>> =20
>> +/* RCLK_EN register defines */
>> +#define DATA_STROBE_EN			BIT(0)
>> +#define AXI_NON_BLOCKING_WR	BIT(7)
>> +
>> +/* DLINE_CTRL register defines */
>> +#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
>> +#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
>> +
>>  /**
>>   * DOC: Quirk flags for different Exynos DW MMC blocks
>>   *
>> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
>>  	struct clk clk;
>>  	u32 sdr_timing;
>>  	u32 ddr_timing;
>> +	u32 hs400_timing;
>> +	u32 tuned_sample;
>> +	u32 dqs_delay;
>> +	u32 saved_dqs_en;
>> +	u32 saved_strobe_ctrl;
>>  	const struct exynos_dwmmc_variant *chip;
>>  };
>> =20
>> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_hos=
t *host)
>>  				& DWMCI_DIVRATIO_MASK) + 1;
>>  }
>> =20
>> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode =
mode)
>> +{
>> +	struct dwmci_exynos_priv_data *priv =3D exynos_dwmmc_get_priv(host);
>> +	u32 dqs, strobe;
>> +
>> +	dqs =3D priv->saved_dqs_en;
>> +	strobe =3D priv->saved_strobe_ctrl;
>> +
>> +	switch (mode) {
>> +	case MMC_HS_400:
>> +		dqs |=3D DATA_STROBE_EN;
>> +		strobe =3D DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
>> +		break;
>> +	default:
>> +		dqs &=3D ~DATA_STROBE_EN;
>> +	}
>> +
>> +	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
>> +	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
>> +}
>> +
>>  /* Configure CLKSEL register with chosen timing values */
>>  static int exynos_dwmci_clksel(struct dwmci_host *host)
>>  {
>> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *ho=
st)
>>  	u32 timing;
>> =20
>>  	switch (host->mmc->selected_mode) {
>> +	case MMC_HS_400:
>> +		timing =3D CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
>> +		break;
>>  	case MMC_DDR_52:
>>  		timing =3D priv->ddr_timing;
>>  		break;
>> @@ -186,6 +224,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *ho=
st)
>> =20
>>  	dwmci_writel(host, priv->chip->clksel, timing);
>> =20
>> +	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
>> +		exynos_config_hs400(host, host->mmc->selected_mode);
>> +
>>  	return 0;
>>  }
>> =20
>> @@ -223,6 +264,16 @@ static void exynos_dwmci_board_init(struct dwmci_ho=
st *host)
>>  {
>>  	struct dwmci_exynos_priv_data *priv =3D exynos_dwmmc_get_priv(host);
>> =20
>> +	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
>> +		priv->saved_strobe_ctrl =3D dwmci_readl(host, DWMCI_HS400_DLINE_CTRL)=
;
>> +		priv->saved_dqs_en =3D dwmci_readl(host, DWMCI_HS400_DQS_EN);
>> +		priv->saved_dqs_en |=3D AXI_NON_BLOCKING_WR;
>> +		dwmci_writel(host, DWMCI_HS400_DQS_EN, priv->saved_dqs_en);
>> +		if (!priv->dqs_delay)
>> +			priv->dqs_delay =3D
>> +				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
>> +	}
>> +
>>  	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
>>  		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
>>  		dwmci_writel(host, EMMCP_SEND0, 0);
>> @@ -319,6 +370,22 @@ static int exynos_dwmmc_of_to_plat(struct udevice *=
dev)
>>  				   DWMCI_SET_DIV_RATIO(div);
>>  	}
>> =20
>> +	err =3D dev_read_u32_array(dev, "samsung,dw-mshc-hs400-timing", timing=
, 2);
>> +	if (err) {
>> +		debug("DWMMC%d: Can't get hs400-timings, using ddr-timings\n",
>> +		      host->dev_index);
>> +		priv->hs400_timing =3D priv->ddr_timing;
>> +	} else {
>> +		priv->hs400_timing =3D DWMCI_SET_SAMPLE_CLK(timing[0]) |
>> +				     DWMCI_SET_DRV_CLK(timing[1]) |
>> +				     DWMCI_SET_DIV_RATIO(1);
>> +		if (dev_read_u32(dev, "samsung,read-strobe-delay", &priv->dqs_delay))=
 {
>> +			priv->dqs_delay =3D 0;
>> +			debug("DWMMC%d: read-strobe-delay is not found, assuming usage of de=
fault value\n",
>> +			      host->dev_index);
>> +		}
>> +	}
>> +
>>  	host->buswidth =3D dev_read_u32_default(dev, "bus-width", 4);
>>  	host->fifo_depth =3D dev_read_u32_default(dev, "fifo-depth", 0);
>>  	host->bus_hz =3D dev_read_u32_default(dev, "clock-frequency", 0);
>> @@ -356,6 +423,16 @@ static int exynos_dwmmc_get_best_clksmpl(u8 candida=
tes)
>>  	return -EIO;
>>  }
>> =20
>> +static int dw_mci_exynos_prepare_hs400_tuning(struct dwmci_host *host)
>> +{
>> +	struct dwmci_exynos_priv_data *priv =3D exynos_dwmmc_get_priv(host);
>> +
>> +	dwmci_writel(host, priv->chip->clksel, priv->hs400_timing);
>> +	host->bus_hz =3D exynos_dwmci_get_clk(host, host->clock);
>> +
>> +	return 0;
>> +}
>> +
>>  static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
>>  {
>>  	struct dwmci_exynos_priv_data *priv =3D dev_get_priv(dev);
>> @@ -365,6 +442,9 @@ static int exynos_dwmmc_execute_tuning(struct udevic=
e *dev, u32 opcode)
>>  	u32 clksel;
>>  	int ret;
>> =20
>> +	if (mmc->hs400_tuning)
>> +		dw_mci_exynos_prepare_hs400_tuning(host);
>> +
>>  	clksel =3D dwmci_readl(host, priv->chip->clksel);
>>  	start_smpl =3D CLKSEL_CCLK_SAMPLE(clksel);
>> =20
>> @@ -387,6 +467,7 @@ static int exynos_dwmmc_execute_tuning(struct udevic=
e *dev, u32 opcode)
>>  		return ret;
>>  	}
>> =20
>> +	priv->tuned_sample =3D ret;
>>  	dwmci_writel(host, priv->chip->clksel, CLKSEL_UP_SAMPLE(clksel, ret));
>> =20
>>  	return 0;
>>=20
>> --=20
>> 2.53.0
>>=20

