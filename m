Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3749CDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA70788DCC;
	Wed, 18 Sep 2024 23:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LsJbh6Nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306DC88FAC; Wed, 18 Sep 2024 23:37:37 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2559688DC1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 17B1441B65; 
 Wed, 18 Sep 2024 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726695454;
 bh=gqgoC6WIkKfTpSLNKSykF59sm3VsA6Xikz+tdo9fjF0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LsJbh6NbVf+VNIll0iuA33Q6Ic/PJqm2+YYhWE109JRll4+NmadJzyefz9EB92Im6
 RSKrUtTSz15e8TIUZwWptnwNlZaktYADKUl24k8l4ROsPfJhuPIzocGNtBd0BObUZY
 Ee0BTME7UVXOyYBRG8MiNYRNJvs6M+fffKp62caEtiejmN7gLluFVHy2esMPojdOhc
 zA5RYSYeUpx7fS+i4Jt0Wvvs/Kv8rzJunY1/sFT4XJfgFV9NBIG57dBodN9EITbl7M
 b57SL21nBYvAj3wJ6kwidGVKL4hUKO0nXTTiK8XGzsKeV66ZYWGX9PWW7spycmIYyr
 9g7SfXtfe2kVA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix some function descriptions
Date: Wed, 18 Sep 2024 23:37:28 +0200
Message-ID: <20240918213728.19657-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* The function name must be provided in the description.
* The function name must match the name used in the description.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
@Tom
This is one of the fixes needed before we can update scripts/kernel-doc.
---
 lib/efi_loader/efi_console.c           | 2 +-
 lib/efi_loader/efi_file.c              | 2 +-
 lib/efi_loader/efi_rng.c               | 2 +-
 lib/efi_loader/efi_unicode_collation.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index cea50c748aa..9d9f786a6db 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -100,7 +100,7 @@ static int term_get_char(s32 *c)
 }
 
 /**
- * Receive and parse a reply from the terminal.
+ * term_read_reply() - receive and parse a reply from the terminal
  *
  * @n:		array of return values
  * @num:	number of return values expected
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 222001d6a3b..c92d8ccf004 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -295,7 +295,7 @@ out:
 }
 
 /**
- * efi_file_open_()
+ * efi_file_open() - open file synchronously
  *
  * This function implements the Open service of the File Protocol.
  * See the UEFI spec for details.
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 9bad7ed6931..4734f95eee1 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -91,7 +91,7 @@ back:
 }
 
 /**
- * rng_getrng() - get random value
+ * getrng() - get random value
  *
  * This function implement the GetRng() service of the EFI random number
  * generator protocol. See the UEFI spec for details.
diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
index 627bb9123cf..d48700a352b 100644
--- a/lib/efi_loader/efi_unicode_collation.c
+++ b/lib/efi_loader/efi_unicode_collation.c
@@ -266,7 +266,7 @@ static void EFIAPI efi_fat_to_str(struct efi_unicode_collation_protocol *this,
 }
 
 /**
- * efi_fat_to_str() - convert a utf-16 string to legal characters for a FAT
+ * efi_str_to_fat() - convert a utf-16 string to legal characters for a FAT
  *                    file name in an OEM code page
  *
  * @this:	unicode collation protocol instance
-- 
2.45.2

