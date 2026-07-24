Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADB6C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 10:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E6B860B57;
	Fri, 24 Jul 2026 10:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDAebt88OkzS; Fri, 24 Jul 2026 10:19:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C62676073D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784888347;
	bh=vt3GR0f8qI7CS+tQdkm9MQYHq3RH3yhBXGDGv7zFOpQ=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=NQmWqwwoWRrFmGxiMEYGBJLieG//2kewQHK+/Z/McJREGnzEqTB2EfV9EnQecGLyG
	 RCJXvD4T8wEQcipGciLPhjhtiwwcPUfz40dJPe769hj5Go5MfvKynYJoq+a1jkb2ee
	 u+0n6qDA2TpoOQOP+lVdpPN/HEwSS8atkM1dVW878N9W/76YPrGjT3uTzp+6vSTYQ8
	 Fox7esGC5HPyEv7XmFEEd+87OlTonRy88LKbbAnTvIenseyDAZQMVEcfA0ImPQqIV7
	 VVWz39Adv4qaN5zMk0o9Hey95A846GwySfOViBvZknMObxOWjzhMx2C87YgY8v8Dna
	 AHP+pAqKFkdIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C62676073D;
	Fri, 24 Jul 2026 10:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 979D8A47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89860606F2
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxpKL9VP_WJF for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:19:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A33A16066C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A33A16066C
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A33A16066C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:19:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OAE9BO2889657
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:19:05 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm61kg19d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:19:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so572005a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784888344; x=1785493144;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vt3GR0f8qI7CS+tQdkm9MQYHq3RH3yhBXGDGv7zFOpQ=;
 b=k5CEWXTRFUhyLjSk5kiwj5lXhJ07MGixqhyFlJ9DfEyLMvz1iPevgUx6DFab5ZOoSe
 Pb29YACs8FV8cQKFrOKQ6TrQeWujwfZghIssRVqsA3RTXpLF+NqRdhu6yuteTnaaaLgA
 NN2M+N4ePmDbx7d6sNh76wyeNdwX7NCk+VqCPX0j7taZ+mFc8oDo/57ne9YFA4J/WtBE
 tdQ76titK8+U5LsRvRnS2Oho4i7xpF5LD2AepBTdG/Om4JKp9Yw8ssc2xieR7X2WUrkF
 nWmDdX9jUsbSPkiUvtMCmpNQnYj7tmCAILo7aFAK5Q3ubdWGSEn+PPB1yVRk3EZ+87mK
 BEHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLH53TmkTlylpBNI4Iaf8326f576k6sE+dBt5TPkZXy33OV1y8aEpK9VwDnjf9FH3AakyQdBw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw4MBF0ppWsB83dCkjGSwSj95l6j6JqN3ROtNCPZU1qSilZx821
 MkUauFhQ71dckJCUR2Eu5iKSWEXwW6h1k9uk43DSp9y3m93Bb05BHGEzeHNdJRKn9CjCiX/DL1+
 InonhL01dIAgILLW2EfEVOaFOOh7o4jWVBWZAasLkquhWgJM9IVznVM0HWFhy1Ydv/pwbGYw=
X-Gm-Gg: AR+sD11o2iGjcENL9XF51SZ6jWJO3XmpedMhJHUHUT23TGyDr6kdRsTN6zcYRHICpKL
 iVSWK+d7az4cq/iBym1dKOn6NhBhNX5YgbX2qSz9+koQ09V05zKCswlEoQDin0Wxs0JlbVrWenp
 DuZIk8IFwYQSTAZXAOiuaPhYqwE5s8YOI56svob9KH49vdFTyI20gHq+qdGQNy5NEQ76L5G/WIq
 owQ4Q+VECUTXnedHgiuIMOi8VRl+HHfxXWuJN/SB4+T49QvwZ4qecS1sd1hNOlFIUw54WM0NPT6
 tEhYmeEfYm6ud+9ZlHh2Ag95x/TnwHFAO78jsfReQwlw79v1erMwaWaZr4Ba0OYxET4qDfTElds
 15PcI1tVR1VoQJOnG/2kfJOVQxgLlbxkqsKoXpUshfah+wRb/fQfjSNcq4JXov6tcXqwXqI61zn
 GjVPKw+2TqpZT+5JNTkqjxpPBJfVlA
