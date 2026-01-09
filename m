Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C3D232C8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 628BD84248;
	Fri,  9 Jan 2026 08:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUXZNnK+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Whm1SpH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA9784324; Fri,  9 Jan 2026 08:09:43 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CFC84144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6096M44u2986441
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EkT56BeDTgW
 PbV3gfOU7m2uguBSFLLVelvI2a28fN8w=; b=KUXZNnK+Ir5bWKa0uFFqUrPr5HT
 2QhbdcSxkikbAZ09uisyNW1NpKUX9P8laCV6EkMCBVMtigHYdbuMgmPYO5FF50Yt
 66pQl35lA8aqWZqUEP9fhSIYLwhqoR6s/CQ+HbVhSMF5LFy2NkIRPUbnBG8a6bW4
 IVwVBs1kDBTI+iWnI0sz1TfvkuLrHZPRZmJX5V89lFU45YOAfbdEWykMOdvKqjZh
 5jEb5AQ0+UG/buy4/p1YxtlRXf8HOYQsNLpldfaYfJUsRuyZ8Twb7GpZRW/VrHFo
 4R3+TzHUWqqQlUYKakmijoEjzLsjmY8joOAelLlyn5SpLl47hC7QkMC86Pw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjhwx1s0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:09:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b9321b9312so7263202b3a.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942578; x=1768547378; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EkT56BeDTgWPbV3gfOU7m2uguBSFLLVelvI2a28fN8w=;
 b=Whm1SpH2BtQo6HXRm0QzdOes/0MJqkN+n84GGlNlpKfP65iLKgQxxNdsoNT3zssqed
 QISLFod8aGnfvGWexk56gRUX6qm1YFbudOdmxoerYg+yHGDF0KlT3oHynNnRPreOwFr+
 IQaB7z/Roh0mFeQC0vVzJO3QbRk/nQu9f+BJeXoz0oeXlTGm1jBnifM81FzgWFA1PuFM
 zpvXmVM4f2tUL243lQyrE6+YSSVavgkuC0gyRJWn2XfQ+KULHivHGVdPw/H8nB2O64f6
 naoJ3BWCaKb6szhB5UUkYvYcbzCp4g1ndmqq/22WmFteo5XPcelbqgEYORR9DqjDrb1M
 XvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942578; x=1768547378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EkT56BeDTgWPbV3gfOU7m2uguBSFLLVelvI2a28fN8w=;
 b=wGTaT9d5f7vXtosvWUgYHJtckHLVxaNJxE1hZN0jbwLns3Pb2wnSD5cdga2bRFv6+m
 3NzhtfhYgMXZj1/2QUcs8DUcU1XSMRRg8YXZiqebT4qa6rphjH18ZqHOEYg6osaqSYMD
 7zkHhA3wD7bRG9D/3YU8GPqjx0R/7ljI20WQfX8YWsVfOXUQqF0JhRWUBYPjaXcNnHx+
 LVXa6LxTpvtjvbafvGOwWqZDumEPGC/WSycACH6O6XQtpmoTrC7Ctd999e8dyWCUkYnr
 5MOywFaUxsbYohdFc0+kcQNnvnHYmHDeoE0/dEJgJgXijJysRX98ZbZe5aoqN28O9Sf+
 TZgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJD2jT5KKsLgpSCU9SsHkHRpKNDaa0lK4r7FP+gcjm07MPvnzMvxezv2JwyihXn0hZeW6nPeQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa6ldOqFnLXtGxOIbZZdmGn9VSPkO72OZCzPErwQEkLD5QVY+0
 gdkf24tjrHZ2dmhlglosfvBWRvUh8gcR6cezUPoe2bIWlxEgYhJpXzQFyVnhcXNbVKTa3oZ+kcR
 SEU/E8ev8/3794hqhqLZhpmojl6nKW2XB73ibmFHc+45yCvatNYUQQSR7
X-Gm-Gg: AY/fxX749mdgyJpuTRnoWbU/3QrQ63VkZmk/F6q+/vG26apAGBFQH0ACzrKR3+BXUrj
 ZgvMR+lGTk29/HerPFc7ekSpPyZu5qO3qftqf0Xnul5D5nxLykiePAmDSgvB6KPAeoY4OQKG2CS
 VLxVj+KZMPYwxWjn39z7h3dd+RoFOOlGiYZjxzuviioHWpAKQqPfiNog53f1yTQ4YmjxP2gM5z8
 8Sa+H3eYBYi2u029JX3Ct4EnB6cyaGchpeuBnOkqsdm1vyIkAZ3xv352wgw+b7sIF6vbT6IovZ0
 dcSjuS0aJBwdoan7FNynd97IUIDAETLFkMLYagVgjcImP+CWlLtIt0u40ILW0oA/6X6SrD7UE4g
 XJYI+S3EIYuEiqqJH/GoO01j+IfUKKCOQGM31u9qbdPNc0TP1S3FV3mRk7/liISpv+j1sHKLvXe
 Cr/VS9rGKefve6Oy9VuynP3ub0K9hzUwcm+3vCgA==
X-Received: by 2002:a05:6a00:1d12:b0:7ff:c51d:7e0 with SMTP id
 d2e1a72fcca58-81b7d3584f2mr8588267b3a.3.1767942578171; 
 Thu, 08 Jan 2026 23:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb3AJRYAyaxjEN4pqTaszEEWd3UfpUgQzDxB9W0iQz3mYOdIS1D6da5XxegqB83IJg/LRDkA==
