Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E161CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C39B83303;
	Wed, 22 Oct 2025 17:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R0lu3I/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C558882B20; Wed, 22 Oct 2025 17:20:56 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFE283893
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A63411A15C3;
 Wed, 22 Oct 2025 15:20:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7F0D6606DC;
 Wed, 22 Oct 2025 15:20:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D74A8102F244C; 
 Wed, 22 Oct 2025 17:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=a5FkYtERhhbyQqXmCLdfcors3JqRZQV6zWoHXX8of5U=;
 b=R0lu3I/lWquf/dKZ8FVzGwOL13pY6h6nA++EGLS4XISII+Wz/WQ8vc3pmX08gLFm0v9Jtg
 MWhsVExZcEUxO/AvH8m1mC6iJrEDFx+DbYGAeMseV06qoiErHjz1k5jdkP2qG4KW6uA+o0
 TdWL2MR9m4oPB4j43AJDO44y/h4Ndi03jVuH90jPtLeViCKFeyNYM1xvcsmf49FHlcj08J
 ZWMhz7UUGqD4oGpkpgh6yZbIYHAL+EDGsaLUAPnsDpcvnHnsq+8dk6bPbCkdtNZDHWT5i1
 3lfZgtpW4mzcGVgpgVR+MNTRreKoEY55dZ1pTBWNVv5+RXGaAZwybpTQqTrUBg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:20:24 +0200
Subject: [PATCH v4 13/20] board: sandbox: Improve extension board scan
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-feature_sysboot_extension_board-v4-13-d24b5ef7b468@bootlin.com>
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

Enhance the extension board scanning code in sandbox with better error
handling and code organization.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

