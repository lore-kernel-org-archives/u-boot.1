Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDAACD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB81C846CF;
	Tue, 16 Jun 2026 11:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOjJP8T0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnkxB2uT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BA784704; Tue, 16 Jun 2026 11:23:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE5B484105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G6fc7R2901716
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+1YkV2SYmJMBKEPkv6Zay4
 HNVsAYHF/Cy47kXweJvj0=; b=QOjJP8T0JfhyjkuOue9zzWunKZlS+Ou0qmwI3I
 bR3YkFkfM3zT++luEClsgbuTmQtMIJUGHFcrQoJohG/83JbRwwVDQe++I/LCGOOf
 aZ3903wYdT/HZy9jFbVbWhbe8Gd9iWR+MH7aeVZo4/Q2r73gv77Rlfw2hRqwuJSY
 ZFPgRG9MjW4htCdBaQCGN/E36vaeZMMtVNFlyQOe7ynt8gSmxTu1755E68VSJNvb
 4IteyOEuhP9zM7rrbNn2iWiKN+q5mx3IsGDujMZNCS2ou2h82m33ISSXn6Z2pDxR
 QFmRJls7dVwGIKuI/uzTYEA80gBLYBvDux3ngKB7M4I2MxSQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep8np6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37c5dfb676fso189123a91.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601782; x=1782206582; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+1YkV2SYmJMBKEPkv6Zay4HNVsAYHF/Cy47kXweJvj0=;
 b=SnkxB2uTOUwoQENP84IClnBnYrEKsoXEYGh16q/85ctJrT1Zlaa6kdI7BJHQyY7JnF
 ZcD4mIbKTIgRYv8oELBmc0RXm4TqNG/6pkYh2jSL2BnK0VxCTi7ubnISTkLJUTkRDa3L
 p7mXjFLD/lViVzEr5pVpVKEEXdsEooAdCNmBNiGXYg6hw6PEYdZMQj/K7ZNui5AtxC9p
 Qa7hSrn7mQVA6XHZdaH7z8nUepeADLw5QD6+Y8GTTbjZyiqFyIE6R7/CagHn/M7YNSV1
 PGnYO/IDPa7WWWn4ZClxmjvS5DQwiw06a3hlFZnecECQGmmMQUmU16jzXdrxcJiz4fkH
 E7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601782; x=1782206582;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1YkV2SYmJMBKEPkv6Zay4HNVsAYHF/Cy47kXweJvj0=;
 b=VC+CnjCN9/ZECyMXnUlGtmpUtJVS1elqCQtJhtJOwk3IxyNPrfF3mW1ABVzjcaT9J5
 IgsdPeIU1xI5aBpfNVbnCqJYlzl74iftZetxJkIOKvCCEJ9bK/HsO6zlWe8xKH5UBKUa
 XFYOHYhrVGrXzvDPin7by6JULkrGuLX0ydSpkUKBti3kkPBmJxbu3RtP+8CrUlG4oRpw
 3yNHV6uVhXfAuIBp90N+JVQNyAXR/pElHbNNJLNAy21r0HMC8jNhRtrzcu/U06HBNjnh
 iKnp4qPg52Mv+bF7UuTqp8W0jbrQf+VOUb6AKCPmsYWXt6qv0isHCaUaJtcZ6+4sASOI
 B2Xw==
X-Gm-Message-State: AOJu0Yw2w0oKPuQVzbcdu6tvtDMdF5/x78gxlmO1hfyskAYsAyXutfVP
 MKqEUY65loacMn6pY7o0WjLwe0WznhqItYTGHwY+9UHP3VG7NDWvDR1cA3fprOLEDMhjZH8EDq4
 Cwsa4PAukGF1ms+ESykKEueWChU+ByFCj2JtUQXgHeAeYga5ISn7CVoKP
X-Gm-Gg: Acq92OEVEK4UdYU3rWR79B4kJstLu2Yu1fwJ1KJopNh4ihwUWMMGWEolpJ6i72vGEYW
 V0q6eKqn8ZjjhkC/MzdksfpxHPpZ9fiLxxwQZ5pz2pWgJfuv0UToZmkM13brRLjZjQD52vKXolN
 PrIYauoyOudqMno1CCWnOE55u3vrv/w231ma+QJdIv/QotErNY/EAGZ61yl9tLPhiMEsaZHIhD7
 3BS3lQGEnJmAMDZvcqEDQ3KiPzKnB7lpMk4tNg7FS02c6dfXTi4LpQrkMgtUYTbX7oG4NKZ8qOk
 ktdA/hu+ftbPoum22WzEj764TpuRDIxSzwZcRLvLAeURRDuLPnXQ/vLtgicr4D96LxS8ZsmZD6i
 XAoX9aqXLnHXXg/e4TwrtShN5PDZSLAtg7W7w+tGphUeArpnpEkm1iaxfRxR6ux3mwU/bQz3oM0
 eqk+6WC05xLNAq5vY2quySy8WvpXU5lyD6q9bUHuD1qwN06OOCMA==
