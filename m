Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F73AC83F16
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C67786B39;
	Sat, 26 Aug 2023 11:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6E086B48; Sat, 26 Aug 2023 11:07:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4BFA586B34
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEC91FB;
 Sat, 26 Aug 2023 02:07:45 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0EB03F740;
 Sat, 26 Aug 2023 02:07:02 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 2/5] fwu: Add the fwu-mdata node for removal from
 devicetree
Date: Sat, 26 Aug 2023 14:36:30 +0530
Message-Id: <20230826090633.239342-3-sughosh.ganu@linaro.org>
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

The FWU metadata devicetree node points to the device which stores the
metadata structure. This node is relevant only in U-Boot, and is not
to be passed to the OS. Register for purging this node from the
devicetree, before passing it to the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 drivers/fwu-mdata/fwu-mdata-uclass.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
index 0a8edaaa41..71411d9c19 100644
--- a/drivers/fwu-mdata/fwu-mdata-uclass.c
+++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <dt-structs.h>
 #include <efi_loader.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
@@ -53,3 +54,7 @@ UCLASS_DRIVER(fwu_mdata) = {
 	.id		= UCLASS_FWU_MDATA,
 	.name		= "fwu-mdata",
 };
+
+DT_NON_COMPLIANT_PURGE(fwu_mdata) = {
+	.node_path	= "/fwu-mdata",
+};
-- 
2.34.1

