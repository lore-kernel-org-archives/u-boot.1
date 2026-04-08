Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88235EA3C5D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AD584214;
	Thu,  9 Apr 2026 15:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="JQJ1C8u8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF0483936; Wed,  8 Apr 2026 21:25:10 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71C884144
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638F9uju1197824; Wed, 8 Apr 2026 19:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps0720; bh=GQ1ofmltcoc4j4oWA4vuHhLJ
 ACJXedQJVBFAf6nTlpA=; b=JQJ1C8u8blBBvAn+6AEki4K11ng4GMBWwt1w9/o4
 63LaaEj6yrVb5LIsGUgpXtv9asx/wzG4o3XDRWrf3HKVJIoTIMguXsNj6/j3ryHd
 TVXFJf8/LZVoTpl/3vwWuogjNnRgR6f7lHx3kTKswDSoCghmwDJxGPxIWkmlAe2Y
 PDl/LR7dU/Cy6BB8Rxv3zRz0YNpNvSDGuQ1CC2mHzkvRT9CbBr9XCTbtJiBy+WPV
 0WIJoSkh31ax8+n5rZs5hqSf+FczlB0UCbDrEtTmQR4Q4KoWABMZ461A88ZiRtRd
 LXPcTII53hI+DFJWCP3hstFXyUiNQH4uinKzraUmhfO7mQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddm58qbb2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:20 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C100B2BADC;
 Wed,  8 Apr 2026 19:24:17 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 525C980FDCD;
 Wed,  8 Apr 2026 19:24:15 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Subject: [PATCH 0/9] arm: hpe: Add HPE GSC (Gen12) BMC SoC support
Date: Wed, 08 Apr 2026 19:24:12 +0000
Message-Id: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyr1mkC/yXMSwqDQBBF0a1IjVPQ8YdmKyGDTvnUCsQ0XRoEc
 e/p6PAM7t3IEBVGt2yjiK+afqaE6yUjGf00gLVLptzltStdw2MADya8BJsj/JuLupUKqFpxnlI
 WInpdj+X9cdqW5wsy/z+07z/qgTmndAAAAA==
X-Change-ID: 20260408-hpe-gsc-upstream-369c5ee59c0a
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jorge Cisneros <jorge.cisneros@hpe.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=ZoDd7d7G c=1 sm=1 tr=0 ts=69d6ab64 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22 a=MvuuwTCpAAAA:8
 a=asIk_nFs52Bc3F4i2EUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: n6Zx8WWUb0jAmHesO-TKcBS3TZHQG4Vn
X-Proofpoint-ORIG-GUID: n6Zx8WWUb0jAmHesO-TKcBS3TZHQG4Vn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX8SIjNrJExOjV
 9lAnyCCiekXGnWuvN9SWIAZ6EOgja3vygt6CBlIEAcwv/Bjr6eHPdB9YPgTZBTpnFMay6prgxTF
 hRC5Lds0ArZRxQOCCdqCgy5mALuAUDY+RI+he+kikfAn+zIGItIgkTanafdjTHj8Lm5geCsneg7
 7weBcvqMssevrtQTdJzGojmPKxvO7BLiCdLVSv6LKg8D7ywQDNSpBhQ0vBRxelbSbL9yJ7mXKqx
 HLSeo8luKs4dsq3hx9Ju6WTu17d+/p9K2ajeuw5XdhK5r+PvZnpLKMeriDe/TQo6n7gFqZlsYuk
 cFG5Xw7qC7gtrLn0Q9mxpYKG873PZrVUQm5w7icyvd3PD0wypZJ9OCuSnyNIFU1MuI2bO1yPxze
 gN8MV5nW8QCh+C3g4VpW4KvUwGBtNSv9zQ4Uf24BT2aM12ckmanZrtajot5N6pmZgOtGps0ABeW
 wZRRwlA04r/pYPWBb4g==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080181
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

This series adds support for the HPE GSC (Gen Server Controller), an
ARM64-based BMC SoC used in HPE ProLiant and Synergy Gen12 servers.

