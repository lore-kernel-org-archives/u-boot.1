Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF453C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9644883A27;
	Fri, 25 Jul 2025 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8071F83A25; Fri, 25 Jul 2025 17:51:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B5DB683A25
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602D1176C;
 Fri, 25 Jul 2025 08:51:02 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE7273F66E;
 Fri, 25 Jul 2025 08:51:06 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 24/24] fwu_arm_psa: Document FWU support for Arm PSA
Date: Fri, 25 Jul 2025 16:50:10 +0100
Message-Id: <20250725155010.285831-25-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add documentation

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>

---

Changelog of changes:
===========================

v2:

* As suggested by Heinrich: Removing the Corstone-1000 specific information
    and addressing nits

v1:

* Add documentation

 MAINTAINERS                      |   1 +
 doc/develop/uefi/fwu_arm_psa.rst | 154 +++++++++++++++++++++++++++++++
 doc/develop/uefi/index.rst       |   1 +
 3 files changed, 156 insertions(+)
 create mode 100644 doc/develop/uefi/fwu_arm_psa.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index fdf34c74049..a75bc1d2379 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,7 @@ FWU ARM PSA
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 M:	Davidson kumaresan <davidson.kumaresan@arm.com>
 S:	Maintained
+F:	doc/develop/uefi/fwu_arm_psa.rst
 F:	include/fwu_arm_psa.h
 F:	lib/fwu_updates/fwu_arm_psa.c
 
diff --git a/doc/develop/uefi/fwu_arm_psa.rst b/doc/develop/uefi/fwu_arm_psa.rst
new file mode 100644
index 00000000000..8f27d31483b
--- /dev/null
+++ b/doc/develop/uefi/fwu_arm_psa.rst
@@ -0,0 +1,154 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+
+Firmware Update (FWU) Support for Arm PSA
+==========================================
+
+U-Boot implements Firmware Update (FWU) support for Arm `PSA Certified`_
+platforms.
+
+The feature aligns with the Platform Security Firmware Update
+specification for the A-profile Arm Architecture
+(see `DEN0118 v1.0 A specification`_) and leverages the Trusted Services (TS)
+framework to interact with Secure world update agent.
+
+Overview
+--------
+
+The FWU subsystem enables secure  firmware updates by
+delegating the update management to a Secure world agent. U-Boot acts as the
+FWU client, coordinating updates via a well-defined set of ABIs over the FF-A
+interface (see :doc:`Arm FF-A Support <../../arch/arm64.ffa>`).
+
+FWU for Arm PSA supports both on-disk and standard capsule updates.
+
+Key Features
+------------
+
+1. PSA Firmware Update Initialization
+-------------------------------------
+
+- Initialization of the update agent using the FF-A transport and discovery of
+  the Trusted Services FWU SP.
+
+- Discovery of the version of the ABIs using FWU_DISCOVER ABI.
+
+- Establishment and sharing of communication buffers between U-Boot
+  (Normal world) and Secure world.
+
+2. ESRT Support
+---------------
+
+Retrieval of ESRT (EFI System Resource Table) data from Secure world using
+FWU_READ_STREAM ABI, enabling compliance with UEFI standards
+(see `UEFI v2.10 specification`_).
+
+3. UEFI Capsule Handling
+------------------------
+
+- Runtime checks for capsule flags as per UEFI 2.10 specification:
+
+    - CAPSULE_FLAGS_PERSIST_ACROSS_RESET
+
+    - CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
+
+    - CAPSULE_FLAGS_INITIATE_RESET
+
+- Support for keeping the FMP payload header in Arm PSA mode to preserve
+  critical metadata required by Secure world.
+
+4. Staging and Update Flow
+--------------------------
+
+- Full support for update staging flow as per PSA spec:
+
+    - FWU_BEGIN_STAGING
+
+    - FWU_END_STAGING
+
+    - FWU_CANCEL_STAGING
+
+    - FWU_WRITE_STREAM
+
+- Capsules can contain multiple payloads (including start/end markers
+  and the update content).
+
+5. Directory Access
+-------------------
+
+- Reading the FWU directory from Secure world using FWU_READ_STREAM ABI.
+
+6. Image Update Lifecycle
+-------------------------
+
+- Implementation of get_image_info() and set_image() using raw EFI firmware
+  services provided by the FMP driver for raw images.
+
+- FWU_ACCEPT_IMAGE ABI issued on ExitBootServices() to commit successfully
+  booted trial images.
+
+- Option to disable automatic acceptance on ExitBootServices() via
+  CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES.
+
+Configuration Options
+---------------------
+
+To enable FWU support for Arm PSA, enable the following options in your board
+configuration:
+
+CONFIG_FWU_ARM_PSA
+     enables the PSA-compliant firmware update client in U-Boot.
+
+CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES
+     enables auto-acceptance on ExitBootServices(). Disable this setting
+     if auto-acceptance shall be handled at a later boot stage.
+
+Platform Integration: Corstone-1000
+-----------------------------------
+
+`Corstone-1000`_ is the reference implementation for the FWU Arm PSA feature.
+
+ABIs Implemented
+----------------
+
+The following ABIs from the PSA FWU specification have been implemented:
+
+    - FWU_DISCOVER
+
+    - FWU_BEGIN_STAGING
+
+    - FWU_END_STAGING
+
+    - FWU_CANCEL_STAGING
+
+    - FWU_OPEN
+
+    - FWU_WRITE_STREAM
+
+    - FWU_READ_STREAM
+
+    - FWU_COMMIT
+
+    - FWU_ACCEPT_IMAGE
+
+ExitBootServices() Integration
+------------------------------
+
+- The U-Boot FWU client performs several key actions during ExitBootServices():
+
+- Notifies Secure world about successful boot.
+
+- Accepts updated images in trial state.
+
+- Supports board-level override of fwu_notify_exit_boot_services() for custom
+  behavior.
+
+Contributors
+------------
+   * Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+   * Davidson kumaresan <davidson.kumaresan@arm.com>
+
+.. _`DEN0118 v1.0 A specification`: https://developer.arm.com/documentation/den0118/latest/
+.. _`PSA Certified`: https://www.psacertified.org/
+.. _`UEFI v2.10 specification`: https://uefi.org/specs/UEFI/2.10/
+.. _`Corstone-1000`: https://corstone1000.docs.arm.com/en/latest/software-architecture.html
diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..573630740a0 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -10,6 +10,7 @@ can be run an UEFI payload.
 .. toctree::
    :maxdepth: 2
 
+   fwu_arm_psa.rst
    uefi.rst
    u-boot_on_efi.rst
    iscsi.rst
-- 
2.25.1