X-Received: by 2002:a17:90b:53c4:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38ec657558amr7433010a91.10.1784888344152; 
 Fri, 24 Jul 2026 03:19:04 -0700 (PDT)
X-Received: by 2002:a17:90b:53c4:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38ec657558amr7432985a91.10.1784888343680; 
 Fri, 24 Jul 2026 03:19:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130cc5ebsm32438738c88.12.2026.07.24.03.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:19:03 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:48:59 +0530
Subject: [PATCH] phy: qcom: qmp-combo: honor USB-C orientation for port select
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABI8Y2oC/x3MSwqAMAwA0atI1hZs/VS8iohUjRqEVpoignh3g
 8tZvHmAMRIydNkDES9iCl5C5xnMu/MbKlqkwRSmKayp1BEWcsfIPAaBPrkkQk3a6rLWs20nC2L
 PiCvd/7cf3vcDrZLkXmcAAAA=
X-Change-ID: 20260724-kodiak_ss_orientation-b171351c78b7
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784888340; l=3716;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Sl3VhEsV4RjxY+zH4d08TInAXQmBP3PnWWMnRm5HrUo=;
 b=SUHsG8hoT5F7KBVkh9AGxw+YODJoHBzXtG7R+q0wQaefiWTVl3+FPLNOWnT4GxZ19vXR28zoC
 5qqQ0VJPkC0BQwf3ccAcheWxDSRbIRqLeqDlgrEX6EyJql9RqMop9jD
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: usKGkzNtaQzurLKewHlfyQJzv2Fbpesp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX7gUxUij9YgU3
 51uSDvtJUA5Tuev5wLHandwU004M3wcWzgCatMCThZxB5rb/psG/iUic9KeQmpX53X5F/IZ5B0n
 ZQfPgTPsks6ff9IwgJ6CAoyVMxtH33klsh0JjFj+7L2AhLe3XfWoxE86vznPRwg8KLcNL9Zqsre
 oIwFsCFqRsGvPdzcfsuCdSkA4ASaW1U76+AFYMZcgVKzhl98U5k6708zGZiiN/3kH4W+6GYfNER
 5NWnY3MGVwhy5mlkzkohZl78QRRGIUx/jYW+V1rIItZ3rziSNPXfgyXhlGkBJaZbJixn9n1i242
 u00cjVdneoPlzzYsFA7HSW1kaZexDh7iBuOZjmI0thO0J2oBr/Iku8RIKvU2jH+uFh7sYbXJsCq
 SWW+FcU2aDX6U2b9yfocS7zZcDcwEzdTEHqaydid19Y4pzkq8cIRGJ1ua17fNKUQzVkWp2sgJ4l
 ipWdRDCeBLUBwkbQXhA==
