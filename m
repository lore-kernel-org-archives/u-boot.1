Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB46D5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BAD988B16;
	Thu,  7 Nov 2024 22:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jl4wbnpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D204D88EFB; Thu,  7 Nov 2024 22:32:22 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A4B8903B
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a3a5cd2a3bso5814445ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015137; x=1731619937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHM05lc2g6c+8ywIRNdu20hIwPzUitBwpjrHu3MdV/c=;
 b=jl4wbnpDiKu57j5rG1+IgHA9+DHuB2Ap5z80ERvHE2VdMANd8OR0RiVytRAszdX22/
 mIo/cGXJTrzaqrFRgnzR5ZM8eGRTvOwwdWVDnDFyhf3dClFNobiiPovQXDFuNIfJoA85
 H6QM9MVpFRsGVf6LF0qiBs5gRVSHD8iG016m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015137; x=1731619937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHM05lc2g6c+8ywIRNdu20hIwPzUitBwpjrHu3MdV/c=;
 b=Pa/GfT+jBIyt7Bq0tV6LdpL83DxJBwR3ZMEAoA4AGETu3y01UpPM2lvhwduEAztcoc
 oOiMSSK2R2+y5xxjfNi7BFpW1WmhIiD15qHKaKpCekUQ38uJoBosP/vARaiH7JHSDPlj
 /q2ydvARMrU61SbRPGi9Li+ZyBZSK+DGJErQ7CyWD6sGdchcLGzqdfGtGLTfSCV2hVXN
 bbxt2MNULKxEOHYOGvWsqoE5gvTw/goMycVOIMwLsXc/bbSFrXCx5xfq5ofpqi42WwLD
 qdQLflekdVtXWMihw8n+Ktf8jylcLpWqBpB9fOgoTVtcZP1kAlqaipRhTuCAxPLRO5k1
 9cmg==
X-Gm-Message-State: AOJu0Yw9RlhkZUVGXJfUumYQ3dpbGtX7QlAOlWN6+izyxWpA/ZUl2LZT
 TqKaF5y8J3IG+vGY87c2RuguazHSQqvstRKuEaOZuuHIr1d9M9Uqr4w8dNHZ/xK9k9nbAiANkXg
 =
X-Google-Smtp-Source: AGHT+IEEmDI3F5aH6Fzx7KhyRX00uwYJ1T2UmEoXAnl6IlVGup+DYltvy65qha68alKfEf6awsTHxQ==
X-Received: by 2002:a05:6e02:18c7:b0:3a6:c09a:504b with SMTP id
 e9e14a558f8ab-3a6f1a590d2mr9616525ab.22.1731015136837; 
 Thu, 07 Nov 2024 13:32:16 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v10 06/10] sandbox: Report host default-filename in native mode
Date: Thu,  7 Nov 2024 14:31:46 -0700
Message-Id: <20241107213150.1711962-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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
index 789a64eda9d..c559fda3004 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -678,6 +678,21 @@ void efi_show_tables(struct efi_system_table *systab);
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
2.34.1

