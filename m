Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EE9C982F1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2D983935;
	Fri, 16 Jan 2026 19:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="EO28mueP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B8E83966; Fri, 16 Jan 2026 19:29:26 +0100 (CET)
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B653C838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout1.routing.net (Postfix) with ESMTP id 20159408AA;
 Fri, 16 Jan 2026 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768588164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SM0o6qFouXA+oIB4X26a+oohWdYZmLxc3oZ/GKGyW08=;
 b=EO28muePczS2kerQW42VwQuk0R5NwY+T3m3QZO2Oxg/MY1+jeOFHgz129MeNWIl8jO756b
 sS1EWlqUahm2gfxgCrj/jfYdzX6hbfksr4V6vLjjhM1lmcSO+m8d5G0Pdx7akMSS2Vgqdk
 3z7h+EbjxNnCZc0MQzrawu36hZEYtEQ=
Received: from frank-u24.. (fttx-pool-80.245.79.4.bambit.de [80.245.79.4])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id F2EE31226AD;
 Fri, 16 Jan 2026 18:29:23 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	u-boot@lists.denx.de
Subject: [PATCH v2] boot/fit: print name of config node not found
Date: Fri, 16 Jan 2026 19:29:02 +0100
Message-ID: <20260116182903.20652-1-linux@fw-web.de>
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
v2
- handle null
---
 boot/image-fit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d040e38d97b..85026c2d1d02 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2125,7 +2125,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		if (ret < 0 && ret != -EINVAL)
 			ret = fit_conf_get_node(fit, fit_uname_config);
 		if (ret < 0) {
-			puts("Could not find configuration node\n");
+			printf("Could not find configuration node '%s'\n",
+			       fit_uname_config ? fit_uname_config : "(null)");
 			bootstage_error(bootstage_id +
 					BOOTSTAGE_SUB_NO_UNIT_NAME);
 			return -ENOENT;
-- 
2.43.0

