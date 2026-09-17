Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D10C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FE6260BD6;
	Thu, 17 Sep 2026 17:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U35c20CRWvhG; Thu, 17 Sep 2026 17:20:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EDA8760BFF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665628;
	b=THit56gd/VeBclxXBFzCoJwpETe/SLDNyeuMdqO5qUSBjdafEAqpDT11zSk8qrIk+mCd
	 5NWXNIcyUP0/eYrwUvPH8kFkF9boJac+QKupFORRcxn/xtt2G90trX7JpaLtj9NWVf25I
	 8vq6fJK2KWBkImFwkR7S96B9mSQNYBXE4sWWf2M0O4Pu+jxmBw5EKX59nt+OuZlcbC5M7
	 +g5H4qjsqF9v0RTNRAQOIs1a7uiL+msmwKMORQTKB6XckNckiEvkmlbVYybDcuyfASdBF
	 zasCPG9TSgUVYYu6fGhzU3zydnyGhUDPzPxIJxk9fIPP3epEmdLHL7Bdihj4m5akuUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yU1FdNJre+pz8x5hKJ2Bk6ZWU1HEyFP8pQww7sOPW3E=;
	b=AaO5oCevidJPOuNNuHj3hN8ARlbhxu8gXCpfP5NTXiJpULauR3LC3Zyb/EkhvzHh9QDt
	 Og2tetF/nqivVotKwH/IbKI50U7iQg85yR5V8qj4DagOfUZ0AnpA1YO+pdMpiBFT4X+iL
	 l2vC0iTB61RPS4xHKmsxR0NJ8OSjhrbBUENMriztSNyqbGyBvq0wHKv+jobY0pz1N8tX8
	 0RqPO0fgZ/2fzPlqImwdC/noWstQ4gIUb3Wo49XOglGg9ak1dTEq46iJjcD+Xlh3XPUPn
	 DAlwdd1VAQ7GVQem4nLrjBy1DU9DdDef5/vVo6JsxrP9knHzEk/SLowts+1fPSN4faA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665628;
	bh=yU1FdNJre+pz8x5hKJ2Bk6ZWU1HEyFP8pQww7sOPW3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mC5pjL9dgEY7sKtH9z8oNPnu8PnCXwmxB2RiR4ENSmhVVp/u6XD9r/XQID0vqMLYv
	 7JyiyciYOU+6IAD2J1QfcSieUNwX5S/Z+Us+QTVHodeF3Wy+/lX25ZRyoJICig/Gm1
	 cz+8WRSGVDb5s0cYUHWVUt8rJ11SUubui4UrYFWbU8R4DKpOP26QNR+ItfXtbF7ueg
	 EBdImNYsamqErrMyZdoqfNsaR8Ul2/zMuyM7JZNpDludi8dhk3MpoWCoULgdVKixo4
	 biddIU3OfbxSlwsdHpX6pzRr11SWGur2UKkNkG7P1k/eT5BHg/zcLM35riT+lGnRJd
	 8V7i+HZ/pbaTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDA8760BFF;
	Thu, 17 Sep 2026 17:20:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FAD4362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4342D8109C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i77bqeFLDCEU for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DC976810D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665559;
 b=OcHUkZJoK/J76TM/dXngKNueeDQuehxYB1AqE56DGCd8VpoyTER3wSfjx2G17jfcHtu5
 ygZGEpTTwq1GpNStN72CV2H+JB+4yHwErld8S3e6c/OeJhhmpyfaF8dUDjf/3pXRsKgS3
 VzH0g+bzU/X3JBHOZyZAjM23RyPqBMPebHGafyqio0ytShusWnzG3l8dE5bds6l+/zz1j
 T424n06Zg+L35EN/I1482pj1hRKbl5t6RbsNq8Nib7+ndkYy9jWW2bAOsg52I3cPqJN5t
 IjG9gTWtqOLJ6hCfFTMiPfeDqx/Uuu01QYXkUVDVC6f8pd31kAB6kzBG3jzLfdbS+jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665559;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yU1FdNJre+pz8x5hKJ2Bk6ZWU1HEyFP8pQww7sOPW3E=;
 b=L49ffnd8dJr1y9UOZ6mwaKTLhtsJdjgM2G7/fkQ7beTMeMhMvqgRyL/4n520ILhoys4B
 KgLp2hgGGJwennR2y8otLuWnZmT2PnA96VzrqZ7doOgj0XBQAggKY/tGspGPkE/yxa8od
 55HLi2otckdIYAqGxseoiTWzLPOtzcZpirmi1oNAQQHfDSqXbz4fITE++t0JInkvny/WQ
 Ztzzi6yv4nBYWkogNjVPqLBPLdMlzC9xe3YEHH+jt+86jRmvpjzcojxrXOr6jvWRwettf
 ajDCxP4w8ueUvV7Gz6Z4l6VD1qTsvYGfnwW99t9S6voVBm6YK9L34kYD0j8nhKXdsgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=vQPbbnRn; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=vQPbbnRn
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC976810D4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753A0143D;
 Thu, 17 Sep 2026 10:19:14 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4207E3F7B4;
 Thu, 17 Sep 2026 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665558; bh=wMHqOxXj7BStoWmSvE04XGWF0A3dG4Qjn6eTJsp6Dgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vQPbbnRnPzGqmzOp2g+GE1HriXOp4XkfiPgfvbq9vboUyEt9eHD9Y829K2/69cSId
 FWvYuVEhwIZMb1ONJja0f5r1aTtoCzUtcl6c6ImdZUpPuW/sM09nDhWWtQ+a7PocEt
 q4TqSSnW6RGGt4ul/ZnXhMz41v2BmZstB+8ClJMg=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 24/24] fwu_arm_psa: Document FWU support for Arm PSA
Date: Thu, 17 Sep 2026 18:18:10 +0100
Message-ID: <20260917171810.4122899-25-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
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
 MAINTAINERS                      |   1 +
 doc/develop/uefi/fwu_arm_psa.rst | 154 +++++++++++++++++++++++++++++++
 doc/develop/uefi/index.rst       |   1 +
 3 files changed, 156 insertions(+)
 create mode 100644 doc/develop/uefi/fwu_arm_psa.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index bde8158fa73..a896ffd2834 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1197,6 +1197,7 @@ M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 M:	Davidson kumaresan <davidson.kumaresan@arm.com>
 M:	Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
 S:	Maintained
+F:	doc/develop/uefi/fwu_arm_psa.rst
 F:	include/fwu_arm_psa.h
 F:	lib/fwu_updates/fwu_arm_psa.c
 
diff --git a/doc/develop/uefi/fwu_arm_psa.rst b/doc/develop/uefi/fwu_arm_psa.rst
new file mode 100644
index 00000000000..a7bef53c7c7
--- /dev/null
+++ b/doc/develop/uefi/fwu_arm_psa.rst
@@ -0,0 +1,154 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
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
2.43.0

