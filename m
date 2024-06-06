Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB0BC41513
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EB6881DB;
	Thu,  6 Jun 2024 18:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="NiTSQ7AS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2F288216; Thu,  6 Jun 2024 18:25:49 +0200 (CEST)
Received: from shout11.mail.de (shout11.mail.de [IPv6:2001:868:100:600::f153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6D7881A1
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
 by shout11.mail.de (Postfix) with ESMTPS id A84F124192F;
 Thu,  6 Jun 2024 18:25:46 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
 by shout02.mail.de (Postfix) with ESMTP id 8CAC3240E59;
 Thu,  6 Jun 2024 18:25:46 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
 by postfix01.mail.de (Postfix) with ESMTP id 6DC8580076;
 Thu,  6 Jun 2024 18:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1717691146;
 bh=uuyq9V0oAZ1rd+zZWG9LZekPUw+xxzrKcjQQJc5SLNQ=;
 h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
 b=NiTSQ7ASYfWu0r0rpY49XFnrEnhHEi3mPO8zna/QaKVsEf158do+Bxz3H4USWT8dX
 hywRezbNdxr7yGwUrwpQtjP9cdqoaSAHGr7R/bvowcYyvxa5QHTqHwmVCAOg3TtMDJ
 V2o/WHamiCfM+Mflj5Gv9qir6IGOwrR9AqcEo9S23jVNkv+angs48qcMyUdbQS/tLN
 bGpqlHBkGCSEJYLnPhJnK55dqHwI57hjLROBZRBa/lKlSSY0DR8ZirRzRifnwbmoOb
 CpZaOh+mFkletYn7evV+KRJQAYMU5xJPbA6jCJplS48XdsGi1AUrmdGKXMSBRLjOEq
 X4Dm2dUsyJRcw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 4E7AC240A6E;
 Thu,  6 Jun 2024 18:25:43 +0200 (CEST)
Message-ID: <0c74113b-aad6-4931-8832-651618b31692@mail.de>
Date: Thu, 6 Jun 2024 18:25:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi R6C
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240605155413.226629-1-seb-dev@mail.de>
 <3c422e9f-3cd8-4b24-83f1-d4ad6e7641eb@cherry.de>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <3c422e9f-3cd8-4b24-83f1-d4ad6e7641eb@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 6108
X-purgate-ID: 154282::1717691146-957EB338-D5E0890E/2/58690639258
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

thanks for your feedback!

Am 06.06.2024 um 16:53 schrieb Quentin Schulz:
> Hi Sebastian,
> 
> On 6/5/24 5:36 PM, Sebastian Kropatsch wrote:
>> [You don't often get email from seb-dev@mail.de. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip RK3588s.
>> It comes with 4GB or 8GB of RAM, a microSD card slot, optional 32GB eMMC
>> storage, one M.2 M-Key connector, one RTL8211F 1GbE and one RTL8125
>> 2.5GbE Ethernet port, one USB 2.0 Type-A and one USB 3.0 Type-A port, a
>> HDMI port, a 30-pin GPIO header as well as multiple buttons and LEDs.
>>
>> Add initial support for this board using the upstream devicetree sources.
>>
>> Tests in U-Boot proper:
>> - Booting from eMMC works
>> - 1GbE Ethernet works using the eth_eqos driver (tested by ping)
>> - 2.5GbE Ethernet works using the eth_rtl8169 driver (tested by ping),
>>    but the status LEDs on this specific port currently aren't working
>> - NVMe SSD in M.2 socket does get recognized (tested with `nvme scan`
>>    followed by `nvme details`)
>>
>> Kernel commit:
>> d5f1d7437451 ("arm64: dts: rockchip: Add support for NanoPi R6C")
>>
>> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
>> ---
>>
>> Hello!
>>
>> The Ethernet status LEDs which sit directly on the 2.5GbE port using the
>> RTL8169 driver don't light up when connected and I couldn't figure out
>> why. The other port with a RTL8211F has no problems with the LEDs.
>> Have there been occurrences like this in combination with the RTL8125?
>> I'm trying to figure out if this is something that could be solved in
>> the devicetree or if this is a potential driver bug.
>>
>> Secondly, the default active network device in U-Boot is the 1GbE one.
>> I believe it would make sense to make the 2.5GbE device the default
>> active one since this one is labeled "LAN", whereas the 1GbE is labeled
>> "WAN". However, since the 2.5GbE device is PCIe-based, it only shows up
>> in U-Boot proper after using the `pci enum` command (shows up as in gets
>> listed in `net list` and `dm tree`).
>> Do you have any tips on the preferred approach to handle this switch of
>> the default active net device? Is this even a sensible thing to include
>> in U-Boot in your opinion?
>>
>> Thanks for your feedback!
>>
>> Best regards,
>> Sebastian
>>
>> ---
>>   arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi   |  3 +
>>   arch/arm/mach-rockchip/rk3588/Kconfig         | 13 +++
>>   board/friendlyelec/nanopi-r6c-rk3588s/Kconfig | 12 +++
>>   .../nanopi-r6c-rk3588s/MAINTAINERS            |  7 ++
>>   configs/nanopi-r6c-rk3588s_defconfig          | 83 +++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst               |  1 +
>>   include/configs/nanopi-r6c-rk3588s.h          | 12 +++
>>   7 files changed, 131 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
>>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
>>   create mode 100644 configs/nanopi-r6c-rk3588s_defconfig
>>   create mode 100644 include/configs/nanopi-r6c-rk3588s.h
>>
>> diff --git a/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi 
>> b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..853ed58cfe
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3588s-u-boot.dtsi"
>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig 
>> b/arch/arm/mach-rockchip/rk3588/Kconfig
>> index 820e979abb..0e232ddfb9 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -78,6 +78,18 @@ config TARGET_NANOPCT6_RK3588
>>            Power: 5.5*2.1mm DC Jack, 12VDC input
>>            Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm 
>> (with case)
>>
>> +config TARGET_NANOPI_R6C_RK3588
> 
> Please add the S at the end of the symbol.

u-boot-next currently has two other RK3588s boards, which are Rock5A
and Indiedroid Nova. Both do not have the S at the end of the symbol:

	config TARGET_ROCK5A_RK3588
	[...]
	config TARGET_NOVA_RK3588

Which is why I haven't included the S. Should we update those as well?
I suppose in this case I should also update '/include/configs/nanopi-
r6c-rk3588s.h' which currently reads:

> diff --git a/include/configs/nanopi-r6c-rk3588s.h b/include/configs/nanopi-r6c-rk3588s.h
> new file mode 100644
> index 0000000000..e05856f3ce
> --- /dev/null
> +++ b/include/configs/nanopi-r6c-rk3588s.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __NANOPI_R6C_RK3588_H
> +#define __NANOPI_R6C_RK3588_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#endif /* __NANOPI_R6C_RK3588_H */

(end '/include/configs/nanopi-r6c-rk3588s.h')
If this should not be updated to add an S, let me know. I'll send a v2
when I know :)

> 
> Otherwise looking good to me. I'm wondering if we shouldn't do something 
> for boards which do not need a -u-boot.dtsi. Here it's needed because 
> U-Boot would include rk3588-u-boot.dtsi automatically (because of 
> CONFIG_SYS_SOC being rk3588) instead of rk3588s-u-boot.dtsi. Maybe it's 
> too much headache for the benefit :)
> 
> Cheers,
> Quentin

Ah yes, I was wondering if my mostly empty rk3588s-nanopi-r6c-
u-boot.dtsi was even needed, since I don't know much about the inner
workings of U-Boot. I believe it would be nice to not need this file,
but I have no idea how complex and maintainable an implementation would
be. If it's complex I'd say no, since having those *u-boot.dtsi files
don't hurt that much in my opinion :)

Best regards,
Sebastian
