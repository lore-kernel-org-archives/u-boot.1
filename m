Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27181EA7194
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B236B83B99;
	Sun, 19 Apr 2026 12:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9VW1fBp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exnIz6Du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7439F842B7; Sun, 19 Apr 2026 12:24:46 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0356A839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J0QvCn1885502
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4uuU3PLF8tPqUhV5YHbCgKz97GXzUgN3eDnojZX/8W8=; b=i9VW1fBppi2l+hcm
 vl0X2smOQI7LzQjkqbbGdPUVdjxwlU02tqgE41FR7M+K6FIYMZovcNpIWt+MxluI
 8N/K7kcYvHJdmDADrUBCUFwqkH+KFfT83kCVqL0mrzoMVrix3y7YpLGkN4grAGml
 oMUi75zyI0qEs83ECjc5H9Xw99Zjs7C+0Cxu+E1/5TYQAQIci0mDB31apPQPji21
 HuRXY5I/NOntfaBbXQGAcSzBTJcB5I0uo2XqBxUWL1FANt8B+jy2Kh9mALynObsK
 sEmGkZctH85uJkn8THHeowSHmZYsJ6w56QDnM5JYYb/OxVYaSXYGWDce9nQSxVmZ
 2x6QIg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm261tc00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso17399525ad.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594281; x=1777199081; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4uuU3PLF8tPqUhV5YHbCgKz97GXzUgN3eDnojZX/8W8=;
 b=exnIz6DukUBI8sbSn0WoIq9D20+Nx9oa6W70pJVLuwjWi24eKj0Iw2BzSsn5EbyIaE
 inT/WNnkQCFQ9ROLRabkLq11Mtq60QU6LVhbGmUBLEc2YMEoib4ya/owrMCxhWtBJjnb
 7JG0M1+Nw0WVA0qvWfmFxotl6UsAED9eDP/DA75VdRHWubg1bfAobYOU0iooIyTN6IeX
 8Cd6TOPYaRMue6Yb7KITn9pMthLQ8BswD7pQ7qGq2cYcWXn20XkndN9oxKYyo9n9m1Xw
 2XSQvmmxugZJpq9d73GFT8WOaDGiqDSiCS7xjFqpHMk2tsDi5yhMzE9PvoRq5cskfFhA
 fUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594281; x=1777199081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4uuU3PLF8tPqUhV5YHbCgKz97GXzUgN3eDnojZX/8W8=;
 b=AzigMGxsM0DotSjSpNr3pOlMmQLdBOAxPrPwNd30cJf4uTyhrnb/0fF0JSSetuBQXE
 yuOegN/HNqysg7Bwy7PXoCE10J5y3Gh1c1P6w3Uby1aIGG6nXvLgkhe9ZxMAzq1VvVkV
 nViV3hlv2WnTn9IimZfOyq6ETSHIrcxP5DndoTcSwWkEIbHJt/vkD+Xg7SEv9qyarlg/
 iuQfehKsP5/TIYbMGuiZp/dCAlBhIVi9Vq3Lf1ysdgCSlSAHHoyZLjhr+ed4dg/nPfst
 ru4aT5aT3nSgIs362CLn+kqPVQEW+GgB9iBIUPjJQTwKaVqU65S/QgOZlbFshbyhc8RQ
 Hdhw==
X-Gm-Message-State: AOJu0Yx3mnNUjoWl59yUpLW/GPbyUScZ6g/zrE2ZmeFfDSX6LKr/kfG0
 nT3jLGrEkmo61lPsjaV6cNMt9/8nbGcAJQPmqzUlox36wPDh597Wdg+n0Na2BZ6yF9LonRY4Ox4
 zqmUep30jddQVq5hGpG/NotXUqeSbwEsbdspBlbGPtMvI7+giOFnSrATQ
