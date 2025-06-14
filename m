Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CDDC71135
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 09:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA73A8283E;
	Sat, 14 Jun 2025 11:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lPdbLP4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2F680050; Sat, 14 Jun 2025 11:37:52 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3F6808AF
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 11:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55E9bZYS3323540;
 Sat, 14 Jun 2025 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749893855;
 bh=iQJBcsUgxjq9hcTdUFtrmm7wqyGAQ68urUBAkUQk1RY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lPdbLP4qg9gqmFQTcOqctwJ0aj0y/DK77pudswLj/gynQSLFVxDYgXs+E1Py6sRKP
 7+m7RMP51b8LIPP/ch1fZDmbBlNhhpHux2xiUINqU23ECN8VVcuoYPd4ety+TeN0sh
 xlnj7GyKo59jz/byQk7mymBXsZZWIXtOfeDGrmko=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55E9bYPs3217764
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sat, 14 Jun 2025 04:37:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 14
 Jun 2025 04:37:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 14 Jun 2025 04:37:34 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55E9bOPq840286;
 Sat, 14 Jun 2025 04:37:29 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <ggiordano@phytec.com>, <wegorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <jm@ti.com>, <n-francis@ti.com>,
 <bb@ti.com>, <vitor.soares@toradex.com>, <contact@paulk.fr>,
 <Oliver.Gaskell@analog.com>, <marex@denx.de>,
 <jerome.forissier@linaro.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 1/2] Kconfig: Add default malloc size of K3 ARCH
Date: Sat, 14 Jun 2025 15:07:16 +0530
Message-ID: <20250614093717.2479920-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614093717.2479920-1-u-kumar1@ti.com>
References: <20250614093717.2479920-1-u-kumar1@ti.com>
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

Many boards of K3 overwrites default malloc size, instead
of doing at almost each board level,
Add default size at Kconfig.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 51358633762..05b7f410fa5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -309,7 +309,7 @@ config SYS_MALLOC_F_LEN
 config SYS_MALLOC_LEN
 	hex "Define memory for Dynamic allocation"
 	default 0x4000000 if SANDBOX
-	default 0x2000000 if ARCH_ROCKCHIP || ARCH_OMAP2PLUS || ARCH_MESON
+	default 0x2000000 if ARCH_ROCKCHIP || ARCH_OMAP2PLUS || ARCH_MESON || ARCH_K3
 	default 0x200000 if ARCH_BMIPS || X86
 	default 0x4020000 if SUNXI_MINIMUM_DRAM_MB >= 256
 	default 0x220000 if SUNXI_MINIMUM_DRAM_MB >= 64
-- 
2.34.1

