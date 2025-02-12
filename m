Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C6C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 05:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCC980842;
	Wed, 12 Feb 2025 06:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cCf598el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BADE809D0; Wed, 12 Feb 2025 06:01:45 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C64B80824
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 06:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51C51d983737446
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Feb 2025 23:01:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739336499;
 bh=b1froPBQkg/5B+034hD7442eLv1L/+Xow+lJI37nozA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cCf598eldIjC7CCpODXLYsHue0rmXbp7p7FeF+PPJhNEltEtt/1dBP6HdxHA8bPyB
 q2oILDxsEZwRn63zRB11Z6jCnGDNAYL9gQVL2j9iQqCMTWfIhdTR8CcaNwW8xPMzWx
 5WG8u6K08KejS27pTh6LlCH0M6Ay77b9i7E92gGU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51C51dx2051328;
 Tue, 11 Feb 2025 23:01:39 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 23:01:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 23:01:39 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51C51ZcY026246;
 Tue, 11 Feb 2025 23:01:36 -0600
Message-ID: <ede4dbe8-c450-4d65-baab-a7a2a8bb779a@ti.com>
Date: Wed, 12 Feb 2025 10:31:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: tps65941: Fix voltage calculation for
 ldo
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <b-padhi@ti.com>, <j-keerthy@ti.com>
References: <20250211175158.867154-1-u-kumar1@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250211175158.867154-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Udit

On 11/02/25 23:21, Udit Kumar wrote:
> As per TRM[0] Section 8.7.1 "TPS6594-Q1 Registers", LDOx_Vout
> bit 6-1, define the NVM voltage settings.
> Along side table 8-4 of above TRM, shows voltage to value mapping.
> 
> Driver wrongly using bits 5-1 to calculate voltage, and to convert
> voltage to value driver was using buck's calculation.
> So fix those calculation.
> 
> [0]: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
> Fixes: 5d7dbd22cf7d ("power: regulator: tps65941: use function callbacks for conversion ops")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Bootlogs
> https://gist.github.com/uditkumarti/298bd277da11eb82146d7aff24c402ba
> 
>  drivers/power/regulator/tps65941_regulator.c | 16 +++++++++++++---
>  include/power/tps65941.h                     |  3 ++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index bc4d153fd8..13f94b730d 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -388,6 +388,14 @@ static int tps65941_ldo_enable(struct udevice *dev, int op, bool *enable)
>  	return 0;
>  }
>  
> +static int tps65941_ldo_volt2val(__maybe_unused int idx, int uV)
> +{
> +	if (uV > TPS65941_LDO_VOLT_MAX || uV < TPS65941_LDO_VOLT_MIN)
> +		return -EINVAL;
> +
> +	return ((uV - 600000) / 50000 + 0x4) << TPS65941_LDO_MODE_MASK;
> +}
> +
>  static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
>  {
>  	if (val > TPS65941_LDO_VOLT_MAX_HEX || val < TPS65941_LDO_VOLT_MIN_HEX)
> @@ -459,7 +467,7 @@ static int tps65224_ldo_val2volt(int idx, int val)
>  static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
>  	[TPS65941_LDO_CONV_OPS_IDX] = {
>  		.volt_mask = TPS65941_LDO_VOLT_MASK,
> -		.volt2val = tps65941_buck_volt2val,
> +		.volt2val = tps65941_ldo_volt2val,
>  		.val2volt = tps65941_ldo_val2volt,
>  	},
>  	[TPS65224_LDO_CONV_OPS_IDX] = {
> @@ -472,7 +480,7 @@ static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
>  static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  {
>  	unsigned int hex, adr;
> -	int ret, ret_volt, idx;
> +	int ret, ret_volt, idx, ldo_bypass;
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	const struct tps65941_reg_conv_ops *conv_ops;
>  	ulong chip_id;
> @@ -502,7 +510,9 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  	if (ret < 0)
>  		return ret;
>  
> +	ldo_bypass = ret & TPS65941_LDO_BYPASS_EN;
>  	ret &= conv_ops->volt_mask;
> +	ret = ret >> TPS65941_LDO_MODE_MASK;
>  	ret_volt = conv_ops->val2volt(idx, ret);
>  	if (ret_volt < 0)
>  		return ret_volt;
> @@ -531,7 +541,7 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  		ret &= ~TPS65224_LDO_VOLT_MASK;
>  		ret |= hex;
>  	} else {
> -		ret = hex;
> +		ret = hex | ldo_bypass;
>  	}
>  
>  	ret = pmic_reg_write(dev->parent, adr, ret);
> diff --git a/include/power/tps65941.h b/include/power/tps65941.h
> index cec85333f0..a026ec5695 100644
> --- a/include/power/tps65941.h
> +++ b/include/power/tps65941.h
> @@ -21,10 +21,11 @@
>  #define TPS65941_BUCK_VOLT_MAX		3340000
>  #define TPS65941_BUCK_MODE_MASK		0x1
>  
> -#define TPS65941_LDO_VOLT_MASK		0x3E
> +#define TPS65941_LDO_VOLT_MASK		0x7E
>  #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
>  #define TPS65941_LDO_VOLT_MIN_HEX	0x4
>  #define TPS65941_LDO_VOLT_MAX		3300000
> +#define TPS65941_LDO_VOLT_MIN		600000
>  #define TPS65941_LDO_MODE_MASK		0x1
>  #define TPS65941_LDO_BYPASS_EN		0x80
>  #define TP65941_BUCK_CONF_SLEW_MASK	0x7

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