X-Gm-Gg: AeBDievclUNu+eezkZCJuYh2yz5f1TSWw2hCCXssuJfkvdQGjIaiFfnvM7l5YBKKNzA
 Hspzhx2volFmxK5vcNwNqnFYUwDkv3rX1NHrLMNbPqOlYmC/1EPZmwB00PcLOHq0xPsrxoXJGDx
 N1c0RO6p3GyjjtoISXgsG8t+lzQbDvBGYQcGMTaPpiVu6WzKk8ASonJIrnQ+0/KXR7Ho59G0vcq
 JfMcLR+7qMuh72FoYbElFEAH5tJEKeaoW+Mt/qIKeBWnaQsmZ0VYHtnOt/mXghMJSW4VqmKKwLW
 MowKxAaSJK5+Y7vNdFH5eFJxd3wq1J0Ha98wV2a8MepaitJ/N4FXpLcb7V8UglpabZNmB2jus7w
 n+SjV+dh8vj+zKyT62efXmwx8XrqlpNwo69anXQUMqIhkM9uoEz+nJsk5zTKYADaE9o0bMRTIiQ
 jHdA+5ygoInHT46SYtujT+dnobV2Qsvm7sW0rpvBlzS6LrqjT/rBVIBWgbXQ8s
X-Received: by 2002:a17:903:487:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2b5f9f534e4mr74306045ad.39.1776594280976; 
 Sun, 19 Apr 2026 03:24:40 -0700 (PDT)
X-Received: by 2002:a17:903:487:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2b5f9f534e4mr74305825ad.39.1776594280466; 
 Sun, 19 Apr 2026 03:24:40 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:40 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 15:54:05 +0530
Subject: [PATCH v3 3/5] env: scsi: Add support for partition type GUID
 based environment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-type-v3-3-ec49acd6870e@oss.qualcomm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=6857;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ptaZIRl8Fd1wFSG4SCuaGj53b/GoACj6FU/OIW5q6cc=;
 b=Rn7UBp/b6RZNpghC/a+2YNDNRy+MEeYpRc6k9BKDJ+wNmL1zbTobQPTWYpDVkdMCgOLvoab0P
 E3yKeOqScuyDWu72LnSmLEJxQAnf85PdWJB8k0obBZuTbdHPbfxDRrx
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfX6/kExViKOSlb
 r6KH8AFEpQyIpa2Rz3oLEZz8E1jxNsQj0DraSUAs+TS1UKLIvu3fMNrjDo+6iz4esW9l1sC1soT
 L27wW2838M0f/pb8Ji/Ouf8KtwNCKfwC0zzSjPcM2koYXT8gOqljUjzEnmpqWjEDkky0y/4tSfW
 J0nvuN0XYkQs8+v9Ak+WQGLmSKmZvKz/TvW8npTx2JldUhRdx4QtEKuCR6BLOS6zbrEBFo1qRjj
 HK7jXPquBLWEBjdyb5NlbXwtF8g4LgdpTzI1wR7Ry+6oQZRbKY2Cda9SsG7HiAUbq/ZgLJO7YnB
 hxscpIGtlw+mFLiF4kyP7hyUr77/aVtbAm3cqiZIbc+LQDDFRSDV1rP92KjpQpGq0tSVuX8zmOU
 s0WnF6xfFu2FENcaPyIuTadf3uFJp8s2psg4ws/WG8BtT9V0HPwFDLqQJn4Vq3qcbunUq9S06oh
 8Y9M7Y2tX/GUMV0dyAQ==
X-Authority-Analysis: v=2.4 cv=dcywG3Xe c=1 sm=1 tr=0 ts=69e4ad6a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ol_ERQdGGk5JG7MUTbIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: BFiLqSlZthOq4rO9zDwtpRV9yJpA6r-6
X-Proofpoint-GUID: BFiLqSlZthOq4rO9zDwtpRV9yJpA6r-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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

Add support for locating SCSI environment partition using GPT type
GUID instead of unique UUID. This enables the saveenv command to
work with partitions identified by their type rather than unique
identifiers, providing flexibility for systems where partition
UUIDs may vary across devices but types remain constant.

Introduce a Kconfig choice statement to select between three partition
lookup methods. The choice provides mutually exclusive options:
ENV_SCSI_PART_USE_UUID (default), ENV_SCSI_PART_USE_TYPE_GUID, and
ENV_SCSI_PART_USE_HW. The corresponding string configs depend on their
respective selection method, creating a clear configuration structure.

