Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964ACD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4D8836D;
	Tue,  9 Apr 2024 00:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UKs26Xl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1E6880FE; Tue,  9 Apr 2024 00:32:14 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B759E880DB
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 00:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438MVwug111536;
 Mon, 8 Apr 2024 17:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712615518;
 bh=YvS5JCQ1zctBXJMcgUS5xnAVlyNXFK5GspTMWluc3sI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UKs26Xl797cB+N2LTpdHPb6diaqltacjrJLsFYsd2zoM8EuzX1l8pyst35QcPzbaX
 rrZMeax/82gl8IfTeOtOhGWBOc0WM40Y588uDnYqW9oB3UL4UYnEa6Kj+872y2ra67
 VKAtRsfmVQe8ADm7yOKRkcPlsYhxPx/RZM9Enlig=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438MVwkb003377
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 17:31:58 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 17:31:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 17:31:57 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438MVvho081164;
 Mon, 8 Apr 2024 17:31:57 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 01/16] board: Define GUIDs for firmware images
Date: Mon, 8 Apr 2024 17:31:19 -0500
Message-ID: <20240408223134.165877-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408223134.165877-1-j-humphreys@ti.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
u-boot.img, sysfw).

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 include/configs/ti_armv7_common.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
index 3def7b1027e..4ce14a9b84c 100644
--- a/include/configs/ti_armv7_common.h
+++ b/include/configs/ti_armv7_common.h
@@ -16,6 +16,23 @@
 #ifndef __CONFIG_TI_ARMV7_COMMON_H__
 #define __CONFIG_TI_ARMV7_COMMON_H__
 
+/* GUIDs for capsule updatable firmware images */
+#define K3_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
+		 0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
+
+#define K3_SPL_IMAGE_GUID \
+	EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
+		 0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
+
+#define K3_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
+		 0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
+
+#define K3_SYSFW_IMAGE_GUID \
+	EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
+		 0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
+
 /*
  * We setup defaults based on constraints from the Linux kernel, which should
  * also be safe elsewhere.  We have the default load at 32MB into DDR (for
-- 
2.34.1

