Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85524F5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD2A844DE;
	Tue, 21 Apr 2026 00:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ehgFTX7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FAD6844C7; Tue, 21 Apr 2026 00:03:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1918844AC
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EC59F40D87; 
 Mon, 20 Apr 2026 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722609;
 bh=KdiuzxvThPA8p8IcLdnjvqLxWQBusEuBoKEGsx6Aq6M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ehgFTX7/xQzZauI0v9IE6iaaf6y6JgawPd+qSpj01RWL1e0Cr45joZJ40//36GcLz
 eXtJhCb2Q5i8+kPIdXaLz2VYr0OMR/GHDto5DqcxJ0zNIxKFhz1HrRLzufDhy89F/y
 mR2CK5bvF3vXwrgSWsB8xwzOmAMcZ+KVR7FWUxaoATi496uzdI9pt239VHc6x6fm0v
 HkyJqEobjP7kxFm9bnZ9hpKQf0RK/s9+aE1arPeFaD+VzEO80LsVOdUr57yEalmrgg
 SJsi9L4nbqU48PvpzZS4FSOtcnSodhvR/oeUJxDTyr2cNZwDIRKRCM/IRZLCi2t3VA
 2zL/ACXUlpgfVlr+cAItp9gISm2hlCXi2wTvQJ5N/vK5+0wya7fK5WZRcc/7ISRFW/
 8fiBxQQnbwbD5UnwTvVccToWZJQmno6W2cFcU9YZTnKDcAS8bNUcJNbwzCI3PzSZUQ
 yhIfSpkbm5bChjMfv0/nufyQFkdup7FWAgIL4fmsX3FW/+g9s+7DDPtwTYc3sM92Ix
 26VRJOhun5tLlc36BRhZeB0s/IJcARZsQRwHjYsFW/uvD5KJ3i2bsjX/QTL4+B2AEe
 xO0DF56SgShfdQLMSY4CHDj6yxEEuFBj1a+5aEjKabr0Pb27ZoQvlYhenQbVYJSykO
 gGQ+WHSQw7xLpYsqvBTGSc8M=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>,
 Ying-Chun Liu <paul.liu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] efi_loader: centralize messaging for efi_init_obj_list
Date: Tue, 21 Apr 2026 00:03:21 +0200
Message-ID: <20260420220321.71147-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
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

If efi_init_obj_list() fails we cannot use the UEFI sub-system.

* Instead of having messages for this everywhere write an error message
  in efi_init_obj_list().
* Always use (ret != EFI_SUCCESS) when checking the return value of
  efi_init_obj_list().
* Remove the return code from the error message as it does not help
  users to understand which initialization went wrong.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rebased
---
 boot/bootmeth_efi_mgr.c      |  4 ++--
 cmd/bootefi.c                |  5 +----
 cmd/bootmenu.c               |  6 +-----
 cmd/eficonfig.c              |  6 +-----
 cmd/efidebug.c               |  5 +----
 cmd/nvedit_efi.c             | 10 ++--------
 lib/efi_loader/efi_bootbin.c |  5 +----
 lib/efi_loader/efi_bootmgr.c |  5 +----
 lib/efi_loader/efi_setup.c   |  2 ++
 9 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 05fc35d01a9..6e70c36ad99 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -58,8 +58,8 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	ret = efi_init_obj_list();
-	if (ret)
-		return log_msg_ret("init", ret);
+	if (ret != EFI_SUCCESS)
+		return ret;
 
 	/* Enable this method if the "BootOrder" UEFI exists. */
 	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 6dab709e507..37165f1a7fd 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -144,11 +144,8 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
-	}
 
 	if (argc > 2) {
 		ulong rd_addr = 0;
diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index d3108778c6f..528afd221d0 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -505,12 +505,8 @@ static void handle_uefi_bootnext(void)
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-
+	if (ret != EFI_SUCCESS)
 		return;
-	}
 
 	/* If UEFI BootNext variable is set, boot the BootNext load option */
 	size = sizeof(u16);
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index d8d946c87ac..570d788cd5c 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -2466,12 +2466,8 @@ static int do_eficonfig(struct cmd_tbl *cmdtp, int flag, int argc, char *const a
 		return CMD_RET_USAGE;
 
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-
+	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
-	}
 
 	ret = eficonfig_init();
 	if (ret != EFI_SUCCESS)
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 7b733119c82..a6faa36b500 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1669,11 +1669,8 @@ static int do_efidebug(struct cmd_tbl *cmdtp, int flag,
 
 	/* Initialize UEFI drivers */
 	r = efi_init_obj_list();
-	if (r != EFI_SUCCESS) {
-		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-		       r & ~EFI_ERROR_MASK);
+	if (r != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
-	}
 
 	cp = find_cmd_tbl(argv[0], cmd_efidebug_sub,
 			  ARRAY_SIZE(cmd_efidebug_sub));
diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 351ae47e870..3a36f94775b 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -213,11 +213,8 @@ int do_env_print_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-		       ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
-	}
 
 	for (argc--, argv++; argc > 0 && argv[0][0] == '-'; argc--, argv++) {
 		if (!strcmp(argv[0], "-guid")) {
@@ -389,11 +386,8 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-		       ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
-	}
 
 	/*
 	 * attributes = EFI_VARIABLE_BOOTSERVICE_ACCESS |
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 144266b785f..12db8f517c7 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -224,11 +224,8 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
 		return ret;
-	}
 
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 52ccebab19f..8c9a9b5eb56 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1310,11 +1310,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
+	if (ret != EFI_SUCCESS)
 		return ret;
-	}
 
 	ret = efi_bootmgr_load(&handle, &load_options);
 	if (ret != EFI_SUCCESS) {
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f06cf49e443..f302bb62ab9 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -392,5 +392,7 @@ efi_status_t efi_init_obj_list(void)
 	ret = efi_start_obj_list();
 out:
 	efi_obj_list_initialized = ret;
+	if (ret != EFI_SUCCESS)
+		log_err("Cannot initialize UEFI sub-system\n");
 	return ret;
 }
-- 
2.53.0

