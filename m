Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B2C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B2426064E;
	Mon,  3 Aug 2026 15:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRoDQgG4OALI; Mon,  3 Aug 2026 15:50:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FC136062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772205;
	bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oRm56KIHhnGbFR5MmYqSCLvM0qr/xTMYx8G9ZGtW91eg0dKcVMrtu1gXvd8tEgSgf
	 IMBtkzQHJ32HeZYiszko50grr4ctU9/yr9LSHM18QFzzVKtkOrRYCnyPjSss7xT9Ss
	 gsyJL+u10pExV5vpb7fojYWM5Xfsl5mUtLSr6qzELRxAWaKyH4YoTEaUB/D4GJ8Sv7
	 lcxP7YUz4PgXlSLuN5P/GueS9OYVMTeqySzkHHxazktPipyOEgJA4l55JG4OcJVH6D
	 YnocsbQsoaZEzvaufMgOZfkUEkvkRHavnF4LA6mLXMpRyeSc0B40L7Qf9jvXmUK62Z
	 m+3UO21wJ+1aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FC136062C;
	Mon,  3 Aug 2026 15:50:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 312B436E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23137809BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grBVqBbYGRCD for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:50:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 33AE080B1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33AE080B1C
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33AE080B1C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673ECBOM241457
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:50:02 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftdmxbhn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:50:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so2709550a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772201; x=1786377001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
 b=jZq5oly/yeE9HSK+u/Vy2iEhQmjzyvNGZNFFvcL3+HaMLa++fhzdfMgOgCG8XT2de5
 V7zVpesvVviV8qxj0fFMpdKs4YBIQeEF/9OXsEGlay0jw8sN+l6stUBfSjsE1+j+80VR
 ZTGtvpWSYVIsk36aR8MnsaNpB4Wj87qowMHNEXTcotEZfx58OlIpX3AO8nv6lORYDcfO
 dvSHjALjWO5jWVpz208Og/AYJiSsacmrl05Pj1SyuSa/JoKXG0Ur1YORfpSLZQ1AwF52
 OJU8czBLzopN37iEpnHMXKe1PO+9OQ03p0KvABrQIiEvD1wKx9geOm4Fk4ywnLecgshL
 JQ9Q==
X-Gm-Message-State: AOJu0YwKQwNER147LL78odDdf77ytSSYm391TV118xqTHrRuE4TNAmTo
 CrtT95SGs7r6s0cd5Sy99QSfFrBX9KEzmMGDIrGdY6a6tjjtP52h7ECSKk/8N93LvRSDbD6U4wq
 ywNkf8HD7ukypHxldx0XFNkzkqoGgy3Pv1uh074REROt0MAx+BfTh34mQL9EZJFB5tHED3FQ=
X-Gm-Gg: AR+sD13ANwYDxKmOpAocUHvSEA3OyG93zUnYjxCpudbJ12LGM7vJ6uutSQxlxf3e/3o
 vJrftVN98/PKd6UxXS8PtZJMnjGslEgUDkv5S7gzhyt6o7q74MYe+n4PXBbANd0eIkqyXIVSfSy
 rKNTFUldFaNmam7ik0EYh99hWS7LGD+HMOUjFeaGuONJEKE+SwOsiL+xf8HxRymxrSWQtIFUiEk
 1MG24lz6br6J6Y5iWk0TzJsFCR1n3QAR9uGK32cNDR3O97T1rfdg77I3IqCQOBg5yUsFJiLdvJ8
 YgixJdoccfyM2ieZ3JJQ8Aoz8qH+A/aoL32NjcHqqsgXO3ISyrEs/5iX6nZPlfZIrAq73ILCC2k
 fMpIEtOMv/c10iuBuisojAPG0XSYWrXD7tOt3pTWhSxPzi9X+LQ2h3hzXZ6OPSCqCOmtotbUtk3
 EH5CA0kQu5kMOSkC6dJSIUpEh7U1h4
X-Received: by 2002:a17:90b:4a86:b0:38f:9674:ef61 with SMTP id
 98e67ed59e1d1-38fbc438c41mr9546859a91.13.1785772201421; 
 Mon, 03 Aug 2026 08:50:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4a86:b0:38f:9674:ef61 with SMTP id
 98e67ed59e1d1-38fbc438c41mr9546831a91.13.1785772200988; 
 Mon, 03 Aug 2026 08:50:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:50:00 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:31 +0530
