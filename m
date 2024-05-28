Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34CBC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6822D88511;
	Tue, 28 May 2024 16:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uF4KNMO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E6D8854D; Tue, 28 May 2024 16:43:39 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895F8884CE
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E2B0C3FE69
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907401;
 bh=c0C6C2/g7HA+lU8GnDTZMq46DYu7+aGZo5tWMQjlVjs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=uF4KNMO6PPQtsMYSgCuH3RLylaAW8CmGv6Boazodcog5uOhlWO4odtAn6TzdASRQP
 T8jOVkBm+xz5oUrzE0YOKPyw6u2YsdNndaomk2GxcDUTufqNfqbKffuhEKoPn2TQ6n
 8OdUl+uzuXwDFIJfupWosu1+XsH3MgIhRgUEDL3DLsWvhjy7cIzaijhl5Y3UAXwPi7
 qSgPsvPLx63Q/syzZUYee7a448eLqEuEul6yrvli0esvOjYw7DlyCV1G3eMoGj8Y2A
 xM3LhGs24dh71Cs5nTnRRcMnvgcqTHtS4ASRuIGDOxxRFhpEBjQYsz7+4iAovu7tfb
 XuwJUIWrU1wdA==
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-529a8c727d3so901208e87.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907389; x=1717512189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0C6C2/g7HA+lU8GnDTZMq46DYu7+aGZo5tWMQjlVjs=;
 b=D9+gT6lPXWrX+oYrHU9RthEpaYdz3N9HCRrl0yUOhXpaUFWpG04YvAzbLAz9Jrkpug
 VD+IIQEseoErk+MU9pQdmD7gNJ5eieVN3LKk3uftV9ZKiS9CLYnHGMC/YabQCbG/YED7
 7NtVyGkP08KTsxmEOrudXrtUUcZWYZQCzXnf/WiLeWzL0aqeERsaTlOU5INd/VYsYJR0
 6p4m+RvsHI/BbLGxV5FDN5c2wQPbVA/GNPAD7vWtCqsQeLNxzv71jzNxcXoj0RKuRkk0
 2SpYcHBTFmMx6nlIPb/afp3wEbp7JcKSD3uRVtJesZ0H5+S2UKIEehjMOW3fkmtDm9Jt
 ea2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvmlPi6pHmmmDDDLGTCrSRu3C92Mo1uRUVlGNp3uo2S/HGD04OemQddWm5iDD3zlbyq/X+dGYUZMWXDUF8aBdECIHIyA==
X-Gm-Message-State: AOJu0Yx4RKhPH6C7cNOJ/TwuHAy32TCWKWeW2ZUBOOQuUXUBS6YnmfRg
 qoSjQMyUZpHuR3Q1ZsjKrdPgGwioYzl6ewCYpRTK1ffevalcT4AShcz7JXSesIfvCHDVy2gUbi2
 27lJ3mxCmhFG7WJA/OBXjX9cYLrbCAXRlIFcsvL0WTBVyzISdmSEPwZGLbqms2xIRhc0=
X-Received: by 2002:a05:6512:475:b0:521:e967:4e77 with SMTP id
 2adb3069b0e04-52965b398f0mr11439554e87.28.1716907388882; 
 Tue, 28 May 2024 07:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhf/H8hb5Kcyg72vEZtqofRrkKDWr7JteDmfoGBdAcsKDZ80ph1ii8bUU6Y37LOs5Lod/cuQ==
X-Received: by 2002:a05:6512:475:b0:521:e967:4e77 with SMTP id
 2adb3069b0e04-52965b398f0mr11439513e87.28.1716907388218; 
 Tue, 28 May 2024 07:43:08 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:07 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/8] efi_loader: load device-tree specified in boot option
Date: Tue, 28 May 2024 16:42:48 +0200
Message-ID: <20240528144252.179247-5-heinrich.schuchardt@canonical.com>
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

We allow to specify the triple of binary, initrd, and device-tree in boot
options.

Add the code to actually load the specified device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
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
+ * fdt:		pointer to loaded device-tree or NULL
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
+	*fdt = malloc(filesize);
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

