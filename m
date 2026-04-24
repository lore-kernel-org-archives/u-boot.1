Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846EAFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD9984479;
	Sat, 25 Apr 2026 20:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Oxv4NoFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAE784401; Sat, 25 Apr 2026 19:01:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2CEC842BF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5AA359F;
 Fri, 24 Apr 2026 10:32:30 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A99F3F7B4;
 Fri, 24 Apr 2026 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051956; bh=SU3t9/b5wqBQManKzNE4+/TWOZ5f/ZdxutQr9S0dqnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oxv4NoFrS5b7JwpqKEpaOwrIkiEu8uxZu9N5Kf8u9poP04YH5im3cc/QmO7emtHnV
 Abs+xVOFNyyQR+zByVpUWU2SC1ljoZE5Gv/MKY+TqfyfNB8nvqizhDqa7HWNswo/WI
 QadKKVLgrK+S3jvB1i+Bw27wf+bbAzNhl46QgZmQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 01/12] efi_loader: add runtime memset helper
Date: Fri, 24 Apr 2026 18:31:40 +0100
Message-Id: <20260424173151.371134-2-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 include/efi_loader.h         |  3 +++
 lib/efi_loader/efi_runtime.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..63944192aeb 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
 /* runtime implementation of memcmp() */
 int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
 
+/* runtime implementation of memset */
+__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n);
+
 /* commonly used helper functions */
 u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
 			     unsigned int index);
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c..d9604399209 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
 	return 0;
 }
 
+/**
+ * efi_memset_runtime() - fill a memory region with a byte value
+ *
+ * At runtime memset() is not available.
+ *
+ * @dest:   pointer to the block of memory to fill.
+ * @c:      value to be set. The value is passed as an int, but the
+ *          function fills the block of memory using the u8 conversion of this value.
+ * @n:      number of bytes to be set to the value.
+ * Return:  dest is returned
+ */
+__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
+{
+	u8 *d = dest;
+
+	for (; n; --n)
+		*d++ = c;
+
+	return dest;
+}
+
 /**
  * efi_update_table_header_crc32() - Update crc32 in table header
  *
-- 
2.34.1

