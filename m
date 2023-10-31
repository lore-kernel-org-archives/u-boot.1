Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B28C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EA087AFE;
	Tue, 31 Oct 2023 07:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="ar+KorLW";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hp68kmW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CBF87527; Tue, 31 Oct 2023 07:40:48 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F97587510
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id C5DCD3200A4E;
 Tue, 31 Oct 2023 02:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 31 Oct 2023 02:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698734441; x=1698820841; bh=7oCFSzoNTL
 1vSMGPPqrmLXhb2i7Yp9vKSXzL0Bc4mGM=; b=ar+KorLWJskhiUDUWGCDP5MLlV
 3OEf4vOHbGvrOVa416izFxKPl2YB9JkHOoJLaefrMPMlo4jXrQehhqCGAmtymsTA
 eVFTM/GTyjaj4qp3LaySLAK6V3KF1KrhiToZ1futM81TuuE2SXYuOEO6H1tAQHq6
 mwJ3FbQzpyxJ1H0RZnYA4hVY25Y0mvagJL2NUrPoiUq5XVj01FDiX1CU7M7bo7L8
 itWw875E+dMNg7GOKEGwLokuQM5TGiLCyKGkAMV6n3OPw1Vb8txmS364Ry/QSYW8
 vOJ7PGygXOnIpuNahvDTWrXhSUtGoWIoay3OqE0M2+3A1HHZLn07kMc8HskA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698734441; x=1698820841; bh=7oCFSzoNTL1vS
 MGPPqrmLXhb2i7Yp9vKSXzL0Bc4mGM=; b=Hp68kmW4hrF+yZNJYYtBBpXWj1SW1
 Ps2twMp+C2TMld6fEBXfeGsV7iC8grDRPTAp02JBrCz6mdtF4swzuhAoJ6Ri1V4x
 2Q0EwQmaq47S+fvgz2GHevTEWGOiKZxNhUGYmmo4FDzth+PoZxaNCkbvFR5qTV7K
 VoXlRDXVLjYw3/qP7j3o8e2jQ+CC1UlKdTANxUUhE4cSrji2GMGGqFbVj9N58o8d
 0ZXVaPnDScGIgRa+4RsHe6EcapwEjqC0cS4tcP/tA12qewfVCDgrSfJToHSwCLtn
 gfg1yrPfsGoF4L3fAMgDHpyY6Q95YQ2rkjaHZX3VsG50AdvchCAgIBduw==
X-ME-Sender: <xms:aKFAZdb5xiy4LpbEhi9oLn0VWbpM5NRBSvkzj7N4P3cTuKKANpTOgA>
 <xme:aKFAZUbAbAJI61pcKBPMpLOndscolzjzmRUJQUtEGZYf2HXD9mqZt6D7OHE9HIIoD
 CaTcMFjG50ktgk0rw>
X-ME-Received: <xmr:aKFAZf8Z9agOzaGjj75sLB6YDevMQqlKE0B92lJ-_yNJEYI1XdR1pdD-d-7HBidq2I--6WkkP1wF29B0CP9bxJiH5uq-aVrAYoXGwy9PA6ulpgxcJ331sKtLJ6aJSCnyr4MQ8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
 vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:aKFAZbqXroMH4drTzLiaIR2eqFwjrsqZHSGra7dblsDB_5k8TfYn5Q>
 <xmx:aKFAZYp6Y1Wj9HTD0LGju7FORN2UXi5r6BefeHaBtiZeEatZThqrrQ>
 <xmx:aKFAZRTFkd_K_BPJYmvlTp5lHufyah-VrA5ibw9Y4xbWNW4WLtJTcA>
 <xmx:aaFAZf0a4Wl_MZx4YnpUqIsCg3S9fn-kZZNc_yhdEqXlHaZw2sRMLw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:39 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 0/5] sunxi: Control USB VBUS supplies via DT regulators
Date: Tue, 31 Oct 2023 01:39:50 -0500
Message-ID: <20231031064039.50942-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
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

This series converts sunxi boards from controlling VBUS suppllies using
GPIO name strings in Kconfig to using regulator devices probed via the
devicetree. ARCH_SUNXI already implies DM_REGULATOR_FIXED, so the only
new driver needed is for the AXP PMIC drivevbus regulator. This is part
2 of 3 for removing the PHY driver's GPIO Kconfig options. Part 1 was
here[1]. Part 3 will finish converting the VBUS/ID detection GPIOs; it
requires adding some missing DT properties to a couple of boards, so it
will have to wait for at least the next DT sync from Linux.

I tried to verify (by inspection) every board affected by this change,
but there is some possibility that this could break some boards. See the
commit message for patch 3. I have CCed some relevant board maintaners;
please test this patch series if you have the opportunity.

[1]: https://lore.kernel.org/u-boot/20230122234623.1636-1-samuel@sholland.org/


