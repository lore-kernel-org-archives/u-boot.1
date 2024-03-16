Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D053C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 09:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1460F87F3E;
	Sat, 16 Mar 2024 10:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SB8z6z0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBA3879F3; Sat, 16 Mar 2024 10:37:07 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBAE87A80
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 10:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A8A9D44873; 
 Sat, 16 Mar 2024 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710581819;
 bh=UDQmSaymIcLKWlfyQDybfRUeUKjwBG+5EsgqBFP+BWI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SB8z6z0Cb55xIXD0TfIB7K1lsvNpuIgx54HOkBUWD/UpRNGn4Ig3hK2zgnlWZUFdS
 SvHNT6lXL3bgwv4LmpHskT9L56JpiZk8eE1Wp/7UEt/6QkBRrsnei+Jn80Uj+G55Pm
 uaITMMZ44lWpYAbG3tAatWTk4DnoL4XybQKmd3XJKYstR3Dpu5wATO3igXgJftN5uX
 Rw8y5gFEjGpLXPTNdaQaFDnHtq7DVv0nAr2Oml7CUVL1TAudajHzlr0z4Ayqq/gIr6
 ZMlEDTQYcgLlRNNsE/s/PJtZbxaHhP001PQR5FbtC9wo5qTwJM+T8pBxjCLTEhIxFC
 IjX4SyuuddAWw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] efi_loader: correct handling of EFI binary return code
Date: Sat, 16 Mar 2024 10:36:42 +0100
Message-ID: <20240316093644.54869-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
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

Running an EFI binary loaded via tftp using the bootefi command results in
showing the usage help.

We should not try to remove protocol interfaces from a NULL handle.

Fixes: 6422820ac3e5 ("efi_loader: split unrelated code from efi_bootmgr.c")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootbin.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 733cc1a61b5..b7910f78fb6 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -125,7 +125,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
 	struct efi_device_path *msg_path;
-	efi_status_t ret, ret2;
+	efi_status_t ret;
 	u16 *load_options;
 
 	if (!bootefi_device_path || !bootefi_image_path) {
@@ -172,11 +172,17 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 	ret = do_bootefi_exec(handle, load_options);
 
 out:
-	ret2 = efi_uninstall_multiple_protocol_interfaces(mem_handle,
-							  &efi_guid_device_path,
-							  file_path, NULL);
+	if (mem_handle) {
+		efi_status_t r;
+
+		r = efi_uninstall_multiple_protocol_interfaces(
+			mem_handle, &efi_guid_device_path, file_path, NULL);
+		if (r != EFI_SUCCESS)
+			log_err("Uninstalling protocol interfaces failed\n");
+	}
 	efi_free_pool(file_path);
-	return (ret != EFI_SUCCESS) ? ret : ret2;
+
+	return ret;
 }
 
 /**
-- 
2.43.0

