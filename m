Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D74C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 13:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FDD83A26;
	Wed,  6 Aug 2025 15:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N0QOukf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285AE83A28; Wed,  6 Aug 2025 15:12:49 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC14836D3
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 15:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C39B5101C05; Wed,  6 Aug 2025 15:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1754485965;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=jXWa5dyzxShi7ieHJc/Xs4sbfj9iVmoaY7wlqQ5xZeY=;
 b=N0QOukf9dhEoz/Gmfhf1Lv5JjNzdqDGhwyY9aVbqOUtzvZm6lD889rdwoprEeWiLRhYZgs
 LnPdjvj7abdZJc3J7f/IhtuOgSFlqrs7Uq1pq7GyhvElnp0YFkBh9gvwI+S0pfaWkKzQ1A
 DvNmzgRxIx1LzYicHx5fuPJ3k0wJKK9nTfjPOu9VyPUFNOzJJB6iFjEIQ7XK10ktFBjYsc
 qTaNQh45N1AWty5mpjI+JRY0Ui7CeGNWuXSP985rxETYw/5xASOTur/CIvqhVpEc6UMcwg
 vEuzuUqqTPogN+ZSM4XXyBhrrN84k1LwWVIFbFHoEiPPiCkLVN0+7Mt3XJgKRQ==
Message-ID: <17b268fe-0b0c-e8e2-d66f-a7ec0326bc9c@nabladev.com>
Date: Wed, 6 Aug 2025 15:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

The following changes since commit 007610da2cca405ea7739fc120d90085be4b6ac2:

   Makefile: Remove expansion of undefined variable (2025-08-04 18:23:16 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2025-10-rc2

for you to fetch changes up to d35589f7d4ec5251eb3093dafc90887ff5f41702:

   configs: agilex5_defconfig: Enable i3c configs for agilex5 (2025-08-06 08:42:22 +0200)

----------------------------------------------------------------
i2c updates for v2025.10-rc2

bugfixes:

- rcar_iic: do not use unitialised variable
   from Andrew

- fix coverity issue in cmd/i2c.c
   from Heiko

new driver:

late, but hopefully okay for rc2, as already picked up when
merge window was open, but there was a problem in common code,
which is now fixed

- new i3c driver support from Dinesh

----------------------------------------------------------------
Andrew Goodbody (1):
       i2c: rcar_iic: Do not use unitialised variable

Dinesh Maniyam (12):
       drivers: i3c: Add new i3c uclass id
       drivers: i3c: Add driver for MIPI DWI3C
       drivers: i3c: Add i3c uclass driver.
       drivers: Enabled Kconfig and Makefile for i3c support
       drivers: i3c: Enabled Kconfig and Makefile for DWI3C
       drivers: i3c: Add i3c sandbox simple test.
       drivers: i3c: master: Enable probe i3c without slave device
       i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
       cmd: Add i3c command support.
       test: cmd: Add simple test for i3c
       configs: sandbox_defconfig: Enable configs for sandbox i3c
       configs: agilex5_defconfig: Enable i3c configs for agilex5

Heiko Schocher (1):
       cmd: i2c: fix coverity issue

  MAINTAINERS                        |    7 +
  arch/sandbox/dts/test.dts          |    8 +
  cmd/Kconfig                        |    7 +
  cmd/Makefile                       |    1 +
  cmd/i2c.c                          |    3 +-
  cmd/i3c.c                          |  271 ++++++++++++++++++++
  configs/sandbox_defconfig          |    4 +
  configs/socfpga_agilex5_defconfig  |    3 +
  doc/api/i3c.rst                    |    8 +
  doc/api/index.rst                  |    1 +
  doc/usage/cmd/i3c.rst              |  146 +++++++++++
  doc/usage/index.rst                |    1 +
  drivers/Kconfig                    |    2 +
  drivers/Makefile                   |    1 +
  drivers/i2c/rcar_iic.c             |    2 +-
  drivers/i3c/Kconfig                |   27 ++
  drivers/i3c/Makefile               |    5 +
  drivers/i3c/device.c               |  262 +++++++++++++++++++
  drivers/i3c/i3c-uclass.c           |   38 +++
  drivers/i3c/internals.h            |   26 ++
  drivers/i3c/master.c               | 2066 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i3c/master/Kconfig         |   11 +
  drivers/i3c/master/Makefile        |    3 +
  drivers/i3c/master/dw-i3c-master.c | 1062 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i3c/sandbox_i3c.c          |   56 ++++
  include/dm/uclass-id.h             |    1 +
  include/dw-i3c.h                   |  252 ++++++++++++++++++
  include/i3c.h                      |   93 +++++++
  include/linux/i3c/ccc.h            |  385 ++++++++++++++++++++++++++++
  include/linux/i3c/device.h         |  286 +++++++++++++++++++++
  include/linux/i3c/master.h         |  698 +++++++++++++++++++++++++++++++++++++++++++++++++
  test/cmd/Makefile                  |    1 +
  test/cmd/i3c.c                     |   50 ++++
  test/dm/Makefile                   |    1 +
  test/dm/i3c.c                      |   34 +++
  35 files changed, 5820 insertions(+), 2 deletions(-)
  create mode 100644 cmd/i3c.c
  create mode 100644 doc/api/i3c.rst
  create mode 100644 doc/usage/cmd/i3c.rst
  create mode 100644 drivers/i3c/Kconfig
  create mode 100644 drivers/i3c/Makefile
  create mode 100644 drivers/i3c/device.c
  create mode 100644 drivers/i3c/i3c-uclass.c
  create mode 100644 drivers/i3c/internals.h
  create mode 100644 drivers/i3c/master.c
  create mode 100644 drivers/i3c/master/Kconfig
  create mode 100644 drivers/i3c/master/Makefile
  create mode 100644 drivers/i3c/master/dw-i3c-master.c
  create mode 100644 drivers/i3c/sandbox_i3c.c
  create mode 100644 include/dw-i3c.h
  create mode 100644 include/i3c.h
  create mode 100644 include/linux/i3c/ccc.h
  create mode 100644 include/linux/i3c/device.h
  create mode 100644 include/linux/i3c/master.h
  create mode 100644 test/cmd/i3c.c
  create mode 100644 test/dm/i3c.c

azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=184&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
