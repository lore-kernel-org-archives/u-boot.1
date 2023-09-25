Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCA1CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4514786D57;
	Mon, 25 Sep 2023 16:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cPW0qGi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1C286D56; Mon, 25 Sep 2023 16:06:32 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4857F86D27
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PE6Puo016227;
 Mon, 25 Sep 2023 09:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695650785;
 bh=c+D/z3rV/mVtuXJ4dPLSFws3zxpORDQx3qza73suAxQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cPW0qGi4rdYUohAvj8QeKFESvX9/PkoqZZGf4BAwK62RusKsOQ2ylMref4yyGVu/b
 qZrr/PdETlgvVdgNRnW+vP3MfhHMNp/MZIVGZVzRbunas9g4rrYtBL2rgmyWsBW7Zx
 VKJLxtF7ubFwaZR1HxRRh1G9isW5h5Lj490B7zmQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PE6Pfh060932
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 09:06:25 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 09:06:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 09:06:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PE6PpC032236;
 Mon, 25 Sep 2023 09:06:25 -0500
Date: Mon, 25 Sep 2023 09:06:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>,
 <b-kapoor@ti.com>, <bb@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/6] drivers: firmware: ti_sci: Get SCI revision only
 if TIFS/SYSFW is up
Message-ID: <20230925140625.pwl6dlm4s25fl7at@grimace>
References: <20230922103954.3454891-1-n-francis@ti.com>
 <20230922103954.3454891-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230922103954.3454891-4-n-francis@ti.com>
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

On 16:09-20230922, Neha Malcom Francis wrote:
> When setting up boot media to load the TIFS binary in legacy boot flow
> (followed by J721E), get_timer() is called which calls dm_timer_init()
> which then gets the tick-timer: mcu_timer0. mcu_timer0 uses k3_clks
> (clock controller) and k3_pds (power controller) from the dmsc node that
> forces probe of the ti_sci driver of TIFS that hasn't been loaded yet!
> Running ti_sci_cmd_get_revision from the probe leads to panic since no
> TIFS and board config binaries have been loaded yet. Resolve this by
> moving ti_sci_cmd_get_revision to ti_sci_get_handle_from_sysfw as a
> common point of invocation for both legacy and combined boot flows.
> 
> Before doing this, it is important to go through whether any sync points
> exist where revision is needed before ti_sci_get_handle_from_sysfw is
> invoked. Going through the code along with boot tests on both flows
> ensures that there are none.

Please provide bootlogs for one board of the following SoCs in the
diffstat for us to be sure.

* AM65 (sysfw gen1), J721e(tifs gen1), AM64(sysfw gen2-Sitara), J7200(tifs
  gen2-Jacinto), J721s2(tifs-dm/Jacinto), AM62x(tifs-dm/Sitara)

> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 72f572d824..45406e24d2 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2690,6 +2690,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  const
>  struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
>  {
> +	int ret;
> +
>  	if (!sci_dev)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -2703,6 +2705,11 @@ struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
>  	if (!handle)
>  		return ERR_PTR(-EINVAL);
>  
> +	ret = ti_sci_cmd_get_revision(handle);
> +
> +	if (ret)
> +		return ret;
> +
>  	return handle;
>  }
>  
> @@ -2825,11 +2832,9 @@ static int ti_sci_probe(struct udevice *dev)
>  	list_add_tail(&info->list, &ti_sci_list);
>  	ti_sci_setup_ops(info);
>  
> -	ret = ti_sci_cmd_get_revision(&info->handle);
> -
>  	INIT_LIST_HEAD(&info->dev_list);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
