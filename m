Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E991CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666EB88A75;
	Sun,  1 Sep 2024 22:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NASn65Cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE50A88A1D; Sun,  1 Sep 2024 22:09:56 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DAB88A0D
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c35426c34eso9807306d6.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221393; x=1725826193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e06WNK2TTtA/F9Da8RTd1w2lmKF9EkxMGkHeinS5JHM=;
 b=NASn65CuHh3pwQ+Q7obwragQo14Vt6XqemHk7nkKS0cpc42vzof5e6E6m+OUpsEEsr
 D0o0hBUHrK7moL8XBzd22vx2ymShyhoHdYwY96kJ2Zm4wcfmyWIli8fvooKl2FSGi8Ry
 h5uaziJDhJQUkKLwI1T5e71MkmZGFNOQ1Tfs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221393; x=1725826193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e06WNK2TTtA/F9Da8RTd1w2lmKF9EkxMGkHeinS5JHM=;
 b=PIylBqqlUY6JfdHwDgy7ywikI+LgixerYdzHpgjC6TDXrwFLRei8ap/X/4LWhV+LHy
 GpZ/JUaiAzQyUV/BY8MhcMi51xD5G7zXgz3x/nPO15mwMUrciuGAZYZPiywKM2UUP8Y8
 RZ9p1uY0xayZRQ8jsZuFp6R45Kk6EWxuZhlDxPgIeAaLcaPE4wU5XvKtu6l7CB/mZJuI
 YC8o0WPKWSUTN8rXtxJNh5QXvGJPXibjd9a71JCjdPhB+XsQDUw44fDxyz9gn88aOGII
 EdaNou3HvdFUjmaaDYI0fFGwUiObcrcl3EoMrViaNTm2/YCg4PW03LTZMPLry7mSEyIG
 axmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5xa0PK/rdv0GbMM1nWgKoxDjgLbhsrE/Z7egTE8g6ytXwUhGsrpmmYXmA7vTo9+75F6f6hdc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/SlXmEOBRC4HlQeHS2kMq8WM2sCwAMdQyAWTbeqRLETe0Qgrd
 1wF1Hs6BLZ75GXIhNx/MqKiRsdLFP9mAYK2xDuLNFde1NyxRKRObVDn2eBOKkAZDZ11/Cf1+Drv
 ZDogFa52o/sCUa5Z4mZ+Y+E/a08JJTkgNnGSn
X-Google-Smtp-Source: AGHT+IFu4mvFoHA0EkSsn/JMJbG2obr3aIzcr6IV39j5J6wxbxW/H1fFmrBk2gu1GRmgMUDn5UIMKXlmzZweXmJOC7Y=
X-Received: by 2002:a05:6214:5d91:b0:6c3:52a6:8e08 with SMTP id
 6a1803df08f44-6c352a68e8amr72825616d6.38.1725221393358; Sun, 01 Sep 2024
 13:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:42 -0600
Message-ID: <CAFLszTgLDHR2bVFmHaKktfP5Swd_4QZfavQC9GrAsHQh2-zj-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, 
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 30 Aug 2024 at 12:23, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On ROCK 5B power is usually supplied via it's USB-C port. This port has t=
he
> data lines connected to RK3588, VBUS connected to the input regulator and
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
> accessed via I2C from RK3588. The USB-C controller is needed to figure ou=
t
> the USB-C cable orientation, but also to do USB PD communication. Thus it
> would be great to enable support for it in the operating system.
>
> But the USB-PD specification requires, that a device reacts to USB-PD mes=
sages
> send by the power-supply within around 5 seconds. If that does not happen=
 the
