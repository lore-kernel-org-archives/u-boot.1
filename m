Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787EACAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C17983839;
	Fri,  3 Oct 2025 18:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EwNXtH5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9770383759; Fri,  3 Oct 2025 18:34:18 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23B783816
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 57D911A10E3;
 Fri,  3 Oct 2025 16:34:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2847160683;
 Fri,  3 Oct 2025 16:34:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99E14102F17C6; 
 Fri,  3 Oct 2025 18:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GCerwr3z8ZxnRSmANJQaF7uHQThMjoKiWTt64PMr5xk=;
 b=EwNXtH5X58tk/QJLsk+QRfXj0NwwDReENKFjxf9CKbUllqeTRF+Re62rynKPpV2KMu81QN
 hd+MTSg6mty3BBMfNqXzpPibdOx9vFCB31UbWVRKPwfVbF7KzuKB12jq+6+hI58XG0FkdX
 o61fgi4Ekc47+ucdnt6jcPA3d6mRCyx0OcDBbZYCpC0Gl2ff06X1wX2o4BzZgAMnnjRqpr
 Lxp1aXCW+26A9ZKpHy0hxIIS2Sdl5gdNJnqkcUmP7SVUCf7usfr7HkHk+rZRPCYHM8lv0K
 iXJxQfR4gMxf8SoD4A9GOwiIVL7+Kr86z5e+KjKDi3rX9NFM/5LQxwW+rXfXww==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:41 +0200
Subject: [PATCH 01/16] MAINTAINERS: Add maintainer for extension board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-1-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3
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

Add myself as maintainer for the extension board support that was
originally added to track ongoing development and maintenance.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b030242a2d8..45e4b8a1865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1183,6 +1183,14 @@ F:	scripts/event_dump.py
 F:	test/common/event.c
 F:	test/py/tests/test_event_dump.py
 
+EXTENSION
+M:	Kory Maincent <kory.maincent@bootlin.com>
+S:	Maintained
+F:	board/sunxi/chip.c
+F:	board/ti/common/cape_detect.c
+F:	cmd/extension_board.c
+F:	include/extension_board.h
+
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained

-- 
2.43.0

