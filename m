Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA12C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 23:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A398819D;
	Mon, 17 Jun 2024 01:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE19881BF; Mon, 17 Jun 2024 01:47:05 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F231876D3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp80t1718581575t5dcc1dc
X-QQ-Originating-IP: iwp2QfX0UuK71bsYZ7hTT7Bu2TftmTom8VOQOlW089A=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 17 Jun 2024 07:46:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11720346594292049734
Message-ID: <725ABC7E5E2DE0B5+4be845bd-0f40-4719-8b84-90215a0b063b@radxa.com>
Date: Mon, 17 Jun 2024 08:46:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rock-3a: rock5a: rock5b: add USB GADGET
 related configs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, eugen.hristev@collabora.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, gajjar04akash@gmail.com
References: <20240615074639.1686-1-naoki@radxa.com>
 <479eaab5-509a-4f30-97d3-e8fa60c8d117@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <479eaab5-509a-4f30-97d3-e8fa60c8d117@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0
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

Hi,

On 6/16/24 18:24, Jonas Karlman wrote:
> On 2024-06-15 09:46, FUKAUMI Naoki wrote:
>> add USB GADGET related configs for USB OTG port on ROCK 3A/5A/5B.
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>>   configs/rock-3a-rk3568_defconfig | 6 ++++++
>>   configs/rock5a-rk3588s_defconfig | 6 ++++++
>>   configs/rock5b-rk3588_defconfig  | 1 +
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
>> index 66ac2f6d7a..0568a73038 100644
>> --- a/configs/rock-3a-rk3568_defconfig
>> +++ b/configs/rock-3a-rk3568_defconfig
>> @@ -37,6 +37,8 @@ CONFIG_CMD_MMC=y
>>   CONFIG_CMD_PCI=y
>>   CONFIG_CMD_POWEROFF=y
>>   CONFIG_CMD_USB=y
>> +CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>   # CONFIG_CMD_SETEXPR is not set
>>   CONFIG_CMD_PMIC=y
>>   CONFIG_CMD_REGULATOR=y
>> @@ -50,6 +52,7 @@ CONFIG_SPL_SYSCON=y
>>   CONFIG_SCSI_AHCI=y
>>   CONFIG_AHCI_PCI=y
>>   CONFIG_SPL_CLK=y
>> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>>   CONFIG_ROCKCHIP_GPIO=y
>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>   CONFIG_MISC=y
>> @@ -90,4 +93,7 @@ CONFIG_USB_OHCI_HCD=y
>>   CONFIG_USB_OHCI_GENERIC=y
>>   CONFIG_USB_DWC3=y
>>   CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_USB_FUNCTION_ROCKUSB=y
>>   CONFIG_ERRNO_STR=y
>> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
>> index c09e6655f0..e06052cd80 100644
>> --- a/configs/rock5a-rk3588s_defconfig
>> +++ b/configs/rock5a-rk3588s_defconfig
>> @@ -27,6 +27,8 @@ CONFIG_CMD_GPT=y
>>   CONFIG_CMD_I2C=y
>>   CONFIG_CMD_MMC=y
>>   CONFIG_CMD_USB=y
>> +CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>   # CONFIG_CMD_SETEXPR is not set
>>   CONFIG_CMD_REGULATOR=y
>>   # CONFIG_SPL_DOS_PARTITION is not set
>> @@ -37,6 +39,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SPL_REGMAP=y
>>   CONFIG_SPL_SYSCON=y
>>   CONFIG_SPL_CLK=y
>> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>>   CONFIG_ROCKCHIP_GPIO=y
>>   CONFIG_SYS_I2C_ROCKCHIP=y
>>   CONFIG_MISC=y
>> @@ -67,4 +70,7 @@ CONFIG_USB_OHCI_HCD=y
>>   CONFIG_USB_OHCI_GENERIC=y
>>   CONFIG_USB_DWC3=y
>>   CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_USB_FUNCTION_ROCKUSB=y
> 
> I do not think there is any usb port that use dr_mode otg/peripheral,
> so enabling gadget support probably have no impact on ROCK 5A.
> 
> Regards,
> Jonas

my patch 2/3 doesn't add "dr_mode = "host";", so it will be "otg".
I may need to fix upstream dts first...

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> 
>>   CONFIG_ERRNO_STR=y
>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>> index fc118cea7b..80a2f2fed5 100644
>> --- a/configs/rock5b-rk3588_defconfig
>> +++ b/configs/rock5b-rk3588_defconfig
>> @@ -39,6 +39,7 @@ CONFIG_CMD_MMC=y
>>   CONFIG_CMD_PCI=y
>>   CONFIG_CMD_USB=y
>>   CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>   # CONFIG_CMD_SETEXPR is not set
>>   CONFIG_CMD_REGULATOR=y
>>   # CONFIG_SPL_DOS_PARTITION is not set
> 
> 
