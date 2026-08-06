Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3953C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E912A40703;
	Thu,  6 Aug 2026 16:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CV_3dlqeQLiC; Thu,  6 Aug 2026 16:12:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A87F406C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032765;
	bh=BiIQSg0JQ44mb6yUoy9WfI//RyBPdcejRPQRukyBnAM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RdkkG7NsXAfTG+Z3gcggQC29HwxMqNy3EkGsDoTz4m6OSGf4eDjPbH97H/5J0BCnU
	 7ORwejI34HtWERDy+D7Ey5ebxLXEiUYow9FCWetpej3lBEhm6nae+a2wdKoPbrnBHT
	 MR8Kxml0K0nbSWvNmFOtiP+w0Hx6Lp/dPMPv8LU+WCr5MU0d3bPp5yeP1eo+TogUib
	 gre8A/6Tt9qJcFNrff/XK3fzj/+jmg0GS6goVqTNt8UY4mo0mqjdPl2iZhD7WeXef5
	 Z/AnDONMzngw/DutkTATATYg9k9RKT8QAOkY4bvkXaK6sf9tKcMruykWx06K33MNLi
	 WdDVRJ5kUmvDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A87F406C9;
	Thu,  6 Aug 2026 16:12:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50BF1218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DDAD60809
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZcm_qabCcw5 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:12:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4468360807
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4468360807
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4468360807
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmkEg2808153
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:12:42 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq732611-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:12:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso2564022a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032762; x=1786637562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiIQSg0JQ44mb6yUoy9WfI//RyBPdcejRPQRukyBnAM=;
 b=EGPn6Q8EynwEXMBT6GmtOVuRsUhq3t/f/CqOU8Ko4/0c0OfpWstSR6kZwrGx4XukOA
 56zDjroRKsowb5dBjX+YEv69ga+AcNpHls0tcC5eC9BDVloQTJqePfwBErUCn+Sfwbb3
 gPqUhhp3ey9f4FmTUjbMr0ciE/Dylk09HwIGGo5qnO3lUt+hSWONWogesaaECf3SmR+A
 iHTQn3jhEqRuq/PW/M8Rue6W89q5KsOVfBdUOgV1zh15pk68DyX3zizKhTF+XFdGv4DM
 b5VodXRUKZJ5qqPp4yNr8Oy3dGwUwqVHmipWreIJd4EDqLwFR2VuaV7Ju2eMZDoSZmZw
 eG2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RohpQJD1mBPdD0veatJqUznQYkPTcNi4nB2OC73CRnojRItCrmBaktYql1W2AX6TAwWjURb3YE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwQIaMls7gOCt/EgLKM0S2RCyqdPI0jUD0MYv8WGm9EwldSPPaN
 KrGeOFLjy7Xqxk5P13l18rBdCUD0rb5yeyjBkCbNcOjDTDbX6gQo4CetgGj8eK4VEGUdNfKFWPV
 SMsyypWxPjZJFuIOb3cS68TdKARjT7KBBhQfU/9tgul5ukPPxGYnmCFvXBJHct/mZZ1Sillc=
X-Gm-Gg: AR+sD12LZMUTSNR7fp2yOaPlK0094iRIYIj/jqopQRvmGAQ3DLZLQoLqUf5U0ADXlSU
 8JCh9A1L7kzSn8NowF7+c4qBFmoLr176JBvJ4cJiLPRp3fQRUu7OGIZ7izWhJ+DttYnwGZk6cro
 ClkaE/4taTHjiedC3eJfZhhuYf9h56/P0HEv3HZ0u7/+0jbBxoycDJ1AvPKJjLOB9IzRIG2DjmV
 xy8IMHLipfVCo62ZNFv3IWUz+uMM/ovOju3mPUaK8BNdV7i4ml9BrJZRyvEmZg+SKAsv3u4ljTR
 1G3V0RmHaYJ5cWXbGz0BwbzNV3u11sDdNZP/VJ8KBSajFHzxI1EdDEyY4bhrkhDihegNV1YkXjr
 JdVOU+E5tW5UU/Mw07BNku+X9m9AGuu1rO0rYRhAGq3OGMCOgGuWGaFFVfXjgjrFM0KwTgi8TAO
 wdfApGGOtWHMUkdqdF4lVcOz1dPmUm
X-Received: by 2002:a05:6a21:8802:b0:3cb:9bb0:27a2 with SMTP id
 adf61e73a8af0-3cb9bb028e4mr9791679637.34.1786032761645; 
 Thu, 06 Aug 2026 09:12:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:8802:b0:3cb:9bb0:27a2 with SMTP id
 adf61e73a8af0-3cb9bb028e4mr9791574637.34.1786032761064; 
 Thu, 06 Aug 2026 09:12:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:40 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:18 +0530
