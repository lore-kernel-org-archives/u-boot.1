Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0D3C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 09:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BB2881B8;
	Mon,  3 Jun 2024 11:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WDdXsBYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CE188214; Mon,  3 Jun 2024 11:58:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32FC8813A
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 11:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=730d=NF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717408694;
 bh=UKIDblb5pDS6AhlqKl0EU0w/2TrfSLKh9rXUsNO5Iwc=;
 b=WDdXsBYYA6MhBzww6AYrHrsVXmFvjbsthn5nNxPvDIb2dILv6jNuj3IAlI52c5NASXrosMomG
 PlCcht6bvVGmKqs94ig1wyG+/AYmDX8Q3mMSmtsS1DbNZdvvpoDHgFzKAUEe0tlFVwBWUryz9hX
 fYttyS/IGW4rS++dzd7B5YtdtUyX2MFKQccx+o882BlAXc1FGWECyFsq191aRXo+mwIAQHRkIEJ
 nzVJ0zIfPrknisyri8JkRQXW+il7mqY33/dfLpJ9OKCBDJDg7yutk0EjewRjMg+a+KqxXeJw9OI
 DoeI3CinoNZxNVsKI3L+5p8vtgWKOWt0kv2cATkXOU2w==
Message-ID: <7ace6636-54ed-477e-9fb2-a9aac6ec4e7b@kwiboo.se>
Date: Mon, 3 Jun 2024 11:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240531151026.84846-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 665d93b45644d33516eaafd2
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

Hi Sebastian,

On 2024-05-31 17:08, Sebastian Reichel wrote:
> Hi,
> 
> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
> data lines connected to RK3588, VBUS connected to the input regulator and
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
> accessed via I2C from RK3588. The USB-C controller is needed to figure out
> the USB-C cable orientation, but also to do USB PD communication. Thus it
> would be great to enable support for it in the operating system.
> 
> But the USB-PD specification requires, that a device reacts to USB-PD messages
> send by the power-supply within around 5 seconds. If that does not happen the
> power-supply assumes, that the device does not support USB-PD. If a device
> later starts sending USB-PD messages it is considered an error, which is solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an machine
> reset. This is currently worked around by not describing the FUSB302 in the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
> 
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>    power capabilities
> 
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
> 
> 1. the tcpm state machine, which implements the Type C port manager state
>    machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
> 
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).

Thanks for working on this!

Some initial quick feedback is that the tcpm uclass and driver should
probably take more advantage of the u-boot driver model.

Few quick thoughts:
- Split out uclass/driver api parts into tcpm-uclass.c
- Take advantage of uclass_driver ops such as post_probe and
  per_device_auto/per_device_plat_auto to e.g. handle tcpm_port_init and
  tcpm_port/tcpm_dev
- udevice should probably be passed to tcpm_ functions instead of a
  tcpm_port, dev_get_uclass_plat/priv could possible be used to get
  the tcpm_port data for the udevice

I have not yet had time to runtime test this but will do and get back
with a more in depth review later this week.

Regards,
Jonas

> 
> Greetings,
> 
> -- Sebastian
> 
> Sebastian Reichel (5):
>   usb: tcpm: add core framework
>   usb: tcpm: fusb302: add driver
>   board: rock5b-rk3588: add USB-C controller support
>   board: rock5b-rk3588: enable USB-C in operating system
>   MAINTAINERS: add TCPM section
> 
>  MAINTAINERS                               |    8 +
>  Makefile                                  |    1 +
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   |   28 +
>  board/radxa/rock5b-rk3588/Makefile        |    6 +
>  board/radxa/rock5b-rk3588/rock5b-rk3588.c |   33 +
>  cmd/Kconfig                               |    7 +
>  cmd/Makefile                              |    1 +
>  cmd/tcpm.c                                |  117 +
>  configs/rock5b-rk3588_defconfig           |    5 +
>  drivers/usb/Kconfig                       |    2 +
>  drivers/usb/tcpm/Kconfig                  |   16 +
>  drivers/usb/tcpm/Makefile                 |    4 +
>  drivers/usb/tcpm/fusb302.c                | 1427 ++++++++++++
>  drivers/usb/tcpm/fusb302_reg.h            |  177 ++
>  drivers/usb/tcpm/tcpm.c                   | 2406 +++++++++++++++++++++
>  include/dm/uclass-id.h                    |    1 +
>  include/usb/pd.h                          |  516 +++++
>  include/usb/tcpm.h                        |  116 +
>  18 files changed, 4871 insertions(+)
>  create mode 100644 board/radxa/rock5b-rk3588/Makefile
>  create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>  create mode 100644 cmd/tcpm.c
>  create mode 100644 drivers/usb/tcpm/Kconfig
>  create mode 100644 drivers/usb/tcpm/Makefile
>  create mode 100644 drivers/usb/tcpm/fusb302.c
>  create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>  create mode 100644 drivers/usb/tcpm/tcpm.c
>  create mode 100644 include/usb/pd.h
>  create mode 100644 include/usb/tcpm.h
> 

