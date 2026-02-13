Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F12EF48ED
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9F183CEE;
	Fri, 13 Feb 2026 10:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZ1m3Xek";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QUhdeSYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21E283DBF; Fri, 13 Feb 2026 10:01:56 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA8083CEE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D67HLF421513
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 751g8lwaB5zqr2Bq262wDNEX5rVO7wZetyKoerX6/E4=; b=WZ1m3XekLMC1XKHs
 96/FwmcMrv+YTKTcZAbMfH3KmWiRd0ox5MDuIN8vY4G9wuct2kTBeSSwntBP1R87
 U4nuCVCVXkxuX8xpCURETV3zDZPBjCqjccvT28reNrhVyeJ52o8RdUfzHEqb+hb/
 UYU3O/Wr+qbb0OVHLMnGB+XSFcazF4GNy0KMnTfkcSNXpAJ00V3tIvSFsC1uqBfK
 zfyPuc6M3oWmPxrRqEA/luiYbfkrTd4hrloLlcM/6CSA5mDKyu/jtBuKcU4Lg/o9
 bO50p9GPxGCC/bmeODq19legQ3KQGiEdj7G+1OuCVlcIXdTNKHJpEPOK7ltuyOsV
 76BhPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy4ccjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a94369653aso7535145ad.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770973307; x=1771578107; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=751g8lwaB5zqr2Bq262wDNEX5rVO7wZetyKoerX6/E4=;
 b=QUhdeSYOU1T/wfJqji5pHa1XZv3H+WxxUjtft4Oud9o87NHJOUIrJ5Nz+L64boikoE
 Fii3oGAgCVLmEk1/Q8pZnk0ASu31Gy1XG/xJhZru6Nqxo+1Z3uuYkgTXp8Q0UmC/b+t+
 lcdBMaFD6KfrWM1Pr288mnPppG87XYJTlfRMnhOZhG2C/oyHHONqxJGNbnTOHFV3CNXS
 wXv9s1gnrP4dLE3oFPa2LmrVH8Fd8kNYAIpiFd2jXMMLz2sAnA2JvQ54J/XFyq7F/WdL
 2PtYh401b8zOgEXxG87Pj8SdJ7RhX4WNGvNe4AiAUzX0WBFyTyFWFtue7XVaiFpuxvBD
 XDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973307; x=1771578107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=751g8lwaB5zqr2Bq262wDNEX5rVO7wZetyKoerX6/E4=;
 b=HRRFB5u3bbrmbggNEbC5nddriOizQqU50JRpFA5GKUxQ+EB5r0oY+XtQsQcFpYu3rf
 XhF8Y1CaA7tkBqZPRSclTqt6qbQHqAorgCLbDYlFQ/9LjHHuw2g1z31PbJGmIybF+rjF
 xij5Fm6oFuwrpa4kgFb4yV3zkYvGL+s/PSkZpR9eVa/CSWFSzt9u4S9FPQsvz4Q06ib6
 urbeKJZfxaVGjgvNoimfxmInZMI6/RGbyybyiDPcK+RxOTHwtUfz1V1MDANgT7dX9ZxJ
 0SswjggJYqv7/j+Y7X0qxiHcYSdnGnlzw6GINzyPhmRCL36gcoYp2Kpqpn4mf+6gq17I
 Lh2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+Jq3CmjHlfadnIbBNnRf+dY/rkHamIBRvFlxMR9PLChpMuDcX+hRBctI1qz4Rx5//lzqj6w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/2egYEEsvc9DHtY2/qOX2AakmBPW6J4SnenLNPqfz+lfPDBs2
 xOxm1N4FiqcOaifKHf9px83BMipslpbwAXkyEzyDrTGvs1HC4FDQ/TAGGYTnse4BHm9a2BvPSSU
 qzSdaozLjTAG87kqQuw3GH//Mv0ALmf5YHIzgyQUUJ5xgVRZlgo0Twq/Z
