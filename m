Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE0D1073C9E
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DDE83D8A;
	Wed,  8 Apr 2026 14:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gKER89s+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCm33g8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C97A8407E; Wed,  8 Apr 2026 14:20:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB931838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638B3g2v249516
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yTlNI/RnPchvkArAhn0CL4
 b2PKYngoJdao+YkAIL2dc=; b=gKER89s+5oced7f670g8X4IBTMYZKT6ej8dSj4
 4ZfZbPrxISq2CJgJLakfaIFSQt6aILK6CzlF4Yw98Kx1vvjiNgYpQDGudiDXK1pF
 AyN2m3bot7GS62JS7Dmn6KszVKs2nM5snuYPWZsBzY0zzOGERvzQHFz2RU8ozwSG
 9rqj1HKFZxOMrnPVOJUrDMLxHFp7lAd2gFqKOJZOyloruPf9vMMnnTC339O2LwzT
 M50IvmAUYPHIf2CNoeUADfoejOYluf4Mau2vhK8Q5teE9uYAyKtRPeuUh4zM/LA9
 4nErMIt0jG0qGiPhDgG+JeC94ZqhZj9j0pnTH4pxC/sC7qLA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x9b2h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:20:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bd4feb9fso2530713a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650818; x=1776255618; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yTlNI/RnPchvkArAhn0CL4b2PKYngoJdao+YkAIL2dc=;
 b=FCm33g8G54rtGUZsHPDHHOKOElFryAQSTjhWDuaGXicp2olE9wcs3/pLmI7G/8+Ewk
 jwL/1koNIMD40yVvSs+Execi4rQyZz5OSB3T7y4tApppwKuRhKz3ifGdfdF50/RaScA0
 bWGTjwFZp2qtsUY0aG8qmBmUAgVH90MWkykGzJjyZg/UaVoa1uCA4Z2EHTrw2r+SPt7E
 dab/aEZuR1QWb0zim2Pj9wqLXFihr/8dD+jsrkvxxv3LEDPlLec4gwkuoqL5BWDRoxFA
 Wz+vxH8oZd1KK2ruUCA33qGUdmW1Qzmzic8bQQV3V4fivL84oJEyOpC4ytsjzvVrYHDH
 qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650818; x=1776255618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTlNI/RnPchvkArAhn0CL4b2PKYngoJdao+YkAIL2dc=;
 b=Wd6v1cNPdkjJdcDX7j0vQWVLiSM5FlIWZ98itE6Ros9TTnqBGpUGOibkY/7YYYj/xH
 9rIbdi0fVpdhzlbRzCdx+dwerZytZZ18G+cS7S8Ey/snEXJjqANXQ9RNE3csJsb0kidm
 mn9g2H4iKCbqayABzvlX/4VC9MmuHhwDfGQp8gfN5fen0CkXVrNQSmSxNe8VWEXP4Nyo
 nyVhkGDH8LIl+NLUyYGDXM95VcGnMxCM1AImIG5jjmzhgNENh0YjnOosrV7EcPhStnHC
 rpMQWeYJro7qfd7U5CPXM7UOSpfoHqDUsPetpDKVw/u76OJUeVCCQQMEF+kAyCKK+Xfa
 Nuqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5vJjBQWLd/yiUKK7YJhDcOhnfm7NgyhD+OXBO32fS22py6gfAKVH5VI6IPT/wDXHdIALj4jY=@lists.denx.de
X-Gm-Message-State: AOJu0YyAloHU4wIROz4l0dDmawwHFolTaiMjc/TYp1g/mXL1e/EXIMob
 ZVrwfMwSfi/evcxl3FQIpdzyfIIWgnXI4kU05I7n3TjFaPZIeS1lJad3U1zn/1eJiayXRuv+1si
 a3S9KO7tyONDdJ9/CnpXwx9ai2PvaBD9XoTkKPVXI766pv03TqmTBs0/L
