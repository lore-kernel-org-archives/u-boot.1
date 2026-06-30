Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C89C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2D384B43;
	Tue, 30 Jun 2026 14:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRKqzmxn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERVeR8hw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD68849FB; Tue, 30 Jun 2026 10:10:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA5484857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CgRL1074128
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8VML1wqnU8JOSHw+FXhTavsh50qcPoC3xEpB1aeeWmU=; b=bRKqzmxnXxCnkpNE
 AGegefoPO7Uh99P7GTeq44P88/ce87R8p/+IbUYxVSsksfJhBe82FsXUxAcCoCTY
 b/ciX53Y45ntTq/LPiDf6VDEOWf++VRXe0LcmxlihRkB13GPLyxa87QhDR9BSKFj
 LlPLGPaQOALUMi/e/k4J7+qiUjiSEmnP7WNvSUsGIy8pbzFMNkzfsKjt437D2/5h
 /fkv2DCIY37L+R3ajgBKSBZJLWuav5w84QDxWdoseOFeqFVXtzuf93Ifwm5w1ndh
 UytR35Gua0X5U1jAMAXhnW5prghqS8LuM75d9sWKgaivztYpBdjZgWhfmQV6JEHR
 cug4/A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k2bah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c9bd8b9c7so5200619eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782807029; x=1783411829; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8VML1wqnU8JOSHw+FXhTavsh50qcPoC3xEpB1aeeWmU=;
 b=ERVeR8hwq1f1WKI7guX9bTpSPsKi5y2JIpmRtuaO71EtzWgKx7PFu1Dtc/+aMocrVc
 aBz8B1nJPlh+hiV7HEiCoULURCzgZh8kts5uej9Rje3bNZHyU+nyBr9oqjDi2u8w+t8A
 fd+0If2qPVlW+pMcjjWkELAFHVvx3+++l2V4ayWgKXDfyKZubzvCYznQBjTvvevM1e1S
 kl8Vr24iucYBWOp9TYdd2DK9JQBZiq5SCOEwhLa+ZTapuIbttANIXJrqfFZDi0KrhIW2
 wx12G9AtAocnZ5ujj0dhN41nYHtKR+KfBDYMpwmbHCRXIDvG3K9CzgpLk/Twd7iesJ4g
 wOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807029; x=1783411829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8VML1wqnU8JOSHw+FXhTavsh50qcPoC3xEpB1aeeWmU=;
 b=PnvL6G8/1Fi67qmLkvSyNrn/Rm3hAdaHPOtQr+1O+VYVNvefwl0HhsK9P8S0rHLsRc
 89atUIlMQs0vTJnDmW5ePbHNjVIzUgb+4QDatqHR07G1ehaWT/YYvk7PTVIfTKCR5JEy
 uz8GWvGyATbfuJZiA73EFlpft9gey1hVVrDyw3KkPEsZsmUbxnAT6ghZDRK8Il1xLXnc
 lk7j6cSBsfNWgmndJqM9ExMccxs4PSzWRdlE30uwOKznxTNYRBGGV4I6TH8Du3xGscJh
 c1w3J8uTb+wEUtwzRii16eARPrN16DJ+V8tFB2+MKCjoo20oKCEUEzIVYrpp1ALOcg3i
 1rRw==
X-Gm-Message-State: AOJu0YzrH9706sMRbkWyldwphmUC9nk/aM9qitx/JmLEi6XE40Xw2Zqs
 wjtK6CWhOKWC13wuOP3inDN2UmOvbZ+7Px5P1/Z8sew0Bqd3KgMvjjim0bE93dgyZCfOXQsN7Kq
 h2Spq/Ch1IwLat7RNVWoOWTttI4rJBKB3r7cfcQEfVRFtHG1YuQWKM08L
