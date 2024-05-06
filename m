Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A15C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493EE88081;
	Mon,  6 May 2024 12:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cd00Bs7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABEB882AC; Mon,  6 May 2024 12:34:59 +0200 (CEST)
Received: from mail-m12791.qiye.163.com (mail-m12791.qiye.163.com
 [115.236.127.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1F588013
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cd00Bs7EXucMA+EPPBpJcei0NRG/v0e3ij+5qHLO66QWUv+murSQzZTmMvNkqH6hMaM9M76OA4kSzWl5BPIO2kfkhXqE2zKk4U+n+Dbkt4I4do9yRS6oAzbuL0tBPOJthdEkQlp+6hGLu4sZqYwnENeGI4DzezXh+GBVN+I+buE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=ZRfoyK+eQFoJX+hQHAvQ3uMU2J0tRoYxg3UaB7HwV2s=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0D45F9002E5;
 Mon,  6 May 2024 18:34:48 +0800 (CST)
Message-ID: <8b9c8359-e204-4535-9a73-772db46fc159@rock-chips.com>
Date: Mon, 6 May 2024 18:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] rockchip: rk3399-puma: Update SPL_PAD_TO Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhMTlZJH09KTRhIHRofT0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d786f0103a9kunm0d45f9002e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ny46Egw4PTNPLhYYMklRTRgO
 SBlPCzBVSlVKTEpPQkJKTUNCQkhKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk5JNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> On rk3399-puma the FIT payload is located at sector 0x200 compared
> to the more Rockchip common sector 0x4000 offset:
>
>    SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>
> Because FIT payload is located at sector 0x200 and IDBlock is located at
> sector 64, the combined size of TPL+SPL (idbloader.img) cannot take up
> more than 224 KiB:
>
>    (0x200 - 64) x 512 = 0x38000 (224 KiB)
>
> Adjust SPL_PAD_TO to match the used 0x200 sector offset.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from DT sync patch
>
> With this change it should be possible to drop the following u-boot.dtsi
> override and use the default offset = <CONFIG_SPL_PAD_TO>.
>
>    offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
> ---
>   configs/puma-rk3399_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 14a7bc8b1e00..ec7d52a6e13e 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -31,7 +31,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
> -CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_PAD_TO=0x38000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
