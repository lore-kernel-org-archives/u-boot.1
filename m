Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98590C3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987E182DFD;
	Wed, 21 May 2025 05:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcmGvpct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDBD82D7C; Wed, 21 May 2025 05:53:55 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C40A82D7C
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGdvfc028112
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iYv0RH0yGeZ
 O1Dk0ZktVJkGgZGAjqjzjyFnsXlP9gq8=; b=jcmGvpctkMkTo8Z9mPA04SCySMN
 my6IZ3EHCayaf2Ixk3UX+nAQRPNFAsz7a/2znUUBKzdPzpa3ozh7VDOmsgQhTTh5
 qtMW8h+D32FjW/O5V2QwPit8enB6BXvmVG6eBHRGHjnqxceX6yj2Xqh59FjACTER
 rwKmvwmyOXNjs2Zi5bmFuDuLNphf3AvT+x/injo21uNNfbCus3v2Cq3NjlBHS1Ez
 uDHW0k/xIVQnEzm5T1jZG02kLRvmM7E1ufQsC+VzJPvKii1047pp/D1Zg/J74ue4
 DQWOWQ0hWLcOt9MDz/lDZCYprtuyzmJDMriMFvsXYEtJIpSAbvThyetQKGw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf41eep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7395d07a3dcso4785144b3a.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799619; x=1748404419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYv0RH0yGeZO1Dk0ZktVJkGgZGAjqjzjyFnsXlP9gq8=;
 b=pBdJVIPfXAGtQ0HZ6Nikas8Lnex6f5Ua6o1NRJdmkV2FXCVHuMokl+T8hzpPKlgHyZ
 0iq98KqReCLf6WY4j96ILpAOGkTgZoUuuCgqP8VR9zVKaToUXrFtEzB70AgZd2yqCvn+
 K5l8/I+MR44TWFfkGu/7qo5IApM3T/ws+ZiaaPLtUrI2lUXgbIbFj0uKHokBgAfTNxOE
 9G+1P2UGOhd6Cbdrr0wYXroOUv7iCu/WFwsJdcR+2uGQHrIu3uKqjyn+NriouATi/au9
 DBHnpuTNR9C8hglnLZz0PrS2dR2iUCYumW5pwZIN2qWU/xYxuwBoeACaAUJnJoy6b7gb
 2i4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgUSun/wkTX9Lu7MtiQAKzOmVr7u5SpXSpv+AgID1yiQCdVhOt27pQdi8sgdyb0ZV5mxzKJU=@lists.denx.de
X-Gm-Message-State: AOJu0YzRtE/1kSc+sZZTfFqv3IvSubVYwjsK13jBxpCwveSj2/T6L/ht
 1gXH+qEmul7AlmZzfEpodlzJlb1g9EH80WXfywLEskRNu3RltNJkv8/QubItcTAqtZFc34GcyiH
 jotYihek6nXg1zKw8exzWatCbP8OkE/nyY1yJYMVkPOcgBWLcf4CGDKPd
X-Gm-Gg: ASbGncuqr0e8qax+KolQTwnVzX1/nSP/56UqbFC23Vy9xub77I49xtE35OpL73novpI
 ETkXP67OismmxjbN18tolzSmlHQtp8uEUjOKB1OWrU8RfvR8SfXbIiQ3IClz1YtwrFuaFbxkADz
 OxeWzGmKNO0XZqYvZ6C24ii48V49QSMYxpp/WiCirOdHmfaEd+1qMbt8GAEAqIOJpGPFLzEpCQO
 8JKSvTW0c+mo0xMgiuYoKhuyYqBg+PNOn15JK0N1K8k2gR0irxjh+jPqQK//DD2wzmqizZmayVr
 Clh5oquSw2Uy4sezo1unrzSOEPwDkdk11cIeKgzfSjUTwHbNHk8x7i09nbXqNGjqCutwGBGOh4D
 oyTegCikWFypaRghM1oVh5+H56qbEyvI=
X-Received: by 2002:a05:6a00:2d19:b0:736:41ec:aaad with SMTP id
 d2e1a72fcca58-742a97e6b2dmr26043263b3a.14.1747799619079; 
 Tue, 20 May 2025 20:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD0pdfSLRUMzkxrYPxRPG5WoSSzIOTQuS9IFf+7ZAwvT8Jd9SoZIeI7gKjzOQZdNe4eCwafg==
X-Received: by 2002:a05:6a00:2d19:b0:736:41ec:aaad with SMTP id
 d2e1a72fcca58-742a97e6b2dmr26043233b3a.14.1747799618652; 
 Tue, 20 May 2025 20:53:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:38 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/5] dts: qcs615-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Wed, 21 May 2025 09:23:20 +0530
Message-Id: <20250521035324.1182833-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfX1EyVHqtPS/aP
 V8o3wuxM8oA3Fm4Ed3iQOn2nN+YfYRcSaFtJV79KmRZ8REilAWbRm92A6ghm1ojbLuQAjNvG5JB
 8biAO751m+c50MuCqPakpoT4MFbnWpM/2gmCMLjuch14uSrHf6YgmSadlHXqZf1UgElAJ3fk9mm
 +jCYGQs1p1BG5Hu6GiYq5HvQgXwdT/oi1srOEFX6DMxDt6ngJMCs1WgfmiFuiznCTbdW5AYxVKN
 2+YnitTekku2QuDoGLDJKnxO1CHvzct/4lX/LqgqynaE7orLjwwe6Q+m5zrM+NDdZbgJud+4qOj
 lSk0l5eMuwRMCsX9l+/ya0hFT7/gw8FnXu0fo8/VaaG2dgKh/OewWxlN59/ZTE9xY7ZbkTwlJDM
 X3eFMRDalIDLNh12oWOJXzCbxONQWskxhKGZfccOODvo52nIJzF0V8+eAJElW5JLe4zx/8OK
X-Proofpoint-GUID: DxdJGGPOK0pyj_b4ZAOss5OKeDgtj1Kt
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682d4e4e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=75hTQqtBxdwJIasrO-oA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: DxdJGGPOK0pyj_b4ZAOss5OKeDgtj1Kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=955 adultscore=0 classifier=spam authscore=0
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

Added the memory entry to bootup.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
new file mode 100644
index 00000000000..68fffc70fcb
--- /dev/null
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x7a00000>,
+		      <0x0 0x89600000 0x0 0x30100000>,
+		      <0x0 0xc0000000 0x0 0xc0000000>,
+		      <0x1 0x80000000 0x1 0x00000000>;
+	};
+};
-- 
2.34.1

