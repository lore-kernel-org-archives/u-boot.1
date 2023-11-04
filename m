Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1245AC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0ECD87206;
	Sat,  4 Nov 2023 08:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EycUFkpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540B2871E7; Sat,  4 Nov 2023 08:22:44 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629F787149
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Ls8u061061;
 Sat, 4 Nov 2023 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082514;
 bh=O48QxO8DFCl9DskEQNd0N4NTqv9z6Pn+WH0AxxfdQeU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EycUFkpI40h6mtRpXp+RBle0LBWE9grWdLAcL372P+K8a9Ih3A8oLwwwjcLAV5ENW
 dwHGwuI5tWeAmCJtewvNPGNHLDYWtls0rembsw++PuYLIary3AxBy0JKHm0JL21MSB
 DkrJRgDBcd+QpGcuEicK5PVpS9W7NkB6tEqM5ldE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LsCd001176
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Ls9O067681;
 Sat, 4 Nov 2023 02:21:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 11/12] configs: j7200_evm_a72_defconfig: Switch to bootstd
Date: Sat, 4 Nov 2023 02:21:49 -0500
Message-ID: <20231104072150.3339-12-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
MIME-Version: 1.0
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

Switch to using bootstd. Note with this change, we will stop using
distro_bootcmd and instead depend entirely on bootflow method of
starting the system up.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 configs/j7200_evm_a72_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 889358afc316..b7bc9ad178f6 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -29,10 +29,11 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.37.2

