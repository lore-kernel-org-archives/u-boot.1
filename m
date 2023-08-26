Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BE7C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F29086B40;
	Sat, 26 Aug 2023 11:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9093A86B37; Sat, 26 Aug 2023 11:07:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E882286B34
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBB11FB;
 Sat, 26 Aug 2023 02:07:47 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7293F740;
 Sat, 26 Aug 2023 02:07:05 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 3/5] capsule: Add the capsule-key property for removal
 from devicetree
Date: Sat, 26 Aug 2023 14:36:31 +0530
Message-Id: <20230826090633.239342-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
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

The capsule-key property contains the public key in the form of an EFI
Signature List(ESL) structure. This property is relevant only in
U-Boot, and is not to be passed to the OS. Register for purging this
property from the devicetree, before passing it to the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index af8a2ee940..5c6c87458f 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -9,6 +9,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <common.h>
+#include <dt-structs.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <env.h>
@@ -403,6 +404,12 @@ out:
 
 	return status;
 }
+
+DT_NON_COMPLIANT_PURGE(capsule_key) = {
+	.node_path	= "/signature",
+	.prop		= "capsule-key",
+};
+
 #endif /* CONFIG_EFI_CAPSULE_AUTHENTICATE */
 
 static __maybe_unused bool fwu_empty_capsule(struct efi_capsule_header *capsule)
-- 
2.34.1

