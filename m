Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84731CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEE8846D5;
	Thu, 14 May 2026 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LIH3gJG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DB284683; Thu, 14 May 2026 14:50:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 58D988467C
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC99244C;
 Thu, 14 May 2026 05:50:06 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A9D3F7B4;
 Thu, 14 May 2026 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778763011; bh=Mh9Ilq7MBJSxQSJpyR9oHGUGPJZijJMrXDRlGwR9MZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LIH3gJG6t9zOEVuQ5U3/y1S9IUppipsAlfYbBphYdufln1gEB/LNIY3yt3LspqLLx
 ZJl36vB7+v1lFaEC0ZR+XgFVJAZR9zOOd9JARSEn7c60tsrvsmu+vWszSn49uqWpA3
 6RqnG2PYdoUGRzZuixk5hJS1H23KImTXJfYVmXiI=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 10/11] doc: arm64: document FF-A runtime path for EFI
 variables
Date: Thu, 14 May 2026 13:49:23 +0100
Message-Id: <20260514124924.1804332-11-harsimransingh.tungal@arm.com>
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

The arm64 FF-A documentation still said EFI runtime support was a
future development, so readers had no description of the current FF-A
runtime transport or how EFI runtime variable services use it.

Document the FF-A runtime transport, the shared MM communication path,
and the EFI runtime variable flow on arm64. Also clarify that the
armffa command is boot-time only and point readers to the architecture
documentation for EFI runtime variable services over FF-A.

Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Simon:

- Normalize `Secure world` capitalization
- Drop low-level cache-maintenance detail
- Remove internal helper names from the public flow
- Refresh `doc/usage/cmd/armffa.rst` to match final wording

 doc/arch/arm64.ffa.rst   | 86 ++++++++++++++++++++++++++++++++++++----
 doc/usage/cmd/armffa.rst | 11 +++++
 2 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
index f966f8ba6af..e9a5375ce24 100644
--- a/doc/arch/arm64.ffa.rst
+++ b/doc/arch/arm64.ffa.rst
@@ -15,10 +15,10 @@ application in S-EL0, or a Trusted OS in S-EL1.
 The U-Boot FF-A support (the bus) implements the interfaces to communicate
 with partitions in the Secure world aka Secure partitions (SPs).
 
-The FF-A support specifically focuses on communicating with SPs that
-isolate portions of EFI runtime services that must run in a protected
-environment which is inaccessible by the Host OS or Hypervisor.
-Examples of such services are set/get variables.
+U-Boot's FF-A bus support exposes an optional transport that EFI runtime
+services can use to communicate with Secure partitions. Through this
+interface, EFI services (such as variable access) can request or exchange
+data with the Secure world using FF-A.
 
 The FF-A support uses the SMC ABIs defined by the FF-A specification to:
 
@@ -26,13 +26,13 @@ The FF-A support uses the SMC ABIs defined by the FF-A specification to:
 - Access an SP's service through communication protocols
   e.g. EFI MM communication protocol
 
-At this stage of development only EFI boot-time services are supported.
-Runtime support will be added in future developments.
-
 The U-Boot FF-A support provides the following parts:
 
 - A Uclass driver providing generic FF-A methods.
 - An Arm FF-A device driver providing Arm-specific methods and reusing the Uclass methods.
+- An optional runtime FF-A transport (toggled via CONFIG_ARM_FFA_RT_MODE) that is
+  resident after ExitBootServices() and enables EFI runtime variable services
+  via FF-A helpers and a shared MM communication buffer.
 - A sandbox emulator for Arm FF-A, emulates the FF-A side of the Secure World and provides
   FF-A ABIs inspection methods.
 - An FF-A sandbox device driver for FF-A communication with the emulated Secure World.
@@ -69,6 +69,12 @@ CONFIG_ARM_FFA_TRANSPORT
     When using an Arm 64-bit platform, the Arm FF-A driver will be used.
     When using sandbox, the sandbox FF-A emulator and FF-A sandbox driver will be used.
 
+CONFIG_ARM_FFA_RT_MODE
+    Enables the FF-A runtime transport. This option depends on
+    CONFIG_ARM_FFA_TRANSPORT and CONFIG_EFI_LOADER, and is enabled by default.
+    When enabled, a minimal set of FF-A operations remains available after
+    ExitBootServices().
+
 FF-A ABIs under the hood
 ------------------------
 
