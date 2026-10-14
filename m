Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DFCC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C623B81080;
	Wed, 14 Oct 2026 20:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjRVBkb8KhYa; Wed, 14 Oct 2026 20:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADC5F81066
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008205;
	b=YYYQfTJ5XFBNP3Bf+8NatBj5ImUBZl6X0n7V3YKiP6aAXvjyItFtA8nVUCcAbEUwE+l8
	 lt/18XYlqU2mgTvSJmOZcWAG/WhHpNzBQoSQ9YpbRX+CNO63bi2YiiBtGA3DK1vKg7BBb
	 wKiwz+xWOmxz/PZ+kKf/IrOn5NYmZAXlfTdbxLI8vK74dF39xX8lH+FEzcaE238ZPcsIc
	 XIcioCi4k0gUccXvUGkj/nSoAoZgDR8tlGizsjaj6hbb3lu8M9YDk95+3mP1STeENyS53
	 oq8vcRuwQZ1Bc4tqVxqSWJTRnRKkgyUzsiZlJfkOfNe/YQrHOb4Ueh87TxmaT7fonOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hf4I/fg5VH3/g5kl3hiJHAkSClKrqZs3mZ3uT/F9pJ0=;
	b=F4V9ri3JnBnH+bR2oVVdb++jkpNRerVpbllBhvCv+qIKee+Zwsgxa6FqJSP7FUo1kyBe
	 23b8horyg2k4UxAo8UfnTPLZBslismZF8yyRTnpNitGqmVaEb0DrsidgHirowM37cAJv+
	 JQ6ZWL3hn3omNIZIVQWA9sKhfnb5Zzp8z+Pt1+zH79fNk9mhCaf3SfSPiTiNCrAMnxFTg
	 CmbUKBo2vHVkCVzYO+VFU1q2cMv7ufmyeokbcq1MW+XMpQP6s6ZOWGclo12poGQVia+1G
	 KUAb03eNm5Hhlqn3jZ6aQrje7Kkmt/YGigBh5K+/XU4/bozu2NHbTkjuZS7EUAxJ//w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008205;
	bh=Hf4I/fg5VH3/g5kl3hiJHAkSClKrqZs3mZ3uT/F9pJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vb06vy/nAldvgbXWsHCkEj1ShFfQ24JMtZd0I9DSQuDrggnz1u8dzzgWuU0G4Ds0f
	 uumJZJUnCDqq+FwdYYEO9ipMfLERT1vWX5TPFtgedyGloNqz0PNAbLj59kUjSnkM2w
	 ux9RCsb05Rz3fxwpujpqvGPR2CZ3dp4C5KLeTUXh7VhYDBnUVLAWBWbwcIyL1bKt8S
	 I/I/l+puBFndq8GQslKIz+G2ANl0MwgEGoJU4NQibrHLHiLLmipAPHWvwF3avr3oMe
	 O8+wSfKdfUzUTHWbyQIYCCJDfmMdWhbgHaWTaLzYqbp7KXunJnMM6FshQMIXSVRnj6
	 gWPY+NAeGwBkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADC5F81066;
	Wed, 14 Oct 2026 20:03:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6271518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4ED7407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svnGBSv1vxo9 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58ABC407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002198;
 b=roxk+uFK6t9zhf6s5JCmfjTY8uaxnIa9feGijt10ddPQLc+MRI66T/PKNmjgdlTmvdT4
 whQdkhki74NVtIFlZk+X+G4OoMZ0/OyYw89a5XtflLdPPNVc8boeoawCZGB4Xfz7jF84F
 8vMH7M9Jp0UaRhuLolNv9Y3H4QK6NhPGvN8l/kURjTo3ki+lEmL3BqWVBmJ+MHmBZf7wB
 gmTidNnad7hkHvUfyu1rZ+enqCops9fBU281ubebPn31K8bjtYRhkYPg48tyCjpr3J7t6
 NJnHWVXWE9OPSNFuenerED7jMAdDtrWz+OjRaj2xebuR01usLiWQkgGABtTgTCpJgIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002198;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Hf4I/fg5VH3/g5kl3hiJHAkSClKrqZs3mZ3uT/F9pJ0=;
 b=ALCjxbqjJ9mdt9y/nG/yMyx+LjZsm+QMYClCWOGZz2nImXoU9DU2b3ga0PfuzO9oS55W
 /OENvCrR/CcHy3kaAjEUzxMzNE6w5D15HLpkgyEhRx1jHXH9qUXFwLIsc0kvefU6mKVkd
 t8f5zCEJvllkqXBFDdu0n1/hYpasRcUmXbOlOKA7x2Z/xlcepfnkGOmkPDZUDTT3DKwbZ
 ePK5OXTkVgDJxGLyIPKSN4R4Ri72OR6nzxkIfv0GNGoFywL2UX2E4sbf2gMK5tIjfSPmR
 k662CkfiJm8MvzzUQ866ntjdES/z4pCw2G9DR8fWJWn1cF1zWbJwaVL+Inbl0vvdqXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=EffdM0rO; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=EffdM0rO
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58ABC407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D7A152B;
 Wed, 14 Oct 2026 11:23:14 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44C853FB7F;
 Wed, 14 Oct 2026 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002197; bh=khWtXBdxQqOiI9AoVe8ASaQsJ/Q/6eyonPAcjnsTmZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EffdM0rO6XD/ny0Z3cKUR+ws6HPBSwEmSiP2E7jTxz2k2tKM/w/kb1lAWnTOELqRF
 v+0/azmo6mG3rVn20a2yzfEoilzLowYnVm0ADON705zQJa0HEQT8jTaCwvj9JbvPKl
 y1FKDyZWCKR+1Okjc4FLZ9bQf4ddlECL3lbhy20U=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 04/22] arm-ffa: add runtime direct-message support
