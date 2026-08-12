Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDEEC5CFCF
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 478B860633;
	Wed, 12 Aug 2026 01:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NEVTbeaoYEvh; Wed, 12 Aug 2026 01:12:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5538F60769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497148;
	bh=hpeClmX2optsvkK2NRw7MvWBM+dHoQ0PZ3JdAWExy3I=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aQSWLJfJt4asV9wOyDSCcNgZT+fFheMQ4dk2W66yiAHLQbISquZariwGy0LSRphyr
	 N/mqaI4Ac6emDe2MZlmn60F3NikWDP74WxNJh1MOGrndrQ9Y2tGc1V/coc8mZ/2vQO
	 ZYCe5WtohCvzYQ1Yu9VNSgpXEYrgq2bm5oruhRw3p+BDZ5fyaw8JCRz009dg4N4hU3
	 b7bnT8+7ReZX/gCHZ2khagQtS4scTBKudVhnv/QvWXQD0o/K3+OJwh6MwhBDU3IqiJ
	 XYl4QEs/qCZ0RRSBNHiODR3TnvKmhBrHjMGKCUPoJ1Wl9qB14nMn/1l5CqwgJQvxLC
	 mQaeKjy5O8nKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5538F60769;
	Wed, 12 Aug 2026 01:12:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C0B61F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6204E4081E
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZd0XP55Ad9L for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6ACA540806
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6ACA540806
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ACA540806
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNGxXp1706566
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:24 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrhe89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so536482a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497144; x=1787101944;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hpeClmX2optsvkK2NRw7MvWBM+dHoQ0PZ3JdAWExy3I=;
 b=ge0/DfdhF8M95SEaxCGe4l8exiqkt3scXQaKeVEJQYK63SY/XerYBRKB5UD2K+6GKW
 V+Grl3lZij6nxvCIDWp8zn609DQr7vFR+r25BZscJAupLbUmix9cawpPT3LyUvJyfCWr
 FfELW9Q9VZJ0qKFkM7K7cPMehlPoHTOvGWJyKDkIJK5spi+vTNooe2uSvhsAiQqxu9kP
 s+PjfOjQb8QeYj0uv2UEnvl2MP1ByJrDkC+KCoK9GukR6s+YNj7DQrlNWzk/0kEvY6xI
 UdU0xeFaCa+ClZyggQoYs2ASJuLvm6Ci4cFaC99nyaLKu50+Cjd6eAHsWLGk43zxbVWx
 bFDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDyybWLj/ioIjmb/7JBnwNEq5Wa9QLN5g3mxSLjVAKDVcgacfH62EsnyombBb7PYIrdRG+c2I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx6fH0GRRK14Du2z95OO3yhw53LvByicDBXNAdJ2VQ0Wy7zHGhG
 +e58qXNTUd9nmMBFAFggKOSoTjUo4fvk6yzERc6WPuqaFpc6SKeV/K9zabOTCD4zCroNGugoWym
 9EcUIErTZIrLTa9+do4A6IxPXIPd+FJ1lu7dxLu4BNgLOPYmQs1uKfLDC1PKSros/Ytp4FH4=
X-Gm-Gg: AR+sD12HZ61Tp9Qheg/rqPlVV/Xw6og4WxzU+FIsexGnp/0p0AUAht3PM2iWSPUlJCq
 b/1o9NJlQlmpYghc6GzlaGom3am14RJo7Cqjrcc2GRMZvAQT0Ysi0gu6l5orBHjI0RdvUGukWO0
 lJL2YrT2ZBHoFymvGsz5hAXc2YcJYwh+R5ElAOq5tKbV6weg1tbaz0tq7+kHkhjLS0PVhDqaOwt
 1pZ32xWbihgIdke/0tZz5jfnT3KJKv8EPfB18gcpYY1maqklpCpItIC+5K2wRrZN4rntWQbqZRF
 awOzgQraGADZsmoHaPJkgQAQowoF3h3an2wSIQI8sWXsxM6n8qaPjJcvfro9DXdjXB//cruXvxt
 pKjY0SWqy9r4OCYK+RIUnXFnoLaHX06+IRsHyfovAvJhw9MTVmOMtymJUCawiq4rHSiET85c5Oe
 4JlQN9X9nihHC1poksep9UZP8bFOfM
