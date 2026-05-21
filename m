Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE61CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C4D84837;
	Thu, 21 May 2026 20:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W48xBokq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCzri85m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB82D846FA; Thu, 21 May 2026 20:06:15 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3EDB84713
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGn4Nm187711
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=40tx1vZEguZMKVopz3ITm8
 tIuAdzbtt1kyHQDj+ZvCs=; b=W48xBokqET8Izvajop7AdOY8MIevUWY9djxN4A
 FSvAEoboIrTgBVt9fuk782+QLZKLsaRZ/XzaenBGobihagrslAF/bbv5TyECLHhi
 D7wMG2xwlW/0NPASxgcBclP2LYkAL1eK5ULd3iAwMe+GkD+t0ukLSfnSIdag5d65
 gwK/xVJ8qeq30H57XiVlCqp+eTdFhC1XaMnvWvg9Z+7opDEotZitjWgS0sR2+bM5
 Rm6OhViRWGHxfscsyqpdMIOHTL3HffJG+l09BCglv8pEuueEMpcCQBblexJuCQ6x
 SwR3oM8/sH7YxKrIJeSiBrOwuWXW7V/OpTU2WstohQcez8kA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahtqre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba838d3fa4so61208225ad.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386770; x=1779991570; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
 b=cCzri85mYx8hMLawHA0C3vfceoCfD7g4JNoTeFYLT7Dho0+9g4YAoziVaWXTDJo9j8
 yYSa7CBxx9DBWw/MaT+KAb/8cOdXK/MoG06uMaRClvW7s/SBcMIYtDSxnZl7jUY44K7q
 5pfPGTYJo2uKQTCb7kN9Ll8fV7NfbBNT9BNdk06tL8elbJIgweIw3+vVXzwQgONrcViv
 YDzWPxFIlkXWO/B9S7cHMSn+BbNytdD5slJU46iZdC+yXpBWzjww+0dPE5c1MYctfOUN
 nEOMEznDf0CQ1apT/1Hjdsgw7JtPi5i3nthY8uin/IlQr6K37NdWNzlY7yb3VAr8fbZb
 mu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386770; x=1779991570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
 b=bjIP2QLxNn6GT2Cu5xDoFPMAP04UgPngxEGF1N4dZX4J12SOMwtX31rPefVAnAwcPj
 oICBZMAzJOg/fFlaLIbhmug2IW5Z9ZN7CTZtpWEWC1UpXePhBNaJ70yNx1iZ6yZRE2TF
 qqFpyowLmgq7VBJuLRoKSAjbmAX0uAgiq9iaxA5GzBB92thRThYiD4oAyVTfnoORSjo7
 2GGazqLl8am2byVoowhta9wPNZ2Mm2HaKZrPUBcNEQq25srzHZH9vvr5PIc3m7yh1qdP
 3I/VMNe4gwF+tmn7dmwZ39ziZcUFJDP6NaFEVOs+3t6+I5g7Jhqe77FIEKivouBEpQkT
 mwaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/213/EYA5XwOrKW1Q0SFp1VqVRxegvMzsLzPgqI2oRuoQIUaNfM0MtMNuN3UkC2xXo7Q7YJrg=@lists.denx.de
X-Gm-Message-State: AOJu0YzxST60gMmwEhq26a3QVDLud/v70bgAdFPrVx6AQhg5KOh7ikjE
 6q+aQV6W2xEVAhgUtsyEhQMToTVHHZKWqSByRcs4UQfE/gYls02AZrYP9R6PkH55YsCVMEF9/9g
 KnwWsI/tGNzZ1+2chk/RQ7Emv0TcspszqpjW0kKdCLWwejLHej1JvwWsv
X-Gm-Gg: Acq92OGGyc7YbVsvehdWgU5V3X6wSc+DaRR0bItfKANik5RBVKjA2UqPzjVQpZUo7+i
 M7aQ+P83ajcN8Bitn23D/jT1iCiyop+T6BsxrZnO7ziC6WF6GnwKt9tAcGeksMq10apWscICRE+
 yAOtTeMzYclYYnE3fbQIT7vZ5XiQB06Llqn8OEHdXHYgmXk2KLDBqaZ+pE0J0CR+DrK++FjIkIw
 osakk3m6gWkM9cBvGxD+LBaErQgsL/DpSVDZYDV2RiM9uXJybXNgVATNKaJl6v1Sgl39z+fOAnF
 ud0IfOycIWePQZd7k40ovy7XWKNBhmhsxdZ7k5PvI++Au1j311+9hYdRhWyLM+GK0uMsmd+6tBM
 504Rbt/e1E6lhw5As3cXmqabbGn0BMP5ROuyjSp/jS3AqkZjk5zssS4JsTj7DUifQsZAxXfJlE7
 SYKbK8sKVC4d7lyfI4gymjaDRecYKEjn4Lp44Ua3SF
