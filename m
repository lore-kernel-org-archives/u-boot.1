Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2971C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C518682991;
	Tue, 13 May 2025 13:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4fMM8gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E4C829E4; Tue, 13 May 2025 13:02:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0D68295C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D99F2i028970
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=od7wAKOgrOG
 nO1q8oo2YYc4lsRyCrXKZwXo0eL1d4ZE=; b=X4fMM8gBOsi0ymjl/HB+nX47ARB
 nkIXPSOm+2AdoD+CyYpHDGG+RzJBi8vgE15wIg1kI/HvH7vfI3JEh/E0NpI9/TRD
 ArFMSD8FNyR2FcXGLvDwQaPkFVApLJLi8ZMh4ivn0cc9pqjHLqEcKKRIZ9n6FHZp
 GYY8wBbQprDP4nUAB/kEvM4JTU8bHbL7UaNLfd57u5kyMQG8epW1ZXzaqmWGesO9
 eNn5f+d7NRep7AxNi556UJWs3WI0L9iU08msOhdX9/P+cfRiV/jI8Vs1+pjNovHx
 +mEIl0T68IiexAc2xVKn4EKCQG+BD1NitJb/GdGP4Nd3peokPQZKyqBMWgQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hxvxff38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e7343c777so41153255ad.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134154; x=1747738954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=od7wAKOgrOGnO1q8oo2YYc4lsRyCrXKZwXo0eL1d4ZE=;
 b=pAZKo4JPFNoFh66rhKqX2V41Jt83WgnbCd+4V3eOgHDEvZHd1hIcq3Fj7kEYPjPE3Y
 /YGXDduTn6k/df3Pyc4onFLbaRCj/RyCOpVenxZTlpjDC3Vq23J3Sav65h3TOivwTQzb
 m2dGm85F9aEBNG9a26IrPR5oIAikMXfvWe7Zxf3uYXTXcd0B71BfvBhlrzZkL4stAoyQ
 Aa87jvxlh/l9SYmgzeWQSefeSLZdT0L7zu5doaVm9S0cD8S61QOw0cxYMAE72PwIcgx2
 C190bwav154bKSGbqtXhO4ac8cWsNlgJxcfMguKyeZAX//dJN5Dj9M+WCs7tIwrLa+V4
 rWwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTPOFNwr8TXvevE2Sk8uBd63GFuC0qosGo/Zv0a7anbCAV19VpQZezO0UVrdVAjsU+Y0qIiRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzYwHFbpPkNFrzJTSYopKSwiHdtyAmivNer9bo7vifXvMC/p8ti
 FV77JP+y2DodX5qhyu7/mH0+LjgtaSZNdIkjoUgd40ywBuOGkqFbMqcIkcByXjakN2FmG6jiPAQ
 OF3B74rdj7ma+ZfvRQUkWvo35xpcHHIbfmjUzddUW0pJ7tpP2jJQU
X-Gm-Gg: ASbGnctV+iuhbKjsF6f8cK4c6r6ImRNZrLAedWvv7V5T4ZikWKLWkU7qGba9vvo8zTG
 1TELUBXTujR4JoKueJQXNCmDmYM8UxUkO6l1YAnpUmB453w8xqm2FLaVyyKeKo9NISv2C28lkHd
 /uerM4krAH6xG6OtniDklHs7NM19C7/iqbIPOThKgGF/c4DH6zwRwK3FHrXBvzNS/ou19mXx1sS
 BSNTuXWJiT3kzILptRYax82ClokAqIcvzCBAsDmsJnl02yxeghX1i9kc9BaJwuRDSPV4NYnSRqS
 vnXlhattG1a95sVVGd73EQjEmWbd5lFzcduzv4mEk8mxmfmUdV64PcXQJcRUlzXIcg7nVAhE7YM
 esok+VIYjetBIiXfPuAxZ7yV6S+uQUtY=
X-Received: by 2002:a17:902:e804:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22fc91900e1mr212927955ad.42.1747134154180; 
 Tue, 13 May 2025 04:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrf6hWHKLqSTpdPGCz+T8ZNk/GSD7OWoGJInxH8HVeHSYEEOIDmtNvuwlZHZQ8/cmSZVoGhQ==
X-Received: by 2002:a17:902:e804:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22fc91900e1mr212927305ad.42.1747134153479; 
 Tue, 13 May 2025 04:02:33 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:32 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 1/5] dts: qcs615-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Tue, 13 May 2025 16:32:09 +0530
Message-Id: <20250513110213.330495-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfX25wNgzFVKFBr
 HEUXt4UkB2uzmoakHXx0cIqfTGPtJKnz+2p23l1W6aAmdLISE06X2c0Zp0ItXHZ45dwAB4DZ9l6
 MCscGXvBAMfHQyirKDGn1FfGmpY7vtg+Vuwg1XquFiMxKZQ7ULfsxECo7cIDzs4XpOJTWtrNCnZ
 ukscHAXSYkLCCmpvO4T/ZywOE65U2XLOo41xCGc3qG0vOG0gmlcYEfyDdX1mqeWSy75XzuPJnb3
 mhtDd2ANdOLFTinZ6ydb3F0Qe7KkZKsouglR+MUE+gScDwr3xhDuhzPi3PynMp6gOIjwsVwGxaw
 lCHpUl0V8JywF9PcmTMqeXLTJA0oehCdodT/wWZlP4TkAB/k0e6TW09cg5ZmmkAkrGft2VLNANM
 Q2Z8UBfYZhjCblc3BQ3VrMiqmfoZRggUlvHL72pxfNb0yEiy7sFenYOT7UL0TrlDewD4aRdF
X-Proofpoint-GUID: 1u6q0zp0ZcnxIQcsX6Ths8Q29j9NbNfW
X-Authority-Analysis: v=2.4 cv=WMV/XmsR c=1 sm=1 tr=0 ts=682326cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=75hTQqtBxdwJIasrO-oA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 1u6q0zp0ZcnxIQcsX6Ths8Q29j9NbNfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=965 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130105
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