> power-supply assumes, that the device does not support USB-PD. If a devic=
e
> later starts sending USB-PD messages it is considered an error, which is =
solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltage=
s are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an mach=
ine
> reset. This is currently worked around by not describing the FUSB302 in t=
he
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
>
> This version has been tested on Radxa Rock 5B using the open source TF-A
> (patches recently got merged into master branch) using the following powe=
r
> supplies:
>
>  * non PD capable (reports 5V 0A)
>  * RavPower 90W (ok)
>  * UGREEN 100W (ok)
>  * Anker 45W (ok)
>  * RavPower PB (hard resets in U-Boot, but succeeds at some point,
>    I still need to investigate)
>
> Changes since PATCHv3:
>  * Rebase to latest master (57949a99b7bd)
>  * Rework autoprobing; tcpm_post_bind tries to check if a probe is needed
>    based on DT properties and then sets the DM_FLAG_PROBE_AFTER_BIND flag=
.
>    If this accidently increases boot time on some boards they are probabl=
y
>    missing a 'self-powered;' flag in their USB-C connector node.
>  * Rock 5B ft_board_setup(): check for CONFIG_TYPEC_FUSB302 instead of
>    CONFIG_MISC_INIT_R to reflect the above change
>  * Drop adding 'CONFIG_MISC_INIT_R' to rock5b-rk3588_defconfig because of
>    the reworked autoprobing
>  * Log an error message if tcpm_send_queued_message() exits early
>  * Add R-b for the rockchip specific changes from Kever Yang
>  * Increase the timeout in tcpm_pd_transmit(), which seems to be the issu=
e
>    S=C3=B6ren Moch ran into. I could not really reproduce it. Please test=
 if this
>    helps with your supply (and share the logs if it does not help). I not=
iced
>    this version has issues with an old PD capable powerbank I own. I'm st=
ill
>    looking into that but wanted to share a new version so that the other
>    changes can get reviewed.
>
> Changes since PATCHv2:
>  * Rebase to latest master (a70d991212c9)
>  * Drop Wang Jie from Cc, since his address bounces
>  * I did not add a test suite. I fully agree, that it would be nice to ha=
ve
>    one, but it is also a lot of work. Just emulating a FUSB302 is not eno=
ugh,
>    we also need to emulate the remote USB-PD device to make this useful.
>    Without that we would only test what happens when a non-responsive USB=
-PD
>    supply is attached and that is the boring, very simple path in this co=
de.
>    On the other hand implementing an emulated USB-C PD remote side more o=
r less
>    requires implementing another big state machine.
>  * Add documentation for the 'tcpm' command (Simon Glass)
>  * I also got asked to add more documentation for the feature in general.=
 I'm
