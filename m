Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEEC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0608882F;
	Thu,  8 Aug 2024 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="iOepbwMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EACA8882F; Thu,  8 Aug 2024 15:58:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF9688ABD
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1723125513; x=1723730313; i=smoch@web.de;
 bh=LEP5lXfv1rlXFYON1eVD/FABFjilyMGt9HQFldGkE9g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iOepbwMedhxlodu+pkgJAvtlRM/lPgK7mDrD/+il11kxr2ecYR88TNfGul4xfFiF
 hPC5SK2fo4dZyrjPcDJR4R6KdPgpY3JgUrxUSZ59WyeG07XS1AVsvtZRrJV9d9OdL
 XYUCP3wEFZs3XpWZfoygpjgzqrc9l7PlSiLqWxdffieOaRuAXybGlmQUe+cUxS1uN
 x+JrRPOumVgXuBoCvYJSHlunKC2BFYAVc0u6Pa5NCLdRMJOr+9OBr0su8a387xz+8
 /JT3SLCg1BzS0OkE+FJTOYdgHd8p91l/jVgfLovbq967Jc3frTRSAAAC6Joejibrz
 zXoOy67eIXchYF/waQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1sAetA0jDB-012QrV; Thu, 08
 Aug 2024 15:58:33 +0200
Message-ID: <9c5078f1-ba80-464c-8778-365117457eaa@web.de>
Date: Thu, 8 Aug 2024 15:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9KrzBMjuG5lgc8jvK/jv4PcfDBNASmUapBpKyDV8xDTs8B6p53F
 zLmqLXKmnYfa1wt+8/Sw9o412sNsUPdnLBoiRZpwIP/TPBjfwHXH0LfcMFj+XRkklJI2Nis
 fpXHILjGnDOIxbrJKvKfOqyPirWENDWeYMtl0VN5BVgft55nvQUwt+DeFDStpsEruXbhLe/
 rauF25P4n+YNSpLyNSCCA==
UI-OutboundReport: notjunk:1;M01:P0:breeIQILCPE=;UHjyq9Z4iGGUwJdAgzeenv0J8bx
 RZbEm518t+QSoNVQq5xWRMS3WTSJb0tIBKkWppe74hNBgIW1QSVTACxJFL07HBCmbNs6qu87E
 bXcFaEQLp3lG8o2Rp3tNMI1BulokDCu2W6jPmdfc6Mwkjj0Lg/SXYdGeo6JEu/QN96RshS6/O
 HFEBBQBc9Vm+FQHe6Eb7g3CPY4y78ZYdidsooZ8iaaUnMuJ2tZaUaW0ngZ5nRKFfBQTP2JFbO
 WoQ3IV7s8dGSaDVt2/VJ4Jzey6l5xlEIohcVVaWDK97tPbYzKMTRZcGTnbOFVzukB5HL6Ev7w
 BvlrYK/2WlooFX74Q7ysICDC9EPwzx9xQNH1+NCv4zu+gFe3n9G69nMQxHca1DuYC88uwh74s
 iixsnO12PzsGerUGflYzqB9IjbnLy7lq3O7k2z2hg9XF7IV9eMwXkT1E2mYU784o1aTZEQSPr
 dfCp5pY0WL737KGj/limraCSe3wib5logleiWim31z6xscKBQx9xls2acWPllDMea0zCOEwrD
 ZgJQC/kxTFGYmy6gNXw+GOWoVS7B1uu0GDforr/m46pDnrdm6F/01YGR6Z/MehbT+fLkpbEKU
 a+sMSUjBXrxgMZStYVmTKYpshRHkDTbqDgooskR0Atd1JeRG6hFMYN7gHzbN+4SH0ZlsUemMY
 gWoc5/1gM5LafjKE6By0AtoT/EZNkoo8a1xtBU/aS+oitvifS++2H0Vc53w5lS7WST2b5r7hv
 Gsukrn+cO5HPt6qHnirz1pFHSzJjis9WdCsQkmqYToeacQ70ocEw8iGwSnN4R4yFco1ewgliG
 Hoeci5HmZw9eHv9TY8xcB2TQ==
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



On 02.08.24 19:59, Sebastian Reichel wrote:
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
> Sorry for the delay in getting PATCHv3 ready.
>
> Changes since PATCHv2:
>   * Rebase to latest master (a70d991212c9)
>   * Drop Wang Jie from Cc, since his address bounces
>   * I did not add a test suite. I fully agree, that it would be nice to =
have
>     one, but it is also a lot of work. Just emulating a FUSB302 is not e=
nough,
>     we also need to emulate the remote USB-PD device to make this useful=
.
>     Without that we would only test what happens when a non-responsive U=
SB-PD
>     supply is attached and that is the boring, very simple path in this =
code.
>     On the other hand implementing an emulated USB-C PD remote side more=
 or less
