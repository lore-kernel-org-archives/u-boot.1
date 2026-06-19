Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83C9CD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51028849CE;
	Fri, 19 Jun 2026 13:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTPeH/sG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dVLXbmpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635F3847C3; Fri, 19 Jun 2026 13:11:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FD0849DA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7RTm7082592
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q6MJMtxKFqT6Dq9AuiBd4KeoKYsuQuzSgnzr+Tc6Q/Q=; b=XTPeH/sGOei43amf
 ykJg+toXp0kNdD5pRbR3HpiEzSjGyPbAhPYBm2WQS+cgti/Gs/oNuDEhMXhQqZS1
 NgUPeCOeG9iIrNdNLLL+UqhwDNBqB400laU1wxYJqPaI0leyybKXDL8ZUUuTFtms
 +wQ9mU+vQYtK8TmMUAPyOmx27iZFAwRRDY+KDIfUtbpFA+Wpbe81qqNsGrL0/EFz
 6qpT/s3usNv9zMbNY/ahbfOiu34NTgPE4yZJMf8ZVr5S+XpGNDR4RvVnkF+B8CtH
 5V/8OyeC9d9hJgUd4h9KjVvYzOBlnIyHIzxSkQndvc6XqH2dwD3mMQyUT5C/a87p
 +S+nQw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtjbbp0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0b35fa876so22356535ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867466; x=1782472266; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q6MJMtxKFqT6Dq9AuiBd4KeoKYsuQuzSgnzr+Tc6Q/Q=;
 b=dVLXbmpN7hF2VHu2HYAj2x4Kh/A87qa6TsaytncrBuqvHs4xxPJuXm7kHmobMmB6eJ
 0O2jV8yZbudkzz+lTRLU5UM/3sodSWGViquMsdAK8VoXlgiHw5YPJzBcHTskvBuC13M0
 q3D2XphAcunrRdxMF2nVoaOh8HGRjCpoxkI6ymSBxXHuhtlklnfrKz4Ljxe89kFhU24X
 WnDLzGn7PJjPL/TE6Cg0tob9B4VE4zp37oF6az9px1TS3WKLQKgY3pNmPSFCdfukfrzR
 3G/yKP8FaG2yjcZ5EnegEhB63i28GS2FTPA5iqqTK3IRqwAbIUNBazI0x4MhpBWx4fnR
 OBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867466; x=1782472266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q6MJMtxKFqT6Dq9AuiBd4KeoKYsuQuzSgnzr+Tc6Q/Q=;
 b=tMon8Q1jjeKbelzAnEldWPfffMVvCj7QWWpy+PjVw137ASC4aSGJBcH0Fc/0IBaBrw
 WOOIbZpMQ4Z7tGZbxBdie8UxKozgV/9zMQa8psyQMlKmCETISeuX1vgnyJwSLR4cjSPJ
 rZycMbqsmS/LFDmsPw9V/B8fsPjZmcwze5iaPA+1DzgiQhzzr8itvVRqDuQE46GDHW0L
 ElNlciwSluTh+fi8WCsBK9QqQNKZeQG3AFplMmVFeW4Y3lrd60cw2ZQh8BlaR3OjvRw3
 tN0194EHqWVruF64rbmWSblKnhGNpKaHS92mRoxlePVZl4t1yH5myx1v84a86N1is8lK
 G44g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ypBfGfj8EygArkry8qMuIySKOz2EjbR2gFFpOtPgV5AuIgSIabICGEfyPhpZkt5ncFf8bC50=@lists.denx.de
X-Gm-Message-State: AOJu0YxQyor/4GEUsxA+EU1TNavJwqYhnCQJiY4AznUdjZJjrpK+Llb5
 YF5YhCz7n5+QCXCmjwmAc7jFusV5s6A4ADL9F8YPLKtSVlwThAhQmn6nR5NwHTKffHviIbD/IpK
 7+tN8xV0uQby7NDd9c/05/uQQwliS4tmjzTMMdJUJKzDM7CfOclzwbpGM