Samuel Holland (5):
  power: regulator: Add a driver for the AXP PMIC drivevbus
  sunxi: Enable PMIC drivevbus regulator support for USB supplies
  phy: sun4i-usb: Control supplies via the regulator uclass
  sunxi: Remove obsolete USBx_VBUS_PIN Kconfig symbols
  gpio: axp: Remove virtual VBUS enable GPIO

 arch/arm/mach-sunxi/Kconfig                  | 29 --------
 configs/A10s-OLinuXino-M_defconfig           |  1 -
 configs/A13-OLinuXinoM_defconfig             |  1 -
 configs/A13-OLinuXino_defconfig              |  1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
 configs/A20-OLinuXino-Lime2_defconfig        |  1 -
 configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
 configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
 configs/A33-OLinuXino_defconfig              |  2 +-
 configs/Ainol_AW1_defconfig                  |  1 -
 configs/Ampe_A76_defconfig                   |  1 -
 configs/Auxtek-T003_defconfig                |  1 -
 configs/Auxtek-T004_defconfig                |  1 -
 configs/Bananapi_M2_Ultra_defconfig          |  2 -
 configs/Bananapro_defconfig                  |  2 -
 configs/CHIP_defconfig                       |  1 -
 configs/CHIP_pro_defconfig                   |  1 -
 configs/CSQ_CS908_defconfig                  |  2 -
 configs/Chuwi_V7_CW0825_defconfig            |  1 -
 configs/Colombus_defconfig                   |  1 -
 configs/Cubieboard4_defconfig                |  4 +-
 configs/Cubietruck_defconfig                 |  1 -
 configs/Cubietruck_plus_defconfig            |  4 +-
 configs/Empire_electronix_d709_defconfig     |  1 -
 configs/Empire_electronix_m712_defconfig     |  1 -
 configs/Hummingbird_A31_defconfig            |  2 -
 configs/Hyundai_A7HD_defconfig               |  3 -
 configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
 configs/Linksprite_pcDuino_defconfig         |  2 -
 configs/MSI_Primo81_defconfig                |  2 +-
 configs/Mele_A1000G_quad_defconfig           |  2 -
 configs/Mele_I7_defconfig                    |  2 -
 configs/Mele_M9_defconfig                    |  2 -
 configs/Merrii_A80_Optimus_defconfig         |  4 +-
 configs/Mini-X_defconfig                     |  1 -
 configs/Orangepi_defconfig                   |  2 -
 configs/Orangepi_mini_defconfig              |  2 -
 configs/Sinlinx_SinA31s_defconfig            |  2 -
 configs/Sinovoip_BPI_M2_defconfig            |  2 -
 configs/Sinovoip_BPI_M3_defconfig            |  3 +-
 configs/Sunchip_CX-A99_defconfig             |  3 -
 configs/UTOO_P66_defconfig                   |  1 -
 configs/Wexler_TAB7200_defconfig             |  1 -
 configs/Wobo_i5_defconfig                    |  1 -
 configs/Yones_Toptech_BD1078_defconfig       |  1 -
 configs/Yones_Toptech_BS1078_V2_defconfig    |  2 +-
 configs/ba10_tv_box_defconfig                |  2 -
 configs/bananapi_m2_berry_defconfig          |  1 -
 configs/colorfly_e708_q1_defconfig           |  2 +-
 configs/difrnce_dit4350_defconfig            |  1 -
 configs/dserve_dsrv9703c_defconfig           |  1 -
 configs/ga10h_v1_1_defconfig                 |  2 +-
 configs/gt90h_v4_defconfig                   |  2 +-
 configs/h8_homlet_v2_defconfig               |  2 -
 configs/iNet_3F_defconfig                    |  1 -
 configs/iNet_3W_defconfig                    |  1 -
 configs/iNet_86VS_defconfig                  |  1 -
 configs/iNet_D978_rev2_defconfig             |  2 +-
 configs/icnova-a20-swac_defconfig            |  2 -
 configs/inet1_defconfig                      |  1 -
 configs/inet86dz_defconfig                   |  2 +-
 configs/inet97fv2_defconfig                  |  1 -
 configs/inet98v_rev2_defconfig               |  1 -
 configs/inet9f_rev03_defconfig               |  1 -
 configs/inet_q972_defconfig                  |  2 +-
 configs/jesurun_q5_defconfig                 |  1 -
 configs/mixtile_loftq_defconfig              |  2 -
 configs/mk802_a10s_defconfig                 |  1 -
 configs/mk802_defconfig                      |  1 -
 configs/orangepi_2_defconfig                 |  1 -
 configs/orangepi_plus_defconfig              |  2 -
 configs/parrot_r16_defconfig                 |  1 -
 configs/pine_h64_defconfig                   |  1 -
 configs/polaroid_mid2407pxe03_defconfig      |  2 +-
 configs/polaroid_mid2809pxe04_defconfig      |  2 +-
 configs/pov_protab2_ips9_defconfig           |  1 -
 configs/q8_a13_tablet_defconfig              |  1 -
 configs/q8_a23_tablet_800x480_defconfig      |  2 +-
 configs/q8_a33_tablet_1024x600_defconfig     |  2 +-
 configs/q8_a33_tablet_800x480_defconfig      |  2 +-
 configs/r7-tv-dongle_defconfig               |  1 -
 configs/sun8i_a23_evb_defconfig              |  2 -
 configs/tbs_a711_defconfig                   |  2 +-
 configs/teres_i_defconfig                    |  1 -
 drivers/gpio/axp_gpio.c                      | 75 ++++++--------------
 drivers/gpio/sunxi_gpio.c                    |  8 ---
 drivers/phy/allwinner/phy-sun4i-usb.c        | 41 +++++------
 drivers/power/pmic/axp.c                     |  1 +
 drivers/power/regulator/Kconfig              |  7 ++
 drivers/power/regulator/Makefile             |  1 +
 drivers/power/regulator/axp_drivevbus.c      | 57 +++++++++++++++
 include/axp221.h                             |  4 --
 include/axp809.h                             |  4 --
 include/axp818.h                             |  4 --
 include/sunxi_gpio.h                         |  8 ---
 96 files changed, 125 insertions(+), 246 deletions(-)
 create mode 100644 drivers/power/regulator/axp_drivevbus.c

-- 
2.41.0

