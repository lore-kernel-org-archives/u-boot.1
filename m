Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1124C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9518644E;
	Fri, 23 Feb 2024 10:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wb+ZtuQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759B1865F5; Fri, 23 Feb 2024 10:42:37 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E618780E
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N9fvx8011365;
 Fri, 23 Feb 2024 03:41:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708681318;
 bh=9i5s7ZMtHd9PxMedxdzX8JWSVNqt/hWGyGF/i4HW6i0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wb+ZtuQcX6BjtAwi8is535I/lxYG075d6TFI7Cm/e81Ip/zsyfJVjDn5UtPTDmWG0
 2GUa9OrNjkfxVZWool13xMF+NFdcj1sHH9YVrudpVB2IwrPuAGww2Hu25egG5Phl/a
 tgdq3Ii0TzhRC86jXXNYIzWYFExWJurOAMghY4/Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N9fvSq035853
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 03:41:57 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 03:41:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 03:41:57 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N9fukl088232;
 Fri, 23 Feb 2024 03:41:57 -0600
Date: Fri, 23 Feb 2024 15:11:56 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <sjg@chromium.org>,
 <m.nirmaladevi@ltts.com>, <kamlesh@ti.com>
Subject: Re: [PATCH v1 4/5] power: regulator: tps65941: use function
 callbacks for conversion ops
Message-ID: <20240223094156.qhzclrbnuiedbfg7@dhruva>
References: <20240223091212.63627-1-bhargav.r@ltts.com>
 <20240223091212.63627-5-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223091212.63627-5-bhargav.r@ltts.com>
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

On Feb 23, 2024 at 14:42:11 +0530, Bhargav Raviprakash wrote:
> Use function callbacks for volt2val, val2volt and slewrate lookups.
> This makes it easier to add support for TPS65224 PMIC regulators.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  drivers/power/regulator/tps65941_regulator.c | 61 +++++++++++++++-----
>  1 file changed, 48 insertions(+), 13 deletions(-)

Add Tom Rini in To or CC please.

> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index cf54e30df5..cdfbc3f4de 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -35,6 +35,17 @@
>  #define TPS65941_LDO_ID_3         3
>  #define TPS65941_LDO_ID_4         4
>  
> +#define TPS65941_BUCK_CONV_OPS_IDX  0
> +#define TPS65941_LDO_CONV_OPS_IDX   0
> +
> +struct tps65941_reg_conv_ops {
> +	int volt_mask;
> +	int (*volt2val)(int idx, int uV);
> +	int (*val2volt)(int idx, int volt);
> +	int slew_mask;
> +	int (*lookup_slew)(int id);
> +};
> +
>  static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
>  								0xC};
>  static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
> @@ -79,7 +90,7 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>  	return 0;
>  }
>  
> -static int tps65941_buck_volt2val(int uV)
> +static int tps65941_buck_volt2val(int /*idx*/, int uV)

IMHO /*idx*/ does NOT look good.
Check something like __maybe_unused attribute

[...]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
