Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB8CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 13:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50D784704;
	Tue, 16 Jun 2026 15:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gB0wTIiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE038484C; Tue, 16 Jun 2026 15:05:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46282846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 15:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68bfcf11050so7650513a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781615140; x=1782219940; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/gmSZ3Vj52esmpchwou129GXnW9Ukl4Oo/bJJ8MCBo=;
 b=gB0wTIiR1p6H3Lpv4Ee/DE+20zsqbiEETouj1JbW4XF3lNzJpikcG+8p0Ivo9QuQgC
 XiSanGRMelerxpxQ7kROC79T/OGoLDG+cybTSqTdcaLWVkB7NQyyIkjTuPFtDSWEhzQH
 RE9tTZrwHNJbnXUl2/M3qEb3bF1JsVwnADYBFuvaDfJSqfZgDElU9qiFBza0bg3lsqpF
 NZKKEQ9S8ObiehvPJliWSKYtx5YNKgZebFJHEuCkZCwFI7Q+u4R7xxsQPbFib2v/noAS
 0Zy11WUAkhmi9sx+F+r3xied4Z5EvY7s97GKeZvUHR2d6ZjY6FsWGZng7zGPFV+N+7y2
 5CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781615140; x=1782219940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/gmSZ3Vj52esmpchwou129GXnW9Ukl4Oo/bJJ8MCBo=;
 b=Wgw7ISBrvZrCfQMW/fKAvaCy0cDYl2E/kba/kd5k7THe0fpzS9viQdkJANWrXqIDVy
 nb3r+GzUKz8hQ26mMqNQMp72sEfoB48J3ZtS7/qiaSCtvVSNnGynmTyoL9vsqeOUaG1l
 8HC5xKQOvA0SmzKxiUwl4hrtmzR3HJ44X+EKVutE4qkFi4UsnpdUkQheQgF/GwhoEPTR
 Y+0ZJm8ZDkBysu7nvloiRR7UA4Aj2MUF0gkvqDm9N1BP4sxiYgejWTVbINrpP8GZOm8i
 HDc+wuZH4X6Iv/nFckqb3mYsjLsoXKEY5el0lNnYJLTg1+jInehZna+yqIf36LBHfnEF
 zJXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y7u46K1KJcrWw67Ot2+p5qc4BcBOLSdLUGLenrEVGlniMH3EYLsTXSRfTMnioNbr9oErbATc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywd4IdQBIP8fXpmd/H76V0eNjQbjkUbITY9iHRQiO5oI0Rbx+4A
 GPiNEBMVQn6kPiR3QVhMUe4qzOL+wNKE3R0+vY5YLz8LFb59VcQB1qF1CSgDf/gJumM=
X-Gm-Gg: Acq92OEk20kd6llxuD2ATh/WIAiYgh0Pg4wzgTx22LM8CaUhCVFlzvsMIwarQdfu7nW
 bC2Bfsa33MvBXZgcxh+a4So+g+H8QWPjcgmn4PLWBnH6/tENuh73aVuOngDaj+jq94S5PIphpEq
 OYG4P3Y7md1WGt83V9+vsUtwmdRL8QQTKHrzvYxZ2sbHdxBwBem25+/bR2ZbOOlrFDWJSgR1IMo
 iDk/A5m2n2j0cnh1P/Lz4LlbToSjo24VLwncBM37UqP5d2JOiv1OpQmFuC+XzRAveWQzNuz4OLx
 /qxRaUo0yg0HxMVBrBA5vZKga70FnO2gjwWeLZc+RkgDr1iHG11VCHLK9VIwxAvTNEV5fAaVOHX
 tpqSAiCH0WJDF7AsK4H/qpiTLdzsP8aD2nfes8syo6pRRdQ3yzdcl5VLQ6AnKeEvRZYVGLpv/Qa
 +LJ80eHLIvMwrFq65gkVgm+RMpnOBAbwi2dHNQhiQ9UoStaQNZsu97U7q4qLfTkTk=
X-Received: by 2002:a05:6402:4498:b0:68c:bf82:884c with SMTP id
 4fb4d7f45d1cf-695086dce09mr2032153a12.6.1781615139705; 
 Tue, 16 Jun 2026 06:05:39 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937948fc99sm5190811a12.23.2026.06.16.06.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 06:05:39 -0700 (PDT)
Message-ID: <112fae50-57a4-423a-b41c-9c7142fad61b@linaro.org>
Date: Tue, 16 Jun 2026 15:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <20260616-sngboot-v3-6-6fb0dee8125c@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616-sngboot-v3-6-6fb0dee8125c@oss.qualcomm.com>
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

Hi Balaji,

On 16/06/2026 11:22, Balaji Selvanathan wrote:
> Add a defconfig for booting U-Boot in snagboot mode on Lemans-EVK
> development boards. In this mode, XBL loads U-Boot directly and
> U-Boot immediately enters fastboot over USB for partition flashing.

Assuming this would be used on other platforms too, I'd much rather you
put this in a config fragment.

On the topic of adding snagboot documentation, you should include a
section describing board enablement, what config options are required
(e.g. COUNTER_FREQUENCY).

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
>   and SKIP_RELOCATE as they are now automatically enabled by
>   QCOM_SNAGBOOT_SUPPORT selection
> 
> Changes in v2:
> - Newly introduced in v2
> ---
>  configs/qcom_lemans_snagboot_defconfig | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
> new file mode 100644
> index 00000000000..c7ac07a6cf3
> --- /dev/null
> +++ b/configs/qcom_lemans_snagboot_defconfig
> @@ -0,0 +1,45 @@
> +# Configuration for building U-Boot for snagboot/recovery mode
> +# on Lemans-EVK dev boards.
> +#
> +# For normal production boot, use qcom_lemans_defconfig instead.
> +
> +#include "qcom_defconfig"
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0x1c100000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
> +# SCSI partition type GUID for logfs partition
> +CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
> +# CONFIG_ENV_IS_DEFAULT is not set
> +# CONFIG_ENV_IS_NOWHERE is not set

I'd also like to understand why you have ENV_IS_IN_SCSI enabled here, if
I "snag" my board for example by breaking stdin/out/err and saving the
environment so I no longer get a shell and then I go to run snagboot it
would fail in the same way.

For a recovery mechanism it really shouldn't load a potentially broken
or untrusted environment from the board.

> +
> +CONFIG_QCOM_SNAGBOOT_SUPPORT=y
> +
> +CONFIG_FASTBOOT_FLASH_BLOCK=y
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
> +CONFIG_FASTBOOT_GPT_NAME="gpt"
> +CONFIG_FASTBOOT_MBR_NAME="mbr"
> +
> +# CONFIG_PSCI_RESET is not set
> +
> +CONFIG_COUNTER_FREQUENCY=19200000
> +
> +# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set

Does this cause problems? Please also disable it in the SNAGBOOT_MODE
kconfig option and explain why it has to be disabled.

> +
> +# CONFIG_IOMMU is not set
> +
> +# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
> +
> +# Disable default env file to use CONFIG_BOOTCOMMAND instead
> +# This allows snagboot-specific bootcmd without modifying shared default.env
> +# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set

It would be nice if we could use #include on .env files...

> +
> +# Auto-enter fastboot mode for snagboot
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
> +CONFIG_BOOTDELAY=0

I'd suggest putting this in a new configs/qcom-snagboot.config and have
this defconfig include it.

Thanks,

> 

-- 
// Casey (she/her)

