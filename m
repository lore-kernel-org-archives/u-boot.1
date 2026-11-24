Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773ED606A695
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HBqwG/pM;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lXleVrsl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C79980E1A;
	Tue, 24 Nov 2026 21:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWq0A3B3TF-3; Tue, 24 Nov 2026 21:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD1E080DC3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795555164;
	b=MtPTFjNZJKBqzIeVvqUCfnW7OURhp85EF/Cb/yMKJwaitHverG9CzAbq0hJvjH5O4OUR
	 +MY33+xClAshpE9ssXpg7GVNwsd254qDIvzdMqhhrhl2ogrnpIh1Hq1iYf2S6m80UGrRO
	 w918PZPLu4FiRMYmHB5X32TvDupVTZadnkzTOgT8pAYKelMTic8bZJjlCikoZrVIaarNM
	 mp5iPZVw80IUtS+hx96aaK/8X/AvKACAfxHLa/v3t3rFZ0/+AuTmp67H3pPo9kbXg4vw2
	 lSQKTSk9m89VlyADA/18ZdJdxCAcGsThhBh1Kan3AtkLNxnCcCT5kS2+r8IN/0/jPGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795555164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bPCvVR7jrNncVbVStLT5YMaIifwr0cF67kBv1QIUu1w=;
	b=NujJN5yZ5PNTFiWBuRihePVlknSqKtq5ELSgm90fcwKNAST/arm6RHOFHQnh7GuA+mn4
	 rUl1rknEQ2/7j/qnZnsTwyRnWOV1VwzikNwVMo0fZF1NF5aBRqNVCyDLCgkdbXz4Md11l
	 jtNcBtgm1PmU1Uim13/iFp9ol8yyWj14oba1lN8QPFc63gJXpgm0DT5le8zBJUtQrfiWU
	 k/xHSZHN+CmT0w4G6s0aATCNmO7MSkotgvP4KhqF2h0dpZ+QekbICbupWtjgJCsAdLw46
	 KvhmP6CY++PIBYcTo3eXMqJ8ryvmX/DOWMFEp0so9WnS8ILCfEk8zKnKJxufcpuzH5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795555164;
	bh=bPCvVR7jrNncVbVStLT5YMaIifwr0cF67kBv1QIUu1w=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBqwG/pMxBjdNRBnFmnmRF7TM02NjKuz7AUxGjgZmfO5MvrqVvajY1z1ujP5tGdHP
	 vcsTzqxA8/GolTdBn1hun6jM8l4Ldkz/dYlKA326IPAUX4j8Bev9fSBptPucUdAHFf
	 am14Zb7IIm0/cHkQh+u4a7S5Wue8JVJjI39Ye6k0ejTjx89KrR2mt0QZuEQVsp7NDE
	 r7TvH0U2Tg9GIET0KWL+zOBgNoebZNK0bb+QGaQIrfvKp9rhhucEPKL/8N7XVREuhc
	 L9bQI8k3ChwREOeqRw9gqtw0YS1YZJXmtVm4OyFrmXTOGTObdPJoiVBu9Mnka1q/wt
	 tBV6023iHE/nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD1E080DC3;
	Tue, 24 Nov 2026 21:19:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3713B325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C51B4009D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNfO3rg_BFfb for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 21:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9480440071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::345"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::345; helo=mail-wm1-x345.google.com;
 envelope-from=3vp8fawkkbsksx136x22dv33v0t.r319-q3380x787.9-q338-463ytr8.36v@flex--dimorinny.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=lXleVrsl