Date: Wed, 14 Oct 2026 19:22:44 +0100
Message-ID: <ba2180d93d28d35d5a15fca88ea2618beec9f3b8.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the FF-A runtime transport implementation needed after
ExitBootServices() so EFI runtime services can continue to exchange
direct messages with secure partitions. The runtime code keeps resident
FF-A private data, tracks whether the runtime context is ready,
translates FF-A error codes, and exposes ffa_sync_send_receive_runtime()
for FFA_MSG_SEND_DIRECT_REQ/RESP.

Add the ARM_FFA_RT_MODE Kconfig option and build arm-ffa-runtime.c when
FF-A transport and EFI loader support are enabled. Move FF-A errno
translation out of arm-ffa-uclass.c so boot-time and runtime callers use
the same mapping.

Tag the runtime code and data with __efi_runtime and __efi_runtime_data
so they remain available after ExitBootServices(). The runtime
direct-message path uses invoke_ffa_fn_runtime() and rejects requests
until the runtime context has been enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Simon:

- Rename the runtime-context helpers to the ffa_runtime_context_* form
- Fix commit message styling

v2:

Simon:

- Keep the runtime-enabled flag separate from copied boot-time data
- Remove unused global-data plumbing
- Switch to IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
- Fix style issues
---
 drivers/firmware/arm-ffa/Kconfig           |  11 +
 drivers/firmware/arm-ffa/Makefile          |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c | 251 +++++++++++++++++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c  |  35 +--
 include/arm_ffa_runtime.h                  | 132 +++++++++++
 5 files changed, 397 insertions(+), 36 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c

diff --git a/drivers/firmware/arm-ffa/Kconfig b/drivers/firmware/arm-ffa/Kconfig
index 3706a889305..7aaf25fdb58 100644
--- a/drivers/firmware/arm-ffa/Kconfig
+++ b/drivers/firmware/arm-ffa/Kconfig
@@ -18,6 +18,9 @@ config ARM_FFA_TRANSPORT
 	  The FF-A support in U-Boot is based on FF-A specification v1.0 and uses SMC32
 	  calling convention.
 
+	  The FF-A bus also provides a runtime layer to keep a minimal set of FF-A
+	  operations available after ExitBootServices().
+
 	  FF-A specification:
 
 	  https://developer.arm.com/documentation/den0077/a/?lang=en
