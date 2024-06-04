Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A5DC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4248850A;
	Tue,  4 Jun 2024 18:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JpfMwxox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC938850A; Tue,  4 Jun 2024 18:35:52 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50989884C7
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717518948;
 bh=o/t99qxdKzUZYJAvvj2h3Z5iEwk9KfKyu54O0El7szE=;
 h=From:To:Cc:Subject:Date:From;
 b=JpfMwxoxjzBQRybXYZcSrdTcnihumVsK+qcylVujdadervD5qMwfLIheyNtTTzBR8
 U2J4Vbg796TYdbWTkudgJXA4iL9l8/jX2wYGm91xmFNYmDkqJriTFV4WD1zZV0Q/p7
 xivcYRiILOqOPqjBqBsWGoB0GsbQYFC750pynj1Fi/LD1N0HqZbJltDY+PNwuIa4oA
 nC1NOd2eP8CF7dKJaMyRoRGntTwNivtt6cvjfvORhqV/DlI7BJ7SHZDch4+8RQU2o4
 4YIMm+jqiVdY6TiMwqltpu/Og4t9HpyMc6mQsn1m4KBC7fOsVn55tpjEpY+vaWTYWa
 QFXdtWGkMOG6A==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AF56737821F2;
 Tue,  4 Jun 2024 16:35:48 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 4DE194800C9; Tue, 04 Jun 2024 18:35:48 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/5] FUSB302 USB-C controller support
Date: Tue,  4 Jun 2024 18:33:52 +0200
Message-ID: <20240604163546.60225-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On ROCK 5B power is usually supplied via it's USB-C port. This port has the
data lines connected to RK3588, VBUS connected to the input regulator and
CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
accessed via I2C from RK3588. The USB-C controller is needed to figure out
the USB-C cable orientation, but also to do USB PD communication. Thus it
would be great to enable support for it in the operating system.

But the USB-PD specification requires, that a device reacts to USB-PD messages
send by the power-supply within around 5 seconds. If that does not happen the
power-supply assumes, that the device does not support USB-PD. If a device
later starts sending USB-PD messages it is considered an error, which is solved
by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
removed for a short period of time. For boards, which are solely powered
through their USB-C port, like the Radxa Rock 5B, this results in an machine
reset. This is currently worked around by not describing the FUSB302 in the
kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means

1. the USB-C port cannot be used at all
2. the board will be running via fallback supply, which provides limited
   power capabilities

In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
that we react to the power-supply's queries in time. The code, which is
originally from the Linux kernel, consists of two parts:

1. the tcpm state machine, which implements the Type C port manager state
   machine as described in the USB PD specification
2. the fusb302 driver, which knows about specific registers

Especially the first part has been heavily modified compared to the
kernel, which makes use of multiple delayed works and threads. For this
I used a priorly ported version from Rockchip, removed their hacks and
any states not necessary in U-Boot (e.g. audio accessory support).

Changes since PATCHv1:
 * tcpm: split uclass specific code to tcpm-uclass
 * tcpm_print_info: move printing part to cmd/tcpm.c
 * tcpm_print_info: report more information
   - PD revision
   - Cable orientation
   - Power role
   - Data role
   - Print TCPM state based on connection status
 * tcpm: use "struct udevice *dev" instead of "struct tcpm_port *port"
   as function argument in most places and drop dev from the tcpm_port
   struct
 * tcpm: avoid useless kzalloc + copy + free for incoming events
 * tcpm: use dev_get_uclass_plat() for tcpm_port
 * tcpm: run tcpm_port_init() and tcpm_poll_event() from UCLASS post_probe()
 * tcpm/fusb302: get rid of tcpc_dev by using dm_tcpm_ops() for the
   function pointers and introducing get_connector_node() for the
   ofnode
 * fusb302: use "struct udevice *dev" instead of "struct fusb302_chip *chip"
   as function argument and drop dev from the fusb302_chip struct
 * fusb302: drop multiple unused members from fusb302_chip
 * fusb302: directly use udelay instead of usleep_range define
 * fusb302: use fusb302_ prefix for all functions. Afterwards tcpm_ prefix
   is only used for the tcpm code itself
 * fusb302: move fusb302_poll_event() to avoid forward defintion
 * fusb302: drop probe function
 * fusb302: drop unused LOG_BUFFER defines
 * roughly 20% of all lines of the series changed between v1 and v2, so
   I did not collect the Tested-by from Soeren Moch

Greetings,

-- Sebastian

Sebastian Reichel (5):
  usb: tcpm: add core framework
  usb: tcpm: fusb302: add driver
  board: rock5b-rk3588: add USB-C controller support
  board: rock5b-rk3588: enable USB-C in operating system
  MAINTAINERS: add TCPM section

 MAINTAINERS                               |    8 +
 Makefile                                  |    1 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   |   28 +
 board/radxa/rock5b-rk3588/Makefile        |    6 +
 board/radxa/rock5b-rk3588/rock5b-rk3588.c |   33 +
 cmd/Kconfig                               |    7 +
 cmd/Makefile                              |    1 +
 cmd/tcpm.c                                |  142 ++
 configs/rock5b-rk3588_defconfig           |    5 +
 drivers/usb/Kconfig                       |    2 +
 drivers/usb/tcpm/Kconfig                  |   16 +
 drivers/usb/tcpm/Makefile                 |    4 +
 drivers/usb/tcpm/fusb302.c                | 1333 ++++++++++++
 drivers/usb/tcpm/fusb302_reg.h            |  177 ++
 drivers/usb/tcpm/tcpm-internal.h          |  174 ++
 drivers/usb/tcpm/tcpm-uclass.c            |  102 +
 drivers/usb/tcpm/tcpm.c                   | 2251 +++++++++++++++++++++
 include/dm/uclass-id.h                    |    1 +
 include/usb/pd.h                          |  516 +++++
 include/usb/tcpm.h                        |   99 +
 20 files changed, 4906 insertions(+)
 create mode 100644 board/radxa/rock5b-rk3588/Makefile
 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 create mode 100644 cmd/tcpm.c
 create mode 100644 drivers/usb/tcpm/Kconfig
 create mode 100644 drivers/usb/tcpm/Makefile
 create mode 100644 drivers/usb/tcpm/fusb302.c
 create mode 100644 drivers/usb/tcpm/fusb302_reg.h
 create mode 100644 drivers/usb/tcpm/tcpm-internal.h
 create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
 create mode 100644 drivers/usb/tcpm/tcpm.c
 create mode 100644 include/usb/pd.h
 create mode 100644 include/usb/tcpm.h

-- 
2.43.0

