Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0F0C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E148F83429;
	Tue,  8 Apr 2025 16:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G5r2EltX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6876E82E0A; Tue,  8 Apr 2025 16:14:56 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C52D82E66
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538EEqgu1195076
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 09:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744121692;
 bh=We0M+R0AFnGltwq+w81AOAEfqH8wuOr9MhfgJcbhznM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G5r2EltX+329sVkeKP8GgInVodaXDgTk16bGHp1yw2CuhujDxZRX57Del1hpH1Lb4
 u2sqPe1ahMToXr/di3xOGqi6Lc2pyBXm/Nqvu/R0AwNsgGVnwHfnWwKWyYNv4WIASw
 nyYroF38FfH0tXuo6XEnuNm8aYhW7vkDa1XCi1GM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538EEqfI004217
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 09:14:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 09:14:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 09:14:51 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538EEpxP119383;
 Tue, 8 Apr 2025 09:14:51 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v7 4/4] configs: colibri_vf: set CMD_BOOTM
Date: Tue, 8 Apr 2025 19:44:33 +0530
Message-ID: <20250408141436.712387-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408141436.712387-1-anshuld@ti.com>
References: <20250408141436.712387-1-anshuld@ti.com>
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

Currently, CMD_BOOTx selects both bootm.o and the respective image.o or
zimage.o for compilation. After the addition of LIB_BOOTx, the behaviour
changes so CMD_BOOTx would not select bootm.o. This leads to build
failure on calibri_vf since it unsets BOOTM while still using BOOTZ.

This was added in commit c5954431eb6c ("configs: colibri_vf: disable
obscure options") to save size but unsetting BOOTM specifically does not
seem to save any space. So the change can be safely reverted

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/colibri_vf_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 3a806243b19..823b4f07460 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -34,7 +34,6 @@ CONFIG_HUSH_PARSER=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="Colibri VFxx # "
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
-- 
2.49.0

