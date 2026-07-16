Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6592FC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F7F84C2A;
	Thu, 16 Jul 2026 10:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlMpwCq2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gP2ookfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658AF84C63; Thu, 16 Jul 2026 10:46:12 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B22F84C23
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7DoZl1734297
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BC8D1e/HQ8CbGaSaPwRMc3
 6JR+AQNPyp/sYI8vV2Gv8=; b=AlMpwCq2wHhH8ojcf+KxjUirf78c4Z37Octs4u
 aNtSu/0UJS6oWg7UMWDkjFW1G2tX6qc0wQeslAEtN1cZgfk0XQJ7qe+HXdKMtQjp
 6c1EXhbo9xgGwJIGXDEg8i7+3yF0cDtqtiyDWpwIRS3GTAGT6KEdG82251r0maOq
 BLUVCSTFCjRnQPewg2G/ycDq61joNbBtU8JKUDAmec3PNx/RzshHxCv4rgR2lsxF
 X1jnrbjsoVlLY3BbnbCVrnWVOMHEtuzgDomsmU3GZNiuAqFmqSBYghtJSjMwaluL
 kHk6h9gSc0BhOzB8h8vgVcOhSqEy0/1syreVSJ5ceGlP8zXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed063fcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:46:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so8572089a91.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784191566; x=1784796366; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BC8D1e/HQ8CbGaSaPwRMc36JR+AQNPyp/sYI8vV2Gv8=;
 b=gP2ookfL8qkizg5IZ2v6jf0x1D138nl+84n5pPs7QkuKs1kNhmRchzhvdKzrugi1Sv
 1eaCaLg3UYXKyQgK28HVvWYdCbwi2NFwxgYWrkrwnukabykAJQ9gkjMEavpmOGTsJUGb
 oqHElKYhKcG8i3xmQorFKZAnIs8Bxxy+F+M5sWOTG/On61qpyzRFOVvSI2rRRWsZp0H4
 ZTyCZdnpkftwEZamlaLmbyzMD6YbiEtXbtDS+W2oi/2atIGdK2WU3UNVIh7ORwqqa6qp
 MIn6YfbOB0vVKx3TV/BGKs76nIfbc2FpQjMGw0VGj+6NEpcN7/MHhK5qitZD9bAVwmVt
 Bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784191566; x=1784796366;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BC8D1e/HQ8CbGaSaPwRMc36JR+AQNPyp/sYI8vV2Gv8=;
 b=N5RW8qEQumR6MWTPE/R4/Jw1NXuyXZ9Eu/fGB5xKsbHcDECwSKRfTgNok/9EBG+PBh
 i8BlwgMzXFRrrVLFaad8N7ukLyQVeM8tG2VIr/BYQZDPoctWGil3sYgIjQH/mEYj6YIb
 QgVU8NQwbfILumi0de46hmyfjI0Vj9o/5AhJhKKmCqBRFoHUwIkGCPgH6TTnpQRwWAfs
 B2XeRWTiYNyCXmlE3b3JHHNns1HdcfEh1nQjkwnTu9IMXWN9Z1Bes8BB/1YTtLaDrGCx
 iMNQVVG9Vy+zQNi5cqcsLc0ms2pvvez3XQ4eEzAgUdsHg4ijyD84PjHzkB3FPsqBuWU2
 6woA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC4YHdvawqebNhD0oQmWPCmCjj+gCgHlP64OG7DVI2KLaCqo4jJfWyDRymIFuKyxHLTzG4XWo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0nXk6JJbfkxBka5kE50usQX+KIomyMhqOhzrJ8FWNXxI9IMm1
 nLPM4qevU1zObV3Xn59JRmDCFjNWO027J6dNF6lsXpcZdyDOZk++Q/4/o8rIU62jJUqwa2QDHPJ
 oHX57gYSHo0X2fMxASh2rOWPxiyI/4bHLqqpSK8QmZJniKEya9OlYr1Pq
