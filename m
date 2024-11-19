Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D2D44001
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5162D88D9B;
	Tue, 19 Nov 2024 06:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i1RPuQUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C175894F9; Tue, 19 Nov 2024 06:18:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FBB88B0B
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ5HxiA3804986
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 23:17:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731993479;
 bh=WpqQyxcWdsQHqUwbbbVOsqcgkLDr1UykcjwZo2Bw8DQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=i1RPuQUZH/NZnMY4uYKUF2Ssa1Z8D1kBamDck2gAgM1Q/tp0mJfTmbRjFYgVV9OkN
 W/tCH+wLv9ypYgxQXmWHIJwJEZQ/eqlVzr+exZSRiC2Dna16jxUgIF1nJy5e/r7t6T
 Jzt7DXYOUyktsibT8eaOQ7BlHsg6+dtHAxB+JVVU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ5HxNb097715
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 23:17:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 23:17:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 23:17:58 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ5HwaD038398;
 Mon, 18 Nov 2024 23:17:58 -0600
Date: Tue, 19 Nov 2024 10:47:57 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v4 3/5] misc: k3_avs: Check validity of efuse voltage data
Message-ID: <20241119051757.mxw5dpbfvsyl47fj@uda0497581>
References: <20241119003617.1871183-1-a-limaye@ti.com>
 <20241119003617.1871183-4-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003617.1871183-4-a-limaye@ti.com>
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

Hi Aniket,

On 06:02-20241119, Aniket Limaye wrote:
> From: Reid Tonking <reidt@ti.com>
> 
> k3_avs driver checks opp_ids when probing and overwrites the voltage
> values in vd_data for the respective board. The new k3_avs_check_opp()
> can be called from board files to check the efuse data and returns 0 if
> valid.
> 
> Also add the same check in k3_avs_program_voltage() to error out if
> the efuse data was not valid.
> 
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
[..]
> ---
>  drivers/misc/k3_avs.c | 32 ++++++++++++++++++++++++++++++++
>  include/k3-avs.h      |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 9d950d034a5..0774e0a4c9e 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -121,6 +121,11 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
>  	if (!vd->supply)
>  		return -ENODEV;
>  
> +	if (!volt) {
> +		dev_err(priv->dev, "No efuse found for opp_%d\n", opp_id);
> +		return -EINVAL;
> +	}
> +
>  	vd->opp = opp_id;
>  	vd->flags |= VD_FLAG_INIT_DONE;
>  
> @@ -192,6 +197,33 @@ static int match_opp(struct vd_data *vd, u32 freq)
>  	return -EINVAL;
>  }
>  
> +/**
> + * k3_check_opp: Check for presence of opp efuse
> + * @dev: AVS device
> + * @vdd_id: voltage domain ID
> + * @opp_id: opp id to check if voltage is present
> + *
> + * Checks to see if an opp has voltage. k3_avs probe will populate
> + * voltage data if efuse is present. Returns 0 if data is valid.
> + */
> +int k3_avs_check_opp(struct udevice *dev, int vdd_id, int opp_id)
> +{
> +	struct k3_avs_privdata *priv = dev_get_priv(dev);
> +	struct vd_data *vd;
> +	int volt;
> +
> +	vd = get_vd(priv, vdd_id);
> +	if (!vd)
> +		return -EINVAL;
> +
> +	volt = vd->opps[opp_id].volt;
> +	if (volt)
> +		return 0;
> +
> +	printf("No efuse found for opp_%d\n", opp_id);
> +	return -EINVAL;
> +}
> +
>  /**
>   * k3_avs_notify_freq: Notify clock rate change towards AVS subsystem
>   * @dev_id: Device ID for the clock to be changed
> diff --git a/include/k3-avs.h b/include/k3-avs.h
> index f6f1031c9cc..5a973e4ed45 100644
> --- a/include/k3-avs.h
> +++ b/include/k3-avs.h
> @@ -27,5 +27,6 @@
>  
>  int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id);
>  int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq);
> +int k3_avs_check_opp(struct udevice *dev, int vdd_id, int opp_id);

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>  
>  #endif
> -- 
> 2.47.0
> 
