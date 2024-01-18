Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4300C47DB1
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237EE87835;
	Thu, 18 Jan 2024 08:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pxn3+jBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A82687B50; Thu, 18 Jan 2024 08:10:59 +0100 (CET)
Received: from mail-m6032.netease.com (mail-m6032.netease.com [210.79.60.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8522877FE
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Pxn3+jBk+hGTp9quWPkK/jh1WBkLfXlZktAADMBKr1NyBwRNbCyMPq51TL0XdMaA1s6BGqwRFYF9JxzyaGjIOrI3RR59YkWkTc7dvpPHgnK3hexyDzMQQLVCsNso9TlCX45akLULGhplATrSlMEr3R5iBX3AKYIyU0QtK1dVvP8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=P9yqFOvYpEB1zzauhiGFOiFEWoVvwuPMyWiJ9Paadp8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 33E4A9004B3;
 Thu, 18 Jan 2024 15:10:51 +0800 (CST)
Message-ID: <97994d7b-82ca-43e7-b5cf-1bdc73093530@rock-chips.com>
Date: Thu, 18 Jan 2024 15:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/7] board: rockchip: Refactor panel auto-detect code
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: andre.przywara@arm.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jagan@edgeble.ai, jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-2-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240102154654.191055-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxNSFZIHxkeTh0dGkNDSh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b6886132eafkusn33e4a9004b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6GCo4LDwqIhANSg9LHA1L
 SjUaCUNVSlVKTEtOTk1KQ05KQklNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTE9ONwY+
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


On 2024/1/2 23:46, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Make the inability to detect a panel using the auto detection code not
> fail the entire boot process. This means that if the panel ID cannot
> be read we don't set an environment variable for the panel, and if an
> environment variable for the panel is not set we don't attempt to
> update the compatible string. Changes to the code also ensure that
> when there are multiple compatible strings required for the panel
> we use them both, which solves some issues that will pop up soon
> for the Linux driver.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 115 +++++++++++++--------
>   1 file changed, 74 insertions(+), 41 deletions(-)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index 3f1a42d184..3d0c614623 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -40,6 +40,7 @@ struct rg3xx_model {
>   	const char *board;
>   	const char *board_name;
>   	const char *fdtfile;
> +	const bool detect_panel;
>   };
>   
>   enum rgxx3_device_id {
> @@ -54,52 +55,67 @@ enum rgxx3_device_id {
>   
>   static const struct rg3xx_model rg3xx_model_details[] = {
>   	[RG353M] = {
> -		517, /* Observed average from device */
> -		"rk3566-anbernic-rg353m",
> -		"RG353M",
> -		DTB_DIR "rk3566-anbernic-rg353p.dtb", /* Identical devices */
> +		.adc_value = 517, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg353m",
> +		.board_name = "RG353M",
> +		/* Device is identical to RG353P. */
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> +		.detect_panel = 1,
>   	},
>   	[RG353P] = {
> -		860, /* Documented value of 860 */
> -		"rk3566-anbernic-rg353p",
> -		"RG353P",
> -		DTB_DIR "rk3566-anbernic-rg353p.dtb",
> +		.adc_value = 860, /* Documented value of 860 */
> +		.board = "rk3566-anbernic-rg353p",
> +		.board_name = "RG353P",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> +		.detect_panel = 1,
>   	},
>   	[RG353V] = {
> -		695, /* Observed average from device */
> -		"rk3566-anbernic-rg353v",
> -		"RG353V",
> -		DTB_DIR "rk3566-anbernic-rg353v.dtb",
> +		.adc_value = 695, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg353v",
> +		.board_name = "RG353V",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
> +		.detect_panel = 1,
>   	},
>   	[RG503] = {
> -		1023, /* Observed average from device */
> -		"rk3566-anbernic-rg503",
> -		"RG503",
> -		DTB_DIR "rk3566-anbernic-rg503.dtb",
> +		.adc_value = 1023, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg503",
> +		.board_name = "RG503",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
> +		.detect_panel = 0,
>   	},
>   	/* Devices with duplicate ADC value */
>   	[RG353PS] = {
> -		860, /* Observed average from device */
> -		"rk3566-anbernic-rg353ps",
> -		"RG353PS",
> -		DTB_DIR "rk3566-anbernic-rg353ps.dtb",
> +		.adc_value = 860, /* Observed average from device */
> +		.board = "rk3566-anbernic-rg353ps",
> +		.board_name = "RG353PS",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
> +		.detect_panel = 1,
>   	},
>   	[RG353VS] = {
> -		695, /* Gathered from second hand information */
> -		"rk3566-anbernic-rg353vs",
> -		"RG353VS",
> -		DTB_DIR "rk3566-anbernic-rg353vs.dtb",
> +		.adc_value = 695, /* Gathered from second hand information */
> +		.board = "rk3566-anbernic-rg353vs",
> +		.board_name = "RG353VS",
> +		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
> +		.detect_panel = 1,
>   	},
>   };
>   
>   struct rg353_panel {
>   	const u16 id;
> -	const char *panel_compat;
> +	const char *panel_compat[2];
>   };
>   
>   static const struct rg353_panel rg353_panel_details[] = {
> -	{ .id = 0x3052, .panel_compat = "newvision,nv3051d"},
> -	{ .id = 0x3821, .panel_compat = "anbernic,rg353v-panel-v2"},
> +	{
> +		.id = 0x3052,
> +		.panel_compat[0] = "anbernic,rg353p-panel",
> +		.panel_compat[1] = "newvision,nv3051d",
> +	},
> +	{
> +		.id = 0x3821,
> +		.panel_compat[0] = "anbernic,rg353v-panel-v2",
> +		.panel_compat[1] = NULL,
> +	},
>   };
>   
>   /*
> @@ -298,11 +314,10 @@ int rgxx3_detect_display(void)
>   	if (!panel) {
>   		printf("Unable to identify panel_id %x\n",
>   		       (panel_id[0] << 8) | panel_id[1]);
> -		env_set("panel", "unknown");
>   		return -EINVAL;
>   	}
>   
> -	env_set("panel", panel->panel_compat);
> +	env_set("panel", panel->panel_compat[0]);
>   
>   	return 0;
>   }
> @@ -367,13 +382,14 @@ int rgxx3_detect_device(void)
>   		rg3xx_model_details[board_id].board_name);
>   	env_set("fdtfile", rg3xx_model_details[board_id].fdtfile);
>   
> -	/* Detect the panel type for any device that isn't a 503. */
> -	if (board_id == RG503)
> +	/* Skip panel detection for when it is not needed. */
> +	if (!rg3xx_model_details[board_id].detect_panel)
>   		return 0;
>   
> +	/* Warn but don't fail for errors in auto-detection of the panel. */
>   	ret = rgxx3_detect_display();
>   	if (ret)
> -		return ret;
> +		printf("Failed to detect panel type\n");
>   
>   	return 0;
>   }
> @@ -400,7 +416,8 @@ int rk_board_late_init(void)
>   
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
> -	int node, ret;
> +	const struct rg353_panel *panel = NULL;
> +	int node, ret, i;
>   	char *env;
>   
>   	/* No fixups necessary for the RG503 */
> @@ -414,6 +431,12 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   			    rg3xx_model_details[RG353M].board_name,
>   			    sizeof(rg3xx_model_details[RG353M].board_name));
>   
> +	env = env_get("panel");
> +	if (!env) {
> +		printf("Can't get panel env\n");
> +		return 0;
> +	}
> +
>   	/*
>   	 * Check if the environment variable doesn't equal the panel.
>   	 * If it doesn't, update the devicetree to the correct panel.
> @@ -424,12 +447,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   		return -ENODEV;
>   	}
>   
> -	env = env_get("panel");
> -	if (!env) {
> -		printf("Can't get panel env\n");
> -		return -ENODEV;
> -	}
> -
>   	ret = fdt_node_check_compatible(blob, node, env);
>   	if (ret < 0)
>   		return -ENODEV;
> @@ -438,8 +455,24 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (!ret)
>   		return 0;
>   
> -	do_fixup_by_path_string(blob, "/dsi@fe060000/panel@0",
> -				"compatible", env);
> +	/* Panels don't match, search by first compatible value. */
> +	for (i = 0; i < ARRAY_SIZE(rg353_panel_details); i++) {
> +		if (!strcmp(env, rg353_panel_details[i].panel_compat[0])) {
> +			panel = &rg353_panel_details[i];
> +			break;
> +		}
> +	}
> +
> +	if (!panel) {
> +		printf("Unable to identify panel by compat string\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Set the compatible with the auto-detected values */
> +	fdt_setprop_string(blob, node, "compatible", panel->panel_compat[0]);
> +	if (panel->panel_compat[1])
> +		fdt_appendprop_string(blob, node, "compatible",
> +				      panel->panel_compat[1]);
>   
>   	return 0;
>   }
