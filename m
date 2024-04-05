Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99307C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2FE8847C;
	Fri,  5 Apr 2024 10:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RExz5+v0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C06A8847F; Fri,  5 Apr 2024 10:13:09 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958DB87D64
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 79B883F3BA; 
 Fri,  5 Apr 2024 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712304786;
 bh=tr4pf87L+GSTNG47/O+jgTDeWXENM7Tk7GXKwFJCoSg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RExz5+v0by2MbzMa9kY6NtKSRpoZPRWo/jPox/+jjvtku2lQOWlHQmos6dlTwDMEn
 BUaQSJtV2bvnehj2lBFkUl1QJuuoM7mKjr5XkbxXiiQiSIVlupMLK1SZS5Ica95esi
 YVHnqMGagJx6KHz1oBBDadzK5gyE8a61OEw0GrPUdPI9bNxeG2KDn8wDRSGhraWQB5
 VdaeaJh9VlMuBebIsuiiinZNnRrvozDyMITKz4s7UPtlpw/KlwvijeGNSeveFF9zQS
 c6FE7SM1esFe7lcfXVdyO50bWXTFePOQLQ9VpQg/RD6PxHkPAnV3MZNS5MgiaPk1pa
 QjGvHQGTbSr5Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: eliminate duplicate runtime section
 definitions
Date: Fri,  5 Apr 2024 10:12:57 +0200
Message-ID: <20240405081257.9515-1-heinrich.schuchardt@canonical.com>
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

The following symbols are defined in two includes:

* __efi_runtime_start[]
* __efi_runtime_stop[]
* __efi_runtime_rel_start[]
* __efi_runtime_rel_stop[]

Eliminate the definitions in efi_loader.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h        | 3 ---
 lib/efi_loader/efi_memory.c | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7daca0afba..bb51c02817 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -345,9 +345,6 @@ extern const efi_guid_t smbios3_guid;
 extern const efi_guid_t efi_guid_text_input_protocol;
 extern const efi_guid_t efi_guid_text_output_protocol;
 
-extern char __efi_runtime_start[], __efi_runtime_stop[];
-extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
-
 /**
  * struct efi_open_protocol_info_item - open protocol info item
  *
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index edfad2d95a..81f5f98a8a 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -15,6 +15,7 @@
 #include <watchdog.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/sections.h>
 #include <linux/list_sort.h>
 #include <linux/sizes.h>
 
-- 
2.43.0

