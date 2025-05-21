Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047CAC3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B0882DB0;
	Wed, 21 May 2025 05:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hgl1NHgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC0182D59; Wed, 21 May 2025 05:54:02 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB0C82DB0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGdcP0031959
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GGjQ1BZRDdz
 b5iiuO6LkXu0rYSwGI6IzlMD4kWzRXc8=; b=Hgl1NHgDVABpuTx1q2gF8y/PiJG
 kqkCTKE+bToisRnAkegWm3JSLhqvBaGix7LOtW7iVFZQzLT/HrMiCYtllhcqhT+f
 oy0kVkJjaoHSIkeymQ0RGYAuBlLB+yFwLvSiRk4ogDmo60XuJ4q8Xzt/CcpBnSv7
 oYuBlBpVvJF4eA1Nc7W7eIBedUpb2PlcUI6NiD41o0gB1pi1QLhgEIbKHbbRUcwN
 0QmrufoIEv+GJT8Pf8BRs4uzXIH0Tls3rm0ejL3qmw0tpDExkGJPWC8ix4YDEAAg
 U97Q7Xh3B3kRJ+n2SMdosW3uXT5tn2pc7uSjtFj5U5o7/qXjNMmidMZ6Qbw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf19e90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b1fa2cad5c9so3814781a12.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799637; x=1748404437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGjQ1BZRDdzb5iiuO6LkXu0rYSwGI6IzlMD4kWzRXc8=;
 b=e8472viRV+NMF/cqKR9ESxXn8yUZut2gh0nglL4k2Sl19gDTTXWyY6lV2I6p8MZipA
 wEwG8rv6D5ZMC1IWZ5TZn+MLAQc4Q7ZLEwzB6k5U/pL7SmET1vG3+SzENiy6KYSm/btF
 +reByJPn/S8AtS5wd7w7Yz6AtgkkXWfihfzq8/TYEwULTtOPS1H/AHXY5suQXj1PfPb8
 SsRQuMB8iVjhhP9HBtFjSHbKEXYDkfAUXtLfZ8Km1Qsv/9zEl+g76QcuUwxIQtzV/iPN
 5kF6I1DKO2EUQIDGUCwK/Y+y9YoRJ0eIZWDCYZrzHRHDMhyRXXtj4rGa2vjxzk8oF0Kr
 IZdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEYzETqcDhmvWKYnFeIgjPO2vcFWd6+3vCuWaKPeScydW3UM/gfOsODild6qDpUxKiDamHqBk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/gejCdG0SAnAY+jeTottIiahW1wV1fAcMHnpFPQU8Ts3UUji0
 JDOgiVi+Muqof3adSn4pIlqjj9dfmsYYFFDekBJvEshJNZaQpyNd7dQLPpBdb+EDkDKkvIKfxHk
 nLAdgXAMqKPiQYZI7JDQGNSlPBjx982K7XX28Hm0ti6F/5HV9tLd/2FmP
X-Gm-Gg: ASbGnct12r27quUbgk6FMWNzzebQM/4Jtsa4lL72QNAUUKWDT4nuYy9IPSR/Mm5ya2o
 ReTqwsytCne9DWIT7Jh4LQg/aL25U9fziMv8JwyrOrZH8mPm7oSTHJz3UH+rqqtttnTRr++kag3
 vtNR1PpOo4PRC0j7N4AZMQaFcBomGhjmNfhgNuEMc2KNcDpTJnww0FtaB4TQm4BWcYJQkaIcDfg
 Ln2KQ/kEx73mu3Qz0MuGAo+ly5zGAP95MqrjuGXZJbjtRv6y1iXjf1qchVGm9q4vXgiMd/KZzxa
 8/g65tNgpUUyCS8f8lPCL2eV8eY4gHTj7soZOdhEFuLV4P3vxnvj+eYR+NMqzfgi5JHuGvhjMUU
 ltaxgeSCj64ODKYVRkm+OWzEyJXFHZ4Q=
X-Received: by 2002:a05:6a21:502:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-2170ce3c81amr27931769637.41.1747799637437; 
 Tue, 20 May 2025 20:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5wz6hmS6RVLAR/qQOc8N+5cpXL/E/uqQkRaQ818KlkkZ0CglVEATt53B2U+2vk+TnNaUsyw==
X-Received: by 2002:a05:6a21:502:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-2170ce3c81amr27931735637.41.1747799637083; 
 Tue, 20 May 2025 20:53:57 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:56 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 5/5] configs: add qcs615_defconfig
Date: Wed, 21 May 2025 09:23:24 +0530
Message-Id: <20250521035324.1182833-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HJubKC1RAnPg9zvWbKtlS5fW8lNpcgPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfXwnnFpQ+QI0Zr
 xEQhZSQepB3KXa4LoM5Tf8eu2/rqwnE7nNtvGeep9Sg/t+c3FDrH7ZEpvLfDaQRmqt21yODRo6R
 M5upvcE14gu3MtdYEY+auxO/vyIT3FjLXI31wwOTNuNtLULXRir5okBiHG5ebGlFdV29SechPhM
 M9xS9Klzca1NZOFGbgq2fW5xzWEwv2QYYAsaRhpRZ4Ndw27eUt84C+fcpl35CWLPPSEmJctxLDa
 USiJb48a3wiHQfOUap+hN9cp9UFLUKAzgP7/AqjNPY1ShmowJDdZHgH5G2ottaKzUN+UfSWdr+b
 x96sJJyZFeWQ8WUYscVpHvW436S+2pKTYhn/jJB7tMfPl23+GrmDloISEeZxdAqngemWDogXaCL
 uFcBqvlvD0Q9E9JgI4RNYYNS5iL4QjElvwcOqiCGwKOhEO0wf6FNzvdo0edzJ3N2zS8lccn1
X-Authority-Analysis: v=2.4 cv=F6JXdrhN c=1 sm=1 tr=0 ts=682d4e56 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=R2VVY1Wf7TWBXLlSVHsA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: HJubKC1RAnPg9zvWbKtlS5fW8lNpcgPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 mlxlogscore=833 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210035
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

Introduce a defconfig for QCS615 based boards.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 configs/qcom_qcs615_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 configs/qcom_qcs615_defconfig

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
new file mode 100644
index 00000000000..2468267b955
--- /dev/null
+++ b/configs/qcom_qcs615_defconfig
@@ -0,0 +1,22 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCS615 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x880000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
+
+CONFIG_REMAKE_ELF=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9fc00000
-- 
2.34.1

