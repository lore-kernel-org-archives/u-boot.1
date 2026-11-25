Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C182606A69D
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=du3WLMua;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTceDrGA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D072160750;
	Wed, 25 Nov 2026 20:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 38JAj13Jp1Ck; Wed, 25 Nov 2026 20:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB2A9606C2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795639855;
	b=ap4iaCZJ9o7HqhcxysXTIt4ZN4IqLylxCHRQoygTnFCQyuaOEGGQmxC/zw6vmGvJDWqb
	 zmuqZo2RM/YSDCDhQDV3iXtjmin9Qg17Penj9OmEnhPIqlPiHEhn60nuhx3JiZeXEaaJc
	 T0JiX05RNw9z+/qLmaNlzuluQJQSFet4hCjfd+HV5UjN1pQFV2eJLJmAcsJyP8fcm2AzZ
	 UeoiyXUym3JI8Y6phQ0jEmCQcGGHlCU2zod9EjG3QJO0H8fvKhkl+BelMFTHDwIhsOsMl
	 IK92b8hI7zJ6oINE2/Xk4+Wy+5+YZKYERWJkJH1tALU01ghmTYc2pnAbmzc0acHD8hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795639855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=thNo8o2a/1wEbtSCwVguUstAIdK2ZkPRmNaZb5OziWQ=;
	b=GqHWxA1bHk7vyUQP1SxAyALgTbVeZ4+f4ebVWFFQ40ejUKK2SEcTpRR17PLQG+qLkePC
	 B2+erBmcY1OwuXJfVIof1wSBZs8g4mvzqVktG51TGBRN9QqiuPlXlZUvXvrMJ/CR3KyPf
	 tae5ECZW+65TsZ+0ux48Gifb26o3xo7Tw6UXnDCFs49WY5OQBulUNSjrrGAfL90rBi94o
	 nD+PcCWhfF6/oAYvLzANrHOVamXCLwUoZEQkqoRSYlVJPJPqzCe7mTIXRfak0MnhqFV/m
	 cq4AwJfxRYj33FUgUCF40FxpLXAGd8oVxoAd7wyl+9zN22ro++g9FSzjsEwT4eazHkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795639855;
	bh=thNo8o2a/1wEbtSCwVguUstAIdK2ZkPRmNaZb5OziWQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=du3WLMuaeLlf9XhdfxJVIKXVZuaoeiui4N4KurUnPPpijaN8bF8utRD2Oi8k0T/rK
	 rm8cgWYH8y5ly242PHdMJ4UBZRC0AEZd2/HwIf0QtSOXozabAtgooXeVwBcYEmrYCb
	 /ElGUQTj4cOH0bq//5AHt5R4g//Eo62Po4UJ+b0Y9pW8xQMSdRIO+ETG18oeVIYFAR
	 z0WJwitacRZxjGZH4tLKyqqDz11Qa8PcMjBoSzuQRWhf/lQevxR9Jjc4g/e3oHDUeT
	 +BgWJARdTR+89eIgL6J9L5+D2RWWujttV7a+eCOVl/htrYCvHrPLj7N2/ISIfW6gmR
	 hvoMlh4tpx46A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB2A9606C2;
	Wed, 25 Nov 2026 20:50:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3890D26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 299B84056F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t40-lceqKxau for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 20:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA5EF40564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zTceDrGA
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA5EF40564
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:50:52 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5ee27c9eec0so2035196e0c.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795639851; x=1796244651;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=thNo8o2a/1wEbtSCwVguUstAIdK2ZkPRmNaZb5OziWQ=;
 b=zTceDrGApN1pr8dWupWaTvHh3bIZIeWEzNUuZ5EulWBLBmzntITNtTYZGzRa0iX4+W
 ESc1ojzPUEcMJizu1fZUPiHGFTmZNJZSTo6QWYyvvVpS+iqE5hG23JYrN5KVko7Kgz6H
 +DqUVhj+bKrLqnakOagVYdXgr4GyeBpX4GFPcjoGtq4iFKaZqV9ZOZ/JThiQn17586Sw
 5jcNu+smeMag8ugJ5GaIx5BQidCYvKuRxdtAjuNBfPHabrWzfSnITAVd2B2TiB42vPcw
 lE/u3gmF0VvFee9c4LrLQrRWwQXz4Y5cJJLKI00JFUgzN7+dzZnQudcMQIpIgFWi5OZG
 vSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795639851; x=1796244651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=thNo8o2a/1wEbtSCwVguUstAIdK2ZkPRmNaZb5OziWQ=;
 b=YG5RFZqvz9qhhiXVMmm20SYgzBDT+koan0JJdM2QYyF84qOjbhYONs5ZwfZ21rlkkL
 FzxRc+1j8KtTLJXbJ49Bb4WKPw2pFSvVjf8F69zXJKUJ2/p6DazLodBzufyvhYvwMAeW
 grlGVa/G5C/DmjYhEFaLWaeUqJlE8VXvwhZEHsA7XV4x8ektt362MkQ0X1Fzch3kGvq1
 jgr2mZT7lqLLeZ7zDGVH9NFdKtNIB05WuMjk0J7zJSD1tt2kUKz/iHk3OeG0kj4OgcjA
 LoBH6nULj0pkF/jrWIJejKiItNMPsXpfkuK7VnNKjelowIPwgpwPFEJNvMPfdoiCS7hQ
 Y3Dg==
