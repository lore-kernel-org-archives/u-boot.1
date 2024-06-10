Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DEFC27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91DF88519;
	Mon, 10 Jun 2024 11:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hU4dMjWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76AB884EF; Mon, 10 Jun 2024 11:11:11 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A14188498
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC16341337
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010669;
 bh=7SHWK4ui6LBuyiXtheclM1cZ2JWKMUt0eW/oi/QkK2s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hU4dMjWADmgBCofOnnvyL7jXFXezCj7RhJ1mmmojX+MpEIp4Nt9TVlzkEEY7DX+YJ
 YcMNkiDM0VjHbcwL1bnJVrb6HkXrjB1U97mzEyLzqmEz/pIkNCoDahpEhZ5EW1hlVy
 ZyPLxVTtXk7BleOLdnSMzW8c3DEIvXEsaYk8401es30n4IAQSndajSAy3Ew4V8zvNR
 NTOETwmbsxBAEqIkPU+Ygt5mOkLAG8VjxJMSYa1IbcphP1KTrQQZyvDRIeWO5uhjFf
 TG4DOfjv72F9mQ0u31fcJ6AA0Pz1dUgHcSpGWFU9P+CBJKgSfgA6bddnsb40Ftdvc3
 AnkK/0XxNVhzg==
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c87d2efa5so951341e87.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010669; x=1718615469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SHWK4ui6LBuyiXtheclM1cZ2JWKMUt0eW/oi/QkK2s=;
 b=pZ3RFTn4p3z/VjRZKq75GSyW7kOv4mtZ3XCRqDw6r/1M+6N07P93LsiHaBZWbJYvgF
 sU2UYMZFbJZBQ8F23ZY3NkBScaTdD4Kedz7A5UcrtRrDZbIx4V9DrPEWc3hDFlih3Ifu
 wpAygeFkolCpTAxBIMFbW463zCG49/sPKk4iC7RsZn5HI7beTDUdNTEYEDU5Oja4T2i/
 JX/mqGCQ1pabhxQYWzciRkelP+ufZeGri2WzEYSiFCUYLiOmm/o358bYv+FEb5guZzDV
 BzOK2v2E326YvztQJiJGcaDiFP6va6noVhmBaTL98io7HD3gz4mpAOwf7yotAoAhVG1a
 Bjsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9kfBJMjAL7hWV5m48h01wbNrF9CWpbiBNA6iveUrZaEwPqQfyiFMpBL2YqdetTgdIPm7/9ecPl5wfiWK8GQom5TNB8w==
X-Gm-Message-State: AOJu0Yw58f9myfwL+A4iUyF2zwKQDQm87AlwGuTfZD0SOzuSctJjcvJx
 nW5gxat1Em0rQHFkEo+N2Fq9ODE0h/VN4dccM0oqeJpwZyCruza2RBassqHs6NHf96wbeg6FdQf
 4SpGX5mfMigxhwxplqPG2+jOxEg7L+yES1QNWoNqeF9c6WcU1suW5a/4ZzK4Tpzvdnc0=
X-Received: by 2002:ac2:5a01:0:b0:52b:c09e:407a with SMTP id
 2adb3069b0e04-52bc09e414amr5493243e87.47.1718010668782; 
 Mon, 10 Jun 2024 02:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD8XR4JrEItNYS2p9DiSz/aTgnx/cXXxfA3/5PPPWhcYpSy9EUboPmKuDwgatwhqReCUxBlw==
X-Received: by 2002:ac2:5a01:0:b0:52b:c09e:407a with SMTP id
 2adb3069b0e04-52bc09e414amr5493210e87.47.1718010668326; 
 Mon, 10 Jun 2024 02:11:08 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:07 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/9] efi_loader: load device-tree specified in boot option
Date: Mon, 10 Jun 2024 11:10:52 +0200
Message-ID: <20240610091057.64463-5-heinrich.schuchardt@canonical.com>
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

We allow to specify the triple of binary, initrd, and device-tree in boot
options.

Add the code to actually load the specified device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	Use calloc() instead of malloc().
	Add missing '@' in load_fdt_from_load_option function description
v2:
	Put all related changes into one patch.
	Do not boot if device-tree cannot be loaded.
---
 lib/efi_loader/efi_bootmgr.c | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b0bf21cf841..5ac116a7edf 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1185,6 +1185,59 @@ out:
 	return ret;
 }
 
+/**
+ * load_fdt_from_load_option - load device-tree from load option
+ *
+ * @fdt:	pointer to loaded device-tree or NULL
+ * Return:	status code
+ */
+static efi_status_t load_fdt_from_load_option(void **fdt)
+{
+	struct efi_device_path *dp = NULL;
+	struct efi_file_handle *f = NULL;
+	efi_uintn_t filesize;
+	efi_status_t ret;
+
+	*fdt = NULL;
+
+	dp = efi_get_dp_from_boot(&efi_guid_fdt);
+	if (!dp)
+		return EFI_SUCCESS;
+
+	/* Open file */
+	f = efi_file_from_path(dp);
+	if (!f) {
+		log_err("Can't find %pD specified in Boot####\n", dp);
+		ret = EFI_NOT_FOUND;
+		goto out;
+	}
+
+	/* Get file size */
+	ret = efi_file_size(f, &filesize);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	*fdt = calloc(1, filesize);
+	if (!*fdt) {
+		log_err("Out of memory\n");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+	ret = EFI_CALL(f->read(f, &filesize, *fdt));
+	if (ret != EFI_SUCCESS) {
+		log_err("Can't read fdt\n");
+		free(*fdt);
+		*fdt = NULL;
+	}
+
+out:
+	efi_free_pool(dp);
+	if (f)
+		EFI_CALL(f->close(f));
+
+	return ret;
+}
+
 /**
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
@@ -1200,6 +1253,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
+	void *fdt_lo;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -1215,7 +1269,23 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		return ret;
 	}
 
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		ret = load_fdt_from_load_option(&fdt_lo);
+		if (ret != EFI_SUCCESS)
+			return ret;
+		if (fdt_lo)
+			fdt = fdt_lo;
+	}
+
+	/*
+	 * Needed in ACPI case to create reservations based on
+	 * control device-tree.
+	 */
 	ret = efi_install_fdt(fdt);
+
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
+		free(fdt_lo);
+
 	if (ret != EFI_SUCCESS) {
 		if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
 			free(load_options);
-- 
2.43.0

