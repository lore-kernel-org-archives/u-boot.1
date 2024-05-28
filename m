Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D57CC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59D98852A;
	Tue, 28 May 2024 16:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g81jkNvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1247B88511; Tue, 28 May 2024 16:43:20 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5498851A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E605400FB
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907396;
 bh=TCxnXSmYcr1hOqTEwm3+Z3/dfEnxnT34RoPW9S96tho=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=g81jkNvZKUnQh9jN0YWjl/XEtTyaHVuNrKZcm71PzOxsJYUIJKsAHeBW6+PtOiYPH
 QB0Qigu/qDMFJ9z92k5X+bcli9aOXwJdupUW358byTmFU5o8efagH+tErto0uYeREC
 1eKvmVkzrX5EUi1JiMHBEbu8wSYmG7ln/8XnGuTphvuCX/tobsAyCAVyhevDwCnwuY
 G8JMqNOBuMTpv3eh2ZSpJ0Bzcdwe9UBJNx/72DAqUe4wG1lLFFhmT3Zy/NDksPjRsh
 4I7N+ahb6awQD4cv9fHNxUsBOw2oZmJcZjK9zW5mVC6F3RNubxG5JxEcXS9Udk7oeR
 fz8hMfvIyCHkw==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-578697a21a4so205748a12.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907394; x=1717512194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCxnXSmYcr1hOqTEwm3+Z3/dfEnxnT34RoPW9S96tho=;
 b=KhMrcNzs1j/skeYX5glwqCua2G5eEhLUIXijD2xXW+pOtj+7cNefCKCCVJknnLoYKo
 1FSr4eSbYgHZp4NAULbTlz1AAyS9leME/t7n9M2jicd9+EIZlLE1AF1mzJS2wNGmUi2F
 BdVzfXF0qAAyVipwZt/f2MoX3sm8eKwEkppStCC0N5FQ6HPifL54kehqjihukeyuuzsG
 4guj75ieHzxw/yLvsolJdewPycf1hl+MqHBiVA+rHTx2CCieYZsNKEKzwyMyz1h5QPjP
 QgB0BA4Fk7rVntSjzEYAxenjJ4uAI4DBuCB+hchDxcRpVEpsQos2w+pnY7xhDH3FcgRa
 FAlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRSh1NqVUWMlVIvtpvQZyzB3zGmp0M//Hks1a3DOS86dYbRkqqKupX1J9gGHK69UbaaUbtcfEg7ggQBegiM5l6yBCA5w==
X-Gm-Message-State: AOJu0Yxy3xB34Q/9t7Djh9aANVdvpvUN42Pw6PY0Eiw7VG2ZTkfgdyFI
 DtFfUCGsnoDvCf+yxUYvszSKg+YlMtFW1eKPpwTU3kJbi03Dx2/Pho7An/cCpqvNqiWl3Cs9rI7
 olkfaAzTQ9RpkN9ipd/wpvNDaWrqcer7HIjTlqmVEbi4B7lT93Dpc+JQtLdQ74kCzWuU=
X-Received: by 2002:a50:cc0c:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57973b7b9fcmr7330071a12.2.1716907394649; 
 Tue, 28 May 2024 07:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQqCJ96aeK3OiG4AqwIuTiBwRhgJZqQjsso7CKPpt/Fm3ftvrG2mA8nsseSa7s2PpbHQPjCw==
X-Received: by 2002:a50:cc0c:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57973b7b9fcmr7330049a12.2.1716907394369; 
 Tue, 28 May 2024 07:43:14 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 8/8] efi_loader: load distro dtb in bootmgr
Date: Tue, 28 May 2024 16:42:52 +0200
Message-ID: <20240528144252.179247-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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

If no device-tree is specified, try to load a device-tree from the boot
device use the $fdtfile concatenated to either of the paths '/dtb/', '/',
'/dtb/current/'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootmgr.c | 13 +++++++++--
 lib/efi_loader/efi_fdt.c     | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index ab7bed22971..6c993e1a694 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1205,4 +1205,6 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 
 int efi_get_distro_fdt_name(char *fname, int size, int seq);
 
+void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size);
+
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b08d6e97ea3..68440542a37 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1249,7 +1249,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
-	void *fdt_lo;
+	void *fdt_lo, *fdt_distro = NULL;
+	efi_uintn_t fdt_size;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -1269,6 +1270,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
 			return ret;
 		if (fdt_lo)
 			fdt = fdt_lo;
+		if (!fdt) {
+			efi_load_distro_fdt(&fdt_distro, &fdt_size);
+			fdt = fdt_distro;
+		}
 	}
 
 	/*
@@ -1277,8 +1282,12 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
-	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
+		if (fdt_distro)
+			efi_free_pages((uintptr_t)fdt_distro,
+				       efi_size_in_pages(fdt_size));
+	}
 
 	if (ret != EFI_SUCCESS) {
 		if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index 0edf0c1e2fc..86ba00c2bdd 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -71,3 +71,47 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
 
 	return 0;
 }
+
+/**
+ * efi_load_distro_fdt() - load distro device-tree
+ *
+ * @fdt:	on return device-tree, must be freed via efi_free_pages()
+ * @fdt_size:	buffer size
+ */
+void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size)
+{
+	struct efi_device_path *rem, *dp;
+	efi_status_t  ret;
+	efi_handle_t device;
+
+	*fdt = NULL;
+
+	dp = efi_get_dp_from_boot(NULL);
+	if (!dp)
+		return;
+	device = efi_dp_find_obj(dp, NULL, &rem);
+	ret = efi_search_protocol(device, &efi_simple_file_system_protocol_guid,
+				  NULL);
+	if (ret != EFI_SUCCESS)
+		goto err;
+	memcpy(rem, &END, sizeof(END));
+
+	/* try the various available names */
+	for (int seq = 0; ; ++seq) {
+		struct efi_device_path *file;
+		char buf[255];
+
+		if (efi_get_distro_fdt_name(buf, sizeof(buf), seq))
+			break;
+		file = efi_dp_from_file(dp, buf);
+		if (!file)
+			break;
+		ret = efi_load_image_from_path(true, file, fdt, fdt_size);
+		efi_free_pool(file);
+		if (ret == EFI_SUCCESS)
+			break;
+	}
+
+err:
+	efi_free_pool(dp);
+}
-- 
2.43.0

