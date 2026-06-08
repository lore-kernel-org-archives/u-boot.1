Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A8CCD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D45883EEF;
	Mon,  8 Jun 2026 11:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUZJ9YHm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hol1K4jS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE4D8405A; Mon,  8 Jun 2026 11:06:45 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BBD807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Oerh2385872
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=q/YUkd79A8lwMvHyctEIAK
 fadptiSpMlVyszqvt6/SM=; b=XUZJ9YHmAxST5zktyE++3n1LchSMNlQ8u2bUO3
 2N3Tr+Bzqj7Ekj3AhiKTohLU/dSHd0/oE85tR7lR2v4T8gIehQpwdMwFpgm67Xrt
 RzlBTQfm0nqMvBJzTeIFZF5vb6I8IFuHuJE+0hGpIo+oxo2zgsiVnafc9QyfpEg+
 6i2QoLYXAbqC2bKk49YWb94mfTqHFYXuzxW+UJ0qaMcmQiCA3KsL2etmFQ6rbIYJ
 PpTHrf56pUIme0kAgJP21rkRvLfROFhrUF0bXjv5fiyAGQy0dmDXw/hTMId1klHc
 IOkVVh5N2FphqXwIzeEvOlS2FaUirmgnt+AAU3HMdvXwHHog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xsna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:06:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so80446375ad.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909600; x=1781514400; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q/YUkd79A8lwMvHyctEIAKfadptiSpMlVyszqvt6/SM=;
 b=Hol1K4jSaUeDOIFYsg+67HBDSvOYqNOM1pi8qnFb0Udgry/PKU/KBFhzBT4l9bcAUD
 gMsJI0uerPNagXpWNyQwCqFE77s8LGR5t+JiIPtmVSTQe/AR3bELLHbDT9qcvDYLyt+C
 dS9P3QGjB6WMaplxu+Re9uQna515einLt2rLIzdWzQf6rKRIBnCrqIzqz0jzYd/EY0tM
 hO/rP5+LX+083Rt6JbchUGKWz/gtqZMsr1FcQ+xdmmC3HNcD0D3AXD4iiQiap+HuPVLa
 GWo9G2jW7x7vxAU8KJEzJdvTqTanu3glsrGmysD4aV0GCB3qyeFjDZouqWLKZ/UJMmkm
 qxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909600; x=1781514400;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/YUkd79A8lwMvHyctEIAKfadptiSpMlVyszqvt6/SM=;
 b=HWoo/TUBVAndPm83MXF81RNw3MHDpXA3Qqq18GQ8S+ljqB0+p8m7pm/h+aYDcPV1uM
 2KajPguB8tRhmyZdqzo+asrMOq40PXVFJda65NmaUxEKP3AmTCW/ir6fKIRzPiI0Nnos
 UdqqaZ7ZCTMn5Cz7oyDQoRXO9ykzqB4ODhOdrsecYGSF0cqRUlQn+2ukxglk12WH/fV4
 ez5Kg5TBoAkgoXc7o+wRDEMHa+i3wFcdFlZ5jvsbWsl7r+FP4KWDhNDb6LNy+wBCOhJn
 avorYerlu3SUmADV7D20SgIeB4PwCNcY/u+wIkrDFpHFa1kfnfMZJH+EK1maD+zvTweh
 QpYQ==
X-Gm-Message-State: AOJu0YyBp0iYnU/txmrGAaO8yH8KkYUGyTHJ8oQN7MMOPD6T2A6OUUaw
 owomhOYAxOeI920C+1TEIfjEUi0QX7oMk6c4DqhBZTiVFNDks/navUOkdbHq0tiAvvh2oVoyUun
 SImY6nXwcAkInrEqzBGHgcAq66ueBZ78W9uYeTirqgxAogrQul7rkOjN8
X-Gm-Gg: Acq92OHNjJIGX26Bncx66cx2XJJoB4L1Kgv+0ey2n6OwXco3h/L7PZZklQDEiCFVaXg
 jCpwg9qSqjWX9iZ2WQIg0QaXlh35cMaugl7XEimih0iaaod8HGgdoJVc16gzCCGmmePlIdVCddQ
 ZeKzPsNmMcwoTqjJ2om7rUn4mBLo79p5EWuEp+ASRrznHsxFD+M+AUg/WnVjNXKXjHuu3SM9smU
 moAep8Iqgk8hkvUgLcfHy9rJMslIKdRGDOZD5BZ0QvZUd9p5AelQdbWX83YjW0+c3J8cZvn4PoD
 VqZ/co9oZvzlJ+jaRKnzoMAqziKqk5xxP/qfbbKDLfCF74z6d9Sl4UwAiND5GpJ44cxwZeZFLTB
 Kz67LVOA0z1ojjXUXKFFzI8+p2xtoTpfDWtJahRfye+JIULkvYLwdBXRRa/ipA985FVAXMVCJbJ
 v6B8LCc4BEnXTpLEIXIMnJiJc9KUlPGiHx+N6lReqBmQ3wKdpniKcVaVH/aP0E
