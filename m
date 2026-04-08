Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869151073CA6
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F328414B;
	Wed,  8 Apr 2026 14:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHzDu7dV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ajny72Zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D09838BB; Wed,  8 Apr 2026 11:12:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A650480433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63839E7t2412291
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j9hXjl/zMXR
 rm3Hv1OI53Om1niZ3x663tg3bwmrB+bs=; b=lHzDu7dVJ1BkYXBYPF8BzOhs0GP
 qzXISa/BbquFAlsZZNaaPJSWX+aGgfbqxa4CLTcgqBw8ljMfoWKovUOx4X7lO09u
 EymcmgL3IPSLMellNfUDChSwkM6QqwlMLHCoY/0rQ4gNeI+0Z07hBHW+O24rMDqQ
 0cjIQKspJiwus13GcNLpqzERhQKvncbyOOyVR73CvkaslXWw4pZw5iLk7L7JUqM+
 uROkKSJ40vGKUsAXTnHoLZNmKwruME+FJKXZYLjodCWPPOaPVLxMp/vPJbk8UgS4
 iPdtbJAMA3+7uoz7NmjtGVZvokDlolAvt8ButJiD/oFamG5csGmNFASKgNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vb0pa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:12:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b249975139so149267065ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639522; x=1776244322; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9hXjl/zMXRrm3Hv1OI53Om1niZ3x663tg3bwmrB+bs=;
 b=Ajny72ZhN8E6PcE0hdYsiJYdsnCNJBiGzcuKE1wkstWtf+pX6v2dkpX5ezTQyC78K0
 FE4hkZIM4n4j4rCJDcpvgd/UPEZYq2fg7nEORb8zvLw0Kb1Q2qAXKInVnlBnkgykYdJP
 v9bEhxnzi5OSCZ/ajSDIzWF7yuWWjHXr6Wrg6yYM1wxLr9ULwDtxKsXMLUalGp9YfkJc
 AV3h1oTjTA9PtC5WdBlxHRIBZtE7P8P5Xyw8aGJ7kAaDKitBgwyyGDF/EKLizTrAAppZ
 i6Me5HNYXNId8VJFoMSqB4w+QkHeQn7lNYjD72HTfNBcaT8ChsbsYSDcYceerbRYaoGF
 C9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639522; x=1776244322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j9hXjl/zMXRrm3Hv1OI53Om1niZ3x663tg3bwmrB+bs=;
 b=Gk4d3qlfqnPSZgSqsoJAElgCUcMDdJLtg4IXH92XcsLqtLoriQh9oWMusyOuTkHxtb
 Lw5byk4cFV67RV+a8wC+l7OsTGPDX0vvJaThAfT+D4Y/Opr/T9oUaGo11RbsezxRqvhL
 EzEVRBdyTfDuHqML1d7FhjsUSP9wUaJIxXb5PH/WWzWTuwas4kSqf4Yd/AvPEgcwxzym
 JKE92yAqThW2U/kjrGa8/RBqUSZdQZo/EtDKlS288RbLROXLqjBfTHsra/PQwuaVWs9L
 /rn3EnyHxs7LZWcatZOMq8Ipyc2JemopUgG9cNz1+mWHjxoYjLVi6zforxhfcvFTTdL0
 iU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaruZlZs0cCNQ0Wck+4G/7JmQow2EPUcj55va/AlN5AGbz14CaE5Cj6uK2TBb7GD/Z/sfz3oI=@lists.denx.de
X-Gm-Message-State: AOJu0YzUfMcYxAcQGJVKCB+1oTbTRRWpb/zGRwbIBcfHN8WFzf6dqf4d
 4401G1An6WJm1wZtq9CTGsTCxksP1RHRfU6XepUE/AhchjClt75jOvqYZ2TdsLby9UEVBNqA0Gs
 EXZ1Q9+OOAKN/DY93VVGuSphOtTlvJP/BByDZU6EwLhWwyovEf5Kklaso
