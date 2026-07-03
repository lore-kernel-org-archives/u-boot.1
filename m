Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17072C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 17:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520C684A76;
	Fri,  3 Jul 2026 19:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSQEbUaO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JtThJuql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E7184A8D; Fri,  3 Jul 2026 19:26:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12D484A76
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 19:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInTj476535
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 17:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2LnlGSDHcCx
 /geMyHcsPmiYKH6bDqhJrhf04NHTazoo=; b=QSQEbUaOXkwS8OSR9dZKoEEBuEk
 iroebc56IIZI4dugvkTQe+50T6J4S4nTmtyYczijd1rU8GrppHxGUasFNvoVIeqR
 AUNy/O7B38Si/Ytwnse4oHqMC4xdc0ul4xREGSXSCmPCqtrTCn5nrN+DxRhTAIGK
 owrlcPMPcPAzykeVkfceXLhqizyZiuewyMy31VIXbPAoANLFKHOgcVg2F/IRQb3t
 oMrbVTTRZ2FRnzU8juFYGZsDtyQA9nH9gdkeuDK3DbHCxAmhgn/S8/yTbFaGcmVt
 seoOegYxYji/ns/aQhNpAFgwzsy5hMvrGs9pffYhSqtx9hYpjRm3e320pwg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyc36d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 17:26:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so160441a12.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099613; x=1783704413; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2LnlGSDHcCx/geMyHcsPmiYKH6bDqhJrhf04NHTazoo=;
 b=JtThJuqlv2+emr5+w2vHXSgD5ZZjA7fkg6ehDoELq+pv9hv0rJA1w5bwp1G9mFV8wn
 6z/zV1NY07064SpWQEUavqZ8e9J05FLC6QDESTGVewOAeMKbb1cZXOO7+vSGctLvPn14
 rkCq0neFZDl+/sowV4Ct5CpCyeeUGzKx/DT7HibqFijDb/3vUHgUjl2iisTJ+/W/R9B3
 tIcWjeZd/UxVMt3pqYq0J9P8C7HNDltU+vZ73Z/qFYaKndGQD49hKC5iemfON76PRmxH
 Dwrrkb2WcXI/QnVdsAp8ehRZBvW9sxC7pH3rT+QsZK/bNv2OrvYFxrdWdzBUawVUSSD8
 yx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099613; x=1783704413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2LnlGSDHcCx/geMyHcsPmiYKH6bDqhJrhf04NHTazoo=;
 b=D72j6Bxg1fSks0Skq7mUReFsnOHCs89ycxkCAok/gJYunp2q1OPynTfgnA1JBmHdqR
 YpFoo0XayKnYCfDP8fmuvME6vfuT2F8MawfXd2u9bSJYmnE4xCqSPaeXdT26HlH7KxwY
 wpSyFbVEAs8E7Nak/r8F6UCbOUrZ1OmJUmeq7k6bxF+zHP4y4OZRy7+r3BAdo/LVgtXd
 E9ka8mLqD6yj8b9uV2qY1yoG3FTbEe8dHKNIb3G054N2p7KlLkCRPCPLi6B3jZlp5fCo
 0wWR/u/BE5OA16Yy8n/L+g/GHRzLNEo9mT+VoxzMmek6wsFdJ0ZgdjM9XTq10awf7+Ni
 0h7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VBg3r8YiEe8SpToyW/4UyrIgcwJhrs9UlPXy1H2jogTRorU908qDn/OCTLm/ByAgXUSE1OLs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywk1G9MTSHu9gejhxH/K5z+LJG++5JU29l2JRukIjq3oZTlodmw
 qbP5E7qnyL8MFqCrE9dZPjtp9YP9kUjc1OBTLbkMoCc1Vrja8WE0PqgQOgPHdjEDxe2Sv1ZZo6d
 LT1TqY5EYjnrQnwb4OjTEsGylAAJoSJkp1gxVmkpW81/mhsvZn4HUfh7F
