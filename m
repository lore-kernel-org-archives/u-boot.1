Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2815FC27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DCE884D1;
	Mon, 10 Jun 2024 11:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tQApyljV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFEB2884FE; Mon, 10 Jun 2024 11:11:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFE38812B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CED5741332
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010674;
 bh=Bqjx4jVOdZX57T2DUz9sXVuyDmiJlO+Wj9832m4i8DU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tQApyljVm9BT8mZVkyAObF8Fc2iTusUYG/Vy+Dppc3wXkxUVFp4kFo7Wvhu4D6Qsz
 mky8NZA5yVYhYl9/fe+LhdrBqV6cXh7ub9MbziFryHSvopr1cuxhpM3/bd4QOwWrd1
 acCSCdqEQ4z29D3qw/S9JSBZKsPw1HOk696sGEX1rnkd26DKtS42cY6Mwyxt5rlx1C
 p9UtgcbkvrkfeGEu2qUxf4BbEp8isIgVLZkZzYAZpqFq+qmALe7ypy9zODVCXvS1JV
 nbQK9MLGY3iw9cWboollE6czxSVI2md1rRntHTxO8B4h17+bqD+QGTHdeLUVYcQXxJ
 7lKZ+t0KkNe1g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so5238315e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010674; x=1718615474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bqjx4jVOdZX57T2DUz9sXVuyDmiJlO+Wj9832m4i8DU=;
 b=lx8u7SpA8Z6Zqg9cocZASjgIL3L4O3FQJ9bTixZRsNHJQak5UIxbrzocJYQ3MQpbTP
 PdWOQV8dATL5ySusg+6rPBQGWpASjHQidOxCI++0Va+UBGXc7uCyjj1hT5qSV2y2TBn0
 SWFSjSCfkX6kGUvCVdq8PTId0BQZFn1Vq8q/ujd0XEtdXiI/aQ39XbdOC5BYEPVsY0ky
 AneK3OQm/YvF5ZrDWA3dLc1KSMMLFwKb0ZkjvhH0ZUjmtwd2FK1XBMmprQqSv1p7hrDE
 qsEVTEmeoivoequXyb3hGccjdQ5MKlA6mz1uK+yyOWERlSP/F00XWhHNqzN6CJKjQnXy
 kUTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu7h4YwT1KImA7B3TIKDEDyCJoCIvJDvn75zKutFAuLtPDL+0tWuDd4fG24oaTf0tGuIHlus+UHRzBDK9gubIy5c3Ogg==
X-Gm-Message-State: AOJu0Yziia+lrIlQmkstmsDVAFAe4kW96Wb4iKoUvk/EDuTrQsOOGsFo
 KL1u79jiYNAz8LRGGy0kSwjHw/HeQTarAudEoMpmFITRIRpkZLNIVMhqoJrBSOILmhHvzAxWH4l
 io6znV22MUBBWRfpNvcbKJpgBRfBKBfUS31wYfB8Y2OzfNI9aScUY32ikBF8gIysOoy0=
X-Received: by 2002:a05:600c:138e:b0:421:2df2:2850 with SMTP id
 5b1f17b1804b1-42164a21d60mr91051495e9.31.1718010674084; 
 Mon, 10 Jun 2024 02:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmawueKacXjqChLu8pyMLxN2RdPQmjiBENSONSS/gg4E8eeAUnM1N6hsIa9uIWqg8wtABrng==
X-Received: by 2002:a05:600c:138e:b0:421:2df2:2850 with SMTP id
 5b1f17b1804b1-42164a21d60mr91051365e9.31.1718010673846; 
 Mon, 10 Jun 2024 02:11:13 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 8/9] efi_loader: load distro dtb in bootmgr
Date: Mon, 10 Jun 2024 11:10:56 +0200
Message-ID: <20240610091057.64463-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	no change
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

