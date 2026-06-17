Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A21CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77349848D7;
	Wed, 17 Jun 2026 14:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsKfDbEZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6UeZw0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C80841F2; Wed, 17 Jun 2026 12:18:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8784C838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UXao2217646
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GbQ/t6tmQ3fcOBktmmmlicjPTCuZR8uVFym
 zRFvsbGM=; b=RsKfDbEZoFTcv0bKZJ4lPGP2TgXwpPCWzLYFr88ZD3+j5xYRKLL
 X5aJ3rR8lmA+sFS4SJuIouO8QryS2l4PtjRd594/VCUts2p65NXQM9SpdpurApDe
 yXuZ0j9yTRPjMqtszW0Q8CFgwh01xKuU/fdQF+82c2ig9H5U2JtfdgaN6ptGWMhT
 oM54lThO+PKXnBjb2Im/whuEWJyWmc+/F3sbqQaCPExCCVksoeJaiVf2LPm9uu5N
 Cw+bNPhJwCDLtM4OBnLM6tT0oErsZDv8LWqWnoXqnh5XddsGJ/oXV5CzvXQeVmmt
 kmVwOIdlgz3KHmKDZ5vMBa05xYTCwLZFf1Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerandc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423f6247c6so6257876b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691509; x=1782296309; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GbQ/t6tmQ3fcOBktmmmlicjPTCuZR8uVFymzRFvsbGM=;
 b=H6UeZw0NLMIXwYgWMmwXwWIGdHtWrVSdeabndR2IEQF1fQITTprsHRq5nY8m//Oy2z
 O+DWGkH3ZzP3vox2CgLnNocXk3XsUX72NCnXG8ThmufvjrM6jKJqkFsYadvNg0fK87m1
 cyAK+yOEPsZQdnJknRgR9Ij7Ym/Mfojyy5P594O6QcQ7r7E3lWSocE2pWVTNbRfNjk3v
 jserroE9GYnGd+6/+Enb+twV3bs+DjX36+ibzKYcRSpW5QEYGsZbVqPRgoq1NHIEubRx
 yXWe8Y9TLMPehLS3PVOeoY1a+YRiKBW7rSXkdFdc0myru1R5EwmZwk7ZG636d34cz2jH
 JQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691509; x=1782296309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbQ/t6tmQ3fcOBktmmmlicjPTCuZR8uVFymzRFvsbGM=;
 b=XbXK0QzlAt2+6oj7QTI5y3yBYAE2sNk1kKc+vr8MaiEeXBXM2psyTHhScKwImPAcOp
 pdTKj4382tGmLDFxcsqRJcntnXiKPKSmPrlg8IzaUApNrr+a7EfyBQIBq842FFNklL1K
 tCh60SvkBuZ4ApUHu1WctsmyIIww8tFoJkIWuybTEsjxbLgHNO49p0kWxN/ssPpZnTuu
 TWdR2/hcl+pL0YjV60Fh7eF1RdaxSMcBE/4b4lNh0Levk+d0GKqnktgEZG++YtS8jAW7
 a9qwBFHmfipLs3qEe9g/j/Z2ge0X0/T7ofSG64cjHw+hf/ArNjVL61AZTSLhK6lDVyPf
 15ZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/f4ToHDU/xP4xUXlHVHFQfPkeiQTr/N7/d2RmZR/q/OMnVmDSFebrPvAUIN0lRCaoUjJqbhoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4uRSQx0WPmLRiMegN4YzWc0526zZQKNclgNoNIR8A1piMaR1m
 RNh6eXMCg/Pk51DXFvS5yYWBOsgKwELCMZdq0/qjcqMdym2DIlr1D//K76AlQJLT8jS8vzkc5yh
 11eU7YoYpeeOeedX86qEK0u4rF7Of8oIKzI9CrBtQV808sC1SHTmcouOi
X-Gm-Gg: Acq92OFMbtbPbLhpU5QAZxQzWgvMPWnIMMSTs1SZeNSPyXJqTXlWjBOnw0vmqNI4EfH
 8LbGXbk2ITIMU47ciPGOjvkjyl4lBgpkcWLCeR0VI/kDhHBVyh5RG/URD13d0pJgi2MORRgsFb7
 +eorvi2OSA4LVeACWYeMSyBU3qr60x7lqYDHGNW1Av8+tDl4E/bxaCYCx1z0Ib4gXC4WvJC+MlL
 OxLpROky8ezi6HPiyI7ILtb8IBiTzlQATSZA3jbpjkbMFu5ERQYtn8aTyS36m5BfBYI8oIZaE6I
 lQAmal5d7yTMHRKx398YxAHEuOKhOl/Gf6yrkmaO2uPqBSQYpGegXmAIy19+QtiDGt/LnqDiMzx
 KvsxDwUEx+dtwb3L6KzjpuTVK5yFAe0gxRSROZ66VHUXfc1C/Vzo+Upq1s8ChfDs3tUxvL8L/v3
 S1MJ+JCSQ3osFxIkyZhu3TfjvIaYpbzze6yRIcCQt1
