Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77293EF4ECA
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 10:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDC984020;
	Mon,  6 Apr 2026 12:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KpU9WXcJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5MT14w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B80E80433; Mon,  6 Apr 2026 12:55:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D05983E7A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 12:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6369D7Mc2554003
 for <u-boot@lists.denx.de>; Mon, 6 Apr 2026 10:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hSMTZxhGxQckeElygpuCDWB2U4pc3Izg1RI9pFyGW9M=; b=KpU9WXcJY41zvgg+
 1eXxXgR8WMURdUqepdW+lIwIAMzhjGXO/ApiaON1A5PRF2Lh52odRvvAiJ2m3gsY
 q/3Rc3enVQg3OI7B2ttY1QfZT43nqLVrYdD4GvnkwVBsGkTAhGNYlUm1UbygROv/
 G+XCUN8r2/WjLMOIh91IFywWhXHMB8LQ2wjxnTB6P3x3prXZBYSUp0tSL8r+zywA
 2uftXTagukNEHjwhEA2tSvo08k15SRrLQNG4dnsvQvz3HmPRPIe3hS6hjXPeQmUP
 D+sKOteOh8pCOHjyYxvFkTJGWEHCBmhE9tZRiglq+FtrKDZr8yomjppvWz3IjXC1
 KhVKjw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mn1x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:55:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c613194caso2384511b3a.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775472947; x=1776077747; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hSMTZxhGxQckeElygpuCDWB2U4pc3Izg1RI9pFyGW9M=;
 b=P5MT14w5wfj/eo7j5UtfNwDWG7vVoZFMRS0OCt+Y2f9oRiBCdYB9+IQ3lddKyLVOUM
 /yyhr5Y1xBvpmqsD3QtSocrc8H9Y+hVWkD4JBoWeNT7EVqhJruKk1lJEErR8LR/b6YQE
 JaJ8GeIbgGKZmdoinZtA7yq3CfeVoANg8LNUi91csS38XG40ANGCMOz4EyaiVAURZoyI
 L+k0I+qhvay7s0gYZyiHc7h/RtnHSWRD7amxJDNJNxB6m/AuHiTbOf4/YK5x0uJxGQuJ
 5QQcZXFTw8QrjpnbPgLO70ozPlZf47lgMFIqNnoebfJor9gdHLx4VmUHwJmRAvD42L7Z
 sWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775472947; x=1776077747;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hSMTZxhGxQckeElygpuCDWB2U4pc3Izg1RI9pFyGW9M=;
 b=if1Nl5Rc+j2KJiQXVSFXyIYtxurp5czRRAC8MhasYzJcqoVjiLQqmEtNqduubMrFms
 XIceNXOUWqTNw7xUuz+zc6rBCOEBEnPPV1V/mXNXqa0MvpLSi38auHiE6KQRgfHwZSJy
 RaLYtuSP/DzdGt4ZmnWyBKZ7tTQDpNMjW5D0qbztmxgqa2Lt5Z4BsVFtDESk+rq+x9rU
 RxjbrF3SEVL6aLNTfcPtMcXYSqte7rYBb/iWJqyOOpCh1IQSVzLzVLsiVYPO8XtD5V+7
 O3+6d6rUxrRP9dBH3dvQjaRA89+97+e4S+TCI+mC7hL9YPdn+KVHZjRCxSxUX+3y+kD6
 GTXA==
X-Gm-Message-State: AOJu0YyDrzclxcqUK3yrEkvuXIn8IjFOkpUyDxdzlohLCopgt2zqxTUP
 AZPPIPYjXOYsy4o3CYs8YjwHz1Dn9Nn9uv/1r8TW/UnUVmVKbw9a3h40wtScTOPs26OGrElHmmS
 50kpYMkW3sLSn/OHyWBN1uX4lL/+uSbGOWnRGV07GUS5oRyJUkjtxIL5p
X-Gm-Gg: AeBDiesW0wb8Ey/iu8khHIfowcTmueS8xc2a903joinGfpqr/Q0N79WCQLz3by9TG7l
 jo/iHwIziNawSdByAZhA/iKOj+Eeqa8PxvstPzhe2S+RvPaNFZk/HuymDd0uy++W7YadBNsaBTg
 OC/aSbReBoZk6W8c+CpfCivosZOQbKVIYnoHnw6FLtZp2QSvNYMExMUv1Dw5WdVawffO6EL04sa
 39IWc6g9GU5Omwqd4NCdt+fMPgKDYiwJSN/ZpDIxrUpLu+QH+4ra4ZBwkVEBwqKvE79NNREp77n
 dLqaCe2hxuD7bBq4atfgZxrEUhkDHmjOoyRzTYz8dlegC5WbL22OOY7GERTO6rfRTcpl6u738sx
 N2++/D1wkl3cco1OtkKyT34ZaS9XTyWYwb1Y0Qb10wDtP/OZtAHEvm9eie/Sf3zDHL4HIUMdToQ
 EyJ+HEwHAyX7iXgFXL0RG1W9S/oqMQDPxIAPyliALMvN6UWgk2Uw==
X-Received: by 2002:a05:6a00:92a5:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-82d0db71be2mr11250639b3a.33.1775472947166; 
 Mon, 06 Apr 2026 03:55:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:92a5:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-82d0db71be2mr11250619b3a.33.1775472946669; 
 Mon, 06 Apr 2026 03:55:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3baffsm14128816b3a.14.2026.04.06.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 03:55:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 06 Apr 2026 16:25:36 +0530
