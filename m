Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A868CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704DA83C94;
	Thu,  9 Oct 2025 21:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i5t0/BaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8962E83CEE; Thu,  9 Oct 2025 21:35:00 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EA583C62
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so1199155b3a.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038496; x=1760643296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+g2Giuh+7uWuhWkdqpdQ1y4FRGRBTgf/tsgeEgmdBQI=;
 b=i5t0/BaSUm4DCryhs68Axtd2EcgKiF1pkGGz7C8IuIo9uzAkowMxt2MItpic5AgZuQ
 XqrRkwkFh2N7ln9wjKh4I3Z9Yg+60NOpFC6UBRuZbK3kcNsJTowV2OLh7uE2CmH6loK5
 m1wxIIX8cy4HrZUv3QRRXJqLeHvWowBtSyouXkTwn9nyF/fO2TQqfs8w9DEsy77HcFAe
 Y123DAZhe25HKtFEndJ2mV2CUDDTKmTiSvDsfH0eg5wXZ7fv8EFK6XhkqYKKw3Ps7tGL
 An1657/eeltjxc8bFjYJDdRlpqqxgcBpkfUyZGhcnnxS/tblZOcQXmZvFmp0Htj8P3Vr
 ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038496; x=1760643296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+g2Giuh+7uWuhWkdqpdQ1y4FRGRBTgf/tsgeEgmdBQI=;
 b=Hf9kzhyTGH6rr6nNZLBbuiDbIpItY5Mb+Y7f5tW9DrjXwDV6QWKv9DhvLEs3WeE8tC
 yg3lq4j0YSDLDm/BjHKlNIqm4JKtpJCm3twvNtEeASobd8lRKpoXUUyaPNMD/7S7ozpp
 lBvyVBSvcLTUyRrx8dho0f3eAcBcGz8HNvH0b3/uoSNjr9h0B6CqEMtT1fiPFY+HCnAb
 OKAxgIy4wh0gqWgsKWwiJYTUOrlgPpgaCwZEjborOUTf3TujLG5XdKZgkE4F/NGMeqIe
 cPzVIGEVuv0XbeeRHWRm0eROzci8EU3PbmwO19BovCoWLnC5WXXxVVqHng9l3NbadHbJ
 m9Iw==
X-Gm-Message-State: AOJu0YyGyQDhulUwGlBVvSbICG4GNgXV908EGOdkgqIr7Eu3c0RZ9dlJ
 JLYqSCeGidibPi+A7a+x7BITOj1pJ9HdbaucoEvpDS0W3RM5iK1bA7/V7tW81A==
X-Gm-Gg: ASbGncs09JfHsTcYxm0msttmEKPEjS0jtRNL/gx+orLYsyu17b+Xe+D5StDO2AkWX5Z
 kagUPsnSTTeGBgPfAOOanHGf5lKLoTkHrpWRTyfG9uQ+UYU9a4DD8lZTlNpaRJUDfnrkQvh1Hmr
 L/Ult2oO4iUsWmZW/DAr2MIUOzZyDTjd9a1jgAHiH5lv9+6ntW2UkGHtT2t3tQqM7TqmGy7z0wd
 o5s4iHk1kgTByN5UaZ90kTkik7E0hYfVmPkzv4uvy0ZTyqcjisVl69cOpKL0l42THaL9JIIX8iy
 usaPlBjkt3Mzm13KjURdvvrFPOPS+rcAnfY2MYcKt447ttBFIgaVOM95w/VtmEa4EFDSCLiZcbh
 DZUixkw91YaCR2A76RAVJK2+R2cOA3KR37N8Pw/SBK/ZOtBy+j4VZdRf2UMboeyfbf/qysd8=
