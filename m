Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE1C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8F0836D1;
	Thu, 24 Jul 2025 11:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nt5FBoDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34648368E; Thu, 24 Jul 2025 11:00:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4EE83721
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXlT8013730
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RVCsze+3Fff
 YtShToreIrAp8grr9lqA5+wQkfRK/DxU=; b=Nt5FBoDCJS0kbK1g0o8sALAUvPN
 ZKqu2KjIDbAbZwSCmy7JiHSStBkA4wfM4/sAv4k5fpdwHCVufloCc/uiLQfRfESw
 jFfoyCAGv3vlhgj9KE9g6cRnCHia33AuVt/F8LTWcMKYFiqj8gaXKEJJhsz0J72b
 itGRk1B7xPRUXtwo1iK0SbV9Fw7GsGaFacG5LnAD9GwKx7c1xMJZQW+EDp72yZH0
 dtu9R9v0UfaHg43hxRknfDMMJrl4qwVL8b9LMrLPb5mBxwptuaR+FNePtbjBLog9
 Jqcvw0uSEcV3FVmYtv+yO/jVANnlUZhXCrFGcyr6tAht1oJDSJ2nBVvySKg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hx4dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-74ae13e99d6so1387174b3a.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347622; x=1753952422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVCsze+3FffYtShToreIrAp8grr9lqA5+wQkfRK/DxU=;
 b=v5bNVfm6Q9yWPKKeCm49thl4+8D0/aW8qN0z7TVNUyrYHOK92hC7vvRzowFyg5Gy3I
 D1+aqjsUm0ZykSJKxipVRCdM4f5Blfv9LET3HonWHexTygKYq1y0uq6vRL4/a576FKfJ
 yuEOqRW2vDPFIMTGr4S03ayeibDwGs9ILRUkMPykN5NPqhLvAJfomN8PmgfBMRPzirZw
 uIrDY48j5iQI9EvmGXjgCYKevaOxy8OEPYcXwGNUIEyFw1ySQvi/BPNEG5vOVwbJJdU0
 TcoZ66rXIh8aP8FuRpuPS6DsXd8FeivBlUR0yLCCbwFxTX2+mmX5D3BzMc+euu85KPZm
 Ycdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjb4U9hiTz7Vq2zazox4z0fIAoIqY2OcAxM988JpBw9aT4J2jvhaqi5U9dtNukAOFZGIM9Eu8=@lists.denx.de
X-Gm-Message-State: AOJu0YybvYsc2XzEjbv4L648vljVYSOJLg6c7OodQ1AF9tFQb/+jFoRz
 hIAnp03MQxPBL3OG5YMf8FLrkza1maqRKK1ZpkSMU/gQidlgOnMDQoy+c0nWG10VEv+9kNlTZ43
 eKCFrP5RbLooJshu8a6oCPnVsPXHL5nQchHSMfklTKPnVEo2yGr0BsdNi
X-Gm-Gg: ASbGncuiIw9tMfVsLrRzUC2vT/MpcavVibAgeuseFmuiKXs3VWc/kmPg2U3VbVBoh+Z
 kf2wSrnB1ct11ewpL54tD22MTcheNbyRSFyTH3WNYSB/Zqd0CKUiCUI3hqOGjL+GZhOKEMU9TMT
 sxyhht2SVONPLsJ+jZMF1cvfSLH5u9SymiHKzcaNdkCea5x7Kx5/Y+WnaPl991DAQn6ix7ukq8V
 O4wGd5JEwmsJZc0bt+9n6wyVVmkNPZrbwVw0zYj6PZBcW7pBFU2L1Cjz4Z4rN31dJf5IAMy0azJ
 qIGc8Q/54Zr9KZ92OaufJTgqaJTPWcH906mTG44yylJtazPqiAsoP5rUkSb1BsZfsMB73DCgxzB
 md6/rUJxD1av1VtHC6n7kWJBT2EFTnFuWfVEfsrZWuNoeZk0pIAzZVE4ihc3n+C6IsOwY
X-Received: by 2002:a05:6a20:748e:b0:220:42a0:7f65 with SMTP id
 adf61e73a8af0-23d5b6660f7mr1811825637.17.1753347622098; 
 Thu, 24 Jul 2025 02:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcRwOchc2Jz18qNvTtjVxgduqSjTDwQFytzmiOqmCgWI91fHcadcD9iHCOmDjsD1nmeqgIww==
X-Received: by 2002:a05:6a20:748e:b0:220:42a0:7f65 with SMTP id
 adf61e73a8af0-23d5b6660f7mr1811762637.17.1753347621580; 
 Thu, 24 Jul 2025 02:00:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b061a514sm1161395b3a.114.2025.07.24.02.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:00:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] efi_loader: improve device path matching for partition
 lookup