Received: from mail-wm1-x345.google.com (mail-wm1-x345.google.com
 [IPv6:2a00:1450:4864:20::345])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9480440071
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 21:19:19 +0000 (UTC)
Received: by mail-wm1-x345.google.com with SMTP id
 5b1f17b1804b1-4bb8ae35aeaso41884275e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795555157; x=1796159957;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bPCvVR7jrNncVbVStLT5YMaIifwr0cF67kBv1QIUu1w=;
 b=lXleVrsl+IM0OpYARJxbZuxc032JygejmTCkfYKY9y7eK9VVN0xAjT9wBssCI04FsP
 h1mCNdZJYdnHJn8/ObDkGvSm18aT4KUlrR20zS7O8Cn7V/S6zUG8CXPsrBZ27zhgS6JY
 IZlqdRCKA2WTMYuV9u1bdYkUx0YMOLrfwKB5Xh2xtVGb5yWhjNfPhe7j8iGi5cs6bN/2
 a1k5caGf9clMoGIhAOLX6CxjZUFtqm24HuPhgjD2qNMSxDNeZ378ZEM18ZAdgqigJpaw
 ltla15UK6Hisk0aoaiHXP7gvNMzwMYVcvvTp8hFh00+79Ppm/LYRf2j/WaJt0TOYPCBI
 /Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795555157; x=1796159957;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bPCvVR7jrNncVbVStLT5YMaIifwr0cF67kBv1QIUu1w=;
 b=wmNVpiBMgqziE6XkqK2ujmB1x6z08kVOQ3HSaJ8BqxGveF2e8xQ9/HBPsGU0FLUnrC
 fBlAciokJJlNjPLTXv6s4GfkLIiEgNPP2K2VCmotdL1DvLepzfEJ8c7+8HK9FsKqWmtS
 MYsYJYWOaWFaA/5dBuiTbAhiiAGFnO3FXBoedeI0yzcNcF8KdpYJ6TW5IkYPAlDG4oWB
 ThAOQBgTgeiKbU7ssLLf2Io6QYdrWLYOVT67gOTwiutXAGZBfy9RrCrLbNhtr2jWYvpf
 rU2vJs1TZpkn9WEej82ARNxi4m4SO7eUZZin6so/TNtsd1+n4IJKlNq0So4DTZGH3Ih+
 Y5aw==
X-Gm-Message-State: APuU4Z/FmNsFXqAxdHtI2ASktDsyLzAVwvxlojq86QiaUt9MGyy75BNy
 6wVh8dv11TQD2M6aYqTmqoKl6puNi94nOwVNJUILPCkxKCLCCxKWSL/qu01rNoAYMX7ccEmemth
 ehZco2q7c7SqU4xbnYfq5sBIrakFpMTsy6MMUnKW2lgIQaLVcsFA6einF4y6dJO1vc1WknhlUrM
 K9k2c2nC/lNz/ZrhhA9tGQuyQMtCoIYs/pHdAeZwFbqeL8y9Ygy3JwmeoDnEW7N0ph
