Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295D8D2D0E0
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D104483015;
	Tue, 13 Jan 2026 12:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYJvVXDv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cItAiLNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54877835B3; Tue, 13 Jan 2026 12:54:36 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE4382B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D5as8V3636970
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CJ3CtkzkJ/J
 KhJ+mMMvIS8j0h849t/5tiI30yf+PAqU=; b=PYJvVXDvzCEJ+IDgv+KbZAK+WwS
 qL9FBHKTJqDqa6IVtI3h+SHiJR54Cpd3fETH5JkpxRHX0GtFzuctnjwo7+x6qu7i
 FbBVYJXtzLrcUiOxmMKSvSKc5mzqmT3ET9ofXX6wbmDKok/uPbIzDuSubA4aXaIs
 Z0tjK7nKZ6BgDZ4VM+GjAUocaeUDr4vOwfbA3oHBgTW3EOlyDP5nn5liRprScAOI
 iNaNKd2sfnG33WvzlfOfCBr91ZTJnotCsFr8I3x43sXErr3wflbapRR6tC0pv/8o
 mtnU6o0P5qpfVbpHuTsKg8Bf7zXAPJnj6sL5xh2DXGbBJmTSOqun/609DrA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng2c163s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c52ff723c86so3082169a12.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768305272; x=1768910072; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJ3CtkzkJ/JKhJ+mMMvIS8j0h849t/5tiI30yf+PAqU=;
 b=cItAiLNM7QkHIgbc/ucTe3/ayVZm05a/4OCOMqK59j2AGkiEaR9B1aDyA+nZbJKA/L
 PoEYVqJMhw0HTzUv9r0kseW8t/aAIoYZ2UG4cPasM4uOKtjXQhcH5mz89t3mOcWdizoY
 vgLSu9/TfJOzMHaF3CcDdh72NOnVssD0c5au6GNoTvwucVR6FMMbHh4hKfjRlUX8IZc+
 sVQghSqBmoDaIWiutvHc7cBNaGUVXqSYrlT+v85oJL4qWUDjBAYlqHZ2qkm9J3iv+hlI
 qE07iLVpb7o/l1FNnZcItdmSrj7aJTqc856efw5sGKIFGqqJTDmAX0H3KxANFYhVE555
 vPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305272; x=1768910072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CJ3CtkzkJ/JKhJ+mMMvIS8j0h849t/5tiI30yf+PAqU=;
 b=RD/JfN6zNw+28NWA/nqSvsyuCcdlXhgLs3aWTIi8TjvmtisJvHj/mXxaE5WuhzLnbz
 kUZUyhKMkcuzcFsRXojaxAbyWkYDkkaegBPF2rAMRPQWCTMMNltMT5zJLnlwjZzoy5B7
 3KoWod+mBWCbn9jyYq5bmdrt8/sxDIOEnUYrIClcJ08XWNFgWRYSJJLScSwiBOw0GdTw
 NveBERzHlK03UEdwOtGub2EC1g1anzkqcSZa75/dQ1fxt78CwR7cWXlJyCh5/Q/JIxen
 X3d2iOPidEQ+ano9+7GBIP83q0EhEApsgvTbHL3YBi8iyKTjvSJSVelHUUV1wsOykDRO
 PEaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVezG415/8wyyEdk4ly7oC7KZSuB4/kjfqsaTWUpN1jmdkW3tQhDyvweyk5+YO02OQ9o87X7ik=@lists.denx.de
X-Gm-Message-State: AOJu0YzCvuF5yJEkv8MtGW1Ei/ArJRGO9lCoedlyNuvjJvXt8k+lQIeR
 I8gyGsiRhSEYVRJsOrBQAcdePwqDNOW4h7OdNwrYVOFtSfIdE0XwfFZMTnm7nlZ3E5nVJ+jPCOB
 G0WDzEUh3g3PkpeXkV7NSOc6Sm4bl/U4j5PwbvWvIFlVk4jOGaKAtLK1R
X-Gm-Gg: AY/fxX7p5joQKBeLcQrNJhEGptI2SLxUwLetwzA8E8WnjCoOlkKzT++r6Yzcn23kjiY
 UsWtILKlqQQDA8cyeRVjwcp4N2XB9pa/mYNH1qqR10/OXhKO0vANDgup9J9Cq847HS3DVrDjoyj
 kA5fgZdxNfYFx6/yOxaiRYagl4ijoOdTCJd9849MixpNs+p393sDci7T7JfLjyTlQId09Ur804t
 gh+mHXS0eamut5nt53/fdnSTm9If5qrGNP5tbcPD4kPNBgCQp4ZPJaqfmjZtXXAoW2IkI63zkWQ
 HjoXV/pVq+QPYOcpV19Kk81mQuw2geKYZUcWjsWzjcuEatcIqfYJlEDkpeveob1fCyKrQriHHbu
 uaItFwmNBubYVNFAuI6QHEUzjPvwAvsFMNOUgk6G1b8qWRdeaMS96cRHJzjSVSnezfF7cwVCKLK
 SIU2r50bbGIaBY1uE/s0xQYvdKQAUv
