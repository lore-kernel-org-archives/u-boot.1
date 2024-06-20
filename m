Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA602C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5AC88537;
	Thu, 20 Jun 2024 16:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="GwHRZlca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D2F8840F; Thu, 20 Jun 2024 16:21:09 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6495E8853F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C65A7148A161; Thu, 20 Jun 2024 16:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1718893265; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=V68wMUiAeiqmdFSkiohBhblKBcbHILVvKM4Se+lWVig=;
 b=GwHRZlca1NFLLSHWydfAgM1KbR552HmlwzH24K9I/TCfzcRyCmJaPOgyBGPABCAGn7ijrg
 gEg3owmzBBHyWt6pvDegKi0jpnrjtS9RuXg4HJyEE/5XO5c02x2MnQ3B7r5OGsZveHmAHZ
 S5VMulAj8oO5+XE3+o8yZ5/FO+xnDQSP03HA1z5Ra0XLQJUYkfV0xbHq6E3vkXTw/vtNlN
 ILWHsIpmpHhUAhPMVfYCpZYSmRm2qJIfni+g3EEb4bYhtoR5uq9Jp62S2edxzJrDtsYp15
 DwiAg7Y2FZh8xusW7fznVVlSWcsxwlbWXEd57RuvdpXzQFx06kuAr5diWtyahA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Massimo Pegorer <massimo.pegorer@vimar.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] mkimage: Allow 'auto-conf' signing of scripts
Date: Thu, 20 Jun 2024 16:20:59 +0200
Message-Id: <20240620142059.2348379-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

U-Boot configured for verified boot with the "required" option set to
"conf" also checks scripts put in FIT images for a valid signature, and
refuses to source and run such a script if the signature for the
configuration is bad or missing.  Such a script could not be packaged
before, because mkimage failed like this:

    % tools/mkimage -T script -C none -d tmp/my.scr -f auto-conf -k tmp -g dev -o sha256,rsa4096 my.uimg
    Failed to find any images for configuration 'conf-1/signature'
    tools/mkimage Can't add hashes to FIT blob: -1
    Error: Bad parameters for FIT image type

This is especially unfortunate if LEGACY_IMAGE_FORMAT is disabled as
recommended.

Listing the script configuration in a "sign-images" subnode instead,
would have added even more complexity to the already complex auto fit
generation code.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 7bfc0cb6b18..49ce7436bb9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -730,7 +730,7 @@ static const char *fit_config_get_image_list(const void *fit, int noffset,
 					     int *lenp, int *allow_missingp)
 {
 	static const char default_list[] = FIT_KERNEL_PROP "\0"
-			FIT_FDT_PROP;
+			FIT_FDT_PROP "\0" FIT_SCRIPT_PROP;
 	const char *prop;
 
 	/* If there is an "sign-image" property, use that */

base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
-- 
2.39.2

