Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE10C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16F387EFA;
	Fri, 12 Apr 2024 00:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="VOgcMrUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D4F8758B; Fri, 12 Apr 2024 00:37:36 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFE387B82
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc74435c428so311356276.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875053; x=1713479853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dGXPROmXYbIMQfLOaTHpvb9aWxe0oVsLcWqFJvzaw4c=;
 b=VOgcMrUiYzeqSkdjGPq1uZ4m9GxDiQbTfibWzZGJp9M2wukPt0uxSLf5UPUQM2PdSu
 sttxgxNoHIc2xB7EYvLOr2HzIJKmXLXM0ckyYthCkSI7rPu8VTaIbuceVucBrOfKLaow
 PPWSCoif/hz1Alu7/vX3LX3QssYeqasME9NY/JWj2dI2KyTdjeNOLu1V7VwFT2JmXmpE
 vNVOkTSCXTXBNzGVRmK6+IkBZQd3brh7VeuH7t62KAOnWQ3D3vNUrMtprXvOuK0H+r2a
 +t6zEbkjtS+eb4Vu1vTwaffTwyJnqUye++fwSWdVmWYb4bawWdh0Ef9d+BlaT3xTONoW
 K/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875053; x=1713479853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGXPROmXYbIMQfLOaTHpvb9aWxe0oVsLcWqFJvzaw4c=;
 b=RWnHuFTxZ/Byt6bY0um4lq2DFtvMYWdysBqSLtwSA/E+d73k35dO+Qht3hDlRlB0gD
 4AWhHqrVXqWLUjPwyjyT3XaxOCLvSgddqD7EMKpxPur6Y23CXTV7K9SoMLEpD55+RACA
 ivqwA0izqFT2YMZlL5IDIPnEPhriGxy4qQ4LteKRAn1F0jxaBTBRTQhGv3N+T3V7CZWW
 ex/x7a+mVM/UhP5MIdp+HnbnylFgXu0BAoJX4wdGOoOs4IBNChOHuWlif+fe4GDF40pp
 K+cSR7yXitsC7trrXj9lyOn55uJgWxXHBEqqEDDNvTtKKx7VTs00CmOS47eb1b2fD1kU
 sWsw==
X-Gm-Message-State: AOJu0YxY6d99DusEvksqz/ycqObvRbVjQ3XuNSLfvW98YPRLmsa12HUV
 qfPS38wz6po+CvgpErAp61sPUrH1pT2Y+cG6Crxk4LZ84S0bsdX4wObNsVOTWW4sjLUfLW/l/Q/
 N6Q==
X-Google-Smtp-Source: AGHT+IG278zXb+pV0NyufYKac6oyL1kpA12N5NoU2+ST2Q/jPsaDJCCCgDI6qanJ1g1UcLc2PGYt2w==
X-Received: by 2002:a25:bc82:0:b0:dcc:1c6c:430d with SMTP id
 e2-20020a25bc82000000b00dcc1c6c430dmr939718ybk.12.1712875052675; 
 Thu, 11 Apr 2024 15:37:32 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:32 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Greg Malysa <greg.malysa@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Apurva Nandan <a-nandan@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Bruce Suen <bruce_suen@163.com>, Dhruva Gole <d-gole@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jim Liu <jim.t90615@gmail.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neal Frager <neal.frager@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH 00/11] cadence-qspi: Add DTR support including PHY mode
 calibration
Date: Thu, 11 Apr 2024 18:36:44 -0400
Message-ID: <20240411223709.573-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Apr 2024 00:51:44 +0200
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


This series introduces support for DTR mode for the Cadence QSPI/OSPI
IP. We have been developing it against the SC594/SC598 from ADI, so
there are some limitations specific to our hardware's capabilities.
Ideally this series could be enhanced with features introduced in a
patch series submitted by AMD, but currently no work has been done to
reconcile the two. So this is somewhere between an RFC patch and
a patch series we wish to submit as-is for inclusion.

Beyond the specific support for the QSPI peripheral, this series also
introduces a more general calibration framework as part of the spi
system in order to facilitate integration of calibration support for
other controllers within a consistent approach.


Ian Roberts (11):
  mtd: spi-nor: Add calibration hook for high speed SPI
  mtd: spi-nor: Octal DTR support for IS25*x
  spi: cadence-quadspi: Enable DDR bit for DTR commands
  spi: cadence-quadspi: enable opcode extension based on command length
  spi: cadence-quadspi: disable automatic write enable
  spi: cadence-quadspi: unconditionally disable auto status register
    reads
  spi: cadence-quadspi: Remove redundant DTR state
  spi: cadence-quadspi: Direct mode does not support zero length
    addresses
  spi: cadence-quadspi: Add support for memory DMA channel transfers
  spi: cadence-quadspi: Add DT control of max Read Delay Capture value
  spi: cadence-quadspi: Implement high speed calibration

 doc/device-tree-bindings/spi/spi-bus.txt     |   4 +
 doc/device-tree-bindings/spi/spi-cadence.txt |  11 +
 drivers/mtd/spi/Kconfig                      |  12 +
 drivers/mtd/spi/spi-nor-core.c               | 246 ++++++++
 drivers/mtd/spi/spi-nor-ids.c                |   6 +-
 drivers/spi/cadence_qspi.c                   | 444 ++++++++++----
 drivers/spi/cadence_qspi.h                   | 105 +++-
 drivers/spi/cadence_qspi_apb.c               | 572 +++++++++++++++----
 drivers/spi/spi-mem.c                        |  24 +
 include/linux/mtd/spi-nor.h                  |  13 +
 include/spi-mem.h                            |  19 +
 11 files changed, 1226 insertions(+), 230 deletions(-)

-- 
2.43.2

