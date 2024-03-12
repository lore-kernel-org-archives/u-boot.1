Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB90C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 22:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3510887EA3;
	Tue, 12 Mar 2024 23:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="A6SmhMjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7F587F00; Tue, 12 Mar 2024 23:00:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4265787EA3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710280791;
 bh=bkNPrMLv6Tz7rJ+6qjFhY4Ydr05Cdsw5rPnlqvUhXFg=;
 b=A6SmhMjtvhUtHjSWLmkzwXedfdmk922CyLNmu1/fB8xL9sc0dxbBa3Qbcw9eIEPl/mYqOfvwm
 x53X89SuhJV5R3wvZMzF5WCpOrUSwK4R6EBsJaH6Mr831hn1Qh8vEBlUdR+2T8Wxxh0kuGAv1Gi
 Nu0+F30d/88tOP6Bit1aTFVFjchtjSgqmA21cBdhbw8MX1f+41ztXhZ/iB/ctpn7fbXymU8OWyd
 GZJ2+KlhqwFvh8iwGOw5Z25dLm/dvrtppe/TLOXLuup18wkUsxyCwwmocrLs+5ci+M7thGBOx0+
 xQyYXWEXwcXbUWb4Nf2p+0/1g8jrgxQBvkoIOMJD0p5w==
Message-ID: <a3a2556d-d9d6-4e55-af3e-3c0006ffbde5@kwiboo.se>
Date: Tue, 12 Mar 2024 22:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, Christopher
 Obbard <chris.obbard@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
 <82acb904-5d37-4170-ae3d-160da304b0bb@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <82acb904-5d37-4170-ae3d-160da304b0bb@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f0d05608d9ce46e2c27fec
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

Hi Kever,

On 2024-03-11 10:29, Kever Yang wrote:
> Hi Jonas,
> 
> On 2024/2/18 02:35, Jonas Karlman wrote:
>> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
>> into its own board target and update related defconfigs to use the new
>> TARGET_ROCKPI4_RK3399 option.
>>
>> Also move the call to gpt_capsule_update_setup() from the weak function
>> rk_board_late_init() into the main board_late_init() function.
> 
> Please split this part as a separate patch, this is an common code 
> update instead of rockpi board patch.

Will split this into its own patch in v2.

> 
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/board.c                | 10 +++---
>>   arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
>>   board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
>>   board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
>>   .../rockpi4-rk3399}/Makefile                  |  2 +-
>>   .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
>>   board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
>>   configs/rock-4c-plus-rk3399_defconfig         |  2 +-
>>   configs/rock-4se-rk3399_defconfig             |  2 +-
>>   configs/rock-pi-4-rk3399_defconfig            |  2 +-
>>   configs/rock-pi-4c-rk3399_defconfig           |  2 +-
>>   include/configs/rk3399_common.h               | 16 ----------
>>   include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
>>   13 files changed, 95 insertions(+), 65 deletions(-)
>>   create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
>>   create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
>>   rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
>>   rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
> 
> Please add new rockpi4 board files instead of rename, so that evb-rk3399 
> can still available.

This only looks like a rename because the only code that was left in
evb-rk3399.c was the rock-pi-4 specific capsule update code moved to
the new rockpi4-rk3399.c file.

board/rockchip/evb_rk3399 still exists and contain the Kconfig, README
and MAINTAINERS files after this patch, just no board specific code.

So will keep this change as-is for v2.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
>>   create mode 100644 include/configs/rockpi4-rk3399.h
>>

[snip]
