Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC6F44857
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244968418C;
	Fri, 10 Apr 2026 14:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKhTaOGh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bsHa9uoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653A184106; Fri, 10 Apr 2026 11:12:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D6E83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6rxHa2624721
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zKRt7BT5TAQ
 tWdKbkNau9K2XsZ8OB5uiCtTkzod3bfU=; b=FKhTaOGhMWSlSgc71zCWCP80zry
 2I553e0lTrz8PsFT5Hugbt6RQtAWWBYXbs0rUai5f5KTP0D4jgSqyFnlcyH6msBs
 BZMaTmrRw/E4y8Fwi5E1JT+rgjHRhj03I5zN1aJ1QtzJwgCLTtSUffiNHFg/Latz
 dmzqRWJk65UdBxR/KnhcYtrRKS1E2YhdcpqXXtAhXOSkxv+vCCNSQTj2nvgtUlZQ
 5UxdOhI8UAPtwU2l8sHnNyca1wPxljeRwxM5ioh42sm/uahknvhpYBE9Cj6w+vKB
 Fjm0RL9hwrbRCzi+ywYPm5dTgI9TU0ZuVeW4hkoo8Pah0na1019UlS2pMTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu3hhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d93a8149bso2092580a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812343; x=1776417143; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zKRt7BT5TAQtWdKbkNau9K2XsZ8OB5uiCtTkzod3bfU=;
 b=bsHa9uoy6XugBubUV5EpgCZVGOeojHwHvQSSUuP3FcZShd5TYksJFstsJlQqD/oA2j
 N8Y6pWU0XvMh35JfeGE6RbmUpZrtgoe1eOgdGPBpQUEVU9BALVQ4eXn2envk43+UjCbX
 NBZoLa9mAluFt2/6WsGNcrrjVo2UcrOzkOeKJqmTzB+G9t6o261qlfG7smxv9HZD4rtP
 zU5CyTqMUlpRmzvWTRAHWmCtzbjma6BvYkBkR5g8IHt1tO5SXkcohfNYK0lzpwBjzEfo
 iR1nkKEOOxVhR/Zk/mtnHSwH2OPzR//gHLvFbYd/GTiERUSWEkAys3UIR9Itt7CvaVBF
 L/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812343; x=1776417143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zKRt7BT5TAQtWdKbkNau9K2XsZ8OB5uiCtTkzod3bfU=;
 b=NXloHikpLKxVDAtpj5tPi/0rC8cQ5B27r+K7FrF7kZH1xrFRW1lnjgGC8NBn7FRUtL
 b9wxMtRfqIpwUeRlYsCvBHTHL+xawxkcBKAqWctwbhqNzhBzIOlSdzFCgRpCeGmQm9vq
 eE7wzlfcWV94Jo7JzMePqAr/c0ebKripYDm0N7ImCjy/vr39bAhJOCoXD0e4eg5iQE9H
 B3KTw2+Y9gJfjcJCK1MlCIfRzXRDJsw7rCR+nMLStm6IwGmOF4EWwraxSBIDJk9bQ9p5
 0uIBJByqVWMjIBJspbc7XhjlmdLVAB02CxQ9+2R10PEO9bYyebqkPK5BeAggkfztUHV1
 EEbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4/A46qokerCYrpd1odCNweR1/sF6uoD1EBcZWpOFtmej13GquUEUV2Pjla2aqa9yXkEEysxo=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ26Jv9bxB5/HvLqxzvjkM5nkIFfRX6T/XT7ZXj+B+VDD1cj8z
 fT9AGU8yF80rlARBOahfKZqI19VUnuHe6JNgDV25JrRiRcuWxamz/2lZCQh8HHXM4FRye7Fy28M
 FfMfXJzgDQoW0v1Xi/0NJIFbBg0QTbDufKnUvQFV4qwMPikhVunRn9nIh
X-Gm-Gg: AeBDiet9sgaXRWY5lOI5qDW/AZ0JHL0nvyT8WRp8XjqVe7BrFhBvfmo10yjmMi06fo1
 q79fuSjdgIjwchpWh40Ho6SLGy84ONBOalz+P+Z74t9AzHWZQNguKDK0itnzM53gMQQHEz9y+Dh
 DuJ8thfPRQGpgVmIjBfP1Y8qswu9+QqnMX4ch4lT1eTa8L0mKORgkyqoht3rD2Mho5TR8fd/KP7
 k2eM0FYV/VFnAIAH4XPs+J4XzHjMJdNWwt2lKOyv4BAtBf/UczeAwSg/zWPnTsUqlnVhq8c8hoQ
 bmoWPSYlTwHyK+oKYXn0/3hmqDhsWXtBCqy4lwf/zz7AJLHV9bbecXkFs9XVbmeVy2xI7k/01HF
 s4ZLXbdCkg7YaQ+pcis1An126QSOyEhK6/hsnBIvCip/RI8Tf99sd4w1HZPIdBQIOY4RM83gZU4
 IP7/eYIDyD3L8XHD9g7i2kZ27tCeLmuEMuxlJORJ9f4vXF8NDw/2c=
X-Received: by 2002:a17:90a:fc4e:b0:35d:9fe9:f830 with SMTP id
 98e67ed59e1d1-35e430e512cmr1723795a91.12.1775812343456; 
 Fri, 10 Apr 2026 02:12:23 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4e:b0:35d:9fe9:f830 with SMTP id
 98e67ed59e1d1-35e430e512cmr1723760a91.12.1775812342955; 
 Fri, 10 Apr 2026 02:12:22 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:12:22 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/9] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Fri, 10 Apr 2026 14:41:46 +0530
Message-Id: <20260410091154.1001021-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vRPIfuqs2IGwV3xq20AIRkgLBfF6guaj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MCBTYWx0ZWRfX4W4sdLN9HQi5
 toCIqO65TBxttQ52/jrfOKKJ5ORcoqzVE1EbGl5OflkpeGPrPbapW4aJr+35t+zSUxh/gK7JHGR
 zmbRX2jd3q/8/J5uYCTH+OPZkxKot9LhwsGRiUM132KmwAmIdxgC+xGncmVrFvC3SyHhSyNLcJW
 9/hPl/NNG8Cop0sXWqdi+NnaQitFbFhnyFHyn1n7ocAW2+CuADhD3pG6LwSGCEoZDeQF+wqVKPC
 I4RoWmYitclbPzCCqEKM3Ni25ffC74a+V1Pet7nHBmfQ0/t8OzjysI5MNAPtgH/d8m6IV/CNKN7
 DtZYaxd44/0teq/m0TwXsEqe/DQeH+3xbGB2l2d1WWUdWIiiXROREa7VuwnVq9EpRzlew6Z7MU2
 H7t2qNKhhr5PCXQBoHvBa+hscs0fwYy5dWMGx8tKaJPxJJkC3JHSkruJDEvd30xS4JOO+ncC6kD
 ViFetMWQxgo3oXGpw4Q==
X-Proofpoint-ORIG-GUID: vRPIfuqs2IGwV3xq20AIRkgLBfF6guaj
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d8bef8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TrNg8JIv_C46ov8ADgEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100080
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