X-Received: by 2002:a05:6a20:db91:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3cc3f5a0820mr1398341637.11.1786497143873; 
 Tue, 11 Aug 2026 18:12:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:db91:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3cc3f5a0820mr1398291637.11.1786497143433; 
 Tue, 11 Aug 2026 18:12:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:23 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:41:59 +0530
Subject: [PATCH v2 1/7] clk: qcom: Add shared RPMH clock driver for
 SM8550/SM8650/SA8775P
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-1-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=5640;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WDCaRgcBDhIXWX3b6oPSfqUHu1JCrXWuZDUVgLwOjzw=;
 b=uFdtot3mfBFB4foTgQgOrr4Qu5ZNjuq+eK+j08jyYzkKCqkHMPuL8sbmpjLorAIU65oHq1Gzl
 Q78H2Xr8K9zCbvCAcUW8vxISy3/4Oo9j6MVF9SYMS+C1wNLJfO+F3yP
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: pvEO_jjFSQ3f61_qM0kvVl4mIUaX1v8b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXypvLOOCAF2EV
 x7Hzpt5vnjEQl4J8L2s0arBLkz88TvDIQPSAccnWw1h59HxsRR43QjsBq87QmVhtezH7mBbb+zC
 PJJRGU6AK4is2rN/WpRZZRT6Y9IoXXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX62dC2rwwQkpc
 ii7Nxhg6hjsZ1P9IZ/EyGCSm/gwIsUycEWcqY1RhmFstQ7xrFColGodLDVD6Br0CVbp5WB0WL2Q
 Dz0Dgs9cIO6P7hj1q1AGiVmRRsx7KOq/3lA4tQ551xq7wIwfkU1mePPnLOnid2nIl75fOjqYlPj
 qBhvYe4tauvAlP2CT1HEppX0Ar7RV0/3F9Xa4hppNcDpG5dlGJXgJdjxHhqY1oYe5tmlSb9WwKm
 zf9XPrxOHNHX2zywK8/NnCC0Ede29jwXODc8KQ5m/++zopG6Svg1a+XglFXvx8/ffoqirr0l70Y
 KybC9emEmtu+xgoOo2qzCmwI8ZOj3MeuymD9TE0f3miQA43Z2ztOESez8o88b72p7smnCSw0xAi
 tsZ14KeEYNv7ycAgJQnACbfGlVHaPdYyPs705NwL4An7qEelMkCvATtsOUQA2Bjt2914O9IpfRe
 XbXAuWz0mRk/PeBKHgQ==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7bc878 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1c2JhAons3WoXjmucV0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: pvEO_jjFSQ3f61_qM0kvVl4mIUaX1v8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hpeClmX2optsvkK2NRw7MvWBM+dHoQ0PZ3JdAWExy3I=; b=iivbrzkNQS/Oq5+m
 LyiXHWaXU/TkSPnmIAqL6c6/EJxGJVOn4fQO07SauogfEiZS4sfZ7WsIEulCtqDs
 FlhVBrpedg+mB2wqvyZvFCydEM/PQV94ITLfl3d1o9/emGAXo3ZPriilWYl04Akm
 ZTpMjhLdg7MlJgzmjK9UjKTzryFONwhBNJbIljaZd5dw5lb+fGQ/p0dfC9F/6VPc
 GUDG+xVD7yJ1Vh4oDuNJbx4Q3AvwcvS9yiSjCvFW/nTtymwzym8LmgZOzCtm2zv7
 dScmKYEwLcVfheEwz15NEOrdwoMlHf8BiL55ffM1NkPyjWVVugNZt2mpvJrt9FMw
 CZPxcw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497144; x=1787101944;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hpeClmX2optsvkK2NRw7MvWBM+dHoQ0PZ3JdAWExy3I=;
 b=IM6u4N4SC/hRM6tRdLkyVFDcQjCJKK8RW8xc6lw7z3NDlhRJdl5gtx4hEaKliH+rID
 AI4d4JzNzA8cx5dLJ2z06BnoHOeOEypDP5DO9CTkEoJKP4g32lqvqgHm7fTwLDwsRNLF
 qtB1lKXPHVRVR2eIqFyECauWOM10U667GrYCovBKc9rdJ5OtgEXUqifFVeV4zAazQvBr
 RISNLabJT1ttDTYAsYBjBeFNQvvBa0Mqcnn0E6MaIQi1FI+EQd/n2+hTEgalLHa6UfD8
 7STQUb1Z0myrH1vBdZT09GLiUZjC80L3P+Fh46xT8NoerJzYRJEbrfATCUC8FXfHgU5S
 jaNw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iivbrzkN; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IM6u4N4S
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

