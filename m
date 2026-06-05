Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E058CD6E77
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0870384958;
	Fri,  5 Jun 2026 14:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzkhbLLn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dPMXQGN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5498486D; Fri,  5 Jun 2026 11:48:36 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA3C84879
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6559UusE823449
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 09:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZWIJB67ftJG
 C1aXLMPXC/BVmmuR16rq/kwANA1n/8/w=; b=jzkhbLLnG5HECxZnCC56LJkKwfT
 5+dzmdBzo02DUGKPvBWOxY3tusMtRhkzNgAQSR5SCBqNfw+XblAhQQMxQlV5iipB
 Ww+sD1+wx4+YFUa39LVY+UAkUqV9uX0PXHYw/XJGdVcKsQl7YFiWKyXVwDML+Bp+
 z36FgqaGupYXkk7Jb35Iu+ACWsl8rQYGsDkEUOCJAcVoSpuYgb3rz+E1VXsyC5He
 2Fn8IEiqM9GiztRxbNMPr6p2+6ZBBxHc5ivi50vIxnT/z2mxjMBMVJoB3WgMn45X
 DQ6dD7i6uHV0kKgjJXvpTC6kdP5ycTDOUzXvTwVvDGtkBX1Sy//Dm5U6kAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekncbhky5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:48:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso2117587a91.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780652911; x=1781257711; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZWIJB67ftJGC1aXLMPXC/BVmmuR16rq/kwANA1n/8/w=;
 b=dPMXQGN0Y7qR6O9Kr/t0zjV59Z8YVWF6ZqdBBuzjlE6e98Dc9LslURt6z2Pk6D42Bu
 oXFhWAxzRhr/Gz+8XYbJwMXDMhio05upDapyy9jsAH4fNkNsGy0AwQebFXj5M1/qQ18c
 fF/fQJCZkbsRLSKhKLPk0G+PVVaeaRgGFOxB8MjXQoOat6vHuYR7A3S8lwkuTCjphtsm
 ArbiV53R4TipeMKxLV1jaodP9l5wFpRTdFBKFPtYUh3OyowDnGpRhLMXwrxOc5mfJkhn
 C1mPrbJSEVwWQhdG3+Ti0SuceqCdh4c2c4UeEku3lfn3YcBfUuZzAN7kEzsIUHe2yAgG
 pMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652911; x=1781257711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZWIJB67ftJGC1aXLMPXC/BVmmuR16rq/kwANA1n/8/w=;
 b=Ffu8Edrdo1+nmg+7H36+2TtdMIHV0G7GT822Bfp/Id10AwWIYCNkmzKAlsQCeOQGQH
 f3bbpSb5Ojo65+hCYguMK6Lcquz49R4AQZCoZl6GvfrwNY3KgIA6c59E+SDnr/sxbDdj
 qrfVDbaDdYcLmEDhmwc/gyCeIjCzDdEZkdIqCKoQcyL7CeFy1GserJEizSd8ppgw39QE
 3bUZ1KEkvzUxMZriAtjRvGXbnoZXaL6Rda0YH8AYxfa/kwnebamy9vDHwFBUx5RegaRO
 WCVoXlkBmj7MXeiyEOGqpPeW6HcZVJ8km0TOvBio1FjdmZhmogwVYYm8sFQPf+mFEZPU
 DG6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rLuwzRoNnI6907MUtCnl5xnJF1qlFrX6w4iyNyaMP3mXdte8bgMsFbNUMImrwDFdw0YcQfJE=@lists.denx.de
X-Gm-Message-State: AOJu0YzTRhyEuKInhvXCE+ztcNJpM43P4QtClNKLvoL580jC5dldko8M
 jRSkuoZyM+We2+MI28kwBr5ox5auIiKLjpZhZVtsoduZaOIAGJ4EQgHJaiFw+O3h/Cu8BfSx/6g
 knO/zGvF3icvM/nYJVPhqnOXqsarPb3MguhwudEOcASLx5ACnsFdbJtmV
