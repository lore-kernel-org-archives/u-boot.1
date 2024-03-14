Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE205C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 06:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D5887EDC;
	Thu, 14 Mar 2024 07:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="K1qn56EP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B896987F40; Thu, 14 Mar 2024 07:47:12 +0100 (CET)
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com
 [220.197.32.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF8087CFF
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 07:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=K1qn56EPf+l3ql8jBwQRk6bXbtD9z1gYxDAcvLSpnTUQ412jqKGW7H+NSJ2BmZmvP4JNaL3TJM9AkpiGUxRAkU7+opVN2F6Wb55CiiupY+uvynz0tnvuJEy6VFYfPl7zU/nnwf4/03EG8b3EQJUVbXpt1I/lT7nu0iQ2m0fnX1w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=D3vlX0oEru3Cd26MqiVlNWb9KMXDa7hZmqQYCjBRgKs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EB4389002DB;
 Thu, 14 Mar 2024 14:46:26 +0800 (CST)
Message-ID: <f2beb621-eb2e-46b2-8341-3219964bc0f6@rock-chips.com>
Date: Thu, 14 Mar 2024 14:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rockchip: rk3328: regenerate defconfigs
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, wens@kernel.org
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Levin Du <djw@t-chip.com.cn>,
 Suniel Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240212135111.1767734-1-wens@kernel.org>
 <20240212135111.1767734-4-wens@kernel.org>
 <5d174a17-72f8-4ba2-b1de-ca72dc5291ba@rock-chips.com>
 <CAGb2v64Qt6=AC3DcTYGzQFJR-VeE+x+fkYsDDmTB32539sbXng@mail.gmail.com>
 <ff2e3b61-e7bf-47db-9c48-9fba0c84ac83@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <ff2e3b61-e7bf-47db-9c48-9fba0c84ac83@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgZQlZKT0xPSEhJGUIZQkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3bb6556803a9kunmeb4389002db
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6LRw5GDMWMC8sFEs0CjMd
 OBUwCylVSlVKTEpLSEJDTENCTkJJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEpJSzcG
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


On 2024/3/13 23:32, Jonas Karlman wrote:
> Hi Kever and Chen-Yu,
>
> On 2024-03-13 15:43, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Wed, Mar 13, 2024 at 6:29 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>>> Hi Chen-Yu,
>>>
>>> On 2024/2/12 21:51, Chen-Yu Tsai wrote:
>>>
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> Regenerate RK3328 defconfigs after adding imply statements.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>>> ---
>>>   configs/evb-rk3328_defconfig                  | 3 ---
>>>   configs/nanopi-r2c-plus-rk3328_defconfig      | 3 ---
>>>   configs/nanopi-r2c-rk3328_defconfig           | 3 ---
>>>   configs/nanopi-r2s-rk3328_defconfig           | 3 ---
>>>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ---
>>>   configs/orangepi-r1-plus-rk3328_defconfig     | 3 ---
>>>   configs/roc-cc-rk3328_defconfig               | 3 ---
>>>   configs/rock-pi-e-rk3328_defconfig            | 3 ---
>>>   configs/rock64-rk3328_defconfig               | 3 ---
>>>   9 files changed, 27 deletions(-)
>>>
>>> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
>>> index 995bfd0558b1..c3bde3e5c457 100644
>>> --- a/configs/evb-rk3328_defconfig
>>> +++ b/configs/evb-rk3328_defconfig
>>> @@ -30,7 +30,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -70,8 +69,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>
>>> There is no this config in the all these boards when I check the code on next,
>>>
>>> which cause the conflict when apply this patch.
>> I can respin, but should I still base my patches on Jonas's series?
>> I don't see them in next.
> The series "rockchip: rk3328: Update defconfigs, DTs and enable boot
> from SPI" [1] that this and some of the other patches depends on is
> missing in your for-next branch. Should we rebase on your for-next
> or will you pick that series? :-)

Sorry, forgot to pick this series, all patches apply correctly after 
this patch set.


Thanks,

- Kever

>
> [1] https://patchwork.ozlabs.org/cover/1900345/
>
> Regards,
> Jonas
>
>> ChenYu
>>
>>> Thanks,
>>>
>>> - Kever
>>>
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_MOTORCOMM=y
>>> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
>>> index 1cb0ed855398..1b0fa27ced16 100644
>>> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
>>> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
>>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_MOTORCOMM=y
>>> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
>>> index 59801328deda..edf24623da2a 100644
>>> --- a/configs/nanopi-r2c-rk3328_defconfig
>>> +++ b/configs/nanopi-r2c-rk3328_defconfig
>>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_MOTORCOMM=y
>>> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
>>> index 61914b1650d2..32c99dfecb86 100644
>>> --- a/configs/nanopi-r2s-rk3328_defconfig
>>> +++ b/configs/nanopi-r2s-rk3328_defconfig
>>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_MOTORCOMM=y
>>> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
>>> index 968110c8cd6f..f554a284d930 100644
>>> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
>>> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
>>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus-lts.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
>>> index 7038f09f202c..162032460fe0 100644
>>> --- a/configs/orangepi-r1-plus-rk3328_defconfig
>>> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
>>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
>>> index 7d81a715ef25..02be1102697b 100644
>>> --- a/configs/roc-cc-rk3328_defconfig
>>> +++ b/configs/roc-cc-rk3328_defconfig
>>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_REALTEK=y
>>> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
>>> index ddd482dd0195..ac6d6c5df772 100644
>>> --- a/configs/rock-pi-e-rk3328_defconfig
>>> +++ b/configs/rock-pi-e-rk3328_defconfig
>>> @@ -32,7 +32,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_PHY_REALTEK=y
>>> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
>>> index 01e447448513..718fb8f2025c 100644
>>> --- a/configs/rock64-rk3328_defconfig
>>> +++ b/configs/rock64-rk3328_defconfig
>>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> -CONFIG_MISC_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>>   CONFIG_ROCKCHIP_GPIO=y
>>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>> -CONFIG_MISC=y
>>> -CONFIG_ROCKCHIP_EFUSE=y
>>>   CONFIG_MMC_DW=y
>>>   CONFIG_MMC_DW_ROCKCHIP=y
>>>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
