Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF71CFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D835584488;
	Sat, 25 Apr 2026 20:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="i/WKAm+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FBB842BF; Sat, 25 Apr 2026 19:01:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B9983842E7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D2A335A5;
 Fri, 24 Apr 2026 10:32:39 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1969E3F7B4;
 Fri, 24 Apr 2026 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051964; bh=0a15qjw+44DBsHYjlJiF9rDHaoet15SkszhUkAL89RI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i/WKAm+Xiyb+uoYr0SB16tQV0/xEHr7myiz8Dtwd1Mxsv1i/OLZr65pWTyVeSgJvT
 fbBym0gc+XuSDz78Zl79cvePs7iHuijdfYBfHDtrIJfJ4ZaNoVd/wALrW3CXN7Fz2V
 iCU+CiUZE2pbBE7OIAwwLqFZodfTQs8bfZ/fS8Vw=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 05/12] efi_loader: move runtime GetVariable() helpers to
 efi_variable.c
Date: Fri, 24 Apr 2026 18:31:44 +0100
Message-Id: <20260424173151.371134-6-harsimransingh.tungal@arm.com>
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

Consolidate runtime GetVariable helpers to avoid duplicates

The functions efi_get_variable_runtime() and
efi_get_next_variable_name_runtime() were implemented in
efi_variable_tee.c as part of the FF-A runtime variable handling work.
However, default implementations for these same runtime helpers also
exist in efi_var_common.c. This results in duplicate symbol definitions.
To resolve the conflict and centralize the runtime API, this patch moves
the default implementations of the two runtime GetVariable() helpers
from efi_var_common.c to efi_variable.c. This ensures that:

 - only a single definition of each runtime helper exists,
 - backend-specific implementations can override these cleanly,
 - the EFI runtime variable service table continues to reference the
   correct functions.

No functional changes are introduced; this is a structural cleanup to
avoid build-time conflicts and consolidate EFI runtime variable support
in the appropriate file.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_var_common.c | 24 ------------------------
 lib/efi_loader/efi_variable.c   | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index d63c2d1b1cd..7cbf098c64a 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -173,30 +173,6 @@ efi_status_t EFIAPI efi_query_variable_info(
 	return EFI_EXIT(ret);
 }
 
-efi_status_t __efi_runtime EFIAPI
-efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
-			 u32 *attributes, efi_uintn_t *data_size, void *data)
-{
-	efi_status_t ret;
-
-	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
-				   data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
-
-	/* Remove EFI_VARIABLE_READ_ONLY flag */
-	if (attributes)
-		*attributes &= EFI_VARIABLE_MASK;
-
-	return ret;
-}
-
-efi_status_t __efi_runtime EFIAPI
-efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
-				   u16 *variable_name, efi_guid_t *guid)
-{
-	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
-					      guid, EFI_VARIABLE_RUNTIME_ACCESS);
-}
-
 /**
  * efi_set_secure_state - modify secure boot state variables
  * @secure_boot:	value of SecureBoot
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 9923936c1b5..f2e0e1ad4e2 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -579,6 +579,30 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	return EFI_SUCCESS;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
+			 u32 *attributes, efi_uintn_t *data_size, void *data)
+{
+	efi_status_t ret;
+
+	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
+				   data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
+
+	/* Remove EFI_VARIABLE_READ_ONLY flag */
+	if (attributes)
+		*attributes &= EFI_VARIABLE_MASK;
+
+	return ret;
+}
+
+efi_status_t __efi_runtime EFIAPI
+efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
+				   u16 *variable_name, efi_guid_t *guid)
+{
+	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
+					      guid, EFI_VARIABLE_RUNTIME_ACCESS);
+}
+
 /**
  * efi_variables_boot_exit_notify() - notify ExitBootServices() is called
  */
-- 
2.34.1

