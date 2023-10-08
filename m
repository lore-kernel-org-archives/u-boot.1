Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DD1E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA8086DA8;
	Sun,  8 Oct 2023 23:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KFhcoeI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDA486D9C; Sun,  8 Oct 2023 23:36:58 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E795D86CDB
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3526c9c401aso13689845ab.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801013; x=1697405813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=li9MX1Wfz6sA6msxnWEyjZmm2JBbONbNURlo3NQQobo=;
 b=KFhcoeI7arot0CB+hYYX2Nkd1SpormxHSlaXv12RNwNutPJde3h/xX/Y9h5kmz/Hrx
 PjBr5ooX/jDiK0yKkG3kxRMNVFo4DZJuaMcVk9E0RryGltPvtPvBWW4eNC149AZfxPxE
 HnN2OAwKHgf0ZyrORQ+8da3ABXnica8XP7HWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801013; x=1697405813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=li9MX1Wfz6sA6msxnWEyjZmm2JBbONbNURlo3NQQobo=;
 b=YcswkH/PPvLFN6Pvhu8KPniLdOAopD/VNN2dBSXS6bOEWx0E8rSlS87K5TROI4FK2h
 PmzLQNHD1qxeKv2l5w25S5+8WJwrEmtZXA2i7DgA/7kZoYuo+of3tfeZE0lj/R8NoVua
 +UEwll7SVjUQnaLtOvanZz7HxteG575GBy4ic92/3avcCiysQ4yi9PMyR+ZQgk4PKUNo
 ab8KIC2HcZsJWMxxhp7+MIeMf6dDVGZ0G79Q46eHACLYJ41F1hYrUwBT8XGsVO9MU0m+
 8x6wS0oVg4flONM0pCJ9+lqpaF6KsE/qIa0K5T0k0ax2rmEeiNHuXHsvCUD+VbefAEv7
 704g==
X-Gm-Message-State: AOJu0Yy6d0uuMJinGuP0lqzVthTjbGTHxjySBVEF0AjKl+fGYN0d46K6
 VbaO/0QXMUyIWFD3GySpVO1b4nicTsTVK01B6NM=
X-Google-Smtp-Source: AGHT+IEUi+86JORCs9Ita4LkZgLp7iUa9u1m1yL3tAxKIhc9yNnRmlSkgyXO/Z5xZq8vHNnmXVjIjQ==
X-Received: by 2002:a05:6e02:df0:b0:349:8447:241d with SMTP id
 m16-20020a056e020df000b003498447241dmr8090361ilj.9.1696801013509; 
 Sun, 08 Oct 2023 14:36:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/5] efi: Use the correct GUID for the SMBIOS table
Date: Sun,  8 Oct 2023 15:36:43 -0600
Message-ID: <20231008213646.622002-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 48446f654d9b..9ef736853d10 100644
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
 
 	addr = gd->arch.smbios_start;
 	if (!addr) {
@@ -43,8 +47,12 @@ efi_status_t efi_smbios_register(void)
 	log_debug("EFI using SMBIOS tables at %lx\n", addr);
 
 	/* Install SMBIOS information as configuration table */
-	return efi_install_configuration_table(&smbios_guid,
-					       map_sysmem(addr, 0));
+	buf = map_sysmem(addr, 10);
+	guid = !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
+	ret = efi_install_configuration_table(guid, buf);
+	unmap_sysmem(buf);
+
+	return ret;
 }
 
 static int install_smbios_table(void)
-- 
2.42.0.609.gbb76f46606-goog

