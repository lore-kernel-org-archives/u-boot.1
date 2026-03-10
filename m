Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E92EB1069
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF3583F53;
	Tue, 10 Mar 2026 16:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IEbr8XaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B1C83FDE; Tue, 10 Mar 2026 16:04:25 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D68B8341A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439afc58ac7so10285727f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773155062; x=1773759862; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ykb9R9KxajCU6Rrkk6nXzXKY0EgL6y6GZYWayhuYcZE=;
 b=IEbr8XaLE6eq9fqJB0yO9Civxwi+QxDyLXk5cTknDrtR4HgcefW6weo66q/mzHyAe/
 67NUA2TuBH1IsMV3gce1vuWagnqdluT0JSp8RxVU7nDpsL5O6AdwUitDoqBG46xwxq6p
 lVT3zh2ru3fLaHEHVxirm6B4RHuVJXZkfFiJtvsSgAuMfgVvQcJyAXx7TpNKxJKiTfK6
 VL2zpXN3oAaSqViI7SRhM1jjuBSlrJDlB/onlD4dm/tGNim2D6Ru2HBRvqKgsYA2QTTc
 TaWDtHoNOK0XgQCAIL3V1CD+udTiPVvOV4OBl4T9Ay/r9ayIcEY95xXP4Ee8pKJVizUi
 myDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155062; x=1773759862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ykb9R9KxajCU6Rrkk6nXzXKY0EgL6y6GZYWayhuYcZE=;
 b=TaHOEl+R3DNJYQ0GwEquOgnfjLJYyx28bQ1/I7N/Nd8IvdOuTimNgoOhJjV2DTssd8
 B9AUAuJ6poq/wTMfELEUZbyl8uyjZYhBVe4QPJUWnyLiLIJU6r5s9XlPL4nnYSXM7bbv
 IjEMTu1K+NWiIXod1syw6Y226SMBfkp+fwJhut8B8rW4JE7BaM6UU98u3l9CrP996CNP
 caNDfNGG58gV9Iw64XZQcQha6OFLCMTcNsRWborIUmbQtXumPOFN4MAM67jFbSbKV9ea
 hyTIIdOALntTY5gYtj8Z7Nocs8ulHZzbuDwvpyIHKW6DtghjFFbpA7prfTvFuyUnEaJX
 0c6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmI4UgFF4ADEaLYICiYtu9HokWL/Cjzf46FFioVnZzuqxTStoXxnvM/XmjqBnxmV23v0Ei2Eo=@lists.denx.de
X-Gm-Message-State: AOJu0YyzAuHQqmLxxVNkcAj5WtcyHiEkuysAFpJhEKDe/cHXD2dVDZ5y
 +v9CYySu1Oh/86Ue9xOJPw7LLaz/gL6mv9W18d5I+I9zKgWGQsS39p3W/f7VgvJ2dwN27Q==
X-Gm-Gg: ATEYQzzPIfYciBpHHX9TzF8hTG2FeVH5dToG1wadzjMp0jCC0FhOugi925sjEEg5SFV
 ykUETbKo/4Mb5aV1W2ZJZc1Mrj3zgrhtEWz2xFGxD1T/RV2XYDRXqz5dUtViVAWt4RZgwE6Qyui
 8YdedG1nN1MV4T6ywZkgNnxD5NHzemphq00xlC5f9tID4fCKoCNMrukmB6AHm3Uv144z0gS9v1d
 kfxypyNQ4eYNYJIDvW0BAGZrHRXNJ1C6KRlWran6G2dovmoTgY4GmYyy3+2ZABv3azCQ+2w4jBv
 3FeH5qJbbbNeq0fRDFGYEuF87Y5Nj4d000oyIlc0Wq9bP2pp7HgdR3qzh7K7Lkn+zyq6vnzRUQi
 CKB40ilXx8NSEgqCdA/3cA19RvB7amIL7TebHJxmxUrniYf4X6OcBJN5mIt49uGx7GPQkp3mxfr
 DgmB+rrPKt7pw1f6Z1YDdQVfAE8rWnQ0fEAPdNGI9LFiH+1qwBOQ67KufvfZI8MARo9uEJQT1mV
 PsiBsEURU0k5DFAPMrCQQ==
X-Received: by 2002:a5d:5c8a:0:b0:439:be82:1fd9 with SMTP id
 ffacd0b85a97d-439da555622mr27089467f8f.12.1773155061303; 
 Tue, 10 Mar 2026 08:04:21 -0700 (PDT)
