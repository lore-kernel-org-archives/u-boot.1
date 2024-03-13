Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D0DC54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 15:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D03D87DFF;
	Wed, 13 Mar 2024 16:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JyoanBcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7F087E3A; Wed, 13 Mar 2024 16:33:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D1A87DF9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 16:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=78b9=KU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710343960;
 bh=w0lxfmgL76Ky8m8quy9dRL3D2DMZ9cTtkS7m7diMiCo=;
 b=JyoanBcR3F+nigYxjzCYbyEliJ6X9poE2SzpEENIbAT/i3DFGwCX64crtA80bNOzAAsqjP0l7
 2iu2WikV2/GD3vzlRHQCYpm4eSX9fVXKxnBdSvhXRWFghleb/uduRy8Dll6YB57d1Cu2aJdSU1y
 cIlTTqA9J/fRiXWdQSoEJdllQDmbS8racYVWB/wtqzm/+SF5VISr3Dg7eg8KhVNoC6RzK/hOvj5
 cETf5IgWRkZsLf9/W/qk7tW9EH8IbMipy7gIQQmjvVMInzWOfvn3cvDqqBxTHzbIPxFu/yOg+P8
 xc0Vr8PqsnCbtFxaB9ToUqGEeY12hkbLMr1CoAen9psQ==
Message-ID: <ff2e3b61-e7bf-47db-9c48-9fba0c84ac83@kwiboo.se>
Date: Wed, 13 Mar 2024 16:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rockchip: rk3328: regenerate defconfigs
To: Kever Yang <kever.yang@rock-chips.com>, wens@kernel.org
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Tianling Shen <cnsztl@gmail.com>, David
 Bauer <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Loic Devulder <ldevulder@suse.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Banglang Huang
 <banglang.huang@foxmail.com>, "Matwey V. Kornilov"
 <matwey.kornilov@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
References: <20240212135111.1767734-1-wens@kernel.org>
 <20240212135111.1767734-4-wens@kernel.org>
 <5d174a17-72f8-4ba2-b1de-ca72dc5291ba@rock-chips.com>
 <CAGb2v64Qt6=AC3DcTYGzQFJR-VeE+x+fkYsDDmTB32539sbXng@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAGb2v64Qt6=AC3DcTYGzQFJR-VeE+x+fkYsDDmTB32539sbXng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f1c716a57683b0b1535223
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

Hi Kever and Chen-Yu,

On 2024-03-13 15:43, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Mar 13, 2024 at 6:29 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>>
>> Hi Chen-Yu,
>>
>> On 2024/2/12 21:51, Chen-Yu Tsai wrote:
>>
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> Regenerate RK3328 defconfigs after adding imply statements.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  configs/evb-rk3328_defconfig                  | 3 ---
>>  configs/nanopi-r2c-plus-rk3328_defconfig      | 3 ---
>>  configs/nanopi-r2c-rk3328_defconfig           | 3 ---
>>  configs/nanopi-r2s-rk3328_defconfig           | 3 ---
>>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ---
>>  configs/orangepi-r1-plus-rk3328_defconfig     | 3 ---
>>  configs/roc-cc-rk3328_defconfig               | 3 ---
>>  configs/rock-pi-e-rk3328_defconfig            | 3 ---
>>  configs/rock64-rk3328_defconfig               | 3 ---
>>  9 files changed, 27 deletions(-)
>>
>> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
>> index 995bfd0558b1..c3bde3e5c457 100644
>> --- a/configs/evb-rk3328_defconfig
>> +++ b/configs/evb-rk3328_defconfig
>> @@ -30,7 +30,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -70,8 +69,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>
>> There is no this config in the all these boards when I check the code on next,
>>
>> which cause the conflict when apply this patch.
> 
> I can respin, but should I still base my patches on Jonas's series?
> I don't see them in next.

The series "rockchip: rk3328: Update defconfigs, DTs and enable boot
from SPI" [1] that this and some of the other patches depends on is
missing in your for-next branch. Should we rebase on your for-next
or will you pick that series? :-)

[1] https://patchwork.ozlabs.org/cover/1900345/

Regards,
Jonas

> 
> ChenYu
> 
>>
>> Thanks,
>>
>> - Kever
>>
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_MOTORCOMM=y
>> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
>> index 1cb0ed855398..1b0fa27ced16 100644
>> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
>> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_MOTORCOMM=y
>> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
>> index 59801328deda..edf24623da2a 100644
>> --- a/configs/nanopi-r2c-rk3328_defconfig
>> +++ b/configs/nanopi-r2c-rk3328_defconfig
>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_MOTORCOMM=y
>> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
>> index 61914b1650d2..32c99dfecb86 100644
>> --- a/configs/nanopi-r2s-rk3328_defconfig
>> +++ b/configs/nanopi-r2s-rk3328_defconfig
>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_MOTORCOMM=y
>> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
>> index 968110c8cd6f..f554a284d930 100644
>> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
>> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus-lts.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
>> index 7038f09f202c..162032460fe0 100644
>> --- a/configs/orangepi-r1-plus-rk3328_defconfig
>> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
>> index 7d81a715ef25..02be1102697b 100644
>> --- a/configs/roc-cc-rk3328_defconfig
>> +++ b/configs/roc-cc-rk3328_defconfig
>> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_REALTEK=y
>> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
>> index ddd482dd0195..ac6d6c5df772 100644
>> --- a/configs/rock-pi-e-rk3328_defconfig
>> +++ b/configs/rock-pi-e-rk3328_defconfig
>> @@ -32,7 +32,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_REALTEK=y
>> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
>> index 01e447448513..718fb8f2025c 100644
>> --- a/configs/rock64-rk3328_defconfig
>> +++ b/configs/rock64-rk3328_defconfig
>> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> -CONFIG_MISC_INIT_R=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>> -CONFIG_MISC=y
>> -CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y

