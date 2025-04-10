Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA6C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5FA83AA4;
	Thu, 10 Apr 2025 10:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="BT3CzKb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C595383A61; Thu, 10 Apr 2025 10:41:28 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BDB83A5C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ww03lubTi/v8RLliYdlyK0LkI6av4faBh0CcPfe3Q6c=; b=BT3CzKb8U25hkus7exwe3Zu/RX
 ST4V06BW7i1xZpSCa5SZOQVT9u7Kv7KEkKY7jknFssGMXhQtG13t/YnAJms9CLeMSwrhiV+88/Lq+
 eK9rShAF0FzDm7rZgEQ9UqJs/t7gd6HkEhMBBee07Ry52M3wkxRQcE1wHmAnD01NUyWn5uJfboz3W
 BLddCGQC5596i+jSCuWd2f4/U6PsAPrxaS588JDoYWuHLNZdX34BhEhCCuTogq8ySpj/sQuTM6ZJc
 ScF43fhyFI2BSnWi9DN2sfifVEJFj0grZmV7uue2xTKMPvcVzPzVDvvKbvHmNi4i3JvFrUV6dkkZ9
 7oVITe5A==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-0L;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 1/6] board: phycore-imx93: env: Move fdt and bootenv addresses
Date: Thu, 10 Apr 2025 10:41:17 +0200
Message-Id: <20250410084122.1010297-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410084122.1010297-1-primoz.fiser@norik.com>
References: <20250410084122.1010297-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Move the load addresses for FDTs and bootenv.txt to create space for
loading OS image. Otherwise, parts of the image might get corrupted.
and the following boot error will be present:

  ERROR: FDT image overlaps OS image (OS=80400000..832a0000)

Moreover, this commit also syncs addresses with downstream PHYTEC
u-boot for i.MX93 in preparation for FIT image support in the future.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index ab65cfce5fd1..9c70c40b2fca 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -4,9 +4,9 @@
 
 image=Image
 console=ttyLP0
-fdt_addr_r=0x83000000
-fdtoverlay_addr_r=0x830c0000
-bootenv_addr_r=0x83500000
+fdt_addr_r=0x90000000
+fdtoverlay_addr_r=0x900c0000
+bootenv_addr_r=0x90500000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 ip_dyn=yes
 mmcdev=CONFIG_SYS_MMC_ENV_DEV
-- 
2.34.1

