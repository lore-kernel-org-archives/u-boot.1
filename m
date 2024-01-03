Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A667C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5959A87987;
	Wed,  3 Jan 2024 09:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="faxzJfgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC0B386FD8; Wed,  3 Jan 2024 09:07:37 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C09DD87963
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2976542FD0; 
 Wed,  3 Jan 2024 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704269254;
 bh=id+WjoNJO/6hzkA0M8M0gemeLn4bN8A19i/uhdPlUns=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=faxzJfgcnUg2Nq2nCSkxvRDaKL4cDjZD6yZVT3mfzCHWqeanrcHwES1Izx29h+Mhi
 x+CzGqR4srUx0ogaBHImGvm7y5bbajIDQ3XgON3X3VFhgkTICgPY2f5adssTLuEJ60
 0Rqi1ymdmD8VE/NIR0Rm8rO9LPpNUMnN/DrWo7m4xQA3vIRr7nLoP/Ex+hRxobU0Mr
 gXn/54upe44GAE9no1kSQ/3uuFiqT08QkW3spYG238GS9XW0d+tftNjHlNFAbbm4nN
 yirsBfEcxRwwpWLfKj2im8nOmdjuc/LFPcZZPeqVQ7ZF39VXmB4nR88IbrSux9jHAn
 xD0lEJxUFupuw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/2] smbios: smbios.h should not import ofnode.h
Date: Wed,  3 Jan 2024 09:07:20 +0100
Message-ID: <20240103080721.22292-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103080721.22292-1-heinrich.schuchardt@canonical.com>
References: <20240103080721.22292-1-heinrich.schuchardt@canonical.com>
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

The smbios.h include does not use any definitions from ofnode.h.
So don't include it.

As DECLARE_GLOBAL_DATA_PTR is no longer defined via dm/of.h we need to
add it to efi_smbios.c.

Add now missing includes to smbios-parser.c.

Remove a superfluous check comparing the sizes of the SMBIOS 2.1 and SMBIOS
3.0 anchors.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
v2:
	new patch
---
 include/smbios.h            | 6 +-----
 lib/efi_loader/efi_smbios.c | 3 +++
 lib/smbios-parser.c         | 3 +++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index 49de32fec2..b507b9d9d7 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -8,7 +8,7 @@
 #ifndef _SMBIOS_H_
 #define _SMBIOS_H_
 
-#include <dm/ofnode.h>
+#include <linux/types.h>
 
 /* SMBIOS spec version implemented */
 #define SMBIOS_MAJOR_VER	3
@@ -80,10 +80,6 @@ struct __packed smbios3_entry {
 	u64 struct_table_address;
 };
 
-/* These two structures should use the same amount of 16-byte-aligned space */
-static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
-	      ALIGN(16, sizeof(struct smbios3_entry)));
-
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index eb6d2ba43c..b2ec1f7919 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -13,6 +13,9 @@
 #include <mapmem.h>
 #include <smbios.h>
 #include <linux/sizes.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
 
diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index b578c30840..b041592152 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -5,7 +5,10 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <errno.h>
 #include <smbios.h>
+#include <string.h>
+#include <linux/kernel.h>
 
 static inline int verify_checksum(const struct smbios_entry *e)
 {
-- 
2.43.0

