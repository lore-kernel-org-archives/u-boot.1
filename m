Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC72C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B5E80E9A;
	Thu, 26 Jun 2025 14:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hi1iwiXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA85809A5; Thu, 26 Jun 2025 14:05:36 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0141809A5
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QC5TPF1730340;
 Thu, 26 Jun 2025 07:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750939529;
 bh=qxFHz0Y2B1CknYXERJ1kFMv4hB0LYFQjoCDsx/27RSY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Hi1iwiXkfthEorQjGdJvdcON11wOH5tx7Ri86700C2byEkcJmqPaAlZOPQZbDai0B
 CDzPiyGyxBhiXqtjUmVgMBT24VoQtzoKdQyR6COgzT0/tD3cde3LN6NCbFwprabt6p
 0qFE3bpOUgo9C0sLprv1VzkEBEu7+5dLZ6vDR4yY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QC5T2O3573956
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 07:05:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 07:05:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 07:05:29 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QC5Stg967387;
 Thu, 26 Jun 2025 07:05:29 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: [RFC PATCH v1 1/4] spl: Kconfig: add SPL_SECURE_OS_BOOT config symbol
Date: Thu, 26 Jun 2025 17:34:39 +0530
Message-ID: <20250626120443.1405409-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626120443.1405409-1-anshuld@ti.com>
References: <20250626120443.1405409-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch adds the new SPL_SECURE_OS_BOOT symbol that enables secure boot flow
in falcon mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 880192043c4..8d153c2e9c9 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1196,6 +1196,13 @@ config SPL_OS_BOOT
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
 
+config SPL_SECURE_OS_BOOT
+	bool "Activate Secure Falcon Mode"
+	depends on SPL_OS_BOOT
+	help
+	  Enables support for secure boot in falcon mode by restricting the SPL to
+	  only loading a fitImage instead of raw kernel images or DTBs.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
-- 
2.49.0

