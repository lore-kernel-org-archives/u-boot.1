Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F39D262B0
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC92A839D5;
	Wed, 21 Jan 2026 07:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H5XNq1/4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsK6Hr8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B318397D; Wed, 21 Jan 2026 07:39:34 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D8E82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L6X6XH2353958
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=8fzeYndeeKuAFhzR4NU18wBJ5Xkro+8ZJFu
 PIY3l0rE=; b=H5XNq1/4dEW8S0vOkAURa01pQME39kMyvfWy1aK7rWZCcWUYauV
 NBFxK5agIS7IclVJlAT7hHCxP7pdhjp22KQ6tgp5vCPUuL0Y7XdLIRVO1mYnBuWO
 3Sm9yUaqDVrvZ80TdGT9lhv01OqyXpnLkW/ikfflVL+rxCYr95CMWspme8Bpg+OG
 iqdDp6Ba56OEsmR16WYuir4id2c8NaHI/AojczINAvwPA42w28ysV5yj5N6e4w24
 +PQP/nodB1coGac8gwEARpvlbHzL8Rgb30T7J9zTlcJmumKC5yo9pxJVLjCEbTKq
 6bVAytHLzb+hDc5jorgAhYDvHSrf6iF/xRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btsmpr0pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f25e494c2so8785685ad.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977569; x=1769582369; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8fzeYndeeKuAFhzR4NU18wBJ5Xkro+8ZJFuPIY3l0rE=;
 b=TsK6Hr8xn6kzzLfKAoQOIhlXjubeUD2krGoAdEmcUvjIcdyoq0ub8epT41SH2ehZMn
 R6kcnQyHc3AEJrXa6KbZoaGXrD0Xv0IrG52ZJyZbM0ZpzhHZoAhSgH6GgHG9L85QrYJ6
 yt4dHG6VZtHk349m0uQJXEzHpi+MIpE//FOiLZ/sP0PZ1fcyjMVMtgHGF/PitpROj4DO
 Ut1hRFfjsFIHuMQuBVkZBSLIp+5tEBNRvagKzh4Ax8xiFZcakZP1dS8cZzD+wVntf1BR
 zlvc54L9H1XrsSqDzD/ZvjawYuG1XtULOIt+Lrd9YGiJauyY4i3cY83IHxEHMeZxldeI
 JfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977569; x=1769582369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fzeYndeeKuAFhzR4NU18wBJ5Xkro+8ZJFuPIY3l0rE=;
 b=AGi5Ajd5ayMryXNHL7OIVBr7fCqPB84lVyzV1QMhbDWrBJOLkmc+htjOCwoYopIMs6
 czsu0NVfXUZMOpITe5uIAq1sEoG5Y8I7r+ZtxKM5oMJHx9fVLnn22FrnU5Th6Ku/O6yk
 /nuA+ao0wHCBS3Gcyq3GjzXtZtVv8qFDLJyFGMPQTv0P4mftuxfg0QOQ4YvofROTEhLl
 qObPYbB5tCZzR6YgTb7n4SuHg183l1L5JnICBG5/HkqS9beydtvoLAKtdDFPFMXBO19Z
 ilhGixpoQzIYSv4jyBYw1QRJYFSiGrKFBKDRax2jkbuxP3dYwEWkYr9H6rXoxbMTqpMS
 e62Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZhSoz+fRhY964Wm2cI8kR55/vBjCHN1pQTBslA5CEAmM8a7saO0DhOogauRsMMXhTV0fJRE=@lists.denx.de
X-Gm-Message-State: AOJu0YyC/vwkCChCsaQOb/RVi5TQvk0Qf16qn3Ys8svt5KrMCbQNd9Wo
 iSz6myf4aPIzvnjsIeIUodFunbk0o5A+PO9QCHBFf+urm+WjTGMYl9ZqEllsqTv74XklbDd+z5C
 BAVQZZxhpUADrX4eTPQ76Iw5oZRQjK+jWhg/L/VuCOFDNncyMy0AZ9mxY
X-Gm-Gg: AZuq6aKEI5b+a9WZbciV6ezExYPOjOWjR/+PyF/7Swb4uI/fPHpQ9RJaVO+dAtaT7+i
 fCk++VmgPG9U1IDt0aLZwXzndLKWoP4iyMKzlCgT7Ln+PerRx94L8rnQhQ3LgrWY2TAI4uW2hH9
 u399AlV8zQms/LD+rS1FwvswNKRbeFdav4kCgWvorN4F8lgA9zC5Dq5bj2fBRnFj7wy7+vL4lqq
 Q1JG2i/OpJwUQXqaR8SNv2MNBOjF69YX3oo1LFN6iuJc5r4MWlMx1jNFEIJaUFybva5EFQAEQC8
 96N/L/LRGjB8nWbiIsEbG+Ob3+KINsdQLqHLcMQ98DwT7X9sR5DV1d+cInd7kw4/qW5nhTmWyrG
 nzR1BHXBA+QhxP+9Lza+vpR4RVd6TSvAnKxwm2H/r8IQUQIQqv8Bc1YLZJ7TPqYzv74h7747d2l
 1WbPAjxNbujbZcuoMVZD/Gl4a2mW6B/bxwkyOQTKo=