X-Gm-Message-State: APuU4Z+o804dP5mhXxBHimbVp9W98gIbEY6CIuZ4Amw6l0v6PpQuvFMy
 NTunsfLTu8d+bBqPMaPoETL74hmBFfT3ie3CJfxNC//++YA34ctR5p1v
X-Gm-Gg: AZFdTZdkaq8E2u6YCbnub5jHiG09aXKk83hmxYRDQc4zgSqAOS/vA8LAkGIwH0DRVGN
 +nt7p7eW8QpkPF6WFVU5diI9Ui0vngqU4AXAGMP+eLZ2aG+fTmcfAeQl6wsT5bNnbPwEn6vHysI
 lLDn64LZvBxg1GOvoRgPJ7ZlXxZdbgUzeFKiz5ff2xOMHgZvAyPBRKq/Kz3fcWIXne7LD3Hztwl
 rvvyOd5TvjCZD66pjP2pmjflFOaQDK3a8IF3DNvlMqxCtVk84T2zp9dQ8HYMfLWEgzR2sNkkdRr
 U1Ult6hTLy5fMJsVv5Ka4A331UkV3kGSE3sf3mQ1VccQ+3c17tr4TTa2id7FyiJHkl+Ohl0R3+9
 X7qtFkNDydYVNY3OvlOoVZ/yyh2jOOzlhExg7GAJsQljNHKfVYrLMdFDxX/G+1NPGzEzFxtrjuw
 tgCWFtgkhRMszYAFpYVqzdDgBgcAQNTO2dQG3jUIKeaoMV/f3Wv1YWxO1qiCO9R5H8yUAkw2ZnQ
 R4uaVSVl9ojOOTEt99ZxJzUeqTioFVZzsKLOkFFBR+LBGs4wV5CqOO+X4a3+zZdX0D+NcYAkqRs
 J2dT99HIoVe//zPL31dt2o0cYMFIHPhuEfRVMFz/ehpILw8OJ4Tvc7ZzMPiIXyRo1uNpPXACIhr
 zAHmvrvKFoxrUdvEUGBt2xJI=
X-Received: by 2002:a05:6122:4d0e:b0:5c9:a60d:3279 with SMTP id
 71dfb90a1353d-5ee8aeefaf5mr10646329e0c.13.1795639851148; 
 Wed, 25 Nov 2026 12:50:51 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a803:a13e:cddd:7df2:4ffd:735c])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee8b5bb61asm18597601e0c.10.2026.11.25.12.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:50:49 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Sergio Prado <sergio.prado@e-labworks.com>,
 Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
 Thorsten Schmelzer <t.schmelzer@phytec.de>,
 Antoine Gouby <antoine.gouby@toradex.com>
