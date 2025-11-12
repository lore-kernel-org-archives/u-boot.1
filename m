Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B2CD3428
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEEC183CD3;
	Wed, 12 Nov 2025 17:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c27wTXpi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nhc5RiXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE82C83CDF; Wed, 12 Nov 2025 17:42:51 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF6E83B91
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACFwSEw1813910
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=kzd5XjUKBgg0r0hxUIakou51n4r4kXY+eEf
 cC8WUMK4=; b=c27wTXpiEvIQ1xn1I+CQjHXZijNezDPjdXjU21JbaAI7oxL0F+k
 VidIAxir3uWK7RaiN8+6br7gh1l/nkzt9XmG1aTFg7xLFYnMGFPlhScO4uX/w2mG
 jgSQResI+57d+J1/nMozx03epBOjJ4fZaCvdC+xsQoKpDoWIJbo/ffR7/FtAwhb3
 uaFaRHUi3PMPgKM0qVhCwvw0FunrForsUMLHD47OyFfAaz05zo4tKfVoyaqiDZV9
 e/N4IJruoJjY9+jisrbbDvLwMabi34pxfZXjOLEo4drGmNy84OBW8aaOfDJslooL
 fiPpVO2nSbYg55eDvFHcSGWAriBnHZDtOKA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpr5r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:42:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b9a72a43e42so987400a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762965767; x=1763570567; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kzd5XjUKBgg0r0hxUIakou51n4r4kXY+eEfcC8WUMK4=;
 b=Nhc5RiXqtY5RDj8aZjuVOIDeQOTC0b8UobU/bkjG6cZ+uc6zqlp6SQWDoXmzl/n14h
 fJswRdQ/+rsOm5Pb7JrycJUnOY5IDUbGITyKrVXJ+9wJIj/dCe0i//JaIRRSiaFr3qJY
 SsTs+tnHPyjpoBprZ0PVS4UHwVTbPTLb9qRZClJygY+rCF5icpfoiuwReW/nVTJ+wKL2
 rChpnb/4F4RdqhXgU4DkpcnblVKkK29a7+kwdt2JATZuSA0LnrfOMQyLzqShCE3ZWVXQ
 qopkyrKu9isopD/RyxArThtFLPUE7BBhT3QG/cUxxGyiCP5NqGw5AkgHJndiRPpt6d4F
 hg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762965767; x=1763570567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kzd5XjUKBgg0r0hxUIakou51n4r4kXY+eEfcC8WUMK4=;
 b=bvM4hxWwgVjwUP74ylQUtLDncyPJA07czrGUdZcsK22bxask773yZLScT43YpIu7mw
 oDrhTPZoZZspFyE4GQjLsrmOYIijVuyMjrBboWIvK+ekBQiCfPtSCX1JDH/FCPlXAElL
 V4Aj61WBFrKIBHMHf/WHcIHmSkubn9xjJ19VN5GyuvbCZKJ0ErOesnlLRtA6HFJYMcmE
 daiBDS37v4433JHzowOzDRlPuoNNRkH2fzyA4JdMp8XBWA+lsq6SVSPjhV0u38DCLBNx
 qPpJk4T540b7abW1sjOVxqTPmBlbm4KuDmAAFyAcFx5iTgEuTvtbVXYypv0BmRFkEhzJ
 uYJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXziTyOIE0efipOdzQYNLLNWiIsH9DDLDA+RYd30mxWGVBbEM7h7UGY1jr4kPHlurUO8fj5vLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3TdyN2Rio0Lf88PI0R0O0xnN/bVXx21uVeosoKO1zP3/JNltJ
 MWXVEAYD2D39MjVUhWxHm1BwSTDXslad+C7GUYSBK5bDvdHxa4LJRyyMIXC6KQmjSDG02S65g8V
 lWmQOqHyo1fgC9+9tetD2iYiEbEUtDALHeNj3y6OC5JRBH+r/jVv0NOlz