X-Received: by 2002:a17:903:228f:b0:2a0:9934:a3f3 with SMTP id
 d9443c01a7336-2a700a464a6mr193232285ad.24.1768977568615; 
 Tue, 20 Jan 2026 22:39:28 -0800 (PST)
X-Received: by 2002:a17:903:228f:b0:2a0:9934:a3f3 with SMTP id
 d9443c01a7336-2a700a464a6mr193232135ad.24.1768977568136; 
 Tue, 20 Jan 2026 22:39:28 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:27 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 0/5] Implement reset to EDL for qcs9100
Date: Wed, 21 Jan 2026 12:09:15 +0530
Message-Id: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EIcLElZC c=1 sm=1 tr=0 ts=697074a1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YfCOm-DyAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Ipwr0HMl9bWdPaQpoD4A:9
 a=324X-CrmTo6CU4MGRt3R:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mY_H7mG38yXbi_b1Fg7o-j7Afdx-wM4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MiBTYWx0ZWRfX1pdgQExONNL4
 rIavpMK3Qq4XCLLtnTT2Qp4xOmN+Tb77d8tIOLTXZz6AKHkgDZ5PFTXbivF86/lwU3U71XwmD1T
 +37ldYQQG2oKiAq0S3S9GxpBsny6d+J1CdmmDhUKsFS0NghG9PD4xXZMnBLZEb9jmIokTvezdDi
 CNj8nRA7nVZma4f7vYL1BuSy3IFIJnZOJaOLz3zHSrNWzz6RWEbplY1jxa7lknwaCFIO/4r/aVg
 MBRtqXo6srfbo2wG9DspojMYfDQt8EiIrmLeo/fTUKMLGN0kd6hQTwhGl7SBjZn2SI9owBzo0Eo
 9/xN+ANxL+iW0r9Y/xf2VlR4aKXbxNiOJQHJfDZLlmyFBmULabap00/h/LKobumwCcdFBdSlIgl
 lPXTN1Uc0L+/kGf1n2cdkbPkViywL83wcNklBOYKUMlhHZBaUiR8fWWgx1nlo5sH6vpy6S6ZGTK
 cZUdsqfQR4QdwObrrZA==
X-Proofpoint-GUID: mY_H7mG38yXbi_b1Fg7o-j7Afdx-wM4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210052
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

Using the 'reboot edl' command in Linux, the platform can reboot to the
Emergency Download mode. Implement the same for U-Boot.

v6: * Add r-b Sumit
    * Wrap the new code inside CONFIG_SYSRESET_CMD_RESET_ARGS
    * Size change details
------------------------
qcom_qcs9100
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qcom_qcs9100
Completed: 2 total built, 2 newly), duration 0:00:25, rate 0.08
/tmp/qcom_qcs9100/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +145.0 data -40.0 rodata +89.0 text +96.0
            qcom_qcs9100   : all +145 data -40 rodata +89 text +96
               u-boot: add: 9/0, grow: 4/0 bytes: 656/0 (656)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     124    +124
                 _u_boot_list_2_driver_2_qcom_psci_sysreset       -     120    +120
                 qcom_psci_sysreset_request_arg               -      84     +84
                 smc_call                                     -      68     +68
                 do_reset                                   100     160     +60
                 psci_system_reset2                           -      44     +44
                 psci_features                                -      44     +44
                 sysreset_request_arg                         -      32     +32
                 qcom_psci_sysreset_ops                       -      32     +32
                 psci_bind                                  188     212     +24
                 qcom_pshold_ops                             24      32      +8
                 qcom_psci_sysreset_get_status                -       8      +8
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

------------------------
qemu_arm
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm
Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
/tmp/qemu_arm/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
(no errors to report)

------------------------
qemu_arm64
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm64
Completed: 2 total built, 2 newly), duration 0:00:18, rate 0.11
/tmp/qemu_arm64/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +8.0 data +8.0
            qemu_arm64     : all +8 data +8
               u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
                 function                                   old     new   delta
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

v5: * Update author and signed-off-by email id from quicinc.com to oss.qualcomm.com
    * Add r-b tags
    * Enable CONFIG_SYSRESET_QCOM_PSCI in qcom_defconfig instead of qcs9100_defconfig

v4: * Update documentation about '-edl' option
    * Add API to check for support of PSCI functions
    * Check if RESET2 is supported before issuing the command
    * Fix compiler warnings

v3: * Introduce a sysreset op that will pass down the 'reset' command
      arguments to registered handlers
    * Handle 'reset to edl' alone in qcom-psci driver

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver

Varadarajan Narayanan (5):
  arm: psci: Add API to check for support of specific PSCI function
  drivers: sysreset: Add sysreset op that can take arguments
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  cmd: boot: Add '-edl' option to reset command documentation
  qcom_defconfig: enable psci based sysreset

 arch/arm/cpu/armv8/fwcall.c           | 15 +++++++++
 arch/arm/include/asm/system.h         |  1 +
 cmd/boot.c                            |  3 ++
 configs/qcom_defconfig                |  2 ++
 doc/usage/cmd/reset.rst               |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              | 14 +++++++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    | 37 ++++++++++++++++++++++
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 include/sysreset.h                    | 18 +++++++++++
 11 files changed, 142 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

--
2.34.1

