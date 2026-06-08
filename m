Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8ECD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4FD84704;
	Mon,  8 Jun 2026 11:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLWU3D4s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyNdhlZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D31384841; Mon,  8 Jun 2026 11:07:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B6F807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Okum2347131
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2tFWZe/uSwhxiXuSTP6LQ9LFbBXsQc6sGOlagHGA3bU=; b=DLWU3D4s1d1X/3PL
 I0PY+yisE+Sv8RvkYWlJHoBAJFzKNPpATDhUMRnVMlAGdGMKe1nUB0QWPe51ti7d
 2lomuleSwa8q69FUOcDVuyLYvDOAb840zaN/VmfGG3kb2/x3AWPNDZihkhu5WzLw
 ugDFCw9T5Xw4QxeUbbFC5tcmgL05E1Khny26lf0wkqI3SPY0Eud3lwngZEp7xI5i
 SlInh73ZbNFADkPogRDAixOuP14T44IsgC1dPJp6T2DJjwd8LjUHk+lQpmUJPz4c
 OXQPVjFgg5pjpep3b4PqbdBHKcndmwmJ/7ZGRigKLpmW+1lYISsQCQzYKoojVRQz
 kRiW2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrf8jc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:07:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so80453065ad.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909625; x=1781514425; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2tFWZe/uSwhxiXuSTP6LQ9LFbBXsQc6sGOlagHGA3bU=;
 b=jyNdhlZnxqmzjAD3IRFJQ/ul1VJairTilFrnlPY93zc6AJfDDfL5fgP641/RlItxAy
 YurdTRZDFbz6CKBEJKy3i1WvYhTbXyaxS9mgp1qX5eEtLpySvxypEj/g8GbubUrTxKke
 kFkDeXITa3rd+s7QcGuKN4ppfLNm1x8yp1QGWat7yIw/EPWG47r9vxZpNdKStEbWLnhg
 wSMzeRASdacdZY9boEyuiy4nw9G98ucveIRqKSIc24UtvvcJd/KSujMCqp+6EKPHUfI6
 alx2/5A5PvejN0oQbRr1JNJ6/ghp0slYHyr/0hHujK2XHn6jQYJ5j2N0baP33A2OBVUR
 PItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909625; x=1781514425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2tFWZe/uSwhxiXuSTP6LQ9LFbBXsQc6sGOlagHGA3bU=;
 b=Ed6bTPEYk6waBexB6/+0ANzgqRmh50AqJDusEeg/1CwEAGvEmRrQOPsDhAI88SUa2g
 PTVNZtSeNWmowHVTeROD2o6jMSlC2cbO8s1I2X+hPXu18czymgNl7RKk6rAVdZQOUGTn
 ZFP0YN212V/kFBsrnV9IOVG4dU5elI/4YU+9sWPx1S9xU9Zvjr+VHW1o85t/Ab4IIsra
 mVXit3calogXnwas3rUjtyNzNb91U5Q9L+V5dB49rx4VIkq9UzXIGp8ZUFSeiM8+ItmJ
 qeVT6JMjYqcNWQwX5fv3iwS4fKl8kQe+psjMqxVbiqr0Wj3501nKS0WtcGRHFVvCMiIl
 d/kw==
X-Gm-Message-State: AOJu0YzVsL1kjbBGVjV0UNDWXvH1nbDQi6tLqPHjWVaDRHoinxJ9hY2P
 ZOEk2wd5n87G1c0QiCHuWsGmoao+QhaRdVLiX1mvjFlDJt9v32wKeS6OMShz08PnivuNhwRScuQ
 XVVj7oHNT7H9zHbO1ykoqJ/lecTdpRizI18x6GkJy0T/qrIQ1zsOcjc6g
X-Gm-Gg: Acq92OGOL9fnIan5OARuJ868JAarYV+pkbT8SoA+XRL3j3JHuKeyJtCFyU5LD7NFCuO
 mvP9THwrXNHfebm3IvwQujeFa1jfs6VRLPFQpQjGLHdGlGImr3WdNcr0Zv+dvnJRhh4SjqJiZ1g
 Ee2xWYFOCFYHgheX+kol1k/j0i7fJ4gtsl/z1RYotFPzgyD0KeWiXLSk9uNyKuSA2RRkxmp254P
 RhQsrtecO9YSmqgQcNDjVmow8obKhjEp/tQ0BSxKpnr8vHk7+r5w7VhZRalbTFdWGA0yxJyvzUx
 A+01oMKmsQPm2kfs/XxwVWAbrl3dyYWmiyxqsSUl79uhwH4k5GLHYtsYS9mRG2D8lHwhzcWqsmM
 V96+mgUx0cgtal/0knIXICqoto4pxKrYUrv25IHKoxHJq7op2nJdg6d/Z1iazthmsxbArCPzZnw
 MJtVHdJbkDdXkC1/ztW8wcf0M9P6X8mPxbUCC8Ba0v1zQ+dY40tA6LyEaZoF+H
