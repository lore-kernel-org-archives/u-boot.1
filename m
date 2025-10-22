Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4768BCCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CA2836AC;
	Wed, 22 Oct 2025 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1LgZzh7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFC280422; Wed, 22 Oct 2025 17:20:42 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A56A83693
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 12F1EC0AFF6;
 Wed, 22 Oct 2025 15:20:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D2169606DC;
 Wed, 22 Oct 2025 15:20:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5AD87102F23AD; 
 Wed, 22 Oct 2025 17:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0Mm/QU/vZFsWpz2jl3fYieBP/HyekWfw5f3oO6dQ8vY=;
 b=1LgZzh7Lbvx5F2TYILDlhU023v4QXK4lHzcZObtHc03Kh/xgOwEcDyf1vFWBwjDcHe+ek3
 q+lZQ4QuapsLEZtbFdk8oSDBJF8AuUEFgd4R4oKlc6aGUKikhDKHXOL+2Ljh5KwyC27dZ9
 ZurgUmshcCoIytqJvc9x6/+aay8a6AglyUt0OlBN/R77wQZ9HvWFSp/3EqpYzX/UIGSz9R
 GadJ5SS3BvqT91NZ9OaCon6KtU6u5/kILFZTDXvADDnGi98E2z6g27DO8+bXufWr/EtlRF
 OmU5aiB86rmZgoy4AxQ+3WGw/bZR+UvEBYUSWMA4vu7dszO5cMnPHiqRKKClqg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:20:17 +0200
Subject: [PATCH v4 06/20] include: extension_board: Document the extension
 structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-feature_sysboot_extension_board-v4-6-d24b5ef7b468@bootlin.com>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
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
X-Mailer: b4 0.15-dev-52d38
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

