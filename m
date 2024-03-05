Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE84C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FE588003;
	Tue,  5 Mar 2024 10:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pgSXc1Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEB188003; Tue,  5 Mar 2024 10:17:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDCA88012
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8d7b=KL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709630237;
 bh=eoTUoif08KsuODTkyXcJGZApQRr9Nda7K9/WiavxrMM=;
 b=pgSXc1YvfgC/oKC7e3oBfay0hEjddjXfNxRhH9K5OJ3hUgA4V5gq74eRIZnk2A/qFSj/0IMWD
 B+NJykEAsIicMYz9YuFtufiGtCYjN1h+vqtUSJi79lJ9Qvr7p4+GvmlnPTyezxufe4VEw6iZWxR
 8TxX7hKCYiBDgJQLZTNcSeb1SPrqwhkMxzYtbSEr5UJvZJmarFB6ttnYxw2y5ThOmjifxDEdMxv
 yax+FvoRyzeOoCdpTkSLqZv4ghO2Yfno6I9C42g7NbO04ciiJfiM1k5jWMZUeejkzZKPTMHGZtH
 6choL0bUDYroZAdsHC1PhYXFytS2Ocj95XX7OJRJ/sMA==
Message-ID: <78c8c8d1-ecff-4d48-a6f7-da433254e4ab@kwiboo.se>
Date: Tue, 5 Mar 2024 10:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5a: enable environment
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, Trevor Woerner
 <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, Weizhao
 Ouyang <o451686892@gmail.com>, Jagan Teki <jagan@edgeble.ai>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-3-twoerner@gmail.com>
 <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e6e31b0c58f90fb4aa5072
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

On 2024-03-05 06:40, Eugen Hristev wrote:
> On 3/5/24 04:10, Trevor Woerner wrote:
>> Following the pattern of other Rockchip devices, enable the U-Boot
>> environment to be stored in MMC. This patch specifically assumes the
>> environment will be stored on the SDcard.
>>
>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>> ---
>>  configs/rock5a-rk3588s_defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
>> index a6471a519514..ac6411667d9a 100644
>> --- a/configs/rock5a-rk3588s_defconfig
>> +++ b/configs/rock5a-rk3588s_defconfig
>> @@ -8,6 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>  CONFIG_NR_DRAM_BANKS=2
>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>> +CONFIG_ENV_SIZE=0x8000
>>  CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>>  CONFIG_ROCKCHIP_RK3588=y
>>  CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>> @@ -48,6 +49,8 @@ CONFIG_CMD_REGULATOR=y
>>  CONFIG_SPL_OF_CONTROL=y
>>  CONFIG_OF_LIVE=y
>>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_SYS_MMC_ENV_DEV=1
>>  CONFIG_SPL_DM_SEQ_ALIAS=y
>>  CONFIG_SPL_REGMAP=y
>>  CONFIG_SPL_SYSCON=y
> 
> 
> Hi Trevor,
> 
> What will happen if there is no Sd-Card, and we boot from eMMC or SPI flash ?

Agree, we should not blindly enable env and expect that it can be stored
on sd-card. If anything, it should preferably be saved/loaded from the
device where TPL/SPL was booted from.

Personally I always run my devices with ENV_IS_NOWHERE, with standard
boot and extlinux or efi as the preferred way to boot, I do not see why
normal end-users with a single OS really have a need for a saved env,
please educate me :-)

> 
> The rockchip pattern is usually to have a standard config for all boards and it is
> not stored anywhere.

Unfortunately lots of rockchip boards have blindly enabled ENV_IN_MMC
and force it to use sd-card. However, before enabling same forced
behavior on new boards I would recommend ensuring adding support for
allowing env to follow same load order as FIT (spl-boot-order).

Regards,
Jonas

> 
> Kever, Jonas, please correct me if I am wrong.
> 
> Eugen

