Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF880CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64DDB83DA7;
	Wed, 19 Nov 2025 00:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CmKW1Ynb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2083583DCA; Wed, 19 Nov 2025 00:21:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8EC83DA6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6da5e3353so4949908a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508084; x=1764112884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v98LD3LbHWmbbQg+bE3EzYz67pFgM70uK2B6yODEkrc=;
 b=CmKW1YnbShtS5VGdIUIBqhJBakUQELLESQtxmLskHdj8OWhLVBp7jwV8gybrRFbFwD
 pBGWT2bYpWls+f0HWuUWU7Vm5TNRawfVBCFTnPdl9q8RSqaeOdiT1PJ3ure3kj6Kxpr+
 S+cbmcDCwhOI5zSDxXWHLZ107W9YaXNl1aRfkuSvcX/YvRBKoW/pa5Gn6zITJK+NV41N
 VJwiZMfcCgec4lup07ZWVQV14m6k6Yh1DcEomwtjX7D4teVAQ0HopYIn4h3nkZmCung2
 TkYuGm8pwqLfZIXETaUVgBE2ukwJuq8uPw17sKOPmO2fZAw15mPQeFIU1Bk6vz0GI7II
 BfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508084; x=1764112884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v98LD3LbHWmbbQg+bE3EzYz67pFgM70uK2B6yODEkrc=;
 b=wD9fFqTbzbL7Lyj+AySyt7HUL4ylLkHEuIcY5Xkpc++RSIEpBSwHjgb4dyAdUnblIz
 gBtVMB+NfOHRrBcyzwe5wtIC+X2V8eq/4HB19AJsFGuoByM2I1JhgTzUV3YDU4exv4If
 FHMXzGpDwwQXhBGLUMO7T3yYHsffbXfRSBTVpR7xW8bBanck96fmp//Gpb7fJK2Vk+TW
 aP5re+9NjN5EzluBqiope1YFyWsXkGdlm8EQJBdqgpSzavPHUnHCLYlWoqf6TYSe+Dka
 zyNhtpnytf9kZbSS/h2NXyRt7yb3bVZoPcclZtYE92UzqbCoFH9lqLd1R4bKH7R8z5kf
 QfyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUka5S2SzW/ag8r0hsH2iwlKlKJc3mi4HykwLvAW07odhAP8LgndEmCmgdm72J/a8egIwu2iqA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/TF1hGWCwsWpPLZV/jzk34NbRl/437oPC1ev4QY/zCEnsxz8q
 G3XLQwlclFRuYyOY+tSkoOm1g1US6pLV6T8a+MREkWTcPMkMVroA0FUgOc3nJokZkS0=
X-Gm-Gg: ASbGncsN+9ElutZPHK3RHnGL/kboVfzRF3qsmDEunqXSp1+s1pWGXLHgBtLUCdKfTk0
 QxePvyPSoKvQWvVCoOAn/lVTfPiSNzDjaOVscN8XYWydWeNF8IY594Z5RFg4V2OnAWhWchgYUYu
 eKLkELz36ObCsrDVAkYge718xEsZxqobuoSG6V6H3Xj1R1SQ/SJ/mhYeBNQe/Z75aaMJrTwge0b
 h2w6scqtYjGCgG+pFD+3aYSETYNVuOWqu+d1ylY61pmurpx6BdO6VuPtJFvpQy9y63KM0nciOPU
 X7w+xQa3Zdg+A9YPXVxa5ey2wFOynGS78qv2/vOoRdt+KwXIE9QSEkCmfTAF45IrB9s12M/+bmO
 fdDWv8BXtgsG5q9w1i+8Pe2h2GcVGHUF5GiOEl4X54VnMXxSm0vKNPtl5sz9gaeVO+OcBHcBdXO
 xeADWwnPvc+hSg50UBArRLZZ1qbit88+U=
