Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C306087500;
	Tue, 31 Oct 2023 09:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ZIsmcaRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1ED6879E1; Tue, 31 Oct 2023 09:58:50 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C031A86FBC
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031085844epoutp03b4b7a1c0e233bcd87fde523ce93f9a2d~TJYIDWK-32897628976epoutp03V
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031085844epoutp03b4b7a1c0e233bcd87fde523ce93f9a2d~TJYIDWK-32897628976epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698742724;
 bh=HzIg05hWM+9a/vugZ8Ito3xYTT32+gcxKc6paSaU0Tw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ZIsmcaRwYDZMS+vii8SuJxEoJhJKwbn+DZQx9QBEcj+aiEW1GbufxlG5mzUy4v1st
 IWlnEoWv8MpD4cdgxeew+qCrFQeNmsLK0BdSOQNKl2CZhVWzQpm88qV7N6gjuE/Q2a
 1FeX+Ls9Ir86jgyBG/5c7KvjtdCOGpsi4q/wLGGQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031085844epcas1p4b92a882f050209f2ea14c4cbcaa75be6~TJYH1jXsT0151501515epcas1p4H;
 Tue, 31 Oct 2023 08:58:44 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKPFH4dnSz4x9QB; Tue, 31 Oct
 2023 08:58:43 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.9F.09731.3C1C0456; Tue, 31 Oct 2023 17:58:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031085843epcas1p1b645138c4ff3ed1fe6803d91e9cf30d1~TJYGgd6cK0873008730epcas1p18;
 Tue, 31 Oct 2023 08:58:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031085843epsmtrp2a0b4ab0d02fd3192ad2852308cc44b3d~TJYGf6-gX1775217752epsmtrp2X;
 Tue, 31 Oct 2023 08:58:43 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-53-6540c1c32782
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DC.8B.08817.2C1C0456; Tue, 31 Oct 2023 17:58:42 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031085842epsmtip1c5d2aaad5556e9bd2430ae341eed6f88~TJYGTOz942909429094epsmtip1F;
 Tue, 31 Oct 2023 08:58:42 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20231027082615.306943-5-clamor95@gmail.com>
