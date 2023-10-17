Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B7CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 17:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A27586BD6;
	Tue, 17 Oct 2023 19:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EkrdwFzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA81786ED1; Tue, 17 Oct 2023 19:52:00 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C995F86940
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1127E3F6DB; 
 Tue, 17 Oct 2023 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697565116;
 bh=km6otV9jD9/RIaE8k/5O63puZYgie0tXkjTCUVYQi4Q=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=EkrdwFzUF0bmUWEG+KC6DPQpQtdFzO1xq0zz0Yy6YDdf6IZMbjCIPEKpA8umuXP9J
 qGm5xzUFwoUP5HroW5voXxygW+fDnbmU5tZ/A9GmpNf4sQ3seoKxZPX2nCqe8fh4A0
 gMyaUygajPGJpEbNa3uFhzSLcAK7rcDMDr0bKd+2MhAxGXG6P8iqsD8MZieEgb3cBW
 aKsB0ZcK4j7cafjv8xAB4TyeUSLJuss3XFYr4GaUK9PAoyQ7RArpfJj5FYiFvmZxte
 LcNlwsXj1d6/0pG5NpcYGbC3a+gEyFUYseSxCWdUUR1pWw5LNLJvrILI/+5cJz7L9h
 7REG7OZIuFR5w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_loader: fix efi_bootmgr_enumerate_boot_option
Date: Tue, 17 Oct 2023 19:51:48 +0200
Message-Id: <20231017175148.75215-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Only auto-generate boot options for removable media.

For testing the different handling of removable and non-removable devices
an emulated USB device can be used:

    make qemu-riscv64_smode_defconfig; make
    qemu-system-riscv64 -M virt -kernel u-boot.bin -nographic \
    -device qemu-xhci -drive if=none,file=disk.img,format=raw,id=USB1 \
    -device usb-storage,drive=USB1,removable=on

Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
Fixes: 339b527bd450 ("Move bootorder and bootoption apis to lib")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootmgr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..96d45157b3 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -346,7 +346,7 @@ error:
 }
 
 /**
- * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
+ * efi_bootmgr_enumerate_boot_option() - boot options for removable boot media
  *
  * @opt:		pointer to the media boot option structure
  * @volume_handles:	pointer to the efi handles
@@ -370,6 +370,9 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		struct efi_device_path *device_path;
 		struct efi_device_path *short_dp;
 
+		if (!efi_disk_is_removable(volume_handles[i]))
+			continue;
+
 		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
@@ -674,7 +677,10 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
+	/*
+	 * Enumerate all removable devices supporting the
+	 * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
+	 */
 	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
 	if (ret != EFI_SUCCESS)
 		goto out;
-- 
2.40.1

