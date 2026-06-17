Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB48CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C963F84A26;
	Wed, 17 Jun 2026 14:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O93vBURr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MP1ezxuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7366841F2; Wed, 17 Jun 2026 12:20:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99458838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8Usew2025364
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ntYOoagLVSr
 egOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=; b=O93vBURrGjSvDeEnD0dLpop0INB
 f3KGpJL5O0BjdhLMnm4d2jYIZ4Fgz6zg5RKPpFN9EUv3S8AKc8H0NKjbxtQ7NRVO
 ExjJ956RhCbsalwvF/GiT6ZJWmkK2FoYAPakxt5UOKxqTiJL/LjEyvQy9TARYrgd
 b9SOnj96SH4UysRk+4gAuorWBGNHgRrA5lVX5F6v9noIynEKIxc8gen/tuJqS884
 Tas5h2l/pqrWtTl+fBwiiXzCfUfX9zp3C1XgJLSFACvkwSNT8Ejd8Yu/5GTnvXqd
 wSaktUkD6KRP+aX2ZQkrQPtAh148LLG2thE6RgBSoMyQOGmyfFNOFr/vkTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euees2mas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8428384f31fso4302492b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691624; x=1782296424; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ntYOoagLVSregOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=;
 b=MP1ezxuBJkYSDHphICrGPTG5ZDcrnM+dpzHjBCjQEv/LlqPFMIua0EY02U6q1UUcWB
 8KCNNfETKneoZD0jPOyFkBHVASoUQtmbMjm9Is1cxuurVMzOD22TCS84rSs2xMndeVMY
 Sdd3d697hZbOLFc8So3TDDuJHkAEBudWyfOqPTKbLN866SM6b+iHlBDmatvlFvFU5ABI
 myDtKMCua6WdtOkoIC9+Cv0iUahlRdyP5Bazt8ioD3kJAXWpe90jcs0jreDf5vSXxzPV
 0BQTghJxrB0FbeMgjtywVuizv5goRhzg2FLrSvaGRTzEB2kp6ZZUl445+5YN98J4nEZR
 lS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691624; x=1782296424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ntYOoagLVSregOwS9vo6YnaQLXa5kGLHjVD0L+2ddnU=;
 b=YBRcjg3KI089qT+e8/pPVs7+VaIq5o6dVjUZpcMw0Gx5Jh/ilST9FzvVS3Oskmcwve
 JAqkBZVn21iOKbDwhKrS/kfZK/bJq3cIAyzDzBBsShkLRmkxi2P2G/BWgepArrSCmEuf
 68tdWr3JGrRFi1LRIhIjT3x13sNvbjQ+eUzFaXemwsJXaX6Fmy6iwO15Q7I4Bunpk45L
 /lbCgeG9s6FzfPzM70NjEJdoy3KtP9KSBRFdhlyokS74eGQwwKLkdqRsKq5qFIR4ZGrS
 VzRfxJO8PPJqt4XScWFRyzjFsjBr1FZJU8ih3yvGLaxzPaMTie4YaR3JvC8ihmdfxqsX
 hn0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fbJI5rX5qBpezQNskZrcaBRBvd/UsRsPofNsRIGLzD/DxXc8/Gl5IbcPEAsmAwpmn6HVSoa0=@lists.denx.de
X-Gm-Message-State: AOJu0YyPQ7PZPx1CP9rQnP/eeYaOf1aUQ/VfZLhs7gOdSNfG/nXtP6g0
 htLPDPJ4cD/AHJ68eH2b/MDeHasM7ju56ou9i3MX2cDDj+6kmSmUkmPglymgkx8sY2UwJYN6/LK
 PN/m7+KOnyjxwf4ufurccuRnybePJcG5VOQm6m+QqX9enz5nYOj6O2mAv
X-Gm-Gg: Acq92OHCeIORBX80pNhUbWbSSW2AkfYI5ynTtt2vRfyGVWFHjxNda/rDoOEdnGOxC2m
 jZOYTGQmJYBCxcsQaJUCkTuSK8GDhtQbJ/OiRutxdYl/cKxcKzJLQTu3Xgh2WbqOXMz76BnrH2G
 u+YmymZm/FdBeQYRNjS4ShV/b2U9+kaUwwYoBEQVLhKA85v93aqKiGzztXlI7iPnMSwWg/rDtIe
 +bnr15xx2RUEyha8AK4p9dBGFNPCEHETLTb/MaYkr1zDpKGmtVEacYFb+eWZ2s3y5VtFiRrh094
 9PFddR2rNQJRDMs9Z28p1MmeCZsco8b+blrf/ajunzL1yzd29WMI/3Yz0ONBd28/q4khxJEnt0t
 tBC34tycumAivDJdmaYEFoPzQiSiHwh19c75tUSOGYifzlg//G/Cd2A/62g+rmTg7h1ZdWKV49S
 GycTElqFvpjMDXpSHl0EfRSq4SYKwgCHlwMplOOFPu
X-Received: by 2002:a05:6a00:3a18:b0:82d:62ed:b01d with SMTP id
 d2e1a72fcca58-845247b6791mr3185096b3a.45.1781691623807; 
 Wed, 17 Jun 2026 03:20:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a18:b0:82d:62ed:b01d with SMTP id
 d2e1a72fcca58-845247b6791mr3185022b3a.45.1781691623309; 
 Wed, 17 Jun 2026 03:20:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:20:22 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 10/13] mach-snapdragon: spl: Update SMEM with boot details
Date: Wed, 17 Jun 2026 15:48:09 +0530
Message-Id: <20260617101812.299586-11-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r2JkhMdYfndCFP8bj-99u0NJLlbYUP8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX0RgIPePYHWCX
 QE8iaRrxXsPXKtSscg4cqK8Wjv3dlU4pzWur2ApBfmD2055HVJIUncF2RiAcNdoiKlG1t0TgWQd
 rjTkXnnoOv0H4BnvM+20UPRsvpLRXGoB2txn1gm0tbdbgAjyB03gz299IOGcJ3H7B+TREP6Xoy8
 ClB1VgjEE8FUYKdd9pkScaFLgdIfo2YlhufE0vzb7Z4ivm1tPjIbVPm7ia7MWe4yrHMO3icu/G+
 wOn6aLdOelcpgwmsuPfV5fpDs2xRvIyP58jbKhRRnyiiZFF6pJK686XkCrMocy9dkTByAAaqT/d
 AVeIZmbdRvzCw3iyoPmQm1AEXLejSp77KD4SrtExirn2byUj78M5MAQIwNdH8dUEwy7eyQL1aBs
 NdG/73pni/KGNZxLSPNI8vbNsOQ8Uyp1zdp2bP5VDrqBiTqeN3BMoixUKejr6Z134mo5gqQ1OQ8
 ERd7V6rRwjpHxU2YBPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXzQiPEJg0Xty/
 6uqWcyIkAp47fKZG6CtwWXX8XUrpd2x8xLRjLFQfSW9jLmQlcSvG7GdkbnCTi8GMAls7szWTI6d
 YEmu0xvhsy1pZ0ypYGDFbDNmNKiF/vM=
X-Authority-Analysis: v=2.4 cv=KeTidwYD c=1 sm=1 tr=0 ts=6a3274e9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cu-XF-9Gu4gfq0MNXlkA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: r2JkhMdYfndCFP8bj-99u0NJLlbYUP8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