X-Gm-Gg: AfdE7cmyxY6Te2KDqLp4A7tYMvZjxFYEXkHbgypR8w7jHtnwB6N361JEJMGlJROUpG/
 TUJgkLu6ybzZ/+vaiqeJeVa+4d07If0WXSE8vigcxI0/vvkBRYfPpbA88ucgh7D7pP/soF5Zu4V
 i8PDai6bf6cahoMiWvDf7HyUumKDYMp2RWT9AnOCwsAe3bG+ek2pqK53CUV0e2qCget9f+A8ZY1
 vzRxb0lFt+W9iFW0igIaIl8suKGVCHgQMKhcRuI3htx/5hSILgysXB6f3Vkaf/QAAkCql9LMXA3
 cY5oYwh0xG8lR8TEMnn6cgnHx/PB0XyNQbcVHx/ydEUDQyMpnzSb8LOT4wjMKUpexD7XZRNQmI5
 SXziEDfv+ZbxVulzL4Urre6sKO70cm1EBl9jzIr3AtN1mrIR9K2CNDgTyqMn0ESv2AFHhMvDrdx
 Q8Cgygqi8ojhHikxXweJPQdnMdlPh/OY9EuSdsWr5b
X-Received: by 2002:a05:7301:9c88:b0:30c:a7da:7add with SMTP id
 5a478bee46e88-30ee12fb78amr1618216eec.15.1782807029089; 
 Tue, 30 Jun 2026 01:10:29 -0700 (PDT)
X-Received: by 2002:a05:7301:9c88:b0:30c:a7da:7add with SMTP id
 5a478bee46e88-30ee12fb78amr1618185eec.15.1782807028520; 
 Tue, 30 Jun 2026 01:10:28 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:10:28 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:30 +0530
Subject: [PATCH v7 08/11] mach-snapdragon: spl: Update SMEM with boot details
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-8-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX03yL2DzvqGzl
 cJmiswtm+yQCPA6YcONPqdt3I6v1lLP0+8bNA+vTkLHJSa91CnjLhNmCS7PxkL/50oQtf2z8h8V
 HJOioumZrEE7r9QBjqte+WvAq+ap2sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX1FWPfGWwmaWh
 zwy0MsgHumWOwm3/JTdI1zzpQrnphQaYvgOFiLilY5z1D2mzhQDzf3LxJM7wIlRCXLWX0Qw7wAA
 6xaMzoRMtMBylJj8caPNzyblei/Vspwh8I7awk13h1xoDuW6avS8CUL3Ap3nBUoDM9Xg9+7y9JB
 50jfrbC0eWs1ytu8N+9Jye1unzgraGDBDHCTdJ6vkAzInfxKEQOXiGOV9xTwnYEMDZwiEEgi0/W
 m5RdEFFBZQOFJGrIwKpeItpiSbisqtCqKUabhBM0q0LP4SbLx7udlbHgYH7Aff6H6HbuYo54aoe
 dMLDfUHt4h+FcQD/WUU/tGDtBGG3TxhG4rawjp8mK0OSYaQbcROBZwe0sqOjVdAEL5taeA+vUsu
 4YHdDWwQg4Go5y25AJce0W3r2uA3gxPAStXAj7Rmofs56/4C+Rgzk4JodbKEeXRadGIJ0C+I8Jd
 dGV4qj8/OFUK1AIkDvQ==
X-Proofpoint-ORIG-GUID: 0orTHg3XfjoqBR_3CsZ3WUm4JKGsD6tM
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a4379f6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cu-XF-9Gu4gfq0MNXlkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 0orTHg3XfjoqBR_3CsZ3WUm4JKGsD6tM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/spl.c | 73 +++++++++++++++++++++++++++++++++++++++++-
 include/smem.h                 |  3 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
index 9b8a640256a..aef9bf206c2 100644
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
@@ -167,6 +168,52 @@ static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
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
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		*fltype = SMEM_BOOT_MMC_FLASH;
+		return 0;
+	}
+
+	pr_err("Boot medium not specified\n");
+
+	return -ENOENT;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
 /**
  * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
  * @if_tbl:	Pointer to the QCLIB interface table.
@@ -328,6 +375,30 @@ int qclib_post_process_from_spl(void)
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
+		ret = qcom_spl_populate_smem(NULL);
+		if (ret) {
+			pr_err("Failed to populate SMEM (%d)\n", ret);
+			qcom_spl_error_handler(NULL);
+		}
+	}
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
 /**
  * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
  * @offset:	Offset (unused, typically 0 for SPL).
@@ -396,7 +467,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
 
 /**
  * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
- * @boot_device:Type of boot device.
+ * @boot_device: Type of boot device.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
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