@@ -41,3 +44,11 @@ config ARM_FFA_TRANSPORT
 	  Secure World (sandbox_ffa.c).
 
 	  For more details about the FF-A support, please refer to doc/arch/arm64.ffa.rst
+
+config ARM_FFA_RT_MODE
+	bool "Enable FF-A runtime support"
+	depends on ARM_FFA_TRANSPORT && EFI_LOADER
+	default y
+	help
+	  Enable the FF-A runtime layer, keeping a minimal set of FF-A
+	  operations available after ExitBootServices().
diff --git a/drivers/firmware/arm-ffa/Makefile b/drivers/firmware/arm-ffa/Makefile
index 318123a7f42..9deb59ba640 100644
--- a/drivers/firmware/arm-ffa/Makefile
+++ b/drivers/firmware/arm-ffa/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+# Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
 #
 # Authors:
 #   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 
 # build the generic FF-A methods
-obj-y += arm-ffa-uclass.o
+obj-y += arm-ffa-uclass.o arm-ffa-runtime.o
 ifeq ($(CONFIG_SANDBOX),y)
 # build the FF-A sandbox emulator and driver
 obj-y += ffa-emul-uclass.o sandbox_ffa.o
diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
new file mode 100644
index 00000000000..d761ec9ee07
--- /dev/null
+++ b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *      Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+ *      Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ */
+
+#include <arm_ffa_runtime.h>
+#include <arm_ffa_priv.h>
+#include <log.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/* Error mapping declarations */
+
+int __ffa_runtime_data ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
+	[NOT_SUPPORTED] = -EOPNOTSUPP,
+	[INVALID_PARAMETERS] = -EINVAL,
+	[NO_MEMORY] = -ENOMEM,
+	[BUSY] = -EBUSY,
+	[INTERRUPTED] = -EINTR,
+	[DENIED] = -EACCES,
+	[RETRY] = -EAGAIN,
+	[ABORTED] = -ECANCELED,
+};
+
+static __ffa_runtime_data struct ffa_priv_runtime ffa_priv_rt = {0};
+static __ffa_runtime_data bool ffa_runtime_enabled;
+
+/* Arm FF-A driver runtime operations */
+static const __ffa_runtime_data struct ffa_bus_ops_runtime ffa_ops_rt = {
+	.sync_send_receive = ffa_msg_send_direct_req_hdlr_runtime,
+};
+
+#define ffa_get_ops_runtime()		(&ffa_ops_rt)
+#define ffa_get_priv_runtime()		(&ffa_priv_rt)
+
+/**
+ * ffa_copy_runtime_priv() - copy runtime data into resident storage
+ * @priv: pointer to the runtime private data
+ *
+ * Copy boot-time runtime data into the resident runtime storage to be used
+ * after ExitBootServices().
+ */
+void ffa_copy_runtime_priv(const struct ffa_priv_runtime *priv)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	if (priv)
+		*priv_rt = *priv;
+}
+
+/**
+ * ffa_runtime_context_enable() - Enable FF-A runtime context
+ *
+ * This function marks the FF-A runtime environment as ready for use by
+ * EFI runtime services. It is called when ExitBootServices() is invoked,
+ * after the FF-A bus device has successfully probed and U-Boot's FF-A
+ * endpoint ID has been discovered and stored in the runtime private data
+ * structure.
+ *
+ * The FF-A runtime flag allows the EFI runtime layer to verify that the
+ * FF-A transport was initialized during the boot phase and that all
+ * runtime-safe FF-A operations may now be used after ExitBootServices().
+ *
+ */
+void ffa_runtime_context_enable(void)
+{
+	ffa_runtime_enabled = true;
+}
+
+/**
+ * ffa_runtime_context_reset() - Reset FF-A runtime resident state
+ *
+ * Clear the resident runtime flag and private data. This is used by the
+ * FF-A unit tests to avoid leaking runtime state across test cases.
+ */
+void ffa_runtime_context_reset(void)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	*priv_rt = (struct ffa_priv_runtime){0};
+	ffa_runtime_enabled = false;
+}
+
+/**
+ * ffa_runtime_context_ready() - Query FF-A runtime readiness
+ *
+ * This helper returns whether the FF-A runtime environment has been
+ * enabled during the boot phase. Runtime FF-A operations must check this
+ * flag before attempting any FF-A access, as the U-Boot driver model
+ * (DM/uclass) is no longer available after ExitBootServices().
+ *
+ * The runtime context becomes enabled when ffa_runtime_context_enable()
+ * is called, typically after the FF-A bus device has probed and the
+ * endpoint ID has been discovered and stored in the runtime private
+ * data structure.
+ *
+ * Return: true if FF-A runtime support is ready, false otherwise.
+ */
+bool __ffa_runtime ffa_runtime_context_ready(void)
+{
+	return ffa_runtime_enabled;
+}
+
+/**
+ * ffa_to_std_errno() - convert FF-A error code to standard error code
+ * @ffa_errno:	Error code returned by the FF-A ABI
+ *
+ * Map the given FF-A error code as specified
+ * by the spec to a u-boot standard error code.
+ *
+ * Return: Standard U-Boot errno for known FF-A errors, or -EINVAL otherwise.
+ */
+int __ffa_runtime ffa_to_std_errno(int ffa_errno)
+{
+	int err_idx = -ffa_errno;
+
+	/* Map the FF-A error code to the standard u-boot error code */
+	if (err_idx > 0 && err_idx < MAX_NUMBER_FFA_ERR)
+		return ffa_to_std_errmap[err_idx];
+	return -EINVAL;
+}
+
+/**
+ * ffa_invoke_msg_send_direct_req() - Invokes FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * @endpoint_id: u-boot endpoint id
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
+ * The response from the secure partition is handled by reading the
+ * FFA_MSG_SEND_DIRECT_RESP arguments.
+ *
+ * The maximum size of the data that can be exchanged is 40 bytes which is
+ * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
+ * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int __ffa_runtime ffa_invoke_msg_send_direct_req(u16 endpoint_id, u16 dst_part_id,
+						 struct ffa_send_direct_data *msg, bool is_smc64)
+{
+	int ffa_errno;
+	u64 req_mode;
+	ffa_value_t ffa_args_rt;
+	ffa_value_t ffa_res_rt;
+
+	if (is_smc64)
+		req_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
+	else
+		req_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
+	efi_memset_runtime(&ffa_args_rt, 0, sizeof(ffa_args_rt));
+	efi_memset_runtime(&ffa_res_rt, 0, sizeof(ffa_res_rt));
+	ffa_args_rt.a0 = req_mode;
+	ffa_args_rt.a1 = PREP_SELF_ENDPOINT_ID(endpoint_id) |
+			 PREP_PART_ENDPOINT_ID(dst_part_id);
+	ffa_args_rt.a2 = 0;
+	ffa_args_rt.a3 = msg->data0;
+	ffa_args_rt.a4 = msg->data1;
+	ffa_args_rt.a5 = msg->data2;
+	ffa_args_rt.a6 = msg->data3;
+	ffa_args_rt.a7 = msg->data4;
+
+	invoke_ffa_fn_runtime(&ffa_args_rt, &ffa_res_rt);
+
+	while (ffa_res_rt.a0 == FFA_SMC_32(FFA_INTERRUPT) ||
+	       ffa_res_rt.a0 == FFA_SMC_64(FFA_INTERRUPT)) {
+		efi_memset_runtime(&ffa_args_rt, 0, sizeof(ffa_args_rt));
+		ffa_args_rt.a0 = (ffa_res_rt.a0 == FFA_SMC_64(FFA_INTERRUPT)) ?
+				  FFA_SMC_64(FFA_RUN) : FFA_SMC_32(FFA_RUN);
+		ffa_args_rt.a1 = ffa_res_rt.a1;
+
+		invoke_ffa_fn_runtime(&ffa_args_rt, &ffa_res_rt);
+	}
+	if (ffa_res_rt.a0 == FFA_SMC_32(FFA_SUCCESS) ||
+	    ffa_res_rt.a0 == FFA_SMC_64(FFA_SUCCESS)) {
+		/* Message sent with no response */
+		return 0;
+	}
+
+	if (ffa_res_rt.a0 == FFA_SMC_32(FFA_MSG_SEND_DIRECT_RESP) ||
+	    ffa_res_rt.a0 == FFA_SMC_64(FFA_MSG_SEND_DIRECT_RESP)) {
+		/* Message sent with response extract the return data */
+		msg->data0 = ffa_res_rt.a3;
+		msg->data1 = ffa_res_rt.a4;
+		msg->data2 = ffa_res_rt.a5;
+		msg->data3 = ffa_res_rt.a6;
+		msg->data4 = ffa_res_rt.a7;
+		return 0;
+	}
+
+	ffa_errno = ffa_res_rt.a2;
+	return ffa_to_std_errno(ffa_errno);
+}
+
+/**
+ * ffa_msg_send_direct_req_hdlr_runtime() - Runtime implementation of
+ * FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_msg_send_direct_req_hdlr_runtime(u16 dst_part_id,
+						       struct ffa_send_direct_data *msg,
+						       bool is_smc64)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	return ffa_invoke_msg_send_direct_req(priv_rt->id, dst_part_id, msg, is_smc64);
+}
+
+/**
+ * ffa_sync_send_receive_runtime() - Runtime implementation of
+ *                              ffa_sync_send_receive()
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * Please see ffa_msg_send_direct_req_hdlr_runtime() description for more details.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_sync_send_receive_runtime(u16 dst_part_id,
+						struct ffa_send_direct_data *msg,
+						bool is_smc64)
+{
+	const struct ffa_bus_ops_runtime *ops_rt = ffa_get_ops_runtime();
+
+	if (!ffa_runtime_context_ready())
+		return -EPERM;
+
+	if (!ops_rt->sync_send_receive)
+		return -ENOSYS;
+
+	return ops_rt->sync_send_receive(dst_part_id, msg, is_smc64);
+}
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index eb159dbfade..13e22a1b7f7 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -7,6 +7,7 @@
  */
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
+#include <arm_ffa_runtime.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
@@ -18,19 +19,6 @@
 #include <linux/errno.h>
 #include <linux/sizes.h>
 
