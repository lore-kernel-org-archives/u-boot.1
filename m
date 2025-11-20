Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5A1CF256D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7126883E0E;
	Thu, 20 Nov 2025 05:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NkYqC1Y1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J76K/jJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0216C83FD9; Thu, 20 Nov 2025 05:16:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9F383952
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dBlQs4WF3z9tN2;
 Thu, 20 Nov 2025 05:16:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yk4VFVeI0Oni/iNMuvSf7YdzShx4a2lNpiW2PuU8KBM=;
 b=NkYqC1Y1Wu8ba9PtIJeDD8XNMMh+DZA4vHntj1XRojtiwkgabenamFxTv9L3vvLPLpl8hD
 MTJDxyxkGNxTMF/1eqnVixmn0K3GX2rymbEi4fYtx5IkakBiszfYMvzyz9gY/xPYZGvai2
 Uf+EbkxIH3izYf/eZkjZBJ0Zlh2oouFuJxNAhoCAsK/ISHKujGtSe4VAQ+EQuDQ9tVHyP5
 Fc0idwwMRvj9CmpREpYejPrnL0ceWgMLD3GMUPQpqaBVg3wb8lOPH77aRJDvGPoNMgUueF
 QzesxdS/ATRBE1gODPOz3nFDT4uqEG0r5f9pUhtPd54WhcW/ubj7HXaDe5R0OA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yk4VFVeI0Oni/iNMuvSf7YdzShx4a2lNpiW2PuU8KBM=;
 b=J76K/jJDhUkYG/bPmlwHyVEro738vAJhnMeCCDaQuEEmclTZFlKk4LBKJoh0/AO1LOSHy2
 FMIGSBBvyZUdRYIsW2Rl3uDjWJjjTI06989OBUGh1eKw52Soig8QLK7QpeOXEGoGvTIk46
 j7LDj/vqlo/dIC0C3svQZLLt/gkrR04VZW0XY1g5KidrWdaI1hA/peZ06ev4ZLph1mqfbJ
 vCFYB62DO59OxasB8/x2qLhI738ZhQ1VVgddC7owHL7crJdr8BffwCZ+OCCxBnwFvoqmFh
 9saZGLMcTgPWOM/6lCYeLHfL7m6Lp5sIO+RwWyaHVXmLECd0XSHG6fVsz0dEeg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH] boot: Check noffset before use
Date: Thu, 20 Nov 2025 05:15:30 +0100
Message-ID: <20251120041613.817311-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w8g7fghz3h6dwh3tokcd6fjxy86jo73s
X-MBO-RS-ID: 5b2f3244f36097c8326
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

If noffset is negative, do not pass it to fit_get_name() and then further to
libfdt, this will crash sandbox with SIGSEGV because libfdt can not handle
negative node offsets without full tree check, which U-Boot inhibits to keep
size lower.

Instead, always check noffset before use, and if the return value indicates
failure, exit right away.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de
---
 boot/image-fit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index cccaa48f683..35595f15ac3 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2137,7 +2137,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 		noffset = fit_conf_get_prop_node(fit, cfg_noffset, prop_name,
 						 image_ph_phase(ph_type));
-		fit_uname = fit_get_name(fit, noffset, NULL);
 	}
 	if (noffset < 0) {
 		printf("Could not find subimage node type '%s'\n", prop_name);
@@ -2145,6 +2144,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		return -ENOENT;
 	}
 
+	if (!fit_uname)
+		fit_uname = fit_get_name(fit, noffset, NULL);
+
 	printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
 
 	ret = fit_image_select(fit, noffset, images->verify);
-- 
2.51.0