X-Received: from wmdp22.prod.google.com ([2002:a05:600c:5d6:b0:4a2:1824:f77d])
 (user=dimorinny job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4bb8880b984mr378390095e9.14.1795555156821; 
 Tue, 24 Nov 2026 13:19:16 -0800 (PST)
Date: Tue, 24 Nov 2026 21:19:13 +0000
In-Reply-To: <20261124211914.3088229-1-dimorinny@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124211914.3088229-1-dimorinny@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124211914.3088229-3-dimorinny@google.com>
Subject: [PATCH next 2/2] efi: gbl: Add GBL GUID names and protocol
 documentation
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ji Luo <ji.luo@nxp.com>, 
 Ram Muthiah <rammuthiah@google.com>, Dmitrii Merkurev <dimorinny@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the GBL protocol GUIDs and GBL_EFI_VENDOR_GUID to list_guid[] so
'efidebug dh', '%pUs' and 'env print -e' print them by name, and
'env set -e -guid' accepts GBL_EFI_VENDOR_GUID when
CONFIG_PARTITION_TYPE_GUID is enabled. Add a unit test in
test/lib/uuid.c to cover them.

Add doc/develop/uefi/gbl.rst with a short overview and the kernel-doc
output for include/efi_gbl/, linked from the UEFI and Android doc
indexes.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
---
 MAINTAINERS                |   1 +
 doc/android/index.rst      |   3 +
 doc/develop/uefi/gbl.rst   |  97 +++++++++++++++++++++++++++++
 doc/develop/uefi/index.rst |   1 +
 lib/uuid.c                 |  47 ++++++++++++++
 test/lib/uuid.c            | 122 +++++++++++++++++++++++++++++++++++++
 6 files changed, 271 insertions(+)
 create mode 100644 doc/develop/uefi/gbl.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca3d064cd8..efcb6f06eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -124,6 +124,7 @@ F:	test/py/tests/test_android/test_avb.py
 ANDROID GBL
 M:	Dmitrii Merkurev <dimorinny@google.com>
 S:	Maintained
+F:	doc/develop/uefi/gbl.rst
 F:	include/efi_gbl/
 
 ARC
diff --git a/doc/android/index.rst b/doc/android/index.rst
index 225d6f125a9..ac04f6944a6 100644
--- a/doc/android/index.rst
+++ b/doc/android/index.rst
@@ -12,3 +12,6 @@ Android-specific doc
    boot-image
    fastboot-protocol
    fastboot
+
+See also :doc:`../develop/uefi/gbl` for the UEFI protocols used by the Android
+Generic Bootloader (GBL).
diff --git a/doc/develop/uefi/gbl.rst b/doc/develop/uefi/gbl.rst
new file mode 100644
index 00000000000..ac51db8da07
--- /dev/null
+++ b/doc/develop/uefi/gbl.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Android Generic Bootloader (GBL) Protocols
+==========================================
+
+Overview
+--------
+
+The `Android Generic Bootloader (GBL)
+<https://source.android.com/docs/core/architecture/bootloader/generic-bootloader>`_
+is an open-source UEFI application (``gbl.efi``) from the Android Open Source
+Project (AOSP) that standardizes Android and Fuchsia boot, Android Verified
+Boot (AVB), A/B slot selection, and Fastboot across architectures.
+
+``gbl.efi`` runs on top of UEFI platform firmware (such as U-Boot's UEFI
+subsystem) and relies on standard UEFI Boot/Runtime Services alongside a set of
+stabilized GBL-defined UEFI protocols for board- and SoC-specific operations.
+For development builds of GBL, all custom GBL protocols are optional; firmware
+can implement them incrementally as platform features are enabled.
+
+The canonical upstream protocol specifications are maintained in AOSP at
+`gbl/docs/efi_integration.md
+<https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/efi_integration.md>`_.
+
+Protocol Summary
+----------------
+
+================================  ========  ====================================
+Header                            Revision  Purpose
+================================  ========  ====================================
+``efi_gbl/avb.h``                 1.0       Android Verified Boot board
+                                            callbacks, lock state, rollback
+                                            indices, and persistent values.
+``efi_gbl/avf.h``                 1.0       Vendor DICE handover and
+                                            Secretkeeper key for Android
+                                            Virtualization Framework (AVF).
+``efi_gbl/boot_control.h``        1.0       A/B slot queries and active-slot
+                                            updates, one-shot boot mode, and OS
+                                            load handoff.
+``efi_gbl/boot_memory.h``         1.0       Platform boot and preloaded
+                                            partition buffers.
+``efi_gbl/debug.h``               1.0       Fatal error notification prior to
+                                            system reset.
+``efi_gbl/fastboot.h``            1.0       Vendor Fastboot variables, staged
+                                            payloads, and OEM commands.
+``efi_gbl/fastboot_transport.h``  1.0       Custom Fastboot transport channel
+                                            (e.g. USB or serial).
+``efi_gbl/os_configuration.h``    1.1       Android bootconfig and kernel
+                                            command line fixups, device-tree
+                                            and overlay selection, and FIT
+                                            configuration selection.
+================================  ========  ====================================
+
+Common Definitions
+------------------
+
+.. kernel-doc:: include/efi_gbl/common.h
+
+Android Verified Boot Protocol
+------------------------------
+
+.. kernel-doc:: include/efi_gbl/avb.h
+
+Android Virtualization Framework Protocol
+-----------------------------------------
+
+.. kernel-doc:: include/efi_gbl/avf.h
+
+Boot Control Protocol
+---------------------
+
+.. kernel-doc:: include/efi_gbl/boot_control.h
+
+Boot Memory Protocol
+--------------------
+
+.. kernel-doc:: include/efi_gbl/boot_memory.h
+
+Debug Protocol
+--------------
+
+.. kernel-doc:: include/efi_gbl/debug.h
+
+Fastboot Protocol
+-----------------
+
+.. kernel-doc:: include/efi_gbl/fastboot.h
+
+Fastboot Transport Protocol
+---------------------------
+
+.. kernel-doc:: include/efi_gbl/fastboot_transport.h
+
+OS Configuration Protocol
+-------------------------
+
+.. kernel-doc:: include/efi_gbl/os_configuration.h
diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..ddee5d40877 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -14,3 +14,4 @@ can be run an UEFI payload.
    u-boot_on_efi.rst
    iscsi.rst
    fwu_updates.rst
+   gbl.rst
diff --git a/lib/uuid.c b/lib/uuid.c
index 16ca8f37751..99227718e72 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -20,6 +20,15 @@
 #include <rng.h>
 #include <linux/ctype.h>
 #include <hexdump.h>
+#include <efi_gbl/avb.h>
+#include <efi_gbl/avf.h>
+#include <efi_gbl/boot_control.h>
+#include <efi_gbl/boot_memory.h>
+#include <efi_gbl/common.h>
+#include <efi_gbl/debug.h>
+#include <efi_gbl/fastboot.h>
+#include <efi_gbl/fastboot_transport.h>
+#include <efi_gbl/os_configuration.h>
 #else
 #include <stdarg.h>
 #include <stdint.h>
@@ -223,6 +232,39 @@ static const struct {
 		EFI_IP4_CONFIG2_PROTOCOL_GUID,
 	},
 #endif
+	/* Android GBL protocol GUIDs */
+	{
+		NULL, "GBL AVB",
+		GBL_EFI_AVB_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL AVF",
+		GBL_EFI_AVF_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL Boot Control",
+		GBL_EFI_BOOT_CONTROL_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL Boot Memory",
+		GBL_EFI_BOOT_MEMORY_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL Debug",
+		GBL_EFI_DEBUG_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL Fastboot",
+		GBL_EFI_FASTBOOT_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL Fastboot Transport",
+		GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_GUID,
+	},
+	{
+		NULL, "GBL OS Configuration",
+		GBL_EFI_OS_CONFIGURATION_PROTOCOL_GUID,
+	},
 	/* Configuration table GUIDs */
 	{
 		NULL, "ACPI table",
@@ -296,6 +338,11 @@ static const struct {
 		"EFI_CERT_TYPE_PKCS7_GUID", NULL,
 		EFI_CERT_TYPE_PKCS7_GUID,
 	},
+	/* Android GBL */
+	{
+		"GBL_EFI_VENDOR_GUID", NULL,
+		GBL_EFI_VENDOR_GUID,
+	},
 #endif
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{ "EFI_LZMA_COMPRESSED", NULL, EFI_LZMA_COMPRESSED },
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 5ae8a30b8a7..aa1842f9921 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -14,6 +14,15 @@
 #include <test/ut.h>
 
 #include <efi.h>
+#include <efi_gbl/avb.h>
+#include <efi_gbl/avf.h>
+#include <efi_gbl/boot_control.h>
+#include <efi_gbl/boot_memory.h>
+#include <efi_gbl/common.h>
+#include <efi_gbl/debug.h>
+#include <efi_gbl/fastboot.h>
+#include <efi_gbl/fastboot_transport.h>
+#include <efi_gbl/os_configuration.h>
 
 /* test UUID */
 #define TEST_SVC_UUID	"ed32d533-4209-99e6-2d72-cdd998a79cc0"
@@ -188,3 +197,116 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
 }
 
 LIB_TEST(lib_test_dynamic_uuid, 0);
+
+static int lib_test_uuid_gbl_efi(struct unit_test_state *uts)
+{
+	static const struct {
+		const char *uuid_str;
+		const char *expected_name;
+		efi_guid_t guid;
+		bool is_protocol;
+	} gbl_guids[] = {
+		{
+			"6bc66b9a-d5c9-4c02-9da9-50af198d912c",
+			"GBL AVB",
+			GBL_EFI_AVB_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"e7f1c4a6-0a52-4f61-bd98-9e60b559452a",
+			"GBL AVF",
+			GBL_EFI_AVF_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"d382db1b-9ac2-11f0-84c7-047bcba96019",
+			"GBL Boot Control",
+			GBL_EFI_BOOT_CONTROL_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"309f2874-ad59-4fd2-af5e-ce0f4ab401a6",
+			"GBL Boot Memory",
+			GBL_EFI_BOOT_MEMORY_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"98ca3da1-c1ac-4402-9c16-7558d3ed5705",
+			"GBL Debug",
+			GBL_EFI_DEBUG_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"c67e48a0-5eb8-4127-be89-df2ed93d8a9a",
+			"GBL Fastboot",
+			GBL_EFI_FASTBOOT_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"edade92c-5c48-440d-849c-e2a0c7e55143",
+			"GBL Fastboot Transport",
+			GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"dda0d135-aa5b-42ff-85ac-e3ad6efb4619",
+			"GBL OS Configuration",
+			GBL_EFI_OS_CONFIGURATION_PROTOCOL_GUID,
+			true,
+		},
+		{
+			"5a6d92f3-a2d0-4083-91a1-a50f6c3d9830",
+			NULL,
+			GBL_EFI_VENDOR_GUID,
+			false,
+		},
+		{
+			"b86bef58-5d90-41f1-b721-b3e3b31505fc",
+			NULL,
+			GBL_EFI_RESET_DATA_GUID,
+			false,
+		},
+	};
+	u8 bin[UUID_SIZE];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gbl_guids); i++) {
+		ut_assertok(uuid_str_to_bin(gbl_guids[i].uuid_str, bin,
+					    UUID_STR_FORMAT_GUID));
+		ut_asserteq_mem(bin, gbl_guids[i].guid.b, UUID_SIZE);
+
+		if (gbl_guids[i].is_protocol &&
+		    (IS_ENABLED(CONFIG_CMD_EFIDEBUG) ||
+		     IS_ENABLED(CONFIG_EFI_CLIENT))) {
+			ut_asserteq_str(gbl_guids[i].expected_name,
+					uuid_guid_get_str(gbl_guids[i].guid.b));
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)) {
+		const efi_guid_t vendor_guid = GBL_EFI_VENDOR_GUID;
+
+		ut_asserteq_str("GBL_EFI_VENDOR_GUID",
+				uuid_guid_get_str(vendor_guid.b));
+		ut_assertok(uuid_guid_get_bin("GBL_EFI_VENDOR_GUID", bin));
+		ut_asserteq_mem(bin, vendor_guid.b, UUID_SIZE);
+		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
+			ut_assertok(uuid_str_to_bin("GBL_EFI_VENDOR_GUID", bin,
+						    UUID_STR_FORMAT_GUID));
+			ut_asserteq_mem(bin, vendor_guid.b, UUID_SIZE);
+		}
+	}
+
+	ut_asserteq_64(0x00010000ULL, GBL_EFI_AVB_PROTOCOL_REVISION);
+	ut_asserteq_64(0x00010001ULL,
+		       GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION);
+	ut_asserteq(1,
+		    GBL_EFI_PROTOCOL_MAJOR_REV(GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION));
+	ut_asserteq(1,
+		    GBL_EFI_PROTOCOL_MINOR_REV(GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION));
+	ut_asserteq(8, sizeof(struct gbl_efi_slot_info));
+
+	return 0;
+}
+
+LIB_TEST(lib_test_uuid_gbl_efi, 0);
-- 
2.56.1.831.g720f3f5937-goog