X-Received: by 2002:aa7:88c2:0:b0:823:d2c:b156 with SMTP id
 d2e1a72fcca58-845244181bfmr3423004b3a.5.1781691508921; 
 Wed, 17 Jun 2026 03:18:28 -0700 (PDT)
X-Received: by 2002:aa7:88c2:0:b0:823:d2c:b156 with SMTP id
 d2e1a72fcca58-845244181bfmr3422924b3a.5.1781691508287; 
 Wed, 17 Jun 2026 03:18:28 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:18:27 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 00/13] Qualcomm IPQ5210 SoC bringup
Date: Wed, 17 Jun 2026 15:47:59 +0530
Message-Id: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX4dIcJ3RU+aqf
 h/hPLYRxaNTEauuDPb/fUq/B9qPXzWf2B3tKXNdKys/DYf9YN+Z7ulbWBv0Vspvnqb3zmptPMxJ
 XsyLJgLEEL61odkWKTjtI+YjPQbtTqw=
X-Proofpoint-GUID: 8yA_0m1AdpvCCqiv2KdiAIBJJsYIBaLw
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a327475 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HXgu0fstwBZNvnSC70MA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX5RLJFTIkjdos
 DlciRSq1DCiVz2QFHQY1E6g/XDDBoDZZo4YPVn33cru28rK2jjeUkWs5gRQGmBeOGNl1R15wIwW
 ws4yEv8tK2NP5MGyIpOrCUJenqMnQ07Cl5evfBNgb6Dk0QdM2chjQ+94FtVjA3XNHrPwJEUWGcI
 qEpK+OK05h1WWqtGoWF8UTg0GUPJ/r91KYCJ5T1O2z8VSCZRDeTfBxSsc/PkhVs5ygWGe/BKBAB
 V91ofQIkBQCtVxhJi1OWRpsXqtOkbVdkTlICs9vUBZSd1zsk0dwdr0YaNs2d+RTzx3h1nQ2wLwo
 pMhkpnJY/dp0s562Ng4fBY+IQa+UCf3Pt5a+vAU180bH/oBrodWMYF1vS175XBRCcxs/JRLisPo
 12yNPweUmd9ztoQypqgmxtpBBZi+3qCi93O5n5W5M8wHbvg67mHHe6CZi19+UJv/y9IQzZgLHIM
 XZuAQ8nW3TyL1CRG5hA==
X-Proofpoint-ORIG-GUID: 8yA_0m1AdpvCCqiv2KdiAIBJJsYIBaLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1].

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

Varadarajan Narayanan (13):
  binman: Ignore noload segments for image numbering
  binman: qcom: Add type definitions for Qualcomm binaries
  dts: ipq5210-rdp504-u-boot: add override dtsi
  clk/qcom: add initial clock driver for ipq5210
  pinctrl: qcom: Add ipq5210 pinctrl driver
  misc: qcom_geni: Add minicore support
  mach-snapdragon: Add PBL shared data defines
  spl: Include SMEM driver in SPL
  mach-snapdragon: Add initial support for IPQ5210 SPL
  mach-snapdragon: spl: Update SMEM with boot details
  mach-snapdragon: Add commands to create wrapper ELF
  configs: add qcom_ipq5210_mmc_defconfig
  doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                              |   5 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       | 128 ++++
 arch/arm/mach-snapdragon/Kconfig              |   7 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 arch/arm/mach-snapdragon/include/mach/pbl.h   |  58 ++
 arch/arm/mach-snapdragon/include/mach/spl.h   |  14 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  18 +
 arch/arm/mach-snapdragon/spl.c                | 615 ++++++++++++++++++
 board/qualcomm/ipq5210/Makefile               |   3 +
 board/qualcomm/ipq5210/spl-ipq5210.c          | 159 +++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 107 +++
 doc/board/qualcomm/rdp.rst                    | 109 +++-
 drivers/Makefile                              |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5210.c              |  98 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/qcom_geni-minicore.c             | 102 +++
 drivers/misc/qcom_geni.c                      | 100 ++-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 ++++++++++
 include/configs/ipq5210.h                     |  11 +
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   5 +
 include/soc/qcom/qup-fw-load.h                |  12 +
 scripts/Makefile.xpl                          |  24 +
 tools/binman/elf.py                           |   4 +-
 tools/binman/elf_test.py                      |   4 +
 tools/binman/etype/qcom_appsbl.py             |  23 +
 tools/binman/etype/qcom_config.py             |  26 +
 tools/binman/etype/qcom_lib.py                |  21 +
 34 files changed, 2022 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/include/mach/pbl.h
 create mode 100644 arch/arm/mach-snapdragon/include/mach/spl.h
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 board/qualcomm/ipq5210/Makefile
 create mode 100644 board/qualcomm/ipq5210/spl-ipq5210.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c
 create mode 100644 include/configs/ipq5210.h
 create mode 100644 tools/binman/etype/qcom_appsbl.py
 create mode 100644 tools/binman/etype/qcom_config.py
 create mode 100644 tools/binman/etype/qcom_lib.py

-- 
2.34.1

