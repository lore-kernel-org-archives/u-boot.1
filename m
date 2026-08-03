Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8E3C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6B49405BF;
	Mon,  3 Aug 2026 15:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqvxNiXwVRv0; Mon,  3 Aug 2026 15:49:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6502F4058A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772195;
	bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k2cv2/pFN/ED3I73KRM3yg73rzs3zhGEq9nkhyfcrY0TY5Rh8KtfoqfB5upT6Uc9e
	 CX0zbGQS++C352/JAwG6dbB0gnXegFNF7XcBpYCezfg5TvLJURxEs6cSRHP1I6ffiT
	 ezRIaDA9J8OM90CtZ0WzjM8UtiO4J6AIieRi4oKdW5E3mqmjrVpQV4X6WJkoKtkZPc
	 nH64MyFShGAAF6bXyWyc0ntka5saJLentfWNzcuO2Quj95ZSqxDf36PQyCgGosDBQs
	 JTyNerknX+dt54AWHIEC7rVEntDl/Jpow9eO8UdofcKvywsqtXUNcRl+Am/mBY0Yk3
	 yv+G8aBfdA2pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6502F4058A;
	Mon,  3 Aug 2026 15:49:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97981282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DDB0809C2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDJ2sgcKyz7v for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:49:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 81BC4809BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81BC4809BF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81BC4809BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673ECHjl656153
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:49:53 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrntb14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:49:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso3777060a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772192; x=1786376992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
 b=JhKt/1HOKlkpKa5ByWWJhvOcC74jrtZteEUD2hV1Q4z1ptyiHc5JimDxzj24AiHsqy
 QcDtyl7d7OjK1O3gRAYuwu8fL96OocolnHy9ayJTpoB7zOsXSc6tmPfYOhBSvc8l6Btr
 l2jf0U76HQFPDGuuB8FgmfuctSLwkyr8+a2/l6gOYTN3Ki76E4L8A+KwDiEnHCckBrTY
 RtK4hhmOxU5Rt8ihiOUQRBzc82j3lU6jdcIloo6zkXkswKB8JymYzsOsIa30vXmyXm5z
 AKN1Nnz6inOdThLfKpiz/oLfYGcDMeiWw0xoXTi+yIL+8lnf/clEPZjjN4YxpG+H8InH
 Minw==
X-Gm-Message-State: AOJu0YwY+BZw1JeKDhElzkBeIG+APb1lqdHYoaN1+2Pcuj+Dg7fBTGcG
 mhNcr1wuwjgVifqjnUJxwXCAMGd3u6eVza9hq29rlbtoTw2uVa2F65lTicIup+rMcWd0oSxWHWw
 Z3XXzt0ZZeoxi75o8CttRxdvQG1qRnhaIFg0glz42OJgIRWmL+dqtqEc6aU8frkr1+LYNHEM=
X-Gm-Gg: AR+sD12g2Q2TkbIT2aa7rb2BgfMfNRqB5u8gf2esQmVPCBnsKqJfYl1Ad5Ji8aOCpNf
 EhlX8wCeF4WKm8wYna7Uryp3QsLtDUgS28V24gMSj01s7Xm9JfWHk2LNzxRsbJnFr8zHLnJTgtd
 07M7vsqWDR9tT6tQhL0EiSDieCfC3jLtlQgT10O8nRJB+tcLJZGCurQ2n6iJtDqq5tER4HBEy35
 dEfW1xkXrJebdV9C+l1GhEwMZehwTJwMMcmj8JjX7v57ubn3NcehW8Xi1AacfbarBtLGZNq+5Mj
 4BAe4vNpNI+XL5iZjwTayeVdanHKL9PVfLaefq+RLN3dOIlqWdkvTn3jpNYrXzwv+CSRaNZABjE
 B3Wh7qBDAYae5/BNV5B0yTZJUpNA4snkwi+F9rbrKFzusoJBeGFiPuAPZ4yCit+LfqBjuonw2XL
 kmEhOvDFbpobRRyAV7QP8wOxS24FeV
X-Received: by 2002:a17:90b:3bc8:b0:38e:6497:ca45 with SMTP id
 98e67ed59e1d1-38fbc59b19fmr9089965a91.39.1785772191892; 
 Mon, 03 Aug 2026 08:49:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc8:b0:38e:6497:ca45 with SMTP id
 98e67ed59e1d1-38fbc59b19fmr9089911a91.39.1785772191379; 
 Mon, 03 Aug 2026 08:49:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:49:51 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:29 +0530
