Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF41073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FF5841C2;
	Wed,  8 Apr 2026 14:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5FE+3IW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jXnM3z3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD0D838BB; Wed,  8 Apr 2026 11:12:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E78280433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387FwAM1619624
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Hd1J7ilWQjg
 HnMbh7OnpDcRH8M1AtCS0O5VR04Xx2SQ=; b=a5FE+3IWNylC+MKbt7YYZMC67zm
 UOJpDCwqKJzBHmvbGUm6hLc8tWAxlxGPoBW8KygsrY/+gR8UnQzF091HqP9i1jyy
 eizqrKHXtyEe2qhXLrNPqGdPpdofyepnDiyBxvkLsvlX6Rvbe8FLxTlURUHEQlyR
 I6bnrpPGHvxbF0L2zGBZbd9IwLKLLXfhHtUU7JsWSKYppXJBV3RwHrGSaAHCHtmE
 STeeSJsSGgRp4+n8JXU4C0qW3LiCoqrutJWVUYDMPjGDt/zqDC82QcXdpQC0n90J
 z9dDEYSGCvVX7RDcr2NfvMJz/e5aJQEo5Bi4NM7ObPz1UU8tReeIVKq4mLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrj12f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:12:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b23c909256so83230125ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639566; x=1776244366; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd1J7ilWQjgHnMbh7OnpDcRH8M1AtCS0O5VR04Xx2SQ=;
 b=jXnM3z3dAWQmuIGaMtdQywpmgH0VbvR/ZlrzTDqRQjTXOaNVST2MAqTCGPAw6+NHm7
 o6dofZgT+JDyJ3w0jhjngKYtr9w0wLa23xmwtaUbr5lbu5t8hFBDln/EZQfoylChFxCo
 IPEzVwCrbeSbPoAkBZQEVNNvD3ZPG3cy0MbuYOBFFHhH+FQr/VRrwB9mQiImSLKKVHsT
 jYQ+iZP+4+QTq1e+LPED5c4xRF8Xwjqh6o9rrjvCLAdF9wzIeKNykLPfpL/1i+szDsyv
 j3iGqt4pqpLeEDLvyngoK1gT7+a2p0NXi5mW0s0N7oReWNMb9JyS1ZGVZHMbPI+wyf1p
 RrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639566; x=1776244366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hd1J7ilWQjgHnMbh7OnpDcRH8M1AtCS0O5VR04Xx2SQ=;
 b=Qj6ZSe4IMRKcQupwZoJx2xMPJhlSGM5OzrU95/R6DwKTtCTTHXGqNWxLTWKlPMXrAB
 hLXYEK+FEusczQ7PDibpNZjNYgtBjh7TONtGZPEj8lb4GBSNA8s37IcVu+eZ+qtcwdv1
 ln6YM2jbNXP1OyG/TnfjB2XwPw56GwFYt7kKWD0pzXo3ow/DepRPoNxpp2v1P90saLQ3
 PfJUgLt4NYougCdUTIZ01/Qlt4ukk8chFgrq8ekbA0gkcPGrBMvJMvlukzovbAuOAvF+
 PG5H+ATjNi7g1nEntEg2OyYZfHrhlIU6x0nomUZMxlxnnkzhhjfhHXAZ+CG7mzC8YaKx
 RSRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvLjJLCdK5CTJRye7FlPETsHYsF0wOCIHTbnHWl6JbAHklcKzyeLcVp/Gj2UH3OFuD2c0Z7/o=@lists.denx.de
X-Gm-Message-State: AOJu0YxhVCfMv+Va0dSJjKK44Xal6A1Ce0e9JItBpyYcsB8RNGY/Ygnu
 ffztYe5+3xJoHgAMyPaMmr9P7BXF9SqJPVeOuqZFpsi1bo9GSfJwcU+aZwAHVfcj2FQQW+Q1L0W
 +Ntg6INZS7FJd7+cMyJYGF3uRNnhB+Q/KLtNn6nMR5vNDEXJ1bp0wYX5w
X-Gm-Gg: AeBDievzPdvJNP3AvqHow7vEdm6f9iwUoAu8EYYBMe2m3Ozj4lR6vWN5HL+dcu5kV5W
 Nt3ATpinrQ5HG6cFMDKICA6d2s+PBsQKrXuKxzLwW5Fx97zcJjn+07hBTWPp0rY5glDw3W/fvvi
 c4MJHihWnfUKHl/5e+TvpQpOBHBiQXd05wTUxyKFzIu7YOvXIHH1beOy6ZaYy/5l0lWnpkrXI1/
 B6bd1UL4dpSXl8AKdYCSO+efFPWe/0x2DW40QFwTzOzrq1takV9qJJb7a9eDHKzwlceHinkIsmI
 Tw0WjfoEExzfwyRy/jCxB3RWDa37r/ljJ1RhBWQv2Dsq9JDUTD4tN7LMFpP78Uf/y9f8RlziB74
 L9b+4JYZQsvJ1UYzIJVVJ7/c8UN7QqL6yQFGoRcWnOoePyPrMCgLDxQcukhxkejCPV9tyBValkU
 mhcSqAiw49+a0M3W1I3vKXcSDfo644/Ywc7LiyN+oiNsPI8engIzM=