X-Gm-Gg: AeBDies51yNgjNHC2P0Oxl4c1roG6af/FXJFxJBrDVHTN/ceJ05lFhVtA+FGwxbzeEV
 Oq0kiBskAINVbk2IhUTDHGJYtZwiKyezG3XWjItsATL3ZSf/W/IE2WIWqy196AqKnCvIQN8yGIu
 VomzuFfjih8Gz+97XnXVSjmyqYjYz/ea9o3iphN0pcp5mq9zqRoX2QUhv4AGP2ODKdJFGmE3bnX
 eAWnZ1KNx0DQT4fRn6C2AjgacCz/AgdcdU9z+rY2BN1Jee4s9iS0ATLGC4ZFSAvjHdtplwp6zD5
 DvYYI7q+1+RdgsajLE6B7xsUl7um2PG9nOyy3pq3tHKFhvEH9Ivo1W7HffVJNSfyqjPZPsDr1Eu
 68b7KmrxG/wnfAGpZQzPfXTJ58ND5SxR6x1K/Ihv1HzsODj3ZkwTBxIes16YB5WdhyjX2J/ln/O
 rnlrCP/+CbqIadAXNYCC2/Vk6n6rWMVfxDHJwr6D+om3SnPhXZimk=
X-Received: by 2002:a17:903:3890:b0:2b2:41a9:8e0c with SMTP id
 d9443c01a7336-2b2816e355cmr232777245ad.17.1775639522023; 
 Wed, 08 Apr 2026 02:12:02 -0700 (PDT)
X-Received: by 2002:a17:903:3890:b0:2b2:41a9:8e0c with SMTP id
 d9443c01a7336-2b2816e355cmr232776645ad.17.1775639521495; 
 Wed, 08 Apr 2026 02:12:01 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:12:01 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 1/9] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Wed,  8 Apr 2026 14:41:28 +0530
Message-Id: <20260408091136.2794546-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX7Uo6m8+wUOkh
 PGmN7XfUIFz+g3xlJgGeMW9yb8TaaeDNfYKILdAjBv8/UHfTOo3kjsbm6nypXBsDmUpUI5lA7ta
 v4nROaJcJ+hKLyROKDYzyHQnhjtbOzgW0/6H8SwI7dvWsrvGO78E/CJsA0CXmkELYI3u4WcSOwS
 ic2dJwIBz8nXggqNjDV3Bxhcp3ZhopPcTeZuoiiJr9lgB4IeE2U7+C8VhoshWvQjjkPPogDpOU4
 NT14x+9phmIIe8paz7V2AM+5D+86GyZo5otyGPZNScA5KSNoAw899NF2rxWT4yP4zy13h+eMu5m
 /jQDLg0ccDjQqZ+ipEdVl+Y4PR+HunNOzji1O6eUFafwXmyVKJPlI+xss1pQusN6sm2FhPGImBL
 iAxV9pZRZvgvRpmKhZeK123fX7u9s1LrlXKadLLypvNTPJQBL6no9Wg5kCUw15BX5dnVTGSDRM4
 XmdskYeCHQjWDWpHKZw==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d61be2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=31KvTjPItaxnfPctQswA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: UnXCe2NWL_CiLlutrAAKf8ANhtC1J3ip
X-Proofpoint-GUID: UnXCe2NWL_CiLlutrAAKf8ANhtC1J3ip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..e3f9eefc739
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,97 @@
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
+
+	chosen {
+		bootph-all;
+	};
+
+	clocks {
+		bootph-all;
+
+		sleep-clk {
+			bootph-all;
+		};
+
+		xo-board-clk {
+			bootph-all;
+		};
+	};
+
+	reserved-memory {
+		bootph-all;
+		smem@87c00000 {
+			bootph-all;
+		};
+	};
+};
+
+&sdhc {
+	bootph-all;
+	sdhci-caps-mask = <0x0 0x04000000>;
+	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	clock-frequency = <192000000>;
+	bus-width = <4>;
+	pinctrl-0 = <&sdhc_default_state>;
+	pinctrl-names = "default";
+	non-removable;
+	resets = <&gcc GCC_SDCC_BCR>;
+
+	status = "okay";
+};
+
+&gcc {
+	bootph-all;
+};
+
+&qupv3 {
+	bootph-all;
+};
+
+&qup_uart1_default_state {
+	bootph-all;
+	tx-pins {
+		bootph-all;
+	};
+	rx-pins {
+		bootph-all;
+	};
+};
+
+&sdhc_default_state {
+	bootph-all;
+	clk-pins {
+		bootph-all;
+	};
+	cmd-pins {
+		bootph-all;
+	};
+	data-pins {
+		bootph-all;
+	};
+};
+
+&sleep_clk {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&uart1 {
+	bootph-all;
+};
-- 
2.34.1

