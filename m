Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B32C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 09:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E40787B3D;
	Wed,  6 Mar 2024 10:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Cchv151v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7D487B3D; Wed,  6 Mar 2024 10:54:13 +0100 (CET)
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com
 [117.135.214.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2A987FC2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 10:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Cchv151vvQWlZ/GkT4n3AhibzuqnTXng+8jXXV3pJr4eqHGzKEL653097wviVgniGiIuFHZ2BaRNuaerZgiLy4Y5t7S5sl26BtFX+FOhKMzN9uHWzdD6NVHnXk0XTmbel6ZBMm2HaNdSUSGWztpaXoYrMfoWzA+jNrdy46FY4hE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=NdspSX3hdxcIb1Y8WFy2wQ2xp5Lr5TTvfr1CMxdCudc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 879B290041E;
 Wed,  6 Mar 2024 17:53:56 +0800 (CST)
Message-ID: <4a8eb628-146e-4ba2-a719-7506b23762ed@rock-chips.com>
Date: Wed, 6 Mar 2024 17:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5a: enable environment
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Trevor Woerner <twoerner@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Jagan Teki <jagan@edgeble.ai>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-3-twoerner@gmail.com>
 <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMYQ1ZNSRofSR9OSxlKSkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e132f16a803a9kunm879b290041e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6SRw4FDMJPUMXFg4tPA4X
 AR8KCipVSlVKTEtCTEpDQ0hMSEtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNQk1CNwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Eugen,

On 2024/3/5 13:40, Eugen Hristev wrote:
> On 3/5/24 04:10, Trevor Woerner wrote:
>> Following the pattern of other Rockchip devices, enable the U-Boot
>> environment to be stored in MMC. This patch specifically assumes the
>> environment will be stored on the SDcard.
>>
>> Signed-off-by: Trevor Woerner<twoerner@gmail.com>
>> ---
>>   configs/rock5a-rk3588s_defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
>> index a6471a519514..ac6411667d9a 100644
>> --- a/configs/rock5a-rk3588s_defconfig
>> +++ b/configs/rock5a-rk3588s_defconfig
>> @@ -8,6 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>   CONFIG_NR_DRAM_BANKS=2
>>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>> +CONFIG_ENV_SIZE=0x8000
>>   CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>>   CONFIG_ROCKCHIP_RK3588=y
>>   CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>> @@ -48,6 +49,8 @@ CONFIG_CMD_REGULATOR=y
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_OF_LIVE=y
>>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_SYS_MMC_ENV_DEV=1
>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SPL_REGMAP=y
>>   CONFIG_SPL_SYSCON=y
>
> Hi Trevor,
>
> What will happen if there is no Sd-Card, and we boot from eMMC or SPI flash ?
The U-Boot should boot correctly with default env, and  without any env 
from storage.

The env is used for U-Boot preoper, they should come from the same storage.

> The rockchip pattern is usually to have a standard config for all boards and it is
> not stored anywhere.

Do you mean rockchip vendor U-Boot? I think rockchip vendor U-Boot does 
not depends on the  env on storage,

it use default env for boot process and a vendor defined "vendor 
storage" for MAC/SN.


Thanks,

- Kever

>
> Kever, Jonas, please correct me if I am wrong.
>
> Eugen
