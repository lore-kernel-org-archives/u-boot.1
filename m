Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9653D2ED11
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A01E83A2D;
	Tue, 20 Jan 2026 05:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCTMqIHK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JJdC5PXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A008683A7A; Tue, 20 Jan 2026 05:26:10 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8BD8063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JGo2qL1904978
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PLC6sKBHiyX
 bWN67l9/HdBiVUrNtJlcr3yjwzFmoiCw=; b=XCTMqIHK92GgthESSHuQoCfK3i4
 ZMKQmha9SpKYfxw3LPsb3Kv2K+IfbDrg1I5ZxIZz5kFsxMej+r5KY1siS2v9FAss
 5OJQ86jB4KN/JjOU73RGgRv6cJYYNvksuqDW9ymYXosfbfhUayF61DhEGhY19ZeF
 vau8HXq5/LsVe7jMFL2/uBPRXErumHlodKPnUPRJ/LoLVblMT3FYt0+17Iye+jBD
 4MUH7NkP/9sMaHy7FZqoVLCJlHkZrDiwDVKAXnGCbxw/mGzDM1RIoBzxVP3BoEuG
 MJS/fRw4Fj8PW53AKSQucDk/nfW4PzZ7KmHrEvEnmRWcoVAoylq1wmdOqUg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmuaypy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a13be531b2so47275235ad.2
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768883166; x=1769487966; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLC6sKBHiyXbWN67l9/HdBiVUrNtJlcr3yjwzFmoiCw=;
 b=JJdC5PXwZlDTtmNibs0HBm4eeUrXtk8miNVbJsa0nnIuGVe0YDckdqxVV2bDlVNqY7
 DcDD+lxpbDP3q/S1bRotuT5Oav1jo0DAtQiHeTcG9R9VRDcF5vjau7GqgoSu72ty2HpG
 0EGH8eP+yRPWvBwEyNfgpHoQ9vKEzaYK5jeYzGeuudCrMwEtBUb2uT2C5R7N1bapZ7qP
 naEw6SKkGeyT9u7HIoTHE9HRfEl/RmQH5NAd+k2zfvuGErb9bIxOZDPfi74MRNG4OEz6
 FbYrjjvwugm0fkWT0Jk7TTvOQwmQjfZDj2OLF/xGKO/r1w/POweXOv1Th02w2o30wrhF
 j/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768883166; x=1769487966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLC6sKBHiyXbWN67l9/HdBiVUrNtJlcr3yjwzFmoiCw=;
 b=JKyc6QI1h9+NT2ctuj04W7lsh44Dyo9g99ujTRaEirRdWK6YB+JKB1v4PE0MyXdJ67
 DpftKp6pJuvJzpC26IImyO9pWcoBC4xjQqX4E12ZU90WVpSLAuEptiZuPkt7zEeEKO76
 lFwHdtdNv/gVDSmfcNdnLqCSjElvG4kYJELcKeuNQj+kf5J311LZwf0bZTqfkPBjv9VL
 fmuJfjIw84gI+NRj+HwQVGbtx68tx1f9Gi/wn54lU9XBKd6ezL0R7fn2HmddBV0G6LGG
 t7O8kdrMoB8mrTNXxDLp2ABXuEdAMDQnfjUmZm8ptTYGz2oE+7PqY9zI4zrYSFxP85H7
 3UKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdgMfBXq+M6wwkt6uwmJj/IQFT5qHHAhN9jSoxgB3PRiX+US2AF76M/J+RXNcTvNxgaIlFxQM=@lists.denx.de
X-Gm-Message-State: AOJu0YwdYbvPmvYOCq9LSPwjj5Dg/hsyNqatRlY6PSQ3SgLr/GPKlnPP
 iIXJlre3N+YDIDsS3H+EmCpZmEBGQ271OiW9JoGALhF2ImSMsDhafEazGJ9wXL3Mp6rhIhgJ37T
 ZCo0TdhcsPvKSr2kxC9wcGEMwXOC4DKiV8iI3szdtC0vpa2Lp+UeZBQ4I
