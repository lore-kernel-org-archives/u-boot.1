Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF906CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D8B846B4;
	Thu, 14 May 2026 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Y5VKeVQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C4983FB0; Thu, 14 May 2026 14:50:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AB67284686
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6096F244C;
 Thu, 14 May 2026 05:49:57 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8BAB3F7B4;
 Thu, 14 May 2026 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778763002; bh=NLFNIga22eJuq/oz3/MzCtHYhsyoFNJtc650W1iApYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y5VKeVQy8LUVrqbDMZjLqC/qHTp6xWIM8bxSICvl36VswtPR8PQ3ayVWnALPdJFMX
 WpH3/8CYNBD45yi62OQ6I1cEGxBekSYmILtvUlVRMI94V1RMsyFqgVD/3Aa9FR7guW
 NMJBSZA7v4DhsdGEZzFe49OJ0XAcBDe3JKUgK5N8=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 06/11] efi_loader: move runtime variable read helpers to
 efi_variable.c
Date: Thu, 14 May 2026 13:49:19 +0100
Message-Id: <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Relocate the generic runtime variable read helpers from
efi_var_common.c to efi_variable.c.

efi_var_common.c is always built, while efi_variable.c is only built
when CONFIG_EFI_MM_COMM_TEE is unset. Earlier patches in this series
add TEE/FF-A-specific runtime read helpers in efi_variable_tee.c.
Leaving the generic definitions in efi_var_common.c would therefore
cause a symbol clash in EFI_MM_COMM_TEE builds.

Move efi_get_variable_runtime() and
efi_get_next_variable_name_runtime() into efi_variable.c so the
non-TEE backend keeps the generic memory-backed implementations,
while the TEE/FF-A backend continues to provide its own runtime read
helpers in efi_variable_tee.c.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Ilias, Simon:

- Reword commit message to include relocation of generic non-TEE
  helpers and broaden the wording to cover both runtime read helpers

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

