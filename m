Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444BCCD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48D1846D3;
	Mon,  8 Jun 2026 11:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbF3l/Rv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrCACJqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FAF84704; Mon,  8 Jun 2026 11:07:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94414807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Pjbv2733088
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /unQRUPJRorIgE2DOu82u/Ibi5HI8hYL4y7DNvdTZts=; b=AbF3l/RvtTn5wrEu
 x/R01mOPUVCQG8E5BeYtbsc9H/U/1x3x1tqJRc+K46O17eL3RxMTjyAunn0G8a2k
 gTm/7M15Fn42DstrE7kg/Qgcs8ankxmJUi++ZcozGAl5xlFZegbX/PAamOVCdRMY
 anPee3A+NVm1NSi5pXX3u5+Ui6TuuaL7D04edSzYemFeL3GHsmg2Z7nnQux0/2G6
 N6CdDR8mbLtAwEzr8mEQ0zBVDv1EUr/gl0tR7MZsLZ6As8l+UY2s65NcvkbBHg/O
 0Lw+grTg3RWro/lQm9DqhgSxrPczVQqYPJMlk9u/R2IlkuRGzdezYczlKmH7/BKa
 3Zv51g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf73pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:06:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8604fbe71eso5090687a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909617; x=1781514417; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/unQRUPJRorIgE2DOu82u/Ibi5HI8hYL4y7DNvdTZts=;
 b=GrCACJqvQ6cGVNda93ecTYjY1sG8XlgmnYjOxyA1sbZPsoJbRY7M6+0OxighLWaN3S
 WClfMHofsWTdC5vl/Z9D9bclcEWG9ChDzMqqKKzDQCMMQVgIv8CuFob/8yghl2KNGhc1
 GtKvBLPi3wIof8RAowZOeINWDBpZb4ui9YkZwIyBQzZpqiOKBOTX+A+k7Hmk8/A6lBhM
 9ni0R6WG7fLxf4q5ZL8dfj1ONzfKTDXrsZ5CZjzxFpjkZqPvn/heJBViBPyuqkwF439e
 qSF+tYginC1aIlZzJt4dnDfeMAztzQoXKZmfEnFFTdfy9EPEOXxojR9KQIH7SBUM1J8o
 bi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909617; x=1781514417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/unQRUPJRorIgE2DOu82u/Ibi5HI8hYL4y7DNvdTZts=;
 b=H/mp7Swt8fxLVeqR+CAxXNPI/qycaJXg2GAl2p1WromcAeT+upa/5+OZCjcsGgJ/n2
 WtT9AzL1zxoD+NbhupIjDAYeoj4ckz6Dm/lfr8BFHZeaRCL3c64xLYCpD1ERJCCXj/rb
 4f071oaZbIFrfXHG/HBCGXemgInH+dSRtdHShBimWT3fySctZJnNHPmlmAI92agVrQ9h
 j8uGkSNFY/zM8o5/vjvBb1y/aURXl5nhphYy/Xx65lz/ydbNxWCWj4kUOCTmL3LbpU6k
 Wf+uOahSlG3UAmd6EDvKue/UUxff28/c4mlxcLBiQvo5eo3gaEDj8JEDAiomm1Bc1Du6
 dNVg==
X-Gm-Message-State: AOJu0Yy3tVML653vjpHTiaNAZyNVj23fqCyWz9afW7MBCO0hcf0rfIIq
 gT1DcwXUHY4EZqIu4T/lMBIAz3VzH23KXeyULrPSNGscqLesxXVcIWVdS7qZkF67f/3BGuzTgmd
 UgpU6b7GHD1SqRB3GKhotE9NQjDGNsrmTq6j0+jpckW6ygeWnCsSGTkw7
X-Gm-Gg: Acq92OH65fe5R/w6DzuTlCTACgiMqtT9QtJcBTagHRD2nHqD0n+k7uBe0u/qRE6CbDS
 h94bc0MJgNUU3ewIZnfdnfqffWg9fWxMNOdOjE1H8IZzEtteSgqY7yOB2HCfaVMaN8IaAA3iz9U
 pG2ggUXOn2l8WbWIPZ3hsneX8hdq8NJ5q6o/bwjQh8rKpVeHn/1IiHNX5PwOJ4VvDfxevIe2hUY
 bESYzHgiZCYorX1dXieSodFnl/vP4ajrHbS3L9DohKygPx4MQ6r9RlwrM0BLQkfjcfcwcX9kb5c
 YSGrM60yDDq7ClOpOi7HEbA00x4Ie0q1P183OtuUdKmzPIC6Gj9/A0HswEdad+2JEzACha9DKYd
 NqNyuP9f8LCqw0i/d+ouH2VdMsOAeZCbx5Sn6MwDrLzeSvV8ZQyxsFL+cSipy/622aeFaoFmYr2
 XZADofYYiJ9aK4912OMVYXyrrkPXH50AV4/x6COSUCavHrD0K63sZFt4QfP3ZL