X-Received: by 2002:a17:903:b0b:b0:2c2:1e6c:450f with SMTP id
 d9443c01a7336-2c21e6c46c8mr104094375ad.10.1780909599944; 
 Mon, 08 Jun 2026 02:06:39 -0700 (PDT)
X-Received: by 2002:a17:903:b0b:b0:2c2:1e6c:450f with SMTP id
 d9443c01a7336-2c21e6c46c8mr104093945ad.10.1780909599469; 
 Mon, 08 Jun 2026 02:06:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:06:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Mon, 08 Jun 2026 14:36:27 +0530
Message-Id: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOGJmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDMwML3eK8xPSk/PwS3ZQ0kySzRHPLRAMLMyWg8oKi1LTMCrBR0bG1tQB
 D615TWgAAAA==
X-Change-ID: 20260608-snagboot-df4b6a79a086
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=2843;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ZwLOgBSQdYVuBDlSvp37ScU+0juwCtBUje2rt6EX66A=;
 b=ECkd6ZZ7dFQ67lSipPRrebRz/qkTYIJp+Z4Y22W8gQGH+gRM2hxAfPzL+PtNgtaRvLqa2UQWG
 HvqDq+XulmrC2aTezj6QWj7XUeXArwOmK7YXJKGSp6j96l1fKNphyLy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: EpkjrxU7pwGYAg0Tkxt1r6GCj2ahWLeb
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a268620 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=I9hHxJcSqu-gFNd0hVMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX/ZDxhFX6TW31
 bgEJo0YPz07xMatgp5hAiUHdY3UEJ++/LY0dn2SRtoKIcUvVy15tJ+x6oxPitjgqroao2j0qOrk
 ZHD0RGl57fiEXD44xZ/FscNgW4MsvSBdFT9i0TluE+3bj672M9F8CqclaRm/rVpyucCPeKh/+NZ
 EPrFvIcrm087btU5uHJseAHljXyv7DiQQoAhHuHcWMoZsp0BTCrNAEnvsN/ea34c8tYghq4njxU
 1CVXIAi9VKrVjEfgy457mUK+NtEfc3mOi2ghMxwrvxkTJNh21LPiFrhY4nQT4zr/IDfJUMVZ1H1
 A6bWHBRvJdmNnGixk9p+UmvOh1PqwOmpMN7ilm/cr98K2CsiKXSXwFKvWejVxzV/B1/0PCXnBe7
 Aqha0tuqpaDayq3pTfA8yl8wjKjJNwtiZzKik2v13px7TA6EhaYpoSGwK5tWyuEdHFbDlzoZaEA
 b1sJjLIqV4UNGHWBsPw==
X-Proofpoint-GUID: EpkjrxU7pwGYAg0Tkxt1r6GCj2ahWLeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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

In snagboot mode, XBL loads U-Boot directly without initializing
PSCI firmware or populating the Command DB. U-Boot then enters
fastboot immediately, enabling partition flashing for manufacturing
and recovery use cases.

Patch 1 changes SYSRESET_PSCI from 'select' to 'imply' so it can
be disabled on platforms where PSCI firmware is unavailable.

Patch 2 guards show_psci_version() and qcom_psci_fixup() with
CONFIG_ARM_SMCCC to prevent build failures when SMCCC is disabled.

Patch 3 disables the MMU and invalidates TLBs at the earliest entry
point to clear stale page tables left by previous bootloader
before U-Boot sets up its own MMU.

Patch 4 adds QCOM_COMMAND_DB_OPTIONAL to allow the CMD DB driver to
bind successfully when CMD DB data is not populated by XBL, logging
a warning instead of failing.

Patch 5 adds qcom_lemans_snagboot_defconfig for Lemans-EVK, based
on qcom_defconfig with snagboot-specific settings: SCSI-backed
environment, optional CMD DB, PSCI reset disabled, and a bootcmd
that auto-enters fastboot over USB with zero boot delay.

Patch 6 adds the new defconfig to the ARM SNAPDRAGON section in
MAINTAINERS.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      soc: qcom: cmd-db: Allow boot without CMD DB data
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      MAINTAINERS: add qcom_lemans_snagboot_defconfig to ARM SNAPDRAGON

 MAINTAINERS                                   |  1 +
 arch/arm/Kconfig                              |  2 +-
 arch/arm/mach-snapdragon/board.c              | 14 ++++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h | 46 +++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig        | 49 +++++++++++++++++++++++++++
 drivers/soc/qcom/Kconfig                      | 16 +++++++++
 drivers/soc/qcom/cmd-db.c                     | 10 ++++++
 7 files changed, 137 insertions(+), 1 deletion(-)
---
base-commit: 26fe27b4eaddcf73e4472368a71703a68e2f67d9
change-id: 20260608-snagboot-df4b6a79a086

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

