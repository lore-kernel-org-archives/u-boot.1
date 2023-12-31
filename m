Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99217C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D287878DA;
	Sun, 31 Dec 2023 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mkaps09u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511078783C; Sun, 31 Dec 2023 16:26:18 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF4D8787B
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7bb99f77f97so4543939f.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036374; x=1704641174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJzHuzcy6s1goDLC6rqadstqZlWiRG0ZFT5J13+V7J8=;
 b=Mkaps09uldCb47NjiPkIoKHqlwPXHJ2fWpp6BlUvaXhdU/it1bKni3twmgq7eYCllf
 QykdZD5ePvZm05uUq+EWIDagIW19GnkRX5PHRCWld9ePBvMfPfzd4HJfsrtFNyteBgKc
 mwo/U89uvgjhp/TDAczqoOTkypkOXxf9vB9Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036374; x=1704641174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJzHuzcy6s1goDLC6rqadstqZlWiRG0ZFT5J13+V7J8=;
 b=vX1G5nlS6haejBW79MHfxGd4B3TV8j918spWYi6GXBXovV4SV+iGyshP4Wrt/9Chgq
 saKRKE94/zOQdZO1XF3czpCNcNOJWvDMK3FvzsdwTWCzy1zyTHflEJ5NzHF/mdx+87ZF
 5EqJFwMf5+oxBmbHuFwmKOBmRjZkGmec5jojOWb8t/zRBt8cBMd2na3CopUyRWEmgJU5
 JA98XxAo8oN0H1Pbj6PnjqC9ZmK79q89oq9XT5cPUNxM5Z1sK+xRKPNvbjky7N4rJ4bT
 AH7D4JSeNJ2LLTecYSLHKyYmemOeC9OuMO16Ooy0Icj73upbjve0g8/qnNvec8o6hs1j
 r5cQ==
X-Gm-Message-State: AOJu0YxyiEbz5F0NzNagfw3dp5at0ACVSuK+tEQ12TZ7vdK4Vdm0mZEW
 gCLeK56V+rgWVPOXaDNJkDdm4D1UMaFu8NhUQiIo+PfJ1rLK
X-Google-Smtp-Source: AGHT+IE+/S0mgbcMR+tZu1IQDGpz2ecpNxu38Tpuf5MgNcyzohS0jq/QcB/0EgpmCun6i9jXog1EIQ==
X-Received: by 2002:a6b:ea0b:0:b0:7ba:fa7c:7e9 with SMTP id
 m11-20020a6bea0b000000b007bafa7c07e9mr5506005ioc.17.1704036374069; 
 Sun, 31 Dec 2023 07:26:14 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 06/12] efi: Use the correct GUID for the SMBIOS table
Date: Sun, 31 Dec 2023 08:25:49 -0700
Message-Id: <20231231152555.464874-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add a note about why unmap_system() is called

 include/efi_api.h           |  4 ++++
 lib/efi_loader/efi_smbios.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index 0e92cb8a7f6..ab40b1b5ddf 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -433,6 +433,10 @@ struct efi_runtime_services {
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
index 49adc87e45a..5cbce6dc4eb 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -14,6 +14,8 @@
 #include <smbios.h>
 #include <linux/sizes.h>
 
+const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
+
 enum {
 	TABLE_SIZE	= SZ_4K,
 };
@@ -25,8 +27,10 @@ enum {
  */
 efi_status_t efi_smbios_register(void)
 {
+	const efi_guid_t *guid;
 	ulong addr;
 	efi_status_t ret;
+	void *buf;
 
 	addr = gd_smbios_start();
 	if (!addr) {
@@ -42,8 +46,12 @@ efi_status_t efi_smbios_register(void)
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
2.34.1

