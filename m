Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60972F8A173
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F5E841F2;
	Thu, 16 Apr 2026 15:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4dDaYqI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zt8JTQ+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C425841D5; Thu, 16 Apr 2026 07:40:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF40783C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1fh2o1702608
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dKe01vcz1xh
 6PZqMF0/N22RCXNIvlYgJYi3vF/KyEd0=; b=n4dDaYqIxMMkItFqQIL6IKCTPrV
 C6OJHFPgESc0oKx0Udhtcdbh3jm55k3g7Al7PlIBNuA564jsXH02ScLRAXsAK21L
 4EmywTnVql6er6v4uptGxBsQncoIeQgf/LUuxNEG9o8MLR2KjedaF2hADQlinYge
 Ftvp8Jife1s1K5GihAhZKM0u1StsQLtzSo+jGUpPStQ0swcxynRy+ma+asAj3NjB
 H1ASaJzMx8PWlhbbmFgS5HEpryiyLyn5GQs7X1ZavWa7TOelAvBFk4fPbqzTXQrJ
 1k1xWDAlOKMyD1sfLE1IbHaSEwzlqEAyDz9negmyhlzwxNljV06yRXA8KIg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djdamjbg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:39:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f780a13c9so246432b3a.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776317996; x=1776922796; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dKe01vcz1xh6PZqMF0/N22RCXNIvlYgJYi3vF/KyEd0=;
 b=Zt8JTQ+GCFJb2YZ4+Zbi/W/5EkVJU7LfhmmCA4Xf7dc2wHGu9sNWnNJZnGOioHupkP
 eKWce7Cc5zOB/I590DcoqUQJae8AZF0e7/FUD5FcIAfkLiVmP+b1xTbj6xxYYQcNhXWj
 /whvD8P+HPiLsOjJBS9ihHfSRC5S4QT1Ztj9z/8fVntOKdkAnXMGoDwG0ghxbJnoiupU
 JhzlPRArwB+9zk6GrCwn5naQF/ANX3vd5scvSqkkxGYlIr26+cAuDRUjos/OtfVecUiT
 mz2DTgi8+Lxc6SJUcolk7L6bvWfGG7HtaVjYCaCbVFr4+PM2NCNQSniIuGAKdgMdbJDB
 yG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776317996; x=1776922796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dKe01vcz1xh6PZqMF0/N22RCXNIvlYgJYi3vF/KyEd0=;
 b=Fdzv/Xmt/2+pBsz8qNkHLYecq4OMS7cUd5Zykm5OHcx0Tg+KsdkoPPaSTqimWR/Eiy
 gAhvzueD6AishSxEt1e6arLEBUg9bW+UZzbeqtzSfT2yxZoR/6DHArjjkat5jy30ot0M
 rWgSHodQxXFVfn4ILwWIvNOX34HouUR2OZHB5mZ/LxMyz/SJXyqnKHB1hidsOxJumX0L
 hoaCc1KMgDf/k46mSWKofKV8xPtyBM5R6k42UgVOtWpLXEsKCDo3yxGtAAVirvuc7RHK
 p0oGK/n+DBfLDXfykrGGhMZfY40u1xBTGT6i4zMkZ5HBS1bqM8ryx2FeFnQA9XwjjgWH
 nMtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9icWj5Cartv6j7t+JG1vgCBq84/SMkuOaF04mYkxLSLsriu84jwnWYRFwncURy5TdNrBbHn30=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5xRin5lCZ25XLgM+z2iuH+q4aezsQ2zPKG1ehU3pyZEhQUeAT
 yio0xb2uPlJ2FArbyppN+w1RWM6ZuGu1PeF4XXNgiTTsWGy0lnnXI/mb708mLhgYe3X1lONczbT
 0uP1VGaRIxnj2kimAWyTXrpsPGeOh9QRrOiNGGv5Lcx3di6YiatvqtzF+
X-Gm-Gg: AeBDietYRF8RK2ZvLvXkue7iUIqyBTS5BctHpcNPDZHO1yxBm6g+k83iz7+HVtj4srE
 /kfWEZhOnfHptgbcb3je55qPF+vy80e2OeF1Uo3wWRSnbeTmf1dZzqfniO0i/629nIKrh5OMd9k
 P9NcZGqIjRX3m+Yd1jgtVxTjrppj5hYyNL9yeKYROnvrx2lu3irV+hlYQptCuDyFplXhMnYYBoY
 VFKwMddDTYrQif7EoC/6/jP20+jGtJNvwKhPBSfYEenDrgCtmsR5as7D9rcJOu05m2r+ArsoUI2
 EoiOT34SufFxgAbOV5h2K3YMhmrUlYnDIy/fWG3yqRUo3tRWiYvx+qJJeQc4QgX8/qJDeGwX2u1
 NrFjyY33gzEN3RAK8Bo01kyxYpLc9iYq+8jZkGMwy9Unhmu9pQYeuNnQrSz63dSSgdrgSgu9Q4/
 QH03JkvRgbwuigufZemXPMw3cAFA2ki7mnZ6nCTdHc9Yt5vCw/bbI=
X-Received: by 2002:a05:6a00:a113:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-82f7ee51719mr406978b3a.25.1776317996298; 
 Wed, 15 Apr 2026 22:39:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:a113:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-82f7ee51719mr406929b3a.25.1776317995758; 
 Wed, 15 Apr 2026 22:39:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:39:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 01/10] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Thu, 16 Apr 2026 11:09:19 +0530
Message-Id: <20260416053928.2834699-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8W9TMrPZmlaZR-HRUWSghr0nBy4iDPXc
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=69e0762d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=syJh1K7D5vuhnvzmwYoA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 8W9TMrPZmlaZR-HRUWSghr0nBy4iDPXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX6lBXG5FlH9VY
 WHVsnPOpXcygp69qtcS94FDLNvVMURjcR2RXtmxJYuxv0MOIL2KC51lxmttl5SkocIVkGFaiWta
 Fl5iJwk+GlFBzCvateEh+sBRTyJcJ6XKz8rncthS20+ueyeYLRkn9G90W6EASc5k+uEkiZHvf4x
 20P0WR3s/5Hq7xsh6rjKsARcSUXeLV42fldDJFr0MM8qa6Fw16TcKu7AhGl6llnxhpax6Cqls68
 91d9DbsN2tfep9my1SbY99mXoV+qQNG7PiMX2aROEFSZVOmT7KdoYSoElkHV4RYSgC2AEvee89/
 UzgNtc+KGLlOdHoHnGRb46UugN6XL60apZTXkyltbs5S/Ay/I2r7pKxQWRbYOaiA74fr4/vR0d3
 dQvje3PBX7W/HXIxwqU48c+ENPHYHcSwGI4wnDL+IWLXcqnj6SJbxBxQ7SD9cqz663Hq8X00kRC
 m4DErsapUG1hGtubSCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Pick R-b Simon
v2: Remove sdhc as it is in kernel DT already
    Move bootph-all to kernel DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5f0105d20de
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2025 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		bootph-all;
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
-- 
2.34.1