X-Proofpoint-ORIG-GUID: usKGkzNtaQzurLKewHlfyQJzv2Fbpesp
X-Authority-Analysis: v=2.4 cv=JLcLdcKb c=1 sm=1 tr=0 ts=6a633c18 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BKWB-FEW3YhUEYzLA1MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXzk+JmPc6voOZ
 WM43eCL3lWwToUzvAwNjB4CiyUd4HigrmhW+jYCn/N46OTJoAZHzsdiyaeRGTt5EA1S6gZgVedv
 Myg24dKS9gLLzko9c5qBSu/rA2Y3Uoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=vt3GR0f8qI7CS+tQdkm9MQ
 YHq3RH3yhBXGDGv7zFOpQ=; b=ZLFSdDLQbuxPG6p5UNZ1I/C6N2w9K05NLn1MWm
 TKPFoaCiniZ/xApuszszpPISJCRWl/gynfFA7E+kq8rwsTzaMPVUHUe07+ZCyTIj
 FkNhPk1gXOxhzEpoDCAz+DCneuc/cgQ5GGl3xZdgM985Tp/hmR7mL5IIcQAZ1uOI
 X69EWkJpkRRewvCpJznMyj384YL15Do/rFCESfbkp+nqBWbfeepBCIDSFfvCQ3P1
 CN7U9FE0ReYBG/aA9IZ8zUIzkTU2JXFYe8/ZqcWFmBK4Aj7ko0RXpIWVmfRbsz+V
 a3kry3i2SIbhvgPmno5hJT42pzF6pRNjP0NmgKgRHfwHSE1A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784888344; x=1785493144;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vt3GR0f8qI7CS+tQdkm9MQYHq3RH3yhBXGDGv7zFOpQ=;
 b=PGNS0jwScEWzVza4fr93Wae1ItjCTU/TArB9fsmVjthYilZKWhtpsfyq27u2bGh1gH
 rKw0foAU/Qpk0GRoo0fXQYyrN28i7oqPF1h1lUgCszsf1DpUHQjv1K5xFA/kfpAnaUq0
 EFxj3JVGRE5rrcjdcVw8jOPfwavVeJ1rY1LAxpxmA48uiv5DjHLnu87jq0KKVLeZKKC9
 Zo2aVcWFTBSkmwG2ziTD6i4sBStuma1QgnSOwxLD4PorGQSfDqghl5nnT8xysY7gi1D7
 e/lZSU02+p8kleIaqwaAhXUlcr1LLLaYdMB4K4XG+Mjrhx8NVEj+iDvBqQ+cD3b49ztL
 2EZA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZLFSdDLQ; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PGNS0jwS
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

Read the USB-C cable orientation from the orientation-gpios
property on the qcom,pmic-glink node and use it when programming
the TypeC port-select mux.

Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")

Previously the driver always set SW_PORTSELECT_MUX without
accounting for cable orientation, so the SuperSpeed/DP lanes could
be routed to the wrong side of the connector on boards where the
cable was flipped. Now orientation is read once during DT parsing
and SW_PORTSELECT_VAL is added to the mux value when a reversed
orientation is detected.

Tested on QCS6490 RB3 Gen2 board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qmp-combo.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
index 0d63e482ee4..615d481513f 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
@@ -7,10 +7,12 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/ofnode.h>
 #include <generic-phy.h>
 #include <reset.h>
 #include <power/regulator.h>
 #include <asm/io.h>
+#include <asm-generic/gpio.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
@@ -39,6 +41,7 @@
 #define DP_MODE                                 BIT(1) /* enables DP mode */
 
 /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
+#define SW_PORTSELECT_VAL                       BIT(0)
 #define SW_PORTSELECT_MUX                       BIT(1)
 
 /* PHY slot identifiers for device tree phandle arguments */
@@ -238,6 +241,7 @@ struct qmp_combo {
 	struct udevice **vregs;
 	int num_vregs;
 	const struct qmp_phy_cfg *cfg;
+	bool orientation_reversed;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -333,6 +337,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
 	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation_reversed)
+		val |= SW_PORTSELECT_VAL;
 	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
 
 	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
@@ -521,6 +527,33 @@ static int qmp_combo_vreg_init(struct qmp_combo *qmp)
 	return 0;
 }
 
+/*
+ * The orientation of the USB-C connector on this platform is reported by a
+ * single GPIO exposed on the "qcom,pmic-glink" node ("orientation-gpios").
+ * Read it once here so the port-select mux can be programmed to
+ * match physical cable orientation.
+ */
+static bool qmp_combo_read_orientation(void)
+{
+	ofnode node;
+	struct gpio_desc desc;
+	int ret, val;
+
+	node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
+	if (!ofnode_valid(node))
+		return false;
+
+	ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
+					 &desc, GPIOD_IS_IN);
+	if (ret)
+		return false;
+
+	val = dm_gpio_get_value(&desc);
+	dm_gpio_free(desc.dev, &desc);
+
+	return val > 0;
+}
+
 static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -536,6 +569,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	qmp->orientation_reversed = qmp_combo_read_orientation();
+
 	qmp->com = base + offs->com;
 	qmp->serdes = base + offs->usb3_serdes;
 	qmp->tx = base + offs->txa;

---
base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
change-id: 20260724-kodiak_ss_orientation-b171351c78b7

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

