Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1345DD2629E
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 20:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947EF839D5;
	Tue, 20 Jan 2026 21:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3GGKBg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14EA83015; Tue, 20 Jan 2026 21:00:02 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212F68063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 21:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-655af782859so9206263a12.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768939199; x=1769543999; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3HDJbHEiKxgdFZ5hj7OBDa9jlnlewZYAD26U7dzWbXw=;
 b=W3GGKBg2hWxif1ERUazLS0yD+JbfqwukINo0/3bMmE5gaaV2LwiuVjzFWZN7p/x9Ix
 FtuvBZcjUqjUr0B9+d2MCvbN9kR0e2wG5hj6l5w/laZKLtVItUNv96zjyP9ngKeferaC
 Gs7GMnVpvm2r9TAg//Z6Pqytinlbh0eWjatiMhB71qZv5SvvxzoKntm0b23X8e0CYvIe
 L7Z28JYC5nc45iUG3L5N2V1Gux4QDhz626Gy+nWOW2jVvz6woqREEZ1LaNohiAqpXneq
 fYCTC0HS81MsxdBFw/eWZaC2S2YFH18x4W2yvuprIjO6JVmUdmxhK+iAN/kVYMwm3kVF
 vUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768939199; x=1769543999;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HDJbHEiKxgdFZ5hj7OBDa9jlnlewZYAD26U7dzWbXw=;
 b=GQVTJF2pjQCHOFE9fcX7np7L9KZD/elD0m0MwXJNJGj6/MPd8nRFWIEEVEkaZ6IZA9
 xzrxJt4tnuCqX06RIDMeCYq0YXCEwIVuTRuVABQqjxqVs22BVo1aP7kS7hpFcXGvIurD
 rZiE3bEzsrG3fBtM/dxG7dDBwfI8emggQft66JsXrbcJbWKQKQ9QknDmxogXlWCpDHZo
 C7GMtNhy5Ut3tkhElAU0DhfI7RkLuILSs26uGpiekLO+q/lVDwrYHAvrTBuKOMq7N+r7
 aksUNpg+nkPeDwbOtYGFJosLXc7LIwfeANaIRXiDXEOT4So+r3RHSvSGd90fE0iRUbvn
 vehA==
X-Gm-Message-State: AOJu0YysPjXooTOZnrhdTACQHnx4uar9ilRjCfeci6DZnMmXY4S3G+tb
 k9SkdqNJsoqBNiC2l1JHYS+wSJxz8ZxuhNAHF93Z8Wx1jmh3V47Pt1MW
X-Gm-Gg: AZuq6aJZKEZLnyjatkqYzyoJAZbFP+MXEw/23gvdB2O5BhgUHDpdbLWSFQGKxiUN4F1
 SrDRGExwbrfc+5xnvDUdCcI+7LtL7XI4AYrgbGxN7R/cLx1D0wD1YoVZa+JEgwgfvxstjJU7tqQ
 0P0bnJQF5Jfwvn4WnoTp2rNE6G7YudEX7D9vqsqBnhURJArZAFffbmQS3LC9K3Vypyci2aKmMQ7
 mrf4UrTy5TnX/SH++Ug7fHn7h/0IhQzscY4w2BxcnPtxwWMOIH/KaiS87u1eYtEdU6oCqtEvb01
 fkoUd7Jr9ad4Ob5VYIL+KbUSLGIl3+Uc+GILW1KmO1hpAYwy20SYOxIya0Zapay+Gk2l4O8a2Z9
 pNNqucGFm1sjS9l3EB+Pdi4vJ+6S6yiNfIQ0IuyHwHN5BExDuLWadPdaBT1cfvJmHWPqjHlLPVw
 +JG1QaVNc2p+/nadkeJ/xJGkbO8PQrGVvCj2RV4503XFNPIGcoZOZvljmiLW6cnvc=
X-Received: by 2002:a5d:5889:0:b0:431:c60:c5ed with SMTP id
 ffacd0b85a97d-435699787bbmr23488218f8f.13.1768932561826; 
 Tue, 20 Jan 2026 10:09:21 -0800 (PST)
