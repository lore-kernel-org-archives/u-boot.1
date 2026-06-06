Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFFCD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 11:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79478405A;
	Sat,  6 Jun 2026 13:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLAOpLoH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Klz8uLoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033D0838BB; Sat,  6 Jun 2026 13:20:42 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644C3838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 13:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BDpf91327436
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 11:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZCwCnq1FX00C77wLyiEZBohTQO9yJwtfAr76LVmfAs=; b=bLAOpLoHaMVDoM8i
 tPf8J6YC02Px04gQxLS1cZALdPO8oLifmdRnYbpBlGflzSmckKohPQHbqKt2BChC
 RsRbIGHGqmxA9XhlhenNc4k4byQr5A/Pte1Iu/w8CyMGGSZ4NkDXHpMoNJQpXeov
 x3EQ+iiAE0oyeE1Mql0ZIcJOOoalu2rcwgnH+XCBKDonHH6IPqH88Yp6pHIZl9iJ
 Xj+Xb0o7AsdJBOmyRfKQ1LtfpiKHc1DH0zQg8aGKPBWZsmkFZdAeD4IBAnn2Fjyo
 DHje4MYyfA6KXIL+8pYxi9B2B4bXLEM7OOEb6sRcdZORvNrThYKEIGLni29RyEqy
 wYASHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rpqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 11:20:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so52928645ad.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780744837; x=1781349637; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0ZCwCnq1FX00C77wLyiEZBohTQO9yJwtfAr76LVmfAs=;
 b=Klz8uLoZ3Vno9WImne7cpwnaVbZ+ZhQyYepGvqt+hcVHnvdcO+T2tNbaiXRE9hFuki
 g36hyRakEsuKWGaxeso5l9Ngh4xqAltBDhZ2OUFIVwO0JOIFZP226Lxa5lrSoSy3tnhc
 1P7OO9XBfatLyt8flQbueIA1+9pyF7poDtb4mdJC4DyAqhOS5/KUxhwrYoLdUTQCV1aZ
 kjd9HXXltc2hgtA9hz9turPFGtnNh0r5f90SyEXtjBUL2/H6GlphD3GAxYMNRWLyEDd+
 GaCfr34cYepKbQU+2TisxSlzU1xt5yL5inSglC6HLWvLdMjIkjP1WBlybAZ3gj3l+Eu3
 xGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780744837; x=1781349637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ZCwCnq1FX00C77wLyiEZBohTQO9yJwtfAr76LVmfAs=;
 b=oUUYCnPZ0LhWSwR7vYXZDLvOi38EkLoS2r6R+tPQNqh59kjMu7CSgoWMFm6ShvBfVU
 illXZ98v+wtS4Oas6oU/miN8XLici1C7EHtqRWOaN7AHN1xnrw3TQnPbhYd+XBL9Dss6
 7TXjOvcqHpz5wvuLyrp06lPW6D+K9SmHEBYTi/mwX9XYQxJNrRi3bJ6GXSw+JvdYRYM1
 5HDNGL/6dYlbii6OuBRwFI7rbaWfeoJpxwodY+vjEhxuvM3KcLJJa1fpjGgj8RIW+GcO
 YigAtUXDvnJFgYm3exjAhrO/uwXC8vGOcN5QtCfTfvKJRu8rwElAVG1BX1sYHIP+4sfo
 VxuQ==
X-Gm-Message-State: AOJu0Yx3N1LCC+d1/8ptBGrKus6QDTMVWv09rFxwcdZvjNF5FyZhC0RT
 iNEHpaIcVWeVD8qRlL5rONb7BQ8siOL3x2W4EFlb3EhElJc17F1YOvuOPOx3qdYuHzHMZxYVLq6
 Tvx4CgP6ak/TxwXTH35OnddkWVhEzA6FIIOnd0BsKyBejNE9YpbgvBy268cxiiWXC
X-Gm-Gg: Acq92OGQcGc91+ck3a/2Bb2C4QZrSEor5z6ERiqP1O1pmOZp/y0/04mJvT/OZYYSodz
 42/ZUyAekT3nWbUyEbt05qY6yGXCFQzMDbykwTKOuDyMhqC7pEo3YkOIEfN2rtmyyC98QJHryoV
 VNSniaZkAmljKY+PreS1gdKpLSmYtuwIj1/kP2V7Z5xgV+86Wlzk8aa1Lr7bHuOmecPMyRw/prh
 I/rkzRGfmNZPsjzoE0tuw/Dt4nGWuwXreYhCmSw3fSuhoNuXu8FjMPYQElQLIrU+lvmpFOVmGSf
 yfpN1oZ67Y4RQIbTnRUCJ8cERYol1uEou7UebK8G91zTjGtGhJj10pbtoL63GMczcBwEb585gnt
 8zIrdmY88dPgSnvH879eH+GyDJ3lfALpn/8/Ch2aYevXyX1cnGktTXb1qwn0Jd/Xq6PPaSULQqw
 IEJPU2aD/dqTnIVNRNSC2xEcHRbltJxAJfAgI7GVCA2rKKLcNYPGx1e2aoEHgd
