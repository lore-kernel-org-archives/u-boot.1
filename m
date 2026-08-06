Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AABFC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56EB4406EF;
	Thu,  6 Aug 2026 16:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jubZS9w4YqrX; Thu,  6 Aug 2026 16:12:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE35140738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032771;
	bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PRk4D+Qidzczh8xyrNPDddfrieRuCT4IWoi9XmEW9MYyTLyrT3IVHIR2GlYHL/laz
	 1kgrH3NegRTULT2cBvVKhUjM9XUR6WcE9eljB8tn/bxBSf7L6oawHyHpbAnltM6OoC
	 PO4CSz/iU51S+pmMyFJKYb7REPTdJb+GROWCNTXNhL5KJyqs6mhGZcPRyV+B1/MBaZ
	 8+7wuDJgLg/j+RhnWoTwJHPSBNldG5gAtSB8J5z/C2gpXF1EDw5phJT2DqzFkNlkV+
	 nNsvig2/eMUPyXycCc4KrnlOu12Fyf59QLrJnh/apxgRDAUdutW4mWXO5looupD0+E
	 Z5yv5sKgrHevw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE35140738;
	Thu,  6 Aug 2026 16:12:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 900E12B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 765FA402A4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNFjz7IOy8Li for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:12:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 06E80400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06E80400D8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06E80400D8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmlSd2808250
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:12:48 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq732622-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:12:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso2982741a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032768; x=1786637568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
 b=BNSLvj6EY9tYIfCPwlpN99uRVlyORq/L/Loc3g5OE8d8e9y62gvNRDG7d+FI8FyEae
 4nUL6QJNJluXDkuWrcc3DAnIeolCI16mWi/XmIF6ePRDVOKr8v8zHn5lVbqZPd7onHjp
 3R75Pjl5A7ynscHYdKT4e3MwbVkgtlB0DS7q5bGnM8PCSiVCjVkNUMMjmyXKp2nXzV/X
 WC+vxBkcruikOOOuhEkGQOr1LqpIxOT8TLuoGLC3iRELb5EdgvRiS/XJ/fM2kr+MpUGO
 t6ypz67dHeVXENlcGijUAq1wLD4RNdsSkpWKmULv9Rf+xYdrc8BA+BFHG2b0pKHP/QAw
 PRqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqR1ZmQ6FYGzdwTIXEgmj8VbWa/6/AEQGCeTzNou37w4rWILKY/7LAoCJj7LqjJkO/VP/mAu3Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzJxnnaW7IbAjvx2+/nrvl23UQtJTac7oNdnWO+TyuhXrywXEyO
 hToyD/VU0DZcdPE2GN1kWG2pxb8ySywTRU3FeLKWFli71LvVldlBTJwPBeLLjlmm2SLC5WdWQrc
 DgB9EqM2J4WS9fkZUMQnG25xwitfJZ0TZWRaejVD7/at4QFI24fKkSM+pWJnhixUdYY4Wp3o=
X-Gm-Gg: AR+sD13TlHMXhPQqQS1kGgaUv7pbKFhGZsksz99VSQYKuhpeyBhbTZtCseRHkSyvShQ
 xXe0VJ80kUxNwyQE0/gHvKbdxMM6cH5l+ih+kUMTJWAkefN2VGpNsHFUvc8T7ZTPDPZbBFq/zlv
 6Xr6ZnjOiMf/92A30XE32mScfdnHsPMgfd904Gb3eCgGCbl/iKnta1tBUA80/sR06+JnL//RlE4
 tFm2SMSTNhlUO/6lFk1A9+Dioy1l+077Vs+eWJOtBDdZFjPE41QFn0HQLg5aCtnsYVRSPy3I4uT
 n9nCiwGaAe9kC0+DKlU1bNcGefEwxxSv3INuol02X19xr6wkoTKaS7CElUpsDGpdCgboCmudwcd
 ESxJFQhSZzk0fQohcg5kekWmBsdTslIZ/QQcpQgHmsUXtFHB2WxcVCqnfGD9rV6lzb/4H17j2X/
 tx4fIeFgqCUyWOdytPEz5gKe0o9psa
