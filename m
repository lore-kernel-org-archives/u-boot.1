Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CA8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 21:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA44889A2;
	Mon, 29 Apr 2024 23:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AjXFBmL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E79889A0; Mon, 29 Apr 2024 23:49:41 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C21880DB
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 23:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TLnakD060646;
 Mon, 29 Apr 2024 16:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714427376;
 bh=AfGEIOhbAGKgq8lqcrcszw+i5uIJZ5t2JEGUOzZ/vkc=;
 h=From:To:Subject:Date;
 b=AjXFBmL52n9wH2gUcgmRdzo4hme20vyj7vgcW2cnkVGKlGS8mUqSHyRQlPaHFJgHx
 saRqxq0KBQuiDQWfwJo2+yV4ZmP3j/h0niy9yts/1wCSu/hJM359ucVwhMpAPgaQoU
 Jx7uNbUrVLlNb1l1ueMUUGRNZOkpx3lumhz2lmj4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TLnapK043157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Apr 2024 16:49:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 16:49:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 16:49:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TLnavH097076;
 Mon, 29 Apr 2024 16:49:36 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: [PATCH] configs: am62x_evm_r5: Increase size of malloc_simple heap
 after relocation
Date: Mon, 29 Apr 2024 16:49:36 -0500
Message-ID: <20240429214936.15187-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
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

On AM62x SK we can see a boot failure with signature "alloc space
exhausted", so fix by increasing size of SPL_STACK_R_MALLOC_SIMPLE_LEN.

Fixes: 128f81290b ("arm: dts: k3: binman: am625: add support for signing TIFSSTUB Images")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/am62x_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 4b2e57b13a0..648241488ed 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y

base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
-- 
2.43.2