-/* Error mapping declarations */
-
-int ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
-	[NOT_SUPPORTED] = -EOPNOTSUPP,
-	[INVALID_PARAMETERS] = -EINVAL,
-	[NO_MEMORY] = -ENOMEM,
-	[BUSY] = -EBUSY,
-	[INTERRUPTED] = -EINTR,
-	[DENIED] = -EACCES,
-	[RETRY] = -EAGAIN,
-	[ABORTED] = -ECANCELED,
-};
-
 static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 	[FFA_ID_TO_ERRMAP_ID(FFA_VERSION)] = {
 		{
@@ -94,27 +82,6 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 	},
 };
 
-/**
- * ffa_to_std_errno() - convert FF-A error code to standard error code
- * @ffa_errno:	Error code returned by the FF-A ABI
- *
- * Map the given FF-A error code as specified
- * by the spec to a u-boot standard error code.
- *
- * Return:
- *
- * The standard error code on success. . Otherwise, failure
- */
-static int ffa_to_std_errno(int ffa_errno)
-{
-	int err_idx = -ffa_errno;
-
-	/* Map the FF-A error code to the standard u-boot error code */
-	if (err_idx > 0 && err_idx < MAX_NUMBER_FFA_ERR)
-		return ffa_to_std_errmap[err_idx];
-	return -EINVAL;
-}
-
 /**
  * ffa_print_error_log() - print the error log corresponding to the selected FF-A ABI
  * @ffa_id:	FF-A ABI ID
diff --git a/include/arm_ffa_runtime.h b/include/arm_ffa_runtime.h
index 66096db3d24..77b528745e8 100644
--- a/include/arm_ffa_runtime.h
+++ b/include/arm_ffa_runtime.h
@@ -12,6 +12,7 @@
 
 #include <linux/types.h>
 #include <arm_ffa.h>
+#include <arm_ffa_priv.h>
 #include <efi_loader.h>
 
 /**
@@ -38,4 +39,135 @@
  */
 void __ffa_runtime invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res);
 