X-Received: by 2002:a17:903:950:b0:2ae:b991:a46f with SMTP id
 d9443c01a7336-2b2817f1a38mr241471415ad.42.1775639565771; 
 Wed, 08 Apr 2026 02:12:45 -0700 (PDT)
X-Received: by 2002:a17:903:950:b0:2ae:b991:a46f with SMTP id
 d9443c01a7336-2b2817f1a38mr241470585ad.42.1775639565212; 
 Wed, 08 Apr 2026 02:12:45 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:12:44 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 5/9] misc: qcom_geni: Add minicore support
Date: Wed,  8 Apr 2026 14:41:32 +0530
Message-Id: <20260408091136.2794546-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _0_qi3HTFErYpwHsS_EL2cXptFgZhidR
X-Proofpoint-GUID: _0_qi3HTFErYpwHsS_EL2cXptFgZhidR
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d61c0e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=c6PXgn3fiFxYvSzRRRIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX/eRB498md4o6
 Bfg7n7Y5AY0gLKsMIzJptKzrqlKLpT0hoM3togzxaK93nwYMo4Ye2v2PmIgRhVADFTGSJljm1O5
 w+Z55KGs7yAyhWAXQjlctdZ0QITfB8dBe/l8Oz/cw7KBwTIofi7RF8Z/Zbgs3gQyyE2XwtGNlPp
 TOTl9Ow+gFQpgHZjmvwUo/1cVml7JYBleErPkrcqxCy0EbAitF+wq8EwQ6nwFcxC7Zp2hMhx7ht
 XFapg0LS2HZ3yqvOquVs0rWo3MXdWkNAjBlNdPpd3mid/d9FSai1INmt/kNJtfsjM0AGfaw8MqJ
 /lyZ4xjnLaZMKj8wzSpom+WpHvsZEVlRnI6Qje0WfhnlLUK1OxK8xaeMEIT0fNAnzDImPW+MXLm
 JvHW403JcZjthjo13mDhOK83fjwSnLoHRDwMb9fHhShzaHcJZ7ZvcV6Mh/FufAjpo4X0DkZVgXU
 rMT0vcMmW7XWjQaMyUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

The qcom_geni driver reads an ELF from storage and configures a set of
registers and programs the firmware to the GENI Serial Engine (GENI-SE)
wrapper device for the expected functionality.

Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
wrapper is pre-configured for one of the functions defined in 'enum
geni_se_protocol_type'. Hence, the firmware download is not needed.
Only the register configuration part is needed.

