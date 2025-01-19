Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56AC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 16:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4E4805CD;
	Sun, 19 Jan 2025 17:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92799805CD; Sun, 19 Jan 2025 17:43:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0E91C80085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 17:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFB32339;
 Sun, 19 Jan 2025 08:44:01 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790843F66E;
 Sun, 19 Jan 2025 08:43:32 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/3] sunxi: switch three SoC families to OF_UPSTREAM
Date: Sun, 19 Jan 2025 16:41:53 +0000
Message-ID: <20250119164157.23648-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
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

This series converts boards with the Allwinner F1C100s/F1C200s, A10, A10s
and A13s SoCs over to OF_UPSTREAM. The .dts and .dtsi files were
identical between the kernel and U-Boot repository, so this is a
no-brainer.
However there are four boards (tablets, I guess) that do not have a .dts
file in the kernel repository. For now I kept them using the "old
style", so they continue working. This requires to keep a copy of the
SoC .dtsi file, I would be grateful for any advice as how to handle this
situation best. Ideally we would submit the DTs to the kernel, but I
don't know how feasible this is, given their age, the missing device
availability and their basic DT nature.

I compiled all boards with and without this series applied: the
resulting u-boot.dtb files were always identical.

Please have a look!

Cheers,
Andre

Andre Przywara (3):
  suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
  sunxi: switch Allwinner A10 boards to OF_UPSTREAM
  sunxi: switch Allwinner A10s/A13 boards to OF_UPSTREAM

 arch/arm/dts/Makefile                         |  48 +--
 arch/arm/dts/sun4i-a10-a1000.dts              | 255 -------------
 arch/arm/dts/sun4i-a10-ba10-tvbox.dts         | 151 --------
 arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts    | 159 --------
 arch/arm/dts/sun4i-a10-cubieboard.dts         | 255 -------------
 arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts   | 218 -----------
 arch/arm/dts/sun4i-a10-gemei-g9.dts           | 192 ----------
 arch/arm/dts/sun4i-a10-hackberry.dts          | 140 -------
 arch/arm/dts/sun4i-a10-hyundai-a7hd.dts       | 115 ------
 arch/arm/dts/sun4i-a10-inet1.dts              | 229 -----------
 arch/arm/dts/sun4i-a10-inet97fv2.dts          | 203 ----------
 arch/arm/dts/sun4i-a10-inet9f-rev03.dts       | 357 ------------------
 .../dts/sun4i-a10-itead-iteaduino-plus.dts    | 126 -------
 arch/arm/dts/sun4i-a10-jesurun-q5.dts         | 181 ---------
 arch/arm/dts/sun4i-a10-marsboard.dts          | 182 ---------
 arch/arm/dts/sun4i-a10-mini-xplus.dts         | 144 -------
 arch/arm/dts/sun4i-a10-mk802.dts              | 144 -------
 arch/arm/dts/sun4i-a10-mk802ii.dts            | 111 ------
 arch/arm/dts/sun4i-a10-olinuxino-lime.dts     | 225 -----------
 arch/arm/dts/sun4i-a10-pcduino.dts            | 200 ----------
 arch/arm/dts/sun4i-a10-pcduino2.dts           |  67 ----
 arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts   | 206 ----------
 arch/arm/dts/sun4i-a10-topwise-a721.dts       | 242 ------------
 arch/arm/dts/sun5i-a10s-auxtek-t003.dts       | 137 -------
 arch/arm/dts/sun5i-a10s-auxtek-t004.dts       | 149 --------
 arch/arm/dts/sun5i-a10s-mk802.dts             | 127 -------
 arch/arm/dts/sun5i-a10s-olinuxino-micro.dts   | 272 -------------
 arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts      | 118 ------
 arch/arm/dts/sun5i-a10s-wobo-i5.dts           | 195 ----------
 arch/arm/dts/sun5i-a10s.dtsi                  | 173 ---------
 arch/arm/dts/sun5i-a13-difrnce-dit4350.dts    |  50 ---
 .../dts/sun5i-a13-empire-electronix-d709.dts  | 190 ----------
 .../dts/sun5i-a13-empire-electronix-m712.dts  |  51 ---
 arch/arm/dts/sun5i-a13-hsg-h702.dts           | 182 ---------
 arch/arm/dts/sun5i-a13-inet-98v-rev2.dts      |  50 ---
 arch/arm/dts/sun5i-a13-licheepi-one.dts       | 214 -----------
 arch/arm/dts/sun5i-a13-olinuxino-micro.dts    | 141 -------
 arch/arm/dts/sun5i-a13-olinuxino.dts          | 247 ------------
 .../dts/sun5i-a13-pocketbook-touch-lux-3.dts  | 258 -------------
 arch/arm/dts/sun5i-a13-q8-tablet.dts          |  80 ----
 arch/arm/dts/sun5i-a13-utoo-p66.dts           | 116 ------
 arch/arm/dts/sun5i-a13.dtsi                   | 118 ------
 arch/arm/dts/sun5i-gr8-chip-pro.dts           | 238 ------------
 arch/arm/dts/sun5i-gr8-evb.dts                | 333 ----------------
 arch/arm/dts/sun5i-gr8.dtsi                   | 126 -------
 arch/arm/dts/sun5i-r8-chip.dts                | 282 --------------
 arch/arm/dts/sun5i-r8.dtsi                    |  47 ---
 .../dts/sun5i-reference-design-tablet.dtsi    | 194 ----------
 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts  |  73 ----
 arch/arm/dts/suniv-f1c100s.dtsi               | 330 ----------------
 arch/arm/dts/suniv-f1c200s-lctech-pi.dts      |  76 ----
 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts  |  81 ----
 arch/arm/mach-sunxi/Kconfig                   |   3 +
 configs/A10-OLinuXino-Lime_defconfig          |   2 +-
 configs/A10s-OLinuXino-M_defconfig            |   2 +-
 configs/A13-OLinuXinoM_defconfig              |   2 +-
 configs/A13-OLinuXino_defconfig               |   2 +-
 configs/Ampe_A76_defconfig                    |   1 +
 configs/Auxtek-T003_defconfig                 |   2 +-
 configs/Auxtek-T004_defconfig                 |   2 +-
 configs/CHIP_defconfig                        |   2 +-
 configs/CHIP_pro_defconfig                    |   2 +-
 configs/Chuwi_V7_CW0825_defconfig             |   2 +-
 configs/Cubieboard_defconfig                  |   2 +-
 configs/Empire_electronix_d709_defconfig      |   2 +-
 configs/Empire_electronix_m712_defconfig      |   2 +-
 configs/Hyundai_A7HD_defconfig                |   2 +-
 configs/Linksprite_pcDuino_defconfig          |   2 +-
 configs/Marsboard_A10_defconfig               |   2 +-
 configs/Mele_A1000_defconfig                  |   2 +-
 configs/Mini-X_defconfig                      |   2 +-
 configs/UTOO_P66_defconfig                    |   2 +-
 configs/Wobo_i5_defconfig                     |   2 +-
 configs/ba10_tv_box_defconfig                 |   2 +-
 configs/difrnce_dit4350_defconfig             |   2 +-
 configs/dserve_dsrv9703c_defconfig            |   2 +-
 configs/iNet_3F_defconfig                     |   1 +
 configs/iNet_3W_defconfig                     |   1 +
 configs/iNet_86VS_defconfig                   |   1 +
 configs/inet1_defconfig                       |   2 +-
 configs/inet97fv2_defconfig                   |   2 +-
 configs/inet98v_rev2_defconfig                |   2 +-
 configs/inet9f_rev03_defconfig                |   2 +-
 configs/jesurun_q5_defconfig                  |   2 +-
 configs/lctech_pi_f1c200s_defconfig           |   2 +-
 configs/licheepi_nano_defconfig               |   2 +-
 configs/mk802_a10s_defconfig                  |   2 +-
 configs/mk802_defconfig                       |   2 +-
 configs/mk802ii_defconfig                     |   2 +-
 configs/pov_protab2_ips9_defconfig            |   2 +-
 configs/q8_a13_tablet_defconfig               |   2 +-
 configs/r7-tv-dongle_defconfig                |   2 +-
 configs/sunxi_Gemei_G9_defconfig              |   2 +-
 93 files changed, 45 insertions(+), 8832 deletions(-)
 delete mode 100644 arch/arm/dts/sun4i-a10-a1000.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-ba10-tvbox.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-cubieboard.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-gemei-g9.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-hackberry.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-hyundai-a7hd.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet1.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet97fv2.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet9f-rev03.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-jesurun-q5.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-marsboard.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mini-xplus.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mk802.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mk802ii.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-olinuxino-lime.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pcduino.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pcduino2.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-topwise-a721.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t003.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t004.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-mk802.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-olinuxino-micro.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-wobo-i5.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s.dtsi
 delete mode 100644 arch/arm/dts/sun5i-a13-difrnce-dit4350.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-d709.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-m712.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-hsg-h702.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-inet-98v-rev2.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-licheepi-one.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino-micro.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-q8-tablet.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-utoo-p66.dts
 delete mode 100644 arch/arm/dts/sun5i-a13.dtsi
 delete mode 100644 arch/arm/dts/sun5i-gr8-chip-pro.dts
 delete mode 100644 arch/arm/dts/sun5i-gr8-evb.dts
 delete mode 100644 arch/arm/dts/sun5i-gr8.dtsi
 delete mode 100644 arch/arm/dts/sun5i-r8-chip.dts
 delete mode 100644 arch/arm/dts/sun5i-r8.dtsi
 delete mode 100644 arch/arm/dts/sun5i-reference-design-tablet.dtsi
 delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
 delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
 delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
 delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts

-- 
2.46.2

