Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF688CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D8884A04;
	Fri, 19 Jun 2026 13:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UOi/lccN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7Bc6AY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CA6847C3; Fri, 19 Jun 2026 13:11:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C08484A06
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7Q8Vi4184989
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J/JRWfIIZSotPfcgCzAQNn8+9ddcmySusW5d8/fcQPs=; b=UOi/lccNFepaby+U
 XCG0+WTj9aw7cWwpmSfIM8uMPcnZ07sHYkiZiQdb+qLbuFYkOjRl60/ud1StruJ0
 LiEihV7vzLj3J5Zo3pm9vPLkhtVR9l/B0Jpu4LQoH/efyxgcdcTNmwOuzaIrdM9H
 M46yi2/bruRLvWTBnN99aoe9NPlJx76MSWIVP5p8bGG75PielVPzvzVkT4i/gReb
 vHUc5oU2Be0RbMyfYRcpxTlzGpFfPy2C+KPTHjZZ7/+339vcoAfy2lUv7RAmBEDr
 RlozoJKSO5GqsMK+JQ/gm9dOv00Ryl1PmS011nhWbmLn3SxgKdQaNb/M+LAiV8m7
 1J6Dqw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sb1yv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0d0516ad7so20340285ad.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867495; x=1782472295; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J/JRWfIIZSotPfcgCzAQNn8+9ddcmySusW5d8/fcQPs=;
 b=E7Bc6AY1ojUR+HwhkT3be/KO05SChVaZz4CuuyBuPoYrOp69HXs3ZPzscEH4Fo1oqF
 5GEwmSKqhb50FHUcUjQqtwJGfarCk5KmYLCLQwwWfx+7SKZ5kvp9TH5gp+s/4ikKn3Ap
 NhhziHIXhldwEQT8Mrqp+BhCWmaS4/Cy/nXCKzc+CslPjwVbbkk+V+u179fdcNLsuh9h
 RxRLR7hFWJh1W82011zigUoDVGmCclfKSTlYr9A2fv1SEQfoPNdv6fc++StuqEi/bsb6
 TatTScgxGbG+YoFCZfkNm2y0avZR30xd8q+T5rYS7k9wyDINT8vHZ7E3oSv0Trnu/rC4
 /QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867495; x=1782472295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J/JRWfIIZSotPfcgCzAQNn8+9ddcmySusW5d8/fcQPs=;
 b=eD18jkiwYpdfbS36zH/Ahgsi2C4uy5+LzRoIzF9+2mmlSluC1u5VDJvTHe6+xlDdlf
 medOf7AiQXURnB9ApBAvthgBi7uVJv+bT3U6wGaYPdnBHf5XeByBQNhBfg6CuDi3sNBw
 p3I5m7G6VevIbzqo0odWgG8mb/sVSLHUiaSRGW2xc/GrrGLWCE40ip4+ErbPeS38w/Ym
 PBvJ3p5aMxzd4jdVA8wT0htf9XaeNcCw57XuL6mLNxYpoLIrvlEFEHnMzG1giTkEmDCG
 IHpzQyqZYkSuYxelmnIzxXkDORSF67OFNxnZ9gdmUN+bM8MP5QUU6dTNx8XWiEGjc0PL
 fIWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+dHn04hEjFWP3I2cVORrM4IGZKYy5ya5ioDvCiaVwKW7kH5gXlJEOtbaC9LfRxwFCNvVgNyY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu+uCfFQgw04qP89O9fEiSmR6+kyME3KAwrQDyN1WecB1db6AZ
 O4eu32miwVeH4liIIUsMaRAZ2Oh5I95e+fUDAMfk431OBrJRjHClbsX8jH018Ks3pcIU5yBeni2
 YLjDfEXVdRBEoB7XKUfMGnH5c9pfCacjDrT0ktjaeZkqdP/cz1UF7/XRQ
X-Gm-Gg: AfdE7cn+9t5kO899eHrpfFb9K4wLEjj0vZKN08b93v5ch+yh3rYySn9SPFLOlTbZpjn
 MJ9ezfR29Zd1M5mu8N+160PTp0tdDtT3ZVxWZPnzzXxlGEjBl/XmxCUzmZyLxHCOyN0AsITgTHC
 45Yz8AvReT/4Cjs+BW3Ft4go9bgyzq4AeTkxdtuPtIT8T402WeDwE+88Vb3jWcfg/YYPpxT/W8q
 FMomVGFkIWWzyllrdlcFzubOnNEdy2b9bWathZNvjuP+9acJWok56VYH1akJsnRrJyM9SImxWJe
 5htn3r3IxLX/bzNOcvpe/8sCqassFFZCsVwJ6VD0+YkLrWp8i8SQcuycAj8EBawJSSXVvFamtpG
 AOtgJatWXNVq9cHxN0TmeFHQy3zcRnsqH+seD4Q8D2WLaFXMTK2TyWew/hiRwgIbzKjjkbLdt0d
 KPZ1vJegbGCNZfb4LzYbwNsuaBBnWTKubY3tEhMao=
