Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1226EC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A3A832C0;
	Tue,  8 Apr 2025 05:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="c4/sz33g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A752832B3; Tue,  8 Apr 2025 05:20:33 +0200 (CEST)
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com
 [101.71.155.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26CB82F47
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8ba6;
 Tue, 8 Apr 2025 11:20:27 +0800 (GMT+08:00)
Message-ID: <3b2c2607-e6eb-486c-83ad-21512e129657@rock-chips.com>
Date: Tue, 8 Apr 2025 11:20:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] rockchip: Enable meminfo and rng commands for
 Generic RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhJTFZLSUgdQxlNSBhKQkpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961369ddc403afkunm1101e8ba6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6PAw4PjJDH0I0Pxw4MQpI
 CT8aCRdVSlVKTE9PS0NJT0lDSUtOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTENMNwY+
DKIM-Signature: a=rsa-sha256;
 b=c4/sz33gsQSQpQFgKCppmsHG/gnnFVGvpXFC6RtF4iKWaRFemncV7MRttDA69IStmAYI0S3R9//akFwc/YKl3lgIQKgfF4swp9gKfvX9YAj0kJn0zhGKHIJIMjEPs5vR4enLTRlfzPYp1XX6yey/2VbFhiPkmYsanTciZpJ2vfs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JRG7Twiow6oqEwLW06d77uSW81cYOqDYcvT2fYrvgEI=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/6 08:24, Jonas Karlman wrote:
> The meminfo and rng commands are helpful for testing, enable them.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/generic-rk3588_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index 51e31dce3a96..2075584cf564 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MISC=y
> @@ -29,6 +31,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
