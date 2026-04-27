Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7611BFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C04184258;
	Mon, 27 Apr 2026 11:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YgDI9BM/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/hAHy2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB10C84258; Mon, 27 Apr 2026 11:26:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC9D83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8kLed3962022
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QtHRKugZU7B9L0HUHWlZlAQD5A43eVMs9r5pXM0OlBk=; b=YgDI9BM/a3vjGyXY
 ADCYcngF9P8glygZ5B+OhxoovuPxKJT5/x4khZMj/JylACyWavWqMkfgYKRNdSWj
 BcjjeOMP/weU2T62iVsQt536EP/26tgxDxy2xOJq346g+53eZz+NQNa7UfICGEJU
 08+wXDp57FKprNjx9ZloBQIBtcdP1swvsJZfBtPKHqHXzMeFeA1Kg8dEZGpYqq1O
 daBZJi2qgPF15rYM9V0oPuoJLBLFeVWdzhw8vn3V3bJ5iJqKm/9OMoWacNc/CRlb
 o35pyEaQwJFdDGRzWKOt1LD0x8gnqWVsw1033Y40BAp9PhGd09oNTyWi+Ys9sUBU
 6Gf1iw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k30b44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f6b984b3aso5521761b3a.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777281984; x=1777886784; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QtHRKugZU7B9L0HUHWlZlAQD5A43eVMs9r5pXM0OlBk=;
 b=b/hAHy2rqUaQIOnKcjNYa2Z8769q7LT+HMAOyWtr0kUOVVztp1+QVu9/2YFsxgnaFw
 XWlpNWTMyUicRL8YKdYBBDGG4EleyhaMbOUi3eI1KEp0wutxMHz7ZGxCZfU3KoDABPjc
 NfE42jcValzM0DJqigqKHfZA7vlIuoLJXe1AKvcodQMgf6bXnaqXKE4kFlY0lPBuYq2P
 zrUwIaY1PUYpMPB9Ax+F2w3z+yITySBPmopyGwix3Ef8+1HAZNhtUqxZHg+FbC+Meuv2
 k7gfOWBPProJjcuHIXYR0MHYnUBrVvLNpMd3sEvmU8ZaR5UzI1Xpknr2s2Hjl29g++kk
 xC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281984; x=1777886784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QtHRKugZU7B9L0HUHWlZlAQD5A43eVMs9r5pXM0OlBk=;
 b=kM/0dEyKtsEANsmNYtC+bWAl8G/m2FWM/LPTT2tZbJprl9t0PxlprUAJ87s8nC7In8
 fUFyqzFBEpYARdssmuZhyO5OXMe08yYUpDMVwz4GjCuWmy6ysFMmzLeUjXfLEHVgKP8w
 i88+mzbiuFNQP9O4Q9JEci76RD0/309cNDqx7v0tfJJ8Sb7ejuGuPk+W0YrEB4eAH8BF
 S+QFXDcwB/hMBOTE+7eRDc7TsCIIC/49Gr6oWyfbcuygV4664LFmxC8DvK8YXfBzCjNs
 Hl85ahOaDm2tT+r83d57iRXMWE1rgtUN79pyCDXsHs0lo938V6K8vmu95kmnNve0FI5+
 oSbA==
X-Gm-Message-State: AOJu0YwMzg/Y0+neKzoqfLoLpv6TEGXxxgUy6m8a12Vm7a9ln8f9qcYv
 v3yHLziLcENGMpnAIfJjzRGUxl4N41sCO5ek+vHPoZBMrNZ6CvWjb9I6ZQgO5jx/5WLvnOb0h2g
 cXOXebp+QOkJEcL/s1fMCOgKW0H9LuSbubImOzdWsQ/O2rnr1H1looE0A