Subject: [PATCH v5 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-5-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=1910;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TVnS/d7dOSCVdwvZ8mYnQy7lI2vJF0a1OVJdRMGL6oo=;
 b=QWoIwENmmiXsLqBfJZuvKaDO0ig4EzOtzVqRBcm2Iqy+zxTTmptjPlnx3zdsLTBLPxpfdmLl3
 0KidC9kg00AC1jsfwSWw7KK8yRs2n2K2/3inBA3ZNn+TEGAHkeVhARQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Sab8xH9yJ3J6yIXjVwTfKyGyYGlg_eDZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX7fyGCt8G10Cm
 5BjFnkl6Dxmlg+CfxuLsvjogEyfheNnK3I05d5BwOBFZrsrFQmR0hbZeYsxHf2nyKlLIdGdN71x
 R4pZc8fRgpihHU/9smPRspLnISWLu+eXRMikB3qvpcnIG/ZNvrXrvJqVyEWHFTKBQkeqnwgAd6P
 or5MA0mFbuEb3Ab0uLcTxsACwzeSqrlUMiUbiPAYDVSoBHpuUyX4q8N6NGJfPCaXDt0UW+oCLdg
 jcAMXFpgGqQ6MPWuHsYtkKP2lAUYZAbm/S+2l0TjKlBI2o/FiPO75a0X1otU/pqLc7VkKPkxxcp
 aIf8Aa5Udn5K6QuWMqF0QrXeY0eZVI37futafyLDMpoe64PjNPK6lFeWufBOJQrP9OfFmW/CmMW
 TT34+/tBVtr6+UgoRhZbaUyqJJH9tmoCpLiFnN8KFNTxkbEKud4DLf2nCXBwxwTZrWp7LvusZNN
 sqhqcXz8dWlogkdP5hQ==
X-Proofpoint-ORIG-GUID: Sab8xH9yJ3J6yIXjVwTfKyGyYGlg_eDZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1Jqw7ayk86/p
 qYUqLvEZQ0YC9CAPCkXVPd0MXR6yu2Or5uCkTxYE0/6/YUwXJBeslyQVZTzkzMgkmgeZ0uWM5/Z
 +0iGyM5Oyv9qNdnee1qtkgSw3/RuFlQ=
X-Authority-Analysis: v=2.4 cv=L7MtheT8 c=1 sm=1 tr=0 ts=6a70b8aa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GqjHzkLP_lxEehVDorYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=; b=J+7iDeUDVb8SX+Jo
 EC3i8+RetjHBq5x8hQZRVjX8BPo+UfWqLfiOOB4y4E578tMGM1e/WDXDE8vqdQFr
 ZSKGN3E0tII7BBMlaWoXLrePJ2Up3Q9t5eqt3JgfVYvxAvtbIFcBW4l8UOoG2y56
 DPvBG7dkdE0MNib8xhFSlMMNDC1tZuRirP42Q5xESvkzLpAi7dmhpcjUKbqgGLSp
 lrOBcrHosGReqr3m0tBLlbqgl/wzQdGqvjz3qP0Nj0nmp9Le32IuP/efTj60SWsj
 l5PUlapw52BQ7Je2owEif5EyJ6ON24g6tbaZ6LAeF32m1luhdakfIVQqZ4tB+pMq
 1uOiCA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772201; x=1786377001;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
 b=RNUC1ATooJhclS6cvlvbJNSnIE2NGD80jMhLSagrtCpb7099CkKic185/eT0ZZEYvg
 q0dgEp8FAEBWVM2eI0+hi7i27puueQ92C54sBKKUp4NfhYdm9FpvD8FvdcGBf+TQLS+E
 Gl2Xai5HqFBJv5VwxpniiBOZZXUv5Az17SaFxbiFh6qVqEgRoyVc+/YKAl/lZqUbp9zW
 ljJjy1rEUgU1PJSCb/WHbVdaWvIg0XUIB7289ZewH5a096LVNhqha/Y/Tt37zQb1JUi9
 C7WBHsB9YeDI8ph+UgS8W1LcsMwS9ByPvkxPslJC/wdwZRYSWlVeBloOZyqd2W+AIKIc
 ppYw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+7iDeUD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RNUC1ATo
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Remove QCOM_COMMAND_DB_OPTIONAL definition from Kconfig as its now
  not used

Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

