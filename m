Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403B7C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A01982E68;
	Wed, 21 May 2025 11:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwoXjBi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA2B82D6C; Wed, 21 May 2025 11:45:24 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8014182E5A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XLSm013519
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7NAIKOTXQJP
 e9ufIAgLA+UY2UKGNuEGh25alXZXAiw8=; b=RwoXjBi4W7nvStpLBqcfbQutyKp
 qdJrdXXZRAfln8ikvz0hgD1ypTjaecp6AAZiFAHkxIYd8b3wZo/vNDE/GmC9LUKT
 vRYnhoNSV4ydJHUFVyY8kwXhofxqra/UVIBmrWS6Hwi1hmWNhkQV22757oOTsi2M
 AI9JS2AsSGeEcnyY7yccWuRRqd6ymm2rmsHQWKrh6v9GWUs2x3/AA2rehvy4yYtc
 qhpIXTb+1Qkp5dgL4MlmAEuWV1+3z9EtfIo++ICdn097xdigXlZBGcP+wLoLPgOJ
 oM7dw1vsyiLCNsp5nyT6f96CpNP/Pd3z4l5UBZPmkGSSrh4p55Sh1smWu5A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh5afv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b00e4358a34so3998575a12.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820720; x=1748425520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NAIKOTXQJPe9ufIAgLA+UY2UKGNuEGh25alXZXAiw8=;
 b=wbJ8bK+7vPA2/Rb3PXvFqE6ZZJw+g6dSEtoANzXJtlZo2N/AggyOTqrVNH6SEyUsBe
 TeSZh3+2wpjSO6Hd4rrShYPGHuURSf2oX2Kb0zIXRFjpQ87LaDDUP9Rl+GLZn2jZRkbX
 hESZtl/g06y8c00pzsDXKRjigm7PSGWt/F+H4C8WypevXM+RW6b/6BR2owubWYq2eUak
 KElXopl0Oc9P9EyWOyRCJP8BYRAJadlY8XMSaWozNVSQ7iJi4HJgWki3MiG1q4acy4Ia
 4Bd38Hs9lveacrNHZOg07GhStQ5Tkmlj8sVkd8eu5Z4aXbdOFBhVNZ7kgf/Aabp7q7lT
 epsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPQWMND9nYgq1cjDYVYRwB4KUNIXdHwfzTIrezx3j/UHb2pN+ZaI2YA6DfqYijIdLMob7sU40=@lists.denx.de
X-Gm-Message-State: AOJu0YydL06DjqiaGis+2rDqNKebZdU910Nh5S+vx97Hj3ILAZJxOSmX
 pni8VsQE60eoQIfy5dQjdwKxirqw+EbX0USRJs3tUfeuf4neocYoo17YHq/O7kkROvORI2DeaJe
 kzKaNdqz/ZVU7JNY2SIplq9p0OywiEHGLalbgjzk5Iz6FChCP7Vwob9Bj
X-Gm-Gg: ASbGncvAo4A4sI1SnEyuxR1pEedKnFnLUGVQ4fFIebTp8E6yskKSjvPNidyjkKhcSpK
 vPlh3h2SVgb2YvsE1gImykwALR4Jcpr60n7KL/bFhX/F1Qo7astePIhEPhvY1S9mWrh8e+EgvSf
 ejaDhI8vGu/WGe4iJ/VCjXdHtGt72zKDFXLJoyDjYx3PvMteNP15j8g5QD0vazAoV7I47dBFSve
 v8VCzrAlwvabvJGql4LrHsdbhX2ou4HJenU5XvSx+GfHWmrh2Lzf6QUOw1x/BumsWC+TqfXHnVY
 Uyg86KbjToKfeDIMNSRPw2Zu34veh0Io1onRZXK/fLR1zjHPah52LT4tzjrHGFFNyt9+B9BQvz9
 ugc+lVfU4A2u74mcC95u7mUmRFd1WQzwkx56vNsw9
X-Received: by 2002:a17:90b:35cc:b0:30e:54be:37e7 with SMTP id
 98e67ed59e1d1-30e7d5b7521mr33668588a91.24.1747820719725; 
 Wed, 21 May 2025 02:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3d5OUWGHSl8egzWbu/UTLHrU1pQ+n5LdKgd7j2+WNAfULY6kpNGQyGchqVDaFsvB/S1bq4w==
X-Received: by 2002:a17:90b:35cc:b0:30e:54be:37e7 with SMTP id
 98e67ed59e1d1-30e7d5b7521mr33668535a91.24.1747820719310; 
 Wed, 21 May 2025 02:45:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:45:18 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 6/6] configs: add qcs8300_defconfig
Date: Wed, 21 May 2025 15:14:42 +0530
Message-Id: <20250521094442.3522036-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX7BFueu+euOU8
 83UDMaklXPlFg9GryGfYRy3MUVSuRPb0CBdXy6e71/QqudssSPrPMcK3GHs6hfZduMsXbp6SW5v
 EIDCHctmSkaclUhTcO01auK9E9edZCkiN7iBr95sPCV0FcA8AQpGxVb2Qh5TTyAYgX38vaa9iDN
 +4MVD/qoa7nk9fEr/7LV6ebp4CL8VtWx9I7xG7Bjkm7tAtNO2mN72pFyqmNSrTqpfncO2b7+OdE
 z/g78P0K+UaSgeNGzYeyjea9huN+YnlBJnU7MZgGYIoaTclMTB1SrSmQW8+4roVtfY6Zf3fCKYp
 EF0HOr7vUFGe6tHLczNlYXccRYi3uYDCj4cM8QNqPXAOSTsuvZi+FbaJ1Let9XtZuTDjq1FnWnQ
 1C4Miq5zwNMLs4eSkW0gqdSYrg46cWyr2FAe5b68DHhshIlU905voM+3XURm9IssNaW9sHYz
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682da0b0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=SDtKitdulPDloLDBxsMA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: p-i1uaG46EyovfoJzCn2oiAVqaYn5W0w
X-Proofpoint-ORIG-GUID: p-i1uaG46EyovfoJzCn2oiAVqaYn5W0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=857 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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

Introduce a defconfig for QCS8300 based boards.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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