X-Gm-Gg: AfdE7ckXITh69Z88HxlZSfjNNcKJkvf9FVJmcg9l0QTBqYFzdGon+783aTdCuWvW2cO
 UBVhp2QtO5oqQHEtACGwI0q9C7HBleYqa6UNXmCD0DqOhHg2adJVvG4p876Hq9VbncVGwSLTwKR
 926MfCbHrOi3sIuiYEownRUK199ZIb007kmusmhxuk2HP0C7FE7KQOB13axhOmuN50W4FHW3nfZ
 vGCsCOfJTFXdaBtDzY1gss9EKaV+hLc37BeG8vN4+moA7RGbpIoOPwgHeK81Keq9pwHRZYDKl/X
 6uWzDk/7xB4TbX2H20eBnrnBXAA6q386hlnEMKkxzLuPAgu6Cm56MTveJeaoH+XbhP7X7lP7KMh
 68kp8AxI1RhMRZ/63H3Y8LueiPbG1TSeZBThoFdGEGGy0IuKB6rf/DkiLc6QrA0M8TeQnZkky2g
 7TbT1biDr5DuiN9aC1kouisEC5YyJX4g==
X-Received: by 2002:a17:90b:57c4:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-38e29f97584mr6535529a91.14.1784191565441; 
 Thu, 16 Jul 2026 01:46:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57c4:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-38e29f97584mr6535503a91.14.1784191564929; 
 Thu, 16 Jul 2026 01:46:04 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e4fc28dsm10037204eec.2.2026.07.16.01.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 01:46:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:15:51 +0530
Subject: [PATCH v2] misc: qcom_geni: Add minicore support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-minicore-v2-1-160af559b273@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD6aWGoC/2WO0QqDMAxFf2XkeZU2zIp72n8MH2oXZ2Da2ahsi
 P++qo8jEDjhcG8WEIpMAtfTApFmFg59AjyfwLeuf5LiR2JAjVYXRquOe/YhkqrzukAsyTaWIOn
 vSA1/9qh7dXCkYUqJ43GE2gkpH7qOx9RAaC35HAsPm96yjCF+90dms/v/nbNRaUpyOvcXo52+B
 ZFsmNxri83Sgmpd1x9wCUgZ1gAAAA==
X-Change-ID: 20260710-minicore-b5b7229e6f6e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4OSBTYWx0ZWRfX5s41BAJvQk49
 oNlc/ehI13YtqmwRQSK/xvQHgsjTvWeK/nTiIspd+pg6O5QbyE2Krhn/5Jv7OWHc68ZrUupHn3S
 Ho4NyN05uf+v1WJBqe5+q2e5cALkaAg=
X-Proofpoint-GUID: LeyV5zQk_7CR-ApDHtbqERDtU7aZj4Av
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4OSBTYWx0ZWRfXzSxsXjs2DeM+
 C+lzGrsjUS0YQ5b5DBE2tG8pMRMizPyQm/m6AzsR3RKKt4XuBo/ShQ6YM+5sndZCMS1QNOHXJrh
 /3d6B9DUm7HsFv5SDpjpKO2KuMcixjRWIHtNdUN4eEmPavWkCbU80bHSIPjuGlc3JvbFpqbYvZw
 R6GzTvDYr7X7oWcyf4ANYl5z8SgXdBp0mRoJLTURmH2DU0QydF9YrFUKZx/QdqndVjAnx2GDO3n
 kRSQHaZlfOaeG9t1mWmsEGd4FgWJzLY3Bh7LINbBXpQEeQlJwk4rwdhPlLzXK0KalpNnBa/kGmR
 1Y3e5m8S0KuSDf5G7dV38t32conYbTp21q9mX2k3jzZz1fawqXigzT/BflWjIrnEuj6jjfWovbP
 ZGOU20698x0jm8U/XANqJL0QiVVDY0KqMZ6pCMccmy9zBJ2adu7ahoXKTGiGkIuiJyEANCuofq8
 ck8nTb/E2IBuihXZdZA==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a589a4e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=YfCOm-DyAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=cm27Pg_UAAAA:8 a=cQ2vkqh8qupFpVM6Gu4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LeyV5zQk_7CR-ApDHtbqERDtU7aZj4Av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160089
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

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Address the feedback in [1].
	- Separate out minicore related changes from the SPL changes
	- Avoid CONFIG_QCOM_GENI_MINICORE check in multiple places
	- Move struct qup_mini_core_info and related defines to separate header
	- Undo changes w.r.t. EVENT_SPY_SIMPLE
	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	  to use Micheal's EVENT siupport in SPL

