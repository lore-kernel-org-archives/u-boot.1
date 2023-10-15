Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE76CCDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E76286CF9;
	Sun, 15 Oct 2023 09:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OGw7zrbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5744286F9F; Sun, 15 Oct 2023 09:04:15 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0970686FBC
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bca5b9b0aso1865507eaf.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697353343; x=1697958143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zim9k0ZneoNtxvh41Boqy8R1/zGCsYn0qtRpTVPi5/g=;
 b=OGw7zrbZl5gY75B5UpdPvARWQ37P8uMQVN7pr9H+K2/kObVaykBPfr1ir/hPunfZCv
 0kIKU2gsFGmBh/FYdwwpaUXbbt61Spm1w43gGZIQMhvJJWrsTBlu4zwrPNsCZDA+VZx7
 a65KPIDQsaGninpJ7b/wt3JrJS2BmX9+UceVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353343; x=1697958143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zim9k0ZneoNtxvh41Boqy8R1/zGCsYn0qtRpTVPi5/g=;
 b=J2gWze2bWpp/NXoL6MiJowPr285/7qkjMB1nscMgKhGDaeltyMrsPEuEjs2j9svH+0
 O5UkBmT6ETbKm1Fk+jNu/1wYLTl3/zLiE8yn4KO+yXx4MlVyDCbV08HCJsXzodTzG71S
 IOip8UU0LTyqRTtPKgW1MZ6Uanizu/ivSO1W+ayLQ62xEwcXBVnBqP7qonLwjQRmUrNb
 vIEP9pEP2qYC0393wXNLxDXqQGno2wTnqcTua+K2YmcrwF2hgkolKfg11geynv6tu1fm
 OEPex0/nwGmpZTeeUjURHJfiSQMoQZnXe8esIAU53d5H14dZZXMsVkazCS0IEHvXUGPe
 StLw==
X-Gm-Message-State: AOJu0YyXkaBf4cLjgf9UnrOp529E+loAPhLev9IKoFrNlbMvGW6/wOpO
 C2HUxTFC4mUrNSmppyCQclQHZSClphDbG63lsPbSow==
X-Google-Smtp-Source: AGHT+IGc/W/BEgVorP4kqxeQTPDenQMwDvOHar10w807QMnVyv4lKHfQvArAPcyE4hV9UCyErdREyg==
X-Received: by 2002:a05:6e02:1a0e:b0:352:6f88:9818 with SMTP id
 s14-20020a056e021a0e00b003526f889818mr35884115ild.11.1697337918662; 
 Sat, 14 Oct 2023 19:45:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/6] efi: Use the correct GUID for the SMBIOS table
Date: Sat, 14 Oct 2023 20:45:07 -0600
Message-ID: <20231015024511.3995580-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231015024511.3995580-1-sjg@chromium.org>
References: <20231015024511.3995580-1-sjg@chromium.org>
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

EFI does not use the 'anchor string' to determine the SMBIOS table
version, instead preferring to have two separate GUIDs. Use the correct
one, depending on the table version.

Call unmap_system() to balance to the use of map_sysmem()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a note about why unmap_system() is called

 include/efi_api.h           |  4 ++++
 lib/efi_loader/efi_smbios.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index 8f5ef5f680f3..1abac2ed7563 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -430,6 +430,10 @@ struct efi_runtime_services {
 	EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  \
 		 0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 
+#define SMBIOS3_TABLE_GUID \
+	EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c, \
+		 0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
+
 #define EFI_LOAD_FILE_PROTOCOL_GUID \
 	EFI_GUID(0x56ec3091, 0x954c, 0x11d2, \
 		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 4ae4e4a7c236..80f38d78d877 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -15,6 +15,8 @@
 #include <smbios.h>
 #include <linux/sizes.h>
 
+const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
+
 enum {
 	TABLE_SIZE	= SZ_4K,
 };
@@ -26,8 +28,10 @@ enum {
  */
 efi_status_t efi_smbios_register(void)
 {
+	const efi_guid_t *guid;
 	ulong addr;
 	efi_status_t ret;
+	void *buf;
 
 	addr = gd_smbios_start();
 	if (!addr) {
@@ -43,8 +47,12 @@ efi_status_t efi_smbios_register(void)
 	log_debug("EFI using SMBIOS tables at %lx\n", addr);
 
 	/* Install SMBIOS information as configuration table */
-	return efi_install_configuration_table(&smbios_guid,
-					       map_sysmem(addr, 0));
+	buf = map_sysmem(addr, 0);
+	guid = !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
+	ret = efi_install_configuration_table(guid, buf);
+	unmap_sysmem(buf);
+
+	return ret;
 }
 
 static int install_smbios_table(void)
-- 
2.42.0.655.g421f12c284-goog

