Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD08CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942068498F;
	Thu,  4 Jun 2026 14:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JEDCIG+l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q0AKurtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB0C8486D; Thu,  4 Jun 2026 11:33:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842EC84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543iWuU3233934
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qfx2pRv5sP9
 aJhNQA6xuIFWYLuhE5CU5zHw8h6BmVu0=; b=JEDCIG+ljUoqi08WCW3ehVAZOk/
 HiDICvd+hWps2EhrL5Jw480zmore2rUAJMnw3/x9zb+QDiBAXgguaKcJ7a1NWUuu
 yzGIhfrj3OCLsadMci4eHjUf8JUHXtvUkDVyyOdkQE7MlmbBWX4kvjyzOAc4mpQD
 TETkLNnd6cm+0R2pPodBUBlVNPcVSIKLtPznG0EF0iul/0LiO7fgWgRPdcoLTcD0
 rtzhtDUbRSm2BEnUjky47VIJ3hfqTFieO3LWqMutLS4l5B9H/470k7ZcrJq+3tgv
 uLiLGhWNKRQFcGA40wyAfSis8oxqTSqGCGITUOgK4ax8owudQqn7Qlgbinw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s3156-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:33:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85d9f0ace9so526345a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565621; x=1781170421; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qfx2pRv5sP9aJhNQA6xuIFWYLuhE5CU5zHw8h6BmVu0=;
 b=Q0AKurtqdOzYoLVS/mUo4pWjenV2FlPSZlZ131vnq/6aZCBxGPI17hq6pCtzlNncEC
 C8jlAdaD6idGrorS5v7LNwXAdMK66q7ztV3jgualuPRR0gpvgeqT/fotdLcert3w02M6
 LOXkfGwm2hWaUYTBYOxwte6cGMNQntNP0VVjLdsPnWIYnq+Wm5J9MzmNcOuS++HP0Bv+
 N9gf66fXM+CKqxTyq6VxGuPogdaEj8LOsaWWjespoQiDvuOqTAJwKlEmime+wAivaYgg
 s95BiynsWjeu+6v7npinBCvs5OwaZboGMWQkT62MGaKtNHYUTWYkISD1fUuvG3zSweS7
 /ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565621; x=1781170421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qfx2pRv5sP9aJhNQA6xuIFWYLuhE5CU5zHw8h6BmVu0=;
 b=ry0NWDEqXl6FoLBCPUvFmV00HX/Q9X1n0ammyluj8qgd+zzSGbIwoB3IhSr71D8yAS
 Ha+5z9C+FhNHWfWdmsNp0+/MUTFsz85MfCEK974ZdFz+KyPRE3ek0xNUg/UabSwuLryI
 qOz8WBJWEO1dfwvqY3W3E0qFq2RWpvvdpVJjQjcxHKnqx6JeSjn/5wiYwuSYRWhYO1WC
 +S1cdiWHfHW+HVhodEO7N6fWE2hUYTKGJb34wgKPeuiLb3mms8emWMDHZHPxMXvCqA9c
 14HuUeJtcLSZVXy1k6iov0rrFOC4qH7jeqlxxDXlQvu3mz7kBN1xWUiozj8jeZaFKNkZ
 ugfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wmKUFWNxpJm9ZASTd56WpWa6c+d73PJHyoLeoDmcafOwz4ja5kALVHsENY/vA4A4eRc8Lv9c=@lists.denx.de
X-Gm-Message-State: AOJu0YzXGxIX2Y002wksz1s9qOkevsuUKlkr1u9CJG94utkJ4qNAJyQx
 odmB3b+SSIJL+3/m0dDa1X9jfmoRWmB2aWkOf2ejxtO4kwCCOy/T3lsiKAL8NWHuuwO/1BofO53
 B/OtTW795f2+2Me2O5kXL47eFcNuMuY2PgP2X7+MYtL7MuT4W28whWFGD
X-Gm-Gg: Acq92OGERILbNS7Ic8mSpmKiuVpzPeJdtLV1rIoc5yt4qhfm/TUuifvyL8d5wmzU1HH
 X51GPvloKYYtynen+/axdGFzzn8n9/LVzRLlO5VMYZ6yuGPIESBHh6sw+IcnkDlsLxAkfA0XABf
 FNRQzSviIL4wZRV5cRZSrX8KSIn9Qq6lhrPRhm7YrQUgcuT7P46J2kuTYon1jdJDRbWyi8Wa5Xy
 zz+srsG105285/xH/HidOpW8qiEuEAckbkRNk17TECTdV+/x5/arRXFveq8qpoPTlL92mBP6QNs
 t94lt/hNIPjdZNUI12zbg4ou36OaMBiyYU5jcPYSQ1DHk92NlI85YB4i0Kq8u+vJJCrnLDwOIAm
 QU66vqWEa1vIHLd35dhY8oRYCstDLwF0Jo2CVM/zEjmNgNyNwZT5mLkAbniGEey5zRbOzJKy0lx
 Rpd511INq8PrwbtqyeGK5TqbgTM89R5LVbtLKjSrZZnQLIsa4ApJg19k9na+wZNg==
X-Received: by 2002:a05:6300:228c:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3b4978a0a35mr7907834637.26.1780565621058; 
 Thu, 04 Jun 2026 02:33:41 -0700 (PDT)
X-Received: by 2002:a05:6300:228c:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3b4978a0a35mr7907804637.26.1780565620600; 
 Thu, 04 Jun 2026 02:33:40 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:33:40 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 10/13] mach-snapdragon: spl: Update SMEM with boot details
Date: Thu,  4 Jun 2026 15:01:29 +0530
Message-Id: <20260604093132.757583-11-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _YnvcT3AoJZQBmznBypCM1IM5AnjMhhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX3kJtejAINRLn
 MsDRlJWt7UzJY1hDSarWvxC3iKIrRrchinzq08NsHko7ZbOhBlLNxwyOeQFCujD6PAPvJl+bAgl
 Qq+qcJsPThwuZ4ZrbVPH9sdYab71pBLnUh+nkC4EIJEUoN2CTX/1oCvuJC/QE/uIeMRoo6vgCAh
 hYzmKk06jLYQXIPxNghmvJUZIYJ0Qs/qkkkaryUL7HvL40mHJ+nPlaAJiKszV741og9aon7Q2fp
 bBEY1Q6bhCEgDQN0JhJlK2wCv84zDMVCluTMqSoCQ7qa3bebDcQJThFHQy2E7t7jtelEf9OPYkq
 rnVloIgSxFagq0fHs+go/nJJz5+INGNOYUGtWBeyblljN/3I5pTY1u8IO/MAJvgjqWVNwEFctFD
 oHB5ULHd5D+PZQQmgEw+gltdTOf8MVCxcy1JL/d2vgnJMqFkNHC5bS4mSqrxlZTc44JHpeGSJNP
 yhmGdvaTLzu8+na7oCQ==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a214676 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=cu-XF-9Gu4gfq0MNXlkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: _YnvcT3AoJZQBmznBypCM1IM5AnjMhhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
index 73e8ca5d459..c1a7d4cb00f 100644
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
@@ -166,6 +167,52 @@ static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
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
@@ -327,6 +374,30 @@ int qclib_post_process_from_spl(void)
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
@@ -395,7 +466,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
 
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

