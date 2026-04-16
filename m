Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE48BF8A173
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F56684286;
	Thu, 16 Apr 2026 15:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsbOpug6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLYHJmo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA9E83C2B; Thu, 16 Apr 2026 07:41:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD5583EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0ckom2834976
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Lv1P0/yL5AB
 15QHy9SMaLAFfhONrUt+3yf2vSVWO3lo=; b=KsbOpug6M5kT3G0GaYuMIwgtbQH
 S8RGZFZrd7sZesGBVCRXFJ6uD4KGeK9pb4H29zortJEQMzTu4zMU+OIBmr0dLwxY
 5XbMpjPAOd0t3qSxNbd+9Pv3U0fQXLQxgZkoNRSDfnk6NsJsznW+8m1YYASgM44l
 d5JbbxqQ1NTphztZ2URoJqacOz2Xxxn3z6j3bYsSrqmKOWL2cXYfO59LQGv77Yz5
 TMtgnEWliSwlnrEXl7vEApbFSl+UDTC7sv/ErtldRAzWEFMCQlF/fi+KoRgO7H8b
 2D2RwtYBjfJC5OGp3C23weyCfGTg21LoQz+c4FDz8yfdQMrdm1oiIOcau1g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvjepv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82d40278103so5136738b3a.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318065; x=1776922865; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lv1P0/yL5AB15QHy9SMaLAFfhONrUt+3yf2vSVWO3lo=;
 b=XLYHJmo8Qa97sH+XG19t4TyUIeSESgkCmTt7tnmVl6GfYWy1k281pR1nobVkr8zMMK
 7rWEI6WrOJRcVZupD7nmdSOdHJVvzkb7JbpxwWxhPbZ0wcGGgJlHpNY+pRxdHT6PMC1l
 iLqS3YYAv8DYozRVEc33dnj/IXtdkn68nGoAgHQ31yjV9fPrWnUVENaEHXHAtKo/X0dp
 H8O15LzKU5Lcxff4YkWMOoCL3HGbEhxOYWvfhVBrVl0Tg7UW3NPv5Aa44l6jcGrpi3G3
 Qqi53HZxvwhKYlW8WcDP0u0lhmauDt467Q+kpLfHlsqWccG/ZmVp5lZt1IIcRTXAi2KA
 4osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318065; x=1776922865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lv1P0/yL5AB15QHy9SMaLAFfhONrUt+3yf2vSVWO3lo=;
 b=VZFWripxtGiMO1q61wwZiXNt5hH7+zUzqJEO81RbwOV4hcAm+G8NJUKjzgXMt2B5DL
 bc0TFTbf+/+yUYA8wtGdnHHXyKFoHS+HCpJsADdgWzlmFzoR1yfpivubmjl9sff0/Lbz
 YycKx/mivv/xvqJO3zChKectGY84AJUajHoZdvLCPBiGTqjus0pWgb9+DvgqQo7+3mqG
 FH+Ze5/BYd04xsAViPiXgPksV6uj9cHnWcc/7k9Yfc8lh4vYNTrlMeyvBiRPd48Hw3qo
 +DUCCqPOE2Vix/0fLfFiV+0FOP8idlVJL0/E3Lgx9reSbB+lq2LnGpufhCnohaY99z1e
 FM3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VwgaNhExteVy3iLhR42CwTK8U0LjRq7CvSuBK7nP5TWaxkGC0BaRsH2jplKUkzLupTooLv3c=@lists.denx.de
X-Gm-Message-State: AOJu0YzKZCGLINhO9mjyCnmZq3dtblGo3GvvlXngnp2AqvmyZyx5fuTw
 DElqj9ZywiTM53y2kVN+I1FPGRp/bjNlV6FxlcyLHFQF+YcmU+d+xAwRfdJ1G84Bj3/rTvLl9DB
 wTS+OIiGrV3uzFaF2SVIBSyq5Jsv10l31ciSUJxFlgmODqxeR8u8+XAEv
X-Gm-Gg: AeBDievUvsN3IMj9aYOimGlB2npfJyiJHPnWJWZp91SaOpuU9GZPFLXqlquW9Nk5cjI
 P0g3vr4pDgPOJgxyt0ckdNZ1Rh4gu8W+8kg+99G4+0tbhiiaLdH8X5371LhDfhMST1Tm6WC8r01
 3sh08Q5abK9o6t5RoJwry8neR2PSQmnfS06q3CPUvpm+NaIlK2uY/n+HpEWVMk4zqwCAEeAvVGJ
 1zndzQ1YUKtyrvV/+XaXJ70yfRnJfrMxTSIqJtALqxaNYEAlV6DaGW3zaZPIx4BMTNgkmHbrO42
 DvqTOX7Qv6QlGoCfbI4GarxTyB0z3EPopGx6PgkjGGhIOosnqSNFRb3r5Plj7a1lXicc6ZgL3u0
 OtWKDCV9XquwnlUvyqVHUM+O5OKXgGJe/TTxEncF+mf+pbe1ugzkaMcEWwu/8jpfLBaVuQv/ScP
 6bLC9KCdJW1oth6q0X8hT+tG5k3af/Mmn0qDKbbxYwL2Rhi5hOiGo=
