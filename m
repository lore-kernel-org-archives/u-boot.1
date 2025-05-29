Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2DFC54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8261D830A0;
	Thu, 29 May 2025 17:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2vavBnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899AF830E4; Thu, 29 May 2025 17:50:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F28830A0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1OV7013717
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+Xe8zRT9y5o
 ubDnYfECGK7cwIM5zsN5YWwh7lJ32lTE=; b=G2vavBnHNPBtOTjSomdjzxcb+5u
 PGvLm59pC/tL4HV6LrdSo+3b87px3mO+e8vbO5aJh8F3p4/TaLzw9vuoudZBmIT0
 M1knsYniZN0RMwZFeQBwZkaNFjSgWat9iujy7ilI5Ikkpb7S2KcHF+4z/Ogp1/uk
 0pb03ENZJcBXW2behQbL7IU4k49B5p2XttfoAGvzJJ6w1dsj63zt1QVEBuWvY2t6
 +ZoY/nNzcA4FtgfEYZ7BzubHIGWJeBKYhVGXLjY+J6jJKfoVniJiIWy6sN+eAPJp
 4nedJbSu0BeoTfha98X2wEM+QZ6k391TOGZDjh7LjMuUT4LWGpGdEEeyRew==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavm02cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b26e0fee541so768255a12.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533809; x=1749138609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Xe8zRT9y5oubDnYfECGK7cwIM5zsN5YWwh7lJ32lTE=;
 b=KDqRIQedIClrP21ccy66ZlZ8P2zsK/pRMf63LQx1O0nGDaJuAEZQlWLMihxpbWUGGo
 YmUiOncp4/s6G2pYo+YV/Ke0JPGFtHOzIv/pzeRpVxmOSqtEWXkXJ8mhriz5XqxBxlKo
 q1IMp41OUWsv7JQdy1Cc+jT0twupBZdEORnxr8ybTSm8DiZiMCJACCJxORrFMhzrpF5c
 pM4jlbgcgvtdb9h9e71HQJCenFZA88m8fbjUHTqYusMHoFY1jbwHUjZRgYovZsvDaeJ/
 le+7uUydAUC3tElUoqDPleTv2f5ZoIGahYR3XxmjySRLL2BZ7zViM+btzBJvdT6JNLgw
 U9Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpPkWr48aacy/OKOw3L1ay+OMkBhjin0q6Ucdr95K4kGb3ZpVXaHC8G38tv6Qcf/4CA5gmcRs=@lists.denx.de
X-Gm-Message-State: AOJu0YxE9aqZdVMNNs/utisWSB55bKDs0Aa/Fm1dZoD/fe9OkRQchube
 4auTfMjj+rYHRqVva2NzdOd5SHeTlkpDejdEvvz0URTXif8HTWlQ5QkKrmmzZWInDWXsJwQ6nFz
 Y30EAuDbcvZbuKp3/fKO0bjci8rJRUjfGJM9qdBLi9bg8qZE93Vc5g+91
X-Gm-Gg: ASbGncvx0VSyL/qGORnZ0y3HIPM+lEx7K5fnmug91nkVrVBsq2QkhDeoYvvaXK0wA6O
 iudOOIYprSOgOtSQuNU9UA8fQZRHPXRKO2wfheYkp/qXjzFrpafiuUgm6k+mFYk0mR4rQiSg5FK
 4nGoImlWpl/74O90Z3SPPYVrUd7qhCHZ35D4iHzZCzLsaF4jh8rqYGyFb11Svh6xvgXjVrWjQJx
 3dzOKt0H2vacS6Ma1mAgrpCGUI6i9D1NsOPlZLP4r6jGc5ZPmDkBf5pFN/YrGUEHZVsq+PKNclt
 8Z8W2BiFjuDNb5VcSwSUC3fvXDfwykEjnhXc8mnmfnpRI2rzS05JwzQZaJNfx0BoxWevmyAChJb
 DPat2SoXUPhgOm5l5sqD5T5y48yw=
X-Received: by 2002:a17:903:647:b0:235:7c6:eba2 with SMTP id
 d9443c01a7336-235298f01b0mr1155615ad.37.1748533809339; 
 Thu, 29 May 2025 08:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn3lOM7YdSRdzYsIn7XiIWSdTkFcwx3WXPp7hEzelAOaHjOf+9VYE74aytRAqdvjvS+v4GKQ==
X-Received: by 2002:a17:903:647:b0:235:7c6:eba2 with SMTP id
 d9443c01a7336-235298f01b0mr1155205ad.37.1748533808975; 
 Thu, 29 May 2025 08:50:08 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:50:08 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 6/6] configs: add qcom_qcs8300_defconfig
Date: Thu, 29 May 2025 21:19:31 +0530
Message-Id: <20250529154931.1879976-7-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kFMLQP4YNA120dNNwpMRag5C1RZrkoVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfX6gXFU0AnjQuU
 rjnjVhpKA0lxl+3GkmaD2TVE6LmiRTArdvU6D9G7oX6kINpDPoZPrNf7tK9Pq6cccw/JAtOTos2
 NkmgrSMh8Ngy5Scqc87Kw3C6Oz549A7DQPqgzLF+pqdl6nLjEP7Ki/r4AsEtH5SblpS9dL1fc1W
 w9tKDe1R63EFY9MupQcB0kbIa4cfXmtXe487y8ISrw+/EWAtj558Stji8O58IGjT64muFwvmk7T
 T+vTeRmWnR9tHngq7hPgu+0Zb2EOiD/vUWXCcVji4S1keIsrPjv5zmV/sedb65NyxTdw280fAOz
 nrgHSIqO5V2HGVSSnlo3og/17JlQVgmmFqqK1BD3ISw8ZcXdUggTfHAbUKzki5tBfgOroP0+j19
 RTKiMNzbo4p+6eineDu7hy8uLWcE9/BMErFBt9+YY/L0T6AM7A6WoYJTkNrYD9h6UUI7/r64
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=68388232 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=SDtKitdulPDloLDBxsMA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: kFMLQP4YNA120dNNwpMRag5C1RZrkoVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=919 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Introduce a defconfig for QCS8300 based boards.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v4:
- Corrected the commit title to "qcom_qcs8300_defconfig"

v3:
- No changes to this patch in v3

v2:
- Renamed from "qcs8300_defconfig" to "qcom_qcs8300_defconfig"
- Corrected a comment in qcom_qcs8300_defconfig file
---
 configs/qcom_qcs8300_defconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 configs/qcom_qcs8300_defconfig

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
new file mode 100644
index 00000000000..5fffcddc16e
--- /dev/null
+++ b/configs/qcom_qcs8300_defconfig
@@ -0,0 +1,21 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCS8300 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi_a" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x99C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xaf000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
-- 
2.34.1

