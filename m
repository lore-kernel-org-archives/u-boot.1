Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9137AC54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F6A87EE3;
	Mon, 26 Feb 2024 13:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ilwvpJkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E310C87EB4; Mon, 26 Feb 2024 11:09:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2B087CED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q6mJgK015857; Mon, 26 Feb 2024 10:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=wMnO2qvh+g16xUL1LhRDwWGVcpraif2weG6YsR/GM8I=; b=il
 wvpJkMbnx2uMbKXHQF7dncuPw9T3EkraEBHleV0OZCYiqPdkybDsaJtRsjfRMTQ+
 EbR1av2n/RrN73EKZN/kaY6vfgiFXm4HNwey7WluYfa4Oq/FPHJU5EgPsdAK7AuT
 D1ZPqcCUMmZVqQfEKPoaXdvPD6ivGdhwV6hwW4Qh6VfF0svU/0eDc1QZabrIVp3X
 fE+WWd9f/LyHNNxexq4w5bWWNG2LSbvY29JpVilAg2YRguzRsIO4Q2RGu7+9pmWj
 i6lt0duXkjrnnXOVFbC2ggXXHbrFnSHlvpgg6eMHsdAMdBV+vRljasaKQ8yZFkE9
 XVACcQvkzbz4LQ0FjS1g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq0jdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA959P007711
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:05 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:02 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Lukasz Majewski" <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, "Sean Anderson" <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] clk/qcom: Add support for clock registers in IPQ9574
Date: Mon, 26 Feb 2024 15:38:00 +0530
Message-ID: <20240226100807.1095607-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: mCIFv-DzP3x4KrOL-RxpxWGITbBoGRBP
X-Proofpoint-ORIG-GUID: mCIFv-DzP3x4KrOL-RxpxWGITbBoGRBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxlogscore=913 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260076
X-Mailman-Approved-At: Mon, 26 Feb 2024 13:01:24 +0100
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

The BCR registers in IPQ9574 are different and have
different fields. Add function to program these
clocks accordingly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 drivers/clk/qcom/clock-qcom.c | 32 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7c683e5192..fe60490186 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -156,6 +156,38 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 	clk_bcr_update(base + regs->cmd_rcgr);
 }
 
+#define CFG_MASK 0x3FFF
+
+#define CFG_DIVIDER_MASK 0x1F
+
+/* root set rate for clocks without the MND divider */
+void clk_rcg_set_rate_v2(phys_addr_t base, const struct bcr_regs_v2 *regs,
+			 int div, int cdiv, int source)
+{
+	u32 cfg;
+
+	/* setup src select and divider */
+	cfg  = readl(base + regs->cfg_rcgr);
+	cfg &= ~CFG_MASK;
+	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
+
+	/*
+	 * Set the divider; HW permits fraction dividers (+0.5), but
+	 * for simplicity, we will support integers only
+	 */
+	if (div)
+		cfg |= div & CFG_DIVIDER_MASK;
+
+	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
+
+	/* Write the common divider clock configuration */
+	if (regs->div_cdivr)
+		writel(cdiv, base + regs->div_cdivr);
+
+	/* Inform h/w to start using the new config. */
+	clk_bcr_update(base + regs->cmd_rcgr);
+}
+
 const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 {
 	if (!f)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 01088c1901..95f6162ea4 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -32,6 +32,12 @@ struct bcr_regs {
 	uintptr_t D;
 };
 
+struct bcr_regs_v2 {
+	uintptr_t cfg_rcgr;
+	uintptr_t cmd_rcgr;
+	uintptr_t div_cdivr;
+};
+
 struct freq_tbl {
 	uint freq;
 	uint src;
@@ -86,6 +92,8 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 		      int source);
+void clk_rcg_set_rate_v2(phys_addr_t base, const struct bcr_regs_v2 *regs,
+			 int div, int cdiv, int source);
 
 static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
-- 
2.34.1