X-Received: by 2002:a17:902:ce09:b0:2c1:ef9:4516 with SMTP id
 d9443c01a7336-2c71904ee57mr36452085ad.35.1781867494481; 
 Fri, 19 Jun 2026 04:11:34 -0700 (PDT)
X-Received: by 2002:a17:902:ce09:b0:2c1:ef9:4516 with SMTP id
 d9443c01a7336-2c71904ee57mr36451575ad.35.1781867493915; 
 Fri, 19 Jun 2026 04:11:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:11:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:31 +0530
Subject: [PATCH v4 8/8] doc: qualcomm: Add snagboot mode documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-8-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=7799;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hb/oK59wM6Xr66fOOSCrzZUj5DrCiRsXC1atDi3NqL4=;
 b=er1h988BeXHhQ3T+aC4YDxSHNZPdxzqjcwWq+LW5t1TOmYR3/pDTK02M1XhBucBlV3LGVYETu
 D+56viAEiBWDUsCy50jHBYpRQR+6pXK5VnGUf16XY+6XsbyezxKbJyX
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Ln58GmgKM7-LLmrVHYKsBCtUXzrJ3yee
X-Proofpoint-ORIG-GUID: Ln58GmgKM7-LLmrVHYKsBCtUXzrJ3yee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX3DJJNdjRulTc
 hEOVJwxYb9IxZs3QbkysmGxHSftpX4PBrFyz6FgiGGbyrnpNzpQe1/SiWRb9OcoDamRFN1RTPgw
 P7GQX2HO9COZwvxJUv1H5ch1UGOBH7NPvkBcrrBKMfiyjI14m5G36I2VAfIITL444GZBpBG42oY
 Hf8xHQTzTS5v1/rfe7FE7SoQ/O7pwo1DxbLH2s7d+YukSIDOOsdgN5uMK/hB9vPOWDZqlsA2dQm
 jzLmr4m9GgiA3yrMRulK0LjAcgyPcG4LaCdpsitG2FnKVrXW6Uzd0iIGLlk5xMITuwxqwt7LWil
 aRo0JNAr5hrhjz+8Che2Qpw+y/i820WZUHt7nA8vNCm4ek4jg5APX5XLqRFymc4i0dJR+N9kbuW
 FALAKCoG+LQoYqNA00VtDGqYlSpnl5lpjKOJw0iGPlgEXwgg+BHIUQ+GFZJqk9tWSad+MppsWlV
 G73uM0G6I2J6fBuh+0Q==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a3523e7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=1pZfsyeTZaWddFco-skA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX5L0LPrWCirq3
 MOunpqsik/zEVolP4navDMJsDqYicacVNT9JL+AkxFdGyEjHGMjEbd+iFDB5rw2eYscrFwCE2lY
 XJ8T56ZRo2jJml0I0d3GA0g2iGPak18=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190104
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

