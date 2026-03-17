Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB0BFD8741
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7E984248;
	Tue, 17 Mar 2026 12:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="l0YC5Fv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC8B840C1; Tue, 17 Mar 2026 08:25:17 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714D2840B0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=realsil.com.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javen_xu@realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H7OxWR23468829,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1773732300;
 bh=4LW6jzB5z8lu9zyF4WWg8/kdtY2j3OR6vAPAdqGLm8o=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=l0YC5Fv/6mZAps1Z9I3U/JAnKUFY00r7NXX4QNUshTutO2KFDycOltGQO2RVQnLtm
 cOT1G61nr44ZC5kEMi37YrZvsbWjawsw9Ohe/WXZDev0mCapdmvcs+RsIM/Q022zRi
 x9oynGc+AKJrH/RKJ2hvooeC7zRi4QZ1NNpMLq18gXLfbQV9IaPsRreIPEB+7a9vHV
 ijHeHUFw7cv/KmiQ743C+yXhJ6P2N642EC6GCHxrjLw5ZZ/LaT/4MLzkl4BxrYHfqZ
 +Ojbj/oXJACGIdq/OaBySYVZRnset48sTyTybeVMjHxuUUPH3baC5c03HEoWTBIls4
 hteIwS/6xb0rA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H7OxWR23468829
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Mar 2026 15:25:00 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 15:24:59 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 17 Mar 2026 15:24:59 +0800
From: javen <javen_xu@realsil.com.cn>
To: <jerome.forissier@arm.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH] rtl8169: add support for RTL8125d
Date: Tue, 17 Mar 2026 15:24:56 +0800
Message-ID: <20260317072456.1781-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 17 Mar 2026 12:56:37 +0100
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

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for RTL8125d. Its chip version is 0x6a.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/rtl8169.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index edcae88a3fc..a679a64fea3 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -270,6 +270,7 @@ static struct {
 	{"RTL-8100e",		0x32, 0xff7e1880,},
 	{"RTL-8168h/8111h",	0x54, 0xff7e1880,},
 	{"RTL-8125B",		0x64, 0xff7e1880,},
+	{"RTL-8125d"		0x6a, 0xff7e5880,},
 };
 
 enum _DescStatusBit {
-- 
2.43.0

