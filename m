Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684A5CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490CF890B9;
	Thu, 10 Oct 2024 07:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="kp+XRAVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64568911A; Thu, 10 Oct 2024 07:56:00 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450208909B
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20241010055556d4faaae2c5c3a88cfc for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=crvIBNMRVdst8Ptbi0etmgNingRc1mo0IL2pglxwKus=;
 b=kp+XRAVhjPZD/4F5I4t+nqVTgEkxFMxZCHWMsvtsbMqmQvY+BxsDo70PI76BsCZhd4bL20
 +OHYtHJ66h/0esNdEBU5IeJzJRxWIncKdLSZH2Mvy9IUwbaZF70J92KKV9SZWV5Uymy44ZtI
 DrX+yuxw5r4PxQ5eLReH+dZXLI1IjF9n5//TZmGfvVe0B+Mpn7udn/SUrlborDpfXCvAwFc7
 v2zKQDZNsqMbGhhMzBisXEuBQzaDB3tzHw+lUHL9wGGr13SH+5sHitPxjFX3EOGfzRguAESq
 qiSurbfBsZDiV1/OcOnc1HxqQINji6vMwFRwuQbWwmuuqxIS+6I/Dkfg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 02/11] board: siemens: iot2050: Fix coding style
Date: Thu, 10 Oct 2024 07:55:46 +0200
Message-ID: <c6b3339edb040c3afabf282b36cbb3cb13b1961a.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

Add a space after the 'if'

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index ed292c364a5..e5c7ce58b06 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -220,7 +220,7 @@ void set_board_info_env(void)
 	if (board_is_advanced()) {
 		if (board_is_pg1())
 			fdtfile = "ti/k3-am6548-iot2050-advanced.dtb";
-		else if(board_is_m2())
+		else if (board_is_m2())
 			fdtfile = "ti/k3-am6548-iot2050-advanced-m2.dtb";
 		else
 			fdtfile = "ti/k3-am6548-iot2050-advanced-pg2.dtb";
-- 
2.43.0

