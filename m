Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA70C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8717876D7;
	Wed, 27 Dec 2023 08:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IbKddNxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C59876D7; Wed, 27 Dec 2023 08:40:53 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451EC87873
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d5095834aso30339685e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662850; x=1704267650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54M6kbPyUXaR2M0fi/x+25HBJtdYiz2b4A/JPfLkjvQ=;
 b=IbKddNxsdzK08jBOiVVsrdceHrneP2SYF4kFR0TqQqvKKQrqVtIyrPY7AQ7XdqNOcD
 Cyjyulxpm3CP5VRIwmawXFe/YLOTDmtOHPPqAsVbwy+gCrVL5/PyW5Dxc03OlAKBq1gq
 bP6stq/8vJK2dkU49uMVHzIsrAmNOQZceHCMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662850; x=1704267650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54M6kbPyUXaR2M0fi/x+25HBJtdYiz2b4A/JPfLkjvQ=;
 b=aOV05b7v570U6N63YV+zjfg1GztcoLN2V84lMennGJsiSDwTkWQtn8SyZ7wVZroOqb
 aN0yCsjrk+FrJB+E5JCpKihEl3iMqb0/T+GH5xfnawDfL6UFQmAJjY5nsxAV60Bjsewg
 XPur0VOsbasofXCROE9ShuRV2O3HEXW7+4Rx6LrIE/XlyBDLWXPo6cu5PUAFbP5KmpWP
 SfwXVl8xv0I310L19Q/rE8ZluVe2NQjzawJBD6kTsQHaPbLTwqBcutjag801RhmxKGHC
 hb6D9tnZAh13ATCiMHrVrNCY0F9yBn/z1VtSzOp9g9GKA10eProfevxbBYF9Ck67OJ9R
 FV9g==
X-Gm-Message-State: AOJu0YzSDq6Hbt9Fvas0ZxY/oSCrGANHnntpWvSoo3jERC9ZaVqFv++o
 bED8Ey7z4Z8BzMXsUAULhG0bsNBvdR4lSOdxfl0ZnAeGOH88
X-Google-Smtp-Source: AGHT+IGcfaA8BjDp3ZMIAtHhbyU2R/LeH0tFOrEoKQbfIQwmkSfLNxOmszKwWWp6i3VGpPUiSD51+Q==
X-Received: by 2002:a05:600c:a081:b0:40d:4836:dbf8 with SMTP id
 jh1-20020a05600ca08100b0040d4836dbf8mr2401696wmb.375.1703662850247; 
 Tue, 26 Dec 2023 23:40:50 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 6/7] efi: Use the correct GUID for the SMBIOS table
Date: Wed, 27 Dec 2023 07:40:23 +0000
Message-Id: <20231227074025.2178825-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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

