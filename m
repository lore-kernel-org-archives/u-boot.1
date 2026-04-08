Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA4EEA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5446184201;
	Thu,  9 Apr 2026 15:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="PheVUNqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B4284118; Wed,  8 Apr 2026 21:25:09 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A3F8413A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638F2fAB2298412; Wed, 8 Apr 2026 19:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=uQ
 VWnOrVLfpJK2JTPmqXs8tr3K+AJUL+kOrhzrSexTg=; b=PheVUNqmIJDLFMernV
 spwqYQYKAb1MGN0evxLIuSfx/JLtJsHEbB8QULeAyJFZ0NvRoKG5ipwJRauJIfSc
 k3D+z7A3uMfEjo5R/zj4UgZEgHFgdXbJnkKYzQhIzwAAVojw8k9HGKLtQjip6En/
 PmuQ6ZoBqd5sNhtowssvcBW7D1Ka3fKkaqNs6fH59guIqMw3peNrl5K3lolwGcqb
 XMjCj7/gEBmUmjSM4x7xllBToKM1akR8yktZ0a77OqTOJO83t1fA4WWUgl3Fya9g
 UTSVPMK5rCniiZNjBPEuQKpcYqxcbFdKAF5D5/C/bWTBUEN3BOtPYWSe5xL4n+06
 ADPA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dds5fu6ek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:26 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 66E25801AD6;
 Wed,  8 Apr 2026 19:24:26 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 49E4480FDE8;
 Wed,  8 Apr 2026 19:24:25 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:20 +0000
Subject: [PATCH 8/9] configs: Add gsc_defconfig for HPE GSC SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-8-2be1fb7cbbfc@hpe.com>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
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
X-Authority-Analysis: v=2.4 cv=E6D9Y6dl c=1 sm=1 tr=0 ts=69d6ab6a cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22 a=MvuuwTCpAAAA:8
 a=x0LnInECdJPLpRm9YaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5J6enYDoVQuzuQZMWZsfiqD-W60iuImv
X-Proofpoint-GUID: 5J6enYDoVQuzuQZMWZsfiqD-W60iuImv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX5dqpWils+5m6
 iPYYPy568lwa0oBpaRbF5T/39uQGcKhw2LOPbjcLXDZy33k+fMfMltToZi7Q/ha2JI90qTnE6xW
 /bds1uJPNDN8XiXRzJgFwp3t7MvpAO9OSm2ND4iSUwB2fPSYNd+Pgq26S/PpLlXf2dQKxc3B/nh
 d2AB4XZe5fWkcbrPX4P4jwwpqeYT2f+9a3YFjrEsNOr0POgH5v4Y9XpPXCWhRP3Hm+GXYO0cZCv
 MrYKCMVAHzlAdvQ0Q/yPV0eofJQsO28NCfWRpmkUvjT0YkHsDvTsvySDCTt4N1Eh/CJd0tTKFzb
 KHse0tqJgAZa7j4us90SpIsbChPo385GVCW/C6tQBaeMuhy2nMK3g3gj14j3xjUuMQBMeRuVc4b
 3S/ekpK+2qBqcIxB3TdUR4irr9CfFlLAoSMn4+mSGLwrbUOt47i0ZtNK0nri72UjxRUAWznMJJC
 eW+Kb8d821yHBO6RRYQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080181
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

Add default configuration for the HPE GSC (Gen Server Controller)
board. This is an ARM64 BMC SoC used in HPE Gen12 ProLiant and
Synergy servers.

Key features enabled:
- ARMv8 spin-table multicore with GICv3
- FIT image boot from SPI flash
- GXP timer, I2C, and SPI drivers (shared IP blocks)
- Cadence MACB GEM Ethernet with Marvell PHY
- GSC watchdog and memory-mapped EEPROM
- FDT fixups for I3C hub and VPD provisioning

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 configs/gsc_defconfig | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/configs/gsc_defconfig b/configs/gsc_defconfig
new file mode 100644
index 00000000000..7bfa40221bf
--- /dev/null
+++ b/configs/gsc_defconfig
@@ -0,0 +1,88 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_ARCH_HPE=y
+CONFIG_HPE_GSC=y
+CONFIG_TEXT_BASE=0x10000000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_GSC_I3C_HUB_DT=y
+CONFIG_GSC_PATCH_KERNEL_DTS_VPD=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="hpe-gsc"
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_LOAD_ADDR=0x200000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
+CONFIG_ARMV8_MULTIENTRY=y
+CONFIG_ARMV8_SET_SMPEN=y
+CONFIG_ARMV8_SPIN_TABLE=y
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=5
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run spiboot"
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="HPE_BMC# "
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+# CONFIG_CMD_NET is not set
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_GXP_I2C=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_GSC_MEMEEPROM=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPI_FLASH_BAR is not set
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_DM_MDIO=y
+CONFIG_PHY_GIGE=y
+CONFIG_MACB=y
+CONFIG_MII=y
+# CONFIG_POWER is not set
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_GXP_SPI=y
+CONFIG_TIMER=y
+CONFIG_GXP_TIMER=y
+CONFIG_WDT=y
+CONFIG_WDT_GSC=y
+CONFIG_SHA512=y
+CONFIG_LZ4=y
+CONFIG_LZMA=y

-- 
2.43.0

