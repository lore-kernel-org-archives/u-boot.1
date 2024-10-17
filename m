Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1308D2F7E4
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C9B88E1B;
	Thu, 17 Oct 2024 05:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729134826;
	bh=ytHDIPpFk/FpClbtYvzjvCQ082vJC/umnRhEEYmAJI8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=adfz1fonR5Vm1UFM05SYIiFbY8kPCEOEPXujkFstOaHspS56AOZZMDItjEcDgtWsr
	 sDFHq5eHz5VRg2W3yLuAvXl7HZHqvjpmsE0NaAPyJuvnhYtD8EaDWJMXdAMkWQb+jW
	 mZs5vO0P42Xy6CI8rhEkVfgUPAxhX/013iUGCfHfLTgVl4+c7J95LUJ0i19mIjk0q8
	 hBEhYWy1k+h2KDPkxjqOHDh+kaJbsh9FwRd5fep2JHKuNJmGi4E7Rq9fETwXXHX6tL
	 vRrDRuGkIEnviwus+fsk/Y+7idXj5U1Z2GIYhhh0/2j9/vJ3YlZYkKOBZIvZTVNqdR
	 1YnIs0AUZSFrg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9D5CF88D40;
 Thu, 17 Oct 2024 05:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729134823;
 bh=ytHDIPpFk/FpClbtYvzjvCQ082vJC/umnRhEEYmAJI8=;
 h=From:To:Cc:Subject:Date:From;
 b=rRNdxf8B8RX4uJZ+6uMRg8S1L+ht0hJmveEutXOg3iTpcuXSwakj1ynBW5TQ4I+0o
 SXPiM/8+7If6lYiyiJOHYZRVviAPkbUxdu8OGV0pKy6yr97dN2AgPqSOQV1r11IUBP
 gmGwP/m6kS1HK8WqnUyhk4DrGwyPOI2M14sR0V96aTLJYEE8hgQYHqxxNqr1uu5s/A
 YpLox2IxU+qz1S9KvIobXJaCOU0e1U7A1g03CslpbzRXDNn419KmAUo7Oi8/VD1+r8
 hdjij251o4a1CjFRJ0QFYeyZkATZOzYaIr1qXHskrUmT1vD/3F6xYnBN9gh5IjMxoe
 TvLwRw4zzqOew==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PULL] u-boot-usb/master
Date: Thu, 17 Oct 2024 05:13:00 +0200
Message-ID: <20241017031327.158132-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd3052874:

  Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11:57 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 6852a2c82e695c418c744b0fcb4298bc0e759842:

  MAINTAINERS: add TCPM section (2024-10-17 03:12:47 +0200)

----------------------------------------------------------------
Sebastian Reichel (6):
      usb: tcpm: add core framework
      usb: tcpm: fusb302: add driver
      board: rock5b-rk3588: enable USB-C in operating system
      rockchip: rk3588-rock-5b: Add USB-C controller to u-boot.dtsi
      rockchip: rock5b-rk3588: Enable USB-C PD support
      MAINTAINERS: add TCPM section

 MAINTAINERS                               |    9 +
 Makefile                                  |    1 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   |   28 +
 board/radxa/rock5b-rk3588/Makefile        |    6 +
 board/radxa/rock5b-rk3588/rock5b-rk3588.c |   16 +
 cmd/Kconfig                               |    7 +
 cmd/Makefile                              |    1 +
 cmd/tcpm.c                                |  136 ++
 configs/rock5b-rk3588_defconfig           |    4 +
 doc/usage/cmd/tcpm.rst                    |   66 +
 doc/usage/index.rst                       |    1 +
 drivers/usb/Kconfig                       |    2 +
 drivers/usb/tcpm/Kconfig                  |   16 +
 drivers/usb/tcpm/Makefile                 |    4 +
 drivers/usb/tcpm/fusb302.c                | 1323 +++++++++++++++++
 drivers/usb/tcpm/fusb302_reg.h            |  177 +++
 drivers/usb/tcpm/tcpm-internal.h          |  173 +++
 drivers/usb/tcpm/tcpm-uclass.c            |  149 ++
 drivers/usb/tcpm/tcpm.c                   | 2288 +++++++++++++++++++++++++++++
 include/dm/uclass-id.h                    |    1 +
 include/usb/pd.h                          |  516 +++++++
 include/usb/tcpm.h                        |   99 ++
 22 files changed, 5023 insertions(+)
 create mode 100644 board/radxa/rock5b-rk3588/Makefile
 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 create mode 100644 cmd/tcpm.c
 create mode 100644 doc/usage/cmd/tcpm.rst
 create mode 100644 drivers/usb/tcpm/Kconfig
 create mode 100644 drivers/usb/tcpm/Makefile
 create mode 100644 drivers/usb/tcpm/fusb302.c
 create mode 100644 drivers/usb/tcpm/fusb302_reg.h
 create mode 100644 drivers/usb/tcpm/tcpm-internal.h
 create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
 create mode 100644 drivers/usb/tcpm/tcpm.c
 create mode 100644 include/usb/pd.h
 create mode 100644 include/usb/tcpm.h
