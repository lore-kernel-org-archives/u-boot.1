Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DEFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192748464E;
	Tue, 28 Apr 2026 09:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJ81THF6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kY671Z9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83B783FB5; Tue, 28 Apr 2026 09:32:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8174B8460E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S7FBDI440889
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hMyL4vN+blJm8kEQYB6iduylN6qL6lhy/KZowRcO01s=; b=LJ81THF6eKKydUPN
 +VCrDttgRnWrzpJQjp8uqagbxGVUVKtEbXbVs0tsEvmXgbSiK3TECIYcjv/Anuzu
 0falyTLhq2J5zz7Wsj8g4p6+Z24MGN+BtmzNPggEzvDNa1FQPuZBHRaD3jZnShzl
 mSOmuZrgFNxeXOzPgOyIzQWnurNnvXOkHxT/Li+uMhWsOZo/S67QOwjAtqp2O8SX
 flsOQQv9ElS34rdvPkqVL9bp4VQzomZrcYzGVvegML1lV0NCJWcUuBZngXn004HU
 sEcmKkkSsKsVKuiEU/0mN0gt0PPU6YJ/0n9ZMxYvfRxqW3VrCszuqa5PJSt69USU
 gt6Tew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac43841-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso138197785ad.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361557; x=1777966357; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hMyL4vN+blJm8kEQYB6iduylN6qL6lhy/KZowRcO01s=;
 b=kY671Z9xFzVYLbIHrSGEaifCcIT5lQT5JGZzOqY8xFQKz19eqKqH1xr/CqFJ6wVnVA
 z6TusP5dK89ejWX1wbDQNpOstid2+Mm8uyXAw5aIjIWaPO0oB8Sdye2oAR2nPTCdWAXm
 F1p8O9nflBEeIE5HaIRcVjcy4OxtgNbdIIoO7X1g5MbWJbRTx3bM4CxknoENVAxibqJY
 gkX2tk0HnSGQjTdO7E8Pmn3HQHm+bb5xGBVI1xxa21IhnWvjRMrMpJE+nSDQ2NlTPGY7
 Lo9pexpcPoAZZI+dvlBd2uNpPv007ToghmJuGVKOeac+wxuN6C1nEpAAy4xgam6cBqpj
 4B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361557; x=1777966357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hMyL4vN+blJm8kEQYB6iduylN6qL6lhy/KZowRcO01s=;
 b=KxvQtNqJ3Ke77BLJVjY/ywXnXtG8se4ZLXqsagO5b8YAORaAYlN+Zc7gTL/3RZO6RA
 sQXjJyf+15rXocyWAamX3ndXgtV08/mAbTtbk9UVKm/9+Uja2vzu2i2WCEsk4tiTQ0wd
 gUpl/+eYBxI0U4EyrWA/hvBf+HqMN6G9AnKE9lndL0f4+jwY0V1u3gk/mW4YA9l8dYDO
 JL/r6KoOcGHDtshsj0qeLRxkYS5BX4XLu1nUlzMdr8oHQOJykyXlez6YC0Far6pC8CoV
 L0O28HoV4g8YdH2ggcASmTEXad5rB9sIbMpPOU4NDXxeeHPyZ490H+9MU7QqwhUd4PbV
 819g==
X-Gm-Message-State: AOJu0YzfNcXlaiaM06IVnTkKZpc6t15YnmpHZb9igLojhJs0p89HF7h6
 BNCQw4uMvQ4ON/zSys1PtuJeJGTtuhb0YrjJdwLuKK/q7YT/6rGrRE+nRAmkYBmJNil2/zjKMl3
 4qz6vuhKel50TmhP24VPgH8itpGtoiOZzLuLsbNJIMCqbzUJFvqTophIe
X-Gm-Gg: AeBDiesyQWdlQ1ddyYR2gE+FHrYA6/BdpJcTq0B+IoHuCqPgl9TxuX90TH0XRZXsq3b
 os9TegEIWcCz9AtFZ1efHKmkdgg5VnLxHBqXzbqY8s3+C2qHh3gIQPs/hEvjeQXiKXhgeT+HJ8n
 5avpQn1njAPM6P5ypeoqzPjDgkjjNz8ko1mDhSsBESq8wENswbQb5SRxiT8Hx/2oCPetkHdRtim
 Wq7i1O8m2N6SxhYwEBSB13BSqYXc84tB+prAlAf6lCMkXXR/9LGruuEYQF8qRTTLdKTsouyTWee
 Jj+aYVIHfMvfY2CbBGFs8gj7aZjqdihiw39EtNV8+If0G3JHArpMMofAZ8qR1QbA+FFQPKWgKBW
 0N5p3QCaNCeSawsFqELGdo52NF1RMGoNrLyDdaz0Cxa3l0EoCwnUjBAge0G1yFcAeO+Nb6wRIrE
 f7lWP0TCUM9Kp00wdbNI7P0HvjhyTdXCz3BnasmMn03A55DNHX4A1OC9iBFVdf
