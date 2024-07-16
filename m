Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56300C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B60788925;
	Tue, 16 Jul 2024 03:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RRd8IH6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DA08891B; Tue, 16 Jul 2024 03:56:03 +0200 (CEST)
Received: from mail-m127220.xmail.ntesmail.com
 (mail-m127220.xmail.ntesmail.com [115.236.127.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6748887A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=RRd8IH6Qs7y+Mo3AVy1ARetyeqq3WtfRnTzl8PMSlB95brbH05+MbwlszQ0Xii3IG+Xsd9Bditw6QE9l9ISDcMaF1j/fh+P1zdbPbrbylT+tCHTMqQ8GlMrgekcbGm8CLwYWOrKSk9rfNO0/YSbpiFXLM1aHrwwUm/Fo48iBlRE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wH+Gg/XJYrAVGI5/lretoPen/epy44vsCLOM9BdpdE0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 46365900368;
 Tue, 16 Jul 2024 09:55:35 +0800 (CST)
Message-ID: <35a2369e-1020-4412-b86d-654d9b1acf4c@rock-chips.com>
Date: Tue, 16 Jul 2024 09:55:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/4] rockchip: ringneck-px30: enable FIT verification
 in SPL
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
 <20240614-ringneck-no-gadget-v1-2-d3bc6e5088de@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-ringneck-no-gadget-v1-2-d3bc6e5088de@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlOHlZMSkoaHkJPTR1CQ0NWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b940944b03a9kunm46365900368
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6Pww4TjI5GBgUMDwVER8S
 CQsKFBxVSlVKTElKS0JPQkhOQkxJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0xNNwY+
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


On 2024/6/14 19:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This enables FIT verification in SPL for its payload (bl31, u-boot.itb,
> ...). This makes PX30 Ringneck match what happens on other Theobroma
> boards.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 2ec5f72e47a..e7594b7a67b 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -17,8 +17,10 @@ CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_BOOTSTD_FULL=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -111,6 +113,7 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
> +# CONFIG_RSA is not set
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y
>   # CONFIG_EFI_LOADER is not set
>
