Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5013CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E5F87158;
	Tue, 14 Nov 2023 09:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="laWdeo+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E648C870F5; Tue, 14 Nov 2023 09:12:25 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EA08719F
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507ad511315so7676610e87.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699949542; x=1700554342;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2IER8DYUQwlolNoELiHh4xOy1QFvam7DS6KoAoKMJY=;
 b=laWdeo+YINFQr0Ddmr50mngtwLpFgEUSzGW5VK37Kkj50IC4/6yWIkWI9b0BqVBU9A
 ZHQ8VrmuftcKbxYEwilLcr4wZyUcgkxUoSYRHEOwq/493C/rBB3DKCQtwLuFxP5RO2Wy
 +dkbuTQSQtu9HMDNI9GUmq1OkHAc2OGkEk5g+T7TgaNlmcMv1cTQYBuGSBjYTTZgxrDJ
 TwU0AHhrCP4d56s6sRPNWLBwRQQTcEKK6TWf3syA9vywzB6n9Kks15n8dppRJjbXcXQt
 amtCN9FnXH3IlT7XF8vw1stQytK3Hfi+SuPRQUIKiEEF54FL8ObkP2C6Z864ZhUI+E/j
 hD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699949542; x=1700554342;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B2IER8DYUQwlolNoELiHh4xOy1QFvam7DS6KoAoKMJY=;
 b=eD6d03ecZGlTPWvcqDfoU+TVgU7WaKeuijWiIHzeYQEhdh4t+sMwNcOXEwjcSaSf2g
 uazP8kw6teHgp7CiRoSPxpIsV7Az8Y8czbE/SzvaqgnI3C62NAhbvHRn1g2lbUWdwrur
 xb6Jp6kT+gCO7q7oLFlq8N91UjWPSVzhLYwsVhL5BoEggFFwCTX3BrrRR+CahCpzY84J
 jxpItyJXrDE6ojolFa6i2p9R2Qs2cqEQb6hx/xphYvqa4vnYlGKeFhMTLTiuREZzCQGa
 phi/P2+cA5EKRyvN+e9xTBwBJuPB5R9IFmwDPaKaVVExIcXxhK9dnDn0rmVV1bqODYIV
 rQqg==
X-Gm-Message-State: AOJu0YzsRJFCk+QVDugiSwuUp3N1VXGDgxUQEedbFr8mff9tLG4rq/lN
 zjIiLU3qMh22qoXvvzwDo/G2pg==
X-Google-Smtp-Source: AGHT+IEbgqxIuHtM0nHxeRG0CizO/f2GADBOm1+2yda2ac+3w/ybwLdzWbWlKZDi9jg2Hpe+3mE/OQ==
X-Received: by 2002:a19:6406:0:b0:503:95b:db0a with SMTP id
 y6-20020a196406000000b00503095bdb0amr6179531lfb.12.1699949541827; 
 Tue, 14 Nov 2023 00:12:21 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b0040a4835d2b2sm12069475wmb.37.2023.11.14.00.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:12:21 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Eugeniu
 Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, Simon
 Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>, Cody
 Schuffelen <schuffelen@google.com>
Subject: Re: [PATCH v2 1/2] cmd: bcb: support various block device
 interfaces for BCB command
In-Reply-To: <20231110055955.3370681-2-dimorinny@google.com>
References: <20231110055955.3370681-1-dimorinny@google.com>
 <20231110055955.3370681-2-dimorinny@google.com>
Date: Tue, 14 Nov 2023 09:12:20 +0100
Message-ID: <87y1f0n47v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitrii,

Thank you for  your patch.

On ven., nov. 10, 2023 at 05:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Currently BCB command-line, C APIs and implementation only
> support MMC interface. Extend it to allow various block
> device interfaces.
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Cody Schuffelen <schuffelen@google.com>