X-Received: by 2002:a17:903:b0e:b0:2c0:d8ee:7d66 with SMTP id
 d9443c01a7336-2c1e836970dmr166197805ad.36.1780909616767; 
 Mon, 08 Jun 2026 02:06:56 -0700 (PDT)
X-Received: by 2002:a17:903:b0e:b0:2c0:d8ee:7d66 with SMTP id
 d9443c01a7336-2c1e836970dmr166197345ad.36.1780909616311; 
 Mon, 08 Jun 2026 02:06:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:06:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:29 +0530
Subject: [PATCH v2 2/6] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-2-036bb0343bf7@oss.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=1972;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=upcs9QEEezsxqJileCuwCyYWmKQupeejEahGxjR8+bk=;
 b=9nq7KpaSb72E26wL5kQ9Byq5HgUfF1szkQBi9RZEtSmhJfJnSMDHsv3jY/eDtrI1diZyBI8PS
 iW3OhLwkO4xAND8JrEqR0+h5DQ1eJJMUCargkAzkJLATgAatN8wWrpS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a268631 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5uKnyaFRDP6ZZ46_rXQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Ot1gy_QBttPgiEXZb_RTt750alBy5fkS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX+Pi+vi14Dc6G
 gdCAGo0VwnAC0fzbl82jHPdcNb5g/xcuE+NL0mb8qnTlMSu3Eh5Py+Wttf2W8wAEVuB2HRlKgzm
 87LNbgiUr1H7XutufwaOmtyRuihU3ONhlrjthXnvH4iyXx+PAmNM8pJF6Cs7N0AM+VTsOs+Mx01
 yKMA5XPFEpNOHI4+Sa5rYqTeKOui//99H7ZF67wL3XGx9EiPsEvPJCq/v81VJJI5A73KkPbpFXu
 wfvxIGFt4YZQI0zpPkAvcgOWhsNFcPdgsAIPtDTVS8sX0/qpBDkZwG0vjDPXHTRgJHqQXbjkgIF
 7GhIzZuTpvEVkbdgNaYbIe2idoq0Z2YYsLS/g7lUSkjNes1OBPVWOC8fCheLrzrGxpB45riAPq7
 6l87a0XjaTdvgvBfwVBJc9bIklW7nO1WPtm8NDlHjAmh6E4kXJDxxJeytDvr5lGzSfhmY2MHJwJ
 77iFB3DoVSZMx6BY1sw==
X-Proofpoint-GUID: Ot1gy_QBttPgiEXZb_RTt750alBy5fkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Wrap both functions with CONFIG_ARM_SMCCC guards and provide
empty inline stubs for the disabled case.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..be4bdd49cf6 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -158,6 +158,7 @@ static int qcom_parse_memory(const void *fdt)
 	return 0;
 }
 
+#ifdef CONFIG_ARM_SMCCC
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
@@ -172,6 +173,12 @@ static void show_psci_version(void)
 	      PSCI_VERSION_MAJOR(res.a0),
 	      PSCI_VERSION_MINOR(res.a0));
 }
+#else
+static inline void show_psci_version(void)
+{
+	/* PSCI not available - no-op */
+}
+#endif
 
 /**
  * Most MSM8916 devices in the wild shipped without PSCI support, but the
@@ -180,6 +187,7 @@ static void show_psci_version(void)
  * firmware driver doesn't bind (which then binds a sysreset driver that won't
  * work).
  */
+#ifdef CONFIG_ARM_SMCCC
 static void qcom_psci_fixup(void *fdt)
 {
 	int offset, ret;
@@ -199,6 +207,12 @@ static void qcom_psci_fixup(void *fdt)
 	if (ret)
 		log_err("Failed to delete /psci node: %d\n", ret);
 }
+#else
+static inline void qcom_psci_fixup(void *fdt)
+{
+	/* PSCI not available - no-op */
+}
+#endif
 
 /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
  * or for supporting quirky devices where it's easier to leave the downstream DT in place

-- 
2.34.1

