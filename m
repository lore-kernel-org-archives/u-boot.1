Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF31C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16BD8001F;
	Tue, 18 Feb 2025 03:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YRggjZe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755118083C; Tue, 18 Feb 2025 03:57:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C750A80017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847443; x=1771383443;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aaSPLQk4R6SGDFXBObJxrXrAKGD06s6q2XdmhjqFqPA=;
 b=YRggjZe6Qj/TkkkY5hGP7YNCP/iiUha+2jmufQGj0pNXo6BtqwnUMxAU
 Qbw7a3YcRBbRXKbeMKAJ44IjXTpFn6914lgXdRUVkYnHew7TjoiglwQ/n
 GiodhCpVTIOMv252tHzBd3HTL0+3LeKZtvIroHcc6ZdOhI2AYlPSmALAp
 bWHv0pSft9vkMgYkMszto50wx7UgH6RjNPe4FRZ3vaiihYaZi2oTv7nb3
 Jg6nW8F7q2qUNA51c9n7TizS56tl0/i+0eazzikWgE9XBTsSgiyHdjUdE
 2+ard+PStTHZmJDh9hUWc7IkCTxAxpbjNZv+sov0HW2IiYn23RQFJHqh5 A==;
X-CSE-ConnectionGUID: FESDBm0hSUiDaFSd0mHFKg==
X-CSE-MsgGUID: aPG13XAnSjG7GYHR6oNiKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174098"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174098"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:57:21 -0800
X-CSE-ConnectionGUID: 2BOsDizPQJmsOHoXJueRug==
X-CSE-MsgGUID: xUcDSsSeQLu/SrUGc+4q+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259241"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:15 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 00/10] Add Synopsys MIPI I3C Driver support
Date: Tue, 18 Feb 2025 10:56:55 +0800
Message-Id: <20250218025705.50051-1-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patchset add Synopsys MIPI I3C Driver support for
Intel Agilex5 devices.

The i3c driver is leveraged from the master/dw-i3c-master.c,
i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
And few header files included to be
part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
include/linux/i3c/device.h and include/linux/i3c/master.h.
Additional i3c uclass driver and command files added to support
i3c read and write in U-Boot.

Dinesh Maniyam (10):
  dt-bindings: i3c: Add YAML schema for Cadence I3C controller
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: Enabled Kconfig and Makefile for I3C support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  cmd: Enabled Kconfig and Makefile for DWI3C cmd support

 cmd/Kconfig                                   |    6 +
 cmd/Makefile                                  |    1 +
 cmd/i3c.c                                     |  193 ++
 .../i3c/cdns,i3c-master.yaml                  |   51 +
 doc/device-tree-bindings/i3c/i3c.yaml         |  186 ++
 drivers/i3c/Kconfig                           |   21 +
 drivers/i3c/Makefile                          |    4 +
 drivers/i3c/device.c                          |  263 +++
 drivers/i3c/i3c-uclass.c                      |   38 +
 drivers/i3c/internals.h                       |   26 +
 drivers/i3c/master.c                          | 2073 +++++++++++++++++
 drivers/i3c/master/Kconfig                    |   11 +
 drivers/i3c/master/Makefile                   |    3 +
 drivers/i3c/master/dw-i3c-master.c            | 1058 +++++++++
 include/dm/device.h                           |    2 +
 include/dm/uclass-id.h                        |    1 +
 include/dw-i3c.h                              |  252 ++
 include/i3c.h                                 |   67 +
 include/linux/i3c/ccc.h                       |  385 +++
 include/linux/i3c/device.h                    |  286 +++
 include/linux/i3c/master.h                    |  700 ++++++
 21 files changed, 5627 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
 create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

-- 
2.26.2

