Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F2EC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D6B280ECD;
	Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOraRXcnpVYs; Thu, 27 Aug 2026 19:53:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860434;
	bh=yM2Sl+dP0aUxZJKANpQIEFJHluAfToC6tG9+PTvFgMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbJOitps1I4/KSzVKfq+IH3ivJudEOc0Jn0Exf3SF4rDMjQwMjdGvouv6rOxatK4q
	 ALCfJAEa184sz5UNDw2ahlONAIE1Fn5qtqIhpIbJW+/Qd7tHZfet1n8Xa/iEEjE8eh
	 klJq+6+tZkKFExuLnn1zrGbqyYeCfl6cX49TAWzZw9uEMHWRoB9urzQ1dNO0rbmEP4
	 ULCprQuGf9g6zhrnnCnjdT/ESMpHndtnLN8TbCQjL9WC9HZXpP5GshlmCE95BnxtkJ
	 OLLrJEqS1lzbhJGf86jG0b2+tnEKJ+KeiALbEZjpI/C9Agkv2TPbunAhT/ACHD2BE6
	 NwlbNsGLGm2TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 568F280E55;
	Thu, 27 Aug 2026 19:53:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 090A6B2C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1738A407FE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUO0sZ0pUPyR for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.172;
 helo=smtp-42ac.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Cv5hsHJe
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FCEE40775
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzF4kx8z11P6;
 Thu, 27 Aug 2026 21:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860425;
 bh=yM2Sl+dP0aUxZJKANpQIEFJHluAfToC6tG9+PTvFgMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cv5hsHJemBkgm5Zs9YTfKlWq4hdQNZq6BnAng8GbENyxSXd08lm2Te4IyTLqYMmyx
 uu53WcHePso1NQIokVqJ0dzxyPL9dJw/0aTKHqYhaD3xsSSOcp0VTl626r1cCSF+VC
 QygCDpIPIzLHt3zwPP6/Lza68gvMRrFoomDbqs05x7LQ2wJSbIAyv8QkpjRPUR5X5s
 cxIL+miECSRQq9gD/XDFV1+TYoxek0q9Wr3uG0FcYz/6wsIu2wVWJywR7aZN0uTeVL
 ar1iPhB+EDnMMquzN8Vf54INU2H1Klr/RdWgvVVXf6vv1KtMiB4FW92EBYpQJfroSH
 UMgmNGDIKqwHg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzC5LrzzRK7; Thu, 27 Aug 2026 21:53:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 24/45] doc: board/allwinner: update link to MTD utils
Date: Thu, 27 Aug 2026 21:52:52 +0200
Message-ID: <20260827195313.129994-3-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The base URL reports Forbidden access. Removing the www. prefix made it
work (note that using HTTPS returns Forbidden access as well).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/allwinner/sunxi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/allwinner/sunxi.rst b/doc/board/allwinner/sunxi.rst
index d0c89b956b1e..5c2406d39594 100644
--- a/doc/board/allwinner/sunxi.rst
+++ b/doc/board/allwinner/sunxi.rst
@@ -312,7 +312,7 @@ also be uploaded via FEL, check the Wiki's `FEL page`_ for more details.
 .. _`configs/`: https://github.com/crust-firmware/crust/tree/master/configs
 .. _`crust README`: https://github.com/crust-firmware/crust/blob/master/README.md#building-the-firmware
 .. _`linux-sunxi`: https://linux-sunxi.org
-.. _`MTD utils`: http://www.linux-mtd.infradead.org/
+.. _`MTD utils`: http://linux-mtd.infradead.org/
 .. _`magic binary`: https://github.com/linux-sunxi/sunxi-tools/raw/master/bin/fel-sdboot.sunxi
 .. _`sunxi_fel`: https://github.com/linux-sunxi/sunxi-tools
 .. _`FEL page`: https://linux-sunxi.org/FEL/USBBoot
