Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5FDE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EDA88007D;
	Thu,  2 Jan 2025 19:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iNhEpnXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67DCA803AB; Thu,  2 Jan 2025 19:11:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC3E8001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 19:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C582D3FA5B
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735841507;
 bh=GXtTkdLVJ7wuJs1YuD4FZ+V54jxz2DhfpnLB6uvyT70=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=iNhEpnXVGhAmjYtp2UaN+o/L40CYg0EmpL56iUDTR0p6e8IviqPMcqnbZxjAa2v/6
 QRxbW9LLZtow5PKqUQFFl5YA8/Q7MZeSr4lnIwMbxlf60MlbcTpyaWrGco0JVMbkOp
 aP9vHBvi/YpwQOsXKX0erQTe+rUXEwhhYXw6BFdRvw/mEiAoGRJkdA6Vk0IM5G5NC0
 HEkIk+0rQEQ3SFZatLtZ8Tpk6AVV2owoaaK4ScpB+9w9yGLNT+XpD07KrngXLuzUrs
 qYW1hO/RpOSimyofX9ghWaQfeep9kDJ7+DRtjY8o6HlLrVbzZtDznJwdh/fHs5kFUc
 5zZtvJQWkAusA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso7449369f8f.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 10:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841507; x=1736446307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXtTkdLVJ7wuJs1YuD4FZ+V54jxz2DhfpnLB6uvyT70=;
 b=Q8Of9XxJt49Ugn6eDRdUrDMkHa3zxqRdbelJ2n0KaPCLn/vqN65frs3UQnz8kwQ7Wm
 gv6JNcUKXbFUCwyTrsEEqOyKMvbj3+8hnysKt1ikidVyjR1cn3FhI4dhd51h79qK8n1m
 iwnXn5b3youQjFqhIfeL4Ty6orgaoLm8pTSDxgreuP00gqurs5/+DaYyTm9cKQBpE/kH
 Hq8ztfOn0kAIdrbZiVjdliffvXqDFb9QfcuNYQD2+9Ewp1fWm2QcCE2XFt6Qi44TU/b2
 G70ksh7VF36fRm8f1ImVe8lb7ETrBEesBOEAkNR5MkrJmO0CbZiFrv1fQ0g6j6k3yhry
 VQkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmnUY/y10QwU9B1DefFmgKreJe0BMxs7+jqrNfkk7FYgvsefUq8wmjhQCFNaNzLFYkvvV8jCw=@lists.denx.de
X-Gm-Message-State: AOJu0YxQgkQfeNem9ToknRNa+ejn3Zo+sO5rqPMCSMYqHYng/g4xvfuw
 1BWnt0DtiPqLkLMvdfYNLui2h13U3+9aEi8OXMXJsezTiV+ranHKMhW1/VBBEBnK2SHzV4h+0EC
 AbH+OkJ8df/N9PUdDrAyMPp0WWeJaWFK07G09YQh7/3sY96meCbHrWycnKUF5xMp0JiA=
X-Gm-Gg: ASbGncurBXjw1V5pnhpCRpRlrbd7NDdeXrpN/JqvLc2zGvvgHVbt08M8UdwqGT+KxeF
 pz2xtVptD57RxqHj53Ccrfygqc6QrnYhvq919dNi99KqrxKlpv7tWn6jSb8zXEjhFBOLnMUTQfM
 5K7vbpTFHFryBA324PuklLR6Uh+4zlAZ4a4ZFAcx4dhjj/z0eIUrIed9qojFFJOMplYwgqKR9sT
 nzzi9b51m3874YIsLcnReesGJWGXRAmyJf8sRVlpKwWSrstnZizAQPz7Yq8yqBB6yDlovbhu8Bu
 081xLAmlSe34FQ==
X-Received: by 2002:a5d:5e09:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a223f75fbmr51279775f8f.44.1735841506995; 
 Thu, 02 Jan 2025 10:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDipasIYucgbEjGgp24Gk/DhJ+O1xo5gNkBIPB5ADNWcWMM7FL4L2TqeN24uAM974UL2tmCg==
X-Received: by 2002:a5d:5e09:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a223f75fbmr51279745f8f.44.1735841506592; 
 Thu, 02 Jan 2025 10:11:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:2b1b:688c:df4:9c06:702e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm496278155e9.6.2025.01.02.10.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:11:46 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] efi_loader: build with HII configuration protocol
Date: Thu,  2 Jan 2025 19:11:31 +0100
Message-ID: <20250102181133.378867-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
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

Without the HII configuration protocol the debug version of the UEFI shell
cannot be used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Makefile         | 2 +-
 lib/efi_loader/efi_hii_config.c | 4 ----
 lib/efi_loader/efi_root_node.c  | 3 +++
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 7d1f04e9fbd..195ed8667fe 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
 obj-y += efi_dt_fixup.o
 obj-y += efi_fdt.o
 obj-y += efi_file.o
-obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
+obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o efi_hii_config.o
 obj-$(CONFIG_EFI_HOB) += efi_hob.o
 obj-y += efi_image_loader.o
 obj-y += efi_load_options.o
diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
index ae0f3ecd3b1..54a72d573be 100644
--- a/lib/efi_loader/efi_hii_config.c
+++ b/lib/efi_loader/efi_hii_config.c
@@ -4,10 +4,6 @@
  *
  * Copyright (c) 2017 Leif Lindholm
  * Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
- *
- * As this is still a non-working stub and the protocol is neither required
- * by the EFI shell nor by the UEFI SCT this module has been removed from
- * the Makefile.
  */
 
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
index 4d7fb74b5d6..426f77cb2ad 100644
--- a/lib/efi_loader/efi_root_node.c
+++ b/lib/efi_loader/efi_root_node.c
@@ -78,6 +78,9 @@ efi_status_t efi_root_node_register(void)
 		 /* HII database protocol */
 		 &efi_guid_hii_database_protocol,
 		 &efi_hii_database,
+		 /* EFI HII Configuration Routing Protocol */
+		 &efi_guid_hii_config_routing_protocol,
+		 &efi_hii_config_routing,
 #endif
 		 NULL);
 	efi_root->type = EFI_OBJECT_TYPE_U_BOOT_FIRMWARE;
-- 
2.47.1

