Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5898CC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 05:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A618805B;
	Thu, 28 Mar 2024 06:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2E387F13; Thu, 28 Mar 2024 06:24:44 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C441387DE6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S5ONLh074406;
 Thu, 28 Mar 2024 13:24:23 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 13:24:20 +0800
Date: Thu, 28 Mar 2024 13:24:18 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Chanho Park <chanho61.park@samsung.com>, Shiji Yang
 <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Message-ID: <ZgT_AiqbX6zpLmMd@swlinux02>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S5ONLh074406
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

Hi Heinrich,

On Thu, Mar 21, 2024 at 07:11:47PM +0100, Heinrich Schuchardt wrote:
> The differences between the Milk-V Mars board and the VisionFive 2 board
> are small enough that we can support both using the same U-Boot build.
> 
> * The model and compatible property are taken from proposed Linux patches.
> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
> * The second Ethernet port is not available.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	do not overwrite /soc/i2c@12050000/eeprom@50/compatible
> 	
> ---
>  board/starfive/visionfive2/spl.c | 99 ++++++++++++++++++++++++++++----
>  1 file changed, 87 insertions(+), 12 deletions(-)
> 
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 1b49945d11b..e0e33cb37ba 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -67,6 +87,49 @@ static const struct starfive_vf2_pro starfive_verb[] = {
>  		"tx-internal-delay-ps", "0"},
>  };
>  
> +void spl_fdt_fixup_mars(void *fdt)
> +{
> +	static const char compat[] = "milkv,mars\0starfive,jh7110";
> +	u32 phandle;
> +	u8 i;
> +	int offset;
> +	int ret;
> +
> +	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
> +	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> +			   "Milk-V Mars");
> +
> +	/* gmac0 */
> +	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
> +	phandle = fdt_get_phandle(fdt, offset);
> +	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
> +
> +	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> +	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
> +	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
> +	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> +			   JH7110_AONCLK_GMAC0_RMII_RTX);
> +
> +	/* gmac1 */
> +	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
> +			   "status", "disabled");
> +
> +	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
> +		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
> +
> +		if (starfive_verb[i].value)

Should this be milk_v_mars[i].value ?

> +			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
> +					      dectoul(milk_v_mars[i].value, NULL));
> +		else
> +			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
> +
> +		if (ret) {
> +			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
> +				break;
> +		}
> +	}
> +}
> +
