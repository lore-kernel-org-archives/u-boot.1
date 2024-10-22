Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F57D1CDA0
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C2988F8E;
	Tue, 22 Oct 2024 08:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="XjWc1u5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4036E88FA9; Tue, 22 Oct 2024 08:04:36 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986AE88F31
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20241022060432088616a28753a3305d for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=crvIBNMRVdst8Ptbi0etmgNingRc1mo0IL2pglxwKus=;
 b=XjWc1u5a0bQOvZnkyRE0hxg/SeUORQ4TKtEhGTS1ywvG0shpUzhtddx0Bt4K9kLp4grIhq
 Ky0JYHQiI+OndsNB70yRRLxA/ipxswCcutGZ994++V2A0T6234AIdJbEdGeJcUqFgfNqTVKl
 68aHWrY9jAX7vgxE8SFOn0JG4GNF8PyTOctKug35KYXjJGm3VTaN6yJsOCtk6aTt6xXx/fC/
 IbPPP+dc3TsDUHq0yzxPzNOVNulV59yaitLmjwSbm080zy8lk85t8EgU7CURK+5a127xGLsc
 onUozhYtwrkt3M8toPJZszf5FoADDSEJChw0ciV6g7OchbecvauIsUfg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 02/13] board: siemens: iot2050: Fix coding style
Date: Tue, 22 Oct 2024 08:04:19 +0200
Message-ID: <c630ad625721781c16e9247f5c123775294c74d5.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
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