1 - https://lore.kernel.org/u-boot/9f40675f-e39d-4849-a6f5-7dcd7aeb251a@linaro.org/
---
Changes in v2:
- Missed to 'git add include/soc/qcom/minicore.h' in the previous version
- Link to v1: https://lore.kernel.org/r/20260710-minicore-v1-1-19ea05c410a0@oss.qualcomm.com
---
 drivers/misc/Kconfig              |   6 +++
 drivers/misc/Makefile             |   1 +
 drivers/misc/qcom_geni-minicore.c | 103 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c          |  85 +++++++++++++++++++++++++++----
 include/soc/qcom/geni-se.h        |   5 ++
 include/soc/qcom/minicore.h       |  25 +++++++++
 include/soc/qcom/qup-fw-load.h    |   1 +
 7 files changed, 215 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bde5c640de8..0b7894f131e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,12 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_MINICORE
+	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
+	depends on QCOM_GENI
+	help
+	  Enable support for minicores in Qualcomm GENI and its peripherals.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2daccbba74d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
new file mode 100644
index 00000000000..12c57bdd8b2
--- /dev/null
+++ b/drivers/misc/qcom_geni-minicore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
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
+struct qup_mini_core_info qup_mini_cores[] = {
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
+};
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3133f85885 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -21,6 +21,7 @@
 #include <linux/printk.h>
 #include <soc/qcom/geni-se.h>
 #include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/minicore.h>
 #include <dm/device_compat.h>
 
 struct qup_se_rsc {
@@ -34,8 +35,11 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+	bool is_mini_core;
 };
 
+static int qcom_geni_fw_initialise(void);
+
 /**
  * geni_enable_interrupts() Enable interrupts.
  * @rsc: Pointer to a structure representing SE-related resources.
@@ -163,16 +167,54 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 {
+	struct geni_se_plat *plat = dev_get_plat(rsc->dev->parent);
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
+	} else if (plat->is_mini_core) {
+		/*
+		 * Minicore controllers come with pre-configured functionality
+		 * and don't need a firmware download and just need the register
+		 * configuration. Hence, skipping the firmware part and setting
+		 * up just the register configuration related information.
+		 */
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		if (qmc->serial_protocol == GENI_SE_INVALID_PROTO) {
+			dev_err(rsc->dev, "Invalid MINICORE protocol (%d)\n",
+				rsc->protocol);
+			return -EINVAL;
+		}
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
+	} else {
+		dev_err(rsc->dev, "Neither fw nor register settings found\n");
+		return -EINVAL;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +392,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
+	bool elf;
 	int ret;
-	void *fw;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +420,26 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
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
+		elf = true;
+		info = hdr;
+	} else {
+		elf = false;
+		info = fw;
+		if (!IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
+			dev_err(dev, "Error: f/w ELF not found and minicore support disabled\n");
+			return -EINVAL;
+		}
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +468,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
+			plat->is_mini_core = true;
 	}
 
 	return 0;
@@ -473,7 +530,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -518,6 +575,11 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+	if (plat->is_mini_core) {
+		fw_buf = qup_mini_cores;
+		goto mini_core;
+	}
+
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
@@ -544,6 +606,7 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+mini_core:
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..3063b37010d 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,8 +77,12 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
+/* SE_HW_PARAM_2 fields */
+#define GENI_USE_MINICORES		BIT(12)
+
 /* GENI_DFS_IF_CFG fields */
 #define DFS_IF_EN BIT(0)
 
@@ -248,6 +252,7 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/minicore.h b/include/soc/qcom/minicore.h
new file mode 100644
index 00000000000..9f2071ed86b
--- /dev/null
+++ b/include/soc/qcom/minicore.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _SOC_QCOM_MINI_CORE
+#define _SOC_QCOM_MINI_CORE
+
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
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+extern struct qup_mini_core_info qup_mini_cores[];
+#else
+struct qup_mini_core_info *qup_mini_cores;
+#endif
+
+#endif /* _SOC_QCOM_MINI_CORE */
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..df8a615b46b 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -14,6 +14,7 @@
 #define GENI_INIT_CFG_REVISION		0x0
 #define GENI_S_INIT_CFG_REVISION	0x4
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define GENI_CGC_CTRL			0x28
 #define GENI_CFG_REG0			0x100
 

---
base-commit: 2e266ec527c20dabd53dc1b19950ce5b77cf2f24
change-id: 20260710-minicore-b5b7229e6f6e

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

