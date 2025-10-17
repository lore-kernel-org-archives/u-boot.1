Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA7ACCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699A583835;
	Fri, 17 Oct 2025 21:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W1eWqWbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9848386D; Fri, 17 Oct 2025 21:33:29 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FFAE83835
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HJXNOm2345158;
 Fri, 17 Oct 2025 14:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760729603;
 bh=+BITsmJHBtrVX3VatpAe9xy1FPZ8bPGUXMl5qZJH/P0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W1eWqWbU/1WK8brY2qlP5EjdJK23FtDgIMdm2t02yYMcZ6FSon2PuMZ9VlYmvT784
 WAlC5+ciEhRdW+uxrEQ74D3bdsgBSTgj2Ll0BzzGTb99f31YEWnX8XgQZJ558dSW+X
 yuOZ/0XJuv+CZsBIISwYpd7PBenOYtWIcmQhwdn0=
Received: from DFLE211.ent.ti.com (dfle211.ent.ti.com [10.64.6.69])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HJXNfB2627216
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 14:33:23 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 14:33:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 14:33:22 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HJXL1C1795011;
 Fri, 17 Oct 2025 14:33:22 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 1/7] spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
Date: Sat, 18 Oct 2025 01:03:06 +0530
Message-ID: <20251017193318.4124997-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017193318.4124997-1-anshuld@ti.com>
References: <20251017193318.4124997-1-anshuld@ti.com>
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

This patch adds the new SPL_OS_BOOT_SECURE symbol that enables secure
boot flow in falcon mode. This symbol can be used to disable certain
inherently insecure options during falcon boot.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4ece5d168f9..ba94d6fe05a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1207,6 +1207,14 @@ config SPL_OS_BOOT
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
 
+config SPL_OS_BOOT_SECURE
+	bool "Allow Falcon Mode on secure devices"
+	depends on SPL_OS_BOOT
+	help
+	  This allows for secure devices with signature verification capabilities
+	  to use falcon mode by disabling certain inherently non-securable options
+	  in the SPL boot flow.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
-- 
2.51.0

