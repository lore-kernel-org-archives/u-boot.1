Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D12C88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E29480E01;
	Mon, 14 Sep 2026 14:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cp44ZBiZYH8; Mon, 14 Sep 2026 14:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39FC281065
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395491;
	b=BdXaARTVEd/4JtpzMWtZKth3fMHyiY7BEwBh674G+bmlXK5OLl/YmMh9jurJMYdwDR7+
	 nryDg+38VFQ9pC9wmt9voMOg0DRiP34wJVSEB++kIi62gcKBy9nr6dJ2U0f/NGL6s+/N1
	 ULr1ERE5BApVbq+Mf5WhBjP5ZefSxe8zpn6y/Uief/wHwGRR/NOu91B33YSrjauutoMEt
	 F7W3SftBRra6+c7WhU/dgCiWsWjvrq0cvaBNG51YpnkSfeWK0TZ74dhwVSAuEu71GM4il
	 g14BNPYKKEgMXiBzkftcwXlQUoEwSEZDycZssV6/Pa04wBX5CjlzrFHamjG3jECVC5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+Z3BhFK9DqYpZiTVWhlBXguw9VnY3idnY3mUuFhVo+Y=;
	b=c9HDrDFolLoDdi7FIlvQnqRNnnTDCQGockoyVOe5h7orfah2414gOizO0Ao06A3oUv7X
	 a60pxWqCs7HQmDGltoy8JKRe5G5gCGxwAh/3FESthK/PbsyCgLnabBIrE3zXbjfimUgUa
	 my+VzgeRZbSK15mMEiTQGRZYOz7VXISJeeFYl+m2/o1MyKC3ajKq4ZBQFxjHODYC9GsvH
	 pEOyiIOHGpb1Pex8kmhh5xFhrna+MmbB9SQf1aT4oy7zJ+5keoC4VIHDUGsZuwKqv0eGC
	 qKC1PHoiaU1TOsPRM7MS8vpcFvqzrbdKSXggm3iSm2zmbFpM2jWxq2aU+yH3lcdDwwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395491;
	bh=+Z3BhFK9DqYpZiTVWhlBXguw9VnY3idnY3mUuFhVo+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ld0Sh9LgrT2s+G9eHFDbByhpfme/asNism6duUSlXyDH4RQF+rFzCGDi+jDCKKFb4
	 MzGRLSW3HcupRKNFn09IGm7D87ZfCgLDvVdItcI0FqI6k5/hHHRP/Plc17UqTUNtOB
	 elmg3sL8XmEZ30WCG7repxrOey2Xl4hhUQGTJA9Nxqw9AXKeZyKmwdS7IPzrNOi8Iw
	 dfoxz6v+JgH5NOCnkfvHLtf0myqUB6it4/NYWpOsFD06JagK+QWDtsD9nLyNCqCMWC
	 WPaqWfycQBwUMNV/I4iWzjMdNhhNGtRag/tQ7XAOjF3uHj1dRr+Fxkd0dk45wAT/Fd
	 xMVRGKnw/k4Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39FC281065;
	Mon, 14 Sep 2026 14:18:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 290342D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A736605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4syNVD2_siTu for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5DD86069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=Bb0zj5UNzLsrdVTdxZge6u5GEAYQ1QHNUJHJ0nRuNs58kBHZ3x1PqAImNAXCSwFceig7
 RjjzqMw1HtE9fPDJKx/tNRQMkTdVvSThSVXJy/N+26y7oSNop3GOCvn5AoqK+WwP89Ai6
 Mr2+llZ1BwQ4h6hCbpANwYbJq7FaJWLP6hKLENltKae7zkSBajXE6haveBTlDHXLLEO4M
 fBvQMmC30baZqNHmEWGPmdXU3VQwhxhUiNSSKt3KDXYaAuZcDy1K6JHLreiJQaWuIPP+b
 FZq37gXnFg554ioH6XWzdq5Facn1AxWBfDU5gXuSNaLGBqEibpMcaa7cGi083SPGC9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+Z3BhFK9DqYpZiTVWhlBXguw9VnY3idnY3mUuFhVo+Y=;
 b=Vhtn7LPqAlq6c0dblTbPUptNz+nLPUm7CmHMogxXgj15vN8aAK5RRh2GUBt/AF14r/K2
 7bHqn0OP2qMc4JQs/PL0uBD5SNkisFe5KhVvg8HbiSu+ZgaZ7DKvGeXWuTW4wvtBacWte
 xY1ImkIUt1rfIKF7K59z2tU5fDKis+B1hqbi62hI7gbfrWoXL3vY/ILBnj4F7kq42Cf1p
 noIOmCzpHKdI+RMsjRlXljdMSt/ttw0hDhumPp96fvpo6FOcg4Vm1oYhR/DJiXuF2wOEL
 iXpcIMhpGJNaKyXrRGw+Kw4BOrnh+7XUc9ddfoUZWGH51cYrniKIx8xzG7nzUzCz0gw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=LVyASght; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=LVyASght
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5DD86069E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C112ED2;
 Mon, 14 Sep 2026 04:02:02 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751EB3F86F;
 Mon, 14 Sep 2026 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383726; bh=hz/nS7vkhXJ9L4Qb2+pi6sf/6wlZTVPDqUmbPz/skGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LVyASghtRfDETc5eU1Sh+IuUDAf5jhvWyazJfTEsBY7jOKz/yyHzitulk32t7sKTv
 mpv6zipdrhpiFWrM8PW2HIZXAx9rjTIzNjbXOjs2COtOjlSk5ve0bQsZThzWL9YaXn
 mUF0CoUZhtGV4CuUWY5pQinbRZlUPBcvuyaKHtME=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 21/22] doc: arm64: document FF-A runtime path for EFI
 variables
Date: Mon, 14 Sep 2026 12:01:05 +0100
Message-Id: <20260914110106.1974894-22-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