Subject: RE: [PATCH v9 4/8] power: regulator: max77663: add regulator support
Date: Tue, 31 Oct 2023 17:58:42 +0900
Message-ID: <008b01da0bd8$72de3e60$589abb20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLxkJu7998OOQM6zGAUNVB6NFUBswFa9302AWMe3FWuHp7ZgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTX/fwQYdUg3n35SwO9PcyWnzbso3R
 YuqkzewWb/d2sjuweMxuuMjisXPWXXaPVwdWsXucvbODMYAlKtsmIzUxJbVIITUvOT8lMy/d
 Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2inkkJZYk4pUCggsbhYSd/Opii/tCRV
 ISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o+nlZKaCT1EVm76eYW5g3OXW
 xcjJISFgIrHp2in2LkYuDiGBHYwSd5ZeZ4FwPjFKHJz5jxHC+cYoMf1ZMwtMy5PJF5ggEnsZ
 JQ4/WgXlvGSU+DztDxtIFZuAnsT/RQuZQWwRgTKJpV1rmUBsZgEpiaaTuxhBbE4BS4mN6y6x
 gtjCAv4S/afugdWzCKhKvO+6DlbPC1Qz/3wDO4QtKHFy5hMWiDnyEtvfzmGGuEhB4ufTZawQ
 u5wkZjx6wQhRIyIxu7ONGeQ4CYGf7BK3595hhGhwkfjU8pkVwhaWeHV8CzuELSXx+d1eNoiG
 ZkaJpUsOskI4PYwS/xqus0FUGUvsXzoZ6DwOoBWaEut36UOEFSV2/p4LtZlP4t3XHlaQEgkB
 XomONiGIEhWJS69fMsHsuvvkP+sERqVZSH6bheS3WUh+mIWwbAEjyypGsdSC4tz01GLDAiN4
 fCfn525iBKdILbMdjJPeftA7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRlNg
 aE9klhJNzgcm6bySeEMTSwMTMyNjEwtDM0Mlcd45j3tThATSE0tSs1NTC1KLYPqYODilGpjq
 89JWLW1J3LDO2/fYGjMnqYU37n+urxHcmr829uRqj8Kshewu/FrtKTfepAZK7bn23iHU8ehG
 O5uXgf8Xbbq7x6ZrewTrwaoJV9dEK+9sau0R8+Pe+MR0u3u46YWP7hziBd/3PZhSyiUrEie+
 gX2i0dQ5nyd4WD9x6Dm1iNVChXMhbwkrX/kE38Ald5k9fhSdV37x0CBF0CG9S7JIj9f3rkXy
 5qNTmzx/G/st4b0WYh7rnnaX6cS3T65fn6w983nqerOy7MZDbGUrlA4GMv5XmBAm7fpPRvfE
 WwkzC9fbEfpa562fRRxj+uzTc9JW+5jTytsLV7XdkdIu1TpUt620X9vQI29V1M/KFH/lN0os
 xRmJhlrMRcWJACTwycsaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnO7hgw6pBmdDLA709zJafNuyjdFi
 6qTN7BZv93ayO7B4zG64yOKxc9Zddo9XB1axe5y9s4MxgCWKyyYlNSezLLVI3y6BK6Pp5WSm
 gk9RFZu+nmFuYNzl1sXIySEhYCLxZPIFpi5GLg4hgd2MEkuenGOBSEhJfH46la2LkQPIFpY4
 fLgYouY5o8SCWQ/YQGrYBPQk/i9ayAxiiwhUSMzp/wgWZwbqbTq5ixGiYTujxNbjq5lAEpwC
 lhIb111iBbGFBXwlFm/YA7aMRUBV4n3XdbAaXqCa+ecb2CFsQYmTM5+wgBzBDLSsbSMjxHx5
 ie1v5zBD3Kkg8fPpMlaIG5wkZjx6AVUjIjG7s415AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYW
 FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHiJbWDsY9qz7oHWJk4mA8xCjBwawkwnvY1CFV
 iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBibRKWl79/dd
 5LZLM9pY4CHl2P48uW6HdqFjXhzbtJBD8nYXeWecaAu1XitnKGfKf8lFPDHtrNadyU2HLhTm
 sXk1fIwIW5q44taepv2O3kwtZ70+h343nTTr36by67dLr767cUcxsuZx2rOFBZ37HsqL8iz4
 7HL/9UqtL9UHpjnMebf5x/ULX3zFzsxcpB1s5sjr5fhZi/Hx/giHBv69V4Wqy9bwLn3vcCMs
 YPnbq1L/+PgNfL5wrg81PvDb+OD5SlbHK4G/Dra6bf3wwqbIo427QfzflguerhfPCAuVrKu/
 ECd857S7Yn2dyYRLi48tiOFMv/zh47JorSwFtp1K79K+nPwekqSz7qlF3e4lZxqVWIozEg21
 mIuKEwF7xc9GAAMAAA==
X-CMS-MailID: 20231031085843epcas1p1b645138c4ff3ed1fe6803d91e9cf30d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231027082636epcas1p3c6033310ec81b4b92c924ef399494085
References: <20231027082615.306943-1-clamor95@gmail.com>
 <CGME20231027082636epcas1p3c6033310ec81b4b92c924ef399494085@epcas1p3.samsung.com>
 <20231027082615.306943-5-clamor95@gmail.com>
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



