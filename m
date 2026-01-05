Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23AC79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B3483E61;
	Mon,  5 Jan 2026 19:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ot8Q9ub7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813CC83E43; Mon,  5 Jan 2026 17:59:18 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C9283E1B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so27817966b.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767632355; x=1768237155; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2xzTN2I0MkcAahr7lVK/cCe6gP+mg8uaKnyiifXtMyM=;
 b=Ot8Q9ub7nj0fXvMFVn0n9w9ZaIjl3aaG5YGHvjhX0hQeKzBQHl17CGV0ytImIfab4/
 1lj78Zjmn3u3MMiyOtk/y8Ig23GeWNnlKaKRit/D1qZDAD8G2yTmTJhKu9LPLj2gZG1M
 lL6Lxy7IEtvRiWk7CbQ1gpiZUKYNB+Ry9veQrOj10BZ2AWOa9Sth29UyAR+u7TDo0ka/
 /Pc0RlpuLNwcjZjx5MKtMlcevkcypM2/uwWd9vnqc5VXhzDhFD0u4u4Ut1CAheDCsu0e
 iqnWxjl7w41f5/I4Fldeu77/dd4IOXbZesMsGUsmdRaaOWobYoIU0qbXEUnXcNCZlpI0
 N1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767632355; x=1768237155;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xzTN2I0MkcAahr7lVK/cCe6gP+mg8uaKnyiifXtMyM=;
 b=FNVa4I+TxpeesoL3SKK8RYUC+SFPN/MmXSrEqGDU9bNFqOxd+uMRkCSRZjzy28ospp
 nnYAX11+cBlrKjYcLOzRQW3g27UydRwKUbW5s1YFu9qT0Ch1cb/vWaYRZlVnv+SIVpeU
 Jb5hB8XJNWXDDNIGV6MMirsVQdvh8M2ooHuVYsKYO2koctAqvsZwUvQWrGzV5Ri5lPuB
 FgCXVSKKbeGo/iA3HblsEp2CERqEjGkFKo9T68lmUu1HbIgAfjHudZ5b0A7YoOW+1L4v
 qLYhbDr89CRtEONsWoPiT3VZtQ88KOIIDUwX4+wVp+pNMYWvdzmctVtV0Tc0AKyLkwNh
 jprA==
X-Gm-Message-State: AOJu0YxjfBgM8PhIvttEkRn7D8tdBlHn3h6aLVLuvUwUd1ljvV9xCSmi
 J+vxYGxxkvXhcRZ5fXo7YJCLvsxJpVdbsLz38kHEiGxG8pFQebh9scocPEsxjUD7
X-Gm-Gg: AY/fxX64YqG5IuT/CXh+zOjAmAgIoN+jytxx27RJ2V9YQVktCxvVGwf4pTAjYEVUS6b
 IQUHuGxFesRLz6DHlTdhu1kAGh5rsgIycv9G5j4KoUqYrPlWwPprftk8dWC9Q90pXHH/c9UwGW9
 3nbUt0JDtjYMjOOR2fDkjKtv30heNR00LngmJ6AC0YKSkilq1Pb/2bUWIt8Mg91iVOvqeiAbCQK
 2JH/Dz6A6vn8Vq0+Jwe5fQJR9UMA+1W1ksTJlyXfpsOH4QRqxXcJEuMNOK3gntzQIRPi3rAnNcc
 /dX0aAUC3PDUJnUnqb6GYSyi0/apfMczPXwt+Ihq4rjWFphm5wlRF1nFxhuvMCC0g0FX/XGm+3x
 MdBdEb7yUs7nYOHaETP4vgYCX0d6USf0GTql8kpSiFFzesRScxf4VkNA+yU+m7ErELTJ2Pkg1a4
 6aLBXVNc9uqWM47L5r4NvaYXzsBDj7ihx9aL9Y7j1mZBexYowlXlMbwUg3jflmhAmXNA==
X-Google-Smtp-Source: AGHT+IHpAf30La6P2LO3S9Xm5j77mhcSlPXNBT2Pm/Z2KUrGgYvB7TCUsKTVhnrCwqQFqLoJmwqoog==
X-Received: by 2002:a05:600c:4fce:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47d194c5bffmr560233505e9.0.1767625565287; 
 Mon, 05 Jan 2026 07:06:05 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c08f9b7sm57955335e9.11.2026.01.05.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:06:04 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v2 0/3] Enable full UFS boot on Rockchip RK3576
Date: Mon, 05 Jan 2026 19:05:35 +0400
Message-Id: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/TW2kC/23MSw7CIBSF4a00dyyGhwXtyH2YDihe2httMaBE0
 7B3sWOH/0nOt0LCSJiga1aImClRWGrIXQNussuIjK61QXLZCik4izfVGs1ePjHr1OAPeDSi1VA
 Pj4ie3ht26WtPlJ4hfjY7i9/6l8mCcWaVP6HROGiN53G2dN+7MENfSvkCiZdflKQAAAA=
X-Change-ID: 20251210-rk3576-ufs-ac3bf4e87156
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=alchark@gmail.com;
 h=from:subject:message-id; bh=4YPPBUDyDVvuYa4An3BPlJ9zA9pPoDPVo2j2mNZAvxk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRGX/beqMFz76xZnNDrRKH3ce1lZV8l5onXXmM8sWQXi
 yy3S8C1joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKb6Nw8jw6e9u8u032QlxCd6C9zaI5cw4Wrx/D+zPzh0Ha5s10gWe8XwT0+u1o1
 9Rh6H72ax6UvC3zyOYMpY5aoZr2DSrvrUyraLAQA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:09 +0100
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

Changes to spl_fit.c which used to be part of v1 submission are no longer
required with the introduction of an optional bounce buffer for UFS block
reads, which is now folded into current Patch 1. This bounce buffer is
currently enabled by default for ARCH_ROCKCHIP, and it is similar to how
Rockchip's downstream SPL operates. It might be possible to allow the
UFSHC to write directly to PMU_SRAM, in which case the bounce buffer can
be disabled going forward, but there is no documented way to do so yet.

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
 arch/arm/dts/rk3576-u-boot.dtsi              | 13 +++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
 arch/arm/include/asm/spl.h                   |  1 +
 arch/arm/mach-rockchip/Kconfig               |  3 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++
 common/spl/Kconfig                           | 48 ++++++++++++++++++++
 common/spl/Makefile                          |  1 +
 common/spl/spl_ufs.c                         | 65 ++++++++++++++++++++++++++++
 drivers/Makefile                             |  1 +
 drivers/reset/Kconfig                        |  9 ++++
 drivers/reset/Makefile                       |  2 +-
 drivers/scsi/Makefile                        |  3 ++
 drivers/ufs/Kconfig                          |  1 +
 drivers/ufs/ufs-rockchip.c                   | 25 +++++++++++
 drivers/ufs/ufs-rockchip.h                   |  1 +
 lib/Makefile                                 |  1 +
 18 files changed, 189 insertions(+), 2 deletions(-)
---
base-commit: 5e7624979083e2bc163e18165452d8ead462b58c
change-id: 20251210-rk3576-ufs-ac3bf4e87156

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