X-Received: by 2002:a17:90b:5627:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-37a01e2fbecmr18182460a91.2.1781601782094; 
 Tue, 16 Jun 2026 02:23:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5627:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-37a01e2fbecmr18182438a91.2.1781601781625; 
 Tue, 16 Jun 2026 02:23:01 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:01 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Tue, 16 Jun 2026 14:52:50 +0530
Message-Id: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsVMWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mz3eK89KT8/BJdczMDc0MTS2OLFEMLJaDqgqLUtMwKsEnRsbW1ADJ
 AIu5ZAAAA
X-Change-ID: 20260616-sngboot-760714938d18
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=4473;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7O/B3wvTDHaDopKSAVc75d9bUf3sLqvhwCSBWwhWPnY=;
 b=Y+S5uJkJv8SgBa7Juv56XG/MkbYWa4ekhtYqzocJJdKaMe4Nj0ywFO1SnVeoxwKVJS9ld7WSo
 bfvV7NIR8+2BGSIzBrHa7TOHUpTQprM9vAzGNBBM7VUosMiFBalq+Ys
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a3115f7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3XfeyOLyYL_U4Ub00CEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfXyD+MAgmZfSDo
 6Q4yq7K6Fba1QoC/k1S6U75vGoXOWpTkQd5lUeoY1l3sc1GckUu2F7d7H7jb9wpNru8mk2xuYJI
 ZUSiRHUhyMpCXO2dDDRODiIAU9hamNQ=
X-Proofpoint-ORIG-GUID: p-YvxN730MSbYrS2y9g0se9-C0eYUz0n
X-Proofpoint-GUID: p-YvxN730MSbYrS2y9g0se9-C0eYUz0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX39nhqMkPAkue
 marIRFElnt1VgqTNK2fjeUu05j+MUMt168muuvVzLy2NoCKKZZLRBqDLkcQyTVkaeGPI2CzBAKY
 ZyY5q90km8rcCYYtjz+RcbwR+Y+ih6cy6z6FARbCOLA84jbUuTtEr8gzabKwl8qhwREWjO5NTTD
 Hh7ySTTzy0FWo9VTumCh/88qz5KvzQXp/kI+4dF667wPsCGqMlXLd/5dWkQvoT5BOaUqTdmmkyd
 SZGQLr3sKP0D1Pr1ew3G5ZL2aDZbW2RXcMJptkA5F1/U2pbBmQLFALC+xbz+SFSqqCTZ7XjGPj5
 g1MNC9XyLl1CL0/Qhd0xMVJIjIwGdW6ANJFLhU4ZxoqQDg30gbXbOhmB98FQYHxxUmE9OkJsxts
 YBj4fEHCwwbKETypJzhzjamL+gySpS3qSJpTI9/JFcWxQlveoTYgN2elDbv0s+0sOw2suel4+AJ
 qEnXyf94tdLP0lKudHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160094
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

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in recovery mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

This series addresses the specific requirements of the snagboot flow:

Patch 1 changes SYSRESET_PSCI from 'select' to 'imply' so it can
be disabled on platforms where PSCI firmware is unavailable.

Patch 2 guards show_psci_version() and qcom_psci_fixup() with
CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.

Patch 3 adds CONFIG_QCOM_SNAGBOOT_SUPPORT option to enable snagboot
mode support on Qualcomm platforms.

Patch 4 disables the MMU and invalidates TLBs at the earliest entry
point to clear stale page tables left by previous bootloader
before U-Boot sets up its own MMU.

Patch 5 adds QCOM_COMMAND_DB_OPTIONAL to allow the CMD DB driver to
bind successfully when CMD DB data is not populated by XBL, logging
a warning instead of failing.

Patch 6 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
on qcom_defconfig with snagboot-specific settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection 
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (6):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_SUPPORT option
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      soc: qcom: cmd-db: Allow boot without CMD DB data
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK

 arch/arm/Kconfig                                   |  2 +-
 arch/arm/mach-snapdragon/Kconfig                   | 13 ++++++
 arch/arm/mach-snapdragon/board.c                   |  6 +++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 53 ++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig             | 45 ++++++++++++++++++
 drivers/soc/qcom/Kconfig                           | 18 ++++++++
 drivers/soc/qcom/cmd-db.c                          | 14 +++++-
 8 files changed, 150 insertions(+), 3 deletions(-)
---
base-commit: e1c3db1f788ed8106840e81b795e030cbe0020b7
change-id: 20260616-sngboot-760714938d18

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