X-Google-Smtp-Source: AGHT+IGq/wKQmJuAI22HVDAmdzXamLmAgEBpdE1jUGIqanqBjL0s8e15H8fOgVVNhUWMUChRm3HHhw==
X-Received: by 2002:a05:6a20:938c:b0:2e9:e7a0:ecfa with SMTP id
 adf61e73a8af0-32da83e6b57mr10837056637.49.1760038496434; 
 Thu, 09 Oct 2025 12:34:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2b8f:a7eb:6996:aa6d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df952b9sm394279a12.46.2025.10.09.12.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:34:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20251009
Date: Thu,  9 Oct 2025 16:34:52 -0300
Message-Id: <20251009193452.285267-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 0eaa4b337336dbbe93395d1f2ccc18937eaafea2:

  Merge branch 'next' (2025-10-06 13:20:24 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20251009

for you to fetch changes up to 15bed125d769e16c688907b504c6d9b60c20b089:

  arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM (2025-10-09 14:57:09 -0300)

u-boot-imx-master-20251009
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27872

- Several improvements for kontron-sl-mx8mm.
- Add rauc to bootmeths to phycore_imx8mp.
- Fix imx93_frdm USB vendor ID.
----------------------------------------------------------------
Eberhard Stoll (1):
      imx: kontron-sl-mx8mm: Force default environment for serial loader boot

Ernest Van Hoecke (1):
      arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM

Frieder Schrempf (12):
      imx: kontron-sl-mx8mm: Increase CONFIG_SPL_MAX_SIZE
      imx: kontron-sl-mx8mm: Enable SDP support for loading via USB
      imx: kontron-sl-mx8mm: Remove deprecation warning for old modules
      imx: kontron-sl-mx8mm: Enable fixed regulators
      imx: kontron-sl-mx8mm: Add support for EEPROM on OSM-S module
      imx: kontron-sl-mx8mm: Use eMMC boot part for environment if booting from eMMC
      imx: kontron-sl-mx8mm: Export current env config to devicetree
      imx: kontron-sl-mx8mm: Enable multiple useful commands, drivers and features
      imx: kontron-sl-mx8mm: Enable standard boot and disable legacy distro boot
      imx: kontron-sl-mx8mm: Enable USB hub on BL i.MX8MM OSM-S board
      imx: kontron-sl-mx8mm: Autostart fastboot if booted from USB
      imx: kontron-sl-mx8mm: Convert to OF_UPSTREAM

Martin Schwan (1):
      board: phytec: phycore_imx8mp: Add rauc to bootmeths

Mathieu Dubois-Briand (1):
      imx93_frdm: Fix USB vendor ID

 arch/arm/dts/Makefile                             |    2 -
 arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi |   16 +
 arch/arm/dts/imx8mm-kontron-bl-osm-s.dts          |  376 ------
 arch/arm/dts/imx8mm-kontron-bl.dts                |  355 ------
 arch/arm/dts/imx8mm-kontron-osm-s.dtsi            |  335 ------
 arch/arm/dts/imx8mm-kontron-sl.dtsi               |  314 -----
 arch/arm/dts/imx8mp-toradex-smarc-dev.dts         |  297 -----
 arch/arm/dts/imx8mp-toradex-smarc.dtsi            | 1284 ---------------------
 arch/arm/mach-imx/imx8m/Kconfig                   |    1 +
 board/kontron/sl-mx8mm/sl-mx8mm.c                 |  102 +-
 board/kontron/sl-mx8mm/spl.c                      |   11 -
 board/phytec/phycore_imx8mp/phycore_imx8mp.env    |    4 +
 configs/imx93_frdm_defconfig                      |    2 +-
 configs/kontron-sl-mx8mm_defconfig                |   75 +-
 configs/toradex-smarc-imx8mp_defconfig            |    2 +-
 include/configs/kontron-sl-mx8mm.h                |   12 -
 16 files changed, 190 insertions(+), 2998 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-kontron-bl-osm-s.dts
 delete mode 100644 arch/arm/dts/imx8mm-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx8mm-kontron-osm-s.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-kontron-sl.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-toradex-smarc-dev.dts
 delete mode 100644 arch/arm/dts/imx8mp-toradex-smarc.dtsi
