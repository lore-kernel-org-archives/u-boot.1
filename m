Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE61CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09447848F0;
	Tue, 16 Jun 2026 11:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqcIRrZW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uhc0CAJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2C4848EB; Tue, 16 Jun 2026 11:23:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D0584908
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G7TRSW2528317
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H6IALfnGyOGNME3XhAL6rqclJP9/LWsWIWZczKG9GAg=; b=dqcIRrZWk2zCl3lp
 WtzkiCqLMLLw5YfGfc1v5zbLi4WCwsy5OcWgM/DTtQmfMAMUCh5ZMKMlqSDqdeSk
 eK+Ha28WCi4xA/zTAiXdY0RKq3kN3oiq7m021LtHDv4+HpmiCdnZBkeTrSu/RSv3
 sQqQE9wJfg2LLnc6jL9F+HxVCoRfcBN0bNc3QvvXf0/NjH11c6gAtt42oqzE2gIN
 +nUbGyQDCXNmjk6qg3n5qx9j0npTbk1daEY+L+1dzMDKLEAFqn0OVVgoqBjBSWM7
 ZcYhYeaRijESMHFqSompW81+tOq5A8agAV6BLlDPSO2f7wracUs0Rc4s8Hnp0w1h
 qfGxBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu253gfvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d985df4cfso5015550a91.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601817; x=1782206617; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H6IALfnGyOGNME3XhAL6rqclJP9/LWsWIWZczKG9GAg=;
 b=Uhc0CAJcsko8BVflqMVm++Gt/2R9YmcIdumNUnZdKAubYQo8FcRusxrrstZlWd3o48
 5UaTkGKnRSoJ/rIdv8l+nsakIUjfXKQAxjyFTSYEleKowh0dyzotbJ0oYRCQqU8JKQQP
 /eU3psOKzqqQatarP673Z3Xn88imEkrUxqvHqREIE+9Zt67VKFP+tzuTUsR5TNivtvF3
 eM4hGb9BtXQtaGeDHbAonBecGJFEQh6epiroLTqSonCRqToiuJirmlb3JNZR3DSV1Ef2
 POZpe8Y3qorMIDFJ2c15qvsajODlmReSdt4DmIottcM/7jDTLIA9BO7wAb2j6V+yApOH
 OJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601817; x=1782206617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H6IALfnGyOGNME3XhAL6rqclJP9/LWsWIWZczKG9GAg=;
 b=d1b+poACNK0GdtbltHKGBrdkSjB4kypNTSXbQ6gsBq/MWE3hc/ctQywJ1xzvDZr4V4
 DerzF/fANCX1UE48ShjIcyKo82ksJyM2S6SD1b8vBxFTlqol5DaaSUb1+50CVEBXzCKS
 GzgagSVMXVyH1bY32UUXP0JltrE+KhZFgjZLZ6OyYD16dwy8ViDIhzBcFZb0uJzY5Ue/
 IWjVAC43ckpD9xXzZFEMyzJEu6j0oLu6ufAdqxW+gNXgNkPoC+QrHzem+XVosiKwvgXl
 Bb5ExUjUx2BaTSXqmd0P3CPZ/VaBmJ6QbFbEOrcG7ApxzDFpHIs/7IGzk8hzfMfQWmdE
 9fJQ==
X-Gm-Message-State: AOJu0Yy3Z96pbBUsu819tUhy8LiACh2On4xJIHVO1h6fdvW7vezxbNQf
 4/qRswi263brmPyLPXcFJKzSw1PbQRnHbne/RIfa+LVW1iL59cOtC1ZKMGMv6gKcB1Wu3p+KeuB
 FO0S4+MwOL69oNTD/OAprqMX8/TjPP6ibv4E0Wbt9KaBje4b3Ogm6YG3e
X-Gm-Gg: Acq92OH7oBOJHl95LqEyZGePN/EkrOjcPRGX38BzvNT71t7DExZwBgnKA/zTiphkcx5
 qMPcRuJNPaTdoBqUer/X90yvrvkDviFRnI6IrJDyMyIdnLRS1dIhzAG7nap87vk/BMHMtB0aHN9
 F4wcCYO4NxKhHa3/uJlPZs7roiHNxVjvSTsbQLHtCq9AnUV8mPCWiEeK/JFCdoqmpwNy2H3pehL
 NYx/rQk7+f+OOZFKlhTIvVnCcNTmCZzWQzBA6eHdY64k8226v3inzkb9FVWTly8wP9WY0iVErKX
 Ih+4TOdbw8c7dgLtuMRQkJlAb4gZU2AlAFc0woRqg3Yel2JT0VbKfuC2gFStOw6NdeWjYE3p21D
 XYIY8lANymMMHOtdtcd/RHohsu3Mj6IbQCWRgOCx+M3enCJHR2hOL5e1gSUzlr9OzT8xeToZdOF
 HwRaaYuhY25vFZVAqFT+pR0cY9nFLQPLGXTx8Px/GhviFMU/KpSA==
