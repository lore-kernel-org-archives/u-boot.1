Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929B6F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F5183EEF;
	Fri, 17 Apr 2026 14:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXq4YXwC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYP4y5V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71A184214; Fri, 17 Apr 2026 14:10:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C56683B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H7AZxg3438242
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eKRJV/3fuW7t2c6NKQar8W7Xqjjvtg+yYmo
 QrTB/vko=; b=oXq4YXwCdHcsCaGAsUEHN6daajUrknn0ZtsfJ/5d2sZ4Vrf/M5m
 KofPJa7Uh8wLsp+oZqtdWGQwlRVCgD8m5zewQ960OcN6EYxxHfFQlfuW4ndimuOB
 MjRrJxrHqgqt9p2PH9tWKJG6yCUYduCYWJCCluk/XkmLc5pR/hpiEK8dwU9uMDaU
 IAaXGoH85cvt5IZ/t19LYs/Upuis9kUlyySmPwOIZuhL5coXSEbJM0PPK/GIy4Df
 amnb2zVoJZ103gW6xWgWb6Bfv3gz2wLrqMGsWvhFIMw0y7rNJ2bzsKUszLSMOnFZ
 X2panBxc9d1bgQfdygaxuwKSVG7O32tfuhA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg88s6w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f780a13c9so539821b3a.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427840; x=1777032640; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eKRJV/3fuW7t2c6NKQar8W7Xqjjvtg+yYmoQrTB/vko=;
 b=XYP4y5V1L7UnVMtCNiA9CEI/RkLcEfgs2LbSL9XyXZQvmkT/tlz8kCtsl4/pC4MiRq
 ywqG9UxItKL4kR4L7Zs+zpvYvaTMjWDJc+xnO35GQ0CSRz3z1H+elsJNZ4YQy17aiegd
 eUbmDE24YWd2IMCZfp2Db3MQ0E8NzLjMVxXe5ZrgoSoPXXPC71magq2N3J16sXEQGmGs
 HoLT49b2luDlJ2RgBM/UarjvObca7AgTba1EsmUingK3XZxJkmqnHJkpLg9IRamlI7fy
 XPuBHBnRJa7T7vtHMLcyft+DRmyRnJb1Hr2EYPAi/j1NIZuLKnRBWWwiVjjuYVeCB3rK
 LQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427840; x=1777032640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKRJV/3fuW7t2c6NKQar8W7Xqjjvtg+yYmoQrTB/vko=;
 b=K4SoOuYa4Khhl/jJ51OVHotO+6XjU1a1IU85iTC+w1UqcqoMOdRwsvKVvGJ4XXNuFy
 JuIqGJ4XGRH3MIAU7Ftnwl/yGJt4zL9HLvT9ZvJUO3b8/Wi/MuxL+Bj2hcicWIbXKNIe
 CrKY1qP01QoxbfUA4H8K/XSAeOkkXBAqsbQeGGw1BtyJILMQeh8UZ/CJijI+cfV0HTQT
 bpK4G65RWvYR5tJFYKUS2s6e8Rg1TSKwJy/x3Xu2aRy9IGwq6ljVfdUN689qF/RL5ujC
 xHVWISNUd9f50GIbq3nLRsjlo0/bKawYIMAkH6JjDKbhG/1xrqTsmsujTyvPL1S7/WHC
 gqRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UuAMpwX/3ZA836Xm7KPKTt95oDzmdca3XWuQvhIrDG0hIpFt+unsCQ+6nUNXgpeJhzygMx44=@lists.denx.de
X-Gm-Message-State: AOJu0YxTNJokWf7P5fxHrkfKJVahlAix0+zP++X4+SmlWIAobyMFTS6K
 CfYAWaNmtI4Rq480Dug77SsrwaK8PKokWcIu8q1S/TYWMyfHHkuSEdMzs8d/LjyFZxfNI34ydqK
 DsHQxxZsZJMRDaL/G1uX7RmFxDQBpGVMme1AehR+FrX/d7qpEeXHhUYii
X-Gm-Gg: AeBDieu4xjRjWZ4rDLvZcblqD4h2L2uvdoPv1Wmnp+VJee1pIKeVE4//m+5mc04wifA
 8MgofnClUS77vVQM0yVoutyaeQ+O33NJx/tCySdpBLaDY6Hk+hTWLkV43i5qCFn7y3FIJ4/JZtR
 ATcjZ9kj/w9ogKtZ/5v7pR1VVEkWqjBZs6kYRT1CJmnTj9DVz/J/QrgYgJT9A5fvz77ROqKAOUc
 3DpkiOPgi0JBI1A9E7AZao35hEX5xlMECr5lOstYfryFUQJBvP4U73sNsLTkamEIwNfvbIYXRYG
 1U99oyBcyah7jUqxWaVZw6O+7oPMiGN+l0kH8u+zEE5JJ35+RJRuV2YDTdljPTyfayqRWTIPusP
 45t6IoYZZwvV0PX9ofvz7rLj1CMmpbAVQyr8d69clow/torbIf6yPzRaNffyntaC7UlY8vrd5Uq
 /u429eBYW+Bi92OKYRh/d5X3bDtwnqwtXVAf8dgGPE+xxrF38a4JY=
X-Received: by 2002:aa7:8892:0:b0:82f:1f43:7190 with SMTP id
 d2e1a72fcca58-82f8b32160dmr2383013b3a.3.1776427839508; 
 Fri, 17 Apr 2026 05:10:39 -0700 (PDT)
X-Received: by 2002:aa7:8892:0:b0:82f:1f43:7190 with SMTP id
 d2e1a72fcca58-82f8b32160dmr2382990b3a.3.1776427839021; 
 Fri, 17 Apr 2026 05:10:39 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:10:38 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
Date: Fri, 17 Apr 2026 17:39:44 +0530
Message-Id: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tJqAzob2joFBkFlDeW4lMFw5F679Q14f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfX6LgPnRpRMAea
 PEPpvpExQw3CZD05JcLT5YfT/4pHnzWY/s4t3jTwZVTgE9LrhTjE9QIAosHxcaBL8M4MrXFVo/p
 rI67qKt4ifErMuAgCXMONsPm+wFWMyel4XDENedVQgEpP/V1nh3m6M2tbFOcTD0ryxhbsS0HCaR
 rBANGKE7cEiF38tQC7LQxAflbPq5xAS5W8P0PIUDLrV0NuwlYrN3Q8YTAk82Z1tve8er/1Dpgnk
 zDts3h/D0hpjGGinjm6f2cALi68aelycn6xhL0P+xo4wDsrWqrfpWoRBrox4xvG7XmWqWoTG6Hv
 17XSKcTlOLoh4DJVCLWyjJ+MDXWEBlmD3EeIM3Q3UREnuWxu8JzlLQ/vEjUn7kvUHO+fkaqj4Gd
 fTPHrKIm6llTIm6JFDUJ/GULOL9Yvd1bprC6L5UUfg/s1XylF2y8iFwUaU6jdeSZNnfVAAjkBK0
 rA1bcfH1CLMPCGVHpFA==
X-Authority-Analysis: v=2.4 cv=X+Fi7mTe c=1 sm=1 tr=0 ts=69e22340 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=cSziVDP4AAAA:20
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a0GKw4dbIcMnyn2RyNEA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: tJqAzob2joFBkFlDeW4lMFw5F679Q14f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170122
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

This series adds dynamic device tree selection from FIT images for
Qualcomm Snapdragon platforms, enabling U-Boot to select the
appropriate DTB based on hardware parameters detected from SMEM.

Qualcomm fit based DTB format is documented in [1]
The fit image contains only DTB, while the kernel will be part of UKI image.

The implementation consists of three parts:

1. SMEM cache infrastructure: Provides cached access to commonly
   used SMEM data (socinfo, RAM partitions) to avoid redundant
   lookups during boot. Includes socinfo header from Linux kernel
   for SoC identification.

2. FIT multi-DTB selection: Implements the core selection logic
   that reads hardware parameters from SMEM, parses metadata DTB,
   matches FIT configurations, and loads the selected DTB with
   overlays. Integrates with EFI boot flow by setting fdt_addr.

3. mkimage: add fatfs image type for FAT partition images
   Added fatimage.c handler that uses mkfs.vfat and mcopy to create
   FAT images from a directory.

[1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md

---
Changes in v3:
1. Runtime IMEM address lookup via DT: Removed CONFIG_QCOM_IMEM_SIZE Kconfig option.
   Added qcom_imem_table[] mapping SoC compatible strings to IMEM addresses.

2. Split SoC version sources: SoC hardware version now read from TCSR register via
   qcom_read_tcsr_soc_version(). The soc_info->plat_ver from SMEM is stored separately
   as board_version. Added socver and boardrev metadata node matching for finer-grained DTB selection.

3. qcom_load_fit_image() returns int: Changed return type from efi_status_t to int,
   returning standard Linux error codes for consistency with the rest of the driver.

4. Code cleanup: strtok() replaced with strsep(); memcpy + manual null-termination replaced with strlcpy();
   DDR thresholds use SZ_* macros; compatible matching and FDT loading extracted into dedicated helpers.

5. image: add IH_TYPE_FATFS image type: Added new fatfs image type to represent a raw FAT
   filesystem partition image, registered in the image type lookup table.

6. mkimage: add fatfs image type for FAT partition images: Added fatimage.c handler that
   uses mkfs.vfat and mcopy to create FAT images from a directory.
   New --fat-extra-space, --fat-type, --fat-volume-id, --fat-mkfs-opts long options added
   to mkimage.

7. doc: document mkimage fatfs type and Qualcomm multi-DTB: Updated 'doc/mkimage.1' for the new
   fatfs type and options. Added 'doc/board/qualcomm/multi_dtb.rst' covering FIT ITS configuration,
   QCOM metadata format, socver/boardrev guidelines, and image creation steps.

Link to v2:
https://lore.kernel.org/u-boot/20260129184817.224101-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- In v1, a combined DTB format was used for multi-DTB support. Based on
  feedback, v2 implements FIT-based DTB selection instead.
- Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (7):
  mach-snapdragon: Add generic SMEM cache infrastructure
  mach-snapdragon: Add FIT multi-DTB selection support
  configs: snapdragon: Enable FIT multi-DTB and configure IMEM
  image: add IH_TYPE_FATFS image type
  mkimage: add fatfs image type for FAT partition images
  doc: document mkimage fatfs type and Qualcomm multi-DTB
  mach-snapdragon: Reorder header includes

 arch/arm/mach-snapdragon/Kconfig             |    8 +
 arch/arm/mach-snapdragon/Makefile            |    1 +
 arch/arm/mach-snapdragon/board.c             |  123 +-
 arch/arm/mach-snapdragon/qcom-priv.h         |   24 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1103 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  189 +++
 arch/arm/mach-snapdragon/rampart.h           |  225 ++++
 boot/image.c                                 |    1 +
 configs/qcom_defconfig                       |    2 +
 doc/board/qualcomm/index.rst                 |    1 +
 doc/board/qualcomm/multi_dtb.rst             |  352 ++++++
 doc/mkimage.1                                |  103 ++
 include/image.h                              |    1 +
 include/soc/qcom/socinfo.h                   |  114 ++
 tools/Makefile                               |    1 +
 tools/fatimage.c                             |  495 ++++++++
 tools/fatimage.h                             |   25 +
 tools/mkimage.c                              |   21 +
 tools/mkimage.h                              |   15 +
 19 files changed, 2793 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
 create mode 100644 arch/arm/mach-snapdragon/rampart.h
 create mode 100644 doc/board/qualcomm/multi_dtb.rst
 create mode 100644 include/soc/qcom/socinfo.h
 create mode 100644 tools/fatimage.c
 create mode 100644 tools/fatimage.h

-- 
2.34.1

