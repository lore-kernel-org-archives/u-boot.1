Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED49D16802
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 10:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8750084132;
	Fri,  9 Jan 2026 11:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B49F8415D; Fri,  9 Jan 2026 11:33:58 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BA683CDF
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 11:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpsz2t1767954784td501971a
X-QQ-Originating-IP: Nc77tWWQsF/9fkF6x/K400mWyb7tV6AOyQxuF6q/fSM=
Received: from [192.168.254.128] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Jan 2026 18:33:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5280802252630799740
Message-ID: <673C2836ACBEBAF3+909bd932-f7a3-44f6-82cf-7c24185cd2a2@radxa.com>
Date: Fri, 9 Jan 2026 19:33:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20260107230747.3552391-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MIqnum/quLXPgZI0kI9R9/UGRy0CaBbcAxbzslg56nj3JgXHd+LMSfLB
 kNZKJ/vZOdobVY41k6FoIEPY65oG1i2mi3rYzIDk4rlebWRgm1z4+Zr6V4ueSaIz9F5cszr
 gJNhJZv/wGfJVkaEf6dYLfww4XTyFFLMBh+r+R9y9UbOoygesNfEPJo4KkgwoTy2vNAw+q1
 WGCERXcf87P4/q67Pz8CcEk+oMd0gnkNK0HFbhKFJGSvMns0ZS4zgALviT7y19odsHOaUch
 2ZMsQE34+w7Wl7sfLbGDyGnCgp21o9yFFJVtHmbEME+MDThxKKC16lr2kNKWiWeRAud16Ea
 2hhzkE/SDoSt9otGPp53gOxApRUH56A1VFn7yucDgiGR92YYK5KZjW/moADeQxY30QZ3AMd
 yS6DhRX39pdhA20BZXjcG0Bv/RSVlKOrsqGi9S9mZRYWDxZmhRxx6gLNEVKbiZ4ugr8muWi
 FDUu/Nu4EZg0vYgqi379lzILHsiZJ0zI6sJPqhfznqHaCp8OQmGID3Ji1JRRI2BA085zKi9
 3UKKzBdzj1zAEyG6dLyhewJABPXOIdFli8VqamNqSWNn12QxpO6eSjOu+fHbETF7ED9TQHk
 GoXCypDJAGiecSMGGIQiY9KLrOTL1O6vtcLyZ4k4ueakp74mhnjAYFK2BIIEu/yNQRYmNyi
 daSXDRj5IPC35ii0ydr22CXGZ0TmbkwO67/LG7qJeclWbHdtB3v89YO7TCKEALdJ4tWODZC
 J7uMTYV3auYRZ/qmq8eMsIXhryBOZohjItfEJzWz8vsvFGYQzoyqqaytFNS4s4hqCY1b7xK
 w5UTg4LeL6d7Hh0nXIru+0dj3RgcwRCHWInklUN7NmLzDqCsjPciunpbb98ph9WrFDyMRKS
 56AzdWI4NzKkaG9sDhOFMUodt28UNMj1/yDzS3IVivGEhF7LJ5iufKOYHvjcH3usPO5Tg5A
 VGtO+vl1j1Mr2vX4nhnx7Z5v0/Y9tqIwfLTBPmGqr63K/uTUcCXGH8yFX
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
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

Hi Jonas,

Thank you very much for your work!

On 1/8/26 08:07, Jonas Karlman wrote:
> This series add initial support for RK3582 support. The RK3582 is a
> variant of the RK3588S with a few ip blocks disabled. What blocks are
> disabled/non-working is indicated by the ip-state in OTP.
> 
> Compared to the vendor U-Boot variant, this mark cpu, the gpu and
> vdec/venc with status=fail instead of removing nodes during DT fixup.
> Linux skip cpu cores marked as failed staring from v5.17-rc1, however
> the GIC driver will generate a harmless WARN_ON that safely can be
> ignored. A patch for Linux will be sent to skip the WARN_ON for
> failed/disabled cpu cores once this lands.
> 
> It is recommended to use rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
> as DRAM init blob RK3582, listed in latest RKBOOT/RK3582MINIALL.ini.
> 
> Changes in v4:
> - Update policy to always fail gpu for RK3582
> - Drop code and comment related to RK3583
> - Update rkvdec node name to match latest mainline Linux DT patches
> - Update commit message to reflect updated policy
> 
> Changes in v3:
> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>    linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
> - Update rkvdec node name to match latest mainline Linux DT patches.
> - Update commit message to reflect updated policy
> 
> Changes in v2:
> - Refactor code to first apply policy to ip-state and then fail cores
>    based on the updated ip-state
> - Add support for failing rkvdec and rkvenc cores
> - Append soc compatible to board model
> - Add patch to add support for ROCK 5C Lite variant
> 
> Jonas Karlman (3):
>    rockchip: Add initial RK3582 support
>    rockchip: rk3588-generic: Enable support for RK3582
>    rockchip: rk3588s-rock-5c: Add support for ROCK 5C Lite variant
> 
>   arch/arm/dts/rk3588-generic.dts        |   4 +-
>   arch/arm/mach-rockchip/rk3588/Kconfig  |   9 +-
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 215 +++++++++++++++++++++++++
>   configs/generic-rk3588_defconfig       |   1 +
>   configs/rock-5c-rk3588s_defconfig      |   1 +
>   doc/board/rockchip/rockchip.rst        |   4 +-
>   6 files changed, 226 insertions(+), 8 deletions(-)

Tested on Radxa E52C:

cpu-code: 35 82
ip-state: 00 04 00 (otp)
ip-state: c0 9e 04 (policy)
remove cpu-map cluster2
fail gpu
fail rkvdec1
fail rkvenc1
fail cpu cpu@600
fail cpu cpu@700

and on Radxa ROCK 5C Lite:

cpu-code: 35 82
ip-state: 10 00 00 (otp)
ip-state: 30 9e 04 (policy)
remove cpu-map cluster1
rename cpu-map cluster2
fail gpu
fail rkvdec1
fail rkvenc1
fail cpu cpu@400
fail cpu cpu@500


For the whole series,

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.