X-Google-Smtp-Source: AGHT+IFBl1rRRlc4vyt0WatSWsjMbCsuwoVtWsdxL7xQMYPoZ5+OwPZJUjvcC8gBpeMV77CvOm1P0w==
X-Received: by 2002:a05:6871:c681:b0:3e8:8e56:6715 with SMTP id
 586e51a60fabf-3e88e56b097mr5573112fac.53.1763508084528; 
 Tue, 18 Nov 2025 15:21:24 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-3eb7a762d6dsm3436017fac.19.2025.11.18.15.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:23 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 4/6] board: samsung: e850-96: Add routine for loading
 images over USB
Date: Tue, 18 Nov 2025 17:21:17 -0600
Message-ID: <20251118232119.17928-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

During USB boot U-Boot is supposed to download some firmware over USB.
It's done by EL3 software, so it has to be requested via corresponding
SMC call. Implement a routine for doing that.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Return 0 on success in load_image_usb()

 board/samsung/e850-96/fw.c | 39 +++++++++++++++++++++++++++++++-------
 board/samsung/e850-96/fw.h |  7 +++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
index 2d52433e38ad..576167122ec7 100644
--- a/board/samsung/e850-96/fw.c
+++ b/board/samsung/e850-96/fw.c
@@ -11,14 +11,19 @@
 #include <linux/arm-smccc.h>
 #include "fw.h"
 
-#define LDFW_RAW_PART		"ldfw"
-#define LDFW_FAT_PATH		"/EFI/firmware/ldfw.bin"
+#define LDFW_RAW_PART			"ldfw"
+#define LDFW_FAT_PATH			"/EFI/firmware/ldfw.bin"
+#define LDFW_MAGIC			0x10adab1e
 
-#define LDFW_MAGIC		0x10adab1e
-#define SMC_CMD_LOAD_LDFW	-0x500
-#define SDM_HW_RESET_STATUS	0x1230
-#define SDM_SW_RESET_STATUS	0x1231
-#define SB_ERROR_PREFIX		0xfdaa0000
+/* SMC command for providing LDFW to EL3 monitor */
+#define SMC_CMD_LOAD_LDFW		-0x500
+/* SMC command for loading some binary over USB */
+#define SMC_CMD_LOAD_IMAGE_BY_USB	-0x512
+
+/* Error codes for SMC_CMD_LOAD_LDFW */
+#define SDM_HW_RESET_STATUS		0x1230
+#define SDM_SW_RESET_STATUS		0x1231
+#define SB_ERROR_PREFIX			0xfdaa0000
 
 struct ldfw_header {
 	u32 magic;
@@ -93,6 +98,26 @@ static int read_fw_from_raw(const char *ifname, int dev, const char *part_name,
 	return 0;
 }
 
+/**
+ * load_image_usb - Load some binary over USB during USB boot
+ * @type: Image type
+ * @addr: Memory address where the image should be downloaded to
+ * @size: Image size
+ *
+ * Return: 0 on success or a negative value on error.
+ */
+int load_image_usb(enum usb_dn_image type, phys_addr_t addr, phys_size_t size)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_CMD_LOAD_IMAGE_BY_USB, (u64)type, addr, size,
+		      0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EIO;
+
+	return 0;
+}
+
 /**
  * load_ldfw_from_blk - Load the loadable firmware (LDFW) from block device
  * @ifname: Interface name of the block device to load the firmware from
diff --git a/board/samsung/e850-96/fw.h b/board/samsung/e850-96/fw.h
index b061abc4df69..68f943e8bbce 100644
--- a/board/samsung/e850-96/fw.h
+++ b/board/samsung/e850-96/fw.h
@@ -9,6 +9,13 @@
 
 #include <asm/types.h>
 
+/* Image types for downloading over USB */
+enum usb_dn_image {
+	USB_DN_IMAGE_LDFW	= 1,	/* Loadable Firmware */
+	USB_DN_IMAGE_SP		= 2,	/* Secure Payload (tzsw.img) */
+};
+
+int load_image_usb(enum usb_dn_image type, phys_addr_t addr, phys_size_t size);
 int load_ldfw_from_blk(const char *ifname, int dev, int part, phys_addr_t addr);
 int init_ldfw(phys_addr_t addr);
 
-- 
2.47.3

