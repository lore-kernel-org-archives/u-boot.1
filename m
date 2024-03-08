Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8591AC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D292388072;
	Fri,  8 Mar 2024 10:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TcrDKXdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1366888077; Fri,  8 Mar 2024 10:01:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B1280245
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42891MFd011750;
 Fri, 8 Mar 2024 03:01:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709888482;
 bh=tFTaHZTxwGSYMKxv6D4HhXzIPOjC3tyWwjsMcwvi/Jk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TcrDKXdgIRFVUCmSh5an4wgjP+/A2/OVJGMDIEHxIT5A3OEhWfr3dcqTaxnA91EsU
 wo2yRRCSFEaKJQ+2AADDer/I8OjAVXaAA1ovFx/9Qco+n3sWaAPlO3EKWPPeRaZmDw
 DPjPESn5Iy+8GfFOtF6p+U8ysuuKV6IBVoP8eFDw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42891M9M053829
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Mar 2024 03:01:22 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Mar 2024 03:01:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Mar 2024 03:01:22 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42891LSt128266;
 Fri, 8 Mar 2024 03:01:21 -0600
Date: Fri, 8 Mar 2024 14:31:20 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <sjg@chromium.org>,
 <m.nirmaladevi@ltts.com>, <trini@konsulko.com>, <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 3/5] power: regulator: tps65941: Added macros for BUCK
 ID
Message-ID: <20240308090120.culeyzgvlbwptbcf@dhruva>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
 <20240306133947.160354-4-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306133947.160354-4-bhargav.r@ltts.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi,

On Mar 06, 2024 at 19:09:45 +0530, Bhargav Raviprakash wrote:
> Adds macros for buck and ldo ids and switched to using switch
> case instead of if else in probe functions. Helps in adding
> support for TPS65224 PMIC.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  drivers/power/regulator/tps65941_regulator.c | 54 +++++++++++++++-----
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index b041126775..cf54e30df5 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -16,6 +16,25 @@
>  #include <power/regulator.h>
>  #include <power/tps65941.h>
>  
> +/* Single Phase Buck IDs */
> +#define TPS65941_BUCK_ID_1        1
> +#define TPS65941_BUCK_ID_2        2
> +#define TPS65941_BUCK_ID_3        3
> +#define TPS65941_BUCK_ID_4        4
> +#define TPS65941_BUCK_ID_5        5
> +
> +/* Multi Phase Buck IDs */
> +#define TPS65941_BUCK_ID_12      12
> +#define TPS65941_BUCK_ID_34      34
> +#define TPS65941_BUCK_ID_123    123
> +#define TPS65941_BUCK_ID_1234  1234
> +
> +/* LDO IDs */
> +#define TPS65941_LDO_ID_1         1
> +#define TPS65941_LDO_ID_2         2
> +#define TPS65941_LDO_ID_3         3
> +#define TPS65941_LDO_ID_4         4
> +
>  static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
>  								0xC};
>  static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
> @@ -270,10 +289,15 @@ static int tps65941_ldo_probe(struct udevice *dev)
>  	uc_pdata->type = REGULATOR_TYPE_LDO;
>  
>  	idx = dev->driver_data;
> -	if (idx == 1 || idx == 2 || idx == 3 || idx == 4) {
> +	switch (idx) {
> +	case TPS65941_LDO_ID_1:
> +	case TPS65941_LDO_ID_2:
> +	case TPS65941_LDO_ID_3:
> +	case TPS65941_LDO_ID_4:
>  		debug("Single phase regulator\n");
> -	} else {
> -		printf("Wrong ID for regulator\n");
> +		break;
> +	default:
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
>  	}
>  
> @@ -292,18 +316,24 @@ static int tps65941_buck_probe(struct udevice *dev)
>  	uc_pdata->type = REGULATOR_TYPE_BUCK;
>  
>  	idx = dev->driver_data;
> -	if (idx == 1 || idx == 2 || idx == 3 || idx == 4 || idx == 5) {
> +	switch (idx) {
> +	case TPS65941_BUCK_ID_1:
> +	case TPS65941_BUCK_ID_2:
> +	case TPS65941_BUCK_ID_3:
> +	case TPS65941_BUCK_ID_4:
> +	case TPS65941_BUCK_ID_5:
>  		debug("Single phase regulator\n");
> -	} else if (idx == 12) {
> +		break;
> +	case TPS65941_BUCK_ID_12:
> +	case TPS65941_BUCK_ID_123:
> +	case TPS65941_BUCK_ID_1234:
>  		idx = 1;
> -	} else if (idx == 34) {
> +		break;
> +	case TPS65941_BUCK_ID_34:
>  		idx = 3;
> -	} else if (idx == 123) {
> -		idx = 1;
> -	} else if (idx == 1234) {
> -		idx = 1;
> -	} else {
> -		printf("Wrong ID for regulator\n");
> +		break;
> +	default:
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
