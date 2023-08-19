Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD13EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE6E87047;
	Sat, 19 Aug 2023 23:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R8M6L/3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83668700E; Sat, 19 Aug 2023 23:23:32 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2996387022
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7914633a110so71382739f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480209; x=1693085009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UYnbBLRuomK1Z6pcgfMJ1sLhkmin8Bre/aRX4FJtFM=;
 b=R8M6L/3R7vdhaGyjtLFVAXFrxdw85oht4BpMrDerrckWOYFb1E7OMWqNQRlUzqS5ek
 RPiF4RnojLB7MF3eAWav801NaOEmjReScTQBZgEqKw+bbF62B+nymkrJPxVwH+vIMM1G
 MXphElwoKrqNgAtXrEmrQCag9OL9+kbpKNqig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480209; x=1693085009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UYnbBLRuomK1Z6pcgfMJ1sLhkmin8Bre/aRX4FJtFM=;
 b=MNmbsf4W8dC9SUfMY55PaGqX6mVXr+ZBY+gP37qGwyP2MoJ6awiNJMezLlq3e0Qzlk
 gHR0MXBqan6z35Vuhsr8yci5VawRD+oCCo+jI2g5fddkvEWxPNsg7YDW8um4K+IRShLx
 5DyzcITWMJSnAeVioGbBgxPk0P1hZ1LSwFRc0AVqxHDQpJormBkHNoOf9coV07METY11
 gdr9hjZoTKdJQAisOv0BwqwvP3/O4IES5rVmw0eYkABkGiry9bjmWXUE5Brxw+D7C9jk
 9WlOgHCJRhtDubt4ohx0UhlpdFAe2fXQfAHTWIeF3TG5zO9BIc4tvkE8CSPOIaN+7/FA
 9tcw==
X-Gm-Message-State: AOJu0Ywji3lE1KrHKCe1la1N3rUBPH0CNkKdHxPPX7VHoL8espvLlNoO
 PIEPrbLwxvKTCTEH9/swrMAt5N5/oNDJ1sPk8+w=
X-Google-Smtp-Source: AGHT+IECEFsg6dOr5T+81b6glTmd6AF7jGz0JYjv6OSMZFF54oebe8S55o8VM7AkCq9YnLUahd7S+g==
X-Received: by 2002:a5e:c003:0:b0:791:6aa4:2d89 with SMTP id
 u3-20020a5ec003000000b007916aa42d89mr4079945iol.21.1692480208854; 
 Sat, 19 Aug 2023 14:23:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/19] efi: x86: Use the installed SMBIOS tables
Date: Sat, 19 Aug 2023 15:22:52 -0600
Message-ID: <20230819212309.1094440-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Changes in v3:
- Use log_debug() to show the message
- Squash in the next patch

Changes in v2:
- Add new patch

 lib/efi_loader/Makefile     |  2 +-
 lib/efi_loader/efi_setup.c  | 10 +++++-----
 lib/efi_loader/efi_smbios.c | 37 +++++++------------------------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 0eb748ff1a59..8d31fc61c601 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
-obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
+obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
 obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
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
index 306c0bc54f90..06f62d58dc96 100644
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
+	log_debug("EFI using SMBIOS tables at %lx\n", addr);
 
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

