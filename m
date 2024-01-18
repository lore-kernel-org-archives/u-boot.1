Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A84C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 09:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA8F87B8D;
	Thu, 18 Jan 2024 10:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2MpHp76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3527587B90; Thu, 18 Jan 2024 10:50:13 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A2487B85
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 10:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so12224418a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705571409; x=1706176209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vysle59Z9eZq90n/E+XrLniq4WKd+Qw0R+tMjN8e0CY=;
 b=X2MpHp76lDxdstKo27n9rbw9X2AtnpsK/E+LJhenCbSSXYTPPLruCtxQyQlvD9nUZo
 LVFlDK8yZWYtYRy0LJnkkFtdHqU42jHwLOzaPPAXxlENuj06pTDKHOWT1Ln51twSz/ox
 wIf6y1zzV/hLmVJbDAmqwRUuU+Brs/h6IV7Adpra6gQjk9ZfI9IgLsXhfckdayUqhwg0
 MM+JXzM0ijN9+3cD3LRxC7LsIAN/XBGeqwDafPFxjagADSeI9KGqpHB4+oQkf6sOJdLJ
 BB/gcTq+LzsPwJhkyPwf/noC5mv3IeoxAegIexqTXjbLZFmKQRtxxCFRPn97imuknSpr
 9R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705571409; x=1706176209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vysle59Z9eZq90n/E+XrLniq4WKd+Qw0R+tMjN8e0CY=;
 b=ZpEaLHDu+CyujkpUgNz6ryeFXbDhWkKisWOGTDrZt1J4HHq35Chw6miECd/oSygz/9
 7bxRPUEVbpfVpXd2mCyHM5nt+8nG4HJfACvYCl/5GAUuP/a0z8E857/mn0FhebHS95U8
 MKiIgxg9d+bjmIk7nfdYBx79y9C+MykfGeq6CGC9sELZswyfcYKeUi8sLdWHkaPucOR8
 A5hkUchr2H8V8eD53qtrNKO35Xi4o91Zo3rcjNr83rcLTafMmgT4o0mPZogQ75pWOuuf
 aQRWtg7GQVRWBMCvG88nkPsUECcnMo8fHH75H2/hrfVWZ+vpwj5HRGjUEWXbG94Y3VoW
 4FOA==
X-Gm-Message-State: AOJu0YykViGJ+33t3o2/WIWR6BSiJp+Dy1Hs3GrdN/jtu9e067DdgZTJ
 +CCscUpC3YIQBcePpKKETEGqoPACUQ/HcfiT773T2K1q/JrUjzPB
X-Google-Smtp-Source: AGHT+IEPrKYxyxPQNdf+daMwRVpLw8fpliKpUFi2hTggdtiL/L20jpbCMElNIP155cbWgopkrXPFvA==
X-Received: by 2002:a17:906:856:b0:a27:c856:d889 with SMTP id
 f22-20020a170906085600b00a27c856d889mr320785ejd.81.1705571409040; 
 Thu, 18 Jan 2024 01:50:09 -0800 (PST)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 bm19-20020a170906c05300b00a2362c5e3dbsm8893790ejb.151.2024.01.18.01.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 01:50:08 -0800 (PST)
Date: Thu, 18 Jan 2024 10:50:07 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/4] board: verdin-am62: set cpu core voltage
 depending on speed grade
Message-ID: <Zaj0T33xqN3Eq6XT@toolbox>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
 <20240117101743.3955852-5-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117101743.3955852-5-max.oss.09@gmail.com>
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

On Wed, Jan 17, 2024 at 11:16:49AM +0100, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Speed grade T requires the VDD_CORE voltage to be 0.85V if using
> the maximum core frequency.
> 
> Speed grades G, K, S allow the VDD_CORE voltage to be 0.75V up to the
> maximum core frequency but allow to run at 0.85V.
> 
> For efficiency in manufacturing and code maintenance we use 0.85V for
> the PMIC defaults and device tree settings and dynamically adjust the
> voltage in the PMIC and device tree to 0.75V for lower speed SKU to
> gain more than 100mW power consumption reduction.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  board/toradex/verdin-am62/verdin-am62.c | 47 +++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> index 4e912b5f32f..8b9db224069 100644
> --- a/board/toradex/verdin-am62/verdin-am62.c
> +++ b/board/toradex/verdin-am62/verdin-am62.c
> @@ -13,10 +13,13 @@
>  #include <fdt_support.h>
>  #include <init.h>
>  #include <k3-ddrss.h>
> +#include <power/regulator.h>

In the !DM_REGULATOR case regulator.h assumes errno.h to be already included.
This happens when compiling the R5 SPL.

Will fix this in a v2 of the series.

Max

>  #include <spl.h>
>  
>  #include "../common/tdx-cfg-block.h"
>  
> +#define VDD_CORE_REG "buck1"
> +
>  DECLARE_GLOBAL_DATA_PTR;
>  
>  int board_init(void)
> @@ -49,9 +52,37 @@ int board_fit_config_name_match(const char *name)
>  }
>  #endif
>  
> +static u32 get_vdd_core_nominal(void)
> +{
> +	int core_uvolt;
> +
> +	switch (k3_get_speed_grade()) {
> +	case 'G':
> +	case 'K':
> +	case 'S':
> +		core_uvolt = 750000;
> +		break;
> +	case 'T':
> +	default:
> +		core_uvolt = 850000;
> +		break;
> +	}
> +	return core_uvolt;
> +}
> +
>  #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> +	int core_uvolt;
> +
> +	core_uvolt = get_vdd_core_nominal();
> +	if (core_uvolt != 850000) {
> +		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
> +				     "regulator-max-microvolt", core_uvolt, 0);
> +		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
> +				     "regulator-min-microvolt", core_uvolt, 0);
> +	}
> +
>  	return ft_common_board_setup(blob, bd);
>  }
>  #endif
> @@ -86,6 +117,22 @@ static void select_dt_from_module_version(void)
>  
>  int board_late_init(void)
>  {
> +	int ret;
> +	int core_uvolt;
> +	struct udevice *dev = NULL;
> +
> +	core_uvolt = get_vdd_core_nominal();
> +	if (core_uvolt != 850000) {
> +		/* Set CPU core voltage to 0.75V for slower speed grades */
> +		ret = regulator_get_by_devname(VDD_CORE_REG, &dev);
> +		if (ret)
> +			pr_err("VDD CORE Regulator get error: %d\n", ret);
> +
> +		ret = regulator_set_value_force(dev, core_uvolt);
> +		if (ret)
> +			pr_err("VDD CORE Regulator value setting error: %d\n", ret);
> +	}
> +
>  	select_dt_from_module_version();
>  
>  	return 0;
> -- 
> 2.42.0
> 
