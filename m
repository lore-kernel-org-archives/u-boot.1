Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8171CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020318344E;
	Tue, 23 Sep 2025 15:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q4ZWt9hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906F683510; Tue, 23 Sep 2025 15:09:12 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD3D83443
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND96Ch1480001;
 Tue, 23 Sep 2025 08:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632946;
 bh=E4n/7CZvdyNO54FcaindUUXI5oxjtoYqLuEEvTrwboo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=q4ZWt9hpBreUoHWhKpXH6++/qtQR66UCKUI2zSQ0s7aiemxRpAfiiAY9tZjmIppFw
 sqhsZGPJX+V4fKhDotx4QqACO+FpjTdMN0DY2Rbm/dKkN6piFpjzu1Pz++aIi83dQY
 0fIqYErFsCEvyo/hy9Qc3qbjC7o6u8+mZRB5FNL4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND96sP2800499
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:06 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:05 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND94r8083692;
 Tue, 23 Sep 2025 08:09:05 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 1/8] spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
Date: Tue, 23 Sep 2025 18:38:53 +0530
Message-ID: <20250923130901.705124-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923130901.705124-1-anshuld@ti.com>
References: <20250923130901.705124-1-anshuld@ti.com>
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
index ab05536bd02..7e87e50f693 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1206,6 +1206,14 @@ config SPL_OS_BOOT
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