X-Received: by 2002:a05:6a00:1d12:b0:7ff:c51d:7e0 with SMTP id
 d2e1a72fcca58-81b7d3584f2mr8588225b3a.3.1767942577671; 
 Thu, 08 Jan 2026 23:09:37 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c85bfsm9471943b3a.30.2026.01.08.23.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:09:37 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 ravi@prevas.dk, quic_varada@quicinc.com, quentin.schulz@cherry.de,
 javier.tia@linaro.org, simon.glass@canonical.com,
 marek.vasut+renesas@mailbox.org, ansuelsmth@gmail.com,
 michal.simek@amd.com, mwalle@kernel.org, jan.kiszka@siemens.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 3/4] env: scsi: Add support for partition type GUID based
 environment
Date: Fri,  9 Jan 2026 12:39:11 +0530
Message-Id: <20260109070912.4106466-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NyBTYWx0ZWRfX5SWeqEvyPgKl
 AemkW38Bba2n7J+MWLKk9LM1ug8AXafe1I9mV/NctKNf2Uzog7cmZwN861cwSB8QwVdY5+6RYz1
 6p2EVD+44FN/uZT5C6bmA9j7ZuHRBDVpIsgFOE2aN7Mbgjp9ZdnYaKksGDgbxeSN7jI0Y73MtA0
 /a8s6IftVpUMumXLIzYZGZpS3eK68CHQwnIIydAx6YvJdCYs4velxMPdoUZW/d3Kg/qHubRBsOS
 7pZHah4Teh5PcCjJM8XFtQt5aDp091xeBhBisjpmWM992gOa0BhiKNvjprV8i0ZTpGssIK88nSj
 982jNKGONKGJNslV5nkVaTI07sFr3Xj6I8KpeMawmBasZbGxhy/9CoF2RgI4hf/TLZ5Rj4//vJU
 Fu2wkXPwwSvwj662i9G3oyfHMYuGckekhwHlAVRNUFjGZXAjWYr0/rFXuAO8HvDO6LZMC+PhhwP
 X7wcl3rBuyD1Pr0SUdA==
X-Proofpoint-ORIG-GUID: Ev6oRGKR2Mm9Hlbnv-PDFKsX1ComWBvT
X-Authority-Analysis: v=2.4 cv=ENILElZC c=1 sm=1 tr=0 ts=6960a9b3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3hivfRA64bkQfXR82fQA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Ev6oRGKR2Mm9Hlbnv-PDFKsX1ComWBvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090047
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

Introduce a Kconfig choice statement to select between UUID-based
and type GUID-based partition lookup methods. The choice provides
two mutually exclusive options: SCSI_ENV_PART_USE_UUID (default)
and SCSI_ENV_PART_USE_TYPE_GUID. The corresponding string configs
SCSI_ENV_PART_UUID and SCSI_ENV_PART_TYPE_GUID depend on their
respective selection method.

Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
allows specifying a partition type GUID for environment storage.
When SCSI_ENV_PART_USE_TYPE_GUID is enabled, the environment subsystem
uses the type GUID based lookup method via
scsi_get_blk_by_type_guid() to find the first matching partition.

This change maintains backward compatibility with the existing
UUID-based approach.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.

 env/Kconfig | 31 ++++++++++++++++++++++++++++++-
 env/scsi.c  | 13 +++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index b312f9b5324..04bb6eeddf3 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -762,12 +762,41 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+choice
+	prompt "SCSI partition selection method"
+	depends on ENV_IS_IN_SCSI
+	default SCSI_ENV_PART_USE_UUID
+	help
+	  Select the method to identify the SCSI partition for environment storage.
+
+config SCSI_ENV_PART_USE_UUID
+	bool "Use partition UUID"
+	help
+	  Use the partition's unique UUID to identify the SCSI partition
+	  for environment storage.
+
+config SCSI_ENV_PART_USE_TYPE_GUID
+	bool "Use partition type GUID"
+	help
+	  Use the partition type GUID to identify the SCSI partition
+	  for environment storage. The first partition matching the
+	  specified type GUID will be used.
+
+endchoice
+
 config SCSI_ENV_PART_UUID
 	string "SCSI partition UUID for saving environment"
-	depends on ENV_IS_IN_SCSI
+	depends on SCSI_ENV_PART_USE_UUID
 	help
 	  UUID of the SCSI partition that you want to store the environment in.
 
+config SCSI_ENV_PART_TYPE_GUID
+	string "SCSI partition type GUID for saving environment"
+	depends on SCSI_ENV_PART_USE_TYPE_GUID
+	help
+	  Type GUID of the SCSI partition to store the environment in.
+	  Uses the first partition matching this type GUID.
+
 config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	depends on !COMPILE_TEST
diff --git a/env/scsi.c b/env/scsi.c
index 207717e17b1..88abf0d5945 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 {
 	struct env_scsi_info *ep = &env_part;
 
+#ifdef CONFIG_SCSI_ENV_PART_USE_TYPE_GUID
+	if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
+		return NULL;
+#else
 	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
 		return NULL;
+#endif
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -83,12 +88,20 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
+#ifdef CONFIG_SCSI_ENV_PART_USE_TYPE_GUID
+		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
+#else
 		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
+#endif
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
+#ifdef CONFIG_SCSI_ENV_PART_USE_TYPE_GUID
+		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
+#else
 		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
+#endif
 		return -EIO;
 	}
 
-- 
2.34.1

