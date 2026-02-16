Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F5CE63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAC78063E;
	Mon, 16 Feb 2026 18:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="tlRqAg3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23EF8063E; Mon, 16 Feb 2026 18:28:53 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DBE80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=CP7i+uj4UMIkE/OcnEaM7fnx4foAFZqz/b/9xexmTw0=; b=tlRqAg3TQcwiLVu+nOQ+OxjzX1
 EJACTiTXAsW4sTVdwDA0cH5aloC/CyOWI44gtlD4MhWWmaWQcMqJVM8RaeNrTBdcnSGWmfIPafhXW
 fRuABoBOsOoNMNXSw/2S0Z/VOXskm1Ug50a9wQW2QHzPJleiwPzCGhTtpxmquAd8nTnc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:38596
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1vs2Oq-00029M-O9; Mon, 16 Feb 2026 12:28:45 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Mon, 16 Feb 2026 12:28:39 -0500
Message-ID: <20260216172843.1102036-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] drivers: cpu: fix syntax error in Kconfig documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace then -> they so that the sentence makes sense.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/cpu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 4cc3679c009..6a96be94de4 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -3,7 +3,7 @@ config CPU
 	help
 	  This allows drivers to be provided for CPUs and their type to be
 	  specified in the board's device tree. For boards which support
-	  multiple CPUs, then normally have to be set up in U-Boot so that
+	  multiple CPUs, they normally have to be set up in U-Boot so that
 	  they can work correctly in the OS. This provides a framework for
 	  finding out information about available CPUs and making changes.
 

base-commit: dffccda75cc68fb9cee3a17b34e6d9a9c27feb39
-- 
2.47.3

