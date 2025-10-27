Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5443BCCD1A5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9243482A9E;
	Mon, 27 Oct 2025 06:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y9H3NHXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1883832AD; Mon, 27 Oct 2025 06:51:12 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9DA80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-44181f9e5b4so2539424b6e.0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544269; x=1762149069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE9CNbtw4OwTRlbQ5Q52X+jQMcAeEFvFrlgG/CHKsho=;
 b=y9H3NHXi0/T8kOI/xvf/CwRZLHnoFpTOdY3HbfE4zQdsq3CJegxCEcwp3TegzKi627
 m0bVpXafmZ1aMlu4YHLPmJdrFvY3I1lbm0SDhLUcmITc+D3sWOqLULHSPi05BSC1De6D
 Sx8GvytgnxTamsnIKzAfIeCr9K7RKQmrbnT2ouliHJNyUW/aOPpbOrCrSaKj+7x8yDpo
 eChum9OdGALpzR6zxt+qAYhJa+8swpa1i+3Mk0d+7N7SQQBWc2mCNEi6be9xeRbwuVEQ
 IyhzEcZ5dMSW0Pg1T+KLey1/mctNAq9mqEog2jT/PdALoCUqmjfDQI143GovNagSLqqi
 LARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544269; x=1762149069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE9CNbtw4OwTRlbQ5Q52X+jQMcAeEFvFrlgG/CHKsho=;
 b=C3gLMNMgZd3vvdYosy+hxnb+r1N/hgSm+/IhXZVZE4KkuGsb2dGR7lE/qtGquYGIRd
 J8QcMhKBapF6mgMla2wzDhS09PKdo20bZh76CsZYxsqS+1VKH02pEJZqByn0V0GPp1Bk
 Yi95hp7E2yvAmNtQDJioy8QOjOmy2aMCihJMSST3flZ6F8s9AWRVBp8+BX9uQ5gSO1+T
 TlkUrQ8ZNaVBQvFLyRCjqQtCQ7cXNO/H+GajSI5oeIzYZ7neswm7uv538LmT3v3IxN5Y
 uPATMjl4WUjIzmSRRKJ/LZn5nCdiiOcwyTLIwMn7Wd6SrKeIxDMGVqcLId4oi9RM2Pg+
 SJ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpNsjEi+WlnwF5PcXITmgOJ54qseHUdydV6IayZ/J7ZjBLWYvMhmWNgmr64lsORlipjwKuXtg=@lists.denx.de
X-Gm-Message-State: AOJu0YymTepn0uDz8Qap8N5g5JqIeISsNmo+LPiOIZ1NPvX809lgN0tM
 4MeoII4ni2bRjCOcjfY5fZAOunl7254JqzKtISuBMS7x5ZGgrHowXvFQUhPrVi/3rKM=
X-Gm-Gg: ASbGncvc4NcrAsbw93dZafJDeVZ1jJFzOdOgaDgZ5EM49nbBagTqL8soUcMmJx1Ehcx
 f+jbn4BjWojhRDNPOFK/m5PRYgHFW+FLY66uU6Y4SjWxrwB6Lo8Yqyn1xnLlWQl0e+dNiwQSy7Q
 8EGtiftg53OVo4fHPTstc9wMI4cImddSFz9e9yVqZ0Y8Syt2V5d7sMsbnictU/O43AV3BlN/ILF
 Y2fgz2SBCnoI9GTW0KB0OrlO4U4smlZoyrKsbkE78GdgJ4rzST+vBd7PCoUmSbPpM6OTja1MOkA
 fst4BADOJy+jzOA885dH2tZdZ5YNEwkdmcu/LM+OKPRms36evP+hJBV5j23X+60IYDII3wysqWU
 nzkilfMVzQwB6Ss9+TuBezGJLTs5Agot819ouVZysXFaXkG0iYuRFlWqNkeKcxVpc5yrqBfe8Je
 kYNJnj0tgoIj8QLk7zB7MK
X-Google-Smtp-Source: AGHT+IFavNpBDnX2K/hQzlKAWkzlwzvwodULyEodAVuSKB1QD4MEm7bEbbdiwmBtNQW8+alfcc2lTQ==
X-Received: by 2002:a05:6808:14c2:b0:441:8f74:e91 with SMTP id
 5614622812f47-443a31673b7mr14718374b6e.59.1761544269472; 
 Sun, 26 Oct 2025 22:51:09 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef27255bsm1647512eaf.0.2025.10.26.22.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:09 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/5] board: samsung: e850-96: Add routine for loading images
 over USB
Date: Mon, 27 Oct 2025 00:51:04 -0500
Message-Id: <20251027055105.720-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
References: <20251027055105.720-1-semen.protsenko@linaro.org>
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
 board/samsung/e850-96/fw.c | 38 +++++++++++++++++++++++++++++++-------
 board/samsung/e850-96/fw.h |  7 +++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
index 2d52433e38ad..e8777060563f 100644
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
@@ -93,6 +98,25 @@ static int read_fw_from_raw(const char *ifname, int dev, const char *part_name,
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
+
+	if (res.a0)
+		return -EIO;
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
2.39.5

