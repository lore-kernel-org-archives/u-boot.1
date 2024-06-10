Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68BCC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8CF8852A;
	Mon, 10 Jun 2024 15:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WYl5ts6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDCF188581; Mon, 10 Jun 2024 15:34:14 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3792B88532
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026450; x=1720618450;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=50xhwt6fC2/YSfAfZVFtv9EK9+eJbfiHPlALzrx0pgk=;
 b=WYl5ts6oKGH+QF6AlXo585MkCicey5mQZ8MVlttLll2uCeGCDAaYXvTGtXCLeyQm
 qZsbL/vq70vZQAm0HRlNGBRoJct+8cMtAwxYYlT/YD9d4iT4W2G9GmrXaK57jSRS
 qrbk+JJyN02em15ZMYr3XWzj1T1CstTW7uKeX+nHED0=;
X-AuditID: ac14000a-03e52700000021bc-e7-666700d2943d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 26.7D.08636.2D007666;
 Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:09 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 04/13] board: phytec: phycore-am62x: Fix CONFIG_SPL_BOARD_INIT
Date: Mon, 10 Jun 2024 15:33:43 +0200
Message-ID: <20240610133352.2473414-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/cSQ3qawYTVrBYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 WN5xgbVgK1fFqVNNTA2MUzi7GDk5JARMJFZOXc7cxcjFISSwhEmiYfVEdgjnMaPEhCf97CBV
 bALqEnc2fGMFsUUEgiR6L31iBLGZBTwktv7dABYXFvCTuHD0FROIzSKgKrFp7xo2EJtXwFJi
 2r7PTBDb5CVmXvoONpNTwErix5q9YL1CQDWLPq1hgagXlDg58wkLxHx5ieats5khbAmJgy9e
 MEPUy0u8uLScBWbmtHOvmSHsUImtX7YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5B
 RmVJarJeSuomRlDIizBw7WDsm+NxiJGJg/EQowQHs5IIr1BGcpoQb0piZVVqUX58UWlOavEh
 RmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGxgrXi5XSd96GslotOz5Dp3ta+nllVnme
 PosX6az9gX6PqwwilJKuLXh31ufh421tLp85LjX7m83vXs1ulX3mXPccy/rZsQcYOY7ZqH3k
 Tbp9Vrnyw5EmM6f4ubyX503l8DKVPh18noulduHmHQKFC2MfrpzFHmXLaiWtPOvD+Zyqf3N/
 KooWKbEUZyQaajEXFScCAJXlq1dnAgAA
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

Make sure spl_board_init() gets compiled by enabling missing
CONFIG_SPL_BOARD_INIT and including hardware.h.

Fixes: 085cd6459dae ("board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore-am62x.c | 1 +
 configs/phycore_am62x_a53_defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 4a76f1343d7..35e1bb96b8d 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -4,6 +4,7 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
+#include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <spl.h>
 #include <fdt_support.h>
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 44f6e77b626..468c0f373b7 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -42,6 +42,7 @@ CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
-- 
2.34.1