Subject: [PATCH 1/7] clk: qcom: Add dedicated sa8775p RPMH clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-1-8d7b4e2f4fe1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=2678;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=jJgHQCtnlBj8PpTj0663ERHIcKYIuZGW5fzczgvGQtI=;
 b=FNcGVpFhvqAceNhXZXMr+Qsa+7ZCO3VLbVlgogWPL8+2GosSNaewhuK3c/HCreiNBz6VCMtku
 jPPS37IL4UeCRhhrT/TZVMMnFvn3dpuA52SpyBY0txsD4d7gWuxoRVM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX16F9lxRzUw5S
 rCvKZjILdufyIz9l4lUT85GldIhJ+G0UPhtF65iafVvyLJAIkzhdRcU3TzwYMMR2thD47L33NHN
 7YBtS9L/9k5ywTuG7HrxadgUKecI6u70FyRjQrfRELFIMAme7DM2DpJbrwoJMnglZTQv1ATwbbl
 7E4YamKAoe+r/R+7r8i7iwBwGfkRndRWuCm3jcZW3hWmz69kIvmFPrUmxhJTgE235O6GgWwvEsQ
 CccJ2UQbHNFxVfjrIvBEZazoyz5ctbt/sLx8q0wUX+nM26JKQ+qP79TOf3xwacWJY+8amuaj6Qv
 AEWHgXG5dNnE4W4ebOmHKYGbMcpYLaD3GFI2sD4HOUwHlHRkpB4lCP1K4+lC90+aE9Nq1zgyb8F
 PbVcyOcr4tU9W8MEwyHA56A4lPF1VAVLrtUTCGSiCkc4dSo8Xq+nzzsk2VHZ5/kUF1OGaH0ESpY
 f4QCzyt1i8p8xqh8wDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX252/uzzhvmyT
 2TSx4M5b/hGOQ782AZeIO1an6AOJLCarP6UkibzXSnruxS1MlsYrNqceUXbZ2uWxjGrxF8v6ItT
 lUaw3u9ITFe9KoRzDL++h/nSxaCi/Vo=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a74b27a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=gIcaO0BRopP2LSBRr_gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 4Xoj6s_Z7GI_a0nBi7uwzoNRTY4FMpCZ
X-Proofpoint-GUID: 4Xoj6s_Z7GI_a0nBi7uwzoNRTY4FMpCZ
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
 BiIQSg0JQ44mb6yUoy9WfI//RyBPdcejRPQRukyBnAM=; b=pFaJoSKyxVzMgOV5
 ja4mW9DnQJrL3V+ESdmrk2SL5ASgT5NKrn3xIHluRq5J4GESgF/vijaXnC0CWnuD
 sqsgFFfPfRwJhShTjsorEvKDN+p2t3ySait0P1xIFWxw+BZ4/OVGSJAb7z/WR0tI
 FLdxO8/tKhQdSLzVPrnc22LijZxODSapS4cXIlcbOMwyezrmv4u7c3mQK7CVVtxq
 sD45li8vdC9cJyVuPpkbA/O6hfghgp7arn+eyCpVgPQ5LV6YoI975gfxfXcJcCox
 Sn3VxG9hYqgrvxeCA3jT8gCzNXh9uaJwh6JjH/2lS7N1Bf1aAKus7DBpAXqISu9n
 vJNqSQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032762; x=1786637562;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiIQSg0JQ44mb6yUoy9WfI//RyBPdcejRPQRukyBnAM=;
 b=V8yHE6xwDXyviU6aswNReKw6XfEmtooYkr4nkC5avaq5gBTtfaSJHXIEYRKgGMXDYz
 l3ksUJ0tut8JT+5S57AyfOqqJPWmLdrKeme4B4GgoIDk09RCmgNf5wYI4/p1dc5qmOHE
 Kqn4EWiFcBTO1jWD/BXlk2oRhQDtRRGFuv+rCWHMZ3BEr7YVahbSupAsPEuy/kJR3HUJ
 WkYSKP5sRuGhs2Phao60LYFGVNjWSY8DryqnV7l/Rst+bIEiqWTc/A9tptQYTOdkBECi
 UtXXlAnMUTT38Tz/T9YlcGYP+yRZuLOm6o4pZYjUHLdaDvP8SbM2G65SYXG6B4lNpB5t
 mFHA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pFaJoSKy; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V8yHE6xw
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
no-ops every request. Give it a real driver that provides support for
get/set rate.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c           |  1 -
 drivers/clk/qcom/clock-sa8775p.c | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 4a6c71016da..f7d42892423 100644
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
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae48..49b94078a41 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -13,8 +13,14 @@
 #include <linux/bug.h>
 #include <linux/bitops.h>
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 #include "clock-qcom.h"
 
+#define TCXO_RATE	38400000
+
+/* RPMH_CXO_CLK = bi_tcxo_div2 on sa8775p */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
@@ -275,3 +281,43 @@ U_BOOT_DRIVER(gcc_sa8775p) = {
 	.bind		= qcom_cc_bind,
 	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
+
+static ulong sa8775p_rpmh_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong sa8775p_rpmh_clk_get_rate(struct clk *clk)
+{
+	switch (clk->id) {
+	case RPMH_CXO_CLK:
+		return TCXO_DIV2_RATE;
+	default:
+		return clk->rate;
+	}
+}
+
+static int sa8775p_rpmh_clk_nop(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops sa8775p_rpmh_clk_ops = {
+	.set_rate = sa8775p_rpmh_clk_set_rate,
+	.get_rate = sa8775p_rpmh_clk_get_rate,
+	.enable = sa8775p_rpmh_clk_nop,
+	.disable = sa8775p_rpmh_clk_nop,
+};
+
+static const struct udevice_id sa8775p_rpmh_clk_ids[] = {
+	{ .compatible = "qcom,sa8775p-rpmh-clk" },
+	{ }
+};
+
+U_BOOT_DRIVER(sa8775p_rpmh_clk) = {
+	.name		= "sa8775p_rpmh_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= sa8775p_rpmh_clk_ids,
+	.ops		= &sa8775p_rpmh_clk_ops,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

