Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E23CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20AF2838D2;
	Mon, 13 Oct 2025 15:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LYnbjigB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 990F4838C1; Mon, 13 Oct 2025 15:32:45 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172298383E
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B360DC093AF;
 Mon, 13 Oct 2025 13:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A63E7606C6;
 Mon, 13 Oct 2025 13:32:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D1BA102F224D; 
 Mon, 13 Oct 2025 15:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FHr/DjBd4F29pmKYX3P4sWO6KGWp0qZyXLMbZ05J8UU=;
 b=LYnbjigBP2I6cfCkUO5ddaTh9FILytyGPwdISikV5sqjUVuD7KQnOt7Sj4qoLB6q8LDfPa
 knF2Iy5GEf/+wRCmGAsF7ypa2YK74qX273HJY9fZVIijuWZmcEW0nCIB8upWcpahOIdIwV
 O+pRvwhBgq/xIYAlDdaKWgoxZ3jXBuUGG5rIFwCgFT3wcDXWJFpy/y6xN5TRPOKok+UcaJ
 DMFZViY5jpxeVtLMUy8s1AUtCZAPaXcBfeS1lgiBSSqcCdB0NG060D8H9n2BuvGh6kV8xO
 ywHFh7n0twzegZ/SfoEY6uvSexChAbIUKwQjvCjxT6eUEmwKmjrI81gBg2+tKg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:26 +0200
Subject: [PATCH v3 01/20] MAINTAINERS: Add maintainer for extension board
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-1-04067b7422a5@bootlin.com>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12043a1f82e..e411e266c94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1182,6 +1182,14 @@ F:	scripts/event_dump.py
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