The GSC is the successor to the GXP SoC (already upstream) used in
Gen11 servers. It features dual Cortex-A35 cores with GICv3, a Denali
DDR memory controller, Cadence GEM Ethernet (SGMII), and reuses several
GXP IP blocks (timer, SPI, I2C).

The existing ARCH_GXP Kconfig symbol is renamed to ARCH_HPE to serve as
an umbrella for both the GXP (ARMv7) and GSC (ARMv8) SoC variants,
selected via a choice menu under mach-hpe.

New drivers:
- Watchdog (drivers/watchdog/gsc_wdt.c)
- Memory-mapped virtual EEPROM for VPD (drivers/misc/gsc_mem_eeprom.c)
- Cadence GEM support added to the existing MACB driver

Board support includes DRAM sizing from the Denali memory controller,
MAC address provisioning from VPD EEPROM, FDT fixups for network
configuration, shared Ethernet/DisplayPort PHY initialization, and a
server_id command for reading server identification from the CPLD.

Notes:
- The server_id command (patch 7) is hardware-specific and reads from
  GSC CPLD registers, so no sandbox test is included.
- MAINTAINERS warnings in patches 1-8 are resolved by patch 9.

Based on v2026.04-rc4 (ba7bf918dafcd093ad733b07ba490baeb20cf5da).
Tested: both gxp_defconfig and gsc_defconfig build cleanly.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
Jorge Cisneros (9):
      arm: hpe: Rename ARCH_GXP to ARCH_HPE and add GSC SoC choice
      arm: hpe: Add GSC SoC support
      arm: dts: Add HPE GSC device tree
      watchdog: Add HPE GSC watchdog driver
      misc: Add HPE GSC memory-mapped EEPROM driver
      net: macb: Add HPE GSC GEM Ethernet support
      board: hpe: Add GSC board support
      configs: Add gsc_defconfig for HPE GSC SoC
      MAINTAINERS: Add HPE GSC files and maintainer

 MAINTAINERS                                  |   8 +-
 arch/arm/Kconfig                             |   9 +-
 arch/arm/Makefile                            |   2 +-
 arch/arm/dts/hpe-gsc.dts                     | 146 ++++++++
 arch/arm/include/asm/arch-gsc/clk.h          |  14 +
 arch/arm/mach-hpe/Kconfig                    |  33 ++
 arch/arm/mach-hpe/Makefile                   |   1 +
 arch/arm/mach-hpe/gsc/Kconfig                |  27 ++
 arch/arm/mach-hpe/gsc/Makefile               |   1 +
 arch/arm/mach-hpe/gsc/reset.c                |  19 +
 arch/arm/mach-hpe/gxp/Kconfig                |   2 +-
 board/hpe/gsc/Kconfig                        |  18 +
 board/hpe/gsc/Makefile                       |   3 +
 board/hpe/gsc/common-phy-wrapper-addresses.h |  86 +++++
 board/hpe/gsc/common-phy.c                   | 296 +++++++++++++++
 board/hpe/gsc/common-phy.h                   |   8 +
 board/hpe/gsc/gsc.env                        |   9 +
 board/hpe/gsc/gsc_board.c                    | 538 +++++++++++++++++++++++++++
 board/hpe/gsc/server_id.c                    |  51 +++
 configs/gsc_defconfig                        |  88 +++++
 configs/gxp_defconfig                        |   2 +-
 drivers/misc/Kconfig                         |   7 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/gsc_mem_eeprom.c                | 118 ++++++
 drivers/net/macb.c                           |  17 +
 drivers/watchdog/Kconfig                     |   7 +
 drivers/watchdog/Makefile                    |   1 +
 drivers/watchdog/gsc_wdt.c                   | 110 ++++++
 include/configs/gsc.h                        |  25 ++
 29 files changed, 1640 insertions(+), 7 deletions(-)
---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260408-hpe-gsc-upstream-369c5ee59c0a

Best regards,
--  
Jorge Cisneros <jorge.cisneros@hpe.com>