X-Received: by 2002:a17:902:d485:b0:2bc:eea4:83c3 with SMTP id
 d9443c01a7336-2c1e847ec9emr82592115ad.25.1780744836800; 
 Sat, 06 Jun 2026 04:20:36 -0700 (PDT)
X-Received: by 2002:a17:902:d485:b0:2bc:eea4:83c3 with SMTP id
 d9443c01a7336-2c1e847ec9emr82591845ad.25.1780744836322; 
 Sat, 06 Jun 2026 04:20:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6e294sm120672185ad.6.2026.06.06.04.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 04:20:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 16:50:27 +0530
Subject: [PATCH 1/2] arm: dts: qcom: Add Lemans EVK U-Boot DTS overlay for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-lemans_spl-v1-1-ead97dd5b515@oss.qualcomm.com>
References: <20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com>
In-Reply-To: <20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780744830; l=2243;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YNlPPdYLFCrnYmanZ1wxEm40rIajrDTMb2PqH8huS2c=;
 b=1A3YFshyID6hhf4eJ8E6L5rnlYzBO/nPw1dtTdrHGSgQ+d/cPbqCtV1xVSRaF8mq91wGCQXN+
 8k8ldcRC9CHDiGB8UP94pK4oxzkjCR7eB45zniBJiNEGh4NBKzItEPj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: cjRPeM5zxq8bIOqvQA-coFJzdlVsBu4i
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a240285 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5VuRcVLWiwFeK_EuOa4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExMSBTYWx0ZWRfX2BIPQOX/fwBz
 eO7IJolLo9kSNbhe43bCYEP59MtVtxf9tBjIwNDigglTrBTaDMduQjWd3LwGWXFuejrGIDLD+r3
 dHWiLZGJmWXHoDI3ZiP/seHP1TNwFsPus7gL/0KJDxAiQVReV7dHc36xxVrLixOHbLQZ3HuNpD6
 i+t2a6r7pPkIfnNFEM9RtUo/h5GbBq/1fwJXh6ZaYT2ZHzEC8+3Y8YL3P27BLGdTARPkVNUnfG/
 jD93gnK+JZ+aTO85Jvwjyskti0+J2HqRcIY0RNBWtoWvTJeFrxDUDgyEKG8yvaQfBIqANtE3v9O
 efb76P8gVwUo+nluDxtt6whtS1M5z8k54FvqELAG6DHBtw6QheBzJOGE45QUVipKYJ0QcFZdTpj
 3bR/FnL22jpFzg7TAMZQWew5LfcrUCTgZAsK+byn5AjjMB4jUdEmsFZULl6KrNlc7tm+rojpZLF
 gNV9fPaYzxuoCc37RCw==
X-Proofpoint-GUID: cjRPeM5zxq8bIOqvQA-coFJzdlVsBu4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060111
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

Add the U-Boot DTS overlay for the Lemans EVK board.
Mark the required nodes with bootph-all to make them available in
the SPL device tree. This covers the UFS host controller and PHY,
GCC and RPMH clock controllers, Apps RSC, UART10 console, and the
TLMM GPIO controller. A static memory layout is defined temporarily
until the changes to get memory information from SMEM ([1]) gets merged.

[1] https://lore.kernel.org/u-boot/20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
new file mode 100644
index 00000000000..12fe2171f10
--- /dev/null
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when bootloader updates later */
+	memory@80000000 {
+		device_type = "memory";
+		bootph-all;  /* Include memory node in SPL DTB */
+		reg = <0x0 0x80000000 0x0 0x3ee00000>,
+		      <0x0 0xc0000000 0x0 0x04d00000>,
+		      <0xd 0x00000000 0x2 0x54100000>,
+		      <0xa 0x80000000 0x1 0x52d00000>,
+		      <0x9 0x00000000 0x1 0x80000000>,
+		      <0x1 0x00000000 0x2 0xf7500000>,
+		      <0x0 0xd0000000 0x0 0x00100000>,
+		      <0x0 0xd3500000 0x0 0x07c00000>,
+		      <0x0 0xdb300000 0x0 0x24d00000>;
+	};
+
+	clocks {
+		/* Fixed clocks needed by GCC */
+		xo_board_clk {
+			bootph-all;
+		};
+
+		sleep_clk {
+			bootph-all;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	bootph-all; /* Enable UFS for SPL */
+};
+
+&ufs_mem_phy {
+	bootph-all;
+};
+
+&gcc {
+	bootph-all; /* Enable GCC for SPL */
+};
+
+/* RPMH clock controller - required by GCC */
+&rpmhcc {
+	bootph-all;
+};
+
+/* Apps RSC - parent of rpmhcc and rpmhpd */
+&apps_rsc {
+	bootph-all;
+};
+
+/* UART10 - console serial port */
+&uart10 {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;   /* Make TLMM GPIO controller available in SPL */
+};

-- 
2.34.1

