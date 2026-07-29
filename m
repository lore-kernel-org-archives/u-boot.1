Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F54DC54F52
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B98160B0D;
	Wed, 29 Jul 2026 12:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8EQl_QVPxbW; Wed, 29 Jul 2026 12:28:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B840460B52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328129;
	bh=mXnLvwIB0idbbgdBY5MEwDy3CSL4WUN2VdFwBVXmXYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e8OruzN0/3AZu0mKYfdXZ14/VoEm4yr/O2SiqTdAgHHm60XCn2kC+bg4g1b7P65aA
	 p9zGK2rCPnmznfYReXCJEben1YsXIzabYzRbN5vE38/VyqqxbKqwEAj2YppqaF5p8K
	 UhxuQmki92FpELgQyIzlxLu9oxxqszbic1dKCUxs3BMOunFwDZytSDXfZRDhDa6mEc
	 yEtqTUwNJB2VPRrATIRwHSu0oC8ZGi5oqlvUXlhugN/tmdhmrmlFuHIdjQvseEqQ2/
	 b1qEVX9LxnnBJ/A4NDl4GSjQg5ZkvXkR0xhPmcBoOF55LA15orWKOvAGL3VmHq1RsY
	 3clyt8A86Z6Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B840460B52;
	Wed, 29 Jul 2026 12:28:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B68023F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DC3840156
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kG6MXo3um5ic for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 87DD04009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87DD04009C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87DD04009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064348404D; Wed, 29 Jul 2026 10:52:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D81D1849AA
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:21 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2213A169E;
 Wed, 29 Jul 2026 01:52:17 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E433F66F;
 Wed, 29 Jul 2026 01:52:19 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 21/22] doc: arm64: document FF-A runtime path for EFI
 variables
Date: Wed, 29 Jul 2026 09:51:23 +0100
Message-Id: <20260729085124.2618817-22-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315141; bh=c5+yXMVBSQ31TlsxdIKW9oRlJ6X9ipSJaPdJaPsQR18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bCBNaOy1PAxgidCyxrgcVfPcFCwEUzxJbqXj5wVSZ8ITKC0atEmECHENdjqQyfVSl
 t1LTMV2LIGa9Ad006GDJa+Ends9WeJyI11jHtbml5FGI4IPZgO7RNO0mKMhebV54Kp
 ox35kzDQY8kDjXYZhTwtEPK/8q2AilKbaPqdO8Ig=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=bCBNaOy1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="bCBNaOy1"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The arm64 FF-A documentation still said EFI runtime support was a
future development, so readers had no description of the current FF-A
runtime transport or how EFI runtime variable services use it.

Document the FF-A runtime transport, the shared MM communication path,
and the EFI runtime variable flow on arm64. Also clarify that the
armffa command is boot-time only and point readers to the architecture
documentation for EFI runtime variable services over FF-A.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 doc/arch/arm64.ffa.rst   | 88 ++++++++++++++++++++++++++++++++++++----
 doc/usage/cmd/armffa.rst | 11 +++++
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
index f966f8ba6af..145bb70abce 100644
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
 
@@ -158,6 +164,73 @@ they want to use (32-bit vs 64-bit). Selecting the protocol means using
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
+use the helpers exported by ``include/arm_ffa_runtime.h``. In particular,
+``ffa_runtime_context_ready()`` verifies that the resident runtime context
+is available and ``ffa_sync_send_receive_runtime()`` issues direct FF-A
+messages after ExitBootServices().
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
 
@@ -256,6 +329,7 @@ For example, when using FF-A with Corstone-1000, debug logs enabled, the output
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

