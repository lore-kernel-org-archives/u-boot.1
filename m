Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946E0CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 19:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D7E87455;
	Thu, 19 Oct 2023 21:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="JKTbO2nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244BA8745B; Thu, 19 Oct 2023 21:42:50 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12088729D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 21:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=MSIrM1uyAV07j/Th1JwlLO92ljK5MiKTOLuOrZlbWNU=; b=JKTbO2nZfInItqCe9v1TkSgXcD
 eq+zEBYaq2TVV2TD3Hw/mEWHRSWFcPv37BR+LZJVc50QGV5r8l1nR6T+C+zskLBYAOp2rJVBxIU9R
 RyXDbiRoZxpewRfa2LKGMTW3xBc2cHaYahRlj96R/KvB2W/dNmh5VhL4OD4C3BZYTHK0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45704
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtYup-0008Gy-5y; Thu, 19 Oct 2023 15:42:43 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	u-boot@lists.denx.de
Date: Thu, 19 Oct 2023 15:42:41 -0400
Message-Id: <20231019194241.2207814-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] imx8mn_var_som: Add myself to MAINTAINERS
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

I would like to help maintaining the imx8mn_var_som symphony board.

Add myself to MAINTAINERS.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/imx8mn_var_som/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/variscite/imx8mn_var_som/MAINTAINERS b/board/variscite/imx8mn_var_som/MAINTAINERS
index 068f807ae69..367f72dfe4f 100644
--- a/board/variscite/imx8mn_var_som/MAINTAINERS
+++ b/board/variscite/imx8mn_var_som/MAINTAINERS
@@ -1,5 +1,6 @@
 ARM i.MX8MN VARISCITE VAR-SOM-MX8MN MODULE
 M:	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
+M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 S:	Maintained
 F:	arch/arm/dts/imx8mn-var-som*
 F:	board/variscite/imx8mn_var_som/

base-commit: 4655b75335384e040358a2e3e478cc42f32a96c9
-- 
2.39.2