X-Gm-Gg: AeBDieskgDcySc3RKXCIekGVYDWGNZxUcJ5emOATVmTNqEojwTmugJC8yIOCocg9J80
 tXcWErehDCIVZ6ZDE+FLHXnRDiFsLeRvTmsuXO91ouKlx6nnEZ0vlX02F6cMmmhAl20hXq8vK9Y
 NT1SFKnlyrWKpTKFHwI24y2JgXJnFU3PzvbRs3/yTVwh8C4BZNNE5hAZUB8bPMf377qQvpBKIaI
 3Ew8DpeB1w7qnR8q4hva4DTS6KUj16c+YQ+acXJTN1QITAgIdphJhd00LicOE2JXu+2y+b/jVLH
 +nvDEBOe92zPovnfMMFO8nrvZJMSQbhcMeLaoPRFZWghfaqV0Nv/EA2ePnVFIvbjl7DvdMRB0xU
 iAVVUVqTqBBGwOzmhQajjNMw1sfubC+4OI1GRSdaMG6Zal/wrvMOt5oypRdyoleZEQI97vDzwkI
 9jGibmAGhsZHcT61UUO78MUF5L5dOVAvC/c5X+GrbE
X-Received: by 2002:a05:6a00:21d6:b0:82a:7893:e14b with SMTP id
 d2e1a72fcca58-82d0db96cc7mr20629034b3a.38.1775650817742; 
 Wed, 08 Apr 2026 05:20:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:21d6:b0:82a:7893:e14b with SMTP id
 d2e1a72fcca58-82d0db96cc7mr20628989b3a.38.1775650817175; 
 Wed, 08 Apr 2026 05:20:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:16 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, sajattack@postmarketos.org,
 peng.fan@nxp.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, mateuslima.ti@gmail.com,
 justin@tidylabs.net, wens@kernel.org, n-francis@ti.com,
 ycliang@andestech.com, jerome.forissier@arm.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 0/7] qcom: Add NVMEM bitfield support and reboot‑mode integration
Date: Wed,  8 Apr 2026 17:48:34 +0530
Message-Id: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d64802 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wgel_GvmafDJSgGvLScA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX9rIPOijeCsS/
 p/DeejEScWOU9GpomElVkUtOJVmGDiYi2jVs3EuZXY6Y1nEYW6cSMMWA6hD0TROKrV03WkNqnv5
 VfNiTCKDuBNvJlzbmE0W+oAzuu89IDwlHOALFxNkfwy5y0EhcYKDz+5evh/Jly9DbZYXdlrOaUY
 CBLSvLoUrP0yJ/sNuuV+hKZmii8sjJ+cP9otzt0Esfa1PYy6L34k+Y2KOOAuQsJlZaud/SXQpFb
 ZcG9ImH8VIE1SYnfga1ozhkE6qS6lLPbADzKXxAKrnBthRU/L4OnK5keZP0A4juEfMj4JUCCZxC
 9VPkTWd5X4uccfJbMFW9FlwbnU9ArPZi7d9qrrkC80We8lVWhkk4u+UlhZfnW4OFg5C1fCvqkTz
 NK38ZG5t8ubAxleGLZ1i19+EzL6SA6WnAiRATlvSAXkZv7oE7gGZR+01J6uEoEdOYtbHHYeQpt4
 BrBUvgvmHLZn2q87Mtg==
X-Proofpoint-ORIG-GUID: Zz-e8sYIgK_wSOJno10PqV1trsQhxiKX
X-Proofpoint-GUID: Zz-e8sYIgK_wSOJno10PqV1trsQhxiKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080112
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

This patch series introduces bit-level granularity to NVMEM cells and
adds complete reboot-mode support for Qualcomm platforms that store
reboot reasons in PMIC registers.

Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
features like "reboot bootloader" for entering fastboot mode. However,
these PMIC registers often pack multiple fields into a single byte,
requiring fine-grained bit access that the current NVMEM subsystem does
not support.

In addition, PMIC generations differ in how reboot-related data is
stored: older PMICs use PON (Power On) registers, while newer ones
provide SDAM regions. This series introduces a unified, NVMEM-based
approach that works seamlessly across both architectures.