sa8775p was being handled by the generic clock stub, which just
no-ops every request. The RPMH_CXO_CLK (bi_tcxo_div2) it exposes is
identical on SM8550, SM8650 and SA8775P, so rather than bury it in the
sa8775p GCC driver, add a dedicated standalone RPMH clock driver shared
by all three SoCs. It reports the fixed CXO rate and accepts no-op
enable/set_rate requests.

Monaco-evk also uses the same RPMH clock driver as sa8775p (it's
rpmhcc DTS node has compatible "qcom,sa8775p-rpmh-clk").

Drop the sm8550/sm8650/sa8775p rpmh-clk compatibles from the generic
clock stub now that they are handled by the real driver.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c        |  3 ---
 drivers/clk/qcom/Kconfig      | 12 +++++++++
 drivers/clk/qcom/Makefile     |  1 +
 drivers/clk/qcom/clock-rpmh.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 4a6c71016da..85e54841386 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -51,7 +51,6 @@ static struct clk_ops stub_clk_ops = {
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,rpmcc" },
-	{ .compatible = "qcom,sa8775p-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },
@@ -59,8 +58,6 @@ static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,sm6350-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
-	{ .compatible = "qcom,sm8550-rpmh-clk" },
-	{ .compatible = "qcom,sm8650-rpmh-clk" },
 	{ }
 };
 
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9ad233c83ac..8596b93d4c4 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -87,9 +87,19 @@ config CLK_QCOM_QCS8300
 	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver"
+	depends on CLK
+	help
+	  Say Y here to enable support for the RPMh-managed clocks found on
+	  SoCs such as SM8550, SM8650 and SA8775P. These clocks are owned by
+	  the always-on subsystem; the driver only reports the fixed CXO rate
+	  (bi_tcxo_div2) and accepts no-op enable/set_rate requests.
+
 config CLK_QCOM_SA8775P
 	bool "Qualcomm SA8775 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SA8775 SoC. This driver supports the clocks
@@ -153,6 +163,7 @@ config CLK_QCOM_SM8250
 config CLK_QCOM_SM8550
 	bool "Qualcomm SM8550 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8550 SoC. This driver supports the clocks
@@ -161,6 +172,7 @@ config CLK_QCOM_SM8550
 config CLK_QCOM_SM8650
 	bool "Qualcomm SM8650 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c0d95a6300e..f5630ae0f9c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_CLK_QCOM_RPMH) += clock-rpmh.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
diff --git a/drivers/clk/qcom/clock-rpmh.c b/drivers/clk/qcom/clock-rpmh.c
new file mode 100644
index 00000000000..69f2a751441
--- /dev/null
+++ b/drivers/clk/qcom/clock-rpmh.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RPMh clock driver for Qualcomm SoCs
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+/* On-board TCXO */
+#define TCXO_RATE	38400000
+
+/* bi_tcxo_div2 divided after RPMh output */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
+static ulong qcom_rpmh_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong qcom_rpmh_clk_get_rate(struct clk *clk)
+{
+	ulong cxo_rate = dev_get_driver_data(clk->dev);
+
+	switch (clk->id) {
+	case RPMH_CXO_CLK:
+		return cxo_rate;
+	default:
+		return clk->rate;
+	}
+}
+
+static int qcom_rpmh_clk_nop(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops qcom_rpmh_clk_ops = {
+	.set_rate = qcom_rpmh_clk_set_rate,
+	.get_rate = qcom_rpmh_clk_get_rate,
+	.enable = qcom_rpmh_clk_nop,
+	.disable = qcom_rpmh_clk_nop,
+};
+
+static const struct udevice_id qcom_rpmh_clk_ids[] = {
+	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_rpmh_clk) = {
+	.name		= "qcom_rpmh_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= qcom_rpmh_clk_ids,
+	.ops		= &qcom_rpmh_clk_ops,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

