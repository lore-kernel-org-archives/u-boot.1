Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0CACEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 17:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4245383B9B;
	Tue,  6 Jan 2026 18:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RUaIrIst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7DF83F98; Tue,  6 Jan 2026 16:35:10 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F5883F6A
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 16:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so219690866b.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 07:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767713705; x=1768318505; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EyebzSmDZZdZqx4IDABY2GdKo0pPql4JOMmvn1qKhXc=;
 b=RUaIrIstcNSIMDp5ezuEtc1AcsrZQAIUgNFQIlbmpcjhtswMQYMnYEd1CTdn/bZmE3
 Dm6kV/9yLktE1Jd8rSV8WGMNEZ+bdC8mzurQGkNW+yfUl0UUoDky5wkVmkBzlyrpmsqk
 YbhFZP+Ly9eUBgIS0jxx1uKzmkTqQ8wh3jSM1+SbxuQ4SY36bkMMtNk1Vjo9ml+y3L7/
 VRw8Xfk1FuVPXXP2h/CT8gMQ4CofOq0XYo/VuQ2axKW6lR9p1vLE/G/azQtmy1Xy4Dxc
 typ4iZJzAAIP6rD2NaUNcmzn1IcN2lUx1/qhGegiD5SPRXYdguQ00f46P9ItFb9dEaVt
 FitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713705; x=1768318505;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyebzSmDZZdZqx4IDABY2GdKo0pPql4JOMmvn1qKhXc=;
 b=rSoYt+gEJD0WoNOcvGc5Dqzf4RIZMZEvnqJ217M/FOQZctt2a+1L5l/D7xEABWgR7T
 FYjH2RkOGMx+YL41JVDOqQA83BrU1BPyFS2quDrAqMUVYTpETtCUMjyZcF0EhgnI3aVo
 v1S0GgsLliA1jUKEfDtJ71UCUM2sX0ZFFgv1WNHLMiMCC6v4veUwjJM5auFcNqjzgHmD
 l0+QouPQd5J2uOiadKFBXQRzIlOtNikK6//ODfhHNhYYR3lie7OTaIM6UMqJqLAqJl3Q
 8TqbW57U6oS6/GFfX3dYaybCIf3LDwpBGmPOX9j2af/fHg6bHSTF7Jc2TmrMkDn1mN/c
 3TcQ==
X-Gm-Message-State: AOJu0YzgVNQcDoAXIf8IjUSfV+7eQoEmppVz7kEuwCFB9LoLilBinjYX
 F91IeY4NtjLqcnlzPfSmAcfuzE5ujK9eT8wX4qXpjpoT6AqojmSlcxuTx7MCRg==
X-Gm-Gg: AY/fxX7z4ddKzZn+V48q+Nmqwu7SMcylJvJILRJ5Y5lCMkMxlH4HQEVQaAbWbJzm4lL
 oOSiOWN2VElSnb4lYw6Ud80rNP6yixGNchWT2qkirMgiZeV/NSId2c45gGesuu+2bzcxluDs+Vw
 55RzohPHScDDtyY0HXLMyXsjNfsV9ND16MgTmIzpOYhpj5VfdBKltsDG95kmDJJgoeaxpSLVc4U
 zGECoz9eF+byIF8YsdDFzvhKepAOC/zWJpfEFaIC5uV95SGsz39aHUXc+hK4+x5Qrholk8VgnVb
 +sF2MDdg/8AqWSKQ2z3L0xEA36w3LOsWtBr9EV62n7S45wbd+zLS44be8EPTPhrAO+lV0FwjyHd
 BDAqOZLIyUOiAvjYlC+coU72Nq8I5NL2MiuxXN1Qhz8m3s7hOzVusMd7X9w5Xpm4GwGKyAtj8WK
 AleDQTWjstYR3zOmwdqKqlfY4tROdro5U2L2IY8F13l8ZoA9bvu2mGgWtkzbly2V1YkA==
X-Google-Smtp-Source: AGHT+IFKnlCgBH5VAQFrc4ZS9M+n9OcqMn5MZaBj8bP1IPUZj4qb9YQWbOQzbSU9MMLdd2uEzVkTrA==
X-Received: by 2002:a05:600c:8b44:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-47d7f410cc8mr33637285e9.7.1767707874751; 
 Tue, 06 Jan 2026 05:57:54 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm4605281f8f.22.2026.01.06.05.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:57:54 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v3 0/5] Enable full UFS boot on Rockchip RK3576
