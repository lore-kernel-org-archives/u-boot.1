Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E2C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA6082054;
	Thu,  3 Apr 2025 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cx1OH38p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A52581FC0; Thu,  3 Apr 2025 09:39:21 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4E780194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8B9744380;
 Thu,  3 Apr 2025 07:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743665957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3K35NKeofaBS+XRAwj66qPGZDnUPZNGXuKCXLDgqTXY=;
 b=cx1OH38pYpr4YM9NdWoQjtd6sbFe98ixeEphN3YWAklLX4KA5saWziPM3L+CXO4EdNAAC1
 5cGJRXrA2fxV1aRIh7k32ZrA0c4WbfKHdpJlzzvgjbGToX//kwK10/ejeeZKl3CdxSoIXt
 jrIKNA2OkpyBAaMrkElTJltZ5yIsoFHo7FmCuQJXhBFZXedDMPqNA1YymFHC+bz56GAcp4
 dhhxBB+l8uxygBVTyGX8+g5wS8T7ph3M2Q/0y6z0D5NGXqW/EEhGpb+L+BuIc2I0gWnwm4
 heSVIU6mppk81zjOElPFAIeIDZFLrDclXrYNT3Wmdz1BWjAU4Lzyoiw5WQQYww==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 00/12] Add imx8mp video support
Date: Thu, 03 Apr 2025 09:39:00 +0200
Message-Id: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQ77mcC/43OTWrDMBAF4KsErasy1l+crHqP0IU0GjWCxDKSa
 xKC795JoLSlxXT5HsM37yYa1UxN7Dc3UWnOLZeBg3vaCDz64Y1kjpyFAmU6BVZyc/Z5OOWBZMx
 tPPmrbO/jWOokATA5SCEqRMHCWCnly0M/vHI+5jaVen08m9W9/Z87KwnSuF6HYHTfR3wJpUx8+
 ozlLO7yrD81C10H65pmjSeCR/IuUfitmW+a2q1rhjVvdNDObilu/9hmvzSt3LpmWSNvAuqEu4D
 +p7Ysywe7umBvsgEAAA==
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegiedtfeegvedvjefhheeuudektddtfeeggfdvueelheelhfetgeeugeehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgriihurhgvrdgtohhmnecukfhppeelvddrudekgedruddutddrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddutddrudelledphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmrghrv
 gigseguvghngidruggvpdhrtghpthhtoheprghguhhsthesuggvnhigrdguvgdprhgtphhtthhopehmrghrihhordhsihigsehgughshihsrdgttgdprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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
Changes in v6:
- Another rebase on next.
- Fixed the clock 24M oscillator clock name due to recent changes.
- Fixed a subject prefix.
- Collected tags.
- Fixed the CI by adding two missing configuration items to secondary
  sandbox defconfigs.
- Link to v5: https://lore.kernel.org/r/20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com

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
      core: ofnode_graph: Fix a comment
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

 configs/sandbox64_defconfig                      |   2 +
 configs/sandbox_flattree_defconfig               |   2 +
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
 23 files changed, 1056 insertions(+), 22 deletions(-)
---
base-commit: 3703298e57c8d749b3c06798f5873562754fb84c
change-id: 20241205-ge-mainline-display-support-00cf60fbd2cc

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

