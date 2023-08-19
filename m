Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7BDEE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7531887041;
	Sat, 19 Aug 2023 23:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mGeU83N6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95AF86F61; Sat, 19 Aug 2023 23:23:31 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C39086C1E
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-790c6d966e0so77185339f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480206; x=1693085006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lc9H0a09U/ZqcnFMePb8++ItEhEtzgnb6YBoq6h9vxA=;
 b=mGeU83N6bZbVShY1OIoPOD7ZWD0PTJ+63US1jvordbtb5Hi7H9t+GPZEeOCOnz2vKS
 6F56EJTtR7Evww5M+kI2SY6DJHtnzE5opoBcBOeyIG8ypaw548sb4BuZNECtR4oN1adP
 8roX6NI4M87SAHWbQ1gSQfSIckPCtQaux2bGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480206; x=1693085006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lc9H0a09U/ZqcnFMePb8++ItEhEtzgnb6YBoq6h9vxA=;
 b=i6sOX11u1P1sRHv/ozNddyY63Bv+xK6v+C/r1zSsyhC+GrrG0/X77jE4OjT/qmAbFz
 hmvca4xGF8zcu3dBH53T6ixlvHrRnK0Yt3fLw8MdiPcWSUUq5icVMxa3bQDwvxD8iJKj
 JgQyzCWCkxe2yChK87nUWvYjBZAXu5lQgUBUODyJYw2U3TYdYbEC52iDRJyXE6CXlHel
 Gw/XYD3r+sbCadNi7jkkbPEncwUKiydIB0vWzbgCfSUXcum1NpyA8wRPDePeF/V1l5Wv
 SxDjUwSZhoN2wA1+AmC633AgOcD35Z4I1tjzfFk3v/yO2Q6VCfMqdt5yc85Wyv+zb1za
 qDIg==
X-Gm-Message-State: AOJu0YxbpMgQJWeZnhzcMkIlznrseWTkuaZyZ0SQlNa96BSBnTk5BC3N
 0/reZDLtVU3BuDL3jle4PZAclkfWOdvvSxXO50Y=
X-Google-Smtp-Source: AGHT+IFtJC59W1TMXLjyUXt39yBMHbTAp5levgUzcIkXcOZzxKrEU34smi4FFSgAVMn9/4Jn9q/1hg==
X-Received: by 2002:a6b:dd16:0:b0:791:8d:91de with SMTP id
 f22-20020a6bdd16000000b00791008d91demr4105790ioc.13.1692480206647; 
 Sat, 19 Aug 2023 14:23:26 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 11/19] efi: x86: Correct the condition for installing ACPI
 tables
Date: Sat, 19 Aug 2023 15:22:49 -0600
Message-ID: <20230819212309.1094440-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

It is not always the case that U-Boot builds the ACPI tables itself. For
example, when booting from coreboot, the ACPI tables are built by
coreboot.

Correct the Makefile condition so that U-Boot can pass on tables built
by a previous firmware stage.

Tidy up the installation-condition code while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 lib/efi_loader/Makefile    |  2 +-
 lib/efi_loader/efi_setup.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 1a8c8d7cab5c..0eb748ff1a59 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
 obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
-obj-$(CONFIG_GENERATE_ACPI_TABLE) += efi_acpi.o
+obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 58d4e1340233..ad719afd6328 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 #endif
-#ifdef CONFIG_GENERATE_ACPI_TABLE
-	ret = efi_acpi_register();
-	if (ret != EFI_SUCCESS)
-		goto out;
-#endif
+	if (IS_ENABLED(CONFIG_ACPI)) {
+		ret = efi_acpi_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
 	ret = efi_smbios_register();
 	if (ret != EFI_SUCCESS)
-- 
2.42.0.rc1.204.g551eb34607-goog