Introduce CONFIG_ENV_SCSI_PART_TYPE_GUID configuration option that
allows specifying a partition type GUID for environment storage.
When SCSI_ENV_PART_USE_TYPE_GUID is enabled, the environment subsystem
uses the type GUID based lookup method via
scsi_get_blk_by_type_guid() to find the first matching partition.

Refactor env/scsi.c to use compile-time preprocessor conditionals
instead of runtime string checks. Replace the previous logic that
checked if CONFIG_ENV_SCSI_PART_UUID was empty with explicit #if/#elif
branches for each method.

Elevate hardware partition selection from an implicit fallback to an
explicit choice (ENV_SCSI_PART_USE_HW), improving configuration clarity.
Move ENV_SCSI_HW_PARTITION to depend on this new option.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Introduce a new choice config: ENV_SCSI_PART_USE_HW for
  ENV_SCSI_HW_PARTITION
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs

Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
---
 env/Kconfig | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 env/scsi.c  | 45 +++++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..d5d956cb4ce 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -780,10 +780,51 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+choice
+	prompt "SCSI partition selection method"
+	depends on ENV_IS_IN_SCSI
+	default ENV_SCSI_PART_USE_UUID
+	help
+	  Select the method to identify the SCSI partition for environment storage.
+
+config ENV_SCSI_PART_USE_UUID
+	bool "Use partition UUID"
+	help
+	  Use the partition's unique UUID to identify the SCSI partition
+	  for environment storage.
+
+config ENV_SCSI_PART_USE_TYPE_GUID
+	bool "Use partition type GUID"
+	help
+	  Use the partition type GUID to identify the SCSI partition
+	  for environment storage. The first partition matching the
+	  specified type GUID will be used.
+
+config ENV_SCSI_PART_USE_HW
+	bool "Use hardware partition number"
+	help
+	  Use the hardware device number to identify the SCSI device
+	  for environment storage.
+
+endchoice
+
+config ENV_SCSI_PART_UUID
+	string "SCSI partition UUID for saving environment"
+	depends on ENV_SCSI_PART_USE_UUID
+	help
+	  UUID of the SCSI partition that you want to store the environment in.
+
+config ENV_SCSI_PART_TYPE_GUID
+	string "SCSI partition type GUID for saving environment"
+	depends on ENV_SCSI_PART_USE_TYPE_GUID
+	help
+	  Type GUID of the SCSI partition to store the environment in.
+	  Uses the first partition matching this type GUID.
+
 config ENV_SCSI_HW_PARTITION
 	string "SCSI hardware partition number"
-	depends on ENV_IS_IN_SCSI
-	default 0
+	depends on ENV_SCSI_PART_USE_HW
+	default "0"
 	help
 	  SCSI hardware partition device number on the platform where the
 	  environment is stored.  Note that this is not related to any software
@@ -791,12 +832,6 @@ config ENV_SCSI_HW_PARTITION
 	  partition 0 or the first boot partition, which is 1 or some other defined
 	  partition.
 
-config ENV_SCSI_PART_UUID
-	string "SCSI partition UUID for saving environment"
-	depends on ENV_IS_IN_SCSI
-	help
-	  UUID of the SCSI partition that you want to store the environment in.
-
 config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	depends on !COMPILE_TEST
diff --git a/env/scsi.c b/env/scsi.c
index 91a6c430302..abb8b0a1dfd 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -41,14 +41,19 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 		is_scsi_scanned = true;
 	}
 
-	if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0') {
-		if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
-					    &ep->blk, &ep->part, true))
-			return NULL;
-	} else {
-		if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
-			return NULL;
-	}
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+	if (scsi_get_blk_by_type_guid(CONFIG_ENV_SCSI_PART_TYPE_GUID, &ep->blk, &ep->part))
+		return NULL;
+
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
+		return NULL;
+
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+	if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
+				    &ep->blk, &ep->part, true))
+		return NULL;
+#endif
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -95,20 +100,24 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_TYPE_GUID " partition not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
+#endif
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_TYPE_GUID " partition read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
+#endif
 		return -EIO;
 	}
 

-- 
2.34.1