X-Gm-Gg: AeBDietfBREFyPuZ9zx+xmaV33u0lTH+3jdoY3nHyQpVOS0WsKVHAeVzEMwHTIqTq1y
 HZ7MUf7QvJ79GxXIVoL1XziKUF/A+A+2SYQQgoi2DsjuFOkX22BwvOXhfzVVsvF40++70JCfaXL
 VzWq6CNh3zLhNEbRSMaIkRG+M/XvcZqqtjXvEVZ14jDxo9lFyvgeYp3L7vNZcie/+X8G1xCG6V1
 2pRoWI3Zpl97Vqe/UvoBSAPEH2UiUyPZK7rrP/PGopTj2pVP/H40/jrv91n+LdrBsOa3JBcIfZy
 pQGajNdZgdEQsraKm+f0W0AiVTHjX5GowNGQZ8CoI/NbtPqeqJDjxFjj966i7jZRMCcFsyTwr3N
 garOClugUbcZfXD8UukaFZIe4E7L4yt4SyticV/IEnTxGzYMUFlHI8BrynWrclISBnzDbzANhjB
 R6mzPpXui4Lfzj2IcnSgs2vWG6s1KmvdMBgleIrsc28wfypjlEwOP0QVw/8rhc
X-Received: by 2002:a05:6a00:17a0:b0:82f:48e:241c with SMTP id
 d2e1a72fcca58-82f8c8fc541mr46142144b3a.23.1777281983983; 
 Mon, 27 Apr 2026 02:26:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a0:b0:82f:48e:241c with SMTP id
 d2e1a72fcca58-82f8c8fc541mr46142112b3a.23.1777281983519; 
 Mon, 27 Apr 2026 02:26:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:23 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:06 +0530
Subject: [PATCH v2 2/7] clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-2-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=895;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=I6J7wNkKdvppUulU9zHQ7Dr5TxQKOe9rYlgpPB0EWBE=;
 b=iFbPhG3G/vRQGL6kpvmYHp1ISis6azVWuk/kX71ipHfgEonJsoKB+8JM/LI7ikWCh9/N+rLCk
 cK40EjKvrpGBugwcTEBraxdmUj1wCqbeq1MhYSmk5MiW9xxq1051nj2
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX6o7JtV8xL8SD
 n+yJf+45UnBGyi/VHU4BylNuYdIE0SIMuvxy+PonyH+uufy+v8CUmxlr2gYb/NiapAgaLlCbhSM
 o/xTExWgHUMqD1nXIub1KUldUFGfvWf8KugXvx4syJXFJLtxu6ausHFm87KCLnIFkze9F+dbD0D
 9qA22fM/NFCSk6Q3RI0S/+6sx5eNIzrxb4E0QYJoghrqv/Bzux5wvM6QOC/IdQg9/musA9WQZ9B
 R3lBYNLDptEKiEQRRtd5bp91M+Q3goBIyS/M2d+M+2NyQaKNR4NN3f2fc0fsajAeuppB/bmvf32
 +C2Qu5O1KPfXY1KziBRyFHV3pmdI78Gcc2/Q8RVy1qQYcLLtqs1w3PSKVKHzJ/esIo04sE5Q5c4
 NESD7talodOHQwcMclJpFsNbEDtvHmj1hwwaxzcZ+lw09EXWg6B0DPRIlrX+7cI/ROH2xfZuKVc
 NgDIxkPETuyoepvar0A==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef2bc0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uyNG1108X2G_u7pM7KEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: vfWyUuFMBGlswos6YueifnfFPf3Kq-1T
X-Proofpoint-ORIG-GUID: vfWyUuFMBGlswos6YueifnfFPf3Kq-1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

Add RPMH clock compatible strings for QCS615 and SA8775P
SoCs to enable clock framework support on these platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Removed sc7280 compatible which was already there
---
 drivers/clk/clk-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index ddcaaa00d91..4a6c71016da 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -49,7 +49,9 @@ static struct clk_ops stub_clk_ops = {
 };
 
 static const struct udevice_id stub_clk_ids[] = {
+	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sa8775p-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },

-- 
2.34.1

