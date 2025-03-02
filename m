Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106CAC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB23B81276;
	Sun,  2 Mar 2025 15:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F5C87FWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9693E81280; Sun,  2 Mar 2025 15:22:06 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E0458120C
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 43BF542828; 
 Sun,  2 Mar 2025 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740925304;
 bh=JjE7blrCbUWDIY+h7shITh8FTFn+rYCrsKVyJq5UIHk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=F5C87FWF4g3f/+sfOaqMbgcLr13LhHyd5TcOKaZg9zmCgDZzVzzncs9Bcvbe5qc5Q
 MySWqEnsowom/vg8Jlt4GN9B6q22Jg8qUAnaISp+iFW13IPLU6WJ0SVZWx5Oiykvaz
 DSN758BH4uXg5HzG2n13UQCv2XI0QjWeaqEjY1HfX2TzDt7YHZFgB4DQnTLe90QG1g
 afBAvrNKKVUG9qfwFfqMw8rvOvyw2gJVRLAQIyF+SIulJiHYjMyCDsb7920N1VfKVv
 ecXpl2BX70JsbVrMcO+pO/dBzBv8hz9rk+AfVIfB529m8muig0EQaFqJg/zWg0C2s5
 uoRok1JyHtWGA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 4/5] efi_loader: Clean up usage of structure jmp_buf_data
Date: Sun,  2 Mar 2025 15:21:20 +0100
Message-ID: <20250302142121.150480-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

From: Yao Zi <ziyao@disroot.org>

Structure jmp_buf_data provides the underlying format of jmp_buf, which
we actually don't care about. Clean up existing code to use the standard
jmp_buf type. This introduces no functional change.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 include/efi_loader.h          | 4 ++--
 lib/efi_loader/efi_boottime.c | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1d75d97ebbc..22b724f311a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -15,13 +15,13 @@
 #include <efi_api.h>
 #include <image.h>
 #include <pe.h>
+#include <setjmp.h>
 #include <linux/list.h>
 #include <linux/sizes.h>
 #include <linux/oid_registry.h>
 
 struct blk_desc;
 struct bootflow;
-struct jmp_buf_data;
 
 #if CONFIG_IS_ENABLED(EFI_LOADER)
 
@@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
 	efi_status_t *exit_status;
 	efi_uintn_t *exit_data_size;
 	u16 **exit_data;
-	struct jmp_buf_data *exit_jmp;
+	jmp_buf *exit_jmp;
 	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
 				     struct efi_system_table *st);
 	u16 image_type;
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index bdf9e7e8066..853a1c8c097 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -21,7 +21,6 @@
 #include <usb.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
-#include <setjmp.h>
 #include <linux/libfdt_env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -3199,7 +3198,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 	void *info;
 	efi_handle_t parent_image = current_image;
 	efi_status_t exit_status;
-	struct jmp_buf_data exit_jmp;
+	jmp_buf exit_jmp;
 
 	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
 
@@ -3238,7 +3237,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
 	}
 
 	/* call the image! */
-	if (setjmp(&exit_jmp)) {
+	if (setjmp(exit_jmp)) {
 		/*
 		 * We called the entry point of the child image with EFI_CALL
 		 * in the lines below. The child image called the Exit() boot
@@ -3444,7 +3443,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 	struct efi_loaded_image *loaded_image_protocol;
 	struct efi_loaded_image_obj *image_obj =
 		(struct efi_loaded_image_obj *)image_handle;
-	struct jmp_buf_data *exit_jmp;
+	jmp_buf *exit_jmp;
 
 	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
 		  exit_data_size, exit_data);
@@ -3511,7 +3510,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 	 */
 	efi_restore_gd();
 
-	longjmp(exit_jmp, 1);
+	longjmp(*exit_jmp, 1);
 
 	panic("EFI application exited");
 out:
-- 
2.48.1