X-Received: by 2002:a17:902:d582:b0:2b9:4c05:5417 with SMTP id
 d9443c01a7336-2b97c47f84bmr20866745ad.32.1777361556863; 
 Tue, 28 Apr 2026 00:32:36 -0700 (PDT)
X-Received: by 2002:a17:902:d582:b0:2b9:4c05:5417 with SMTP id
 d9443c01a7336-2b97c47f84bmr20866305ad.32.1777361556326; 
 Tue, 28 Apr 2026 00:32:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:36 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:47 +0530
Subject: [PATCH v4 5/8] env: scsi: Add partition type GUID support and
 choice-based selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-5-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=4724;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=OPIW8rft62NN0XKDVX7iQkwgiyd4nzFZHnVhZykyLnU=;
 b=YO5xVDxyYlHDgiXlPXCEjwDYUTOoVO7C121bT2EnjnbViprhFgnCPYoS1Al+H90c2f4f198TZ
 WAsr0AqAW/FA+Aa6mHryl+V7dtmAUjJ96MXvp1OeTEETvlIjtWSKWDl
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: UxQ89cFW5auS4EgCsq9LAjDPQ5-XpT_J
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f06295 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=UtjBXWsYNgS_f0zzo0EA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: UxQ89cFW5auS4EgCsq9LAjDPQ5-XpT_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX0hIn/TKOPoXI
 QdniPFbydV0w9npDxvYi8zhsNXtZY8mggrNLiU80a9zTe24CuCcNBllDclpPYSfOhKz4CCwXoxp
 DPN0Y3xt45Jay44dlfUYPNTcPunTNbK5Fd4ZjctLw+1QNxPPFjOIrgT765aBtntz5ge/CAHO1g7
 Lx/JnWhvLtEvy9ETP6dG2sDqiVjB6Rnmm2ghDPZqsJLNQP9igDFQ6OWkK8pmUCbarZavahhhNkj
 6gL16h/YtMQr0UBdHjwYJoZaJHXfxytNiUD0wTacjdr78NTU+FczG3lQzik6Zi+ema6VAq/hSVX
 oI6I8p8SX+hClqOTD53Y27w484kmHP6t0Gl6lBetul9FhRetveFcZsHceksUEdvVrzGGmL115sT
 sBgz21NrNtqN3TY7GN/1lhcxU8FHd9QDBdYSPZRvidUzPIdoACfBmKAwDTzRInc4+wqetHKhO5J
 sNRWbpZBUHrHsKPE0Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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
GUID.

Introduce a Kconfig choice statement to select between three
mutually exclusive partition lookup methods: UUID-based (default),
type GUID-based, and hardware partition number.

Reorganize existing configs to depend on their respective choice
options. Update ENV_IS_IN_SCSI help text to document the
new configuration structure.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
 - Has only changes related to introducing choice configs

Changes in v3:
- Introduce a new choice config: ENV_SCSI_PART_USE_HW for
  ENV_SCSI_HW_PARTITION
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs

Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
---
 env/Kconfig | 68 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 71a27894f90..f59b2acb7e6 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -299,16 +299,20 @@ config ENV_IS_IN_SCSI
 	  The size of the partition where the environment is stored in bytes. Must
 	  be a multiple of the partition block size.
 
-	  - CONFIG_ENV_SCSI_HW_PARTITION:
+	  The partition selection method is configured via a choice statement:
 
-	  Specifies which SCSI partition the environment is stored in. If not
-	  set, defaults to partition 0, the user area. Common values might be
-	  1 (first SCSI boot partition), 2 (second SCSI boot partition). Ignored
-	  if CONFIG_ENV_SCSI_PART_UUID is set to non-empty string.
+	  - ENV_SCSI_PART_USE_UUID: Use the partition's unique UUID to identify
+	    the SCSI partition for environment storage.
 
-	  - CONFIG_ENV_SCSI_PART_UUID:
+	  - ENV_SCSI_PART_USE_TYPE_GUID: Use the partition type GUID to identify
+	    the SCSI partition for environment storage. The first partition
+	    matching the specified type GUID will be used.
 
-	  UUID of the SCSI partition where the environment is stored.
+	  - ENV_SCSI_PART_USE_HW: Use the hardware device number to identify
+	    the SCSI device for environment storage. Specifies which SCSI
+	    partition the environment is stored in. If not set, defaults to
+	    partition 0, the user area. Common values might be 1 (first SCSI
+	    boot partition), 2 (second SCSI boot partition).
 
 
 config ENV_RANGE
@@ -780,9 +784,51 @@ config ENV_MMC_USE_DT
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
+	select PARTITION_TYPE_GUID
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
+	depends on ENV_SCSI_PART_USE_HW
 	default "0"
 	help
 	  SCSI hardware partition device number on the platform where the
@@ -791,12 +837,6 @@ config ENV_SCSI_HW_PARTITION
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

-- 
2.34.1

