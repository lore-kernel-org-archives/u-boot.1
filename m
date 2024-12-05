Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EFDE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39205881FD;
	Thu,  5 Dec 2024 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NST46UTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A618950D; Thu,  5 Dec 2024 14:54:49 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F00894E4
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0945440005;
 Thu,  5 Dec 2024 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASGaXd0syxzOZ1wKSfnV+Sf0k0KoWW/JdOKs9VChRZw=;
 b=NST46UTLXVn/UTt4uSMvAg6Z1cy+7qtwXxvreZoJawN01fqaOt8uNhEx8crQRHS8nZvklc
 PZ48++c9alQr/wO45EDjzFZz3zT5a3dz6tQhMd6Qi7i9B+zjrFwXUZx4yUURJXIE3n+aGp
 HKjkVjkKGF0t/mrnyvqbc8ZICgxpHOu/wDQIo5E1BCbXIUSFqM0mQQrS7ZEGANE/XSZ2XB
 eWZGkv5Wh08fpaymtE75Il5FomTDVgCNT+B8bkea6gOotadd6qL16XfTD+X0YD6b2EUZPp
 or/4TX8nCfJVZhtFbaRGUUJXfFUGz0COd6GZKguJ94ltblTqUOmv9WF2+HPj6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:07 +0100
Subject: [PATCH v2 01/13] dm: doc: Fix example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-1-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

`.priv_data_size` does not exist. I believe the actual structure member
was supposed to be `.priv_auto`.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 doc/develop/driver-model/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 8c2c81d7ac9a1f59af67db012c78ed5be276805b..ce914dae342388d770a17e74c72e423ba5c34204 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -312,7 +312,7 @@ drivers/demo/demo-shape.c):
 		.name	= "demo_shape_drv",
 		.id	= UCLASS_DEMO,
 		.ops	= &shape_ops,
-		.priv_data_size = sizeof(struct shape_data),
+		.priv_auto = sizeof(struct shape_data),
 	};
 
 

-- 
2.47.0