X-Received: by 2002:a05:6a20:b7a7:b0:38b:dfc2:9388 with SMTP id
 adf61e73a8af0-38bdfc2964dmr1808714637.58.1768305271580; 
 Tue, 13 Jan 2026 03:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnJP+iyVgxIXFwGe14CWRqOw2Yoex7RFi4OqINGD8RX8eThl61FaZlRmcGwmQMO0fWzGDl1A==
X-Received: by 2002:a05:6a20:b7a7:b0:38b:dfc2:9388 with SMTP id
 adf61e73a8af0-38bdfc2964dmr1808684637.58.1768305271042; 
 Tue, 13 Jan 2026 03:54:31 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm19734073a12.10.2026.01.13.03.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:54:30 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/3] mach-snapdragon: Add cached SMEM socinfo accessor api
Date: Tue, 13 Jan 2026 17:24:02 +0530
Message-Id: <20260113115404.1448759-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
References: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwMCBTYWx0ZWRfX/xd5Zh5JoJk1
 hsLVbyZmx5ybLyFuUpMSYFq0BYhiwqfaRJHnVpkrKMn0l04fknRQl8QPLHKd+1kbyAbooDvFFAe
 WZVpEjZX5LFJcNrieIXNK9fjYRinL8llHQUieQyJ1g68x/D6RZSGAfnCJzbfWiZ56T53TXxj+nJ
 EGad/LA1gbsIRs/5Ub9OXUUlSpSLH/pLAhUeQ6jJBJSRqz/SaK2fz2Rck8KGnEgpk10KWXHhTGe
 RH59x2qBNrq0Q+3/oihnMFIwNflcKP+nBSSIv+3yqYawetNLsPkmU+ghnR7wJCx/cltuHFRhNRw
 JNf87znI/FdVA5xdqurZMSQEa8Vjsr+qgfGlRLETFyvi1nzK65T4jtPa8LlXMPFuRdzfSez3XWJ
 AZnL3ye3QyHAGtZP0QmUkqVCLWYzm+AeGS/4TngyX/P53Eq+EG7ZRPUyFeSRHtBPUvbdP+Mm3hz
 wR66gKP/RVIAHWwwbtg==
X-Authority-Analysis: v=2.4 cv=C5TkCAP+ c=1 sm=1 tr=0 ts=69663278 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wCt2VNi_px-LVYxwGHIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mn1grV6-nTLlucZSxyzqQYlQZKFcH6Kd
X-Proofpoint-ORIG-GUID: mn1grV6-nTLlucZSxyzqQYlQZKFcH6Kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130100
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

Add qcom_get_socinfo() function to provide cached access to the
socinfo structure from SMEM. This eliminates redundant SMEM device
initialization and socinfo retrieval across multiple callers.

The implementation uses a static cache that initializes on first
access and returns the cached pointer on subsequent calls. This
improves performance and reduces code duplication in components
that need to access SoC information.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c     | 43 ++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  5 ++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..ccdb22d5429 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -32,11 +32,19 @@
 #include <usb.h>
 #include <sort.h>
 #include <time.h>
+#include <smem.h>
 
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* SMEM cache structure */
+static struct {
+	struct udevice *smem_dev;
+	struct socinfo *soc_info;
+	bool initialized;
+} smem_cache;
+
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
@@ -749,3 +757,38 @@ void enable_caches(void)
 	}
 	dcache_enable();
 }
+
+/**
+ * qcom_get_socinfo() - Get cached socinfo from SMEM
+ *
+ * This function provides cached access to the socinfo structure from SMEM.
+ * On first call, it initializes the SMEM device and retrieves the socinfo.
+ * Subsequent calls return the cached pointer.
+ *
+ * Return: Pointer to socinfo structure on success, NULL on failure
+ */
+struct socinfo *qcom_get_socinfo(void)
+{
+	size_t size;
+
+	/* Return cached value if already initialized */
+	if (smem_cache.initialized)
+		return smem_cache.soc_info;
+
+	/* Get SMEM device */
+	if (uclass_get_device(UCLASS_SMEM, 0, &smem_cache.smem_dev)) {
+		log_err("Failed to get SMEM device\n");
+		return NULL;
+	}
+
+	/* Get socinfo from SMEM */
+	smem_cache.soc_info = smem_get(smem_cache.smem_dev, 0,
+				       SMEM_HW_SW_BUILD_ID, &size);
+	if (!smem_cache.soc_info) {
+		log_err("Failed to get socinfo from SMEM\n");
+		return NULL;
+	}
+
+	smem_cache.initialized = true;
+	return smem_cache.soc_info;
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..d5ec210faf5 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -3,6 +3,8 @@
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+#include <soc/qcom/socinfo.h>
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -17,6 +19,9 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+/* SMEM socinfo cache accessor */
+struct socinfo *qcom_get_socinfo(void);
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
-- 
2.34.1

