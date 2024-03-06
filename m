Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B30C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68A087FE9;
	Wed,  6 Mar 2024 13:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TUyY84YB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CA587BA8; Wed,  6 Mar 2024 11:42:51 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 811B187C61
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 11:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426AgLl6092396;
 Wed, 6 Mar 2024 04:42:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709721741;
 bh=efgZSOSw8V3OjvXOG7H/KogjeEm7v8UwauRDST2vkXM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TUyY84YBch8h74IR6oqpvP46XwuC2bfTGJWY+rDG4vphYg1kPwJYpV1m2Sgo74zyt
 WbWvLlG7XIrMOBQXS5X8YL9HpALes19X7WmewP7v3Wo1fJZzHmkD/ttSjsy6Rmz5XT
 It0UiAuhoRFvGnTrdd5fLqqCzSzgaW2tWf85Vd9s=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426AgL7k120491
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 04:42:21 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 04:42:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 04:42:21 -0600
Received: from [172.24.227.70] (a0503533.dhcp.ti.com [172.24.227.70])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426AgEOa068062;
 Wed, 6 Mar 2024 04:42:15 -0600
Message-ID: <e1d07285-c252-4ab9-afad-8819bc16aa2a@ti.com>
Date: Wed, 6 Mar 2024 16:12:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] boot: fdt_simplefb: Enumerate framebuffer info from
 video handoff
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <agust@denx.de>, <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <20240222130811.3878567-2-devarsht@ti.com>
Content-Language: en-US
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20240222130811.3878567-2-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Hi Devarsh,

On 22/02/24 18:38, Devarsh Thakkar wrote:
> Enable and update simple-framebuffer node using the video handoff
> bloblist if video was enabled at SPL stage and corresponding video
> bloblist was received at u-boot proper with necessary parameters.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  boot/fdt_simplefb.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
Reviewed-by: Nikhil M Jain <n-jain1@ti.com>
>
> diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
> index 069ced75a7..b0221eaf2a 100644
> --- a/boot/fdt_simplefb.c
> +++ b/boot/fdt_simplefb.c
> @@ -12,6 +12,8 @@
>  #include <asm/global_data.h>
>  #include <linux/libfdt.h>
>  #include <video.h>
> +#include <spl.h>
> +#include <bloblist.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -26,15 +28,29 @@ static int fdt_simplefb_configure_node(void *blob, int off)
>  	struct udevice *dev;
>  	int ret;
>  
> -	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
> -	if (ret)
> -		return ret;
> -	uc_priv = dev_get_uclass_priv(dev);
> -	plat = dev_get_uclass_plat(dev);
> -	xsize = uc_priv->xsize;
> -	ysize = uc_priv->ysize;
> -	bpix = uc_priv->bpix;
> -	fb_base = plat->base;
> +	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
> +		struct video_handoff *ho;
> +
> +		ho = bloblist_find(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho));
> +		if (!ho)
> +			return log_msg_ret("Missing video bloblist", -ENOENT);
> +
> +		xsize = ho->xsize;
> +		ysize = ho->ysize;
> +		bpix = ho->bpix;
> +		fb_base = ho->fb;
> +	} else {
> +		ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
> +		if (ret)
> +			return ret;
> +		uc_priv = dev_get_uclass_priv(dev);
> +		plat = dev_get_uclass_plat(dev);
> +		xsize = uc_priv->xsize;
> +		ysize = uc_priv->ysize;
> +		bpix = uc_priv->bpix;
> +		fb_base = plat->base;
> +	}
> +
>  	switch (bpix) {
>  	case 4: /* VIDEO_BPP16 */
>  		name = "r5g6b5";

Thanks,

Nikhil

