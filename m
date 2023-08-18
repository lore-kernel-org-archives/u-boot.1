Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783E2C2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9933286C20;
	Fri, 18 Aug 2023 02:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DL+2Lmju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC6786C58; Fri, 18 Aug 2023 02:27:31 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B8886C3F
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34961362f67so4070995ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318445; x=1692923245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8y7y0xxBp4VyRPVS3OVJBMp4w4su0O4fk1PuWD4aqw=;
 b=DL+2LmjuNqplFjt8G7NvGvvPgohLufu4ks87MSZzdeGgBuYhMExio5K7+RB+jWU8Ou
 uLUjAvBLGDSYb2GaCf7qLpXzAhlJujv+k3NYIXDS7mAStqDZJUdNHQtVAwMlY/UHE017
 BPG7NzKDemybO05RwdXXuZ5H/y9kCA39xVPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318445; x=1692923245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8y7y0xxBp4VyRPVS3OVJBMp4w4su0O4fk1PuWD4aqw=;
 b=HL6s/Tv4S5EkkU7eb13CeSnn5rRbV3GZ68KdUg27ql4p/aRUVRzsdZS+bfIlU0Ccyv
 5NiqNsffFehVUb+neUuqPSB7+uhvsrA7De9DvQZhX5Y8y9yfCVfHJebeiNQ4fV1KM6zK
 4Ix0v4AEuESSTO9sJhmhCTKUd6VIN03otNRYqYzgQsr3mDfWuorRBhoaHXt9yQ8s9p5I
 k6Ogmb+I1Eplu6yRaYwggse/FPpi/JeHSUJTu3daLRuvsDS/9uNHO41IT0duLwBf7yo2
 a6DOYelpSjmZwzEcVwUALBwbRHo7E1X0fKNGqe7sSTPUr46mKIplmoFaNp8Fc5WiSPFa
 e3/w==
X-Gm-Message-State: AOJu0Yzvzv7gceAWNIXN0DApuG9prsGeoB0uzKJ4d0NV484dFXCTNXfO
 0ntBnamFzfKJsa+GREsqb1MdwVPGZyXODGsthmc=
X-Google-Smtp-Source: AGHT+IFCDmiUV42q7IWPn1x+ED2Txj6T4HzyVbHl1713r4UH1gw54BP4d5ljYQhdfmkOJZk2sDb/7w==
X-Received: by 2002:a92:c544:0:b0:348:cb33:a3a6 with SMTP id
 a4-20020a92c544000000b00348cb33a3a6mr1362759ilj.0.1692318445177; 
 Thu, 17 Aug 2023 17:27:25 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 14/20] efi: x86: Use the installed SMBIOS tables
Date: Thu, 17 Aug 2023 18:26:53 -0600
Message-ID: <20230818002706.853550-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

U-Boot sets up the SMBIOS tables during startup. Rather than creating a
new set, install the existing ones. Rely on the ACPI table's memory-map
record to cover the tables.

Tidy up the installation-condition code while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch

 lib/efi_loader/efi_setup.c  | 10 +++++-----
 lib/efi_loader/efi_smbios.c | 37 +++++++------------------------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index ad719afd6328..e6de685e8795 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -326,11 +326,11 @@ efi_status_t efi_init_obj_list(void)
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-#ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	ret = efi_smbios_register();
-	if (ret != EFI_SUCCESS)
-		goto out;
-#endif
+	if (IS_ENABLED(CONFIG_SMBIOS)) {
+		ret = efi_smbios_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 	ret = efi_watchdog_register();
 	if (ret != EFI_SUCCESS)
 		goto out;
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 306c0bc54f90..0e6454a8fe0b 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -20,36 +20,13 @@
  */
 efi_status_t efi_smbios_register(void)
 {
-	/* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
-	u64 dmi_addr = U32_MAX;
-	efi_status_t ret;
-	void *dmi;
+	ulong addr;
 
-	/* Reserve 4kiB page for SMBIOS */
-	ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
-				 EFI_RUNTIME_SERVICES_DATA, 1, &dmi_addr);
+	/* space for all tables is marked in efi_acpi_register() */
+	addr = gd->arch.smbios_start;
+	printf("EFI using SMBIOS tables at %lx\n", addr);
 
-	if (ret != EFI_SUCCESS) {
-		/* Could not find space in lowmem, use highmem instead */
-		ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-					 EFI_RUNTIME_SERVICES_DATA, 1,
-					 &dmi_addr);
-
-		if (ret != EFI_SUCCESS)
-			return ret;
-	}
-
-	/*
-	 * Generate SMBIOS tables - we know that efi_allocate_pages() returns
-	 * a 4k-aligned address, so it is safe to assume that
-	 * write_smbios_table() will write the table at that address.
-	 */
-	assert(!(dmi_addr & 0xf));
-	dmi = (void *)(uintptr_t)dmi_addr;
-	if (write_smbios_table(map_to_sysmem(dmi)))
-		/* Install SMBIOS information as configuration table */
-		return efi_install_configuration_table(&smbios_guid, dmi);
-	efi_free_pages(dmi_addr, 1);
-	log_err("Cannot create SMBIOS table\n");
-	return EFI_SUCCESS;
+	/* Install SMBIOS information as configuration table */
+	return efi_install_configuration_table(&smbios_guid,
+					       map_sysmem(addr, 0));
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