Date: Thu, 24 Jul 2025 14:30:08 +0530
Message-Id: <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6881f627 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=aSWqRgVU3teZXBa7ZnkA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NSBTYWx0ZWRfXwAa0bChX1bba
 Awf3HP1JoVYWTU9IiJYKeryOYuxGQoJV3In9mPqoegy/SoN3/XMEnthP048Yy8k4vzCdGbk6FmM
 OwrrfXzW1g7WgkSGPPFQ5d0WlA9DK67+vzuBNIjXhy4KDw0EQvMGPHwjIt+o+MA/WuYKY7PG0Md
 MLBdgn9v2SgEakfImhzzjuYVZBPJAb4W/xusiugpic6nvTc5Vy3RrUztvOxO88uDu0PRt0PWwM+
 Z9c4+Lsn8Wt9vNhNkumm+F/MF+PdjLUj9RCaoi4dx/i7anQ50GRp5wJFRLE+jFPsJqs4Z7p1mrL
 w8rkidV67ORdSSawduZa1DOMEtihCo1rAOQpAZ5V65y5miGrsT0tUf3oBZyKrcBM11abgzMXsIg
 q/stM4DAy2xN4jb26MHuJkS2QHJ4MMcK7/XYQxol6qeSYmCHsbESb4ZXT7uIcEgTJewiECm/
X-Proofpoint-GUID: CsmkFgKO_dDlqUpTDrcKJRXuv4svTxA4
X-Proofpoint-ORIG-GUID: CsmkFgKO_dDlqUpTDrcKJRXuv4svTxA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240065
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

- Refactor find_handle() to improve device path comparison logic.
- Original logic only compared paths when len_current <= len.
- This fails when searching for ESP inside a larger boot device.
- ESP partition path is longer than boot device path by design.
- New logic allows matching when dp is a prefix of dp_current.
- Without this change, it was not able to find ESP and capsule
  update fails to start.

- Also update efi_fs_from_path() to use system partition GUID.
- Above ensures ESP's EFI handle is returned which contains
  file system protocol.
- Without this change, it was returning a wrong EFI handle
  that was not ESP handle.

- These changes improves reliability for capsule updates.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_device_path.c | 62 ++++++++++++++++++++++----------
 lib/efi_loader/efi_disk.c        |  2 +-
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index b3fb20b2501..3716165e963 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -107,54 +107,80 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
  * @rem:	pointer to receive remaining device path
  * Return:	matching handle
  */
+
 static efi_handle_t find_handle(struct efi_device_path *dp,
 				const efi_guid_t *guid, bool short_path,
 				struct efi_device_path **rem)
 {
 	efi_handle_t handle, best_handle = NULL;
-	efi_uintn_t len, best_len = 0;
+	efi_uintn_t len, len_current, best_len = 0;
+	efi_status_t ret;
+	struct efi_device_path *dp_current;
+	struct efi_handler *handler;
 
 	len = efi_dp_instance_size(dp);
 
 	list_for_each_entry(handle, &efi_obj_list, link) {
-		struct efi_handler *handler;
-		struct efi_device_path *dp_current;
-		efi_uintn_t len_current;
-		efi_status_t ret;
-
 		if (guid) {
 			ret = efi_search_protocol(handle, guid, &handler);
 			if (ret != EFI_SUCCESS)
 				continue;
 		}
-		ret = efi_search_protocol(handle, &efi_guid_device_path,
-					  &handler);
+
+		ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
+
 		dp_current = handler->protocol_interface;
 		if (short_path) {
 			dp_current = efi_dp_shorten(dp_current);
 			if (!dp_current)
 				continue;
 		}
+
 		len_current = efi_dp_instance_size(dp_current);
+
 		if (rem) {
-			if (len_current > len)
+			/* If current path is shorter than or equal to input path */
+			if (len_current <= len) {
+				if (memcmp(dp_current, dp, len_current))
+					continue;
+				if (!rem)
+					return handle;
+				if (len_current > best_len) {
+					best_len = len_current;
+					best_handle = handle;
+					*rem = (void *)((u8 *)dp + len_current);
+				}
+			}
+			/* If current path is greater than input path */
+			else if (len_current > len) {
+				if (memcmp(dp, dp_current, len))
+					continue;
+				if (len > best_len) {
+					best_len = len;
+					best_handle = handle;
+					*rem = (struct efi_device_path *)((u8 *)dp_current + len);
+				}
+			} else {
 				continue;
+			}
 		} else {
-			if (len_current != len)
+			if (len_current == len) {
+				if (memcmp(dp_current, dp, len_current))
+					continue;
+			}
+			/* If current path is greater than input path */
+			else if (len_current > len) {
+				if (memcmp(dp, dp_current, len))
+					continue;
+			} else {
 				continue;
-		}
-		if (memcmp(dp_current, dp, len_current))
-			continue;
-		if (!rem)
+			}
 			return handle;
-		if (len_current > best_len) {
-			best_len = len_current;
-			best_handle = handle;
-			*rem = (void*)((u8 *)dp + len_current);
 		}
 	}
+
 	return best_handle;
 }
 
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 130c4db9606..49f8b5935f4 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
 	efi_free_pool(file_path);
 
 	/* Get the EFI object for the partition */
-	efiobj = efi_dp_find_obj(device_path, NULL, NULL);
+	efiobj = efi_dp_find_obj(device_path, &efi_system_partition_guid, NULL);
 	efi_free_pool(device_path);
 	if (!efiobj)
 		return NULL;
-- 
2.34.1

