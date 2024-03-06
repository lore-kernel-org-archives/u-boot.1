Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65416C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6F488008;
	Wed,  6 Mar 2024 13:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TjrBIK3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03545879CC; Wed,  6 Mar 2024 11:51:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967E687947
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 11:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426ApOJt035185;
 Wed, 6 Mar 2024 04:51:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709722284;
 bh=9gc0Pc1E7VE+JFtQIo0h2hHwniWZ7xLhIMMm4yaARq8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TjrBIK3jjDUYvYUKnI7xIYVqBAby0EgdnHVeWkVXcr5XXKpjo60KtDgQmGJSOWHX9
 PCVi+FtEBCtBCBCzWbV7Icv00fxbWcLOTKMom0ds64BQo9I+r/dtiQWYhFsc20BJ4Z
 y/+ilRRLokoJHAw3KMwXQna9VBCS0L4yzQQqoqQM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426ApOGE019193
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 04:51:24 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 04:51:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 04:51:23 -0600
Received: from [172.24.227.70] (a0503533.dhcp.ti.com [172.24.227.70])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426ApHQw095614;
 Wed, 6 Mar 2024 04:51:18 -0600
Message-ID: <e9bb9589-5064-41a2-b883-2f6a7918f5b8@ti.com>
Date: Wed, 6 Mar 2024 16:21:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] boot: Move framebuffer reservation to separate helper
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <agust@denx.de>, <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
 <20240222130811.3878567-4-devarsht@ti.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20240222130811.3878567-4-devarsht@ti.com>
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
> Create separate helper for just reserving framebuffer region without
> creating or enabling simple-framebuffer node.
>
> This is useful for scenarios where user want to preserve the bootloader
> splash screen till OS boots up and display server gets started without
> displaying anything else in between and thus not requiring
> simple-framebuffer.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  boot/fdt_simplefb.c   | 12 +-----------
>  boot/fdt_support.c    | 21 +++++++++++++++++++++
>  include/fdt_support.h |  2 ++
>  3 files changed, 24 insertions(+), 11 deletions(-)
Reviewed-by: Nikhil M Jain <n-jain1@ti.com>
>
> diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
> index b0221eaf2a..837920bd3a 100644
> --- a/boot/fdt_simplefb.c
> +++ b/boot/fdt_simplefb.c
> @@ -107,7 +107,6 @@ static int fdt_simplefb_enable_existing_node(void *blob)
>  #if IS_ENABLED(CONFIG_VIDEO)
>  int fdt_simplefb_enable_and_mem_rsv(void *blob)
>  {
> -	struct fdt_memory mem;
>  	int ret;
>  
>  	/* nothing to do when video is not active */
> @@ -118,15 +117,6 @@ int fdt_simplefb_enable_and_mem_rsv(void *blob)
>  	if (ret)
>  		return ret;
>  
> -	/* nothing to do when the frame buffer is not defined */
> -	if (gd->video_bottom == gd->video_top)
> -		return 0;
> -
> -	/* reserved with no-map tag the video buffer */
> -	mem.start = gd->video_bottom;
> -	mem.end = gd->video_top - 1;
> -
> -	return fdtdec_add_reserved_memory(blob, "framebuffer", &mem, NULL, 0, NULL,
> -					  FDTDEC_RESERVED_MEMORY_NO_MAP);
> +	return fdt_add_fb_mem_rsv(blob);
>  }
>  #endif
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 090d82ee80..07aa7337e8 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -22,6 +22,9 @@
>  #include <exports.h>
>  #include <fdtdec.h>
>  #include <version.h>
> +#include <video.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
>  
>  /**
>   * fdt_getprop_u32_default_node - Return a node's property or a default
> @@ -2042,6 +2045,24 @@ int fdt_setup_simplefb_node(void *fdt, int node, u64 base_address, u32 width,
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_VIDEO)
> +int fdt_add_fb_mem_rsv(void *blob)
> +{
> +	struct fdt_memory mem;
> +
> +	/* nothing to do when the frame buffer is not defined */
> +	if (gd->video_bottom == gd->video_top)
> +		return 0;
> +
> +	/* reserved with no-map tag the video buffer */
> +	mem.start = gd->video_bottom;
> +	mem.end = gd->video_top - 1;
> +
> +	return fdtdec_add_reserved_memory(blob, "framebuffer", &mem, NULL, 0, NULL,
> +					  FDTDEC_RESERVED_MEMORY_NO_MAP);
> +}
> +#endif
> +
>  /*
>   * Update native-mode in display-timings from display environment variable.
>   * The node to update are specified by path.
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 25600d62f2..4b71b8948d 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -423,6 +423,8 @@ int arch_fixup_memory_node(void *blob);
>  int fdt_setup_simplefb_node(void *fdt, int node, u64 base_address, u32 width,
>  			    u32 height, u32 stride, const char *format);
>  
> +int fdt_add_fb_mem_rsv(void *blob);
> +
>  int fdt_overlay_apply_verbose(void *fdt, void *fdto);
>  
>  int fdt_valid(struct fdt_header **blobp);
Thanks,
Nikhil
