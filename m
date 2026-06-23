Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D1CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C19384A3E;
	Tue, 23 Jun 2026 08:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivWMEM08";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NKHRlf/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805C7849BD; Tue, 23 Jun 2026 08:50:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFB5800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6ctMG2987163
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ntYOoagLVSr
 egOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=; b=ivWMEM08FEfyc87V4IxAwlXDg20
 +To8vsu7laDdXsHYtd6qJ0kLAPWVS59dayv9ydrLTM7Crjnqw1bGeAxbM3XKHIVA
 XwikcT11nTBvoZgklDs1BPntvMc3cXCh8fKiA5zHYnrfElVqAhoCvAYAcANArfML
 6JhGa0wI4p0JKyTIpTJQ1rVa8COQ7G0yYzPfZIb/x7d2SIhUZNzcKqVKXF0rwY4Y
 yPn6JlPGo9bpUxqLCA7ej+6ziFA2jotGYgXDYg3/MGj0lTwZMNzrglznQiNlqxAY
 vJaFjU+ROLVraIBIYat0cu06JgnevWgcqeEKCwQix2ouWMMEyyVCjnNUx4A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0uws4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:49:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37ca2bf8e39so5793960a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197396; x=1782802196; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ntYOoagLVSregOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=;
 b=NKHRlf/mV78T/213rFmAEv+GiC68CHD2Lsx7adcOi4p8qI2aq4Sxf7kFd1HqWjBWVP
 fZsLGo0gvcl6kSOVjSYA2fHMgc8aVc8V0PCrvyrS6wf/qrGTYY3U1f0oLM90ZsDu0nSY
 ESR4kG4jHIBTj3B8b3YuKylgBArfWx6vplSnjLmi37L6o8BNwktX71ryj7RCNirSFbQ8
 raYfxJiA+X+iX8J/5uLyoKsgFSqcTSdevogotJUGIGf1u4QlE/lIDerfwITw0phP5Xoj
 kJMMxRgEjhc7+bAZNjcm9JrzFC2vNg6ark7aY8AaBy850lIuO5EqFmUrpinlPKyfx+tJ
 +/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197396; x=1782802196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ntYOoagLVSregOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=;
 b=Z/sXfFMA/n4jognvlrVQqVMlWz8V3n31EYP70EXphXF+WWypDvQHUAkLQXgeWEdZ3e
 CgE3wZ9WdYIQTwCnBq7zjy/939T+LORawvayRDKnePy5HxAs2c1HLQ9AIE+1/B1pMZHq
 7e5t1TkndeVxNX2xhNF4yFohoKcfI9mqLTIdhJnhrP3tE8ChC0ChNvbcSkpmmP9Tji3/
 uNqXB+FQIIYOUAghnArqhZ351hgfS282XvQuCLVbHsobaLnbT+zgq+ToZyb6667omlyO
 NY3AIqnJL0959Tj/p2qcx7sTstVtKn/Wfr0NqHcZrYZOuRQe7RuybCiSOs7Fqu3L3S8T
 2wlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGQw361BuCopo9+g199bO9gz7a83nsxS7tiQd8M+FStsxeKNJxIGtf6Oq5aDhxjZrR3HEURMw=@lists.denx.de
X-Gm-Message-State: AOJu0YyJcp07NmoLzQ42MK29g981e/ZWs+3U1R3Qo3nzzSuZz3K4IJ14
 MD54JHYrbO+3fuB5EnPbrgpbLsamIEFdCQS0rBpjVbldT31PjcKz/vSA9YRr9kzX3Pno/AOEU/L
 28KhE1nFGeUUI9EbJgawo+4y48JdZNwkHAq8jTeoJJkEQvdvI0gTXTc3Z
X-Gm-Gg: AfdE7cnPL+rD+uW0eKjwMPCj4pfsOfpGJo/oUXhhoYfGFwMM2IF4wmMcrF6NrzhRCBw
 0pBgvIxYeISXDmCbn4RPgc9bd5iNzGYHlXlE0qFDbdIcjKiNEj0S/i5tOzlcSAVc6kmyEKySD44
 +BG7J0TVH2yizy+EUi1x82Rsb+rh8OJ3HZxBUuSss7ZTjn8pDA807NlMuTAN0YHnoopEH/p+H80
 Ji5OupnIjkbSOPJHDRHar0CuHwnl4jsiBqjjahBI6SBP8ymn+cHGs8mouf5yZRRsV+XIR1caDZF
 XlHyx+VU+tJ24bp1IyCGvadSHICYPBYV1YaSxD2JcUYIzYDAftQFA61IIQ1oFlveXUsQTdN0PPe
 mhfEnxyiOngXEztm9/OGeASfkXYN9njcya9QwlCx+lDGc3JKR13tSIOO5zIqDxTo35qlYFxQV/S
 eytGvbEWtknL6zi0WF8iulGMK8dQKlhNqvyau7JiqH
X-Received: by 2002:a17:90b:35cf:b0:36b:75:6387 with SMTP id
 98e67ed59e1d1-37dd16ec131mr1435414a91.8.1782197396177; 
 Mon, 22 Jun 2026 23:49:56 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:36b:75:6387 with SMTP id
 98e67ed59e1d1-37dd16ec131mr1435370a91.8.1782197395520; 
 Mon, 22 Jun 2026 23:49:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:49:54 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 08/11] mach-snapdragon: spl: Update SMEM with boot details
Date: Tue, 23 Jun 2026 12:18:01 +0530
Message-Id: <20260623064804.3988799-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX12nC0IsJOmTM
 IoubZCNIRoGcaqV7ZorLmYmLPEg21ZSd9RU3MR6kK09fW7oebx3S7qtkA5iD4Qq1DRFxjjfenAs
 e8x+c5MixTbwAaJPkCjqQdqKG5hpI8w=
X-Proofpoint-GUID: p998zTF0Gpfyrcly5foaE3D6VKqcRSg_
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a3a2c94 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=cu-XF-9Gu4gfq0MNXlkA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX1NpHAfYmM8XZ
 PoYWIhy/y/x/WXdRBlQbc52zX7LTVAhRahAMbChKp0L64qs8TvhluzmmdzsZVBRE4xqFEOeJSqD
 yFrPVmm/mPiOqrlPvIJDfPN4yQhg8RuLE4TdGpaL4K95EXsamWcpEtN2igygHG3r94j3+XR2M02
 C04koUNWvvhv++JycKIhLJTel/ela2+y5Rp1cBSB0VJylwSThqIQuq/UsBc2Kd+Ua9ewXSnuVWZ
 k1vWVJWI9ODACTXgYJPmgxyXij6WHM6WM9zjfMrweJd9LuBKTVjW6rnBbO4GliPZnL/cNAiu/c8
 49cJprwHN2jTgSttdvrVqRF8A2wiMlQkWjPx7R17OjWNOrVzSlYrtz0XyftGfXErGFkGdEiI1JM
 kvtog8doNdn4C+i3H4fZRdZagzH/2gUHrTjalEiuzLh0Ah9+FX5rPGZeoN4se6GKP8MlOG20e4C
 ajBN600pbL1Oqh3SNOA==
X-Proofpoint-ORIG-GUID: p998zTF0Gpfyrcly5foaE3D6VKqcRSg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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
v4: Handle Boot medium not specified case properly
    Minor cosmetic changes

v3: Move SMEM init from previous patch to this new patch
---
 arch/arm/mach-snapdragon/spl.c | 73 +++++++++++++++++++++++++++++++++-
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