Received: from alchark-surface.localdomain (bba-83-110-134-52.alshamil.net.ae.
 [83.110.134.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569998240sm30168043f8f.43.2026.01.20.10.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:09:21 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
Date: Tue, 20 Jan 2026 22:09:01 +0400
Message-Id: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3Eb2kC/23Q0W7CIBTG8VdpuB4NBwoUr3yPZRcHOChztVvRb
 ovx3Uc1Jmp2eUh+/5DvxApNmQpbNSc20ZxLHvf10C8NC1vcb4jnWG8mhdQgQfBpp7Q1/JgKx6B
 86qi3oA2r4HOilH8usde3em9zOYzT76U9w/L6b2YGLjiq5Mga8sbQejNg/mjDOLAlM8sbNQKEf
 qCy0oAenXUoovHPVN1T80BVpT6R1C5FE8E+0+6e9g+0q5R6MtZ0LqnU39PzdYiJvo51zMN1DTZ
 QKXgZc9XckqCUVF3bCQHKCQ78fdxjWe++sx/HttAyqcdCvHaHfFg1JsRotbMok08BtJUBvMAkV
 VQREwRKKCPZ+onzH3/3O57ZAQAA
X-Change-ID: 20251210-rk3576-ufs-ac3bf4e87156
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6100; i=alchark@gmail.com;
 h=from:subject:message-id; bh=GCVawfkBf65Q30+tusGHdpN6pnALQpygI6V9oPx8TPw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTmHzn1951viHhkYd7aRZ15VY0sN63vxIeYLX78dU6/X
 sqyBWGvOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZhqySqGf5py8tfPXl2l8eV/wh0v457e/0FmZfsTkziNf31Vv52x2J+R4WlX+In
 nmkuv/3gY9XFh9cecNzEqV6q+W/zifXJ7Qv/0Wm4A
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Jan 2026 21:09:08 +0100
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

Rockchip RK3576 can load its bootloader from UFS among other options,
so this series adds the necessary bits and pieces to enable an end-to-end
boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).

To achieve the above, this series goes through the following:
 - Patch 1 introduces arch-independent code to enable SPL images to use
   UFS devices, including build system tweaks and a function to locate
   a U-boot image at a fixed UFS offset and LUN (SCSI device number)
 - Patch 2 adds an option to build the Rockchip reset driver for SPL
 - Patch 3 adds device-reset functionality to the Rockchip UFS glue code,
   which is required for (at least some) UFS modules to respond to
   controller commands upon initial enumeration
 - Patch 4 ties it all together for Rockchip RK3576

This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
issue which patch 3 aims to address, because the boot ROM initializes the
UFS module before handing over to U-boot. If, however, one boots SPL from
FSPI1 with the same driver code, the module fails to respond unless patch
3 is applied.

This depends on Jonas' recent series [3] enabling DMA writes to PMU SRAM,
without which the UFS controller will fail to load ATF and end up in an
unrecoverable error state requiring a hard reset.

Note that in my experience none of the RK3576 boards actually boot current
mainline U-boot versions without a single-word SRAM write before jumping
to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, to
test this series I additionally applied commits 6b152999908b..d43031c4045e
from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any testers
might want to:

git cherry-pick 6b152999908b^..d43031c4045e

from there before or after applying this series

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/d43031c4045ef8aaf29c467b910207e721dabce0
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576?ref_type=heads
[3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.se/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v5:
- Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
- Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
  This also pulls in SCSI to avoid compilation errors.
- Split out the patch enabling the Rockchip reset driver for SPL builds
  (thanks Quentin)
- Reworded the error message when requesting the UFS reset GPIO fails
  (thanks Quentin)
- Added a note in the commit message about reset-gpios being required by
  the DT binding (thanks Quentin)
- Dropped the redundant check of GPIO validity in the reset function
  (thanks Quentin)
- Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
  on RK3576 (thanks Shawn)
- Dropped "imply" symbols from the arch Kconfig, now that both GPIO
  and RESET drivers are explicitly depended on from the UFS driver
  (thanks Quentinq)
- Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com

Changes in v4:
- Added a dependency in b4 metadata on Jonas' new series enabling DMA
  writes to PMU SRAM (thanks Jonas)
- Dropped the bounce buffer quirk altogether, as it now works as-is
- Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com

Changes in v3:
- Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
  SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
- Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
- Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com

Changes in v2:
- Rename the SPL UFS read helper function more self-descriptively (thanks Neil)
- Add an option to configure the UFS LUN used to look for the U-boot image
  in raw offset mode - or rather the SCSI device number, which most of the
  time coincides with the UFS LUN as long as the UFS device is the only
  SCSI block device the SPL sees (thanks Neil)
- Add an option to use a bounce buffer in RAM while loading U-boot from UFS,
  which helps avoid changes to common spl_fit.c code which in v1 achieved a
  similar result at a performance cost to unrelated platforms (thanks Jonas)
- Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com

---
Alexey Charkov (4):
      spl: Make UFS available for SPL builds
      reset: rockchip: make device resets available in SPL
      ufs: rockchip: Add device reset support
      rockchip: spl: Add support for booting from UFS

 MAINTAINERS                                  |  1 +
 arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
 arch/arm/include/asm/spl.h                   |  1 +
 arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
 common/spl/Kconfig                           | 30 +++++++++++++++++
 common/spl/Makefile                          |  1 +
 common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++++++++
 drivers/Makefile                             |  1 +
 drivers/reset/Kconfig                        |  9 +++++
 drivers/reset/Makefile                       |  2 +-
 drivers/scsi/Makefile                        |  3 ++
 drivers/ufs/Kconfig                          |  4 +++
 drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
 drivers/ufs/ufs-rockchip.h                   |  1 +
 lib/Makefile                                 |  1 +
 17 files changed, 155 insertions(+), 2 deletions(-)
---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20251210-rk3576-ufs-ac3bf4e87156
prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

