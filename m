Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55115CFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 23:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8389488AB9;
	Mon,  7 Oct 2024 01:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728256318;
	bh=LOnHVx09Tyg1LHn2+1rAqzdmmNUObVFaXcJQGDAa4wA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qRbOcKudWinhbOhgAa/oHEu72fUqWDrCSMrQMtJpsve2gQ1X/hxpJV8ret0ov5cVf
	 oKtqS9VZUkYSo2NkG+s4d5YKTS7W/amr1qzrwbFIwXDb75ceM3UmkbI+CEYTiQ7f6G
	 0TW4+2ZWrdQZ8N1ms9fkqyNmJnDnoXXW7TRZQjLv2yeZa1sF9uXTqadJ2/bFtCG27u
	 /Xk9HeZ/IPnc7tknAg9UUfjsetfR1IZzlJQF2mQ79bE27xiASfeWbQ733gSQbQ31w3
	 nd/tGWGPHkh+0V2Jopl1kakuFmzYyZkUqMOdEhkjrUIq4Oy5m5ng6l3HdsfvzLzzyu
	 mVV0zXD8GbXsw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1EE9D887FA;
 Mon,  7 Oct 2024 01:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728256317;
 bh=LOnHVx09Tyg1LHn2+1rAqzdmmNUObVFaXcJQGDAa4wA=;
 h=From:To:Cc:Subject:Date:From;
 b=pqp82xpQ5mYzA5foZ2U/XPHygc8XSOqOhsWI3TmE4EMff0eijd2seGEWgrWI7cwVw
 Zd1Zf+ZJ/9GXljOzQT/k4B+hkwpM5yn3UWxhe9oaKzEpMFOYw30nSpf7O56CYdONFP
 7RQUzyvwSUqG1BOteHWW+vx8y/p6BVbaq5N9cjFuMU8uRrBfS2z5sqvW0xV9H20Enq
 pgyuImC0REY4BNbU4+TGSHDlP7aN1bffT9DOxwP1fNgcsx7jFfC/IzfPBuen7S4Z38
 FNnD7AGH92SM9FpEbpPTeZ3W0QClkq699/joU8Wu14C5KFe3Zyj9Q7UawAurGypeNi
 wQfGUSXqQvssA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/2] ARM: imx: Update MAINTAINERS file globs for i.MX6 DHSOM
Date: Mon,  7 Oct 2024 01:11:09 +0200
Message-ID: <20241006231142.126771-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the MAINTAINERS file glob to cover all of i.MX6 DHSOM related files.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx6/MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/dh_imx6/MAINTAINERS b/board/dhelectronics/dh_imx6/MAINTAINERS
index 8f9b5ff2dca..472e908e278 100644
--- a/board/dhelectronics/dh_imx6/MAINTAINERS
+++ b/board/dhelectronics/dh_imx6/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Andreas Geisreiter <ageisreiter@dh-electronics.de>
 M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
 L:	u-boot@dh-electronics.com
 S:	Maintained
-F:	board/dhelectronics/dh_imx6/
-F:	include/configs/dh_imx6.h
-F:	configs/dh_imx6_defconfig
+N:	imx6.*dh[cs]o
+N:	dh_imx6
-- 
2.45.2

