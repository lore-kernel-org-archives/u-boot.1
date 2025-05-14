Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E752C3ABCB
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F367B82A76;
	Wed, 14 May 2025 06:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnmC3Xpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B24582A4D; Wed, 14 May 2025 06:42:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF32282A76
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E44Ap8024274
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7RW54XgV/dF
 iIXYSKcHHYn7GbrQ4vzC8uMQn+4e95d8=; b=dnmC3XpmSiiS6je7DYSDqrFRTyk
 7vp3r8uKhU8Msm8W8sms7CKWaxWwYKW8EeBSomaH9XIp7A7R9nEh6oVxm7BOED35
 AFEk8CpSkW/lo70Byh2eYl0odG5oXc3vOmemStxhHdRqqDyI5oiR4ad/lMQq5cT/
 DdjjzZS6OfkfnOemKNG5p2XKlqa62J7nNCaZlvKux+O3WUWQgaqLcEctAkE5FzSR
 lRONuNoaWDGRr1yL6L28nYPOW3h/KEgFH+z1r7et7BnwEhmPvcFdyvrs9AwzCqmL
 PMjGRgRADK5d15wOw1m1tXMxui19v0Nw0i+Z3kzOuYYSbY97xGcbsfPM/rQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmscj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso465631b3a.0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197773; x=1747802573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RW54XgV/dFiIXYSKcHHYn7GbrQ4vzC8uMQn+4e95d8=;
 b=sxq5JxkglzeFf9gAh/23vKVlh26yMNtJxRzsoJbNzIRe1Kd8nl3kKiJ22Eoaw5uQnX
 ta3UtXnhDk8tq/72y3K/gyEMihrlI04krY1+dmXhcrx/tKW5xjAXuXW8ZI5u1+8ysJXr
 h7UCwX7o6fFBFnfdnqRh3fRMLa8rpFG4dD8hd6g9dKMtSNIrPcw4im6rXr4WN5EElfIA
 s4Yg+WpQUiePw1XJxntNZG1KsfbjbDJljYiEnPsQo356RQY7CC79mB1C7ykIPtZDNafm
 Gcpj2GE0+p1PXSnKMVo/J3iwaC8f3h9G+DG+c1ECf6fJ8o/eQqzO/hL6R1wJIZdKUhbq
 GLLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO2IJfSgSDbg2BJ84UeGN8l2VXn4y3BTyIY3yRxtuhuYGVUHK9eouZr7VZyZMieAed2/Iw/70=@lists.denx.de
X-Gm-Message-State: AOJu0YyS//4q1ycxUPS+txoZ+rMSK7kBYWJxPfKQ4Bl2uQM+0T3+w8Rg
 IA5uQuS2lYH/ABi4sGrVPF7bc3I86FU37Tla5LLMgN1S+cN7KEunonfQkMIBeL7VMBpK80W5IOl
 Am5VLWaejU/rfsa0cV1TlM7i980t3ZAdH+BvqS0tnJBWdiBUCHW/d
X-Gm-Gg: ASbGncvs1K2LetJwAZ874IECHuo69scyj/SI6EmWJnnOIBceFIZbiC0IsXDAAGoVAxu
 ZcGT24ZXbdj0/Ou5tWV8EjpBcnBjW/G929dcay9WQ4Ilplw2HPdH0Ebrs0osw1ubrjiVdo9Bbfx
 HqLevTSRA1JHaf3eGgOwz+CRpn90jhBX+huhCUAtNnqdw+YbYLYfFH+qvFZz8tf4PIr6lzQ5Y19
 onWxxgicp1oe+rCh7uQHD5ebxd+22c/5cqG1XAip618E61W0XA36zTQ8ivQXo804ze782bzba5+
 y9SfRsejQCBR3UeMe3ce4GWD7Ttu2Yq5x2NaR8jNehsxVk5bauX9Gity+f0x7ET4NEPD5qMb4Gm
 hl+zdKNf3GxORLjrKreqYaaTWvYSF2b6nWfBFfTjY
X-Received: by 2002:a05:6a00:2382:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-7428907f200mr2769037b3a.9.1747197772889; 
 Tue, 13 May 2025 21:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhKmvikGjvZ+FdytZzxtCBy1eBtQmBmPUnTpDB0U8UB7WDVadge/E2MeVXpajeBn7nNwI8zg==
X-Received: by 2002:a05:6a00:2382:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-7428907f200mr2768996b3a.9.1747197772464; 
 Tue, 13 May 2025 21:42:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 6/6] configs: add qcs8300_defconfig
Date: Wed, 14 May 2025 10:12:12 +0530
Message-Id: <20250514044212.1422714-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AXKroybx_fzv_Mw8zeb8wvHQla_GuVoN
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=68241f4e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=SDtKitdulPDloLDBxsMA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: AXKroybx_fzv_Mw8zeb8wvHQla_GuVoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX+72MMSnY1Qds
 1YlvZfyT3kckezK0pM+q9g3a2uqxECTpLwftKSXtKEINzGdKvvYSsk4gb6+5h8Qw+DHsPV3BPml
 4f83m4vqfqzqdNkGLxyhyU0gcuhhMnZqjYRTXeC6rk3ISNx4zs+3hsC9MZH/ezlEspPBAL+6eWh
 OuYeeEaASNs1+kXWJn7mxtA3wbWrsz92tFPnxTrvOU8wiO7binBmVmYv+YBC4D54aAYY5PO+j1s
 a4Uyo08krOfkR+tWm4cf/Pv5wp+MSfamjweGoYOj50v6Il7nVr0P61z7HXgWhFi2KwZexl6Oi55
 QiwwVXdRmlCdQY1T1vEGYeBQAV0glUakWQ5p/zCt8iTTreAK75qM/nYc184MZz/GoCHc7bUP4Ne
 uSreHCz/bieuy050OIVvOGpV5gdHcHwgNXw80IILx4f6RQ2TIfzUg+hFw6V5O3fqoZqHf7Ol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=888 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140039
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
Changes in v2:
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

