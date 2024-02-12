Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C86C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 19:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C0F87ED5;
	Mon, 12 Feb 2024 20:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZYyvzpU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A8C87ED0; Mon, 12 Feb 2024 20:47:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24865874BA
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 20:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CJlR4H127400;
 Mon, 12 Feb 2024 13:47:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707767247;
 bh=n7bevE4Ne6ZU21sLRGS5orNZTv0w3gGXI3AqQPaIJK0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZYyvzpU6hDSlkTm311yNrbGQHljh0MFRlcsQh5yu73aVrW8qGHF6gaUADaRt7aBtj
 ooSa15mc+bzLBm0tm5K+0x6jzOc0NqMC/wlaNExBVHraqq5yhEe6XADpTq+M8/znxw
 VphLuHcEC7TEc/dFLXNlKwZ53rQ0omX05vvBv02A=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CJlRIn010211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 13:47:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 13:47:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 13:47:26 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CJlQ42005871;
 Mon, 12 Feb 2024 13:47:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 01/11] board: ti: Add missing common/Kconfig references
Date: Mon, 12 Feb 2024 13:47:16 -0600
Message-ID: <20240212194726.1093771-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212194726.1093771-1-nm@ti.com>
References: <20240212194726.1093771-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add missing board/ti/common/Kconfig references for the platforms that
missed it. The intent is for the common Kconfig to be usable across TI
reference boards as required.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V3:
* No change

V3: https://lore.kernel.org/r/20240130130615.670783-2-nm@ti.com

 board/ti/omap3evm/Kconfig | 2 ++
 board/ti/panda/Kconfig    | 2 ++
 board/ti/sdp4430/Kconfig  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/board/ti/omap3evm/Kconfig b/board/ti/omap3evm/Kconfig
index 08a8aa20ae85..cd71fe083176 100644
--- a/board/ti/omap3evm/Kconfig
+++ b/board/ti/omap3evm/Kconfig
@@ -9,4 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "omap3_evm"
 
+source "board/ti/common/Kconfig"
+
 endif
diff --git a/board/ti/panda/Kconfig b/board/ti/panda/Kconfig
index 8f277b612a45..5912f69babe2 100644
--- a/board/ti/panda/Kconfig
+++ b/board/ti/panda/Kconfig
@@ -9,4 +9,6 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "omap4_panda"
 
+source "board/ti/common/Kconfig"
+
 endif
diff --git a/board/ti/sdp4430/Kconfig b/board/ti/sdp4430/Kconfig
index 36f185282166..65e9107bc1b0 100644
--- a/board/ti/sdp4430/Kconfig
+++ b/board/ti/sdp4430/Kconfig
@@ -12,4 +12,6 @@ config SYS_CONFIG_NAME
 config CMD_BAT
 	bool "Enable board-specific battery command"
 
+source "board/ti/common/Kconfig"
+
 endif
-- 
2.43.0