Subject: [PATCH 1/2] armv8: timer: Add option to use virtual counter at EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-timer-v1-1-f7c5a290c459@oss.qualcomm.com>
References: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
In-Reply-To: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775472938; l=3029;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=mo7N4tK3Fu1vI4NE1Max2qxM1n9s5RUlS7mqWbgFkbA=;
 b=ALFUs+I96+GgN3XowKrup67XBEFyRNRR5nY9tiN4gHhAEPzflbNfzuRdBFWXmGCbtu5fHqQ44
 LZr56hbtpsGDbtne+DUH/Z2J1C1M+dfiXOUi//9eMaUBL2l5nJ2nQRt
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: kk1LgAdw7q-zImIdoObGvDHcdHemqOR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEwNiBTYWx0ZWRfXyEpBL0LeXlYp
 3jtveldPON6ByFFWo1FOVckrVcX7ghGschxpiJbCP1YRBcqWwDh1SMKGRG4Px22W63604WBi2fQ
 29kFmVGz41MSqrFeggnn56BDIpnJ3sYtuoZFme63xVpRYCB2my7JrF8V4+3Id7Kbof/U0rZoGWv
 CCqXeZpxhTx07az3Mv48r6C88SSdVi0bE/V5qoY6Zd1S+3ej1l1WDKKM2pzAAUrsvEbgWlOHB5S
 SIWhkovUWd3H1vDAa5V80eRMSi71hTxz8wZCIUFvWOKCx8TwW9BfnUr6OUX9O6DG24PQNN3THe9
 lHTnTcTBCJ0V8UINl43rTHLCIQnVW+ZICams+J4OeapCLLEkV4FFKZVNygOsN4wK8IiaZfdjckS
 GltIRw5ovk8YpwsCkSpknlBaqXmxB261m+y0mpcQfweku5WfsuEEtfNxXlZQgw195YYYmRm9QvN
 Q2l4f0v2TUaKaJbLRIw==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d39134 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=L-uvaZSnVQ2Xq_8tjAIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: kk1LgAdw7q-zImIdoObGvDHcdHemqOR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060106
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

Add CONFIG_ARMV8_TIMER_USE_VIRTUAL_COUNTER to allow platforms to use
the virtual counter (CNTVCT_EL0) instead of the physical counter
(CNTPCT_EL0) when running at EL1.

This addresses platforms where the hypervisor or EL2 firmware does
not configure CNTHCTL_EL2.EL1PCTEN, causing EL1 access to CNTPCT_EL0
to trap. The virtual counter is typically accessible without trapping
and provides equivalent functionality when CNTVOFF_EL2 is zero, as is
typical in bootloader environments.

The new Kconfig option is disabled by default to maintain existing
behavior on platforms where physical counter access works correctly.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/cpu/armv8/Kconfig         | 19 +++++++++++++++++++
 arch/arm/cpu/armv8/generic_timer.c | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index dfc4ce851c3..00c7303e09d 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -12,6 +12,25 @@ config ARMV8_CNTFRQ_BROKEN
 	  does not set the CNTFRQ_EL0 frequency, and its not possible to
 	  set it from U-Boot either.
 
+config ARMV8_TIMER_USE_VIRTUAL_COUNTER
+	bool "Use virtual counter (CNTVCT_EL0) at EL1"
+	depends on SYS_ARCH_TIMER
+	help
+	  Say Y here if the platform's hypervisor/EL2 firmware does not
+	  configure CNTHCTL_EL2.EL1PCTEN to allow EL1 access to the physical
+	  counter (CNTPCT_EL0), causing traps when attempting to read it.
+
+	  This option makes the generic timer use the virtual counter
+	  (CNTVCT_EL0) when running at EL1, which is typically accessible
+	  without trapping.
+
+	  This is a workaround for platforms where the EL2 firmware cannot
+	  properly configure CNTHCTL_EL2. In most cases, the
+	  virtual counter provides equivalent functionality since CNTVOFF_EL2
+	  is typically zero in bootloader environments.
+
+	  If unsure, say N.
+
 config ARMV8_SPL_EXCEPTION_VECTORS
 	bool "Install crash dump exception vectors"
 	depends on SPL
diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 744ab3b91e5..6dc98874504 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -86,7 +86,20 @@ unsigned long notrace timer_read_counter(void)
 	unsigned long cntpct;
 
 	isb();
+
+#ifdef CONFIG_ARMV8_TIMER_USE_VIRTUAL_COUNTER
+	/*
+	 * Use virtual counter (CNTVCT_EL0) at EL1 if configured.
+	 * This is a workaround for platforms where the hypervisor/EL2 firmware
+	 * does not configure CNTHCTL_EL2.EL1PCTEN, causing EL1 access to
+	 * CNTPCT_EL0 to trap. The virtual counter is typically accessible
+	 * without trapping and provides equivalent functionality when
+	 * CNTVOFF_EL2 is zero (as is typical in bootloader environments).
+	 */
+	asm volatile("mrs %0, cntvct_el0" : "=r" (cntpct));
+#else
 	asm volatile("mrs %0, cntpct_el0" : "=r" (cntpct));
+#endif
 
 	return cntpct;
 }

-- 
2.34.1

