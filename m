Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2FDCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09E5839AC;
	Thu, 30 Oct 2025 17:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1+hO8y2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74656838FA; Thu, 30 Oct 2025 17:45:38 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988EE839A1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D9E09C0DABA;
 Thu, 30 Oct 2025 16:45:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 551B760331;
 Thu, 30 Oct 2025 16:45:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B950811808C40; Thu, 30 Oct 2025 17:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842735; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=a5FkYtERhhbyQqXmCLdfcors3JqRZQV6zWoHXX8of5U=;
 b=1+hO8y2kSe3ukOGLNhmLPjPbubnOwoDAoLt4eB3hlUsZULHXnKWUrnAEyM+FBg87ulaUv5
 1/YpT0kKo2QvTRUTy3xGefGvX8Xg1VA0B72vzoNaM6lBZi3Uf5exL/jc36aG1ar5NSjPzS
 EB8Mbjor2XE1fMHsmsl3mHxKdv3bXHz70ZhqZEfrOgwaqauFEvou7XF4nwU0jRQPm2mZK9
 cSnFUpt5zRKHtCX2v1bbQmED2GY3SvnWCuFCoL/3u12bIJFsqKaBYLVldIb1sntjdwVSp3
 zPzywoIHsGM8z6zkkeC2dp2CxzHancLFLc9vpmv2n4axac83Z3mwTOyPFkHZaA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:06 +0100
Subject: [PATCH v5 13/20] board: sandbox: Improve extension board scan
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-13-cfb77672fc68@bootlin.com>
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

