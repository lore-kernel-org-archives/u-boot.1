Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52029C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 12:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E8480C6F;
	Wed, 12 Feb 2025 13:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F3fDJ+SR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F40807C0; Wed, 12 Feb 2025 10:18:32 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA3380BAD
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IRRU500808
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 03:18:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739351907;
 bh=hVzAuy3CzTnfMzkNqhvCtOBQ9cf7L+HGULS/ya9QwVs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F3fDJ+SRCMJe3ibjLm0qQgOw9fyUw/OY3MsTQ3anlQ3FfwABfLsPTJNiQKv95gjNa
 g955OAVfexvuhAIZ+1nlki8AcvkFtWAdpYnxKOcODd6zQsQxOOSnSQOeMa0HJ0VxZ7
 2oS+zAlCwSc/3fugnBDfMpleijbqZBqZjrYGSNiE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IRRe083760
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Feb 2025 03:18:27 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 03:18:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 03:18:27 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51C9ILKR067685;
 Wed, 12 Feb 2025 03:18:24 -0600
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config to use subnode's
 bootph property for binding drivers
Date: Wed, 12 Feb 2025 14:48:19 +0530
Message-ID: <20250212091820.213895-2-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212091820.213895-1-m-shah@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 12 Feb 2025 13:56:52 +0100
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

Add a new config when set will traverse through all the subnodes of
a given node scanning for bootph-all property and propagate it to
all of its parent node up the hierarchy.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 arch/arm/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 314916527c9..51fc952b0db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -805,6 +805,7 @@ config ARCH_K3
 	select FIT
 	select REGEX
 	select FIT_SIGNATURE if ARM64
+	imply BIND_FROM_CHILD_BOOTPH
 	imply TI_SECURE_DEVICE
 
 config ARCH_OMAP2PLUS
@@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
 	  Path within the source directory to the kwbimage.cfg file to use
 	  when packaging the U-Boot image for use.
 
+
+config BIND_FROM_CHILD_BOOTPH
+	bool "Bind drivers from bootph* in subnode"
+	depends on ARCH_K3
+	help
+	 This config must be set to bind drivers in pre reloc stage whose
+	 compatible parent nodes are implicitly declared to be bound to
+	 their respective drivers by having bootph* property in one of
+	 their subnodes.
+
 source "arch/arm/mach-apple/Kconfig"
 
 source "arch/arm/mach-aspeed/Kconfig"
-- 
2.34.1