Earlier, the boot stages before U-Boot would configure the GENI-SE (to
access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
(i.e. boot ROM) doesn't do that modify the driver to do the register
configuration part alone without reading an ELF from the storage.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c       | 168 ++++++++++++++++++++++++++++++---
 include/soc/qcom/geni-se.h     |   5 +
 include/soc/qcom/qup-fw-load.h |  15 +++
 3 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..d02ea804c33 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -34,6 +34,102 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+	bool is_mini_core;
+};
+
+/*
+ * Register configuration for the QUP minicores to setup the corresponding
+ * functionality of SPI/I2C/UART.
+ */
+static u8 cfg_reg_idx[] = {
+	/* 0 to 18 */
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	/* 64 to 113 */
+	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
+	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113,
+};
+
+static u32 spi_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
+	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
+	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
+	0x00004000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
+	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 uart_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
+	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
+	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
+	0x00000B00,
+	/* 64 to 113 */
+	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
+	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
+	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
+	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 i2c_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
+	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
+	0x00000000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static struct qup_mini_core_info qup_mini_cores[] = {
+	{
+		.serial_protocol = GENI_SE_SPI,
+		.fw_version = 0xb02,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(spi_cfg_val),
+		.cfg_val = spi_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_UART,
+		.fw_version = 0x405,
+		.cfg_version = 0xa,
+		.cfg_count = ARRAY_SIZE(uart_cfg_val),
+		.cfg_val = uart_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_I2C,
+		.fw_version = 0x204,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
+		.cfg_val = i2c_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_INVALID_PROTO,
+	},
 };
 
 /**
@@ -163,16 +259,38 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, int elf, void *info)
 {
+	struct elf_se_hdr *hdr, tmp_hdr;
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
 	int ret;
 
-	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
-	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
-	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	if (elf) {
+		hdr = info;
+		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	} else {
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		tmp_hdr.magic = MAGIC_NUM_SE;
+		tmp_hdr.version = 1;
+		tmp_hdr.serial_protocol = rsc->protocol;
+		tmp_hdr.fw_version = qmc->fw_version;
+		tmp_hdr.cfg_version = qmc->cfg_version;
+		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
+		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
+		hdr = &tmp_hdr;
+		fw_val_arr = (const u32 *)qmc->cfg_ram;
+		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
+		cfg_val_arr = (const u32 *)qmc->cfg_val;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +468,8 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
-	int ret;
-	void *fw;
+	int ret, elf;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +495,22 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
 
-	ret = read_elf(&rsc, fw, &hdr);
-	if (ret) {
-		dev_err(dev, "Failed to read ELF: %d\n", ret);
-		return ret;
+	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
+		ret = read_elf(&rsc, fw, &hdr);
+		if (ret) {
+			dev_err(dev, "Failed to read ELF: %d\n", ret);
+			return ret;
+		}
+		elf = 1;
+		info = hdr;
+	} else {
+		elf = 0;
+		info = fw;
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +539,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+		if (readl(res.start + QUPV3_SE_HW_PARAM_2) & GEN_USE_MINICORES)
+			plat->is_mini_core = true;
 	}
 
 	return 0;
@@ -473,7 +601,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -492,7 +620,11 @@ static int probe_children_load_firmware(struct udevice *dev)
  * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
  * all the peripheral devices that need firmware to be loaded.
  */
-static int qcom_geni_fw_initialise(void)
+#if CONFIG_XPL_BUILD
+int qcom_geni_fw_initialise(struct udevice *dev)
+#else
+int qcom_geni_fw_initialise(void)
+#endif
 {
 	debug("Loading firmware for QCOM GENI SE\n");
 	struct udevice *geni_wrapper, *blk_dev;
@@ -520,6 +652,10 @@ static int qcom_geni_fw_initialise(void)
 
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
+		if (plat->is_mini_core) {
+			fw_buf = qup_mini_cores;
+			goto mini_core;
+		}
 		pr_err("QUP firmware partition not found\n");
 		return 0;
 	}
@@ -544,6 +680,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+mini_core:
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
@@ -563,7 +700,9 @@ static int qcom_geni_fw_initialise(void)
 	return 0;
 }
 
+#if !CONFIG_XPL_BUILD
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
+#endif
 
 static const struct udevice_id geni_ids[] = {
 	{ .compatible = "qcom,geni-se-qup" },
@@ -577,4 +716,7 @@ U_BOOT_DRIVER(geni_se_qup) = {
 	.of_to_plat = geni_se_of_to_plat,
 	.plat_auto = sizeof(struct geni_se_plat),
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+#if CONFIG_XPL_BUILD
+	.probe = qcom_geni_fw_initialise,
+#endif
 };
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..e51dd06fa94 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,6 +77,7 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
 /* GENI_DFS_IF_CFG fields */
@@ -248,6 +249,10 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
+/* SE_HW_PARAM_2 fields */
+#define GEN_USE_MINICORES		BIT(12)
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..a3ae4122681 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -14,6 +14,7 @@
 #define GENI_INIT_CFG_REVISION		0x0
 #define GENI_S_INIT_CFG_REVISION	0x4
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define GENI_CGC_CTRL			0x28
 #define GENI_CFG_REG0			0x100
 
@@ -21,6 +22,9 @@
 #define RX_FIFO_WIDTH_BIT		24
 #define RX_FIFO_WIDTH_MASK		0x3F
 
+#define QUPV3_SE_HW_PARAM_2		0xe2c
+#define GEN_USE_MINICORES		BIT(12)
+
 /*Same registers as GENI_DMA_MODE_EN*/
 #define QUPV3_SE_GENI_DMA_MODE_EN	0x258
 #define GENI_M_IRQ_ENABLE		0x614
@@ -173,6 +177,17 @@ struct elf_se_hdr {
 
 struct udevice;
 
+struct qup_mini_core_info {
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 cfg_count;
+	u32 *cfg_val;
+	u8 *cfg_idx;
+	u32 *cfg_ram;
+	u32 cfg_ram_count;
+};
+
 int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
 
 #endif /* _LINUX_QCOM_QUP_FW_LOAD */
-- 
2.34.1

