Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E1C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2395E87F52;
	Fri,  5 Apr 2024 10:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N17knXPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E2687D8E; Fri,  5 Apr 2024 10:20:01 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B9D88488
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415523d9824so19345525e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712305199; x=1712909999;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WKP0P78SUqWZrEyX8yd8psXFXshmKdf1erVhYXB7/kY=;
 b=N17knXPw5hvOEUgJG8SW2zk2upELcT4NB2AiBXDlEgBtAMrm1aeIbs94XxWC5kCp50
 CcZ5C0W3t32QsOtE8zCsdowgS9sYOjQeM7Im4sIe4CGOvWlgS7+hVYVaT0ktbS1fdgqS
 aLJQFTWMvIXYbufprFN4M39sTXDSxADOLqsuIR6Pb9RaVEmT538kV5HY++C5liBUDDrA
 dgmne/GpwIPY6b1N3OXs/OOc8bSArUzBainBWdFX1QoNWPe8ZpqSytGsV+GUOIivvhzo
 EKSywX+bAAMQiAXWSFuYFABcGmeNY7qeTCqAuPFRyREHSYykEUmVJcIXgP19DHhg2gl6
 +RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305199; x=1712909999;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WKP0P78SUqWZrEyX8yd8psXFXshmKdf1erVhYXB7/kY=;
 b=M0AVCsWLNkg1WAnrM5VYt4ZzNJOOmGdRhnUzT8NSWbzMnT87C58uHIAF85MqE+tiBw
 d3XD+DP/e9ryA3RlGejds4+HrML+8OQ2qCVjJJyNFc/ECGffEvLaF+08pwa+Lnsl8S/w
 dkOyYC69havFmsMbVnpV9p+325lB/E2IgdQgQYjGAerlIiMlrDwB5mQT9lrYy4zaTcAd
 TmA5Ym7H5+dh2QiSaWv5Sqw3Wv4ek8UdrL3AtLxrRwkYAy6v8F+7UJDKeBc7yhRLQ2KT
 W4YgYU7GzTwuli0u/aDn3vA4d8CLoq6V/2L4sHb6eeH32Rxfs53KCod7qR6sXd+SFF9Q
 kkHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5mxLoxW7NMt/rTP3pIhAT8gtakNVhpEGzQRz7ab1LwpMLUuXQ+T/Q4dpdsIuXm1eKnuG4L9JIb2AmD6lq5id8hcFkwQ==
X-Gm-Message-State: AOJu0YzZZ58aVAM3aZ/qh8WVlzPHzgeLoia76Ld+aN5n2rlPxTKd8htF
 7zlME2WSUXKWTpygTvrCIGzMoMJtcMEExR7w3YR3pno3BTabaDMqVUEKpwVejxAUPnkqooBwtjK
 p
X-Google-Smtp-Source: AGHT+IFx5EvLwLJVIhwFQSaLjGEi1NiJtG1tD+6NxJBtADjtpQJJKcO1eqKs79G+tCmbmBXyUgDvVQ==
X-Received: by 2002:a05:600c:1d25:b0:413:f4d1:199e with SMTP id
 l37-20020a05600c1d2500b00413f4d1199emr752090wms.31.1712305199131; 
 Fri, 05 Apr 2024 01:19:59 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 dr20-20020a5d5f94000000b0033ea499c645sm1443447wrb.4.2024.04.05.01.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:19:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Alex
 Kiernan <alex.kiernan@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Ying-Chun
 Liu <paul.liu@linaro.org>
Subject: Re: [PATCH 4/4] fastboot: integrate block flashing back-end
In-Reply-To: <20240306185921.1854109-4-dimorinny@google.com>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-4-dimorinny@google.com>
Date: Fri, 05 Apr 2024 10:19:57 +0200
Message-ID: <87o7aofcgi.fsf@baylibre.com>
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

Thank you for the patch and sorry for the review delay.

On mer., mars 06, 2024 at 18:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> 1. Get partition info/size
> 2. Erase partition
> 3. Flash partition
> 4. BCB
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Alex Kiernan <alex.kiernan@gmail.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> ---
>  drivers/fastboot/fb_command.c |  8 ++++++++
>  drivers/fastboot/fb_common.c  | 15 +++++++++++----
>  drivers/fastboot/fb_getvar.c  |  8 +++++++-
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index f95f4e4ae1..67ebe02efa 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -9,6 +9,7 @@
>  #include <env.h>
>  #include <fastboot.h>
>  #include <fastboot-internal.h>
> +#include <fb_block.h>
>  #include <fb_mmc.h>
>  #include <fb_nand.h>
>  #include <part.h>
> @@ -331,6 +332,10 @@ void fastboot_data_complete(char *response)
>   */
>  static void __maybe_unused flash(char *cmd_parameter, char *response)
>  {
> +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
> +					   image_size, response);
> +
>  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
>  		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
>  					 image_size, response);
> @@ -351,6 +356,9 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
>   */
>  static void __maybe_unused erase(char *cmd_parameter, char *response)
>  {
> +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		fastboot_block_erase(cmd_parameter, response);
> +
>  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
>  		fastboot_mmc_erase(cmd_parameter, response);
>  
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 3576b06772..7602653c0b 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -97,16 +97,23 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
>  		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
>  	};
> -	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
> -					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
>  
> -	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> +	int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +					CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +	if (device == -1) {
> +		device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
> +					    CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
> +	}
> +	char *bcb_iface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,

Can this be made const?

With the above addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> +					     CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc");
> +
> +	if (device == -1)
>  		return -EINVAL;
>  
>  	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
>  		return -EINVAL;
>  
> -	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
> +	ret = bcb_find_partition_and_load(bcb_iface, device, "misc");
>  	if (ret)
>  		goto out;
>  
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index f65519c57b..71507009ab 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -8,6 +8,7 @@
>  #include <fastboot.h>
>  #include <fastboot-internal.h>
>  #include <fb_mmc.h>
> +#include <fb_block.h>
>  #include <fb_nand.h>
>  #include <fs.h>
>  #include <part.h>
> @@ -114,7 +115,12 @@ static int getvar_get_part_info(const char *part_name, char *response,
>  	struct disk_partition disk_part;
>  	struct part_info *part_info;
>  
> -	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
> +	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
> +		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
> +						 response);
> +		if (r >= 0 && size)
> +			*size = disk_part.size * disk_part.blksz;
> +	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
>  		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
>  					       response);
>  		if (r >= 0 && size)
> -- 
> 2.44.0.278.ge034bb2e1d-goog