This version also integrates reboot-mode handling into Qualcomm board
initialization, enabling automatic fastboot entry when the reboot reason
indicates bootloader mode.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Changes in v4:
1. NVMEM Core (drivers/misc/nvmem.c, include/nvmem.h):

- Explicitly interpret hardware bytes as little-endian for bitfield operations
  to ensure consistent behavior across architectures
- Removed const pointer write violation in nvmem_cell_write()
- Replaced unsafe bit shift expressions with GENMASK() macro to avoid undefined
  behavior when nbits == 32
- Consolidated size validation logic for clarity
- Enhanced documentation with explicit @cell parameters (offset, size, nbits, bit_offset)
- Changed magic number 4 to sizeof(u32) for consistency

2. QCOM SPMI SDAM Driver (drivers/misc/qcom-spmi-sdam.c):

- Fixed address type mismatch using local fdt_addr_t variable to prevent silent
  comparison failure on 64-bit platforms
- Removed non-standard qcom,sdam-size property and hardcoded SDAM size to 0x100
  bytes per hardware specification
- Changed dev_info() to dev_dbg() to reduce boot log verbosity

3. Board Integration (arch/arm/mach-snapdragon/board.c):

- Simplified conditional compilation with runtime check instead of #ifdef wrapper
- Adopted logging subsystem (log_info/log_warning) consistent with rest of file
- Added error handling for fastboot command failures

4. Device Tree (arch/arm/dts/qcs615-ride-u-boot.dtsi):

- Changed bits property to decimal format (bits = <1 7>) for consistency with
  upstream conventions

5. Test Coverage (test/dm/nvmem.c):

- Created separate test file for NVMEM bitfield tests
- Fixed test to use correct I2C EEPROM functions
- Corrected test expectation bug for 4-byte cell with 12-bit field spanning byte boundary
- Added comprehensive error validation tests

Link to v3:
https://lore.kernel.org/u-boot/20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
1. Simplified bit field handling to maximum u32 size (32 bits).
2. Enforced strict size matching (size == cell->size) when nbits == 0.
3. Enhanced test function for NVMEM read & write
4. Updated NVMEM API documentation

Link to v2:
https://lore.kernel.org/all/20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
1. Replaced custom reboot reason handling with the standard U-Boot
   reboot-mode subsystem, per review feedback.
2. Added bit-field support to the NVMEM core using the new "bits"
   property.
3. Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
   access.
4. Updated the reboot-mode driver to support variable-sized NVMEM cells.
5. Added device tree configuration for the QCS615 RIDE board.
6. Enabled reboot-mode in qcom_defconfig.
7. Integrated reboot-mode detection into Snapdragon board
   initialization:
   - Added qcom_handle_reboot_mode() in board_late_init() to enable
     automatic fastboot entry on "reboot bootloader".

Link to v1:
https://lore.kernel.org/all/20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com/

---

Aswin Murugan (7):
  misc: Add support for bit fields in NVMEM cells
  misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
  mach-snapdragon: Integrate reboot-mode handling
  dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
  qcom_defconfig: Enable reboot-mode support in qcom_defconfig
  test: dm: add comprehensive tests for NVMEM bit field operations
  misc: update API documentation for bit field support in NVMEM

 arch/arm/dts/qcs615-ride-u-boot.dtsi |  26 ++++
 arch/arm/mach-snapdragon/board.c     |  59 ++++++--
 arch/sandbox/dts/test.dts            |  12 ++
 configs/qcom_defconfig               |   3 +
 drivers/misc/Kconfig                 |   8 ++
 drivers/misc/Makefile                |   1 +
 drivers/misc/nvmem.c                 | 166 +++++++++++++++++++---
 drivers/misc/qcom-spmi-sdam.c        | 202 +++++++++++++++++++++++++++
 include/nvmem.h                      |  40 +++++-
 test/dm/Makefile                     |   1 +
 test/dm/nvmem.c                      | 160 +++++++++++++++++++++
 11 files changed, 641 insertions(+), 37 deletions(-)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c
 create mode 100644 test/dm/nvmem.c

-- 
2.34.1

