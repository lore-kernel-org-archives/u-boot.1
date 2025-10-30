Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34847CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B27D83957;
	Thu, 30 Oct 2025 17:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BSIJ9Fzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FA283952; Thu, 30 Oct 2025 17:45:24 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C8A838E5
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2415F4E413FE;
 Thu, 30 Oct 2025 16:45:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E79D160331;
 Thu, 30 Oct 2025 16:45:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB8F511808CA6; Thu, 30 Oct 2025 17:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0Mm/QU/vZFsWpz2jl3fYieBP/HyekWfw5f3oO6dQ8vY=;
 b=BSIJ9Fzl/V5M9JzKbj190bI01AIVJvGQSXLYO9XHsuqdlwhcDjlavrSTzQ9HgtHhfdpjoY
 r3qard8KvVxsP149KC96Q/uvL+oZR60OObtE1g9us6QF71lwlRx6v8sw8twbR3nMgMwhQP
 fXggz60i7+0nhpkAccvsLpKWJOS6cjLu1yDQUMRvyirMM51l4ffvlTS1heH+ymLL+brdit
 VGYwniOZggUsYyaDKMrYydp2IcjhxH8Xmz+fPsohKzq+sJDUEzkUuU9jiyBWABPV6vRI94
 Ie6ijmtGSXBdXx0SJokTVx057EfafG7s14dGkRjDGv6wq16eK7OevDP+O44lUw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:44:59 +0100
Subject: [PATCH v5 06/20] include: extension_board: Document the extension
 structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-6-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
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
X-Mailer: b4 0.14.3
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