X-Received: by 2002:a05:6a21:3397:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cb85ea62efmr17657196637.29.1786032766320; 
 Thu, 06 Aug 2026 09:12:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:3397:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cb85ea62efmr17657106637.29.1786032765747; 
 Thu, 06 Aug 2026 09:12:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:45 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:19 +0530
Subject: [PATCH 2/7] clk: qcom: qcs8300: Extend GCC clock driver to full
 gate/RCG coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-2-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=27701;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=J3TFENiXjuJdDdZ5R19hpWH5pSHYHvlTouG8piGhuHA=;
 b=76hZulxpGOCMe9EjIm32g11pk+7BSgLtV7w8vsDtDmfbcyXI+VoMCkEZnnoUD6qMpY9qkbsAc
 HgBUX2yJof6Bh9pshvcywVPYGo05z969a3s6yEYB11PvKdAdNF9tu+h
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX+x9/yNs5Smer
 QmI3amfnSZvccIrPIxF4B0AZYxxWk+TpF+1bk5+zFbO3UCk916ows9WngUQamZ56sl3JWjkKnkM
 cu/kOsh7Kxm2Vy6xawlwAxJYX2YcmCT+Um8pyf3tfGE4/+McWh729seF7tp6nMlM7zz0/ig4+hJ
 yAcHCazC7CsJ90RGyTwTegu43BhwFKti2FKn6TXKxAaQK8i0tje7EnaDj5j1vbVH8KyxnanpgXp
 PQGkSe3fDZjVDZTO1Ub/T/i2FCXIOLSObFONMgO39vSwG79dFrYtYdx26qjok3trGtxiuOoGLWz
 bmrPd/FGfwVw3Mp7iFGl1w+m8yjhynaG151oVKOJHQJwrwVp4lQ5kE0QW7UHlowHn1m6cR38ikK
 1d/K2kKVqhZlA3+PF9BQrUyH53wWyZ5p5fmz7hcb33bjbQ59C5y4LREvy2QYLySR6y4mV2jGx58
 FMhlFVuIBBzlueIZiQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX0FSdYhOOPTr/
 YECPBDN90RNr7xkCUy7ig3v5Ct/POEJ7Ci7ip+jEhS+XemXLRcrMmYyHGHjINMVBxkOJ7bIsbIK
 iL31YiWZdUApNnO3y53OmZX8v0pGvrw=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a74b280 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8KRvGpLnRcE-MBQpGOYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: iVnziyNPXU3TYFDVENeom8hxVisckKV8