X-Gm-Gg: Acq92OHtcKyNmRLGTe71D6lhegZMXYqBT1WzEo36ddgPc66dqK4srhnaxu7BFA7sv2W
 AXSXoQEeYqdiXBvPXS8sCq51zLOMUZDZsPZOTRBQQe4bktOQ6XCVmusVtkpkfGyteBa0UtBuukS
 fh0JrSu4djzR/Hw4EEydDGLCFf8WO10LKBCbxJvWJfSQCPKxTIE3iwPe6KMlEpifIfRFlUTWcpB
 WTLpAm6kchTmmVwCHwToRfFElfxsRYcBT+G4OvdqdE1cS/ak/+L4OCbXGN8iQAPobOwNVid5psZ
 RbV96LzutLm7P85zzr5/lfv/ukbmVWaEzeEQHYZiwD8EYxdXqocnXthYv7LIcSV8W7Wx4sZTlJp
 SLdcu4lSzOLQNRWLvwkkeaLNiawLzJUjgZOUf5uPMolEhxjWRY4nU5KZoKvk5ZobxcET02R8AuB
 s/kxwDQ35ulQzxazepzOZWM43qdL7k5Z4g8LIkW+BgELuDferLmFan
X-Received: by 2002:a17:90b:3f88:b0:36d:e051:7b6a with SMTP id
 98e67ed59e1d1-370ef1f3c52mr2895610a91.12.1780652911531; 
 Fri, 05 Jun 2026 02:48:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3f88:b0:36d:e051:7b6a with SMTP id
 98e67ed59e1d1-370ef1f3c52mr2895592a91.12.1780652911112; 
 Fri, 05 Jun 2026 02:48:31 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm6208237a91.9.2026.06.05.02.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:30 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH 3/4] arm: dts: ipq9650: Add override dtsi
Date: Fri,  5 Jun 2026 15:18:00 +0530
Message-Id: <20260605094801.4130128-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
References: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a229b70 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hd9ws4i4fi2IlGS9FWgA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5NCBTYWx0ZWRfX7hoo3KHPYNEy
 OxSIikGwvf57dD53Wn8RURu5fuI2q38+CJfwd2C+evZixzXoaKR0tuVPZnl62EcXm+oRfOY73XP
 gsuOA2piDPnqo0mR12TBwVdro4FsViSj5lXtxh2FLIDiwTiPqcX8CzH5WXgaXWXRDCTEe8HhrW2
 +TWmIQJVfgyNg1Px81XkABB7FAEXimbNTgQ79oS2SMHQX7HA53olWayGwC4Pj2kdpAjMyG+P7Wi
 zb9n/VKfTcQKptFdjQCj4Dg923bHCcMvnkF3Jg0KVZx9ywQPNkTZlBWU771IGelGhnGu+QFqQ+g
 tfVe3UDQl1Gr0JVlNpQRrjAtviOw5rnVpimpCbwm9P6fQLskchg6RXrwNvjyXGsc7137KddDNCx
 Jo8cldC0ca1FL2rmxoCns3NZLf2cpAQ3B/1CaYEGORohEz+HbwddfHerighBgz6wV57rHCD/qM4
 +iw16f46qHORf1IgAxA==
X-Proofpoint-GUID: 389s63lD5j0L9KMGNke3Th0jQ-tAK6XP
X-Proofpoint-ORIG-GUID: 389s63lD5j0L9KMGNke3Th0jQ-tAK6XP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050094
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..4454e56469d7
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
+
+&sdhc {
+	sdhci-caps-mask = <0x0 0x04000000>;
+	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
+
+	/*
+	 * This reset is needed to clear out the settings done by
+	 * previous boot loader. Without this the SDHCI_RESET_ALL
+	 * reset done sdhci_init() times out.
+	 */
+	resets = <&gcc GCC_SDCC_BCR>;
+
+	status = "okay";
+};
-- 
2.34.1