Subject: [GIT PULL] Please pull u-boot-imx-next-20261125
Date: Wed, 25 Nov 2026 17:50:38 -0300
Message-ID: <20261125205038.36398-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit a1ce46a6689641dd83d725edbfc3f5719abf3a94:

  Merge tag 'net-next-20261123' of https://git.u-boot-project.org/u-boot/custodians/u-boot-net into next (2026-11-24 10:45:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20261125

for you to fetch changes up to aae8ef7b7027a0dbd240a659f2a7b0c5b4f58dbd:

  arm64: dts: imx: Enable CRC8 support Data Modul i.MX8M eDM SBC (2026-11-25 15:51:59 -0300)

u-boot-imx-next-20261125
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/2166

- Moved Colibri VF50/VF61 DDR initialization into the image DCD so the
  ROM can load U-Boot directly into DDR, removing the 480 KB on-chip RAM
  limit that blocked NAND boot-control and USB gadget commands.
- Added initial U-Boot support for the Toradex OSM iMX95 module on the
  OSM Development Board.
- Enabled NXP UUU USB boot and eMMC flashing on phyCORE-i.MX8MM, with
  automatic Fastboot startup after USB boot. Also enabled FIT device-tree
  overlays via `overlays.txt` on phyBOARD-Polis and phyGATE-Tauri-L.
- Fixed eMMC fast boot on Verdin iMX8M Mini and MX8Menlo by aligning the
  SPL load sector with the FIT location for both signed and unsigned
  images.
- Enabled the clock framework and migrated to upstream device trees on
  Colibri iMX6ULL. The related i.MX6UL/ULL Ethernet clock fixes complete
  the ENET clock tree, correct the clock gate, and wait for the ENET PLL
  to lock.
- Added support for an external RMII reference clock on i.MX93 EQOS
  Ethernet and fixed i.MX ROM API SPL loading to propagate container-
  load errors.
----------------------------------------------------------------
Antoine Gouby (1):
      board: toradex: add initial support for OSM iMX95

Francesco Dolcini (8):
      board: toradex: verdin-imx8mm: remove CFG_SYS_UBOOT_BASE
      board: toradex: verdin-imx8mp: remove CFG_SYS_UBOOT_BASE
      board: toradex: smarc-imx8mp: remove CFG_SYS_UBOOT_BASE
      arm: dts: imx95-{toradex-smarc, verdin}: remove lpuart1 clocks override
      clk: imx: imx6ul: fix the enet clock gate register
      board: toradex: colibri-imx6ull: drop the static serial device
      arm: dts: imx6ull-colibri: migrate to OF_UPSTREAM
      board: toradex: colibri-imx6ull: enable the clock framework

Marek Vasut (1):
      arm64: dts: imx: Enable CRC8 support Data Modul i.MX8M eDM SBC

Markus Niebel (3):
      include: spl.h: add return code documentation for spl_load_imx_container
      mach-imx: spl_imx_romapi: respect return code of spl_load_imx_container
      spl_imx_romapi: fix typo in output of spl_romapi_load_image_seekable

Martin Schmiedel (1):
      imx9: clock: support external RMII REF_CLK source for EQOS

Mehmet Fide (2):
      colibri_vf: configure the DDR controller from the DCD
      arm: dts: vf610-colibri: name both modules in the model

Primoz Fiser (3):
      configs: phycore-imx8mm, tauri-l: Enable overlay and overlays.txt support
      configs: phycore-imx8mm, tauri-l: Enable mmc reg command
      configs: phycore-imx8mm, tauri-l: Enable crc32 command

Sergio Prado (1):
      board: toradex: verdin-imx8mm: adjust U-Boot proper offset for eMMC fastboot

Stefan Eichenberger (3):
      clk: imx: pllv3: wait for the ENET PLL to lock
      clk: imx: pllv3: do not touch the ENET output gate
      clk: imx: imx6ul: add the enet clock tree

