Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65DEC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DEC83327;
	Thu, 17 Jul 2025 08:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752732591;
	bh=41KK3LY7IrRN5Oa+iwdgg6zy2VZMclV44s4AIfuD6iY=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=YSBbx689xnPFvGfYmoHC6a849l6wbSu5epLfeKkns7Og9mTkWgMJDcauoypZvU8Hj
	 QqjfcN2DyS8OVY+G4L85XNajN2qx0C9ldyvxF7KUUTsUN+9Bw08DlDo+GKT5bQ2ja6
	 eY2F0lZf2v7Zb0ppGZsmhl2MBoOyL3cbSCtZFK9s5vQA8/44uQ+UlaGL60WYXmcKXp
	 hnRT4YENMUIK2IjjL+7w54Uy17dIRWh56xIUoyzSVmghhEPC7xTCZ6rYlSl6uubs2l
	 OPMbF5yZVHfJYkd8pz6XBbLjUvDYayoy73XqtkVXIoPdO73rDHYG3qmqu+9p322y3Y
	 4/1Y8mo1urLCw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B788083381; Thu, 17 Jul 2025 08:09:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72836832EA
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZEbICIvp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF08210397286; 
 Thu, 17 Jul 2025 08:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752732586;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=41KK3LY7IrRN5Oa+iwdgg6zy2VZMclV44s4AIfuD6iY=;
 b=ZEbICIvpabdSwx9wmK1HVIRK9eV7D5Xwh7fLxryGmHTpJ55023J01kfuaLgnDH7YyrVSo9
 kovYI3LQs04amIX0e0nSA+txbQ4rf4LTf3AsxMqX6Lun43sNPzO8h51Qbz1z8BwwhXGHaG
 oGudgs4iizDfQWthuthRV0CHEkIC1nnCMHW3Im5lX5Bqzd3ZbCFTHVSR8UqBmztm0l59I5
 ZjX+61vJlLBiuS1kYUR6diovC5N1m0EDPgMDzSfLvdZzZ7lvaMlwM4LMyDJEwdKvaQ1r62
 NFYNAzL79ARZxyKoctU56genNyurKsViDdULDA/erhFKdMisCcXOBCJN7lPp6g==
Message-ID: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
Date: Thu, 17 Jul 2025 08:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Frank Wunderlich <linux@fw-web.de>, Padmarao Begari
 <padmarao.begari@amd.com>, dinesh.maniyam@altera.com,
 Holger Brunck <holger.brunck@hitachi-powergrids.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

The following changes since commit 53bd87651e45b32efa398dd5e433d8b93d781445:

   block: sandbox: Add support for SYS_64BIT_LBA (2025-07-11 11:33:25 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git i2c-for-2025.10

for you to fetch changes up to 5e80c6757378d09950235083533e7a7c3aeae3be:

   configs: agilex5_defconfig: Enable i3c configs for agilex5 (2025-07-16 09:33:54 +0200)

----------------------------------------------------------------
i2c updates for v2025.10

- i2c Kconfig updates from Tom
   - add some driver dependencies
   - added missing include delay.h in iproc_i2c.c

- i2c: muxes: Add PCA9541 i2c arbitrator driver
   from Padmarao Begari

- pca954x: add pca9545 support
   from Frank Wunderlich

- cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C
   From Holger Brunck

- added i3c support to U-Boot and enable it for agilex5
   board from Dinesh Maniyam

----------------------------------------------------------------
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

Frank Wunderlich (1):
       i2c: muxes: pca954x: add pca9545 support

Holger Brunck (1):
       cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C

Padmarao Begari (1):
       i2c: muxes: Add PCA9541 i2c arbitrator driver

Tom Rini (2):
       i2c: Add missing <linux/delay.h> to iproc_i2c.c
       i2c: Kconfig: Tighten some i2c driver dependencies

  MAINTAINERS                        |    7 +
  arch/sandbox/dts/test.dts          |    8 +
  cmd/Kconfig                        |    6 +
  cmd/Makefile                       |    1 +
  cmd/i2c.c                          |    6 +-
  cmd/i3c.c                          |  271 +++++++++++++++++++
  configs/sandbox_defconfig          |    4 +
  configs/socfpga_agilex5_defconfig  |    3 +
  doc/api/i3c.rst                    |    8 +
  doc/api/index.rst                  |    1 +
  doc/usage/cmd/i3c.rst              |  146 +++++++++++
  doc/usage/index.rst                |    1 +
  drivers/Kconfig                    |    2 +
  drivers/Makefile                   |    1 +
  drivers/i2c/Kconfig                |   11 +-
  drivers/i2c/iproc_i2c.c            |    1 +
  drivers/i2c/muxes/Kconfig          |    7 +
  drivers/i2c/muxes/Makefile         |    1 +
  drivers/i2c/muxes/pca9541.c        |  297 +++++++++++++++++++++
  drivers/i2c/muxes/pca954x.c        |    6 +
  drivers/i3c/Kconfig                |   27 ++
  drivers/i3c/Makefile               |    5 +
  drivers/i3c/device.c               |  262 +++++++++++++++++++
  drivers/i3c/i3c-uclass.c           |   38 +++
  drivers/i3c/internals.h            |   26 ++
  drivers/i3c/master.c               | 2070 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i3c/master/Kconfig         |   11 +
  drivers/i3c/master/Makefile        |    3 +
  drivers/i3c/master/dw-i3c-master.c | 1062 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/i3c/sandbox_i3c.c          |   56 ++++
  include/dm/device.h                |    2 +
  include/dm/uclass-id.h             |    1 +
  include/dw-i3c.h                   |  252 ++++++++++++++++++
  include/i3c.h                      |   93 +++++++
  include/linux/i3c/ccc.h            |  385 +++++++++++++++++++++++++++
  include/linux/i3c/device.h         |  286 +++++++++++++++++++++
  include/linux/i3c/master.h         |  698 +++++++++++++++++++++++++++++++++++++++++++++++++
  test/cmd/Makefile                  |    1 +
  test/cmd/i3c.c                     |   50 ++++
  test/dm/Makefile                   |    1 +
  test/dm/i3c.c                      |   34 +++
  41 files changed, 6145 insertions(+), 6 deletions(-)
  create mode 100644 cmd/i3c.c
  create mode 100644 doc/api/i3c.rst
  create mode 100644 doc/usage/cmd/i3c.rst
  create mode 100644 drivers/i2c/muxes/pca9541.c
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

Thanks!

Azure build shows an error:

https://dev.azure.com/hs0298/hs/_build/results?buildId=180&view=results

https://dev.azure.com/hs0298/hs/_build/results?buildId=180&view=logs&j=6be877ff-932d-5d95-9b1f-9903312b5111&t=a6f13977-3537-5140-4cdf-3c258dd9359a&l=346

! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other tests will run !

So, I think, it is not a problem with pull request...

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