> -----Original Message-----
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Friday, October 27, 2023 5:26 PM
> To: Tom Rini <trini@konsulko.com>; Jaehoon Chung <jh80.chung@samsung.com>; Simon Glass
> <sjg@chromium.org>; Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: u-boot@lists.denx.de
> Subject: [PATCH v9 4/8] power: regulator: max77663: add regulator support
> 
> The driver provides regulator set/get voltage
> enable/disable functions for MAXIM MAX77663 PMICs.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/Kconfig              |   9 +
>  drivers/power/regulator/Makefile             |   1 +
>  drivers/power/regulator/max77663_regulator.c | 375 +++++++++++++++++++
>  3 files changed, 385 insertions(+)
>  create mode 100644 drivers/power/regulator/max77663_regulator.c
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index eb5aa38c1c..581816294c 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -141,6 +141,15 @@ config SPL_REGULATOR_PWM
>  	  This config enables implementation of driver-model regulator uclass
>  	  features for PWM regulators in SPL.
> 
> +config DM_REGULATOR_MAX77663
> +	bool "Enable Driver Model for REGULATOR MAX77663"
> +	depends on DM_REGULATOR && DM_PMIC_MAX77663
> +	---help---
> +	This config enables implementation of driver-model regulator uclass
> +	features for REGULATOR MAX77663. The driver supports both DC-to-DC
> +	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
> +	found in MAX77663 PMIC and implements get/set api for value and enable.
> +
>  config DM_REGULATOR_MAX77686
>  	bool "Enable Driver Model for REGULATOR MAX77686"
>  	depends on DM_REGULATOR && DM_PMIC_MAX77686
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
> index d9e0cd5949..8d73169b50 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
>  obj-$(CONFIG_$(SPL_)REGULATOR_AXP) += axp_regulator.o
>  obj-$(CONFIG_$(SPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
>  obj-$(CONFIG_$(SPL_)DM_REGULATOR_DA9063) += da9063.o
> +obj-$(CONFIG_$(SPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
>  obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
>  obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
> diff --git a/drivers/power/regulator/max77663_regulator.c
> b/drivers/power/regulator/max77663_regulator.c
> new file mode 100644
> index 0000000000..ea4b7c63e5
> --- /dev/null
> +++ b/drivers/power/regulator/max77663_regulator.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <dm.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +#include <power/max77663.h>
> +
> +/* fist row is control registers, second is voltage registers */
> +static const char max77663_sd_reg[][MAX77663_SD_NUM] = {
> +	{ 0x1d, 0x1e, 0x1f, 0x20, 0x21 },
> +	{ 0x16, 0x17, 0x18, 0x19, 0x2a },
> +};
> +
> +static const char max77663_ldo_reg[MAX77663_LDO_NUM] = {
> +	0x23, 0x25, 0x27, 0x29, 0x2b, 0x2d, 0x2f, 0x31, 0x33
> +};
> +
> +static int max77663_sd_enable(struct udevice *dev, int op, bool *enable)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	u32 adr = uc_pdata->ctrl_reg;
> +	int val, ret;
> +
> +	val = pmic_reg_read(dev->parent, adr);
> +	if (val < 0)
> +		return val;
> +
> +	if (op == PMIC_OP_GET) {
> +		if (val & SD_STATUS_MASK)
> +			*enable = true;
> +		else
> +			*enable = false;
> +
> +		return 0;
> +	} else if (op == PMIC_OP_SET) {
> +		val &= ~SD_STATUS_MASK;
> +
> +		if (*enable)
> +			val |= SD_STATUS_MASK;
> +
> +		ret = pmic_reg_write(dev->parent, adr, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * max77663_*_volt2hex() - convert voltage in uV into
> + *			   applicable to register hex value
> + *
> + * @idx:	regulator index
> + * @uV:		voltage in uV
> + *
> + * Return: voltage in hex on success, -ve on failure
> + */
> +static int max77663_sd_volt2hex(int idx, int uV)
> +{
> +	switch (idx) {
> +	case 0:
> +		/* SD0 has max voltage 1.4V */
> +		if (uV > SD0_VOLT_MAX)
> +			return -EINVAL;
> +		break;
> +	case 1:
> +		/* SD1 has max voltage 1.55V */
> +		if (uV > SD1_VOLT_MAX)
> +			return -EINVAL;
> +		break;
> +	default:
> +		/* SD2 and SD3 have max voltage 3.79V */
> +		if (uV > SD_VOLT_MAX)
> +			return -EINVAL;
> +		break;
> +	};
> +
> +	if (uV < SD_VOLT_MIN)
> +		uV = SD_VOLT_MIN;
> +
> +	return (uV - SD_VOLT_BASE) / 12500;
> +}
> +
> +/**
> + * max77663_*_hex2volt() - convert register hex value into
> + *			   actual voltage in uV
> + *
> + * @idx:	regulator index
> + * @hex:	hex value of register
> + *
> + * Return: voltage in uV on success, -ve on failure
> + */
> +static int max77663_sd_hex2volt(int idx, int hex)
> +{
> +	switch (idx) {
> +	case 0:
> +		/* SD0 has max voltage 1.4V */
> +		if (hex > SD0_VOLT_MAX_HEX)
> +			return -EINVAL;
> +		break;
> +	case 1:
> +		/* SD1 has max voltage 1.55V */
> +		if (hex > SD1_VOLT_MAX_HEX)
> +			return -EINVAL;
> +		break;
> +	default:
> +		/* SD2 and SD3 have max voltage 3.79V */
> +		if (hex > SD_VOLT_MAX_HEX)
> +			return -EINVAL;
> +		break;
> +	};
> +
> +	if (hex < SD_VOLT_MIN_HEX)
> +		hex = SD_VOLT_MIN_HEX;
> +
> +	return SD_VOLT_BASE + hex * 12500;
> +}
> +
> +static int max77663_sd_val(struct udevice *dev, int op, int *uV)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	u32 adr = uc_pdata->volt_reg;
> +	int idx = dev->driver_data;
> +	int hex, ret;
> +
> +	if (op == PMIC_OP_GET) {
> +		hex = pmic_reg_read(dev->parent, adr);
> +		if (hex < 0)
> +			return hex;
> +
> +		*uV = 0;
> +
> +		ret = max77663_sd_hex2volt(idx, hex);
> +		if (ret < 0)
> +			return ret;
> +		*uV = ret;
> +
> +		return 0;
> +	}
> +
> +	/* SD regulators use entire register for voltage */
> +	hex = max77663_sd_volt2hex(idx, *uV);
> +	if (hex < 0)
> +		return hex;
> +
> +	return pmic_reg_write(dev->parent, adr, hex);
> +}
> +
> +static int max77663_sd_probe(struct udevice *dev)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	int idx = dev->driver_data;
> +
> +	uc_pdata->type = REGULATOR_TYPE_BUCK;
> +	uc_pdata->ctrl_reg = max77663_sd_reg[0][idx];
> +	uc_pdata->volt_reg = max77663_sd_reg[1][idx];
> +
> +	return 0;
> +}
> +
> +static int sd_get_value(struct udevice *dev)
> +{
> +	int uV;
> +	int ret;
> +
> +	ret = max77663_sd_val(dev, PMIC_OP_GET, &uV);
> +	if (ret)
> +		return ret;
> +
> +	return uV;
> +}
> +
> +static int sd_set_value(struct udevice *dev, int uV)
> +{
> +	return max77663_sd_val(dev, PMIC_OP_SET, &uV);
> +}
> +
> +static int sd_get_enable(struct udevice *dev)
> +{
> +	bool enable = false;
> +	int ret;
> +
> +	ret = max77663_sd_enable(dev, PMIC_OP_GET, &enable);
> +	if (ret)
> +		return ret;
> +
> +	return enable;
> +}
> +
> +static int sd_set_enable(struct udevice *dev, bool enable)
> +{
> +	return max77663_sd_enable(dev, PMIC_OP_SET, &enable);
> +}
> +
> +static const struct dm_regulator_ops max77663_sd_ops = {
> +	.get_value  = sd_get_value,
> +	.set_value  = sd_set_value,
> +	.get_enable = sd_get_enable,
> +	.set_enable = sd_set_enable,
> +};
> +
> +U_BOOT_DRIVER(max77663_sd) = {
> +	.name = MAX77663_SD_DRIVER,
> +	.id = UCLASS_REGULATOR,
> +	.ops = &max77663_sd_ops,
> +	.probe = max77663_sd_probe,
> +};
> +
> +static int max77663_ldo_enable(struct udevice *dev, int op, bool *enable)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	u32 adr = uc_pdata->ctrl_reg;
> +	int val, ret;
> +
> +	val = pmic_reg_read(dev->parent, adr);
> +	if (val < 0)
> +		return val;
> +
> +	if (op == PMIC_OP_GET) {
> +		if (val & LDO_STATUS_MASK)
> +			*enable = true;
> +		else
> +			*enable = false;
> +
> +		return 0;
> +	} else if (op == PMIC_OP_SET) {
> +		val &= ~LDO_STATUS_MASK;
> +
> +		if (*enable)
> +			val |= LDO_STATUS_MASK;
> +
> +		ret = pmic_reg_write(dev->parent, adr, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77663_ldo_volt2hex(int idx, int uV)
> +{
> +	switch (idx) {
> +	case 0:
> +	case 1:
> +		if (uV > LDO01_VOLT_MAX)
> +			return -EINVAL;
> +
> +		return (uV - LDO_VOLT_BASE) / 25000;
> +	case 4:
> +		if (uV > LDO4_VOLT_MAX)
> +			return -EINVAL;
> +
> +		return (uV - LDO_VOLT_BASE) / 12500;
> +	default:
> +		if (uV > LDO_VOLT_MAX)
> +			return -EINVAL;
> +
> +		return (uV - LDO_VOLT_BASE) / 50000;
> +	};
> +}
> +
> +static int max77663_ldo_hex2volt(int idx, int hex)
> +{
> +	if (hex > LDO_VOLT_MAX_HEX)
> +		return -EINVAL;
> +
> +	switch (idx) {
> +	case 0:
> +	case 1:
> +		return (hex * 25000) + LDO_VOLT_BASE;
> +	case 4:
> +		return (hex * 12500) + LDO_VOLT_BASE;
> +	default:
> +		return (hex * 50000) + LDO_VOLT_BASE;
> +	};
> +}
> +
> +static int max77663_ldo_val(struct udevice *dev, int op, int *uV)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	u32 adr = uc_pdata->ctrl_reg;
> +	int idx = dev->driver_data;
> +	int hex, val, ret;
> +
> +	val = pmic_reg_read(dev->parent, adr);
> +	if (val < 0)
> +		return val;
> +
> +	if (op == PMIC_OP_GET) {
> +		*uV = 0;
> +
> +		ret = max77663_ldo_hex2volt(idx, val & LDO_VOLT_MASK);
> +		if (ret < 0)
> +			return ret;
> +
> +		*uV = ret;
> +		return 0;
> +	}
> +
> +	hex = max77663_ldo_volt2hex(idx, *uV);
> +	if (hex < 0)
> +		return hex;
> +
> +	val &= ~LDO_VOLT_MASK;
> +
> +	return pmic_reg_write(dev->parent, adr, val | hex);
> +}
> +
> +static int max77663_ldo_probe(struct udevice *dev)
> +{
> +	struct dm_regulator_uclass_plat *uc_pdata =
> +					dev_get_uclass_plat(dev);
> +	int idx = dev->driver_data;
> +
> +	uc_pdata->type = REGULATOR_TYPE_LDO;
> +	uc_pdata->ctrl_reg = max77663_ldo_reg[idx];
> +
> +	return 0;
> +}
> +
> +static int ldo_get_value(struct udevice *dev)
> +{
> +	int uV;
> +	int ret;
> +
> +	ret = max77663_ldo_val(dev, PMIC_OP_GET, &uV);
> +	if (ret)
> +		return ret;
> +
> +	return uV;
> +}
> +
> +static int ldo_set_value(struct udevice *dev, int uV)
> +{
> +	return max77663_ldo_val(dev, PMIC_OP_SET, &uV);
> +}
> +
> +static int ldo_get_enable(struct udevice *dev)
> +{
> +	bool enable = false;
> +	int ret;
> +
> +	ret = max77663_ldo_enable(dev, PMIC_OP_GET, &enable);
> +	if (ret)
> +		return ret;
> +
> +	return enable;
> +}
> +
> +static int ldo_set_enable(struct udevice *dev, bool enable)
> +{
> +	return max77663_ldo_enable(dev, PMIC_OP_SET, &enable);
> +}
> +
> +static const struct dm_regulator_ops max77663_ldo_ops = {
> +	.get_value  = ldo_get_value,
> +	.set_value  = ldo_set_value,
> +	.get_enable = ldo_get_enable,
> +	.set_enable = ldo_set_enable,
> +};
> +
> +U_BOOT_DRIVER(max77663_ldo) = {
> +	.name = MAX77663_LDO_DRIVER,
> +	.id = UCLASS_REGULATOR,
> +	.ops = &max77663_ldo_ops,
> +	.probe = max77663_ldo_probe,
> +};
> --
> 2.39.2


