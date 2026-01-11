Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC7D2502F
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 09:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6078C83AB7;
	Sun, 11 Jan 2026 10:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="DpTmWa0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFD583AEE; Sun, 11 Jan 2026 10:23:52 +0100 (CET)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0B783A8C
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 10:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout4.routing.net (Postfix) with ESMTP id 32B0F10048A;
 Sun, 11 Jan 2026 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768123430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/xAZIsy+teXv4hZNutP75GyY4qSTwy82i58Gya6Lbp4=;
 b=DpTmWa0/xoX6NlxmwRk2zwrdj5OhDft/IdQ0Q1tNo8MxIa0TB8zlcB4yQ9Gst7ExEsbCEc
 vuBPkj9aHzDe/dj1rog0B/AgGaVDbF/DU8czDDkbEsQUFKOCws9KFw7WKGNQmKyOKvGJdj
 +VuthgYfHaOle9pf2GnoflNtk4g5I5k=
Received: from frank-u24.. (unknown [217.61.158.0])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 198271226B1;
 Sun, 11 Jan 2026 09:23:50 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] boot/fit: print name of config node not found
Date: Sun, 11 Jan 2026 10:23:36 +0100
Message-ID: <20260111092338.16555-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frank Wunderlich <frank-w@public-files.de>

Show name of configuration node which was not found.

current state gives no hint if fit image is wrong or the requested name.

Could not find configuration node
load of <NULL> failed

After this patch we see name like this:

Could not find configuration node '#ov-test'
load of <NULL> failed

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d040e38d97b..92675e98f2eb 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2125,7 +2125,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		if (ret < 0 && ret != -EINVAL)
 			ret = fit_conf_get_node(fit, fit_uname_config);
 		if (ret < 0) {
-			puts("Could not find configuration node\n");
+			printf("Could not find configuration node '%s'\n", fit_uname_config);
 			bootstage_error(bootstage_id +
 					BOOTSTAGE_SUB_NO_UNIT_NAME);
 			return -ENOENT;
-- 
2.43.0