X-Received: by 2002:a05:6a00:3e13:b0:82f:24e:6a50 with SMTP id
 d2e1a72fcca58-82f0c26b7a9mr25861123b3a.10.1776318064691; 
 Wed, 15 Apr 2026 22:41:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e13:b0:82f:24e:6a50 with SMTP id
 d2e1a72fcca58-82f0c26b7a9mr25861047b3a.10.1776318064049; 
 Wed, 15 Apr 2026 22:41:04 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:41:03 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 07/10] mach-snapdragon: spl: Update SMEM with boot details
Date: Thu, 16 Apr 2026 11:09:25 +0530
Message-Id: <20260416053928.2834699-8-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E2dk5_JB-7QOlQYU-0HmQlZc0IMpjpS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX+KES2qBdEHye
 SKDtO79ASotg+AeO+xaFj3J/ZfVa7chsGqrU3lF0PTcQMXpGePrNKd9Bh6XtH3tC0IEZQ0Cmal2
 VZqrThXzV3xekCkXrYpNA6rKyUvqA2DAzC+6bdDtyCJJjebIX0A+vQuinI014ZaRgb8pUp2m4x3
 F5D3Mvvu6WKFOtMZhTyi3SFmhWQCVsTU7AvT0FSoUoOqngDg7xnM7GTSc1k6GFdYnxXEYZGJ6St
 78CZiKmf9B90dCFiGl38+hRWTbV3jQjRw0i73UX+kKyGCRjTMHc80h/btRQUX37Uo78O+YMN+7X
 n71a0ulbs00AR4Lm3q05jcmdx0dKVRFTj4cqkAMmT/5j66kRRH+ISNY6XY8Ywq6jLKRRSlgmukA
 MeMT2+q5aDEWdbGONOGwTSKNnX/vmr0BlV5XfHY/8O50Z6zdsKu3yLAzmY/+HlmU1Tjir7Os3Ug
 oFJLBtJJ7Ctpp8YHcgg==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e07671 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0SPA9odgS42ATgxe00IA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: E2dk5_JB-7QOlQYU-0HmQlZc0IMpjpS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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

Update SMEM with the storage medium from which the system booted.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Move SMEM init from previous patch to this new patch
---
 arch/arm/mach-snapdragon/spl.c | 65 ++++++++++++++++++++++++++++++++++
 include/smem.h                 |  3 ++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
index 8cc28bbee82..82b390ba3d7 100644
--- a/arch/arm/mach-snapdragon/spl.c
+++ b/arch/arm/mach-snapdragon/spl.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
+#include <smem.h>
 #include <atf_common.h>
 #include <linux/err.h>
 #include <dm/device-internal.h>
@@ -169,6 +170,46 @@ static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type, try-mode status, and ATF enable status.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = uclass_get_device(UCLASS_SMEM, 0, &smem);
+	if (ret) {
+		pr_err("Failed to find SMEM node (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+	ret = smem_alloc(smem, -1, SMEM_BOOT_FLASH_TYPE, size);
+	if (ret) {
+		pr_err("Failed to alloc item: SMEM_BOOT_FLASH_TYPE (%d)\n", ret);
+		return ret;
+	}
+
+	fltype = (u32 *)smem_get(smem, -1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC))
+		*fltype = SMEM_BOOT_MMC_FLASH;
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
 /**
  * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
  * @if_tbl:	Pointer to the QCLIB interface table.
@@ -330,6 +371,30 @@ int qclib_post_process_from_spl(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * spl_board_prepare_for_boot() - Prepare board for boot
+ *
+ * This function is called by SPL before jumping to the next stage.
+ * It populates SMEM during coldboot.
+ */
+void spl_board_prepare_for_boot(void)
+{
+	int ret;
+
+	/*
+	 * Populate SMEM in coldboot (Dload bit not set)
+	 */
+	if (!QCOM_SPL_IS_DLOAD_BIT_SET) {
+		printf("Populating SMEM\n");
+		ret = qcom_spl_populate_smem(NULL);
+		if (ret) {
+			pr_err("Failed to populate SMEM (%d)\n", ret);
+			qcom_spl_error_handler(NULL);
+		}
+	}
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
 
 /**
  * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
diff --git a/include/smem.h b/include/smem.h
index b19c534ebc4..f16ba7d63dc 100644
--- a/include/smem.h
+++ b/include/smem.h
@@ -87,4 +87,7 @@ void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t
  */
 int smem_get_free_space(struct udevice *dev, unsigned int host);
 
+#define SMEM_BOOT_FLASH_TYPE			498
+#define SMEM_BOOT_MMC_FLASH			5
+
 #endif /* _smem_h_ */
-- 
2.34.1

