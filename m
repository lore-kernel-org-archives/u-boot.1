Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCDC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D53CA8083E;
	Mon,  3 Aug 2026 15:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYpBfEl0br6F; Mon,  3 Aug 2026 15:59:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CBAE807E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772762;
	bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Xp8gMG0VYi4p07x5UmzAesT2LXT+2KPj7KkCNHFs1tqQ9nmTpoLWgIBhMtzoMCqbF
	 aHBZo8oLjcI1uDCSHMbom0fyh3C5AiYuBd2nM1kRnuHC9NORmK7TjvwuR2S1Ooe6qD
	 Xgwdqw9IrdZptPmUnDynwEkBOqx8fPqRv8xCRkRjsGmd+nLJKxw3IX3Qb7gjw6zZNN
	 Rhqfq0MkqBsrEnH6rQSWd/0g1rZPlP/PlLfsynFyZQWf8SG9PyAZ/W8KKy8cn1NJLZ
	 gcFJ0WF3VIs41wwAF5eAVoTDNsii2pH36ixLmDUvIeAyuta3LDVaExeNwXMQw/37g5
	 Cc5wNcHo/ZPBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CBAE807E6;
	Mon,  3 Aug 2026 15:59:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 052CA389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF55240042
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuFb3BwL-dFr for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F6284007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F6284007A
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F6284007A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBxke1355081
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:18 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrdadm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so3823853a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772752; x=1786377552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
 b=YOiv/zmLy07cfzSmF6qpS3Wbn3K8RgJoj7acJMQ+Bsh8FkHouhksYjVUY+MP7mifTt
 DOldWmTOq1R3tsLvx3acumjcBeMT7/exdX0IY3I7B5ruxo2stIxeL4S3UGlA0mamCz1r
 D0mjahTeIkc5lVLuvXaUy+olFoq0zz+uyunGrbGY4MBFwxDgUg8Z9qxvNs0zYpBIqEc2
 0riXv/4I7tWc9Fb+lWmmLqDqcWGuVUUorUcMZSXYRkxV6JlszodwS1I9s10TxAOavXdU
 Xz370sZGZtXOH1gKLfOSQkiO2zpx0hZVbubu9N4FlvN67MvStzQFNmM4qyRnPIkDaE3F
 t+Ww==
X-Gm-Message-State: AOJu0YwEzCvYGXDF+F1JmoQUlHqQb/qY53D/bPv2HmZaMs4QRDZZtIum
 hBarAfvS5tzA6+wLVlZc6O1q0sqLLDSk9V04ezRyGBXQSL6egUL3NksTw4GseY2074+e8lpB03o
 +7WdelstUD/0KJ1AAZiRkLnyZQ9n+MOhd6/05l8n7KNm6DfzUrTBQ8JdLB8iPQEopGl+0hK2WXh
 BmpVI=
X-Gm-Gg: AR+sD10LcXcYMBEbb3RGJxy3sYAnDooVqfMdVb9igj3kWaQe2fdEYb7aqfFD83Szv+s
 25Ah+LXNV8zHz38BW8GDOIQSc6xMOalriuNIX8OaNrojl093g2uOLLc9hsLaOFmZR/e9/TaMXQu
 tIomYczmw7fUJaA5hAJwrbAtnHQ2iyhoY6GOzv9D/GHw+n93i1nIlDT5zdDLUTHbEbgD1MsOO9t
 9f56+pTwc4yME54I48Xu8TdTTWuIJOm8+XjOQBQVtWBgZarDrT/hlbkDwRawuvCjKZSQ/FI9/uh
 yEUCaZO/Y1f1t1Ka0on9Afyl8hZO1BfyDI2bF6pgB8IvhScQLoc92P9j5sTi335xPm85LxyGo76
 /e4kbRCopMEAauLKMhAdbN2VVcDK2KqB8bI4dC4wRk+twna9SyVrnpuQqMvxW5OUDq1Tr9Eqb+/
 /LNc860Lre95DP56IDKU9E7jh8EeHB
X-Received: by 2002:a17:90b:4c41:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-38fbc4bc175mr9569674a91.20.1785772752108; 
 Mon, 03 Aug 2026 08:59:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4c41:b0:381:5a08:6291 with SMTP id
 98e67ed59e1d1-38fbc4bc175mr9569655a91.20.1785772751549; 
 Mon, 03 Aug 2026 08:59:11 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:11 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:48 +0530
