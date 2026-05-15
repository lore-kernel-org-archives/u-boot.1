Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE2CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 06:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1998D838BB;
	Fri, 15 May 2026 08:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSRWEUzN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K80xq2rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F229783AA9; Fri, 15 May 2026 08:56:52 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F2338341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F53HUN3219660
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4VzHcYmFkw0vpvxofLuDWDBKUFTcl9xCKoY
 KT0SNKnE=; b=cSRWEUzNATzQD6jmlq0BecixNCoLxry2kG9fUyJH7BkqCgo+Ee0
 q/8ZhZpCEqfdkdWQ5ZVSc/G0rXfN1iR2e8TVUIcX/dx/POZAcF5+akZkVm1YzD1Z
 jjc53rzQ0HeIVaGXHEYS92USCutDTXJWyD3sOcjcQmLJc/PoNu2Bb6YSfGZvZhUW
 /6nYHsethstahBldYh7dWPHumPSst6FLNaKmdOVPdzMoX5FP03ba05FuXBY/nQA8
 RMDn/rzr6pDgvDkr3vBpxtmUQ0ezn7f8139s0pMEErXpcxWIpjb5X/srMM2OwX6N
 k4FWbZJrckPuJ2cXoLo+Uw18oNRVIwF2JYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s20ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:56:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365ff2ab7beso636585a91.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 23:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778828208; x=1779433008; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4VzHcYmFkw0vpvxofLuDWDBKUFTcl9xCKoYKT0SNKnE=;
 b=K80xq2rwwNjr3VB3UlaT0kjis5EnxtP+m0dPcHbjEXhNsLeglh2KocfKDyJ4g0eP2M
 +ZB+BsdR+hX3zm7OQO8LJm4jIOQFm9vdNMiamnE2ijAYK20x4B6pJF+bN98ijBpJytcA
 XRVlz2YZ3CIw/FY39SgTjTPZjbdF1udCQ3428fzjvceLzQ4jxfoOx7feLzwws8kzHe8H
 KRVzgEEYs11WqW98CFItuY46VdKdSvPUD0gMTgohmDZTt4ssjHD98quNe09d63CoMDc5
 YLe8rx+z5K1KgLGuSubb7gGrXy155ciRjBVYECSw5mKspSnUNmaNQpTuG3JjANxh1NPD
 rCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778828208; x=1779433008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VzHcYmFkw0vpvxofLuDWDBKUFTcl9xCKoYKT0SNKnE=;
 b=svR/yAzwIehLRsloL1OysTSkUDd2SbT+0sc2x8xutouNFpQIok3XKXAOmKcGhNnu18
 mMq4V2/1z4fDeopmz4QyoexF4k4Bnns8I3d8lZn/utnf180l4IV1G7J5sBkpZe4adk72
 FX5zHEsarAnwVx/IA28HEmbvHEsuo35P9Y+ZQBrWaadXhuCROYYbQ4dez6IGBihQoJZ5
 lfy5BJ40ivy+YPZ3JJXvbG2D9QnkUyhl1B+UFs5T6N6v2evBvAJ7R8wzwsgC8EX3R4UL
 6ebi1ysOedpDDsR0ytro937cHZKgmEPMH9vZ0ONku27xdZrFZaQX26aE2iXff/lm6HAc
 S8hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+k7FminR2woFvPwdECudP64bKC3qQAsJNQ9hBwNyrFg2hexApdBTVKkVAWuwkYqZ5y9Zy5GX8=@lists.denx.de
X-Gm-Message-State: AOJu0YyB7uWbd7B2iq+oa/MQ8tUOU0DR22zdHvV8g/udRGthcIbu9c0j
 r2nZxB/fFOLYg6t2kggZMwqavBCtUaAwPACmRbGcf6fBU78AhtzpNUDp9+0Mk1U9fgw4sFAVOXA
 OBr7RVGINbFUkgm3TtcmZzwNCayoFXbj4SeJQDL4RBWu+eORbI0w/nDr5
