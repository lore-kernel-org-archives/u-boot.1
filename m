Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF993D44C46
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5886783655;
	Thu, 15 Jan 2026 14:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wXZLnUFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFF780077; Thu, 15 Jan 2026 14:35:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A62A836A3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf5=7V=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768484137;
 bh=B0H4SdCMdnwm29eICpV88u42MbGCWA+0kYj+8YnI9+I=;
 b=wXZLnUFluIIMrnzGanQqgocvRkJKxmI/LuPK37DVjlKzc8LLuwtGuqtSWuh9nzjdyizGM5GnT
 ap8Fpg1w2xBIMPtKpHvHEJX4THuo3Lr0FNsETNA//eNjgYEXjCGT7iKEoVpsLmdk/gk34nHRB7u
 bUKG11r0wWm3nMtN4mPey6LwV8bfBZpK33iqHMrxjt2whcdEXIrmtVENc5uRn5HlL3Wa+SkkI1U
 6l1oeosfN31znm9KH7gXyBdgDSEIW1KBTi2qNQbs8FLcwMsN7ig2UBw7QHTp2O3uWOCYvGHU1jG
 ASgJVcJVdRuNUsqoyuz2ladvhjd6ZvGzBkC1gLb7jUJQ==
X-Forward-Email-ID: 6968ed281104151281d4b8f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7d77e501-2347-4f1e-af36-c82a47dbf126@kwiboo.se>
Date: Thu, 15 Jan 2026 14:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20260110205337.1242457-1-jonas@kwiboo.se>
 <af311e0b-e9df-47b0-9313-93186ca0c14e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <af311e0b-e9df-47b0-9313-93186ca0c14e@cherry.de>
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

On 1/15/2026 1:24 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/10/26 9:53 PM, Jonas Karlman wrote:
>> The NanoPi Zero2 is a small single board computer developed by
>> FriendlyElec, based on the Rockchip RK3528A SoC.
>>
>> Add support for the FriendlyElec NanoPi Zero2 board.
>>
>> Features tested on a FriendlyElec NanoPi Zero2 2407:
>> - SD-card boot
>> - eMMC boot
>> - Ethernet
>> - USB host
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 ++++
>>   arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>>   configs/nanopi-zero2-rk3528_defconfig        | 64 ++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst              |  1 +
>>   4 files changed, 82 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>>   create mode 100644 configs/nanopi-zero2-rk3528_defconfig
>>
>> diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..3e2fbd81da17
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3528-u-boot.dtsi"
>> +
>> +&vdd_arm {
>> +	regulator-init-microvolt = <953000>;
>> +};
>> +
>> +&vdd_logic {
>> +	regulator-init-microvolt = <900000>;
>> +};
> 
> Why? We need an explanation here to know if and when we can get rid of 
> those additions. Why aren't those in the Linux kernel tree?

All prior regulator-init-microvolt props was purged from Linux DTs some
time ago [1], instead of adding a dt-binding for this prop :/

After that change we now need to keep track of any initial microvolt
that should be set by U-Boot in -u-boot.dtsi files.

If I remember correctly these regulators may have been initialized with
too low or high voltage out of reset, and this ensure stable operation.

[1] https://lore.kernel.org/all/20230707162217.675390-1-cristian.ciocaltea@collabora.com/

Regards,
Jonas

> 
> OK to me otherwise.
> 
> Cheers,
> Quentin

