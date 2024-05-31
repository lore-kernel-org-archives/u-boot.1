Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3DFC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BA4887BA;
	Fri, 31 May 2024 17:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="a7JOTsFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FAD882CD; Fri, 31 May 2024 17:10:57 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA7F885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717168253;
 bh=K/54eVhh3lEfSUQyzv4DS/YdmWNXW4/CbUxHS6pf9hU=;
 h=From:To:Cc:Subject:Date:From;
 b=a7JOTsFe37ckgTmArrFyipedqOFhdXNLuVH0TSszE+M6sqD553Ev8UjppnT3RzeHS
 J1qKQhh9DrTI92iy+xHb0iMYxZKjcVyGEEM2RiRdEL7H8aBrUm7D1+GlxzHeTCMnXu
 8dAOZ+22dTXlTwEN2HMe9iWxilnq7192B4FnagWKey8092rPS4cIMFAS3CwtIlg82Y
 2JK3ofadXEG/DEwsMpEvHT1itdWe8nrnUuvG8lXgAZ7z5uNKcmbrBhyC7nwlmgoKhK
 3xmwQ2M+OOqFJjdlHPl2RxEuboetWy28fl3JPs5sitP0PwGrBNzPwF6OSyLTE0Vuad
 9aaL9zzDtqJ6A==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4B15E37821DC;
 Fri, 31 May 2024 15:10:53 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DE7D84800C9; Fri, 31 May 2024 17:10:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 0/5] FUSB302 USB-C controller support
Date: Fri, 31 May 2024 17:08:12 +0200
Message-ID: <20240531151026.84846-1-sebastian.reichel@collabora.com>
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
 cmd/tcpm.c                                |  117 +
 configs/rock5b-rk3588_defconfig           |    5 +
 drivers/usb/Kconfig                       |    2 +
 drivers/usb/tcpm/Kconfig                  |   16 +
 drivers/usb/tcpm/Makefile                 |    4 +
 drivers/usb/tcpm/fusb302.c                | 1427 ++++++++++++
 drivers/usb/tcpm/fusb302_reg.h            |  177 ++
 drivers/usb/tcpm/tcpm.c                   | 2406 +++++++++++++++++++++
 include/dm/uclass-id.h                    |    1 +
 include/usb/pd.h                          |  516 +++++
 include/usb/tcpm.h                        |  116 +
 18 files changed, 4871 insertions(+)
 create mode 100644 board/radxa/rock5b-rk3588/Makefile
 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 create mode 100644 cmd/tcpm.c
 create mode 100644 drivers/usb/tcpm/Kconfig
 create mode 100644 drivers/usb/tcpm/Makefile
 create mode 100644 drivers/usb/tcpm/fusb302.c
 create mode 100644 drivers/usb/tcpm/fusb302_reg.h
 create mode 100644 drivers/usb/tcpm/tcpm.c
 create mode 100644 include/usb/pd.h
 create mode 100644 include/usb/tcpm.h

-- 
2.43.0

