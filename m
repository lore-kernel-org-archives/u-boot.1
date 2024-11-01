Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFCBE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AF9892EA;
	Fri,  1 Nov 2024 16:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="etcMYYFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2473789301; Fri,  1 Nov 2024 16:26:37 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7C588606
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso285200966b.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474793; x=1731079593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI+V/ztQgHnzvzla7o6fXvbMDxKa/O/Qph3dpr60HGQ=;
 b=etcMYYFCcvguoE4BQeQbnD6stawi5iFay2P+LKESbks6NzUEfHXjr/ssN43aBAJidM
 alL05Oq9PTwbp/haN2Lif8dG1PWywC1yIM5GknXdKlgButRtDpO9PZ3VaJrB6BdLVQbk
 HEDO8vKqbBiHQvTZu5ARi/YZFuIjdqaefJnOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474793; x=1731079593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI+V/ztQgHnzvzla7o6fXvbMDxKa/O/Qph3dpr60HGQ=;
 b=p+xMjyp081XrSh+7g9urNrvGsoURYVO3TwsN7NdiCX+qSlf4VU4OtCXUE8Mo/MwqEY
 xcyC8uAstOqVqL51Yt8thXBza3wcj3A1A8rVlSOfLeD0bKTSesbkucAV/dKmxyoXjOrh
 xhses+OxeOwJB3KP+hwFr2pefyHzp8eMZ4FBb7DGfYqcMxP8qE92nPneTLde+LJj4kCD
 rLNRDa+Gt0+dZTh27RhzbS6PqZ9Nz/iRrVaALGMYfscLZZZSf41caiZkhHpnmEQXUVxg
 2OYZu9Zx/caGGf36Kb6F1/3elTI+xrnyn5zxu5u1tEjcrRYuenAvUdnQ0n9yhtq7/WUQ
 XxIg==
X-Gm-Message-State: AOJu0YxAklzXo3U8TCPpKrkmtRXAvRI+B9x1/SRJgDBJyJj3sq5DFYKC
 gRb6zGVsJOJ+QnMUkcsJWSH2G4nnSbu4LMn1tUkuDNgiYq6LnnSXKIqgMEmd/UxgUj/8Wyy8xLt
 PYV6P
X-Google-Smtp-Source: AGHT+IG6jmZKsqWfLwqxo+wivHBA9aNRD4ijtxku05Nr0nZEtVheBurOX3F03tCUyb1qfeckgRpKzw==
X-Received: by 2002:a17:906:c145:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-a9e6553bf86mr394656366b.12.1730474792889; 
 Fri, 01 Nov 2024 08:26:32 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v9 07/11] sandbox: Report host default-filename in native mode
Date: Fri,  1 Nov 2024 16:26:05 +0100
Message-ID: <20241101152614.238747-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

When the --native flag is given, pretend to be running the host
architecture rather than sandbox.

Allow the same control for PXE too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v9)

Changes in v9:
- Separate into separate patches

Changes in v8:
- Add new patch to report host default-filename in native mode

 include/efi.h               | 15 +++++++++++++++
 lib/efi_loader/efi_helper.c | 35 ++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index 633f5b4acb5..817bc56c835 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -679,6 +679,21 @@ void efi_show_tables(struct efi_system_table *systab);
  */
 const char *efi_get_basename(void);
 
+#ifdef CONFIG_SANDBOX
+#include <asm/state.h>
+#endif
+
+static inline bool efi_use_host_arch(void)
+{
+#ifdef CONFIG_SANDBOX
+	struct sandbox_state *state = state_get_current();
+
+	return state->native;
+#else
+	return false;
+#endif
+}
+
 /**
  * efi_get_pxe_arch() - Get the architecture value for PXE
  *
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index b8ece1c2e0c..ab5678eb66c 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -23,27 +23,31 @@
 
 #undef BOOTEFI_NAME
 
-#ifdef CONFIG_SANDBOX
-
 #if HOST_ARCH == HOST_ARCH_X86_64
-#define BOOTEFI_NAME "BOOTX64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
+#define HOST_PXE_ARCH 0x6
 #elif HOST_ARCH == HOST_ARCH_X86
-#define BOOTEFI_NAME "BOOTIA32.EFI"
+#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
+#define HOST_PXE_ARCH 0x7
 #elif HOST_ARCH == HOST_ARCH_AARCH64
-#define BOOTEFI_NAME "BOOTAA64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
+#define HOST_PXE_ARCH 0xb
 #elif HOST_ARCH == HOST_ARCH_ARM
-#define BOOTEFI_NAME "BOOTARM.EFI"
+#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
+#define HOST_PXE_ARCH 0xa
 #elif HOST_ARCH == HOST_ARCH_RISCV32
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
+#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
+#define HOST_PXE_ARCH 0x19
 #elif HOST_ARCH == HOST_ARCH_RISCV64
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
+#define HOST_PXE_ARCH 0x1b
 #else
-#error Unsupported UEFI architecture
+#error Unsupported Host architecture
 #endif
 
-#else
-
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_SANDBOX)
+#define BOOTEFI_NAME "BOOTSBOX.EFI"
+#elif defined(CONFIG_ARM64)
 #define BOOTEFI_NAME "BOOTAA64.EFI"
 #elif defined(CONFIG_ARM)
 #define BOOTEFI_NAME "BOOTARM.EFI"
@@ -59,8 +63,6 @@
 #error Unsupported UEFI architecture
 #endif
 
-#endif
-
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INITRD)
 /* GUID used by Linux to identify the LoadFile2 protocol with the initrd */
 const efi_guid_t efi_lf2_initrd_guid = EFI_INITRD_MEDIA_GUID;
@@ -68,11 +70,14 @@ const efi_guid_t efi_lf2_initrd_guid = EFI_INITRD_MEDIA_GUID;
 
 const char *efi_get_basename(void)
 {
-	return BOOTEFI_NAME;
+	return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
 }
 
 int efi_get_pxe_arch(void)
 {
+	if (efi_use_host_arch())
+		return HOST_PXE_ARCH;
+
 	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
 	if (IS_ENABLED(CONFIG_ARM64))
 		return 0xb;
-- 
2.43.0