X-Received: by 2002:a17:903:3905:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2beb05e4149mr409915ad.25.1779386769976; 
 Thu, 21 May 2026 11:06:09 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2beb05e4149mr409165ad.25.1779386769330; 
 Thu, 21 May 2026 11:06:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:08 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, clamor95@gmail.com, m.schwan@phytec.de,
 msp@baylibre.com, aswin.murugan@oss.qualcomm.com,
 lucienzx159@gmail.com, sajattack@postmarketos.org,
 luca.weiss@fairphone.com, varadarajan.narayanan@oss.qualcomm.com,
 peng.fan@nxp.com, anshuld@ti.com, ycliang@andestech.com,
 n-francis@ti.com, jamie.gibbons@microchip.com, justin@tidylabs.net,
 quentin.schulz@cherry.de, michael@amarulasolutions.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 0/7] qcom: Add NVMEM bitfield support and reboot‑mode integration
Date: Thu, 21 May 2026 23:35:42 +0530
Message-Id: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MSBTYWx0ZWRfX7liZlGRCspmx
 mPI+5j7LyZ4uOdGBYnEACK1hAAOikFU0T2UYZ/fzw1uMlz7O6ZZlrTH2WevlOlW4Z5SxOTiYsSF
 aRAH21K1DZ7CTdZeRfEV6Woy/QzZHAWrwOx9BM82jAGyKXEQtFpYRG5A+tWUGLM9yj2HVTXvhM5
 BHURd1FLBOPBEhEU3nX2IDletDlZxbRLCz3eVJuxuOdr8G1IiwtIZUlVGYlwrRMTd6FYCKf4gIh
 ynVHyMZos9cJMTiwF4x118JtVNOW1IqMg+g39YoeDPFHejtTfrZvcegXW+gCHxsrJ3d/JP00ZXQ
 /Oocpdbpkx3sKTRfkBBwk4CpTYb9wZ71X6skFLvHOBf16/ZFctVjQM8j7YSxz8tvCl0Q7hwltQt
 ytb0U4hgL5ZgndqD7K0cxYPOqHJtJW0HAOZEvvdNnW3/D4+HBrDkRWMmAMW0mtHlklF+5sqGLs7
 ldm2OoIh5U4m9fZoS8g==
X-Proofpoint-ORIG-GUID: 40FUx1yCwaETesgtR_-jnyqzekki27iw
X-Proofpoint-GUID: 40FUx1yCwaETesgtR_-jnyqzekki27iw
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f4993 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4I-owfGHyUgqjhYrcLAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210181
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

This version adds automated reboot‑mode environment updates via the
REBOOT_MODE_ENV_UPDATE option, ensuring the reboot-mode variable is
set during last-stage initialization once the environment is ready.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Changes in v5:
1. Added REBOOT_MODE_ENV_UPDATE option to automatically update the reboot-mode
   environment variable during last-stage initialization.

2. Registers an EVT_LAST_STAGE_INIT handler to probe the reboot-mode device and
   trigger the update once the environment is ready.

Link to v4: https://lore.kernel.org/u-boot/20260408121841.186410-1-aswin.murugan@oss.qualcomm.com/

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
  reboot-mode: add REBOOT_MODE_ENV_UPDATE option
  mach-snapdragon: enter fastboot on bootloader reboot reason
  qcom_defconfig: Enable reboot-mode support in qcom_defconfig
  test: dm: add comprehensive tests for NVMEM bit field operations
  misc: update API documentation for bit field support in NVMEM

 arch/sandbox/dts/test.dts                |  12 ++
 board/qualcomm/default.env               |   2 +-
 configs/qcom_defconfig                   |   4 +
 drivers/misc/Kconfig                     |   8 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/nvmem.c                     | 166 ++++++++++++++++---
 drivers/misc/qcom-spmi-sdam.c            | 202 +++++++++++++++++++++++
 drivers/reboot-mode/Kconfig              |   8 +
 drivers/reboot-mode/reboot-mode-uclass.c |  29 +++-
 include/nvmem.h                          |  40 ++++-
 test/dm/Makefile                         |   1 +
 test/dm/nvmem.c                          | 160 ++++++++++++++++++
 12 files changed, 604 insertions(+), 29 deletions(-)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c
 create mode 100644 test/dm/nvmem.c

-- 
2.34.1