X-Received: by 2002:a17:902:f70f:b0:2bf:356f:4e0c with SMTP id
 d9443c01a7336-2c1e80d2996mr181779345ad.1.1780909625228; 
 Mon, 08 Jun 2026 02:07:05 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2bf:356f:4e0c with SMTP id
 d9443c01a7336-2c1e80d2996mr181779045ad.1.1780909624768; 
 Mon, 08 Jun 2026 02:07:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:07:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:30 +0530
Subject: [PATCH v2 3/6] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-3-036bb0343bf7@oss.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=2372;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KfBYjMewMmcVoMXS5Rb+5B+YNQ9wSswG2inlqbk/JIk=;
 b=TELyenL+/G53LOEZInzOEZCgPT0IxkHbSVLRic0KYNYbnfYvL1ACXZ+elbGkEoZoC4pRI/d5L
 U5SMyNMAJ8KA7E5quvCFpyOb3EFTkZMFAu35xCMA6C+U7gQdvypdT+u
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX9TILLw8SG9oq
 H/up9l9Zfcgq+ZtP9ajqo8IoPLSO52FZYbPlr32tS6MaMJCnajUGPsWo1Pzzo/RNWMBbK4gA1tl
 nFNL7MkrwNuNqk+wLVFXPTaqZiE5wRUFg37XeKncoN/8WMzoAXyBKdtHotL2DyT+NLCihrFS2T3
 xFKs+RgeZXapwPzOD8ERXzlj2FzwJOLiIULTxuySp39VC3BAyuJjATJadIH6DpUTSxgYVhClbhA
 oGY5czpb78Ab5FWhiikWCrbiBV40XubNbt8uO0Wbv+STd4JA6YvxeQPcFa5gwFwSIBAMuuJsGqU
 Xc1+pPW47wSXBqlghOmtZgkCLVAR+OPuqXCvglbo1VfLSLQYRTYz2BTT6M1kiMV9o+DactMPKho
 4xmiFjCgf3RVpGvnCARgLbfX80yKdy40q5Dlkcx2UwxAGLOP/f0og4ty3pow58hARNnQSQjCHPx
 7aUMjNkwrDn3HbZL4Dg==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a268639 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=X-BflmPX2xr2PvCcbqQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Vzp_zq6roJn0yAmupC3pIud1_hMEMmY4
X-Proofpoint-GUID: Vzp_zq6roJn0yAmupC3pIud1_hMEMmY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080084
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
Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 032a9fbdb12..c31bf6f52c5 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,52 @@
 #elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
 #include "gunyah_exit_boot0.h"
 #else
+	/*
+	 * Disable MMU at the earliest possible point.
+	 * This must be done before any other U-Boot code executes.
+	 * Handle all exception levels (EL1, EL2, EL3).
+	 *
+	 * After disabling MMU, invalidate TLB to clear any stale entries
+	 * that might cause issues when MMU is re-enabled later.
+	 */
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* EL3? */
+	b.eq	disable_mmu_el3
+	cmp	x0, #(2 << 2)	/* EL2? */
+	b.eq	disable_mmu_el2
+	/* EL1 */
+	mrs	x0, sctlr_el1
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	msr	sctlr_el1, x0
+	isb
+	/* Invalidate TLB for EL1 */
+	tlbi	vmalle1
+	dsb	sy
+	isb
+	b	mmu_disabled
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
+	b	mmu_disabled
+disable_mmu_el2:
+	mrs	x0, sctlr_el2
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	msr	sctlr_el2, x0
+	isb
+	/* Invalidate TLB for EL2 */
+	tlbi	alle2
+	dsb	sy
+	isb
+mmu_disabled:
+
 	b	reset
+
 #endif
 #endif

-- 
2.34.1

