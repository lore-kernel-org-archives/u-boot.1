Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F9AFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB9D8410D;
	Mon, 27 Apr 2026 14:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7nXN7nR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d465mQLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD3284236; Mon, 27 Apr 2026 14:07:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE1F80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RB72qj1237202
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zjdNZlM+mi/RoOEmOfFhw80yi21syL1T+K/GcHgaUmc=; b=E7nXN7nRG5yPSHWZ
 g3qaUkpebenJzJz/FnVmw7z8QEjusPDS4Pxb6D7MpomVrbiAa4dQhyKv+L17c1zA
 /UN64DnlcFmoP1XB5zcNLjB4nbBpyWI6GjZaAuPLeFl1cxm9/iKRrbA2mZr4z27n
 ixOT9q376FFwd+KzNNHNsJ/0qvp6eUFJrfo2/9DDxzgopvr98vsWI8ykobH9ull3
 q3EQVHgysovhi2ExWMlbIZfzW/AQwXR6V5urt8nV/5Jo7lGa3f7oftbjxsrmCwQ5
 kFpqlxdmQ5YCLoQNmMDch03JWVPtxn/FAlzSCXeRpWKJeVnF/8TdKY45J9FvW4xF
 AZtIEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4g6en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:07:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35fb969a4c0so11068861a91.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777291621; x=1777896421; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zjdNZlM+mi/RoOEmOfFhw80yi21syL1T+K/GcHgaUmc=;
 b=d465mQLz3bBYCzjpIv7UTUQJDytF3hPrn/HB2tiQU6G1IbuXZa8LWM77ji5FMamWpu
 p6HcCq+jWT8+qLK0hLH1tR8F2aGP140++Za/U9fEshwqWvqRB/LqjaZ8n1ogkDwZ4Y4T
 O7xty5oB3GnrxaR+49LRk1IL6hXvHvcJ5zl5XupR2innIRQCbpuYwySCvF9jm7np4U3Y
 WSt8vPoe+s75QWd3YELhijSJymQhhdPJxIPdhmYvWnUNeb3CdamLFq217C9Y4LcdyWSf
 JlYNPB5cKEkM1cBegJf7twkTXzW1Z7L5p1X52zQGUgGvpMNjAXzswME9iwvq5NN7ruuT
 uxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291621; x=1777896421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zjdNZlM+mi/RoOEmOfFhw80yi21syL1T+K/GcHgaUmc=;
 b=b8Mq8X/KIMWn0rbX0cL2F4Rcngl1LOseVFpNnGfl8wpz3cMF1+j5WqV9XMSuX8sOnQ
 RXbnMzbL95a/0Wym7woGfvz4glLsVo1iZ38qYkeE1lpfBTQmNyCYkOMO6zszr+Jey57o
 7cmHKlNRKhn67UHrTO7vWAtmNrolKfuyAT4K6kbarirM08LOBEoO2bV+41vpSSXAxS0n
 ER2+VvDjU4GZWVEukwWil2VjNDmoOMnd9yCVudXfQSZGl7ncXQcNgBL9TDFKFiJOKvDt
 cdopI+ZAidN8ZNQtXxO+EMClQc4TntXpDpjrZNbH3/tMuPeWZdCu5NPr0gXui50y7kVn
 ikAw==
X-Gm-Message-State: AOJu0Ywvrz+PXbxvWf5NrGWmDaScfniJj3j5dqcFQ1mSXttTLKOgB8uO
 tPgzDIAeqe+O66USwjDwHr4SH7WNEVHrpiCAYGYWb7KLA6sG8O+9HDx+8VTypCMQwEXXu92cmE0
 eaZQd7mk5798jjKxBWCnyZ4REQZmKJOUFpnND3JHEIGTwMVRtlth1W9uPuKpno7FW
X-Gm-Gg: AeBDiesEy9Z0gDtHGxvd4nbUHm7R8WE2IbLYbvwjhW0o5i0PbSvCc4X+ox0MB3JARPq
 FO0gtnjO27IDKo5OT/PZ9RL0m745u3Mjfv1AbjkXLC1J5WMBAmooMSiohpCLAmFdzzjuNP+VekW
 TYAAXKa7dOi3pqF2+AhKBX0bEfrl7ERzP6gF5T7wTWXGfs6wk/fe0zAOsZZMz/B+cR5NnSbpKOH
 bPkCtV7ZIYTJbi4y/JchOrEiN4Xe341QpYRfaxpxSJfa3Xv0QFU9wGdR/VSGmL+zoo6m6H2fL8U
 fhkqp0z2b0+Y6l8hUXRg1EGU6TQqjxsXYztyu04NF6S/7bfxJbw4ugJ4LFRhEX8DhqXJ8vWIQ4U
 VfcuryTEty4Mmp/gPCn6wXhw9I6tnFab4B4eMKQogzOV+h8THCQyQWbCA14dOl3rNqWlYUDl5q9
 XJ+aiawUhvhWr3QAnttuCSx62Q7D83mc693U1a9XjhcTVBPfg1uJf+qshDc/+2
X-Received: by 2002:a17:90a:ec8c:b0:35d:90c4:59f3 with SMTP id
 98e67ed59e1d1-3614046e0c5mr44674405a91.13.1777291621386; 
 Mon, 27 Apr 2026 05:07:01 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:35d:90c4:59f3 with SMTP id
 98e67ed59e1d1-3614046e0c5mr44674386a91.13.1777291620746; 
 Mon, 27 Apr 2026 05:07:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140feea38sm31832910a91.6.2026.04.27.05.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:07:00 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 17:36:44 +0530