@@ -158,6 +164,71 @@ they want to use (32-bit vs 64-bit). Selecting the protocol means using
 the 32-bit or 64-bit version of FFA_MSG_SEND_DIRECT_{REQ, RESP}.
 The calling convention between U-Boot and the secure world stays the same: SMC32.
 
+FF-A runtime support for EFI variables
+--------------------------------------
+
+U-Boot provides an FF-A runtime transport to keep a minimal set of FF-A operations
+available after ExitBootServices(). This runtime transport is enabled with
+CONFIG_ARM_FFA_RT_MODE. The runtime helpers and data are marked with
+``__efi_runtime`` / ``__efi_runtime_data`` through the
+``__ffa_runtime`` / ``__ffa_runtime_data`` aliases in
+``include/arm_ffa_runtime.h``.
+
+Runtime context is enabled at ExitBootServices(), and the following prerequisites
+are prepared during FF-A bus probe:
+
+- The U-Boot FF-A endpoint ID is discovered at boot time with FFA_ID_GET and
+  stored in the runtime private data.
+- An ExitBootServices() event is registered by the FF-A runtime transport so
+  the resident runtime context is enabled when EFI transitions to runtime.
+
+At runtime, the driver model is no longer available. Runtime users should
+use the resident FF-A runtime transport, which verifies the runtime context
+before issuing FF-A calls.
+
+EFI variable services over FF-A
+-------------------------------
+
+When CONFIG_EFI_MM_COMM_TEE and CONFIG_ARM_FFA_TRANSPORT are enabled, U-Boot
+routes EFI variable services to an MM Secure Partition (SP) over FF-A.
+The MM SP is discovered at boot time using FFA_PARTITION_INFO_GET and its
+partition ID is cached in runtime data.
+
+The data path uses a shared MM communication buffer and a door-bell style
+direct message:
+
+- The communication buffer is located at CONFIG_FFA_SHARED_MM_BUF_ADDR and
+  sized by CONFIG_FFA_SHARED_MM_BUF_SIZE.
+- CONFIG_FFA_SHARED_MM_BUF_OFFSET is sent in the FF-A direct message payload
+  to indicate where the data begins.
+
+After ExitBootServices(), EFI SetVariable()/GetVariable() call paths use the
+runtime MM communication path:
+
+- A pre-reserved shared buffer is used for the MM communication payload.
+- The cached MM SP partition ID and FF-A runtime transport are used to
+  dispatch direct FF-A messages to the Secure world after
+  ExitBootServices().
+
+Configuration notes
+-------------------
+
+Enable FF-A transport and MM communication:
+
+- CONFIG_ARM_FFA_TRANSPORT
+- CONFIG_ARM_FFA_RT_MODE
+- CONFIG_EFI_MM_COMM_TEE
+
+CONFIG_ARM_FFA_RT_MODE is enabled by default. It turns on MM communication for
+EFI runtime and may be disabled when EFI services over FF-A are not required
+after ExitBootServices().
+
+Configure the shared MM communication buffer:
+
+- CONFIG_FFA_SHARED_MM_BUF_ADDR
+- CONFIG_FFA_SHARED_MM_BUF_SIZE
+- CONFIG_FFA_SHARED_MM_BUF_OFFSET
+
 Requirements for user drivers
 -----------------------------
 
@@ -256,6 +327,7 @@ For example, when using FF-A with Corstone-1000, debug logs enabled, the output
 Contributors
 ------------
    * Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+   * Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
 
 .. _`FF-A v1.0 specification`: https://documentation-service.arm.com/static/5fb7e8a6ca04df4095c1d65e
 .. _`SMC Calling Convention v1.2 specification`: https://documentation-service.arm.com/static/5f8edaeff86e16515cdbe4c6
diff --git a/doc/usage/cmd/armffa.rst b/doc/usage/cmd/armffa.rst
index dbe4d5bc842..64571d615cb 100644
--- a/doc/usage/cmd/armffa.rst
+++ b/doc/usage/cmd/armffa.rst
@@ -39,6 +39,17 @@ The command also allows to gather secure partitions information and ping these
 
 The command is also helpful in testing the communication with secure partitions.
 
+Notes
+-----
+
+armffa is a boot-time test command. It relies on the FF-A driver model device
+(UCLASS_FFA) and is not part of the resident FF-A runtime transport used after
+ExitBootServices().
+
+armffa does not provide EFI variable operations. For more information about
+the FF-A runtime transport and EFI runtime variable services over FF-A please see
+:doc:`../../arch/arm64.ffa`.
+
 Example
 -------
 
-- 
2.34.1