X-Received: by 2002:a17:90b:3fce:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-37c5293ddf6mr2725146a91.24.1781601816981; 
 Tue, 16 Jun 2026 02:23:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3fce:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-37c5293ddf6mr2725108a91.24.1781601816512; 
 Tue, 16 Jun 2026 02:23:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:36 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:55 +0530
Subject: [PATCH v3 5/6] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-5-6fb0dee8125c@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=2912;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=XqRuR8GnbtFyBB1gYWYR23a81mLwzeeCNjNm+f6uC6M=;
 b=AsotfHsnWENEY+2HZ9Bsm/5jPao0p6FPfnh1oenUqQpihTPV/0AAFNAcduGrIUIeqyn/Zc79a
 5h5IxhFlO+ODZaz2QOWaWF7pUbzw+qqIr1oiq3kJnKVPFa4xlVjIll4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: h4UOZsZwQBikb15FQvssPpCbKV3FHxpJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfXwadV+fsrWFpb
 oCTUmpq8dyKv/Q/txBEPitGJe5xG/T7se9F6YzH6YZ0n1Mv5PU8cUVYIG4XuTAZ6BwZO+0u8xxQ
 wyI8xI7v4Td4k0GXhc5epUYXgY/CPw8=
X-Authority-Analysis: v=2.4 cv=WNdPmHsR c=1 sm=1 tr=0 ts=6a311619 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VT_t5Kp36RIPchdbbsgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX/YrOSPG97zno
 LwEWx6Ge8I3592sE34gjtFCLCTMv+E8zhduJSQzeEnfX8i29m/u7NdvUQkyCejquM4meUTwEHYP
 wovNpB7M5YbgSoVx1VdnZeBC20g7aXAiFpAgdMwRxMzzE4pBj2hXCz7gov1QyWBoP69YVTYAPwK
 h2etlfOgNE0/7IfRN1Aufh3L6JFnvZ9QZEbs6LX4xYPwMLbptVlz3+xr5hp0hQVZ7dfToETK1jn
 vqd4srJ6YUBjyZ0GOZC5wPd3gZndx1li/4hgh48QHEqfZVg5zOBvcBl/L2nrFPyWOlzFgTypTb9
 VqK4S7KJGyWy282nTeOMZGRoIwNyU9HglrvYr6dF6VibzFt5smlnxx6lR4u1tWPD/fWywU5lM5s
 fhTiXxjJFhkbG/zu6/12S8UJyng/6dhVkP5WCkenrFfwBc0OcAXJZ32sjVoGxz30V/+ITb+eOkI
 620uQ2GcSdzrvS7BmrQ==
X-Proofpoint-ORIG-GUID: h4UOZsZwQBikb15FQvssPpCbKV3FHxpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160094
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Add QCOM_COMMAND_DB_OPTIONAL config to allow the driver to bind
successfully when CMD DB data is absent. When enabled, a warning is
logged and cmd_db_header is set to NULL, so consumer drivers receive
errors on resource queries rather than preventing boot entirely.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/Kconfig  | 18 ++++++++++++++++++
 drivers/soc/qcom/cmd-db.c | 14 ++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 8243805e46a..7f4cf1b9a98 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -18,6 +18,24 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
+config QCOM_COMMAND_DB_OPTIONAL
+	bool "Allow operation without Command DB data"
+	depends on QCOM_COMMAND_DB
+	help
+	  Allow the Command DB driver to bind successfully even when CMD DB
+	  data is not populated or has an invalid magic number.
+
+	  This is useful for platforms where CMD DB is not populated by the
+	  previous bootloader (e.g., snagboot mode where XBL loads U-Boot
+	  directly without initializing CMD DB).
+
+	  When enabled, missing CMD DB will generate warnings but allow boot
+	  to continue. Consumer drivers must handle cmd_db API failures
+	  gracefully by checking return values.
+
+	  If unsure, say N. Most production Qualcomm platforms require
+	  valid CMD DB data.
+
 config QCOM_RPMH
 	bool "Qualcomm RPMh support"
 	depends on QCOM_COMMAND_DB
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..9b5091f5b5a 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL)) {
+			log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
+				    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
+				    cmd_db_header->magic[2], cmd_db_header->magic[3]);
+			log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
+				    __func__);
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
 	}
 
 	return 0;

-- 
2.34.1

