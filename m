Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824F1CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA30848D8;
	Tue, 16 Jun 2026 11:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MH9OBM53";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JHjOrgo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41232848DF; Tue, 16 Jun 2026 11:23:35 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3EF84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G8s61g1239710
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YHpPV9RUtHtlH4Q9Htk3QGbyQKMhus3nmkz30KmiIaE=; b=MH9OBM53qoJ/IIgT
 n77IReCNxue9xuksywHgBR37gXdH53OZKicv5OiwVtvPBQN3Ni16KCumSsUXIF6m
 GabHPNUXU0s37Gqzq9ylP/Bgc4QQSFsa6mw1KW0rmvLPrLHbemE3bSeHpB6V7fhv
 T3ZCbxhkXov9qflerA276LEiWRqUGYADqYbUIqbZa0wUGe3cSQ+zj+/VCliqogV9
 DGlYallWYfspzhnIlSxkj1Lg5Ac4q1vqwhTBIX8ZrRrjxA1oflWHyZWXsL1xMxJe
 gqK40qwB2FisjKo29gPwjS/SV5XYvxBtBXeyI2FfEG9usoA2pwGPzjVAxVrKamPk
 jDX8yg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct041q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37c648d3ab9so118173a91.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601810; x=1782206610; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YHpPV9RUtHtlH4Q9Htk3QGbyQKMhus3nmkz30KmiIaE=;
 b=JHjOrgo8qtsczJ2IBxKUVBMgBmOTS5Tc+g6NwavdEwdkbdW8TsYQbA3aK6wWUnQopg
 feqj2HPfwY/hBWthebsk1xrILCu7qHJOmSqouJCUsN4cvn10dNI6EBXQ0FBmupJkLPMp
 eunsGbi+lvx+OEAxKd029V4dSPs54qh0/fA1zA6MH9YEkbKyfOg/8/fQ5CedtuqM/JwG
 P7FMuMd9AxhNWaPT7sblrKLYiqFSLzCQwQfCCzt7ifqYEaf6hORsq4abuFt8byAo2xz6
 EgLta1S7t3S0lBdVIcbUMuD+qqUDpziwuBcQ5IOfvsotjUj2ceZ+RAb+vl1TnJu1jjHH
 GQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601810; x=1782206610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YHpPV9RUtHtlH4Q9Htk3QGbyQKMhus3nmkz30KmiIaE=;
 b=XCcqGUzuJmuPKKmUhq4QUd7bQuOjfbdvBT7qELJayahZmvHqVqjSdXeYIEJAW0rijy
 xPWqjILiuGkjt0DkA08wj7oDmKWugsUvNBwSKgSv1V+hjabdcdLxovlOJ+aLX9w8HSgx
 xQRNgd8IqRdjRmKcrOE2UYFapr1Zy4NKIY9Ha5fqFHuJWSL4Ps8u1mGOEqHPX2NnKwxN
 P4+PaVU/ViQ4p3ixY8pFyIz8R8ol6LQQX0OUJ29giAUm7RlJFtI7t5ZOk0rTe7yBUZHu
 EJRNoTfYjVmywJuiq54wwKmBG6oht2u3qSuoOBdNCrnJaROr2K1pemjjCOrKn+qjdFyj
 Ijmw==
X-Gm-Message-State: AOJu0YyQ1hZxsveQle0le8yOM8dqyqAINe8RYtfavkv3HVTLlJBl0WMD
 3fF1tRX2U5fuFhNs75Woxtfr5Gci9WmZVbqwaXB66jS32ipA0IW4dnMn5iZ8etVHRe1XbhptqeK
 mPHHLCLFanAQhUZ2qaUvFdYTgwFhpcvBMlBabOTy4Kvx9vUAquv9wX7UJ
X-Gm-Gg: Acq92OEOpyjHnD/nExrmwky+AA23ZxEphxkks5tu4J0ObuaYZIfOpbeJLwOnH01oYMo
 bsqwiCrs+bdGeluervFM58OPZP+mqzaxiIMgaGagWl3PtQrQnYcVuESzzrppyQBYj0zCHoAxC33
 00oCEnEypBIoX8irwjKgOFokpndMr5S5KuGudHqOBwBXkcgzHPdSWYJNQuVbFOYy0C1nrVu95y3
 fFeVw4UsLKtZF1ya7QBTikBlOuFGbrrhGES3VSWybX+OcUJk26sc451g+EzVb6ZzyX/zMpdz7RH
 eX6yKlzXFQJnyk2Lh3amxmfZjfLvZlPr6WLifYse4JUwjX8fzh47oeaZ0kBIlAyq2YypS8VAYUr
 IwJWHt/8fWMvRALTZyhR6kO66AcXCp1VQO+gorWnVUZqZbHmPX9aFb3SH/fWcTem/ifgbVCm6qB
 uQ/mglerY4L4icXG8DHmwKHWAjkUWGI6dMMouFnE9Eaac5TzPxGQ==
