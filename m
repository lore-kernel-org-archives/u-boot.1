Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B0C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 02:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CF087092;
	Sat,  4 Nov 2023 03:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="0OyBtJ3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A42986CF4; Fri,  3 Nov 2023 22:16:55 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe39.freemail.hu [46.107.16.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823E186A26
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 22:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain (catv-80-98-74-198.catv.fixed.vodafone.hu
 [80.98.74.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4SMYTb01Pkzl9;
 Fri,  3 Nov 2023 22:16:50 +0100 (CET)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: otavio@ossystems.com.br, festevam@gmail.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH 1/1] pico-imx7d: fix typo in AR8035 comment
Date: Fri,  3 Nov 2023 22:16:40 +0100
Message-ID: <20231103211640.423-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1699046211; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=827; bh=+enMxx4/S5A/sm0sFnrLGcNM/DhlUEUavscdaDAPrF8=;
 b=0OyBtJ3rmJfOz2jmm9jezfyT+R8XU7LV884FhFC71UVRrefh7TQzHZ+1zJ7CPloE
 DJbSSZAYTJS1DXEASoFjIie0e5Y99MFbCxxVVVpNUKBKjhHG7vvT1o7mmJu+mLV3jHj
 L8bB+4PfH5qo9EBaI7wNwCceqB6hioQTVwgnKPg3alMNKgVS01eS22lGyCEJeX5ZGxQ
 K5qschHX5V49zb7dW5F5hZi/EDRMbILsmvvzYvl0cJAWHZc29iW+zgv9wM8cLf4NOEZ
 iIQSqT98Oej9W4GB0o9SPmcOWgZt0Ck5MTXw7D4W5Yc8FWVLyuegf4CHtaG5XgM2rYi
 2VLX+xzPoQ==
X-Mailman-Approved-At: Sat, 04 Nov 2023 03:43:20 +0100
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 board/technexion/pico-imx7d/pico-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index 6e98b85b28..7f5a092457 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -106,7 +106,7 @@ int board_phy_config(struct phy_device *phydev)
 {
 	unsigned short val;
 
-	/* To enable AR8035 ouput a 125MHz clk from CLK_25M */
+	/* To enable AR8035 output a 125MHz clk from CLK_25M */
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
 	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
-- 
2.42.0.windows.2