I confirm that I can reboot from U-Boot into other modes (like
fastbootd) using the default U-boot environment

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/Kconfig                  |  1 -
>  cmd/bcb.c                    | 70 ++++++++++++++++++++++--------------
>  doc/android/bcb.rst          | 34 +++++++++---------
>  drivers/fastboot/fb_common.c |  2 +-
>  include/bcb.h                |  5 +--
>  5 files changed, 65 insertions(+), 47 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index df6d71c103..ce2435bbb8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -981,7 +981,6 @@ config CMD_ADC
>  
>  config CMD_BCB
>  	bool "bcb"
> -	depends on MMC
>  	depends on PARTITIONS
>  	help
>  	  Read/modify/write the fields of Bootloader Control Block, usually
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index 02d0c70d87..6594ac6439 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -25,6 +25,7 @@ enum bcb_cmd {
>  	BCB_CMD_STORE,
>  };
>  
> +static enum uclass_id bcb_uclass_id = UCLASS_INVALID;
>  static int bcb_dev = -1;
>  static int bcb_part = -1;
>  static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) = { { 0 } };
> @@ -53,6 +54,9 @@ static int bcb_is_misused(int argc, char *const argv[])
>  
>  	switch (cmd) {
>  	case BCB_CMD_LOAD:
> +		if (argc != 3 && argc != 4)
> +			goto err;
> +		break;
>  	case BCB_CMD_FIELD_SET:
>  		if (argc != 3)
>  			goto err;
> @@ -115,7 +119,7 @@ static int bcb_field_get(char *name, char **fieldp, int *sizep)
>  	return 0;
>  }
>  
> -static int __bcb_load(int devnum, const char *partp)
> +static int __bcb_load(const char *iface, int devnum, const char *partp)
>  {
>  	struct blk_desc *desc;
>  	struct disk_partition info;
> @@ -123,14 +127,14 @@ static int __bcb_load(int devnum, const char *partp)
>  	char *endp;
>  	int part, ret;
>  
> -	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, devnum);
> +	desc = blk_get_dev(iface, devnum);
>  	if (!desc) {
>  		ret = -ENODEV;
>  		goto err_read_fail;
>  	}
>  
>  	/*
> -	 * always select the USER mmc hwpart in case another
> +	 * always select the first hwpart in case another
>  	 * blk operation selected a different hwpart
>  	 */
>  	ret = blk_dselect_hwpart(desc, 0);
> @@ -161,18 +165,20 @@ static int __bcb_load(int devnum, const char *partp)
>  		goto err_read_fail;
>  	}
>  
> +	bcb_uclass_id = desc->uclass_id;
>  	bcb_dev = desc->devnum;
>  	bcb_part = part;
> -	debug("%s: Loaded from mmc %d:%d\n", __func__, bcb_dev, bcb_part);
> +	debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev, bcb_part);
>  
>  	return CMD_RET_SUCCESS;
>  err_read_fail:
> -	printf("Error: mmc %d:%s read failed (%d)\n", devnum, partp, ret);
> +	printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp, ret);
>  	goto err;
>  err_too_small:
> -	printf("Error: mmc %d:%s too small!", devnum, partp);
> +	printf("Error: %s %d:%s too small!", iface, devnum, partp);
>  	goto err;
>  err:
> +	bcb_uclass_id = UCLASS_INVALID;
>  	bcb_dev = -1;
>  	bcb_part = -1;
>  
> @@ -182,15 +188,23 @@ err:
>  static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  		       char * const argv[])
>  {
> +	int devnum;
>  	char *endp;
> -	int devnum = simple_strtoul(argv[1], &endp, 0);
> +	char *iface = "mmc";
> +
> +	if (argc == 4) {
> +		iface = argv[1];
> +		argc--;
> +		argv++;
> +	}
>  
> +	devnum = simple_strtoul(argv[1], &endp, 0);
>  	if (*endp != '\0') {
>  		printf("Error: Device id '%s' not a number\n", argv[1]);
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	return __bcb_load(devnum, argv[2]);
> +	return __bcb_load(iface, devnum, argv[2]);
>  }
>  
>  static int __bcb_set(char *fieldp, const char *valp)
> @@ -298,7 +312,7 @@ static int __bcb_store(void)
>  	u64 cnt;
>  	int ret;
>  
> -	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, bcb_dev);
> +	desc = blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
>  	if (!desc) {
>  		ret = -ENODEV;
>  		goto err;
> @@ -317,7 +331,7 @@ static int __bcb_store(void)
>  
>  	return CMD_RET_SUCCESS;
>  err:
> -	printf("Error: mmc %d:%d write failed (%d)\n", bcb_dev, bcb_part, ret);
> +	printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id, bcb_dev, bcb_part, ret);
>  
>  	return CMD_RET_FAILURE;
>  }
> @@ -328,11 +342,11 @@ static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return __bcb_store();
>  }
>  
> -int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp)
> +int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp)
>  {
>  	int ret;
>  
> -	ret = __bcb_load(devnum, partp);
> +	ret = __bcb_load(iface, devnum, partp);
>  	if (ret != CMD_RET_SUCCESS)
>  		return ret;
>  
> @@ -385,21 +399,23 @@ static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  U_BOOT_CMD(
>  	bcb, CONFIG_SYS_MAXARGS, 1, do_bcb,
>  	"Load/set/clear/test/dump/store Android BCB fields",
> -	"load  <dev> <part>       - load  BCB from mmc <dev>:<part>\n"
> -	"bcb set   <field> <val>      - set   BCB <field> to <val>\n"
> -	"bcb clear [<field>]          - clear BCB <field> or all fields\n"
> -	"bcb test  <field> <op> <val> - test  BCB <field> against <val>\n"
> -	"bcb dump  <field>            - dump  BCB <field>\n"
> -	"bcb store                    - store BCB back to mmc\n"
> +	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
> +	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
> +	"bcb set   <field> <val>        - set   BCB <field> to <val>\n"
> +	"bcb clear [<field>]            - clear BCB <field> or all fields\n"
> +	"bcb test  <field> <op> <val>   - test  BCB <field> against <val>\n"
> +	"bcb dump  <field>              - dump  BCB <field>\n"
> +	"bcb store                      - store BCB back to <interface>\n"
>  	"\n"
>  	"Legend:\n"
> -	"<dev>   - MMC device index containing the BCB partition\n"
> -	"<part>  - MMC partition index or name containing the BCB\n"
> -	"<field> - one of {command,status,recovery,stage,reserved}\n"
> -	"<op>    - the binary operator used in 'bcb test':\n"
> -	"          '=' returns true if <val> matches the string stored in <field>\n"
> -	"          '~' returns true if <val> matches a subset of <field>'s string\n"
> -	"<val>   - string/text provided as input to bcb {set,test}\n"
> -	"          NOTE: any ':' character in <val> will be replaced by line feed\n"
> -	"          during 'bcb set' and used as separator by upper layers\n"
> +	"<interface> - storage device interface (virtio, mmc, etc)\n"
> +	"<dev>       - storage device index containing the BCB partition\n"
> +	"<part>      - partition index or name containing the BCB\n"
> +	"<field>     - one of {command,status,recovery,stage,reserved}\n"
> +	"<op>        - the binary operator used in 'bcb test':\n"
> +	"              '=' returns true if <val> matches the string stored in <field>\n"
> +	"              '~' returns true if <val> matches a subset of <field>'s string\n"
> +	"<val>       - string/text provided as input to bcb {set,test}\n"
> +	"              NOTE: any ':' character in <val> will be replaced by line feed\n"
> +	"              during 'bcb set' and used as separator by upper layers\n"
>  );
> diff --git a/doc/android/bcb.rst b/doc/android/bcb.rst
> index 8861608300..2226517d39 100644
> --- a/doc/android/bcb.rst
> +++ b/doc/android/bcb.rst
> @@ -41,23 +41,25 @@ requirements enumerated above. Below is the command's help message::
>     bcb - Load/set/clear/test/dump/store Android BCB fields
>  
>     Usage:
> -   bcb load  <dev> <part>       - load  BCB from mmc <dev>:<part>
> -   bcb set   <field> <val>      - set   BCB <field> to <val>
> -   bcb clear [<field>]          - clear BCB <field> or all fields
> -   bcb test  <field> <op> <val> - test  BCB <field> against <val>
> -   bcb dump  <field>            - dump  BCB <field>
> -   bcb store                    - store BCB back to mmc
> +   bcb load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>
> +   load <dev> <part>              - load  BCB from mmc <dev>:<part>
> +   bcb set   <field> <val>        - set   BCB <field> to <val>
> +   bcb clear [<field>]            - clear BCB <field> or all fields
> +   bcb test  <field> <op> <val>   - test  BCB <field> against <val>
> +   bcb dump  <field>              - dump  BCB <field>
> +   bcb store                      - store BCB back to <interface>
>  
>     Legend:
> -   <dev>   - MMC device index containing the BCB partition
> -   <part>  - MMC partition index or name containing the BCB
> -   <field> - one of {command,status,recovery,stage,reserved}
> -   <op>    - the binary operator used in 'bcb test':
> -             '=' returns true if <val> matches the string stored in <field>
> -             '~' returns true if <val> matches a subset of <field>'s string
> -   <val>   - string/text provided as input to bcb {set,test}
> -             NOTE: any ':' character in <val> will be replaced by line feed
> -             during 'bcb set' and used as separator by upper layers
> +   <interface> - storage device interface (virtio, mmc, etc)
> +   <dev>       - storage device index containing the BCB partition
> +   <part>      - partition index or name containing the BCB
> +   <field>     - one of {command,status,recovery,stage,reserved}
> +   <op>        - the binary operator used in 'bcb test':
> +                 '=' returns true if <val> matches the string stored in <field>
> +                 '~' returns true if <val> matches a subset of <field>'s string
> +   <val>       - string/text provided as input to bcb {set,test}
> +                 NOTE: any ':' character in <val> will be replaced by line feed
> +                 during 'bcb set' and used as separator by upper layers
>  
>  
>  'bcb'. Example of getting reboot reason
> @@ -91,7 +93,7 @@ The following Kconfig options must be enabled::
>  
>     CONFIG_PARTITIONS=y
>     CONFIG_MMC=y
> -   CONFIG_BCB=y
> +   CONFIG_CMD_BCB=y
>  
>  .. [1] https://android.googlesource.com/platform/bootable/recovery
>  .. [2] https://source.android.com/devices/bootloader
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 4e9d9b719c..2a6608b28c 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -105,7 +105,7 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
>  		return -EINVAL;
>  
> -	return bcb_write_reboot_reason(mmc_dev, "misc", boot_cmds[reason]);
> +	return bcb_write_reboot_reason("mmc", mmc_dev, "misc", boot_cmds[reason]);
>  }
>  
>  /**
> diff --git a/include/bcb.h b/include/bcb.h
> index 5edb17aa47..a6326523c4 100644
> --- a/include/bcb.h
> +++ b/include/bcb.h
> @@ -9,10 +9,11 @@
>  #define __BCB_H__
>  
>  #if IS_ENABLED(CONFIG_CMD_BCB)
> -int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp);
> +int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp);
>  #else
>  #include <linux/errno.h>
> -static inline int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp)
> +static inline int bcb_write_reboot_reason(const char *iface, int devnum,
> +					  char *partp, const char *reasonp)
>  {
>  	return -EOPNOTSUPP;
>  }
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog
