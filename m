Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB55DCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07358499C;
	Fri, 19 Jun 2026 13:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bh5VqmR6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPHDAFpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28292849AE; Fri, 19 Jun 2026 13:10:43 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F178847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7QxkH081514
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=StpYBHwFGmX52pq9Wqv8tA
 ffNNgwQiT8AScVySG0RJo=; b=Bh5VqmR6cZRSlAMesVbRPTIAjCMjnRFICy/6EI
 PdatDNIMrveT3FcelOWmQL5Y0NPiNi0HQlFkY1xCtYYURACc0Q3CdbgIivwHVWfo
 RLgS1r3tcuaV2Gjnogp+zlEDwkMudDA5nXw2mYH77XjePuwKUkblrooqQ3fkjTjq
 GxWWMy9hBxb1x5e5/vDWjijXoIWxZHUfXvoNz8cgJD35o46c1dEQi6fvOgD4Ta0b
 yNZIF2IaV4wuurHgOZk/LlnBLEYrxoctpx8aBLJaZG/OuySpgmnBsVQxMyG9li6D
 NAiylOfy4q5K/zupo4JWsKANTpRdMvoskOA0PGPG3ihVTwjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtjbbmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c2d0a8b5beso25069115ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867438; x=1782472238; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=StpYBHwFGmX52pq9Wqv8tAffNNgwQiT8AScVySG0RJo=;
 b=IPHDAFpG4TicMQNdScYmHH4lSC5l1QZZgVoypZXBBnJZLo/GF1opytFlNQFhoSVCrV
 MhDnpwmEszGrGS+F5k4quB50J+QqSs8APIc9ZIUSNN+gdkw+voxUoXQVL5MQcsfWUQ0O
 w8E0PgzdUbB4h9pQuOz5V1/KtT3qki09arUQYw8Iv0YCqSOtN20VQoPRDQaJOxVbjb/T
 WkZQrph3ypC6im8Suh2L9CKKX5kUYk7tzDieF+/DWxVGq4Lvn9Shldn1zLRLHwZusBtg
 v5RuK7dKXnRiYE2eB5A02yxbDwJizDIvgTm/ZrRoECt3NCGbOfiJIwF0120tQBr2g5yy
 9pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867438; x=1782472238;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StpYBHwFGmX52pq9Wqv8tAffNNgwQiT8AScVySG0RJo=;
 b=KvLmM3v7TsOW97qMuXkH9aZd5VuLatrw3HiuUu9PkECJNiJBK+l5Y3FR9INpCOVUuw
 ntI8Wlk69viaSLfOECqCNXiKVFcpnoGXBZ6pSXMjjYO314YRcx6Hzz4ll9P1yAILcKX1
 bTNJWMwaH4psAtEm7Ijj8EFFFREZoVKaXICQvdJj/ZRodFA1Vk2XCEbqPSNl1Xnpisbk
 LdbEbBM9z684S94EFHENBdvRqYGnSdSXvQOh7zQRrssiJggvevCkZFyqX0ndXsPjNefM
 DeKBvt7SJvElK831zciBAFi9LAnNPF+zPcVNUxf2yWjs1a6/yKvBGzRZoIX3o0K9p7Dy
 KYbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FlkbajLU1MD37dpdRrkC+tduuCcU4QdSGXvOncfJR5tsZqtBSBMcxjMgfKHnFCsgk5IoxkI0=@lists.denx.de
X-Gm-Message-State: AOJu0YwqwQFlNobEhoyNzFOyN4gN/HpN6m7ggId1La+eX4x8J3bg3H/t
 oSC5zZZX2+85KfgnX/lpDF+trFvC4Coo94NdIo4OBQMpi89kbRb2I40g2vFmWy84kDfAhPBIUoo
 BkIyAJrjjBoWoD4zrUIh18ralEqbii4qITKPzv3D1FgJ1qJR8sBntQx0s
X-Gm-Gg: AfdE7ckir5+sAxPGuIy5S1W0oK/6pINw5/XsIfpGnHm19NpIzh+1pC0BUqhbeXmuE7D
 bVUEdbQ+wSA/Nt0WOyAw1G2JpiRm8Wqn/pStwFAY+DOsusX9EtAdlaTCYVE6+FhdO9DqVeFyikb
 TTNV7tGkEyEyGKhvpnliPODek8ouAGYQ6Igv90lmVBWbSfjgNUKWMe3qs8+zUlecPhZz3sKRgH2
 yUyrUTT8k8XYy+RQHxvIFSIcB6CtfJO9PFY30W8QS94dWGj556eARmRfZ3Yg8GJkMqNXBRnlkDm
 0ZnGlNUMziXZ7hBGuvChyZoNvYDaQGP5t0DxH8yFGFf2AizoHpogNg4JcMAV+BagFI0tBXvZq53
 gVwcK2Jh0JprJ0K3OVkfFFiiCvpAa7JFe71ZTLjrZGsJGrHjsbtp6TApDidYZ9qa6ziZG1dJ5vM
 BhRRuU0iECcRySDV/a1/X60Hxz9T26WSeEeANSMAs=
X-Received: by 2002:a17:903:2347:b0:2c6:9358:3ad5 with SMTP id
 d9443c01a7336-2c718fc45fbmr33792655ad.17.1781867437780; 
 Fri, 19 Jun 2026 04:10:37 -0700 (PDT)
X-Received: by 2002:a17:903:2347:b0:2c6:9358:3ad5 with SMTP id
 d9443c01a7336-2c718fc45fbmr33792185ad.17.1781867437235; 
 Fri, 19 Jun 2026 04:10:37 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:10:36 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Fri, 19 Jun 2026 16:40:23 +0530
Message-Id: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8jNWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NL3eK8xPSk/PwSXTMj0xRzc4tkU8u0ZCWg8oKi1LTMCrBR0bG1tQA
 HkD1uWgAAAA==
X-Change-ID: 20260619-snagboot-625d778c59fc
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=6308;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Zm+C1RSOTmoLCpUDLO1B+DBLrfcbW8xIxV5c7aJfG04=;
 b=SedzNZRXgzv0QB0pppg7P+3ueKs1gdppNY/Z7IN0ReULZETVXY12kqXkg92v7mECiV9TrVPeS
 VeUh3W+iTAwBqZ/N3f/s9bWIRjrdVrqbnlaLznCYizvd4MpCtHbSQqT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX29mAJBXaYC6p
 Qku+VTpJ/HPIixIQ/Yckg/3gf8ZZNWGECn7zh0T0aECgDc/ZJvzV618RD3ShgtLx6JifAlqpO9m
 6DsdmtmFnOoNbHo1Gkg3tntT+2JFibs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXw/8Ulj1auYyj
 BINhV1I3jmPd8S3bI1XmU5YNotAFVZNd610qpKCvVU8Eg60EjC64cAfpN2VP4GAe1BgTnzTHpoe
 5hZ9Kz7Smp26WGSo7cbZXe9dVwbna8zdw/la+iDDkDZMxIJhxRXSZ0f0HApmMQMWOWgq/ZsSJIx
 IZpGM5ngSny0qglhXE92rQyrcqNKC+9ac4A2CY5h79fKN/3SFdYUL5ej/lssMv+skpjAjiT6g9x
 0aI//GN9ShZO1LXfNkVCIT0Lh40j9KBHEohl0piU6+jAMCpqBHQqHtr5/RgfHYxsBcb+m86MPlM
 3DuOJyUotnAK868r3xNN0awCSMultXPC79OrZQM8JWYDL8NxYukBci600TplgC86t4AfZPwwWyT
 HF8y1LimNO0zm6gTF0picFkdNNYlcCiR6G+xcLznwkChHv0xUOUQ3hjCKK5zy+VDE1TcNIDeYFO
 L0REEnxkOeV7tJcyjVQ==
X-Proofpoint-GUID: Hl-lVfjK7by3MX_b4iYUEDJsJxHMsH0G
X-Proofpoint-ORIG-GUID: Hl-lVfjK7by3MX_b4iYUEDJsJxHMsH0G
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a3523ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=bdZDpkB85n7FlCjsG58A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is now available in
https://github.com/qualcomm-linux/snagboot/tree/qcom-next
Soon these Snagboot changes will be upstreamed to https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which 
populates CMD DB data).

This series addresses these issues by following patches:

Patch 1 adds CONFIG_QCOM_SNAGBOOT_MODE option to enable snagboot
mode support on Qualcomm platforms.

Patch 2 changes SYSRESET_PSCI from 'select' to 'imply' so it can
be disabled as PSCI firmware is unavailable in Snagboot mode.

Patch 3 guards show_psci_version() and qcom_psci_fixup() with
CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.

Patch 4 disables the MMU and invalidates TLBs at the earliest entry
point to clear stale page tables left by previous bootloader
before U-Boot sets up its own MMU.

Patch 5 allows the CMD DB driver to bind successfully when CMD DB data
is not populated by XBL, logging a warning instead of failing.

Patch 6 removes Lemans EVK override DTS

Patch 7 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
on qcom_defconfig with snagboot-specific settings.

Patch 8 adds documentation for U-Boot snagboot mode support on
Qualcomm platforms.

This series depends on the following patches/series:
https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/
https://lore.kernel.org/u-boot/20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com/ (already picked in u-boot/next as of 19th June 2026)

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot 
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

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
Balaji Selvanathan (8):
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |   2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                |  19 ---
 arch/arm/mach-snapdragon/Kconfig                   |  28 ++++
 arch/arm/mach-snapdragon/board.c                   |   6 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  |  26 +++
 configs/qcom-snagboot.config                       |  33 ++++
 configs/qcom_lemans_snagboot_defconfig             |  18 ++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/snagboot.rst                    | 184 +++++++++++++++++++++
 drivers/soc/qcom/Kconfig                           |  18 ++
 drivers/soc/qcom/cmd-db.c                          |  15 +-
 12 files changed, 330 insertions(+), 22 deletions(-)
---
base-commit: ff70c8fdcf2fe81acba632b606af16d5a041631f
change-id: 20260619-snagboot-625d778c59fc

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

