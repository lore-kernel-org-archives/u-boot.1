Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE9C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 20:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACDE87CFC;
	Tue,  9 Apr 2024 22:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EesIUUcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB37987DCA; Tue,  9 Apr 2024 22:48:32 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133528796B
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 22:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3B29E3F107; 
 Tue,  9 Apr 2024 20:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712695710;
 bh=SSA9G16/r5CkxWwvbjZSaBuAdKhLU3Ee05gr4IvnqYo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=EesIUUcU6aPP30W83IDy4kduqVxkrDeVrIbA22JftsDFvsYR8HfNb+Q55xfLpj7qd
 xX5zprKn80LqRnFRWcvN+SanmUBvh3gjzJhKHtsHT8P7JTh/OcqTu9P3EsZuTcLNdD
 Ob1H4/CCZB6LQaKkydusOdTn/HWrBr7LCtY5eQIsxmrWU+CPahwZMv9bOWpNrhHZDA
 7CaLbjHKa8vElVUI/7aa1E8O60kbZOjR9vGaw5RSIoeh92EojpIAm8qWwqj3NIZTus
 gr6+5NPkDE+B8zALnOp05TGRX7MOfdPDYltuXWwejLdFAhmhq68ycZXo1eP6CwzDlm
 GlDo8K/Lf/kwA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: 'EFI using ACPI tables at' should be debug
 message
Date: Tue,  9 Apr 2024 22:48:24 +0200
Message-ID: <20240409204824.70582-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The message "EFI using ACPI tables at %lx\n" is only of interest when
debugging. Make it a debug message.

Fixes: 085f8db6b98d ("efi: Use the installed ACPI tables")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bbd2a01c0..67bd7f8ca24 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -41,7 +41,7 @@ efi_status_t efi_acpi_register(void)
 	}
 
 	addr = gd_acpi_start();
-	printf("EFI using ACPI tables at %lx\n", addr);
+	log_debug("EFI using ACPI tables at %lx\n", addr);
 
 	/* And expose them to our EFI payload */
 	return efi_install_configuration_table(&acpi_guid,
-- 
2.43.0