X-Gm-Gg: ASbGncvDFKOLH4j+4py/ooh8STJyM+x9uAm25Agpf/Bm8Yv3/C2EvyIamHEs8b8JvYG
 I5PpQ2tmqh3o3l3gDqODyIbxSEHGOm/+McwyJ8edIB4rgSbiObwgsxlgGTt4xsZUmmrpecdsI2E
 pkr4XH/1yQQn9cQk514qLN+jmSbm63Xo5QbRXIgCtxHyqXyEEcGpclRfssVoiaB2QHoiXjEjkqY
 fP4uAlN7jVI9l6Kta8xk8U8dPWPmRWrOPqu13B2AK741wHc7TeksZzD5kkUmMSJWdWNvkBPibBA
 WkYs9HXbHmfK7YvjaetyxkurX3Xx3M50tQavUxplwVE9aKh9xF/GiUUUANZ7XUTibwmrv5wi+CM
 fKDr32q4kdHeXEbJqL676GA7yA93MUQCNQh86CV8xC9kTTqHduJRRHTMojk4JRKq8NkX7fzlTCH
 lULH5cTFd6Hv4F6z/U3Q==
X-Received: by 2002:a17:90a:d446:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-343ddef8f8bmr4095954a91.32.1762965766437; 
 Wed, 12 Nov 2025 08:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMT7UL90VCUEL15DEXX3mD8eKAfZB92VP4vkSlHPVefYbN9jQ4RrJ3ceH3eRKLnVfNO1eBUA==
X-Received: by 2002:a17:90a:d446:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-343ddef8f8bmr4095729a91.32.1762965764868; 
 Wed, 12 Nov 2025 08:42:44 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e0794e56sm3165642a91.10.2025.11.12.08.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:42:44 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: jh80.chung@samsung.com, peng.fan@nxp.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] regulator: qcom-rpmh-regulator: add support for PM8150
 PM8350 PM7325
Date: Wed, 12 Nov 2025 22:12:04 +0530
Message-Id: <20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6914b907 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AOuoptBRGkJZEVa_u_4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: sOdX5qap6lKgoOsoTKqMP_kFWg5qDdSh
X-Proofpoint-ORIG-GUID: sOdX5qap6lKgoOsoTKqMP_kFWg5qDdSh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzNSBTYWx0ZWRfX/u/PFSTytaGR
 g+wVgE0NkDn6VVQzu4tP6g+VQEzZS45wTl0i/YUYepDy+9YmUMDKK1OPEm9ddSkUcEGjRMVzIHg
 fjqhAPll6Ow876ZnCxM+Gs5Db7S0Hngw9E/wwIt4BLQ9Ou3qJbpe+8oVEqc96a7yz6r5UNC70YL
 N2/s1XxHwMEdo/BM5oQY6xaX3mG6sV3KPxkI1SL5t/fdMBYtNM8qVFfQJvdoPejdCwumuadH9Ed
 Ox/KWM76fpP8ls2IkibUDg4U5Xpd4h/yzbvS8e+gVX/CgP3KXPDF0QcJk4/sUBz+zpGVzjQma+n
 DOoMlr4dC/5KcMakA5sODtN5gJTNAIdT9Xx0iMpdN7oNQLJdGCT5Bjj3Lqct1lFl/f4koTVdfdu
 /BepDINuOAMzRyEY+g0zhpbiAb1wHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120135
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

Add the PM8150, PM8350, and PM7325 regulator data found on Qualcomm
platforms. These regulator tables are imported from the Linux driver
to enable support for these PMICs in U-Boot.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 06466142560..b16cbccbfc4 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -402,6 +402,42 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_bob),
 };
 
+static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 216,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
+	.n_voltages = 236,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	.n_voltages = 264,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	.n_voltages = 264,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -521,7 +557,34 @@ static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
 };
 
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l8-l11"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l10"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l1-l8-l11"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
+	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
 	{}
 };
 
@@ -626,6 +689,65 @@ static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps515, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l12"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo_lv,   "vdd-l2-l8"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l6-l9-l11"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l2-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l6-l9-l11"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l6-l9-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l1-l12"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
+	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps520, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_nldo,      "vdd-l13"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_nldo,      "vdd-l14-l16"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_nldo,      "vdd-l14-l16"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
+	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
+	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
+	{}
+};
+
 /* probe an individual regulator */
 static int rpmh_regulator_probe(struct udevice *dev)
 {
@@ -736,6 +858,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm6150l-rpmh-regulators",
 		.data = (ulong)pm6150l_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm7325-rpmh-regulators",
+		.data = (ulong)pm7325_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = (ulong)pm8150_vreg_data,
@@ -744,6 +870,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8150l-rpmh-regulators",
 		.data = (ulong)pm8150l_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8350c-rpmh-regulators",
+		.data = (ulong)pm8350c_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8550-rpmh-regulators",
 		.data = (ulong)pm8550_vreg_data,
-- 
2.34.1