Add documentation for snagboot mode support on Qualcomm platforms.
This covers the architecture, execution flow, and board
enablement requirements.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |   1 +
 doc/board/qualcomm/snagboot.rst | 184 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..ee2bc9e29e3 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -14,3 +14,4 @@ Qualcomm
    iq8
    phones
    rdp
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..b7f0598d7a6
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,184 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+=====================================
+
+Overview
+--------
+
+Snagboot is an open-source, scriptable flashing framework that provides
+an alternative to the proprietary Firehose protocol for device
+provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
+Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
+and execute bootloaders. However, instead of using the proprietary
+Firehose programmer, Snagboot loads U-Boot into DDR and uses the
+standard fastboot protocol for device flashing.
+
+The framework consists of three modular components:
+
+* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot into RAM
+* **snagflash**: Communicates with U-Boot over USB using fastboot to flash system images
+* **snagfactory**: Orchestrates parallel factory flashing tasks
+
+Why Snagboot?
+-------------
+
+* EDL + Firehose remains the default and supported factory provisioning flow
+* Customers are requesting support for Snagboot, an open, scriptable flashing framework,
+  as an alternative option
+* Snagboot reuses Qualcomm recovery primitives and standard flashing protocols,
+  minimizing platform disruption
+* Provides an open-source alternative to proprietary flashing tools
+
+Architecture
+------------
+
+Snagboot Execution Flow on Qualcomm SoCs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The snagboot execution flow consists of two main phases:
+
+**Phase 1 - snagrecover**:
+
+1. ROM code enters recovery mode (EDL)
+2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal memory
+3. XBL executes and initializes DDR
+4. Snagrecover downloads U-Boot into DDR
+5. Control transfers to U-Boot
+
+**Phase 2 - snagflash**:
+
+1. U-Boot runs in DDR and enters fastboot mode
+2. Snagflash communicates with U-Boot over USB using fastboot protocol
+3. System images are flashed to non-volatile memory (UFS, eMMC)
+
+Boot Environment Considerations
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In the snagboot execution flow, ROM code in recovery mode loads
+snagrecover, which downloads XBL to internal memory. XBL executes
+and initializes DDR, then snagrecover downloads U-Boot into DDR and
+transfers control to it. At this point, XBL has left the MMU enabled
+with its own page tables and has not initialized PSCI firmware or
+populated the Command DB. U-Boot must handle this non-standard boot
+environment to enter fastboot mode for device flashing.
+
+This is why several standard U-Boot features must be disabled in snagboot mode.
+
+Comparison with Traditional EDL+Firehose
+-----------------------------------------
+
+**Standard Device Provisioning Path Using EDL and Firehose**:
+
+* **Emergency Download Mode (EDL)**:
+
+  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootloader (PBL) in ROM
+  * Triggered via hardware strap, software command, or recovery from boot failure
+
+* **Sahara Protocol (Stage 1)**:
+
+  * Host PC uses Sahara protocol to communicate with the SoC's PBL
+  * Transfers Device programmer (Firehose) into RAM
+
+* **Firehose Protocol (Stage 2)**:
+
+  * Once the Firehose Programmer is running on the device, it establishes a Firehose
+    protocol session with the host
+  * Host sends XML-based commands to flash firmware images to specific partitions,
+    erase or read flash memory and manage partition tables
+  * Integrated into tools like QFIL and PCAT
+
+**Snagboot Alternative**:
+
+Instead of loading a proprietary Firehose programmer, Snagboot loads U-Boot into DDR
+and uses the standard, open-source fastboot protocol for flashing operations.
+
+Supported Platforms
+-------------------
+
+Currently supported platforms:
+
+* **Lemans-EVK **: Initial platform with snagboot support
+
+Additional platforms can be enabled by following the board enablement guide below.
+
+Board Enablement
+----------------
+
+To enable snagboot mode on a new platform, follow these steps:
+
+Required Kconfig Options
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+1. Enable snagboot mode::
+
+    CONFIG_QCOM_SNAGBOOT_MODE=y
+
+   This will automatically select:
+
+   * ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
+   * ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
+   * ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load address)
+
+2. Platform-specific settings that must be configured:
+
+   * ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (e.g., 19200000 for Lemans)
+   * ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e.g., 0x1c100000 for Lemans)
+   * ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your platform
+
+Disabled Configs
+^^^^^^^^^^^^^^^^
+
+The following configs must be disabled in snagboot mode (automatically handled by the
+config fragment):
+
+* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't initialize PSCI firmware)
+* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
+* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader context is not preserved
+  in snagboot mode
+* ``CONFIG_REBOOT_MODE_ENV_UPDATE``: Not applicable in device/factory provisioning mode
+
+Environment Configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Use ``CONFIG_ENV_IS_NOWHERE=y`` to ensure recovery works even with corrupted environment
+storage. This is critical for a recovery mechanism - it should not load a potentially
+broken or untrusted environment from the board.
+
+Using the Config Fragment
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A reusable config fragment is provided at ``configs/qcom-snagboot.config`` that contains
+all common snagboot settings. Include it in your platform-specific defconfig::
+
+    # Configuration for building U-Boot for snagboot/recovery mode
+    # on <Your Platform> boards.
+    #
+    # For normal production boot, use <platform>_defconfig instead.
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Platform-specific settings for <Your Platform>
+
+    # Address where U-Boot will be loaded
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000
+
+Example: Lemans-EVK
+^^^^^^^^^^^^^^^^^^^
+
+See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of a
+platform-specific snagboot defconfig.
+
+References
+----------
+
+* Snagboot project: https://github.com/bootlin/snagboot
+* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+* Qualcomm EDL mode: See your platform's technical documentation

-- 
2.34.1