Subject: [PATCH v6 3/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-3-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=2610;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=e9/9zhCAkSzPfY+6ZJ57OoethFrzOI7Jhu1Nz82lfHg=;
 b=qxvXhOyscH3vVT7fm504maqvMDxtJyiNv2M/9IS0KBzxu6XvVXVo6T4m8rndYvoDF/vWLaA/q
 RfctBDNkA/5CunAAPPPII218PgJIbPnXENH1BA3EyzMBd4dqkSFWWGb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX4fs7pVig2DzF
 +8sf2IzFYJXaBxZ1dk6gqCKi97VERJ/F0hs0r2E0EpwmEIFaJxijAvg78wSU4RA/LLeGnArvBFS
 6irs2sAS7J0RaeuvJ0mjLri/w+a43xM=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a70bad5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: V3NKEr9py4HgXJTMbr31JWFtrNpzrnlR
X-Proofpoint-ORIG-GUID: V3NKEr9py4HgXJTMbr31JWFtrNpzrnlR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX99EQspNLuWTf
 AkDmMbKWn7iOvJpT1RhBlIVt01PoIWneQUrhTGADzndwpmk+YwYZKNJ0KM8dwbiJ4pae5UM5Nzl
 NIuonVsO+N3Q9327KJtamxRGV1MYViP7zwkDB96spY+mu9E3u55CjbStXe2yYHl35Kb0WX8VN6+
 zDyoQPUr7PNjA4U3OuC1lhGqUGmTY9Y2m1if426/6udq9Fof+hi4xz2XG6dqaQH6v/WKXPdIueN
 bBISZn31hMNaRx9ACzfRqut8fCy1Xr30G07SedWdBe80/GHJqq15a33jEBo1bANsV2KjeSSpxpt
 T85OBWpe87rbfJiErC0L2eYqwvKyP6BIvOLPwxOO6t0s6OGMEipYfqZkXXHm0b/Z2gMhQ71+QQF
 C0Oaap+M5rIWord7dkSbqrJ5ShAoOiNF8x0arX8gGpN9MPGdSa3a8v6ncm9qbv0/4kxdW7Xd5bS
 1e1KNf5RwjilDasaYtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=; b=NZ+2J+enp3AyvxHl
 V56+X6woClcIxSU3SQ1Xat2uLNBMBcfdpS3oXmflqPx57WFaf/mdRu37r3eTIUwI
 HxFHLXYs3xiJ2UMs1uRaJmagIIKfG47Jy6uzAvPMg0UY0NgCmAcew0Go6aKKEil4
 rhHNcNlwuST/vpY7qOE/vNwdLCWKbmj4J2z6PMeb+GNhfSxSzmXXetn87L8Ziihq
 z8Mf5eTmSm39IsdDifsOpB6X98dJd2m7stDXroOCCOUBL3t4ilEfeKpQjg6gatND
 zT43baEbLIudId74klItcZE9wyzKeFq6XTw/I4uWMUsa1N922V+YLp4zLA/HEV4Z
 IKx9Pg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772752; x=1786377552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
 b=KC78cPMR8s4/gLFr2Gp5+TETcTfvoyZuqEEUMxjNqoBev+BFubVw56MToZsBzVM30t
 3wrfafehkgG3Tc0nWUzzGEtzptjJkWId13B3uBsF/owUVwXmbTxhxaPbgiEQnIK3PsYl
 Yp7tNrlSn9YT9oeMH6tmT17gJNX4LssiKp7HvYaN/nhpUrCNrXuomttSg8AmCKZzmEoX
 sFQa0sYNa1gc1LmjgR5zkkjtjSsHb9+ujKwMdFGcGMlmFMm3A+81Ozc/GhYBswjnjOov
 Zfa/r15cNEOpI9xXTgJ8Nhlrf0mzhkuJju1BQj8tSd+M1lg1a6i0DaiusVm4PUZGBism
 AE1w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZ+2J+en; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KC78cPMR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes iv v5:
- Clear C bit (Dcache enable) also during MMU disable

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
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b3c76d6d97d..a4eb5723d2e 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -4,6 +4,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..f82ee87c9b9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,27 @@
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
+	bic	x0, x0, #(1 << 2)   /* Clear C bit (Dcache enable) */
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