X-Gm-Gg: AfdE7clXvJsv6z+cjK5c5qlussVtP1sai/pMBPFczug+5mYd8rvhbc5B8Yk1t1apt1A
 /ib40t5VV59i63cFNR7OQ/9ptcWUbGINsDfKEkM5ltFX3MPW3DLPa6lm2H1pZr9I8Z18TznTlXt
 J6lkPlXSZIH0u7vvQYFqXhzJtFtK3T2MfKTR7NCV7unOD4Eo8J1pvUZukqQP6VwAiyaD5GLuZKA
 akBEq6ERLJvSlutv31/7Kke4g5ftFgqm1WkOMf65bGtJPzeEcfadMaVFhWaoN4d64GoAxbmXK0B
 DyNfiF9zDV2u+ld+RBVPu90KD7ldzjEd4eOMemsAwTiqfysk2kOf2VRIa1qSVJzrYdnb1up1ZXw
 3iO98gxDZ6+hoyiMAbzGKckhm5Xc6R346ezJWZYhuuuwp0TfTgV34IWobfLWwml60EwS31NY0LC
 GVR6GRuYXhfTWLpqJS6Twlxuhmtg0mtg==
X-Received: by 2002:a05:6a21:6b02:b0:3b3:21f7:15e0 with SMTP id
 adf61e73a8af0-3c01cbf1191mr5658907637.38.1783099612944; 
 Fri, 03 Jul 2026 10:26:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b02:b0:3b3:21f7:15e0 with SMTP id
 adf61e73a8af0-3c01cbf1191mr5658862637.38.1783099612296; 
 Fri, 03 Jul 2026 10:26:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b813d37sm23489561eec.10.2026.07.03.10.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 10:26:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 1/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Date: Fri,  3 Jul 2026 22:56:32 +0530
Message-Id: <20260703172634.140515-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
References: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX8P+HYfCOiS/h
 nuoOsgPPUsH/BrkSvqcATCUwfMDxK3/JniS15AD/pedTnS5SBRV6bdhQWvQC1jhINSjnj80wJY3
 00+ptQf1brUfcgN/zny8Nm4xfXdq6tKb1Al9hq3kIH3/B3Pj1PZ+mjdVVvF1yuTy72lW3h0dBl2
 PKwr1UxRyJRLYp0335c4xyIY8uPpL8wPLoMYQm+M+sUgd/ymKEa/D9sbLBiU5A0xS3EsZxMXcNf
 ur6DknklXWud17dsEh5Zi7DKybiWW9AMF223OxYwdNCLBLNy6iontHgOS5NLF9EmJMr2kACydtu
 sF9RDLSitO8+fhDMXMhVaPE9v299S9L2SPX/tiH3NQ8OFWmSaqW5qFvQ0OA0bvEMSzpgIxCvNDv
 8Zd7/cPvnowiEP4Aiam5HvIUJahppnaqBes2Ez4zH23QMRp0Ro6XEBaT9oqGx4+/XDkWyW9uOIL
 GAGl9EEzIC6Bi3UBTWQ==
X-Proofpoint-GUID: yE0fzEOnK2MeVPGsNwxg040dK9l2AmU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX9TkD++37GIol
 fJFm+nXdfkFDOmkHM1Qkbmt9jl8qieuGKvOZLMDEs/H7V4yjcPOY4u58IhwTBOY9md/cFmeAE+E
 i1QNY9y50PhQ8qet/D9D543JYDhm4zQ=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47f0de cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=aHHwf1IshyYoWWdMeKcA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: yE0fzEOnK2MeVPGsNwxg040dK9l2AmU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

Exit Gunyah hypervisor and switch to EL2 during early boot on
Qualcomm Dragonwing family platforms. This must happen before EL
register configuration in start.S so that U-Boot can run properly
at EL2 to support hypervisors requiring EL2 privilege level.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  8 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  3 ++
 .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index f863daf6bb9..3a95d7141f9 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -56,6 +56,14 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
 	help
 	  Select this if you are building U-Boot proper for an msm8916 board that
 	  uses the buggy PSCI implementation.
+
+config QCOM_EL2_GUNYAH_EXIT_SUPPORT
+	bool "Enable early EL2 switch by exiting Gunyah"
+	help
+	  Exit Gunyah hypervisor and switch to EL2 during early boot on
+	  Qualcomm Dragonwing family platforms. This must happen before EL
+	  register configuration in start.S so that U-Boot can run properly
+	  at EL2 to support hypervisors requiring EL2 privilege level.
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
index 00000000000..80b9f7effa5
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Early Gunyah Hypervisor Exit for Dragonwing Family Platforms
+ *
+ * Exit Gunyah hypervisor and switch to EL2 during early boot on Qualcomm
+ * Dragonwing family platforms. This must happen before EL register
+ * configuration in start.S so that U-Boot can run properly at EL2 to
+ * support hypervisors requiring EL2 privilege level.
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