+/**
+ * struct ffa_bus_ops_runtime - Operations for FF-A runtime
+ * @sync_send_receive:	callback for the FFA_MSG_SEND_DIRECT_REQ
+ *
+ * The data structure providing all the runtime operations supported by the driver.
+ * This structure is an EFI runtime resident.
+ */
+struct ffa_bus_ops_runtime {
+	int (*sync_send_receive)(u16 dst_part_id, struct ffa_send_direct_data *msg,
+				 bool is_smc64);
+};
+
+/**
+ * ffa_runtime_context_enable() - Enable FF-A runtime context
+ *
+ * This function marks the FF-A runtime environment as ready for use by
+ * EFI runtime services. It is called when ExitBootServices() is invoked,
+ * after the FF-A bus device has successfully probed and U-Boot's FF-A
+ * endpoint ID has been discovered and stored in the runtime private data
+ * structure.
+ *
+ * The FF-A runtime flag allows the EFI runtime layer to verify that the
+ * FF-A transport was initialized during the boot phase and that all
+ * runtime-safe FF-A operations may now be used after ExitBootServices().
+ *
+ */
+void ffa_runtime_context_enable(void);
+
+/**
+ * ffa_runtime_context_reset() - Reset FF-A runtime resident state
+ *
+ * Clear the resident runtime flag and private data. This is used by the
+ * FF-A unit tests to avoid leaking runtime state across test cases.
+ */
+void ffa_runtime_context_reset(void);
+
+/**
+ * ffa_copy_runtime_priv() - copy runtime data into resident storage
+ * @priv: pointer to the runtime private data
+ *
+ * Copy boot-time runtime data into the resident runtime storage to be used
+ * after ExitBootServices().
+ */
+void ffa_copy_runtime_priv(const struct ffa_priv_runtime *priv);
+
+/**
+ * ffa_runtime_context_ready() - Query FF-A runtime readiness
+ *
+ * This helper returns whether the FF-A runtime environment has been
+ * enabled during the boot phase. Runtime FF-A operations must check this
+ * flag before attempting any FF-A access, as the U-Boot driver model
+ * (DM/uclass) is no longer available after ExitBootServices().
+ *
+ * The runtime context becomes enabled when ffa_runtime_context_enable()
+ * is called, typically after the FF-A bus device has probed and the
+ * endpoint ID has been discovered and stored in the runtime private
+ * data structure.
+ *
+ * Return: true if FF-A runtime support is ready, false otherwise.
+ */
+bool __ffa_runtime ffa_runtime_context_ready(void);
+
+/**
+ * ffa_to_std_errno() - convert FF-A error code to standard error code
+ * @ffa_errno:	Error code returned by the FF-A ABI
+ *
+ * Map the given FF-A error code as specified
+ * by the spec to a u-boot standard error code.
+ *
+ * Return: Standard U-Boot errno for known FF-A errors, or -EINVAL otherwise.
+ */
+int __ffa_runtime ffa_to_std_errno(int ffa_errno);
+
+/**
+ * ffa_sync_send_receive_runtime() - Runtime implementation of
+ *                              ffa_sync_send_receive()
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * Please see ffa_msg_send_direct_req_hdlr_runtime() description for more details.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int __ffa_runtime ffa_sync_send_receive_runtime(u16 dst_part_id,
+						struct ffa_send_direct_data *msg,
+						bool is_smc64);
+
+/**
+ * ffa_invoke_msg_send_direct_req() - Invokes FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * @endpoint_id: u-boot endpoint id
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
+ * The response from the secure partition is handled by reading the
+ * FFA_MSG_SEND_DIRECT_RESP arguments.
+ *
+ * The maximum size of the data that can be exchanged is 40 bytes which is
+ * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
+ * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, error on failure
+ */
+int __ffa_runtime ffa_invoke_msg_send_direct_req(u16 endpoint_id, u16 dst_part_id,
+						 struct ffa_send_direct_data *msg,
+						 bool is_smc64);
+
+/**
+ * ffa_msg_send_direct_req_hdlr_runtime() - Runtime implementation of
+ * FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_msg_send_direct_req_hdlr_runtime(u16 dst_part_id,
+						       struct ffa_send_direct_data *msg,
+						       bool is_smc64);
+
 #endif
-- 
2.43.0