X-Gm-Gg: AZuq6aJOE0XJnT/9CyLKHEIH29iBZDaWfBGdtiwTLxCw7hncZX34091mHUOid4i2zhg
 SoXr6yDhukcAI5yBAaEFV7OmBqz7y93kQrLAj4zHOfc1QcCSN+S+7wG7nWp/uMiJwbAI0BVspDh
 yU7VmKprvbKzMEl/nJ8EYoLNUPWgDHlTlDNo2kpchyCeChwunKsEg4wTb+cAhJvbXfXDpdnh7ls
 qkCFnPoX6l72oufzUP0dcWcBTBKa/O7Zovz9CSuC16KKkXKokOXvJZcGCkQ7Q1t5O2ycleOLuaG
 AIHDnBT/KkPjAFuVMDk53f5wC5YUN5J0FKrZKKbfc6aHzB/DK9KnD+HjRybDz5eZ7ln5ZnPWW2M
 NFBQqYwfG2w/MUVQT2R3XKASJjni5ruj3P4bitfrGQ0TzYqar7lMHJpKaZtxhM/VeoDIoeMnVFw
 bRj6xcMmyHR2ZILSkzxlCJeDAFkFKMbEs+OfDbaIBIJfLjODWUXQ==
X-Received: by 2002:a17:902:e74d:b0:2a0:ba6d:d101 with SMTP id
 d9443c01a7336-2ab50557d98mr10189495ad.21.1770973306884; 
 Fri, 13 Feb 2026 01:01:46 -0800 (PST)
X-Received: by 2002:a17:902:e74d:b0:2a0:ba6d:d101 with SMTP id
 d9443c01a7336-2ab50557d98mr10189215ad.21.1770973306401; 
 Fri, 13 Feb 2026 01:01:46 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29965055sm77524755ad.53.2026.02.13.01.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:01:46 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 14:31:19 +0530
Subject: [PATCH 2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-talos_usb-v1-2-4c4355d61437@oss.qualcomm.com>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
In-Reply-To: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770973294; l=1274;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=HxPp74m9ZX55GzXx1OMevdqd0SzWUjU/KSSnail8szQ=;
 b=Kuer3Bx3bkPc4nSVCCIq7fIb5F3UUob665/AEO4DfwzEMXIoGN300iOTitDwsVc0ow/RJQDL4
 vX7PI3+54vGAk2Q6Xkl/VKGuZf3UplFx+/KrHC8VpthJLFuWcux+HnG
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: VAEUhUEbRxNjhIDGuMpCEveE1MOsfcV0
X-Proofpoint-GUID: VAEUhUEbRxNjhIDGuMpCEveE1MOsfcV0
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698ee87b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jvnA7breJFyUQw32XGIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2OSBTYWx0ZWRfXz/EvUuxtEUQO
 zp4FZ5hwE545EKO8/epBtORSNhctFdRxNDt0a+F8Ij/u9x9gihr83y4pmiRMqOY9yVTVr39bGGw
 yaff/ITjPBfqpNYpHdpW8ejYe2zA0v47rf71QeFlq3Av/+/1TfTMzJOayoboJn3GhLLXcsrCYIo
 RWA2kzvaCcAsiAe3VHmoei4drAOinR4gg7I9kxQ2R/eIadmzqM8mHL/sqYK4TuslU1OC7HA7zwi
 qMy2pu5aGbe2jifTTXUSZAO+Pybp2tEWbZiVkvzcH4yxIGP0d9of2MC7jFATfH0qGuFVtxOsSrn
 v0R5gPS5Uc8uVU/Fq3IyaXfBWAYOH/1+RkrFyi3hua+E5p3sbACg7EKjUdp+7T87ACHjQVodVSZ
 2xt+vZZI/tBL6DygH0rZjtHgGv7M9LyK9DVMKQHLoVo9G0CR+JQFdNLpcsc78EyRrbwOMfbfTAF
 dKH4DAy2uWdHU4C3qOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130069
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
Changes in v3:
- No changes in v3

Changes in v2:
- No changes in v2
---
 drivers/clk/qcom/clock-qcs615.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 65b8db04020..2087fc38f63 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -67,6 +67,7 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0)),
+	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),

-- 
2.34.1

