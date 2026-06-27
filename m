Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD418C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24758467F;
	Sat, 27 Jun 2026 19:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="E1rkLn7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0E98460E; Sat, 27 Jun 2026 16:44:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1DD7D83FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BB71F60;
 Sat, 27 Jun 2026 07:44:29 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.95.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647CC3F905;
 Sat, 27 Jun 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782571474; bh=PNTHyJibDFNMKChh1C4AUbTnYmz0FqUGSDyUpe4k6qI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E1rkLn7wXeedL4P+zZ2Z6u4VLY46WzvhIy0weE7/6B/JEOBaC7RZtLRvaPrGto8Xe
 VWTqvRv6J95rwiAgs3oE0EzqgPaHPPfTbiNcsfnTsBg8XVuOEd5Jw0n6g2IzNxu1uH
 q8hxYSiUpeHixA7sL/ta122+1c+5t8rdKFatllfw=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v3 01/10] efi_loader: add runtime memset helper
Date: Sat, 27 Jun 2026 15:44:12 +0100
Message-Id: <20260627144421.2067410-2-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Jun 2026 19:41:26 +0200
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

Add efi_memset_runtime() for EFI runtime paths

This keeps buffer initialization in runtime-resident code after
ExitBootServices() and avoids relying on non-runtime helpers.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 include/efi_loader.h         |  3 +++
 lib/efi_loader/efi_runtime.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..9dfea1fd7de 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
 /* runtime implementation of memcmp() */
 int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
 
+/* runtime implementation of memset() */
+void *efi_memset_runtime(void *dest, int c, size_t n);
+
 /* commonly used helper functions */
 u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
 			     unsigned int index);
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c..c0182931c42 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -233,6 +233,26 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
 	return 0;
 }
 
+/**
+ * efi_memset_runtime() - fill memory area
+ *
+ * At runtime memset() is not available.
+ *
+ * @dest:	destination buffer
+ * @c:		byte value used to fill destination buffer
+ * @n:		number of bytes to set
+ * Return:	pointer to destination buffer
+ */
+__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
+{
+	u8 *d = dest;
+
+	for (; n; --n)
+		*d++ = (u8)c;
+
+	return dest;
+}
+
 /**
  * efi_update_table_header_crc32() - Update crc32 in table header
  *
-- 
2.34.1