X-Gm-Gg: AfdE7ckG9xjg467T8NJIshHPbAwhfDFRSzUOAm38/Ok+X94lE5Jq5ZrPc21ze6qwFyL
 dI9sOloH7TPNKWNeGu/krizQyMy/RwzRJriBYg8jIpj+J75HyssZfGzasxvfQaBveTxPj+WSbp5
 5YhsMj1K9KuJu4LwoH37/YxqjMKz3M+IgGbWIkMF89QhMces+xJfckqBUgN6hze1M0jsk4FFyxZ
 RL7HHucau2qzXTRLo5B6eUOhMETpPGB76Wy1hrG8st+y1obToUysAyW1K3HPKspOb3ZSPBwrJJx
 XeHe7NpF2b8KoicPMv9nJOyam+UIrVkJhrxT3JHhxgbn606pc/mgLtFNyt3f7WxpEGrjf/GymAT
 Tg8FshtIk1fKWc4/9aGpCfk1TU108uqRBAMNAnlyOL/68U8uxeL61iIv7sS0GTy+TUyKoTWCs4f
 96uwb6bZrCpqhpQWaCJHs7EW4UhLbpMCmyE3vWEqs=
X-Received: by 2002:a17:902:d48d:b0:2c6:e46f:7e62 with SMTP id
 d9443c01a7336-2c718f75eafmr34591805ad.33.1781867466287; 
 Fri, 19 Jun 2026 04:11:06 -0700 (PDT)
X-Received: by 2002:a17:902:d48d:b0:2c6:e46f:7e62 with SMTP id
 d9443c01a7336-2c718f75eafmr34591495ad.33.1781867465825; 
 Fri, 19 Jun 2026 04:11:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:11:05 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:27 +0530
Subject: [PATCH v4 4/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-4-385497442db2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=2502;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RAjF+C1h7f5SokPS95JfvJUQjZJaYa2DEpBCMBDrx6A=;
 b=uztBP3Bzc9yF9CYmrPcjC81s81tWvMrSMit+Ds3988BAdJ+PHTFIBVI7RMIfkVlmCPnSeBv0o
 PvzeJhIEUeyAgCkiECNitMdG13KfnXUTHjuCjJTWBFVdXt0xj3i2f7X
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX2o2DLc/riCDL
 mHXffqZp0gYqMh4KyNKfqxbYaEbhB8RvbCbp1qW6HhCjohSdNDX0YdWD6abW7/trupmzDDpAlwD
 C8NaUiuh8PWm4mbSVfKo9ido0k8nSTk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX+vuijhhvc4DT
 iHYl8AHVk1sD+OprxZdZGqajS8MFyZPBCEuexLd/ZWzEr+g6CP3XeWpkRw4eAk0j33XA6mQOoK8
 MHu7eAQprN7eVnbjQqGjl8nWso9H/qKEsMwS8El3+/Kjp+JKihkwbxcU8k/ZyoWTTijch9K41RJ
 iApZdNTqkUTfhMgIc9dL7wKYnP81XAS6yIlbruc9b3zylkueThjwGJEuoVYsPqrtAs1mrZYMeWt
 VpFt7xev++K9J9fEUVqtzjYZYLMxAw+Zt1ZSmMZJ3TdjkaiUWG0q0IpoJpAPHBqju5hcX4hQBwY
 mda03DZoPiEkR2mH96iz34HkeP/mB4c1wH6d7GOHxmX7Enm+hW/luanTNSmeA2JJiO2+JuQmP/k
 Tgrq4OSDHEFZgPbK8zzRwDF1Z3gIWXeLbFzkm8jTe/jo5SDAzeaH5iRKZ7PiR7QYOxFwReCPNvY
 IZUtiMZJogsJhEA3beQ==
X-Proofpoint-GUID: MKlIL6ZprV_0OZY499pw0ygqMlwaSPfh
X-Proofpoint-ORIG-GUID: MKlIL6ZprV_0OZY499pw0ygqMlwaSPfh
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a3523cb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
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

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes iv v4:
- Remove handling for EL1 or EL2 entry as for Snagboot we would
  only enter U-Boot in EL3 from previous bootloader

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 032a9fbdb12..99ab9788155 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -7,6 +7,8 @@
 #include "msm8916_boot0.h"
 #elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
 #include "gunyah_exit_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..6f7bf7eea7f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point for EL3 entry.
+ * Snagboot mode always enters U-Boot at EL3.
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* Verify EL3 entry */
+	b.ne	reset		/* Unexpected: not at EL3 */
+
+	/* Disable MMU at EL3 */
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
\ No newline at end of file

-- 
2.34.1

