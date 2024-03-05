Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9127AC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0155888008;
	Tue,  5 Mar 2024 11:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WBwQ18ZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C9E988015; Tue,  5 Mar 2024 11:29:05 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BE287FD6
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425ASk83091049;
 Tue, 5 Mar 2024 04:28:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709634526;
 bh=vMJ95cJyWv7x+ClXaODq8ufmLLXonLpQHKEV1oQj58o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WBwQ18ZIopHI3KX5kW7TNNEaO5m6+Kp9aQzxxbXzta0lWy1RB6UtbhjNAAikonyXq
 FGbtPyrb9lCOJgzyingpCVk9C29YanFBcpmWvpcr3z/Z77qla5u/RC2f8BPFydoft3
 a7lKjIVFec7Tb/gMKxLGj/nBY+70TyzgBn719TPI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425ASkS7063211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Mar 2024 04:28:46 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 04:28:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 04:28:46 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425ASdtC064205;
 Tue, 5 Mar 2024 04:28:40 -0600
Message-ID: <ec68fa00-b23a-b07a-55e6-1d1e7723167a@ti.com>
Date: Tue, 5 Mar 2024 15:58:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] board: ti: am62x: evm: Update simple-framebuffer node
 in device-tree
Content-Language: en-US
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <20240222130811.3878567-5-devarsht@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240222130811.3878567-5-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 22/02/24 18:38, Devarsh Thakkar wrote:
> Update simple-framebuffer device-tree node by enumerating framebuffer
> related information in existing simple-framebuffer node in Linux
> device-tree file and enabling it.
> 
> In case there is no simple-framebuffer stub detected in Linux kernel
> device-tree and video is still active, then update the device-tree to
> reserve the framebuffer region for the active splash screen.
> 
> This helps preserve the splash screen till the display server takes over
> after OS is booted.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  board/ti/am62x/evm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index 88e02155ee..c825af3368 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -15,6 +15,7 @@
>  #include <cpu_func.h>
>  #include <k3-ddrss.h>
>  #include <fdt_support.h>
> +#include <fdt_simplefb.h>
>  #include <asm/io.h>
>  #include <asm/arch/hardware.h>
>  #include <dm/uclass.h>
> @@ -118,3 +119,21 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
>  #endif
>  }
>  #endif
> +
> +#if defined(CONFIG_OF_BOARD_SETUP)
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	int ret = -1;
> +
> +	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB))
> +		ret = fdt_simplefb_enable_and_mem_rsv(blob);
> +

This needs to be protected with IS_ENABLED(CONFIG_VIDEO) too to avoid below
errors when CONFIG_VIDEO is disabled :

/home/devarsht/ti/ti-u-boot/board/ti/am62x/evm.c:102: undefined reference to
`video_is_active'

aarch64-none-linux-gnu-ld.bfd:
/home/devarsht/ti/ti-u-boot/board/ti/am62x/evm.c:104: undefined reference to
`fdt_add_fb_mem_rsv' \

I will send out a V2 of this patch.

Regards
Devarsh
> +	/* If simplefb is not enabled and video is active, then at least reserve
> +	 * the framebuffer region to preserve the splash screen while OS is booting
> +	 */
> +	if (ret && video_is_active())
> +		return fdt_add_fb_mem_rsv(blob);
> +
> +	return 0;
> +}
> +#endif
