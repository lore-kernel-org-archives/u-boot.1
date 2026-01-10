Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76033D2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 15:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC6383A41;
	Sun, 11 Jan 2026 16:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NiOBKLHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344BB83C5E; Sat, 10 Jan 2026 21:34:39 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D8983B07
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 21:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 35D2E10300E; Sat, 10 Jan 2026 21:34:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1768077275; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=ffMuYxE3wQ3kahSud4TxVyjHUD8r6OH8SJYWBlBVai4=;
 b=NiOBKLHEBqBikyx3TTDnHQ/8zMZq2eMoL9eO1vbBaox8o+Zav5hQBCtYg394UpMBRKLhvr
 1HtFUJD2fDOihCYQ0R6Gp3gL8ZJWxXP3UkyYVNW/NJgBjJyc3lzhNtbn4OWuctFKEFqp9D
 9XisykGcI1F6K7mocydF7NX/jFbOwAgzPKhuKfyl2thqPGG8eNWmF8TS0CLmX9BaqZBMus
 /Rx2AQqFItSNk7+j9qtZW9/NxBBtmJj5zW0JSQRvGXj/8RVP4QailFtRq5BO/hEPuSa+ag
 6mF5yYzHQwg8+cu9Mp7JB9JlSyDahwRAq0bLKy4hoygfFwTTEO9QieywQnH9NQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable boot from both USB controllers on all i.MX6
 DHSOM
Date: Sat, 10 Jan 2026 21:34:19 +0100
Message-ID: <20260110203433.715468-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 11 Jan 2026 16:22:46 +0100
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

Enable boot from both USB controller 0 and 1 on all i.MX6 DHSOM.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 include/configs/dh_imx6.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index d849cb544be..4041e7e424a 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -54,6 +54,7 @@
 	func(MMC, mmc, 0) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2) \
+	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(SATA, sata, 0) \
 	func(DHCP, dhcp, na)
-- 
2.51.0

