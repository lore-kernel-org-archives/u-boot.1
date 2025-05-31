Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF2EC5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3F383197;
	Sat, 31 May 2025 05:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HcvIjWU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA82783108; Sat, 31 May 2025 05:20:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820CA8313B
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UNBrtc016092
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6IvTPxWzRP+
 tYpvEf07es6lrbLoHt1KVVa2CUPMduNg=; b=HcvIjWU+TMwdvaboEdxinWN1f/n
 JViO4uV8oOsXjPiHGJHz3k8cZEabHnzoIBS5L+FhZ3QjHByH6bfuMn8V2UhTmwos
 wgAfSvQS7lY+hXVGNjrpqfSuEfEEZ/qMPqFgH23ETfx8vilWkwYagQBgdMvPwmZ0
 niG2vEnEk7uGZgsp40TOdN3uC1xM0d0DRHVjsgj1To1TJB46CzLEl/BjQM10rnmp
 raHIdz4Qa1Gj8sxFxNq4rDVJjYftAJxuKAW1kAUkMZr5rjK0nMZFYzP/92stC2ZU
 dd2jYZviu7p+tiWUhwqh5fA6wP6L4oUZDSiP1SzvkuA4vtbOzvqSwkAmqug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yc4yt45j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b090c7c2c6aso1725845a12.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661644; x=1749266444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IvTPxWzRP+tYpvEf07es6lrbLoHt1KVVa2CUPMduNg=;
 b=a//sSmdtaC6Z3e0YDPah0Q1c/q86DFNuKM2prF3n4rib5Mfo1wpysAdpSugLGoDzSV
 +6d2M94lZoK01sm54BrWe/97JREa1BWzQFfIrh6S5T+SupU0kLpIXKkJdLUeZXpzE98c
 IpTzMIfldMQ1tCT1nv4VCuEqzOAkxE4OeXWB6/AUk0hzT1gIPfVFdYTXdyX3XEg+9rdB
 oJyvar6m1e21v6/N9coqBkpXVle74zFlXsDewFoGWbUfZ3wq0y9UUNoM7Owk0HVQMWzw
 64ufDC+LWA8hPou/E8rhfhRsCU1XYxpW+NDJtDM1ncwdeQiy9EzPzFNo78Ceh4AiLBq0
 Nc2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNlvOhXMNex4kAdoqbwU5QPyOLBE3EO7z6O25VtejyHDh4nN60sftjBpgFXajCGHW9e3wfeas=@lists.denx.de
X-Gm-Message-State: AOJu0YzOA9kkxtzXH9MOqSJ6gytFWxW6WHzGnlOydl/a/zKTpDyCBBCY
 UiVxETZuMK6QToVuW/hbmGdeis9y/vnMVn5vEsgYiJVEtJMsHFC0Vd8mixpUMlnZfZUQ3kjrLff
 9qDwJoa+X5wCxjrQdMP0G1ekfo71fBO83Btd1TtZLoCE2v7W0y2Jk40J/
X-Gm-Gg: ASbGnct2+pTXhgaq63M7SYumTXM9O0cWQiNH8aDIOCR3HkVr3psPa9knH5aHnPDwZ6d
 hvulL5w99nBH2diAqXy64isPoufn9uxiNR25xV+8F49TRMzUWNzXrm0kxvCUkbzlLQrRCEfnUk8
 4H5dKLYGqGT+XBALMEz5r+4nUpJBSinTQcosGiavQJ0cS6XRm4GEnxZ4vogYVzHrL2lc+j/u3yu
 tSc2t/zmiqTj5Bvll6RZqV46Dco1LDXOAISlXTz/LrpmXUyRfO8iVkLM5Mr1UBYt2i3xHc2dTc0
 MbGKRTEdL7RvM/38qQpqX2SKJEPLFP1uJz6sFrq2J66IAE3Q+m1rIyGkyokimb7/HUDGp9naoya
 muM72Kc9es9BibVdwoiS1HR7mtjF0WTPpqCwVLe1P
X-Received: by 2002:a05:6a20:12c1:b0:21a:de8e:5c50 with SMTP id
 adf61e73a8af0-21adff6bcdbmr6618262637.11.1748661643879; 
 Fri, 30 May 2025 20:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJul15zWW7kyRIRXHwv2omEkzH6ZVy71OMBo7FJBuFT5FqA8H342tGU/SWkFihrlF7rmiNg==
X-Received: by 2002:a05:6a20:12c1:b0:21a:de8e:5c50 with SMTP id
 adf61e73a8af0-21adff6bcdbmr6618222637.11.1748661643424; 
 Fri, 30 May 2025 20:20:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 6/6] configs: add qcom_qcs8300_defconfig
Date: Sat, 31 May 2025 08:50:08 +0530
Message-Id: <20250531032008.3083716-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfXxHAq6mEO4ePi
 IvBAvGyZtFE6jCpyRBzzkz2T+y3hEH+GmvWqJgRirIk7DEIBzC78ONa3mKjfiJRnU/Yfrsc47HM
 TxYFSyIkVHdDteqB6J3m1m6fwX6oDstJ8Ckn5wFioZ1oZbR7+w+gd52lFNAAGPK6QRT5Yct8Xc2
 otBXIaUqyREEvdaqZyxbR4gVMdjpWFzJJC+FayHJOb4DsCyjbbH7oXU5fkg1DVkh/rhZ7UPy/0e
 uxRhFhdnwu1UP/2JMLBkfyHUA+tiaImZcRYWqXNuVvIALlRX9F2L88BNCcJDZkWYxRUeNKr+tam
 kqJDLt3Cu7GePREgKDvzTZnO8+FDuROs30g6dx3oTdGdXphvRaRYknOr7cWlQ9C+tgrECYZRJSV
 U+bk/VbN1KthHg/9YSbXVaETCwTbiVi7gs9fE46cIeWTh99kA4Qe59WGvFg+yr5kuX4mZZVX
X-Authority-Analysis: v=2.4 cv=Ybe95xRf c=1 sm=1 tr=0 ts=683a758c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=SDtKitdulPDloLDBxsMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: xFZn1lrWLEBzT1XEk6RT-EFKOl4nNf8M
X-Proofpoint-ORIG-GUID: xFZn1lrWLEBzT1XEk6RT-EFKOl4nNf8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=912 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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
v5:
- No changes to this patch in v5

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

