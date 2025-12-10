Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934CD3E77D
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C69783A71;
	Wed, 10 Dec 2025 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fcD7094y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45AD83CAA; Wed, 10 Dec 2025 21:11:22 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACD68042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59578e38613so130248e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765397479; x=1766002279; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LVJbLFGK5Sfuo+YVbD6ZGLL6a5Wq/EjHaIhuXFPVDz4=;
 b=fcD7094yr0ILJCaDi9amkKnDNe/8gu8VE86+IOHfEFWn5MKV78UanhFClRq6XuXOsA
 EE2vzRkqI9j+XgFM+OepevKE9fC310OmdH2rVg9GwJajmKuEChOR16zYiWh9x5A0769a
 kTD5YGELpO0vURs7U/1D34j1wHIl1h36p+xyEW9Le1d+WGuMxaKozz8HLUzW+BAY3rWj
 1z7d3Iplt56uSl+953hL2hItzbJfsQ5+WwG2dVd1wHh863veeaZlHZ26cQmwndouFvVd
 Y1O+RFbKNBTka8gX4Y8+KYd2OV2cfhSmv5VcUbqObEj8p1yVW8F+jBnjJ+LfR0LLcHxi
 vSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397479; x=1766002279;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVJbLFGK5Sfuo+YVbD6ZGLL6a5Wq/EjHaIhuXFPVDz4=;
 b=UbWZBCVQ7kSPAadrjtiqBYatuSYgC2OHwv68gKNVa2x+UCLPS4mh+b2zgWYuVBisT2
 TEdTBWS9pMsuxh+y2GfisGO/QuWvmLG0e90Ym1GaE6vd7QxlconFrSF/ZXy3o45SXQpi
 YYGxU7znptbW6DGxukf8YEJ7qIfJRfwRcY5p8D6GfTXHfXNwPMSNa9ei64rWkHbhP+Tr
 WBYM7MkPqxCRSugngtFH07BGJ/f2cxNRCe1NT11XY3O54WuKCfRzvLLnUXPnTkt1wVPv
 NK6zkYYYCJKNIWgHF4rgdNt26fqtZDGmNv9Hgaki6qavZcHrCVP6b4rbw9mLIJ6bew2/
 v1TQ==
X-Gm-Message-State: AOJu0Yx2qFxKWqRuoJVaiwUx+apG0hmuk9l84SLfbP+SZZgYv8Wzv932
 ut7YY08JIAG/0LACBCSEDO5aAkuUP3Wzz6HKBffQGsX5ACvg4kZ6qNva
X-Gm-Gg: AY/fxX6SjHqXfivAMc8JS/LOm1BwIWXKzNuECadzsV6IxDgQYOMD4SSs1YC6rqYwUTL
 8WABLOfrVSPAONr7yyN8/NwarRZuT4VvTQd+VoMYBQoJMNSjmjNdqJqT7onjnXTBQAN+BUrT1u8
 1sGYiyZbwmXBOX4jYchcU0Um3knEq+xXRYlHSXkbBhZ6UUUf5A2GJVmciC7YMbWMN3/fp5CW2BF
 MQYaiHfShEmNapvyCw9Yhu+LWENOAXlCxA1ZwfYcYN7fCVtqCXZgOGxlOnWIxwCeB7ndQpqPWLL
 3Mo+Ja2/egPVwqyIaUONlw1QMtwok6S9zuNzy17ePR9plvjjJgZz4RHYcGgRbBGvgLVbXORWx0K
 7TCjX4mwfN327l2y5FffmEFFecl0H6cUXUz5szjhhBWF+0z7LsfVO5qxQEuSRiClPtHNV3tvzWZ
 RalrtmR/1X2/cAcvKdPbOAXlZzTP0K5CyEHmw=
X-Google-Smtp-Source: AGHT+IHYsnsE5GhrXT+kQ9/uV8UwNoZ2vELkIonY7Rwm7Ofdq8dtA3SJNt3md+ToVdayNADaqMTXlQ==
X-Received: by 2002:a05:6512:ba0:b0:594:2f72:2fa2 with SMTP id
 2adb3069b0e04-598ee4d5a7cmr1282191e87.5.1765397478848; 
 Wed, 10 Dec 2025 12:11:18 -0800 (PST)
Received: from alchark-surface.localdomain ([31.173.84.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f2f45bbbsm134986e87.45.2025.12.10.12.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:11:18 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/4] Enable full UFS boot on Rockchip RK3576
Date: Wed, 10 Dec 2025 23:10:46 +0300
Message-Id: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMbTOWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0MD3aJsY1NzM93StGLdxGTjpDSTVAtzQ1MzJaCGgqLUtMwKsGHRsbW
 1AKrr+3BcAAAA
X-Change-ID: 20251210-rk3576-ufs-ac3bf4e87156
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anurag Dutta <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4479; i=alchark@gmail.com;
 h=from:subject:message-id; bh=J9+a8kdiEqQCWmbDYsxMNpnKFP+/vs3p1YwfIJtQf2w=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRaXn62S3RC4m3FSpc5k+9+Dll/ZOZikSjWRt9ztuGyg
 eZqxW+edJSyMIhxMciKKbLM/bbEdqoR36xdHh5fYeawMoEMYeDiFICJxM9m+O+7fPO0rwLb1Zz9
 orNYjzz/Obv4ja2lH8f5hq3Zsa33PSIZ/kcGbuCTKN/kc47FTDv5wLHp7SkNpjqqehGztB7MaWn
 uYgAA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 10 Dec 2025 23:28:32 +0100
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
 - Patch 1 adjusts the existing SPL function for loading FIT images so
   that it doesn't try to immediately read an image fragment into its
   ultimate load address, as this causes trouble with a load address
   in a memory segment inaccessible by the storage device's DMA
 - Patch 2 introduces arch-independent code to enable SPL images to use
   UFS devices, including build system tweaks and a function to locate
   a U-boot image at a fixed UFS offset
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

Patch 1 is necessary because at least on RK3576 the UFS controller cannot
directly write the first section of the ATF image to its required load
address (which happens to be in SRAM, not in system RAM). This is what the
current spl_fit code tries to do unfortunately, leaving the UFS controller
stuck in an error state. In this series I rely on the fact that all code
paths in spl_fit which follow the initial load do either a memmove or a
decompress operation, so the initial load address ultimately doesn't
matter. I thus replace it with the Kconfig specified base load address
unconditionally, on the assumption that this address is always accessible
for writes. The memmove operation down the line then ensures that the CPU
and not the DMA controller write the image to SRAM, which works.

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
Alexey Charkov (4):
      common/spl: fit: Avoid directly loading images to load_addr
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
 common/spl/Kconfig                           | 16 +++++++++
 common/spl/Makefile                          |  1 +
 common/spl/spl_fit.c                         |  6 +---
 common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++++++++
 drivers/Makefile                             |  1 +
 drivers/reset/Kconfig                        |  9 +++++
 drivers/reset/Makefile                       |  2 +-
 drivers/scsi/Makefile                        |  3 ++
 drivers/ufs/Kconfig                          |  1 +
 drivers/ufs/ufs-rockchip.c                   | 25 ++++++++++++++
 drivers/ufs/ufs-rockchip.h                   |  1 +
 lib/Makefile                                 |  1 +
 19 files changed, 142 insertions(+), 7 deletions(-)
---
base-commit: e09d04dae5aaef5cda6b648c9c0b8282fce05559
change-id: 20251210-rk3576-ufs-ac3bf4e87156

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>