Thorsten Schmelzer (4):
      arm: dts: imx8mm-phyboard-polis-rdk-u-boot: Add usb entries for SPL
      configs: phycore-imx8mm: Add support for loading via UUU tool
      board: phycore-imx8mm: Start fastboot when booted through USB
      board: phycore_imx8mm: env: Add fastboot raw partitions for UUU

 arch/arm/dts/Makefile                              |    2 -
 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts      |   17 -
 arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi     |  187 ----
 arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |    6 +
 arch/arm/dts/imx6ull-colibri-eval-v3.dts           |   14 -
 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi          |  121 ---
 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi          |  161 ---
 arch/arm/dts/imx6ull-colibri.dtsi                  |  748 --------------
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |    8 +
 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |    4 -
 arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi     |   66 ++
 arch/arm/dts/imx95-toradex-osm-dev.dts             |  404 ++++++++
 arch/arm/dts/imx95-toradex-osm.dtsi                | 1032 ++++++++++++++++++++
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi   |    2 -
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi     |    2 -
 arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi     |    2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h          |    1 +
 arch/arm/mach-imx/imx9/Kconfig                     |    5 +
 arch/arm/mach-imx/imx9/clock.c                     |   12 +
 arch/arm/mach-imx/mx6/Kconfig                      |    1 +
 arch/arm/mach-imx/spl_imx_romapi.c                 |    4 +-
 board/phytec/phycore_imx8mm/phycore-imx8mm.c       |    5 +
 board/phytec/phycore_imx8mm/phycore_imx8mm.env     |    2 +
 board/toradex/colibri-imx6ull/MAINTAINERS          |    8 +-
 board/toradex/colibri-imx6ull/colibri-imx6ull.c    |   45 +-
 board/toradex/colibri_vf/colibri_vf.c              |  131 +--
 board/toradex/colibri_vf/imximage.cfg              |  158 +++
 board/toradex/common/tdx-common.c                  |    3 +-
 board/toradex/osm-imx95/Kconfig                    |   36 +
 board/toradex/osm-imx95/MAINTAINERS                |   11 +
 board/toradex/osm-imx95/Makefile                   |    8 +
 board/toradex/osm-imx95/osm-imx95.c                |   52 +
 board/toradex/osm-imx95/osm-imx95.env              |   20 +
 board/toradex/osm-imx95/spl.c                      |   76 ++
 configs/colibri-imx6ull-emmc_defconfig             |    4 +-
 configs/colibri-imx6ull_defconfig                  |    4 +-
 configs/colibri_vf_defconfig                       |    4 +-
 configs/imx8m_data_modul.config                    |    1 +
 configs/imx8mm-mx8menlo_defconfig                  |    2 +-
 configs/imx8mm-phygate-tauri-l_defconfig           |    5 +-
 configs/phycore-imx8mm_defconfig                   |   33 +-
 configs/toradex-osm-imx95_defconfig                |  184 ++++
 configs/verdin-imx8mm_defconfig                    |    2 +-
 doc/board/toradex/index.rst                        |    1 +
 doc/board/toradex/osm-imx95.rst                    |  176 ++++
 drivers/clk/imx/clk-imx6ul.c                       |   81 +-
 drivers/clk/imx/clk-pllv3.c                        |   21 +-
 include/configs/toradex-osm-imx95.h                |   28 +
 include/configs/toradex-smarc-imx8mp.h             |    3 -
 include/configs/verdin-imx8mm.h                    |    3 -
 include/configs/verdin-imx8mp.h                    |    3 -
 include/spl.h                                      |    1 +
 52 files changed, 2451 insertions(+), 1459 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri.dtsi
 create mode 100644 arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-toradex-osm-dev.dts
 create mode 100644 arch/arm/dts/imx95-toradex-osm.dtsi
 create mode 100644 board/toradex/osm-imx95/Kconfig
 create mode 100644 board/toradex/osm-imx95/MAINTAINERS
 create mode 100644 board/toradex/osm-imx95/Makefile
 create mode 100644 board/toradex/osm-imx95/osm-imx95.c
 create mode 100644 board/toradex/osm-imx95/osm-imx95.env
 create mode 100644 board/toradex/osm-imx95/spl.c
 create mode 100644 configs/toradex-osm-imx95_defconfig
 create mode 100644 doc/board/toradex/osm-imx95.rst
 create mode 100644 include/configs/toradex-osm-imx95.h
