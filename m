Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661F5C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 17:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9600D88501;
	Tue,  4 Jun 2024 19:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="cL7Ov+Gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D328850D; Tue,  4 Jun 2024 19:47:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5364B884D2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 19:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1717523219; x=1718128019; i=smoch@web.de;
 bh=6Lf4d+b1We1Qe0umKZloH7+aVUZvgMScnwA74fS1sDg=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cL7Ov+GfwcfkzFUhnfsDHnWd252ureX9Zxp7qaGua9nROsX458lBcrXI9XKGQ4Y6
 J5luSFGRewtY2A5CuY4iROh9tUC+FprId70AJn52LUx5Ei6CbBzCe5IQQK/RCNSQA
 gHFX3qKYARQgT3FNn4EjG1o3tR6yjezEhg7UXIvxpgrqkdLmgFSem9+XSY+iVD8Nn
 ZttSZ1logid0n2dl2/7wdhpDNwgyzm/1WIJMAU23d9Tl3YoWpYeU4oVF9cIFDRB5V
 Aogqhd0vIRdDzDGF+yxBbQvxaokBeltILoR3aIlfKGIx+HkLtFvMbBTolvRcvmSf7
 +WESCkyCRQx0NHSHNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1seVA82WYs-00sAXV; Tue, 04
 Jun 2024 19:46:58 +0200
Message-ID: <64258812-7a63-4500-a026-d281af2e11fe@web.de>
Date: Tue, 4 Jun 2024 19:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240604163546.60225-1-sebastian.reichel@collabora.com>
X-Provags-ID: V03:K1:gLvIRm0AdOSlnclE6J13x9um6sshxNV+L1DlTD+e7TR8Wdita4o
 Gz0otJ9NqWtwL99swiJskfXBP2p2tZZuizvS3zanfFhRGXtVmK7WhuZyJ9VRjWuguKPCRLd
 GVc6mDtoFCJbRQVDYeLwBz6sHnckKqGigD9uEQpfDcJwhKziEE4ymkRJYOQrexVqw0nqfqt
 hzZZjZOfJhur0AT6dbShA==
UI-OutboundReport: notjunk:1;M01:P0:xkQ2S6G7Ulc=;NEFgVAaLqLz5QCxwYvsKQz663bO
 jXfrO+9fA9hlNYT7FzHJ0irPVSo2mNHMN8nBPgPgYcCCk5HYJqqu5d5waPUFXpWbAffr9cLpJ
 YYXQyV/0G2TZ1xOcYL/S5eP2sHB7WsSkT31D9oeVTtY6VZOQqIXjXVDVehfhtkFeHkwfKz6vd
 VwFBV/cpSRUrYsDPTaRg7Zl9Ev26+2P7ECOtKE7ti4iYPzuOT7e9yxpgGioFNJ5+Z5/D9k0p7
 mZKHRa9RPr8WPFxk7BNjDQzpcHED5evybb+XHpUQNK1bd29E8DXzY99qOCucFy8vHl3tiPmG3
 8NfK3oBg1nTnZqvB0yznP8P0CcsTcfYBjSZnQ+25XhvNAmmxFoKWqDsEK6bde0ikSIKm+Oe8A
 8zHqu32lZELivFdXRm9O2CSaWGafaQnqv6IKQE1y49b4g9wPNaX5yIJ4XlCLKSNSgKUxnuEDk
 /f/ZLI/6gZDqPro6RmRzv7FFjkyKmwnK9TN3AiavYDe/9K1V9gebDZzDmW4Tvo+jKdOGQNp7v
 pv+QE2FZG07jBUz5WnZFzckoCo+coEorFc8RBwFe4txhbzJ5k15grs60WoRcUrKgToxj0Xraf
 8v+5h34lUPWrx8u+OgQgOPTbRs2RBT1QIBcXdFMtXQFfY5IE+cDpijGyRHYeiHgDRDL9VkMwJ
 39kH3EwOHoSglz8Tgif1P2vUchgorgfNzlljTgiulP3bxa0K7EcrgB72DJ90kKPAt2TrNDM1G
 RbcZWIhKUH5JJ11EI0OetcfwNT7aHoQvuV2+z0GsjLBQiKM3Iz840YsnrSKn1bYMV/xzilP19
 R/61KQo6Cdmn4StSLRK6AfbyDRkmnQk65X8dyrIAz9l6s=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

