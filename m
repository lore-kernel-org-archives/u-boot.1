Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8D8C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CB481DF6;
	Thu, 27 Mar 2025 05:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="POtAo5jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8462781D3B; Wed, 26 Mar 2025 16:01:33 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB10E803CC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B97F44293;
 Wed, 26 Mar 2025 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vOTKLa1mqlewAU1oYyujWtVZMdxeJ6MQxCUQPpP1vSk=;
 b=POtAo5joGNVAVtOnJ2dQlaipIIExpi6Kyv1VB4XYl7yINgsXz/2e0iagRCExmc1kaLjR4H
 wkgLo6695APevfbUGpPL0aa/T97GAfJYQYUUDbuToI7rM1zBtQtkOtZt2oGNWpBLqLGL8Y
 hIcl6ByB4Y0/iErjB0B1xMiboiOcNkzhxj2yQF/Po9IaqNEoTFBzIO1/YRBFqK3UpeIVKG
 lgT6o5Gh+98Or9iiebJUpFQnWYT0NoQrpL+urUEnZT4ImLtPANqzgls17k/Znl/Hw/OhvK
 6co8nO0cgHKXZX2lUk2Eaw+usVLSD5SWn2aP1oL+TkRKagBiadYqKYbJwD+w6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 00/12] Add imx8mp video support
Date: Wed, 26 Mar 2025 16:00:44 +0100
Message-Id: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwW5GcC/43OywrCMBAF0F+RrI1Mk/ShK/9DXOQx1QFtSlKLI
 v13R0EQheLyXoYz9y4yJsIsNou7SDhSpthxKJcL4Y+2O6CkwFkoUKZQUEpuzpa6E3UoA+X+ZG8
 yX/o+pkEC+LaC1gXlvWChT9jS9aXv9pyPlIeYbq9no3q2/7mjkiBN1WjnjG6a4LcuxoFPVz6ex
 VMe9VsroShgXtOs8USwHm3VovvVzIem1vOaYc0a7XRV1hjqr23TND0AtQ5IdmQBAAA=
X-Change-ID: 20241205-ge-mainline-display-support-00cf60fbd2cc
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegiedtfeegvedvjefhheeuudektddtfeeggfdvueelheelhfetgeeugeehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgriihurhgvrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtoheprghguhhsthesuggvnhigrdguvgdprhgtphhtthhopehmrghrihhordhsihigsehgughshihsrdgttgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopegurghrihhordgsihhnrggttghhihesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmp
 dhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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

In order to display a boot picture or an error message, the i.MX8MP
display pipeline must be enabled. The SoC has support for various
interfaces (LVDS, HDMI, DSI). The one supported in this series is the
standard 4-lane LVDS output. The minimal setup is thus composed of:
* An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
  stream
* One LVDS Display Bridge (LDB), also named pixel mapper, which receives
  the pixel stream and route it to one or two (possibly combined) LVDS
  displays.
* All necessary clocks and power controls coming from the MEDIAMIX
  control block.

Patch 3 adds a very useful helper to the core in order to grab devices
through endpoints instead of being limited to phandles. Video pipelines
being often described using graphs endpoints, the introduced helper is
used several times in the serires (there are 3 LCDIF, one of them being
connected to the LDB, itself having 2 ports).

Patch 5 is a fix which is necessary for this series to work properly,
but is way broader than just this use case. In practice, when assigned
clocks are defined in the device tree, the clock uclass tries to assign
the parents first and then sets them to the correct frequency. This only
works if the parents have been enabled themselves. Otherwise we end-up
with a non-clocked parent. I believe this is not the intended behavior
in general, but more importantly on the i.MX8MP, there are "clock
slices" which have pre-requisites in order to be modified and selecting
an ungated parent is one of them.

All the other patches progressively build support for the whole video
pipeline. Regarding the LCDIF driver, there is already a similar driver
for older i.MX SoCs but I didn't manage to get it to work. It was
written more than a decade ago while device-model, clocks and others
were not yet generically supported. Thus, numerous ad-hoc solutions
were implemented, which no longer fit today's requirements. I preferred
to add a new "clean" driver instead of modifying the existing one
because of the too high risk of breaking these platforms. Once proper
clocks/power-domain descriptions will be added to them they might be
converted (and tested) to work with the "new" implementation, but going
the opposite way felt drawback.

