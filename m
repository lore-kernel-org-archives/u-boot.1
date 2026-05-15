Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FAACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE9F846A7;
	Fri, 15 May 2026 15:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QVSsNIWR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbkTgBSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4DB846A7; Fri, 15 May 2026 15:09:46 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322F38464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBUdah3797373
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+J+INwTeswAdg7vvqdhO8/bOz0jmUFFiyy+
 04wRINwM=; b=QVSsNIWRywiMrTK8jUfYXX+mTbkp5Z8tdrHQ3aWSuVdB2EaqJ7m
 468pdtRrTNET/2f8cqsOcvGcE54Nqkrcno4zkoo8GjBBg/JHZjaiypQNn6FnHRiE
 8KyAicCwHh4HnTQl6nJrQF610nQqd/kq8cYKo/p5fj7ErmoH6OXKEc2ctqPlCAsR
 WMNY09mjI/cItsZOrH35Y9gM9oZjbbALkcZ9NpJCXCNWI0uWQDfkKtEoE/F9FemK
 3JgOiIvApliX2OpANgZwHPvLXECdj8P2e7pEDBeHbxYVR9wigO+JEkB0JPRrN3KR
 p4h5F+z/SucvwEhGAQxSy3/7KlNbC53dvxg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sua26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:09:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83836443305so5258240b3a.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778850581; x=1779455381; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+J+INwTeswAdg7vvqdhO8/bOz0jmUFFiyy+04wRINwM=;
 b=hbkTgBSlpfRCOHaHpx9laIdU8ny1o9BKtF6DlvpHDZANYxTWeYlYKZs4t9FRR2EFR0
 p8nJlYmHR05r4kiPP6wW8AyeGT0wukpJUyYTXO560m6+gJk2HwaeIaju/8ePAUh9frzr
 0wqKapTXiPG4vTnnmqC4RwiZHw3rpXehZxwPyhqYJ/MrCJ9iRdhnemo51mMSqdjndUFt
 1vKQCTqgeKleFYqlKTcX4NPtJoBAl+aCvhl3kRMh22a0ZgfN5xDlMI6yBuTICxYgLXuD
 t7NQqkmAPcocdbf1NcwcM5CZ3Lm3xvjh8f+I3/WKTMj9+bPMvjH8cOXqOKAMEUCD2blS
 O52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850581; x=1779455381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+J+INwTeswAdg7vvqdhO8/bOz0jmUFFiyy+04wRINwM=;
 b=CKyhgiV+t9sOOKBBZFRvjOm5CAlSI3y7GEXbqytZv0/xtQLzXDKoLd7v+4Iwivsi4S
 lFG5U8RJFD3vj2l7310XnzfnDoEzq0t0WKiI8IXCqNc+rO8V2YKvNeKO+ozvNGnlpqm7
 9e7KMVraaOCYkwfjpkWCvIkqfXbSaUgRIX+dH/uLOk6YZCzrxgbLDrqhxUyY8Y1EcVeN
 d2fgf37DvYFT38jyHeQBVHe23v2zQ6vM0P38KlUX1NVVXQDsokT9gZumRj4Ah/gd03jK
 7zyHcuxXKo5LpDzFBynvgCAdjVrzMbfB11nFGTG3s9NfNaz2BDhUs4eBGC6cc4SdIqeF
 xfXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8V+BECRvDiXosw67ngdVaaKWlHqJ+o6V/h7AVPNreYrWOSC/BU2R6dPZKJVLikUNwzrvRiL2s=@lists.denx.de
X-Gm-Message-State: AOJu0YxgwSW8UafeY8cBmnr6MEsiEjyNnRjzf0SXs526yHX+WKOBtjwt
 3sGPcRudEw2FXKXeyMSxTtsCTrYSlSzdmzDR8devkG8CwQch/bTkrWGRxCjgEwPkjvHh1KZ9nHN
 1MmU0/pmsyTMtl9QMNBqMfIjtshMPnCxPB9U1G+ZE+L92+ATT/xUefgSg
X-Gm-Gg: Acq92OFgnPQ41Fr0VPI6+tuwoV/F5m/kkYZBu0LYymir744trXIMoQB6/PyxM+s1rLc
 PdMmbgw+n3EcBAXRDFW3zWO1Qjze2JpHCtMn+mIYAGRLaK3ObPJvXnCETNDQKd/HT4abZ7k22bg
 PrP25O6Ch6S7lCCY6jWwYBJkOpXMFwJdnKEUEOP5xyT2S0wsBOGuff30lRgR+85qu59lYKQ4zJq
 Hl0BmlMHhWF5HacNF5tiLQmB7ce2dRIXVIebUnandCf3WFW63VGyI7+JlvLYjyADsjbsLntF/Bi
 dl+xU5APTWjFe5t2QmS9bb8FQaK18KlblbOG0C4inRrQLBVfSPkBuZJbNc8D89HT7yxC/g+yVvx
 eU6nCN1N6WZOINUN7sy/41XZmOtsqDoN2JSiec5nw5qsYjZ2MnuKxpJmWuWnqdutUmW1b3ua++S
 DPY+UcYSjpRn2Nh58BHEErtA8Xq2F67mOZch2p1oWZ
