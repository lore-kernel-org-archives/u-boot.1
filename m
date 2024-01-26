Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE1C47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625C387BC4;
	Fri, 26 Jan 2024 08:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ism2gMmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A70862DA; Fri, 26 Jan 2024 08:54:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8188487B9D
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D3AD13F2D6; 
 Fri, 26 Jan 2024 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706255678;
 bh=IXHcg3YHMBsga/FDwOvsh8IMJAfi5VSAWI3o6fBtm4Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ism2gMmIAWt4t9UQTPKTYvRVLOaDx36uMZh/MIgdQXCDwdpGOPIeaa+i634jwv80u
 zUqnpy9GXrAyeNNR24vHhXUvsIMiLqNQytx3FVzJjauH5ajSy4pfBo2jQVoitq3gQL
 IX75NRIfX3SnM+MfU9jGSNLdzZ4ZrO5NyRSEVN0yTDob5+MTKVdipN6Uf/wW8eymca
 xYqI7tEsfNg+XOs1/qLyW3DZR/w3OKW4sYyo0u2L0fXatkrzjbK2Kos2CTMu0Lzisg
 AaAF/TDnrB9hmRcBF3HOWGv1aybbWn73T8+1IiCkxX1KjYioRK2rX5ra/eS7ax13vy
 AzX5wYgDkX/zQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] efi_loader: export efi_get_configuration_table
Date: Fri, 26 Jan 2024 08:54:30 +0100
Message-ID: <20240126075431.22876-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
References: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
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

In multiple places we need a function to find an EFI configuration table.
Rename get_config_table() to efi_get_configuration_table() and export it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h        | 2 ++
 lib/efi_loader/efi_helper.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index d5fca2fa5ef..2c44614dde4 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -545,6 +545,8 @@ void efi_setup_console_size(void);
 /* Set up load options from environment variable */
 efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 				      u16 **load_options);
+/* Get EFI configuration table */
+void *efi_get_configuration_table(const efi_guid_t *guid);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
 /* Execute loaded UEFI image */
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 11066eb505d..5dd9cc876e4 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -380,12 +380,12 @@ done:
 }
 
 /**
- * get_config_table() - get configuration table
+ * efi_get_configuration_table() - get configuration table
  *
  * @guid:	GUID of the configuration table
  * Return:	pointer to configuration table or NULL
  */
-static void *get_config_table(const efi_guid_t *guid)
+void *efi_get_configuration_table(const efi_guid_t *guid)
 {
 	size_t i;
 
@@ -430,7 +430,7 @@ efi_status_t efi_install_fdt(void *fdt)
 		uintptr_t fdt_addr;
 
 		/* Look for device tree that is already installed */
-		if (get_config_table(&efi_guid_fdt))
+		if (efi_get_configuration_table(&efi_guid_fdt))
 			return EFI_SUCCESS;
 		/* Check if there is a hardware device tree */
 		fdt_opt = env_get("fdt_addr");
-- 
2.43.0

