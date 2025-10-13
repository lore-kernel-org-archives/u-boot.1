Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675F4CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D109D83977;
	Mon, 13 Oct 2025 15:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vRPaIVjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCA283977; Mon, 13 Oct 2025 15:32:54 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B69837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 779F31A133B;
 Mon, 13 Oct 2025 13:32:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D466606C6;
 Mon, 13 Oct 2025 13:32:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DAF7D102F224D; 
 Mon, 13 Oct 2025 15:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0Mm/QU/vZFsWpz2jl3fYieBP/HyekWfw5f3oO6dQ8vY=;
 b=vRPaIVjUzzq4IEU53T222IVaDxdOiIHoAxYVdvjwyJ2dPTnQHv4ff4wBoCwrJoXLb9mLua
 a/sBP1d90qTlEsPH1xLt5cDr1XTulNGV9fJ49+5Uv5ZM1WGOf7PUzk2SKl7+V45IGhayH0
 FHLoNND0YVQLzzUvoC2GIzObPKjM2pjyj9SzyelVGvNVm+Td0AufrkdemVF3m2i/u1+qZN
 JgLjeGOGGebzq6tI8mQ0cloVM4uZLG+USIkwqRPctLuP8EyD6DCHVgjso1Pnh2CdBDDczN
 3x5h3leJQvFtmSOn/xwge/FuUgulxIKWvYaGlDXqi210n+opz1pUHCeNlkPGRg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:31 +0200
Subject: [PATCH v3 06/20] include: extension_board: Document the extension
 structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-6-04067b7422a5@bootlin.com>
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
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
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

Add documentation to describe the extension structure.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v3:
- New patch.
---
 include/extension_board.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/extension_board.h b/include/extension_board.h
index 22e4104bc54..23e36d3c0bf 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -9,6 +9,15 @@
 
 #include <linux/list.h>
 
+/**
+ * extension - Description fields of an extension board
+ * @list: List head
+ * @name: Name of the extension
+ * @owner: Owner of the extension
+ * @version: Version of the extension
+ * @overlay: Devicetree overlay name to be loaded for this extension
+ * @other: Other information of this extension
+ */
 struct extension {
 	struct list_head list;
 	char name[32];

-- 
2.43.0

