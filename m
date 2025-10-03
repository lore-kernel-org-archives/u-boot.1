Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E5CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8100F838A5;
	Fri,  3 Oct 2025 18:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SES7iIrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF17C8386D; Fri,  3 Oct 2025 18:34:37 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B913D8389A
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5C5BCC00DA9;
 Fri,  3 Oct 2025 16:34:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 62E0760683;
 Fri,  3 Oct 2025 16:34:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B963A102F1CFE; 
 Fri,  3 Oct 2025 18:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509274; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JFU20cvYo6m2/RjOGBmSM0/QqT6AaZUsLt56741dpfI=;
 b=SES7iIrgvl81unNxlccLpcemlVCJzv+semNrXESwA4di9IPgpFt2aO547k+cMZh/1TkJEA
 /BDNZudYVut8y3yKM6IyPW6h8Fd+sKvOirsxBoImW/ejolXOEuVNYwwiV2+LfDYXQ8ubdE
 6UL8WMPfC7NMy+a+EX8OXmbUWtSyN8EbsHUJ95gkpqBaqeTBRifUbrz9TyZ2aCq4Oklnee
 /zh/NGV9UJUaTpsOe0AUrDbYW5oZw3QeNvLKauo0JFbJd+e6IHKzE9aPmu/2alg5Bnx9Sb
 F+PT/GPLMSHOwjrllnBDAoxoqc5p9OUt5/TwQJm4jC4QK/lpJPtupPrXagRy6Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:49 +0200
Subject: [PATCH 09/16] board: sandbox: Improve extension board scan
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-9-458b8bf85325@bootlin.com>
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

Enhance the extension board scanning code in sandbox with better error
handling and code organization.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 board/sandbox/sandbox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 0dc23a27dfc..c5d7b9651a9 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -113,11 +113,15 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 #ifdef CONFIG_CMD_EXTENSION
 int extension_board_scan(struct list_head *extension_list)
 {
-	struct extension *extension;
 	int i;
 
 	for (i = 0; i < 2; i++) {
+		struct extension *extension;
+
 		extension = calloc(1, sizeof(struct extension));
+		if (!extension)
+			return -ENOMEM;
+
 		snprintf(extension->overlay, sizeof(extension->overlay), "overlay%d.dtbo", i);
 		snprintf(extension->name, sizeof(extension->name), "extension board %d", i);
 		snprintf(extension->owner, sizeof(extension->owner), "sandbox");

-- 
2.43.0

