Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B40E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED6880583;
	Fri, 20 Dec 2024 21:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nzhMlpfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A42805C8; Fri, 20 Dec 2024 21:37:14 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AA7804F9
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4HV004852;
 Fri, 20 Dec 2024 14:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734727024;
 bh=IawYXdQMBy+4SdPA0KPpUMRJ6qtgDnujvTrs0Q1nly8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nzhMlpfVzAKnaA3jotr9t4OJttThkiNxgiUb4UNzB7jg4EJv8ZLVOPyYmOiTeqjxZ
 yYdb5Abwm+hc8zPjlQjE0mgOZykcW+TFcJLbb1R3JENy/IwXGTh3yIvWeJN4BTMA8i
 vOPw5eVtDKOBemCOlr5vbi0ZSTwMJq0G0Z8NVanQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKKb4wl002581
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 14:37:04 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 14:37:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 14:37:04 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4ST106394;
 Fri, 20 Dec 2024 14:37:04 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH RESEND 6/7] configs: am62ax_evm_a53_defconfig: Enable
 MMC_SPEED_MODE_SET
Date: Fri, 20 Dec 2024 14:37:03 -0600
Message-ID: <20241220203704.2076499-7-jm@ti.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220203704.2076499-1-jm@ti.com>
References: <20241220203704.2076499-1-jm@ti.com>
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

Enable MMC_SPEED_MODE_SET config option in defconfig to enable
changing MMC bus modes with mmc rescan for am62ax device.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/am62ax_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index a070182cd14..5e80c68605c 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-- 
2.47.1

