Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FECF9C7E
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 15:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EBAE88B6D;
	Wed, 25 Sep 2024 17:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KeLS4J1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D186B88BD2; Wed, 25 Sep 2024 17:14:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B4D88BCF
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 17:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDvjF102754;
 Wed, 25 Sep 2024 10:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727277237;
 bh=AD49vW7Yh+GMjGX6aVJESHz4cU1bQexnwjlEGHkD/zs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KeLS4J1YuJ8JhGTXP5LIrKPx4BQv7jZgTC39EG3+VwTVciuaxTOnC31YaUSUfQWN7
 y7SV/7aD/qWMs6NEc6gtw2GxZJh/oPiTxBvi+rIqzNyvkd0Ivpyao12jfypunkrKIC
 IWp+a5Er24Zf3dSh0vQHr+eTkomNODaltjGiUhmA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDvl6111998;
 Wed, 25 Sep 2024 10:13:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 10:13:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 10:13:57 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDuRe017913;
 Wed, 25 Sep 2024 10:13:57 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <sjg@chromium.org>, <agust@denx.de>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
 <j-humphreys@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <akashi.tkhro@gmail.com>,
 <mkorpershoek@baylibre.com>, <eajames@linux.ibm.com>,
 <caleb.connolly@linaro.org>, <quentin.schulz@cherry.de>,
 <martinstolpe@gmail.com>, <iivanov@suse.de>, <n-jain1@ti.com>,
 <devarsht@ti.com>
Subject: [PATCH 1/3] boot/Kconfig: Add Video Kconfig as dependency for
 FDT_SIMPLEFB
Date: Wed, 25 Sep 2024 20:43:52 +0530
Message-ID: <20240925151354.480704-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240925151354.480704-1-devarsht@ti.com>
References: <20240925151354.480704-1-devarsht@ti.com>
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

The fdt_simplefb.c APIs rely on video-uclass APIs and structures to
fill/update framebuffer information, so compile it only when VIDEO
Kconfig is enabled, as otherwise below warning can be seen if VIDEO
Kconfig is disabled:

"boot/fdt_simplefb.c:96:12: warning: fdt_simplefb_enable_existing_node
defined but not used [-Wunused-function]
96 | static int fdt_simplefb_enable_existing_node(void *blob)"

Reported-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index de277d2ba50d..56f2bb59a1e5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1583,6 +1583,7 @@ config FDT_FIXUP_PARTITIONS
 
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
+	depends on VIDEO
 	help
 	  Enable the fdt tools to manage the simple fb nodes in device tree.
 	  These functions can be used by board to indicate to the OS
-- 
2.39.1