Received: from [10.0.1.128]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d973sm34340267f8f.3.2026.03.10.08.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 08:04:20 -0700 (PDT)
Message-ID: <34d4475a-8353-47c9-86fe-36e67ceecb69@gmail.com>
Date: Tue, 10 Mar 2026 16:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 3/10/26 12:54, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> Call qb save automatically in the board-specific
> spl_board_init(), if SPL_QB option is enabled. This
> makes sure qb_save is called before any image loading
> is done by the SPL.
> 
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> ---
>  arch/arm/include/asm/mach-imx/qb.h | 2 ++
>  arch/arm/mach-imx/Kconfig          | 7 +++++++
>  arch/arm/mach-imx/imx9/Makefile    | 4 +++-
>  arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
>  board/nxp/imx94_evk/spl.c          | 6 +++++-
>  board/nxp/imx95_evk/spl.c          | 6 +++++-
>  6 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
> index 5efe68f0a60..4f923d79e7a 100644
> --- a/arch/arm/include/asm/mach-imx/qb.h
> +++ b/arch/arm/include/asm/mach-imx/qb.h
> @@ -10,4 +10,6 @@
>  
>  bool qb_check(void);
>  int  qb(int qb_dev, int qb_bootdev, bool save);
> +void spl_qb_save(void);
> +
>  #endif
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 17aad696648..069b25c6241 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -71,6 +71,13 @@ config CSF_SIZE
>  	  Define the maximum size for Command Sequence File (CSF) binary
>  	  this information is used to define the image boot data.
>  
> +config SPL_IMX_QB
> +	bool "Run qb save during SPL"
> +	default n
> +	depends on SPL && IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
> +	help
> +	  Run qb save on bootdev automatically during SPL.
> +
>  config CMD_IMX_QB
>  	bool "Support the 'qb' command"
>  	default y
> diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> index 7dee144e0f4..3207013812a 100644
> --- a/arch/arm/mach-imx/imx9/Makefile
> +++ b/arch/arm/mach-imx/imx9/Makefile
> @@ -15,7 +15,9 @@ obj-y += imx_bootaux.o
>  endif
>  
>  ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
> -ifneq ($(CONFIG_XPL_BUILD),y)
> +ifeq ($(CONFIG_XPL_BUILD),y)
> +obj-$(CONFIG_SPL_IMX_QB) += qb.o
> +else
>  obj-$(CONFIG_CMD_IMX_QB) += qb.o
>  endif
>  endif
> diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
> index fc01d8e22e9..79573741d39 100644
> --- a/arch/arm/mach-imx/imx9/qb.c
> +++ b/arch/arm/mach-imx/imx9/qb.c
> @@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
>  
>  	return 0;
>  }
> +
> +void spl_qb_save(void)
> +{
> +	int dev = spl_boot_device();
> +
> +	/** Save QB data on current boot device */
> +	if (qb(dev, dev, true))
> +		printf("QB save failed\n");
> +}
> diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> index cc5b7f9ef0f..1d25795eb17 100644
> --- a/board/nxp/imx94_evk/spl.c
> +++ b/board/nxp/imx94_evk/spl.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>   */
>  
>  #include <hang.h>
> @@ -14,6 +14,7 @@
>  #include <asm/arch/sys_proto.h>
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/mach-imx/ele_api.h>
> +#include <asm/mach-imx/qb.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -44,6 +45,9 @@ void spl_board_init(void)
>  	ret = ele_start_rng();
>  	if (ret)
>  		printf("Fail to start RNG: %d\n", ret);
> +
> +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> +		spl_qb_save();
Does it write to MMC/NOR/SD at every boot? Is that necessary if a quick boot
was performed and the data has not changed?
>  }
>  
>  /* SCMI support by default */
> diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
> index 761a1a4a0f6..35e4458f2b7 100644
> --- a/board/nxp/imx95_evk/spl.c
> +++ b/board/nxp/imx95_evk/spl.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>   */
>  
>  #include <hang.h>
> @@ -13,6 +13,7 @@
>  #include <asm/arch/sys_proto.h>
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/mach-imx/ele_api.h>
> +#include <asm/mach-imx/qb.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -41,6 +42,9 @@ void spl_board_init(void)
>  	ret = ele_start_rng();
>  	if (ret)
>  		printf("Fail to start RNG: %d\n", ret);
> +
> +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> +		spl_qb_save();
>  }
>  
>  void board_init_f(ulong dummy)

Kind regards,
Emanuele

