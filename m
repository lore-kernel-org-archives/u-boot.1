Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B9D1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075A184286;
	Thu,  8 Jan 2026 18:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaMGcKGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB088427F; Thu,  8 Jan 2026 18:50:36 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7AA841F2
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-382f9211cbfso30372611fa.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767894633; x=1768499433; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1ZBb7ImHOjq5dYS9XlyjK/O+bSwvr23kbYYg+eC/QU=;
 b=SaMGcKGb/oL0qi9Tr/TOOBn8l5tJ2k1Ov/qQa6ED6q/tSqjs37+loHesB8ZmA3Lc89
 X14aQT8fdvf4JfrsAKJFMkF4yXpyYEn8L0qOX60Viz0Y5+4E+hIAzONHPxisgykJkHpv
 3PrMZx+S+tfMyOFN9h3CBMUg6/ikCbWrcwjTHH9M1FlcEKF+COjd3rWFnCc+EKn+aaGb
 ghCMNmzj5aifUEB6EDM6a8Y4VhrkavB6e96oal8wsbhL6MjZoYZyRtIrdLxyuUJx8dex
 BXbvol6qv2qPMjMZm9MAy9HF8Y39qhR2tVO+hK+U8lSrZt6vE8wvxeKUy+ZH1RkdHH2p
 WnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894633; x=1768499433;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1ZBb7ImHOjq5dYS9XlyjK/O+bSwvr23kbYYg+eC/QU=;
 b=FrNzc9Bkb7y8pFRh76cbRVd5zyr80UmQ3+wRx+JdtLDGouerT0pIz4t/FfujlQ9s+X
 3xC3LdIgx4uF0XkU2zrKEAVu51ahfepI/9hGJ2Hn7zwTFsa1HwpwJ3JbvcnWFKqfXuec
 otFRl6HzsgNEmWZkvmMmE7Ifg2G3olwJMCrMDNWioxPJmepdF5WeAuQgLYlE4FfWq+Sh
 D+6mRZMQ4SpCEjSKxHAoT2GBvKqUPv529elEewMHP5OHejmGTtbn6h7sYi7QzbkekgMQ
 hh9b8OoxFnZhZNFyWGLkF8iH3arN/R2YcqklmFlrMRS5PI48hNy55U5oVzQ+D0JnswdF
 aJNQ==
X-Gm-Message-State: AOJu0YyvxgqKCIHjNnQzX4Yx/Fje/0u1yW8b+x30Nf+R0PNIBZ14JAX1
 R2aD82NyAYmnm0FWSYFlH7DGdT2zBFACAVDpG9DYNp3jlczCLU0jX8O1
X-Gm-Gg: AY/fxX4MqWaxDoGFO00zKGq2zfDrvkB6VDosi1KvLo7MgrQKV8uXG6H4KEs7yOP8Fsn
 uVJUOFCnvzae7WTtTiG5db6dtI2ThF7FwgawKpttm6zFTxeTxzLt0R3kW8hOnPnLxs8tQkzs1hN
 GufEHdAoSz4YRvbLzuIoz2A1hiZDWAiG3Jr9wL2F5MKLMSK2sdfSdhsaajzs4rOIN71EkUTsboZ
 PrKTTo3hTPcFaoJAxPFmMFQCjJfClbPIDEDHl4LmkgojYyWB2bmcg3BIxVbnXrHJK2XNI2fqFdX
 Xgayn/tcaPx6+kCl8X6EgJsSB3dTxlMLRsaTSMVI+sTr5SA5d/S5RRfLAPEMfbJ7kBIwsOvqYEf
 FCaexheqxi9oOhkFIjiWioLXYSMO94eGXk2c+1ySX7YhGLDkw3msdn+wRnejqvhtY8TxZb+hiC4
 t04/S2nCPNNHT/8FEtRmknw+3C5mv2DBL1IwjF1Q8SJuBNhhrWwD0fl4s1r7c0SP9OjA==
X-Google-Smtp-Source: AGHT+IFWcq4AFQNYKNSgCMlF7+TdHDlNv7aYgYrH9cpotOccbsFw4RfOYIYnMmpoEyNBlK24jxRXTw==
X-Received: by 2002:a2e:b8ca:0:b0:381:800:910d with SMTP id
 38308e7fff4ca-382ff85846fmr20333001fa.38.1767894632568; 
 Thu, 08 Jan 2026 09:50:32 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-382eb8f478dsm17988701fa.37.2026.01.08.09.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:50:31 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v4 0/3] Enable full UFS boot on Rockchip RK3576
Date: Thu, 08 Jan 2026 21:49:57 +0400
Message-Id: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXuX2kC/22QQW7DIBBFr2KxLhYDBmKvco+qiwGGhKa2U+O4r
 aLcvThppaTq8o/0nub/M8s0Jcqsq85soiXlNA4lNE8V83scdsRTKJlJITVIEHw6KG0NP8XM0Ss
 XG9pY0IYV4DhRTJ9X2fNLyfuU53H6uroXWK//ahbggqOKLVlDzhja7npMb7Ufe7ZqFvmLGgFCP
 6CyoB4dtrZFEYz7i6p71DygqqAuktRtDCaAvUcvtzYTvZ/KIvOtEuspZ7wu0lU/yg0oJVVTN0K
 AagUH/joOmLeHj+TGsc607uIwEy/ePs1dZXwIVrcWZXTRg7bSgxMYpQoqYARPEWUgW564fAN0+
 TbOngEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5073; i=alchark@gmail.com;
 h=from:subject:message-id; bh=zCQozDVjkwoT8CiOXuTekzQWP7Bt2v0Y6z3WCEPH3Nc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGv4svL7g5f/pNS7F9fUY1NrNf8G9m1NzPVd644CPPS
 lcGn365joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKZ6djQjw9RszwMiISuDlC6/0xHtf2k+OfZV84pPwrsEVIKjPNqmf2b4Kx48/eo
 /pr554g7nc+O2122IvR6QMCfczervguUeE5hncAEA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Thu, 08 Jan 2026 18:51:53 +0100
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
 - Patch 2 adds device-reset functionality to the Rockchip UFS glue code,
   which is required for (at least some) UFS modules to respond to
   controller commands upon initial enumeration
 - Patch 3 ties it all together for Rockchip RK3576

This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
issue which patch 2 aims to address, because the boot ROM initializes the
UFS module before handing over to U-boot. If, however, one boots SPL from
FSPI1 with the same driver code, the module fails to respond unless patch
2 is applied.

This depends on Jonas' recent series [3] enabling DMA writes to PMU SRAM,
without which the UFS controller will fail to load ATF and end up in an
unrecoverable error state requiring a hard reset.

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
[3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.se/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
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
Alexey Charkov (3):
      spl: Make UFS available for SPL builds
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
 drivers/ufs/Kconfig                          |  1 +
 drivers/ufs/ufs-rockchip.c                   | 25 ++++++++++++++
 drivers/ufs/ufs-rockchip.h                   |  1 +
 lib/Makefile                                 |  1 +
 18 files changed, 154 insertions(+), 2 deletions(-)
---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20251210-rk3576-ufs-ac3bf4e87156
prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

