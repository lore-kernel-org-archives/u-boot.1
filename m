Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5573CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480C2836B4;
	Mon, 27 Oct 2025 07:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qcDsNUNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EFD83826; Mon, 27 Oct 2025 07:15:01 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BCA83710
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3d1cf5c2805so1840024fac.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545697; x=1762150497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl1DthvULsCiRVT2mKzmIN3w9gg5f/JNTbtQagxQK7g=;
 b=qcDsNUNP/XdvOm5r/teG61ML1pjSsP8KMwuuk+du7NZ3+Ec3lAIfuyeivU/M6Rynwp
 2vHKhCoVziWrCgimAUZGuEbNG69Siiq0ZMOpK/GfTEUaArcyYFgAcqm7D3UCojVRD500
 ygZ+9IsE3uSL65CtBSomeSYH78OU8ykSM9G36sKYp8e5uxUYCRSVxNpYyCJi4MX+qXXQ
 CyH/o2qyQgmQWxn9UrlpaeUjGDGq7o38yodqURL8V5uAHxZSyF0FaDMFfpur6QVZ1s6S
 y7lq9mVmI8xXrnji2A3W/wZ3zQcGw58LZyU8FidKD1+/bgE2yj+QxwbZie8ZyftPq6DP
 kwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545697; x=1762150497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jl1DthvULsCiRVT2mKzmIN3w9gg5f/JNTbtQagxQK7g=;
 b=bn8fgBqHnvZLf4LQH/jDv462ynGDGi9peLVmvB8UuFxJmgs2kPh4gG/IL4ySym7WXh
 Q2av79sPi6WIL5WI7BWW3gZNidkgpP8fHKC0I8Jc1xKWbrDz7UzCcVF8T2GjMrQFGwT9
 3kAxuo1cLaenI+OrgTYckhgi7Kh3YKLF4Aw9ADD4shMUVgMsJAPWGUmtR5mEelo7YGN7
 IVLPNZugp2+6kPcwE776uQu0TCFvY21lbNrTm1xdpfLSxifNUypAkNjhwrk2Y7Xm5OOA
 pumW0EQV0mTKPM9pE+IGiR8Td5ktmnSbP/2eHPMo2LmztXKu9IzLKoequJBmvhvPsacj
 j/vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLoEvaRnr82YX7fqGq+kzVKCjSBZyAV8rsgIh4MwT9v5xM/z0oPEm6+YVAdDl6JoFKYRBQwSI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3KKMun07QM/eLoxnNdm+G36+C2vtcyBYAFf6OSh5nXa4/vGws
 EGbDMgPfNe5NXYSKZ/TQkPtkX+1B7+NUizmoF9rHhUWuRTpx9MY0zmQQ9aqgwu3J8Q0=
X-Gm-Gg: ASbGncs9R+746a6BvTODpyUB8t45uW4zO+nV81zAZvr00ufESre58rh0rrfBONzaadw
 1H0/3KM2s6zn3jfErCWIKajoOuHkZQSu4tD5I/0PqJPctjaq96esVUAdN7GpO4dFOFexggdOLAc
 8vC+s7A9RMV806eWDPqDKvAmk0iTsD4bsMP9h9NsmZI9HZgTvGuW4gLQaAbjCUhfD3pmBDuiCBY
 ypg6gWrpJWYKwv9sRRDsK8CqYzcFIta+AG256+N0RE0DSXyxotj+1oxJ05nkjlP0jlsR3wUnnAW
 zQ+/YJ8tREuEvAMaQYv9yAw7e7+9N+z1fhUSjbr+wztuYvFvkR6kR91Rfp3L540LFJMmLRUVDym
 Cb5Hhdhu+suqj2MNMSHVxpbBfulcgdSiS+ff7He5XgapUP4UMT3nYxy7M1Ghkhyf4bvzdRfnEP1
 NbOWfu9bjmYw==
X-Google-Smtp-Source: AGHT+IEEcUDqJqXCsZ5U3r2JZOOiuEfWCCnJl0Su2jA9dThLJoqy/iGBlASYVDOcXNLpUm7tEq+ftA==
X-Received: by 2002:a05:6871:3324:b0:3d3:76f:5108 with SMTP id
 586e51a60fabf-3d3076f7373mr1842260fac.33.1761545697162; 
 Sun, 26 Oct 2025 23:14:57 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e2f2c97dsm2179097fac.13.2025.10.26.23.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:56 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/5] board: samsung: e850-96: Add routine for loading
 images over USB
Date: Mon, 27 Oct 2025 01:14:51 -0500
Message-Id: <20251027061452.21165-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027061452.21165-1-semen.protsenko@linaro.org>
References: <20251027061452.21165-1-semen.protsenko@linaro.org>
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
2.39.5

