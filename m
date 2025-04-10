Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA8AC369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A7983A5F;
	Thu, 10 Apr 2025 10:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="TgDMQasB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93F183A88; Thu, 10 Apr 2025 10:41:28 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E2D83A57
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
 bh=mMY5ADLBI89vQNY9w8hCl/fnwXeMeaszwxlCcyhPlPI=; b=TgDMQasBJKbC5fhC9XUc1aedQS
 GNXRq1PC7fKUvAjpRLi+GvCQ7TfQ3wdxolDWpXvSSoYtw5LXwaOrYSHzaMrZwt5v0F6iakKxPbTQh
 2IgKI7pwakTSBHjPvvqySAD3JC5fmnE+WQim36+qrZhxp6vOwozrDJDae8Cg/jsjZzEKXUH3qj25e
 pjt1tBuDN8eOjIarAxROdWSM8hNzRPzPQNB/ilz0jB+W/KPGxBJR3f9CzLRW7yOlqD4+pccJoD5M1
 RWVD/BoU23nKnF/udUpVtDELFDF7DmwDMHIRY94zelikapKJ5IeRuHJK/qBDjpdixaKtXs6l3t/7G
 2XHEH6oQ==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-0X;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 2/6] board: phycore-imx93: env: Add optargs to environment
Date: Thu, 10 Apr 2025 10:41:18 +0200
Message-Id: <20250410084122.1010297-3-primoz.fiser@norik.com>
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

Add the optargs variable so we can set optional arguments while booting.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 9c70c40b2fca..36bf3fefa0ba 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -14,7 +14,7 @@ mmcpart=1
 mmcroot=2
 mmcautodetect=yes
 mmcargs=setenv bootargs console=${console},${baudrate} earlycon
-	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
+	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw ${optargs}
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=
@@ -31,7 +31,7 @@ mmcboot=
 	fi;
 nfsroot=/nfs
 netargs=setenv bootargs console=${console},${baudrate} earlycon
-	root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+	root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp ${optargs}
 netboot=
 	echo Booting from net ...;
 	run netargs;
-- 
2.34.1