>     requires implementing another big state machine.
>   * Add documentation for the 'tcpm' command (Simon Glass)
>   * I also got asked to add more documentation for the feature in genera=
l. I'm
>     not really sure what is needed. At least Tim Harvey managed to use i=
t
>     considering he got stusb4500 working on top of PATCHV2. If there are=
 more
>     specific requests I can write something.
>   * Just like PATCHv1, PATCHv2 received a 'Tested-by: Soeren Moch <smoch=
@web.de>',
>     which I did not take over. This time the changes are a lot smaller, =
but
>     the different handling of timeouts might have broken something. (On =
my end
>     things still behave correctly of course, otherwise I wouldn't have s=
ent
>     this series)

FWIW
I retested this v3 series on top of v2024.07. Everything still works as
expected on my rock-5b board with different USB-PD power supplies (5V,
12V, 20V).

Tested-by: Soeren Moch <smoch@web.de>

Thanks,
Soeren

>   * Address feedback from Marek Vasut
>    - TCPM core
>      - drop useless "failure" function
>      - replace printf with log in TCPM command code
>      - invert some conditions to reduce indent
>      - use read_poll_timeout() in tcpm_pd_transmit()
>      - did not add any more 'static' keywords to functions, the non-stat=
ic
>        TCPM functions are exported and called from the fusb302 driver.
>      - add a safety guard to tcpm_send_queued_message(), which stops
>        the loop if more than 100 messages are send directly after each
>        other. This should never happen anyways, but it's better to exit
>        cleanly if the code runs astray.
>    - FUSB302 driver
>      - Drop default initialization for most local ret variables
>      - Make some local variables constant
>      - Make set_polarity callback optional on the uclass level and drop =
the
>        empty FUSB302 implementation
>      - Change buffer initialization in send message function
>      - Create define for max. message length magic value
>    - Rock 5B board code
>      - Add comment why misc_init_r explicitly initializes PD
>      - Split defconfig and DT into separate patches (Kever Yang)
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
> Greetings,
>
> -- Sebastian
>
> Sebastian Reichel (7):
>    usb: tcpm: add core framework
>    usb: tcpm: fusb302: add driver
>    board: rock5b-rk3588: add USB-C controller support
>    board: rock5b-rk3588: enable USB-C in operating system
>    rockchip: rk3588-rock-5b: Add USB-C controller to u-boot.dtsi
>    rockchip: rock5b-rk3588: Enable USB-C PD support
>    MAINTAINERS: add TCPM section
>
>   MAINTAINERS                               |    9 +
>   Makefile                                  |    1 +
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   |   28 +
>   board/radxa/rock5b-rk3588/Makefile        |    6 +
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c |   46 +
>   cmd/Kconfig                               |    7 +
>   cmd/Makefile                              |    1 +
>   cmd/tcpm.c                                |  136 ++
>   configs/rock5b-rk3588_defconfig           |    5 +
>   doc/usage/cmd/tcpm.rst                    |   66 +
>   doc/usage/index.rst                       |    1 +
>   drivers/usb/Kconfig                       |    2 +
>   drivers/usb/tcpm/Kconfig                  |   16 +
>   drivers/usb/tcpm/Makefile                 |    4 +
>   drivers/usb/tcpm/fusb302.c                | 1322 ++++++++++++
>   drivers/usb/tcpm/fusb302_reg.h            |  177 ++
>   drivers/usb/tcpm/tcpm-internal.h          |  173 ++
>   drivers/usb/tcpm/tcpm-uclass.c            |   88 +
>   drivers/usb/tcpm/tcpm.c                   | 2277 +++++++++++++++++++++
>   include/dm/uclass-id.h                    |    1 +
>   include/usb/pd.h                          |  516 +++++
>   include/usb/tcpm.h                        |   99 +
>   22 files changed, 4981 insertions(+)
>   create mode 100644 board/radxa/rock5b-rk3588/Makefile
>   create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>   create mode 100644 cmd/tcpm.c
>   create mode 100644 doc/usage/cmd/tcpm.rst
>   create mode 100644 drivers/usb/tcpm/Kconfig
>   create mode 100644 drivers/usb/tcpm/Makefile
>   create mode 100644 drivers/usb/tcpm/fusb302.c
>   create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>   create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>   create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>   create mode 100644 drivers/usb/tcpm/tcpm.c
>   create mode 100644 include/usb/pd.h
>   create mode 100644 include/usb/tcpm.h
>