Date: Tue, 06 Jan 2026 17:57:07 +0400
Message-Id: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQUXWkC/23MSwrCMBSF4a2UjI3kYW6sI/chDpL0pg3aVhINS
 uneTQuCgsNz4PsnkjAGTORQTSRiDimMQxlyUxHXmaFFGpqyiWBCccEZjRepNNCHT9Q4af0O95o
 rIAXcIvrwXGOnc9ldSPcxvtZ25sv7N5M5ZdRIX6MGtAB4bHsTrls39mTJZPGhwDhTP1QU6ow1t
 a4Na8B+03me399msOPfAAAA
X-Change-ID: 20251210-rk3576-ufs-ac3bf4e87156
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4889; i=alchark@gmail.com;
 h=from:subject:message-id; bh=/fkkym4BJUqbgp4q0fVjLhRliau0AsWX6o8Q6BobaX8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGipw/dTp1wauqZUpfemUMTHaa8ajvF+js865eESCl+
 KBR2XV9x0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKhjrGPEwMUpAFP9gZHhv8u9pjlqe6f1fProInv79pT0D/VbGVziX7QyL/dd7lNybDMjw0f3k07
 TNFmtUzWvcOvHGa760/HdpbR/+ymfA/xqu9SV+QE=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 06 Jan 2026 18:54:15 +0100
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
 - Patches 2-3 introduce a quirk for the UFSHC to force the use of a SCSI
   bounce buffer for addresses outside system SDRAM, and enable it on
   Rockchip RK3576
 - Patch 4 adds device-reset functionality to the Rockchip UFS glue code,
   which is required for (at least some) UFS modules to respond to
   controller commands upon initial enumeration
 - Patch 5 ties it all together for Rockchip RK3576

This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
issue which patch 4 aims to address, because the boot ROM initializes the
UFS module before handing over to U-boot. If, however, one boots SPL from
FSPI1 with the same driver code, the module fails to respond unless patch
4 is applied.

The bounce buffer and the corresponding quirk is required to enable the
loading of ATF image segments into PMU SRAM, which is inaccessible to
the UFSHC for direct write on Rockchip RK3576.

Note that in my experience none of the RK3576 boards actually boot current
mainline U-boot versions without a single-word SRAM write before jumping
to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, to
test this series I additionally applied commits ea2ebb491e2c..390668db9d13
from Kwiboo's rk3576 branch [2] (including ea2ebb491e2c), so any testers
might want to:

git cherry-pick a256b4182bd2..390668db9d13

from there before or after applying this series

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/390668db9d13b2cd0ac0077c15edb4b575ee28f9
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576?ref_type=heads

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
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
Alexey Charkov (5):
      spl: Make UFS available for SPL builds
      ufs: Add a quirk for SDRAM-only DMA
      ufs: rockchip: Enable SDRAM-only DMA quirk
      ufs: rockchip: Add device reset support
      rockchip: spl: Add support for booting from UFS

 MAINTAINERS                                  |  1 +
 arch/arm/dts/rk3576-u-boot.dtsi              | 13 +++++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
 arch/arm/include/asm/spl.h                   |  1 +
 arch/arm/mach-rockchip/Kconfig               |  3 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
 common/spl/Kconfig                           | 29 ++++++++++++++++
 common/spl/Makefile                          |  1 +
 common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++++++++
 drivers/Makefile                             |  1 +
 drivers/reset/Kconfig                        |  9 +++++
 drivers/reset/Makefile                       |  2 +-
 drivers/scsi/Makefile                        |  3 ++
 drivers/ufs/Kconfig                          |  2 ++
 drivers/ufs/ufs-rockchip.c                   | 26 +++++++++++++++
 drivers/ufs/ufs-rockchip.h                   |  1 +
 drivers/ufs/ufs-uclass.c                     | 13 ++++++--
 drivers/ufs/ufs.h                            |  7 ++++
 lib/Makefile                                 |  1 +
 20 files changed, 173 insertions(+), 5 deletions(-)
---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20251210-rk3576-ufs-ac3bf4e87156

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