X-Received: by 2002:a17:90b:274b:b0:36d:8bb4:4640 with SMTP id
 98e67ed59e1d1-37c529088bcmr2972954a91.19.1781601810024; 
 Tue, 16 Jun 2026 02:23:30 -0700 (PDT)
X-Received: by 2002:a17:90b:274b:b0:36d:8bb4:4640 with SMTP id
 98e67ed59e1d1-37c529088bcmr2972913a91.19.1781601809571; 
 Tue, 16 Jun 2026 02:23:29 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:54 +0530
Subject: [PATCH v3 4/6] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-4-6fb0dee8125c@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=3127;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Ln8FmMO2m1Tnk8mTAHhKCursNWAoAUErco9hJawbd2s=;
 b=KtvNAwfZmfBr6mdORZAyniP5RUM8KCMY7ltfbV9WKy75GUXHPiHK8riDmxozvXbypLbadCzZr
 jJIn+wdSTyqDiacxwkMOv+EnEKUZHdmOIBbI6WRvRBznVtfItnnmlH8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a311612 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RHAX3wZJKHXDS7NASl4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: m1JLSYs64kltZGU9FGb3T76T60DppjlL
X-Proofpoint-ORIG-GUID: m1JLSYs64kltZGU9FGb3T76T60DppjlL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX8r4nntO4M2Qv
 BvNDEaxLVh70RjJGkobx6O6U1kzLAtc92MmRFQxZMNkjhDTpMAfJHWRu3K9rJygg6rtK7cItzLq
 HrVz2dIF0aBH+S/zpMiSCgMyUj1xumoE0RXS6bEbizN1KiP5xU3v5ECDMWiyQE2ITrGJLFfcZjb
 eaPR9OaP/TUQYuh/O59FtfbgioTIsuWmUssHLa2sPi3LVWpvn13RtZMHoEHKe35dAWyUU49TukH
 mz6vBKp0DL92gd8ce7CfQqc1GduzjwyvRSLknn2KVjnQ0bCSj2rSbN/Er+qusJDdD96T/flKlT8
 yVOKa9fSunucX+iBIu0nxWxlchd5YF1wPa9yhsnOOft6sEo9QQv0iFK0/SdGpqDVGBQDQoZw7a+
 DmRO8uMIs/ymttJxct0ioVdinok40LwJsV9EWqY9Gkj8QnzREfisqodWQZa1FvFasWuhbG3F7AB
 9iy9Dp//8b/CGXPwMDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX8HgPXY2tzR8S
 pS4N946OwCvqHETUwZ1HPgU8CzRgISNVg8UyJbUvIO0i+6HZ40gvaCVvgTAmDjp/kIZg9FVdnf6
 jm6vrft7+TCwGPQZZS9+AbFDSqdbsoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160094
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

When U-Boot is loaded by XBL in snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs at the earliest entry point,
before branching to the reset vector, handling EL1, EL2, and EL3.
This ensures a clean MMU state for U-Boot initialization.

The changes in this patch are based on:
https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 53 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 032a9fbdb12..60ad15dba57 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -7,6 +7,8 @@
 #include "msm8916_boot0.h"
 #elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
 #include "gunyah_exit_boot0.h"
+#elif defined(CONFIG_QCOM_SNAGBOOT_SUPPORT)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..fb146384cba
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point. This must be done before
+ * any other U-Boot code executes. Handle all exception levels (EL1, EL2, EL3).
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* EL3? */
+	b.eq	disable_mmu_el3
+	cmp	x0, #(2 << 2)	/* EL2? */
+	b.eq	disable_mmu_el2
+
+	/* EL1 */
+	cmp	x0, #(1 << 2)	/* Confirm EL1 */
+	b.ne	reset		/* Skip MMU disable if not EL1 (e.g., EL0) */
+	mrs	x0, sctlr_el1
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	msr	sctlr_el1, x0
+	isb
+	/* Invalidate TLB for EL1 */
+	tlbi	vmalle1
+	dsb	sy
+	isb
+	b	reset
+
+disable_mmu_el3:
+	mrs	x0, sctlr_el3
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
+	msr	sctlr_el3, x0
+	isb
+	/* Invalidate entire TLB for all ELs */
+	tlbi	alle3
+	dsb	sy
+	isb
+	b	reset
+
+disable_mmu_el2:
+	mrs	x0, sctlr_el2
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	msr	sctlr_el2, x0
+	isb
+	/* Invalidate TLB for EL2 */
+	tlbi	alle2
+	dsb	sy
+	isb
+	b	reset
+

-- 
2.34.1