Hi,

On 04.06.24 18:33, Sebastian Reichel wrote:
> Hi,
>
> On ROCK 5B power is usually supplied via it's USB-C port. This port has =
the
> data lines connected to RK3588, VBUS connected to the input regulator an=
d
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can b=
e
> accessed via I2C from RK3588. The USB-C controller is needed to figure o=
ut
> the USB-C cable orientation, but also to do USB PD communication. Thus i=
t
> would be great to enable support for it in the operating system.
>
> But the USB-PD specification requires, that a device reacts to USB-PD me=
ssages
> send by the power-supply within around 5 seconds. If that does not happe=
n the
> power-supply assumes, that the device does not support USB-PD. If a devi=
ce
> later starts sending USB-PD messages it is considered an error, which is=
 solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltag=
es are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an mac=
hine
> reset. This is currently worked around by not describing the FUSB302 in =
the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>     power capabilities
>
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, s=
o
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
>
> 1. the tcpm state machine, which implements the Type C port manager stat=
e
>     machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
>
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
>
> Changes since PATCHv1:
>   * tcpm: split uclass specific code to tcpm-uclass
>   * tcpm_print_info: move printing part to cmd/tcpm.c
>   * tcpm_print_info: report more information
>     - PD revision
>     - Cable orientation
>     - Power role
>     - Data role
>     - Print TCPM state based on connection status
>   * tcpm: use "struct udevice *dev" instead of "struct tcpm_port *port"
>     as function argument in most places and drop dev from the tcpm_port
>     struct
>   * tcpm: avoid useless kzalloc + copy + free for incoming events
>   * tcpm: use dev_get_uclass_plat() for tcpm_port
>   * tcpm: run tcpm_port_init() and tcpm_poll_event() from UCLASS post_pr=
obe()
>   * tcpm/fusb302: get rid of tcpc_dev by using dm_tcpm_ops() for the
>     function pointers and introducing get_connector_node() for the
>     ofnode
>   * fusb302: use "struct udevice *dev" instead of "struct fusb302_chip *=
chip"
>     as function argument and drop dev from the fusb302_chip struct
>   * fusb302: drop multiple unused members from fusb302_chip
>   * fusb302: directly use udelay instead of usleep_range define
>   * fusb302: use fusb302_ prefix for all functions. Afterwards tcpm_ pre=
fix
>     is only used for the tcpm code itself
>   * fusb302: move fusb302_poll_event() to avoid forward defintion
>   * fusb302: drop probe function
>   * fusb302: drop unused LOG_BUFFER defines
>   * roughly 20% of all lines of the series changed between v1 and v2, so
>     I did not collect the Tested-by from Soeren Moch
>
Makes sense, of course.

I retested this v2 series on top of 2024.07-rc4, everything still works
perfectly fine for me.

Tested-by: Soeren Moch <smoch@web.de>



U-Boot 2024.07-rc4-00005-gc9c6c70498 (Jun 04 2024 - 19:18:57 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:=C2=A0=C2=A0=C2=A0 serial@feb50000
Out:=C2=A0=C2=A0 serial@feb50000
Err:=C2=A0=C2=A0 serial@feb50000
Model: Radxa ROCK 5 Model B
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot:=C2=A0 0
=3D> tcpm list
| Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Parent uclass
@ seq
| usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@feac0000=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
status: 0
=3D> tcpm dev usb-typec@22
dev: 0 @ usb-typec@22
=3D> tcpm info
Orientation: normal
PD Revision: rev3
Power Role:=C2=A0 sink
Data Role:=C2=A0=C2=A0 device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0 12.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.500 A
=3D>

Thanks again,
Soeren
