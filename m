Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A87D111A0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 04:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A7A890F8;
	Mon,  4 Nov 2024 05:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CN4H55t7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01C088EAF; Mon,  4 Nov 2024 05:48:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A86289137
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 05:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A44mc6A091830;
 Sun, 3 Nov 2024 22:48:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730695718;
 bh=72KtQAfinMtlqYN2W61vrC49anZyOWbr3xGrszaqCjw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CN4H55t7FtnCpKNfk8nwmD3EjXweO3iWO24LualiXGpQL1wANA4NkW1YyFtty2M4c
 iGmRY1iIdGBM/tcPi3lYUMBMDeMTYWiPrOJ5uWFbqMIceyMfY0EKBbjLC/3XdI2gFG
 cM4+3+yUt5XyxFTjGYnHVVBeVGBfv3LTxKeU/koM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A44mcd6093655
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 3 Nov 2024 22:48:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 22:48:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 22:48:37 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A44mVb6086198;
 Sun, 3 Nov 2024 22:48:33 -0600
Message-ID: <db93ece3-12a4-452f-87f0-3acd247e7c3c@ti.com>
Date: Mon, 4 Nov 2024 10:18:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] board: phytec: common: k3: Apply SoM-specific
 overlays to OS device tree
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.co>, <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
 <20241030164815.1763506-7-w.egorov@phytec.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241030164815.1763506-7-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 30/10/24 22:18, Wadim Egorov wrote:
> Our SoMs are available in multiple configurations, managed via device
> tree overlays. To determine the specific variant in use, we read the
> EEPROM and apply the appropriate overlays during boot to the device tree
> used by the OS.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   board/phytec/common/k3/board.c | 73 ++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 3d7e090ccaa..346b2b6491a 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -6,7 +6,9 @@
>   
>   #include <env_internal.h>
>   #include <fdt_support.h>
> +#include <dm/ofnode.h>
>   #include <spl.h>
> +#include <malloc.h>
>   #include <asm/arch/hardware.h>
>   
>   #include "../am6_som_detection.h"
> @@ -97,8 +99,79 @@ int board_late_init(void)
>   #endif
>   
>   #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
> +static int fdt_apply_overlay_from_fit(const char *overlay_path, void *fdt)
> +{
> +	u64 loadaddr;
> +	ofnode node;
> +	int ret;
> +
> +	node = ofnode_path(overlay_path);
> +	if (!ofnode_valid(node))
> +		return -FDT_ERR_NOTFOUND;
> +
> +	ret = ofnode_read_u64(node, "load", &loadaddr);
> +	if (ret)
> +		return ret;
> +
> +	return fdt_overlay_apply_verbose(fdt, (void *)loadaddr);
> +}
> +
> +static void fdt_apply_som_overlays(void *blob)
> +{
> +	void *fdt_copy;
> +	u32 fdt_size;
> +	struct phytec_eeprom_data data;
> +	int err;
> +
> +	fdt_size = fdt_totalsize(blob);
> +	fdt_copy = malloc(fdt_size);
> +	if (!fdt_copy)
> +		goto fixup_error;
> +
> +	memcpy(fdt_copy, blob, fdt_size);
> +
> +	err = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
> +	if (err)
> +		goto fixup_error;
> +
> +	if (phytec_get_am6_rtc(&data) == 0) {
> +		err = fdt_apply_overlay_from_fit("/fit-images/som-no-rtc", fdt_copy);
> +		if (err)
> +			goto fixup_error;
> +	}
> +
> +	if (phytec_get_am6_spi(&data) == PHYTEC_EEPROM_VALUE_X) {
> +		err = fdt_apply_overlay_from_fit("/fit-images/som-no-spi", fdt_copy);
> +		if (err)
> +			goto fixup_error;
> +	}
> +
> +	if (phytec_get_am6_eth(&data) == 0) {
> +		err = fdt_apply_overlay_from_fit("/fit-images/som-no-eth", fdt_copy);
> +		if (err)
> +			goto fixup_error;
> +	}
> +
> +	if (phytec_am6_is_qspi(&data)) {
> +		err = fdt_apply_overlay_from_fit("/fit-images/som-qspi-nor", fdt_copy);
> +		if (err)
> +			goto fixup_error;
> +	}
> +
> +	memcpy(blob, fdt_copy, fdt_size);
> +
> +cleanup:
> +	free(fdt_copy);
> +	return;
> +
> +fixup_error:
> +	pr_err("Failed to apply SoM overlays\n");
> +	goto cleanup;
> +}
> +
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
> +	fdt_apply_som_overlays(blob);
>   	fdt_copy_fixed_partitions(blob);
>   
>   	return 0;

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