Subject: [PATCH v5 3/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-3-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=2610;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=e9/9zhCAkSzPfY+6ZJ57OoethFrzOI7Jhu1Nz82lfHg=;
 b=DI+kkWJocTn0N8mZqoiwDvLx9J+mqYZU+isDhFj5nOA7Dm8QgnKlqwe8vOOJ/CeWA4F9qS0Bt
 hmPGSTa9e1UCSjOrAUK/p21dkwf0La8wQbTEXMIz3GBMbgLIDH5VMvv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2LqQrV27z0/G
 GyH8zT6Iri2swVSL+YtHoDn/bI+aa90KvR1aK5iyKL08a0If5q/dVMnjTcKziND9sdLq+CD0qSz
 kIBQFO4vuA0F2ny6XqqpKAqrZSS8BRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwl5qR3IkClLa
 LWpI/cd62Kh/VsuOHNZWB5PtV0HbHoytcXirsisDdRnsj6VdPPj20AErRPK4szq4e1QZrsADifz
 X4AVsVLJM5L7fFv9chtG4mGGk/mcW35nsJYu+BF2UVmfUqUuIwJKVCfvirECR0abZyL3Cy3JMAN
 +RRpfbvKkgdai4NQmGeu0SR2M3cagHiGno/OXhwBuBXq8ch4co0tWM0geXTu0F6mTkxWNx9wDAZ
 L0d52QrQl35ezC1jdL5HCKxSnrub/37bz4h97u7BHYLxn6sNODO/cw5HxJuPOIX4YO912y303Hl
 NJo2cZ8cDHhfXXpfMcqfcaJlEEo0TaWdp8YnIkLE1xVBVo0k0pd578PH69V7z8uinV8Qe8QZEKw
 wQssXqvdq/SjTJO374aRN0ddVvDv4jWuWQcqQ4pmm0P8XWXr3+gmN8/gFSEyQsqj4EyzF2Ydxpx
 bAAKXzOtdZfMY/bIHXg==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a70b8a0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 15N2okSO19k1Cm_xm6onl3azObCVD7Yo
X-Proofpoint-ORIG-GUID: 15N2okSO19k1Cm_xm6onl3azObCVD7Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=; b=kpdybYrM90yppBUV
 TgrzrtZ84dZcqk0n4gpkpTIcKAq2zF4iRLn5eqMWH11Fmx6AhYlW/95orCsYbrwh
 Q3dEZEDNFxBwM5CAvJx+Nntt11yqrMg6AW9zHintC9qa9YPNrHJFpeipvzpy45ud
 PJgGHHDMVqi1DIVLRwVzNN0jcIUF+5kzWmInUBOBYHdrCs+bA+oZaeS1WTFtVxsz
 NSVTDc2vU+RetdQVPb7vlUV5QIEia5w+nt8RfIlrbxgxkm1gcCaS3o5g1nJFKXDv
 1DHXNz4DGhRJgZnSuftNxy7ih5IPKYRDpnc3U737GuUgOQlocG99Bl4oJa5ujkVN
 6oflyw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772192; x=1786376992;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0chUCO59qDV56eVZeh+JWgyWgIZjGK1mszkE1dyZyAk=;
 b=FRdpAP2Dckq64LGcLxuAGNpjMM8dY5smtA7uFFU9GHg0t1VofTxbeiW/RrzTMfe6tl
 vd8y8pisRZRNnt0t69xaGHImHgquKPIClPRdIpG0o2TKylqStkm/K23lX6rc+pjwOPa1
 8NPneWfXhZaV8d9BANcPIY/qjpm3+rGNDweqgSoAPAooBw+H6mQ7wc9hL5Cy255nIxy8
 JbGOPu18RTUwKH3Mcqwp+1Vhu8uOjWqk8iw0EnbcdYAU1a62mTZALDD5S1YsL6sotQDA
 3xCSebHK6mrBHY3k5kTvboGlqdoBQgQ7V8vmGKfDoN0B/YtOGUVCBy7zMTWpYTB8F+X5
 ddtw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kpdybYrM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FRdpAP2D
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

