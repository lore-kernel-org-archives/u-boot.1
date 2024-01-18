Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52931C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 16:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3360587B5F;
	Thu, 18 Jan 2024 17:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SyRMECsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6913487B5F; Thu, 18 Jan 2024 17:31:25 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707A6878D3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2ac304e526so1237377266b.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705595483; x=1706200283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+a4CnQYBiYY4NY77Pvj+JfrhGHr7raq4b13NKYRVUNI=;
 b=SyRMECskIzkBgveYY6xSywxaOZtW4H8bjIUyuOQQMRKYv0hjawaZApsd1uL3smk6pJ
 GmuR0RDoHJUsWxRQ2y17nwJwIpk/Pd3rnhDiq7dGR73COpyYOUPdjo2uOR8DWzx9eVUA
 /a97HReK1lER+i3PYgND0gt7BS/bxJUY6zOQBYlIdimJXGytCQwPTdY8q7dGAxSXTHVN
 boKHPAmMp47t2MLYLpuD3PqQxtrho6ssqJ9GcNEtuViA8QyoonCobMZLHiUMHKxGvUb2
 bFkfNg5lrPLW79DbyLVoqdVKgGKo5DkjkCZtSdvLAmzPacTWl6NU8jDzE+xSP49bcWyc
 wANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705595483; x=1706200283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a4CnQYBiYY4NY77Pvj+JfrhGHr7raq4b13NKYRVUNI=;
 b=TslZDVQnW0IQB+qUyOrwLYUl3L5k9udqNYH8URyEYHaghUxgdzbnye+dzD9fFpE7sg
 1xN2KJWLkTAmm5h9K35ZLJXf53sWtCMvwkzvoeRcB3FTYXyERSo3WaQ2loaVE7sNafKq
 bHBzg4ftab9QANP4xUFpkp5M0s05s8Kddp8tupfM1chTSa75ldxEfhcXBQwS5zCCj7tX
 eryO2f4ZVoCRFosbahB44fjv3n9UJOMKE+qBrmODSZOAOAT08VeqSL4uefuq386tNSQk
 4gFqXuFWZj1SvRDaHozsrqZ4K6PmrEaL6XuwDwi9HIrHwOrnMyi5vRUuZbohRxvNpIAe
 J0ww==
X-Gm-Message-State: AOJu0Yxb0GuH+oLLzZo4BvfleemNMuPq+4Cj6mTfUUcY3KksHuenh7AJ
 ZqbD6NBN+z59Qv5kBkJBCw7s/yF5yhh93YGG/wBqy6Q1vrXuUbZs
X-Google-Smtp-Source: AGHT+IEtpQc13JwLs7xROXDgdi+5pHC5qIjHBfsfxqrHi4moPNem/0tYtII3+3kVVs8oSQoYQ8mwMw==
X-Received: by 2002:a17:906:68c8:b0:a23:7464:e970 with SMTP id
 y8-20020a17090668c800b00a237464e970mr646515ejr.80.1705595482484; 
 Thu, 18 Jan 2024 08:31:22 -0800 (PST)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1709060f8e00b00a2a61b9c166sm9273128ejj.33.2024.01.18.08.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 08:31:22 -0800 (PST)
Date: Thu, 18 Jan 2024 17:31:20 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/4] board: verdin-am62: set cpu core voltage
 depending on speed grade
Message-ID: <ZalSWOw7UEvfnrKf@toolbox>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
 <20240117101743.3955852-5-max.oss.09@gmail.com>
 <Zaj0T33xqN3Eq6XT@toolbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zaj0T33xqN3Eq6XT@toolbox>
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

On Thu, Jan 18, 2024 at 10:50:07AM +0100, Max Krummenacher wrote:
> On Wed, Jan 17, 2024 at 11:16:49AM +0100, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > Speed grade T requires the VDD_CORE voltage to be 0.85V if using
> > the maximum core frequency.
> > 
> > Speed grades G, K, S allow the VDD_CORE voltage to be 0.75V up to the
> > maximum core frequency but allow to run at 0.85V.
> > 
> > For efficiency in manufacturing and code maintenance we use 0.85V for
> > the PMIC defaults and device tree settings and dynamically adjust the
> > voltage in the PMIC and device tree to 0.75V for lower speed SKU to
> > gain more than 100mW power consumption reduction.
> > 
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > ---
> > 
> >  board/toradex/verdin-am62/verdin-am62.c | 47 +++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> > index 4e912b5f32f..8b9db224069 100644
> > --- a/board/toradex/verdin-am62/verdin-am62.c
> > +++ b/board/toradex/verdin-am62/verdin-am62.c
> > @@ -13,10 +13,13 @@
> >  #include <fdt_support.h>
> >  #include <init.h>
> >  #include <k3-ddrss.h>
> > +#include <power/regulator.h>
> 
> In the !DM_REGULATOR case regulator.h assumes errno.h to be already included.
> This happens when compiling the R5 SPL.
> 
> Will fix this in a v2 of the series.

Actually we can go on with the series. While it is true that errno.h is not
included in regulator.h, the required header is included and its definitions
available.

I will create a separate patch which cleans up the headers, so that they
become self contained.

Max

> 
> Max
> 
> >  #include <spl.h>
> >  
> >  #include "../common/tdx-cfg-block.h"
> >  
> > +#define VDD_CORE_REG "buck1"
> > +
> >  DECLARE_GLOBAL_DATA_PTR;
> >  
> >  int board_init(void)
> > @@ -49,9 +52,37 @@ int board_fit_config_name_match(const char *name)
> >  }
> >  #endif
> >  
> > +static u32 get_vdd_core_nominal(void)
> > +{
> > +	int core_uvolt;
> > +
> > +	switch (k3_get_speed_grade()) {
> > +	case 'G':
> > +	case 'K':
> > +	case 'S':
> > +		core_uvolt = 750000;
> > +		break;
> > +	case 'T':
> > +	default:
> > +		core_uvolt = 850000;
> > +		break;
> > +	}
> > +	return core_uvolt;
> > +}
> > +
> >  #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> > +	int core_uvolt;
> > +
> > +	core_uvolt = get_vdd_core_nominal();
> > +	if (core_uvolt != 850000) {
> > +		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
> > +				     "regulator-max-microvolt", core_uvolt, 0);
> > +		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
> > +				     "regulator-min-microvolt", core_uvolt, 0);
> > +	}
> > +
> >  	return ft_common_board_setup(blob, bd);
> >  }
> >  #endif
> > @@ -86,6 +117,22 @@ static void select_dt_from_module_version(void)
> >  
> >  int board_late_init(void)
> >  {
> > +	int ret;
> > +	int core_uvolt;
> > +	struct udevice *dev = NULL;
> > +
> > +	core_uvolt = get_vdd_core_nominal();
> > +	if (core_uvolt != 850000) {
> > +		/* Set CPU core voltage to 0.75V for slower speed grades */
> > +		ret = regulator_get_by_devname(VDD_CORE_REG, &dev);
> > +		if (ret)
> > +			pr_err("VDD CORE Regulator get error: %d\n", ret);
> > +
> > +		ret = regulator_set_value_force(dev, core_uvolt);
> > +		if (ret)
> > +			pr_err("VDD CORE Regulator value setting error: %d\n", ret);
> > +	}
> > +
> >  	select_dt_from_module_version();
> >  
> >  	return 0;
> > -- 
> > 2.42.0
> > 