X-Gm-Gg: AZuq6aJCzstOfITLYdG1VVmF8IhohmGo7ojGDcXo4/hbNO03C3slRl94Y/9icIbtNnf
 l9ZLpwfy3kLPN3YJCOQ/rkRFchUZXX1z35xMuGlVkBb/zqeYMg+FVN+d17lBPHdCbS+VuNjrvp+
 VABbAxXoCcX+2QYA1BClOmSed7unwbMFvQFyhcp1tB2jLYneeM7Q49JVqrl8cZ4fic5I4Hu2X3L
 CIDyz1/anlXeQ3RbcJ8XBxYftQKMIJRrXQ5UHHjchk1uplrTGsukYq53bn6/3tHKTM9qtd5qaP8
 4IlfwIm6216hd5i67zhyV7yRUW5Gte/tEvrOxiQi5dYAL/hWcMoDr/QkfNLESP5Ad4q+uxYaBoh
 a+91LjM5Gqt9BFDK5R+jCBgiQFoYw2zBzTC8GyxheYx9VrrG5n7hc2GaT4rw8bJZFDxjvZdH6Vh
 +KqR1gk9LMcQhDQEx7ilWoyITZsoJsvggL+it0hA==
X-Received: by 2002:a17:902:d4c6:b0:2a7:5171:9221 with SMTP id
 d9443c01a7336-2a751719365mr12806045ad.42.1768883165737; 
 Mon, 19 Jan 2026 20:26:05 -0800 (PST)
X-Received: by 2002:a17:902:d4c6:b0:2a7:5171:9221 with SMTP id
 d9443c01a7336-2a751719365mr12805815ad.42.1768883165247; 
 Mon, 19 Jan 2026 20:26:05 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eeefasm107929825ad.43.2026.01.19.20.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:26:04 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 alexeymin@postmarketos.org, nathbappai@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock
 support
Date: Tue, 20 Jan 2026 09:55:50 +0530
Message-Id: <20260120042551.650113-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzNCBTYWx0ZWRfX8lDUrc5Xerb5
 YoKaw1DAFO450bVhWicE8rGDSvZJF9O9Vnq1bjYC+Vsyzh2uXF3/g3Lc7QQ5PdqJSLexmUMj2Ew
 5q3NmFXlk/i3iJzpzEeu0rRyKCtEwjV0xmyvHkH9/ZAwchxqQXy1719zCRbF2ZkKPzM8T1MiBQc
 4En4ulQROmZqbD/ZNER5AWHnzuOJ3fj8wcV7JGmgJ/Bu0JOh/qCaxyx4C7Og+c903NgwHHZDQ2C
 ir3q677oIF5oFnoiNExm0fW4usznghWzPbV0vpBqgMDrRE+ahjeSV5kUUUf3I/nsjGx/tHJt+C2
 0cipQvGH+FDh4y/cnAezRMNvs9bIOzAV3eyL9GRJVCvBdcIC9OL/10etR2ieFVIdee/Ws+JGeoq
 2rtjzOfw9BwHgw8TXHfoRwWqbpDK+r7DrylJ72KUvqtms9XQZ+TTqOT9j5ZjVdUxx3+2opviv7I
 OcYlxzR2DEiZ369J0fg==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696f03de cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=G1K_gZgz9GLba3hnKCwA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cDXlEXTPJoYQ8SsOe8gh1-BDLx879uaV
X-Proofpoint-GUID: cDXlEXTPJoYQ8SsOe8gh1-BDLx879uaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200034
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

Add GCC_AHB2PHY_WEST_CLK gate clock definition to the QCS615
clock driver. This clock is required for proper PHY operation
and eliminates clock-related warnings during USB initialization.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-qcs615.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..2b59c4d13fd 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
+	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
-- 
2.34.1

