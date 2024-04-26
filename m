Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26860C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ECF8868B;
	Fri, 26 Apr 2024 16:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WtbJP0Lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1EB88F03; Fri, 26 Apr 2024 16:14:09 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BEF88728
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 567E73FE65
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140840;
 bh=wiiYQD4IlqLYLTMQaivXL/3FtvuZbrAFoz04S0nkXHI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WtbJP0Lfhn0o7EifWALhNApsnfdbVRgv1No9g3GUofLh+uHzGoIevA21qK2zWY4zr
 kaUA83CVL/FCvN7nWiLtABbsXYrLOygl4aMDSFIsWfzlQaMy+sKgJx+ISB6PadgG4W
 8OyiJjA1e5eGFYxECZeIz/IhWTWWFLj11L5kZF+MocW9z2I1Jz1udKggmCBJ0eMUsW
 Mbm6QPTGqyvzGfKmK3P7nfUL0ADGSFgg5qJZYUVxkUUMA7UhDZYJXxp3xp90+R33yo
 UfHBfq8FTHA2bcwfwyOTjQwppZ8Vyos1w0h12CwlSuNq4VK1tU8F2nYNikvtMU19pp
 bspC2iP80YzCQ==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-347f92ab882so1481003f8f.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140840; x=1714745640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiiYQD4IlqLYLTMQaivXL/3FtvuZbrAFoz04S0nkXHI=;
 b=PY10sCqW5HQYrcVWm9iY06z8KyX5Hwc2Wc7SURlUaURhegQmG1RtnhrPDVYROHaO1Y
 sK3Ddj5VhuuWn0l6lEXgMbJ9cdyd+MFQl0U/R6Pw2zujuT4hhivZCZQrizKMM5DccHGb
 0ocL1HW9Dctrz3n/yYU5qQxIQYWxsSTAKZZdhRuyLx03yaL0nxHGLbnaMdkZg7Slt4jP
 vi7y2vG0aFhmM9JNxuMUJKfYA0Dux9MnVdQLIP+VdJ5q6l1xhUPG7jFByVatsiyQTkjG
 Vs95uMvtxHdRDMmt5HaViKr8p2kxR9ngZzS6nGDqtlRsgD0kqsRLXiyzFP3GVUp9EDnu
 5dqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsFVEqf4aUELOXmrP7JPb6Mvt2iLwi2+H3pzT0Ixyf9v9iU2Sva3WrjVIZxdaoRxWmUqUtATQFYg1MP5tM/wYV4t+XYw==
X-Gm-Message-State: AOJu0YxFcUXeMhqyH7a27jC/xME3an9XEC85+je7sPKpSaNL21cxjwRp
 iWnjxlMf4Mc39zDEY0ylNaCsG0lA4ResS2OT3LHP5hFTJdcIj3xTEDxqL4SL9KgHn2xuWtujy4F
 l6X2DzPRkpDz9b4RP4VJpFozLMNTFxM//AwjPWQdTUkQAWF+iOMceXFqpHmtjb5D+WYk=
X-Received: by 2002:a5d:5f86:0:b0:343:f3d9:a9d5 with SMTP id
 dr6-20020a5d5f86000000b00343f3d9a9d5mr2594405wrb.10.1714140839907; 
 Fri, 26 Apr 2024 07:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3W7tVl/+blx0da2asseSOBihiQSa6Whax+KjhaeBsLRyQmBZYPGuyQtmSNGO7IsQFsNResg==
X-Received: by 2002:a5d:5f86:0:b0:343:f3d9:a9d5 with SMTP id
 dr6-20020a5d5f86000000b00343f3d9a9d5mr2594386wrb.10.1714140839629; 
 Fri, 26 Apr 2024 07:13:59 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:59 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 14/14] efi_loader: load distro dtb in bootmgr
Date: Fri, 26 Apr 2024 16:13:21 +0200
Message-ID: <20240426141321.232236-15-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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
 include/efi_loader.h         |  1 +
 lib/efi_loader/efi_bootmgr.c | 13 +++++++++--
 lib/efi_loader/efi_fdt.c     | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 0bf325fdc4b..e0bdce2dbdf 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1192,5 +1192,6 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 void efi_add_known_memory(void);
 
 int efi_get_distro_fdt_name(char *fname, int size, int seq);
+void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size);
 
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 9ae948bcf08..7987b047f1a 100644
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
 		fdt_lo = load_fdt_from_load_option();
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

