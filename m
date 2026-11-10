Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F7606A74D
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r6SDWenm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=COcqyExu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20FC0817A9;
	Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gDYWtfVS-Ji; Tue, 10 Nov 2026 13:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 554CB81767
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316021;
	b=cYHCU8PPBea4+qieVyDNomFTB9CZ30hSCnMVnEtb/ggRZLi0vXjx5b3T4DzcWrzMTa4H
	 NG3VX7AMqwkE0imrWlhL4oSSFOfcMXWaOVfXKjz5pYTNF5EK2H2fy02u8D1GCSgBEYPBQ
	 sGg8T4FlXDSEcOdnJnOGBJx6pAgF1gy9R0STJlJ9on7J/gwf01ppuO08Swf5f+qFWHA2F
	 GyafPlzspCJ+rtUJ6h+55hJ9tqXgcUDGzqyIB2jH0Zs4XxMa4xpDpovtHxBCKkZEkmWNK
	 91bfdrmGwYgNKpbsC06LWatVk/iPl1oZYmxzBU9BbVPh5ZHyXMDcADOjwd9teChWKrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=13A7NVm/RdE/bdnyEuLFmDn9sxPPuziMabZgEQSAGK0=;
	b=Bam8Tf9RFRu2K/qavUfwgzBatPDOT4QXdWykhegRsc8wLkxXsnRiotxJ9uN6RVrcJqxN
	 Xsno3YaPVQsC1wies4xEZ5Y60yNxPdLeWH85eYOrZhTKaHnX7ZOyhKqIyHCzlcDgR38KW
	 yMYuUZA/Amn4U0oT7H+pI9hrPWCdAqeKGo8TmdeFxOTd8TaBJttgH9eSU8gDfzuXWn9Lj
	 K6EBDJ6XqVc66UQciPDOg91cY3OjBSn7rWOvl9ZvnGlx65jQgmYxte8kGRQ/71Ca+UCxa
	 rlFoiqYMXdRx4DJWd7I2/+kl0Vq5U/a6COoWUfJLG8Um+Ram1/d9k/o7jGco5vd1w4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316021;
	bh=13A7NVm/RdE/bdnyEuLFmDn9sxPPuziMabZgEQSAGK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6SDWenmjFkuXfstlafpjRu1x0MzcF5ZQxdGkdnizTO1BPG2GZ6biYerB//1J1FUt
	 U1wRlJE0L6IQXhFVDC3Jcu2ttdGP3cXZdph0/yHUFzW/b8NqHCSLfmkncAQvSsOV/T
	 I4P+KX8RaecOgQu21NoEE9hwVsInq13ZoTZGU+Lec7smoTg9X/LIjYeDrshiodDe7C
	 hEn9knz3h6gkQI/UN4p5qX5vqqu/HjCB43UpIctZp2WUKbw9WldS84MmbGBhZeoz5p
	 O47zInFAETWirYqQEByww3oWemWCMn/giT5jzOa8mP2rN2HTppuxGRdrlZuoL1bdEm
	 nCq7Qc2aNXhLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 554CB81767;
	Tue, 10 Nov 2026 13:07:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1C1FD7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68CA0405B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rk2hJAr5Unxw for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43503407FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=COcqyExu
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43503407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB241E7D;
 Tue, 10 Nov 2026 01:58:40 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C093FAA1;
 Tue, 10 Nov 2026 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304723; bh=cLdJUygskkmxv6H69PZz4s2No9iADe/0yu0vqUoXo54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=COcqyExuUcLq+EjaJufb0UIqOd94LrQHooTkX12tagNRqXc0KpUsRX0v5Zh2TEfUd
 HBx6AD3S1KVTbMj0O+7MSKiSlszGFZEZUv4+pl1CYGOIXDZ1dF54fi9Rtn/9Lkr7ZJ
 Ukx+FPx+QMuPcMsSV5EPOI5b96jAQL5FqNXObPq8=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 21/22] doc: arm64: document FF-A runtime path for EFI
 variables
Date: Tue, 10 Nov 2026 09:58:02 +0000
Message-ID: <d93bb8c8967ba20b703a754b8bc7862fdb802469.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changelog:
===============

v3:

Simon:

- Name the exported FF-A runtime entry points in the arm64
  documentation

v2:

Simon:

- Normalize `Secure world` capitalization
- Drop low-level cache-maintenance detail
- Remove internal helper names from the public flow
- Refresh `doc/usage/cmd/armffa.rst` to match final wording
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
2.43.0

