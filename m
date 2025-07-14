Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A57BC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 16:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F056D82E37;
	Mon, 14 Jul 2025 18:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="x1V489P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3730B82F14; Mon, 14 Jul 2025 18:46:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDC382CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 18:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752511593;
 bh=Aa0ELChnI3U2lHZNfkYTp98rjzv0SFsGEKgDM6MF2ns=;
 b=x1V489P3E+L+T3tuugvJ4qTqsfKQclP89rOUtpEoSVqbsHnjjaMyVTYIIAhI+LDrc7s4JOoks
 ZievnSznhYjnOgP+FFdhj7jCQ3Z+TOwnw4O9k3p1i/o3UYkc13+oj6R0mg8fdLep7Vpr8JPHxzY
 vcadsu/x0SEYJ1Mh2tMH6dyFkM88SBpb7uPXz1UibGrzuoRy1uBK3j08z5SQ2OeXqXc92pt6Z3S
 +4hmg7XygBcA2kAXH+KtLb2JXkSxsL4h5Ix7IMgDEzzfNj1R0zf2a2L36ChtSz5IhEI2ZC76tMi
 FwYvngrVT3FTZhpeiXx3W1bmY/MlutlbSRVfyyivvbMA==
X-Forward-Email-ID: 687534662fde68b42d1b5539
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4b2fe7eb-f6d3-47dd-a2e6-d577ba60a806@kwiboo.se>
Date: Mon, 14 Jul 2025 18:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: rockchip: Add Radxa ROCK 4D
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250711230613.217996-1-jonas@kwiboo.se>
 <20250711230613.217996-5-jonas@kwiboo.se>
 <6034d52d-36ff-469a-8113-afaa9c26682f@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6034d52d-36ff-469a-8113-afaa9c26682f@cherry.de>
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

Hi Quentin,

On 7/14/2025 6:35 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/12/25 1:06 AM, Jonas Karlman wrote:
>> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
>> numerous top-tier functions, features, and expansion options.
>>
>> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
>> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
>> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
>>
>> Features tested on a Radxa ROCK 4D v1.112:
>> - SPI Flash boot
>> - Ethernet
>>
>> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
>> or directly from USB when the MASKROM button is pressed, booting
>> directly from SD-card is not possible on these boards.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 15 +++++
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>>   configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst           |  1 +
>>   4 files changed, 90 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>>   create mode 100644 configs/rock-4d-rk3576_defconfig
>>
>> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..5056a1cecb83
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3576-u-boot.dtsi"
>> +
>> +&rgmii_phy0 {
>> +	/delete-property/ reset-gpio;
>> +	reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
> 
> Why?
> 
> If the upstream DT is wrong, please fix the upstream DT first and 
> cherry-pick.

This has already been fixed in upstream DT [1], however it is targeted
for v6.17 so not pickable for another 4-6 weeks.

This u-boot.dtsi override fixes it so Ethernet PHY reset can work in
U-Boot until the prop-rename fix has fully landed.

[1] https://lore.kernel.org/all/20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org/

> 
> If it isn't wrong, then can't we simply patch the PHY subsystem/driver 
> to be able to read reset-gpio too instead?

reset-gpios is the correct prop, so fixing DT is what should be done.

Regards,
Jonas

> 
> Cheers,
> Quentin