Subject: [PATCH v2 3/4] fastboot: block: Add GPT/MBR partition table
 flashing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-fb_gpt-v2-3-9e7fe3c1649a@oss.qualcomm.com>
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777291604; l=4014;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/cXGBEwhSfFx/fKdi8k2/mzM6neEL/rGfHpFDhczrBU=;
 b=DlUtt3qh8LT5qWddzchsMkRVVF0fS9wEpcWr7CyfIv9FdxwO2F4/JGZCr+695OgQoQi5UBlBM
 jjifCxfVABNAIdsU5uZ4HS///aKoWV60+vYyYwNAnaKh33zX/Lv3Iq3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: OVSX1od2kZgvGMATQa7Gj0xu-NR3N2j4
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69ef5166 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=g-st2ZJDtLM_O9EgdKAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: OVSX1od2kZgvGMATQa7Gj0xu-NR3N2j4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyOSBTYWx0ZWRfXxi1JN0uPuS+Z
 dFQJkQ02qEEcgOuCbW76oBkmcp1veFty2vN967cz90S9Ev6QXTObJCQ8Dlv0R6ZZYUiodPfixCt
 RFuNj6kPYDSqz2KUBLGKgIUU0ZDOF1f8FxfLL6s4MKYKvSgsNGxGnPMN6j1Tv/q+jeToklimRmK
 I0X4+8kpi4J4r4EMJc4V8/0m0YGwRqO6DYBuEtclnzgsJMKLTNgnx19VLxBNbgs/GBVvZAVtzHj
 jdQV3Db9QQgQUfh1jX/Kh9Nl5PDx2YQmJ5GwXHf324D4cfmN7ncTIOU9bZYCtmpZXXe8g2heqPz
 7NB07KbYlQCr/MZ1nIFqrbPL+sX//k9B9Sm7PDRp3ytVU3CE8s8dUFUYP2djWCwBWOSh/F6qxve
 vE7ZfVShgt8+Do+eJ7qqtUGEsW1MpjY3pt2uiPbIyb1Ed4Iw5RRzWAiVX7ECHJP68dm5ZLHtNyZ
 Nnk2Pf1J7faTo9pwbzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270129
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

Add support for flashing GPT and MBR partition tables to the
fastboot block backend. This enables operations like "fastboot flash
gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.

The implementation validates partition table names and rejects
invalid input formats such as ":gpt" or ":mbr" where the device
prefix is missing. Valid formats include "gpt", "mbr", "0:gpt",
and "1:mbr".

Update Kconfig dependencies to allow FASTBOOT_GPT_NAME and
FASTBOOT_MBR_NAME to work with both MMC and block backends.`

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly created in v2
- Adds GPT and MBR flash support to fastboot block codes
---
 drivers/fastboot/Kconfig    |  4 ++--
 drivers/fastboot/fb_block.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 576c3ef8a45..43d83265df4 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -227,7 +227,7 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
 
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
-	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
 	default "gpt"
 	help
 	  The fastboot "flash" command supports writing the downloaded
@@ -240,7 +240,7 @@ config FASTBOOT_GPT_NAME
 
 config FASTBOOT_MBR_NAME
 	string "Target name for updating MBR"
-	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && DOS_PARTITION
 	default "mbr"
 	help
 	  The fastboot "flash" command allows to write the downloaded image
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 061ffd930a5..a8c74e35d0d 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -163,6 +163,27 @@ static int parse_device_partition(const char *part_name, int *device,
 	return 0;
 }
 
+/**
+ * is_partition_table_name() - Check if name matches partition table target
+ * @part_name: Partition name to check
+ * @table_name: Config name for partition table (e.g., "gpt", "mbr")
+ *
+ * Returns: true if part_name matches table_name (with or without device prefix)
+ */
+static bool is_partition_table_name(const char *part_name, const char *table_name)
+{
+	const char *colon_pos;
+
+	if (strcmp(part_name, table_name) == 0)
+		return true;
+
+	colon_pos = strchr(part_name, ':');
+	if (colon_pos && colon_pos > part_name && strcmp(colon_pos + 1, table_name) == 0)
+		return true;
+
+	return false;
+}
+
 int fastboot_block_get_part_info(const char *part_name,
 				 struct blk_desc **dev_desc,
 				 struct disk_partition *part_info,
@@ -361,6 +382,34 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
 	struct blk_desc *dev_desc;
 	struct disk_partition part_info;
 
+#if CONFIG_IS_ENABLED(EFI_PARTITION)
+	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
+		int device;
+		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+							   NULL);
+
+		parse_device_partition(part_name, &device, NULL);
+		fastboot_flash_gpt_partition_table(interface, device,
+						   download_buffer, response);
+		return;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(DOS_PARTITION)
+	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
+		int device;
+		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+							   NULL);
+
+		parse_device_partition(part_name, &device, NULL);
+		fastboot_flash_mbr_partition_table(interface, device,
+						   download_buffer, response);
+		return;
+	}
+#endif
+
 	if (fastboot_block_get_part_info(part_name, &dev_desc, &part_info, response) < 0)
 		return;
 

-- 
2.34.1