X-Received: by 2002:a05:6a00:4094:b0:82d:29f:d003 with SMTP id
 d2e1a72fcca58-83f33bf6a49mr5276464b3a.12.1778850581236; 
 Fri, 15 May 2026 06:09:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:4094:b0:82d:29f:d003 with SMTP id
 d2e1a72fcca58-83f33bf6a49mr5276419b3a.12.1778850580645; 
 Fri, 15 May 2026 06:09:40 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c045sm7493640b3a.37.2026.05.15.06.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:09:40 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3] mach-snapdragon: Add early EL2 hypervisor switch support
Date: Fri, 15 May 2026 18:39:34 +0530
Message-Id: <20260515130934.388894-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzMyBTYWx0ZWRfX5eTLnF8azDsO
 KXbcMTcvWCRHhUUzsP0udaaWIKhMDUq3JXkHfqJhYc5JxQ67x2YJgk9TOBH1zQmJroBrMuGuWrl
 2ZCAClfK893EltsOXppmBEPV89nGZQPrXln2kfshPv99c/tCZgYsEIQ6bzFV005ODfCOWoM2sne
 kOugVLxWc3tWj8cbEbW7oOdDJ65tcRCgiFGkRMZfnNR9bbMmjfJEimLZrsCpufVU//rm2h1j8GY
 /Wga+1ewqaHca/wL1reprV47vGXSH4U0yAXDFAkqhHTQYMBQJjTGpd7zw3BcXJ1ee2+qUUZ44fg
 vYy7z9FHqNJZDLJzCaUb+T52ir/WKSLnbmiLLm7Ib+SWpr4ic7oBraLIlWPJ8HUoZ+bwTOBcN2Y
 VHpPFOLl3/FcwevBP6o2s37q52GOLDwNldOejEWCQp0p954zd9O/4lLKM2/YD2N2KByMKhRhBXK
 pDCAJ6fYdQPZoXs54aw==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a071b16 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aHHwf1IshyYoWWdMeKcA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 8sFHgs4yw8rxUDFNCyGR73pR-4e3a3I5
X-Proofpoint-ORIG-GUID: 8sFHgs4yw8rxUDFNCyGR73pR-4e3a3I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150133
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

Add support for exiting Gunyah hypervisor and switching to EL2 during
early boot. This is required for platforms that boot U-Boot in a
hypervisor guest environment where U-Boot needs to run at EL2 to
enable other hypervisors like KVM.

The switch is performed via TrustZone SMC call before EL register
configuration in start.S. The implementation:

- Checks current exception level and only executes at EL1
- Uses TrustZone SMC to exit Gunyah and transition to EL2
- Integrates with existing boot0.h workaround infrastructure

A new Kconfig option CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT enables this
functionality.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Change in v3:
- Corrected the logic to accurately detect the current Exception Level (EL)
  and fuction properly when U-Boot enters either EL2 or EL1.

Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/

Change in v2:
- EL2 switch is made at early stage instead of doing at the very last stage in
  the previous version
- This change is based on the patch [1]

[1] https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/

Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/
---
 arch/arm/mach-snapdragon/Kconfig              |  7 ++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  3 ++
 .../include/mach/gunyah_exit_boot0.h          | 35 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index f863daf6bb9..931d25c1023 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -56,6 +56,13 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
 	help
 	  Select this if you are building U-Boot proper for an msm8916 board that
 	  uses the buggy PSCI implementation.
+
+config QCOM_EL2_GUNYAH_EXIT_SUPPORT
+	bool "Enable early EL2 switch by exiting Gunyah"
+	help
+	  Exit Gunyah hypervisor and switch to EL2 during early boot. This must
+	  happen before EL register configuration in start.S so that U-Boot can
+	  run properly at EL2.
 endchoice
 
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b3c76d6d97d..032a9fbdb12 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -1,9 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
+
 #if defined(CONFIG_SPL_BUILD)
 	b	reset
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
+#include "gunyah_exit_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
new file mode 100644
index 00000000000..5c5bd3b6691
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Early Gunyah Hypervisor Exit
+ *
+ * Exit Gunyah hypervisor and switch to EL2 during early boot. This must
+ * happen before EL register configuration in start.S so that U-Boot can
+ * run properly at EL2.
+ */
+
+#include <asm/macro.h>
+#include <linux/arm-smccc.h>
+
+/* TrustZone SMC IDs for hypervisor configuration */
+#define TZ_EL2_SWITCH_SMC_ID			0x02000121
+#define TZ_EL2_SWITCH_PARAM_ID			0x00000023
+#define TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH	0x1
+
+	/* Only perform hypervisor switch if we're at EL1 */
+	switch_el x9, 3f, 2f, 1f
+
+	/* Save FDT address before we modify x0 */
+1:	mov	x9, x0
+
+	/* Switch to EL2 (exit Gunyah) */
+	ldr	w0, =TZ_EL2_SWITCH_SMC_ID
+	ldr	w1, =TZ_EL2_SWITCH_PARAM_ID
+	mov	w2, wzr
+	mov	w3, wzr
+	ldr	w4, =TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH
+	smc	#0
+
+	/* Restore FDT address */
+	mov	x0, x9
+2:
+3:	b	reset
-- 
2.34.1