X-Gm-Gg: Acq92OGy5Hx9TCyZVr9ovgyYLf/qnK9602Oxds8UkVeCHGxHO5Xdjsdz+/T3hV7+F+x
 sSwe7Bq4sG+5WF7jEoGC9pftUW8IFobmGPB4ZRogUYLhCDcLn/kpwPLbvgUo/khXE8O5pbjZAB0
 WXXFmFYx0h+AA+VXaiJ71lT21LIJoO64BY78R1zrvSH8WXfApiiCwfOYCErsbnqfdd/GFQ62/iT
 hHK3OJU5cgsnXPfjpsocyt94G/mYPASTougtKSVwXcKN+JrSHhf0f+Xr/XfAo+D4VkkqybKtUNt
 KJz1V5V75P3aA2O0Xl5kSGIs8bXfmnSiySAMgXN82Tx7OLATMdPj5v3RH9inUG6qVGDSHT9D5QJ
 T9s2KbmjbCKhRLoTWpq8NEbrrtncxhNtQlFce2UJPBzR6Oxy4oOQg2g79NN4o2aFUZ6M2A58IPg
 4iLC016s5klZY9J3pk1/oVOxMKUnKtk9Eea3lV9tYt
X-Received: by 2002:a17:90a:a78d:b0:369:277b:38de with SMTP id
 98e67ed59e1d1-369277b3eb9mr3936178a91.18.1778828207602; 
 Thu, 14 May 2026 23:56:47 -0700 (PDT)
X-Received: by 2002:a17:90a:a78d:b0:369:277b:38de with SMTP id
 98e67ed59e1d1-369277b3eb9mr3936163a91.18.1778828207101; 
 Thu, 14 May 2026 23:56:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695126fc8asm1739674a91.7.2026.05.14.23.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 23:56:46 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, Michael.Srba@seznam.cz, sjg@chromium.org,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2] mach-snapdragon: Add early EL2 hypervisor switch support
Date: Fri, 15 May 2026 12:26:32 +0530
Message-Id: <20260515065632.90772-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2OCBTYWx0ZWRfXyhdEwAyLanbg
 r7C/cGDClvZ3M45+Bq7xYq91VS2Woxelg8ADAJ/GVDXzdmdBKgbdpe8RwS1VoTVVM3Lenc6hDiw
 heO3nt6O5CWsM5kwpCAG6ma5gupnb4EU/Kb5Ke4XiJFtqjpZNvReWcPssZ6RGE6/6A0zCpe0Dk5
 fd8EM0pkP3hbbTovGGn22s3oZ/KXNmK0fqJRAgrTvLR3GHtXvTU+EbVrIvwIcvuEB8B5RO8vEwX
 7cQkW+CaqPM+iXq2UlQ1x5eJd/I9s8HQL+cXJJYyrG5i58S2OA5pxh5n0Kzvl7mSjD7eKoAFlO3
 5YJpX4OR7sxfES42jBPZ6g0vpPS/nNvcQxGYkefvHVDVvH0pEK37bsTez863A6eDXFAlErdpsiT
 beu8Ij/JFWQrUAwWQ5lbiQkGIE6j8Mq0nEsLz7G/KLXyL8eEkR+/7kqIA4pSxprRuYhesTGIVy4
 J6ek+z91037uUsFAoTg==
X-Proofpoint-GUID: FK-g21sS4DU94W3Ox0fVFM9eAmQztYyP
X-Proofpoint-ORIG-GUID: FK-g21sS4DU94W3Ox0fVFM9eAmQztYyP
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a06c3b0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Il_tCLDDmL0aIamoW0IA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150068
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
- Integrates with existing boot0.h infrastructure

A new Kconfig option CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT enables this
functionality.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Change in v2:
- EL2 switch is made at early stage instead of doing at the very last stage in
  the previous version
- This change is based on the patch [1]

[1] https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/

Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/
---
 arch/arm/mach-snapdragon/Kconfig              |  7 ++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  3 ++
 .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
 3 files changed, 46 insertions(+)
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
index 00000000000..f69678018ea
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Early Gunyah Hypervisor Exit
+ *
+ * Exit Gunyah hypervisor and switch to EL2 during early boot. This must
+ * happen before EL register configuration in start.S so that U-Boot can
+ * run properly at EL2.
+ */
+
+#include <linux/arm-smccc.h>
+
+/* TrustZone SMC IDs for hypervisor configuration */
+#define TZ_EL2_SWITCH_SMC_ID			0x02000121
+#define TZ_EL2_SWITCH_PARAM_ID			0x00000023
+#define TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH	0x1
+
+	/* Save FDT address before we modify x0 */
+	mov	x9, x0
+
+	/* Only perform hypervisor switch if we're at EL1 */
+	mrs	x0, CurrentEL
+	cmp	x0, #(1 << 2)
+	bne	1f
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
+1:
+	b	reset
-- 
2.34.1

