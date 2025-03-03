Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E3BC282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D335D812C8;
	Mon,  3 Mar 2025 15:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWnahEBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6645281249; Mon,  3 Mar 2025 15:13:30 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC0981249
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223785beedfso46494965ad.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741011206; x=1741616006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8afDDFrVPGyxxhcPZCK4dTLj0ZmanDkOe4Z7CsQxYl8=;
 b=TWnahEBQTDV2GbMU//QNnxqkR9vKKp5uyyD7R1C6KLyr+gzs7aTvP9FX5W+Dx4cPPi
 mbEcScFJnab0UAl5Ub1FsfkBmsfYR5j6smjBzn680MP9iYpHW2MITcjMlOOnQiOL3ZF9
 Nwobxn+a8Tw8j8beVW7v2aDWqoVPgr6rW8QplLmtb4RSGUwWvhXtnsgxp1KrRRXDIKp4
 ic9ZwqR4QPfKaTfHwYF4JdlDDtO0EhIMKYn5/P6+jmngvQLk9T052ddxfZgBkFXlZTmN
 Zpm0xtVYhC7voAcefk9+ZofC2NEGzKUkxDA86ckgJJY0Ot24ckf0368PXP48Aq7qQosC
 Cz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011206; x=1741616006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8afDDFrVPGyxxhcPZCK4dTLj0ZmanDkOe4Z7CsQxYl8=;
 b=sTiB9GMITZQXHHU75w1+vJ49FnfUNwDgqZXD4xmX7y78N5jrY7LNeJ+uZ0Gkfg3FMM
 N5bPmnXtwTC9p4hZPSPTdpWkysvP/myBx3f6jxUAw3htMrt8Bv4OaCDF2pRclJg8mP+K
 f0drz7p89yd+3AXcNzFf1F1+uDHDRLqUr1NgvykNOAV6h6R5kiRlL8rJoCVX4XkjKorK
 sIfUX7uJNfjQjixQ6PXLCi0UYRNYnW0N8Q9oEjePppcGKD0AC9jqOI0IUWGptNnSUcz/
 yOcCRv3greEAgsElHY2zpJY1hC1VRqGbyeN1UaypuRViamdGKIRiqR03eMqg1AXWiL62
 M2wA==
X-Gm-Message-State: AOJu0Yzw1gdwfH87sEB9wFpgZcIl3ChRAUUy6KxPp4LlbCOLIrAik7nc
 a8rPsvpl5p+iMAq9jmpKBTO1isqKJ74BWNbqlIrJAQuwXzHwQ4ZX3BWw+y+B6nA=
X-Gm-Gg: ASbGnct6e29DgsKBg+etH41JApWl938iWJLDqWJwyMs/gOr5E9exrTx9ON2SLKe86NJ
 N3eifd/SG8V+bZyNel6Ujdv0jUzd1RZCEi5jRNHzcL4iscDXJKgYAO7e5oQKUp0voyd4XYJcXTl
 CWZ37/2r066dKmiXFt2yMd0ObrCMlqUXFE/ih2azGboAdVuiLD6DaWGJf4ANkjZ/LGa7OTP8X2z
 jz5Hvmqzc9D7CPoyHC4VImuKtn9orgRW+AIKyo/UfhdY6rENKB2kfGJV1JVtDEiFJx5DiF/VSIM
 ngSuahvZTjVj+nlZcrNCloFdyKIdgOe03V3Nml5t2MHIUOVH7C6/bbM=
X-Google-Smtp-Source: AGHT+IEMW3iCcrE84IBcD5xaZLLQKbsTz3KD/HQSaug4rWAuu62sjBoNc4XQuom6Fly8DtoHI2gckA==
X-Received: by 2002:a17:903:138a:b0:223:4816:3e9e with SMTP id
 d9443c01a7336-22368fbea82mr200084205ad.13.1741011206493; 
 Mon, 03 Mar 2025 06:13:26 -0800 (PST)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501faa33sm77875265ad.66.2025.03.03.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:13:26 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 3/8] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
Date: Mon,  3 Mar 2025 11:13:12 -0300
Message-ID: <20250303141317.265098-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303141317.265098-1-adriano.cordova@canonical.com>
References: <20250303141317.265098-1-adriano.cordova@canonical.com>
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

The coomand bootefi calls efi_init_obj_list to do the efi set up
before launching an .efi payload, but efi_init_obj_list is called
only once. There are some initializations which depend on the
environment and should be done each time a payload gets launched and
not only once. A motivation for this changes is the following order
of events:

1. Launch an EFI application (e.g. bootefi hello)
2. Change the ip address
3. Launch another application which uses the pxe protocol

As the EFI pxe protocol was initialized when the handles
for efi net were created in 1., the ip was hardcoded there.

In this example, another possibility would be to make a callback for ip
address changes to go all the way up to efi_net.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..164586742ae 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <asm-generic/unaligned.h>
 
+#define OBJ_LIST_INITIALIZED 0
 #define OBJ_LIST_NOT_INITIALIZED 1
 
 efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
@@ -208,6 +209,18 @@ out:
 	return -1;
 }
 
+/**
+ * efi_start_obj_list() - Start EFI object list
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_start_obj_list(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	return ret;
+}
+
 /**
  * efi_init_obj_list() - Initialize and populate EFI object list
  *
@@ -217,7 +230,9 @@ efi_status_t efi_init_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
-	/* Initialize once only */
+	/* Initialize only once, but start every time if correctly initialized*/
+	if (efi_obj_list_initialized == OBJ_LIST_INITIALIZED)
+		return efi_start_obj_list();
 	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
 		return efi_obj_list_initialized;
 
@@ -349,6 +364,10 @@ efi_status_t efi_init_obj_list(void)
 	if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
 	    !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
 		ret = efi_launch_capsules();
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = efi_start_obj_list();
 out:
 	efi_obj_list_initialized = ret;
 	return ret;
-- 
2.47.1