X-Proofpoint-GUID: iVnziyNPXU3TYFDVENeom8hxVisckKV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=; b=Nn66sVcDW2NzEU82
 yf+YYn7dhKdqxDKfykNZi6x4NSz51f3Djec7MwfWITK8eq/Uz/YcdzD7mpZD0IiS
 YRoX2IQciy9hhoVVx3/z4kZ1T4nUenYEZros8pRNiR8gpJEFSHMbZyupF5yXycfg
 evT0drP24XXPDcT2kQPAC2NcH4AcZ8WLewGIJJYE0kl8QSU/R34wm92fA+0M65Rw
 ech4twpZO+7om7Q6Lv2u6yGDcvV88ZTElinLaMRezIYFcSVl+qUe+vQh0d+KvdG4
 1z1D4GRmkchqbyBGP1kJGvncd7WMvG6YatMuKtOBUHxkDP0BG9CFcZ1Wvl8+3QI6
 ORnKeQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032768; x=1786637568;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
 b=dKz8yyZtOb9U5hdoVAXLRnLAQ0+wobKn+jQ0Rx+DxlJQH5tSGtwlTKzwoCA7kjcDrV
 QzUM7XxpXG4HVse6BD0qmYjsYaI+XrVk2vRnlkxbEzajlL5fl3/3j2dtIpvTMw4BsKFI
 QpvX9DBPY4El3KyMjJo1JTCet8JYPOsNlQhJeelOpvnMb3rbOyoJpJjJNrjjga8C0DJk
 /p9raRYU4++6RxWEVmy9HTaO4Xt1RWRXf8GN6H2/x20WkZju2QS8O7zWnHv7MvTstq+e
 gk4asmushxBneGFm6FkKTTG42CYwz1Dvn9grgvGq8EtjdI6LQVP6aM6JfR0wxB0wPJaG
 cdtg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Nn66sVcD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dKz8yyZt
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Extend the QCS8300 GCC driver with the remaining RCGs (USB2/USB3,
UFS PHY, SDCC1, QUPv3 wrap0/wrap1/wrap3 SE clocks, GP1-5, PDM2,
EMAC0, PCIe0/1) and their gate clocks.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs8300.c | 545 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 525 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf788..cd47b384f1f 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -14,12 +14,210 @@
 #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
 #include "clock-qcom.h"
 
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define USB20_MASTER_CLK_CMD_RCGR		0x1c028
+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0x1c040
+
+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
+
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+#define SDCC1_ICE_CORE_CLK_CMD_RCGR		0x2002c
+
+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR		0x23154
+#define QUPV3_WRAP0_S1_CLK_CMD_RCGR		0x23288
+#define QUPV3_WRAP0_S2_CLK_CMD_RCGR		0x233bc
+#define QUPV3_WRAP0_S3_CLK_CMD_RCGR		0x234f0
+#define QUPV3_WRAP0_S4_CLK_CMD_RCGR		0x23624
+#define QUPV3_WRAP0_S5_CLK_CMD_RCGR		0x23758
+#define QUPV3_WRAP0_S6_CLK_CMD_RCGR		0x2388c
+#define QUPV3_WRAP0_S7_CLK_CMD_RCGR		0x239c0
+#define QUPV3_WRAP1_S0_CLK_CMD_RCGR		0x24154
+#define QUPV3_WRAP1_S1_CLK_CMD_RCGR		0x24288
+#define QUPV3_WRAP1_S2_CLK_CMD_RCGR		0x243bc
+#define QUPV3_WRAP1_S3_CLK_CMD_RCGR		0x244f0
+#define QUPV3_WRAP1_S4_CLK_CMD_RCGR		0x24624
+#define QUPV3_WRAP1_S5_CLK_CMD_RCGR		0x24758
+#define QUPV3_WRAP1_S6_CLK_CMD_RCGR		0x2488c
+#define QUPV3_WRAP1_S7_CLK_CMD_RCGR		0x249c0
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4158
+
+#define GP1_CLK_CMD_RCGR			0x70004
+#define GP2_CLK_CMD_RCGR			0x71004
+#define GP3_CLK_CMD_RCGR			0x62004
+#define GP4_CLK_CMD_RCGR			0x1e004
+#define GP5_CLK_CMD_RCGR			0x1f004
+
+#define PDM2_CLK_CMD_RCGR			0x3f010
+
+#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
+#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
+#define EMAC0_RGMII_CLK_CMD_RCGR		0xb6048
+
+#define PCIE_0_AUX_CLK_CMD_RCGR			0xa9078
+#define PCIE_0_PHY_RCHNG_CLK_CMD_RCGR		0xa9054
+#define PCIE_1_AUX_CLK_CMD_RCGR			0x77078
+#define PCIE_1_PHY_RCHNG_CLK_CMD_RCGR		0x77054
+
+#define CFG_CLK_SRC_GPLL4_UFS_ICE_CORE		(3 << 8)
+#define CFG_CLK_SRC_GPLL7_EMAC0			(2 << 8)
+
+static struct pll_vote_clk gpll4_vote_clk = {
+	.status = 0x4000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(4),
+};
+
+static struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(7),
+};
+
+static struct pll_vote_clk gpll9_vote_clk = {
+	.status = 0x9000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(9),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s2_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_gp_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_rgmii_clk_src[] = {
+	F(5000000, CFG_CLK_SRC_GPLL0_EVEN, 10, 1, 6),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7_EMAC0, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(201600000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 4, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
 
 static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n",
@@ -31,28 +229,315 @@ static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
 	case GCC_USB30_PRIM_MASTER_CLK:
-		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
+		return freq->freq;
+	case GCC_USB20_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
+	case GCC_UFS_PHY_AXI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_ICE_CORE_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll9_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC1_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, SDCC1_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_GP1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP1_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP3_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP4_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP5_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PDM2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pdm2_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PDM2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_EMAC0_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_EMAC0_PTP_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_EMAC0_RGMII_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_rgmii_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_RGMII_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_0_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_0_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_0_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_0_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PCIE_1_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_1_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_1_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
 	default:
 		return 0;
 	}
 }
 
 static const struct gate_clk qcs8300_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
+	GATE_CLK_POLLED(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, BIT(28), 0x8e200),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
+	GATE_CLK_POLLED(GCC_AGGRE_USB2_PRIM_AXI_CLK, 0x1c05c, BIT(0), 0x1c05c),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
+	GATE_CLK_POLLED(GCC_AHB2PHY0_CLK, 0x76004, BIT(0), 0x76004),
+	GATE_CLK_POLLED(GCC_AHB2PHY2_CLK, 0x76008, BIT(0), 0x76008),
+	GATE_CLK_POLLED(GCC_AHB2PHY3_CLK, 0x7600c, BIT(0), 0x7600c),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x4b000, BIT(10), 0x44004),
+	GATE_CLK(GCC_CAMERA_HF_AXI_CLK, 0x32010, BIT(0)),
+	GATE_CLK(GCC_CAMERA_SF_AXI_CLK, 0x32018, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMERA_THROTTLE_XO_CLK, 0x32024, BIT(0), 0x32024),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x1c060, BIT(0), 0x1c060),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
+	GATE_CLK_POLLED(GCC_DDRSS_GPU_AXI_CLK, 0x7d164, BIT(0), 0x7d164),
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x33010, BIT(0), 0x33010),
+	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xb6044, BIT(0), 0xb6044),
+	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x70000, BIT(0), 0x70000),
+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x71000, BIT(0), 0x71000),
+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x62000, BIT(0), 0x62000),
+	GATE_CLK_POLLED(GCC_GP4_CLK, 0x1e000, BIT(0), 0x1e000),
+	GATE_CLK_POLLED(GCC_GP5_CLK, 0x1f000, BIT(0), 0x1f000),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x4b000, BIT(15)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x4b000, BIT(16)),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CENTER_PIPELINE_CLK, 0x7d160, BIT(0), 0x7d160),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x7d010, BIT(0), 0x7d010),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x7d01c, BIT(0)),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_AHB_CLK, 0x7d008, BIT(0), 0x7d008),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_CLK, 0x7d014, BIT(0), 0x7d014),
+	GATE_CLK_POLLED(GCC_PCIE_0_AUX_CLK, 0x4b010, BIT(16), 0xa9038),
+	GATE_CLK_POLLED(GCC_PCIE_0_CFG_AHB_CLK, 0x4b010, BIT(12), 0xa902c),
+	GATE_CLK_POLLED(GCC_PCIE_0_MSTR_AXI_CLK, 0x4b010, BIT(11), 0xa9024),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_AUX_CLK, 0x4b010, BIT(13), 0xa9030),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_RCHNG_CLK, 0x4b010, BIT(15), 0xa9050),
+	GATE_CLK(GCC_PCIE_0_PIPE_CLK, 0x4b010, BIT(14)),
+	GATE_CLK(GCC_PCIE_0_PIPEDIV2_CLK, 0x4b018, BIT(22)),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_AXI_CLK, 0x4b010, BIT(10), 0xa901c),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_Q2A_AXI_CLK, 0x4b018, BIT(12), 0xa9018),
+	GATE_CLK_POLLED(GCC_PCIE_1_AUX_CLK, 0x4b000, BIT(31), 0x77038),
+	GATE_CLK_POLLED(GCC_PCIE_1_CFG_AHB_CLK, 0x4b008, BIT(2), 0x7702c),
+	GATE_CLK_POLLED(GCC_PCIE_1_MSTR_AXI_CLK, 0x4b008, BIT(1), 0x77024),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_AUX_CLK, 0x4b008, BIT(3), 0x77030),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_RCHNG_CLK, 0x4b000, BIT(22), 0x77050),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x4b008, BIT(4)),
+	GATE_CLK(GCC_PCIE_1_PIPEDIV2_CLK, 0x4b018, BIT(16)),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_AXI_CLK, 0x4b008, BIT(0), 0x7701c),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x4b008, BIT(5), 0x77018),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x9746c, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CFG_CLK, 0x4b020, BIT(15), 0xb2034),
+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x3f00c, BIT(0), 0x3f00c),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x3f004, BIT(0), 0x3f004),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x3f008, BIT(0), 0x3f008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x32008, BIT(0), 0x32008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x3200c, BIT(0), 0x3200c),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x33008, BIT(0), 0x33008),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_ROT_AHB_CLK, 0x3300c, BIT(0), 0x3300c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x34008, BIT(0), 0x34008),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x3400c, BIT(0), 0x3400c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCPU_AHB_CLK, 0x34010, BIT(0), 0x34010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9), 0x23018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8), 0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10), 0x2314c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11), 0x23280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12), 0x233b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13), 0x234e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14), 0x2361c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15), 0x23750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16), 0x23884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17), 0x239b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18), 0x24018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19), 0x2400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22), 0x2414c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23), 0x24280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24), 0x243b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25), 0x244e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26), 0x2461c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27), 0x24750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27), 0x24884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28), 0x249b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24), 0xc4018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23), 0xc400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26), 0xc4284),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25), 0xc4150),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6), 0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7), 0x23008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20), 0x24004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21), 0x24008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27), 0xc4004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20), 0xc4008),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x20044, BIT(0), 0x20044),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x97034, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0x1c018, BIT(0), 0x1c018),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0x1c024, BIT(0), 0x1c024),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0x1c020, BIT(0), 0x1c020),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
+	GATE_CLK(GCC_USB_CLKREF_EN, 0x97468, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x34014, BIT(0), 0x34014),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI1_CLK, 0x3401c, BIT(0), 0x3401c),
 };
 
 static int qcs8300_enable(struct clk *clk)
@@ -74,11 +559,27 @@ static int qcs8300_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP0_S0_CLK ... GCC_QUPV3_WRAP0_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP1_S0_CLK ... GCC_QUPV3_WRAP1_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_2X_CLK);
+		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map qcs8300_gcc_resets[] = {
@@ -112,8 +613,12 @@ static const struct qcom_reset_map qcs8300_gcc_resets[] = {
 };
 
 static const struct qcom_power_map qcs8300_gdscs[] = {
+	[GCC_EMAC0_GDSC] = { 0xb6004 },
+	[GCC_PCIE_0_GDSC] = { 0xa9004 },
+	[GCC_PCIE_1_GDSC] = { 0x77004 },
 	[GCC_UFS_PHY_GDSC] = { 0x83004 },
-	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
+	[GCC_USB20_PRIM_GDSC] = { 0x1c004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1b004 },
 };
 
 static struct msm_clk_data qcs8300_gcc_data = {

-- 
2.34.1