---
Changes in v5:
- Rebased on latest next. Fixed the conflicts.
- Used Svyatoslav's ofgraph code to rewrite the core uclass function.
- Fixed the tests, again.
- Added a small fix in a comment from Svyatoslav's series.
- Rebased on latest next because there were more incompatible
  changes. Fixed the conflicts in the clock driver.
- Link to v4: https://lore.kernel.org/r/20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com

Changes in v4:
- Created a set of low-level helpers below power_domain_on/offoff() as
  asked by Simon.
- The EVK change has been dropped, as we cannot test it.
- Link to v3: https://lore.kernel.org/r/20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com

Changes in v3:
- Fix a clock name in the imx8mp clock driver (mismatch between Linux
  and U-Boot).
- Fixed the Azure tests with extra changes in the test files
  and sandbox configurations:
  https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10296&view=results
- Link to v2: https://lore.kernel.org/r/20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com

Changes in v2:
- Add ISP clocks to avoid harmless errors when shutting down the
  pipeline.
- Add power domain refcounting to avoid shutting down a power domain
  already disabled. This is useful when a device points several times to
  the same power domain in the DT.
- Ensure the mediamix driver frees all the power domains it got a
  reference on.
- Add an in-tree user as requested by Fabio: the EVK.
- Use the same Kconfig prompts as in Linux.
- Add sandbox tests for uclass_get_device_by_endpoint().
- Enclosed media clocks definitions within #if CONFIG_IS_ENABLED()
  guards to avoid bloating the SPL and configurations without video
  support, as Adam and Fabio advised.
- Disable the enabled clocks in the remove path of the mediamix block
  driver.
- Fix many typos.
- Fix checkpatch warnings.
- Rebase on next.
- Collect tags
- Link to v1: https://lore.kernel.org/r/20240910101344.110633-1-miquel.raynal@bootlin.com

---
Miquel Raynal (12):
      core: ofnode: Fix a comment
      dm: doc: Fix example
      dm: core: Add a helper to retrieve devices through graph endpoints
      test: dm: test-fdt: Add checks for uclass_get_device_by_endpoint()
      power-domain: Add refcounting
      clk: Ensure the parent clocks are enabled while reparenting
      clk: imx8mp: Add media related clocks
      imx: power-domain: Describe the i.MX8 MEDIAMIX domain
      imx: power-domain: Add support for the MEDIAMIX control block
      video: imx: Fix Makefile in order to be able to add other imx drivers
      video: imx: Add LDB driver
      video: imx: Add LCDIF driver

 doc/develop/driver-model/design.rst              |   2 +-
 drivers/clk/clk-uclass.c                         |  21 +-
 drivers/clk/imx/clk-imx8mp.c                     |  69 +++++
 drivers/core/ofnode_graph.c                      |   2 +-
 drivers/core/uclass.c                            |  19 ++
 drivers/firmware/scmi/sandbox-scmi_devices.c     |   1 +
 drivers/power/domain/Kconfig                     |   7 +
 drivers/power/domain/Makefile                    |   1 +
 drivers/power/domain/imx8m-power-domain.c        |  17 ++
 drivers/power/domain/imx8mp-mediamix.c           | 208 +++++++++++++++
 drivers/power/domain/power-domain-uclass.c       |  40 ++-
 drivers/power/domain/sandbox-power-domain-test.c |   1 +
 drivers/video/Makefile                           |   2 +-
 drivers/video/imx/Kconfig                        |   9 +
 drivers/video/imx/Makefile                       |   4 +-
 drivers/video/imx/lcdif.c                        | 314 +++++++++++++++++++++++
 drivers/video/imx/ldb.c                          | 251 ++++++++++++++++++
 include/dm/uclass.h                              |  24 ++
 include/power-domain.h                           |  60 ++++-
 test/dm/power-domain.c                           |   2 +-
 test/dm/test-fdt.c                               |  20 +-
 21 files changed, 1052 insertions(+), 22 deletions(-)
---
base-commit: 042c8f0cb1ea5f6988e8633799f7b550876f0ae6
change-id: 20241205-ge-mainline-display-support-00cf60fbd2cc

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

