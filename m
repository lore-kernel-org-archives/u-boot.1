Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EEFCD5BA6
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAA984659;
	Tue, 19 May 2026 15:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="fpvZSSi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D922843B6; Tue, 19 May 2026 15:01:56 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEB084659
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195707; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VMRGgp0SMfkZnR1/SlRyrXSE1DIssbiDp8qXzXHu8rzPS3EmyBowc7tAolNc7Rs9uBd6dWIUfSD/z627I4+oAC+rDWYI2VCJrVB15tjmeOHI757lsUmo2grJsGPh2x2+ChWwjFlsou2yKB4HVga5Hd4I/8DozrlFa70qg07b8To=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195707;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AaNeMxpa3aHKiss0tueR1ImmrD699IlQ7rnhZ4/PElY=; 
 b=F4Vv2PranrVa0mXEhsdtmtqMw3O/4eKgfnvc9uoFp9mUnQiznBdJz/ebsNbkq+P1vgbpuqcWhZD3nQmlvbLGJJwMTw1fDj8um11IAWMMZ/2WaFVYZNJTYG62KbOsXEo5Egk52Uzh1Nn1/AlrRPOf1m7SNnum9BFUHNVIpH746MU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195706; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=AaNeMxpa3aHKiss0tueR1ImmrD699IlQ7rnhZ4/PElY=;
 b=fpvZSSi+GAgfq+Co2y1ByjbwxOs077MJMBCrYYaV1PXp9K4KNypW84+wvm8K1ubV
 ExS6iu+NEtfJRWFM3qymY+4lR+A0mkjBw61K3bMtB5y4+FtSQhQU/9B2XtzgtgMvgU8
 6NqN+KgJ4t7JIS/Gmme2iwJNQnx4juRC7twlT+ew=
Received: by mx.zohomail.com with SMTPS id 1779195704539876.5344169665116;
 Tue, 19 May 2026 06:01:44 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 19 May 2026 20:58:30 +0800
Subject: [PATCH 3/5] pinctrl: sunxi: a523: add gmac1 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-a5e-gmac1-v1-3-c3117603b9fb@pigmoral.tech>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=1011;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=9YKqvfDj32ltHad5pJpwqfhloykfg5hcSsdC4870NmI=;
 b=Fq4FbGtEu6gmQWY4rVifNJPMI80ra0jWPVmKdOWpLsjdpuTmkEoQC8Id55pH5mleTBH6djUTv
 jeui0kgO7PnC9k2ETzuiY/aJxpbDK+nHxEGPYPsGpabmSwUCJjBig3u
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The Allwinner sun55i (A523/A527/T527) platform provide a Synopsys
DesignWare Ethernet QOS IP block as the gmac1 controller, which uses
pins PJ0 to PJ16. Add the gmac1 function to the pinctrl driver to
support it.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index a8632aeaf8f..ab4e88c9918 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -761,7 +761,8 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_h616_pinctrl_desc =
 };
 
 static const struct sunxi_pinctrl_function sun55i_a523_pinctrl_functions[] = {
-	{ "gmac0",	5 },	/* PI0-PI16 */
+	{ "gmac0",	5 },	/* PH0-PH7, PH9-PH10, PH14-PH18 */
+	{ "gmac1",	5 },	/* PJ0-PJ9, PJ11-PJ15 */
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
 	{ "mmc0",	2 },	/* PF0-PF5 */

-- 
2.54.0