>    not really sure what is needed. At least Tim Harvey managed to use it
>    considering he got stusb4500 working on top of PATCHV2. If there are m=
ore
>    specific requests I can write something.
>  * Just like PATCHv1, PATCHv2 received a 'Tested-by: Soeren Moch <smoch@w=
eb.de>',
>    which I did not take over. This time the changes are a lot smaller, bu=
t
>    the different handling of timeouts might have broken something. (On my=
 end
>    things still behave correctly of course, otherwise I wouldn't have sen=
t
>    this series)
>  * Address feedback from Marek Vasut
>   - TCPM core
>     - drop useless "failure" function
>     - replace printf with log in TCPM command code
>     - invert some conditions to reduce indent
>     - use read_poll_timeout() in tcpm_pd_transmit()
>     - did not add any more 'static' keywords to functions, the non-static
>       TCPM functions are exported and called from the fusb302 driver.
>     - add a safety guard to tcpm_send_queued_message(), which stops
>       the loop if more than 100 messages are send directly after each
>       other. This should never happen anyways, but it's better to exit
>       cleanly if the code runs astray.
>   - FUSB302 driver
>     - Drop default initialization for most local ret variables
>     - Make some local variables constant
>     - Make set_polarity callback optional on the uclass level and drop th=
e
>       empty FUSB302 implementation
>     - Change buffer initialization in send message function
>     - Create define for max. message length magic value
>   - Rock 5B board code
>     - Add comment why misc_init_r explicitly initializes PD
>     - Split defconfig and DT into separate patches (Kever Yang)
>
> Changes since PATCHv1:
>  * tcpm: split uclass specific code to tcpm-uclass
>  * tcpm_print_info: move printing part to cmd/tcpm.c
>  * tcpm_print_info: report more information
>    - PD revision
>    - Cable orientation
>    - Power role
>    - Data role
>    - Print TCPM state based on connection status
>  * tcpm: use "struct udevice *dev" instead of "struct tcpm_port *port"
>    as function argument in most places and drop dev from the tcpm_port
>    struct
>  * tcpm: avoid useless kzalloc + copy + free for incoming events
>  * tcpm: use dev_get_uclass_plat() for tcpm_port
>  * tcpm: run tcpm_port_init() and tcpm_poll_event() from UCLASS post_prob=
e()
>  * tcpm/fusb302: get rid of tcpc_dev by using dm_tcpm_ops() for the
>    function pointers and introducing get_connector_node() for the
>    ofnode
>  * fusb302: use "struct udevice *dev" instead of "struct fusb302_chip *ch=
ip"
>    as function argument and drop dev from the fusb302_chip struct
>  * fusb302: drop multiple unused members from fusb302_chip
>  * fusb302: directly use udelay instead of usleep_range define
>  * fusb302: use fusb302_ prefix for all functions. Afterwards tcpm_ prefi=
x
>    is only used for the tcpm code itself
>  * fusb302: move fusb302_poll_event() to avoid forward defintion
>  * fusb302: drop probe function
>  * fusb302: drop unused LOG_BUFFER defines
>  * roughly 20% of all lines of the series changed between v1 and v2, so
>    I did not collect the Tested-by from Soeren Moch
>
> Greetings,
>
> -- Sebastian
>
> Sebastian Reichel (6):
>   usb: tcpm: add core framework
>   usb: tcpm: fusb302: add driver
>   board: rock5b-rk3588: enable USB-C in operating system
>   rockchip: rk3588-rock-5b: Add USB-C controller to u-boot.dtsi
>   rockchip: rock5b-rk3588: Enable USB-C PD support
>   MAINTAINERS: add TCPM section
>
>  MAINTAINERS                               |    9 +
>  Makefile                                  |    1 +
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   |   28 +
>  board/radxa/rock5b-rk3588/Makefile        |    6 +
>  board/radxa/rock5b-rk3588/rock5b-rk3588.c |   16 +
>  cmd/Kconfig                               |    7 +
>  cmd/Makefile                              |    1 +
>  cmd/tcpm.c                                |  136 ++
>  configs/rock5b-rk3588_defconfig           |    4 +
>  doc/usage/cmd/tcpm.rst                    |   66 +
>  doc/usage/index.rst                       |    1 +
>  drivers/usb/Kconfig                       |    2 +
>  drivers/usb/tcpm/Kconfig                  |   16 +
>  drivers/usb/tcpm/Makefile                 |    4 +
>  drivers/usb/tcpm/fusb302.c                | 1322 ++++++++++++
>  drivers/usb/tcpm/fusb302_reg.h            |  177 ++
>  drivers/usb/tcpm/tcpm-internal.h          |  173 ++
>  drivers/usb/tcpm/tcpm-uclass.c            |  145 ++
>  drivers/usb/tcpm/tcpm.c                   | 2289 +++++++++++++++++++++
>  include/dm/uclass-id.h                    |    1 +
>  include/usb/pd.h                          |  516 +++++
>  include/usb/tcpm.h                        |   99 +
>  22 files changed, 5019 insertions(+)
>  create mode 100644 board/radxa/rock5b-rk3588/Makefile
>  create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>  create mode 100644 cmd/tcpm.c
>  create mode 100644 doc/usage/cmd/tcpm.rst
>  create mode 100644 drivers/usb/tcpm/Kconfig
>  create mode 100644 drivers/usb/tcpm/Makefile
>  create mode 100644 drivers/usb/tcpm/fusb302.c
>  create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>  create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>  create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>  create mode 100644 drivers/usb/tcpm/tcpm.c
>  create mode 100644 include/usb/pd.h
>  create mode 100644 include/usb/tcpm.h
>

Are you able to build this on sandbox?

Regards,
Simon
