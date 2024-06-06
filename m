Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0314EC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 11:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBCA88274;
	Thu,  6 Jun 2024 13:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13367883CF; Thu,  6 Jun 2024 13:44:17 +0200 (CEST)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1117887D40
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 13:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vw2YB4xgrz7xh;
 Thu,  6 Jun 2024 13:44:14 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vw2Y94dtxzhtN; Thu,  6 Jun 2024 13:44:13 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 06 Jun 2024 13:44:04 +0200
Subject: [PATCH] rockchip: mkimage: fix mkimage -l for header v1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-rkcommon-dumpimage-mkimage-v1-1-018515731e86@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAOhYWYC/yWMSQqAMAwAvyI5W4hbFb8iHqRGDZJWWhSh+HeLn
 oaBYSIE8kwB+iyCp4sDO5ukyDMw22RXUjwnhxLLGjVq5XfjRJxV8ykHy5QK2X82nS7QLNhWNUI
 aHJ4Wvr/5MD7PC2ZiG0BsAAAA
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

There are two paths to reach this function, either through mkimage -l or
through dumpimage -l. The latter passes a NULL imagename while the
former passes an empty string. Therefore, let's make both tools behave
the same by handling the empty string the same way as for NULL.

Without this, the only way to get some information out of mkimage -l is
to provide "-n rk3399" for example, which isn't documented in the usage
of the tool.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/rkcommon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 12c27b34eaa..3e52236b15a 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -470,7 +470,7 @@ int rkcommon_verify_header(unsigned char *buf, int size,
 	 * If no 'imagename' is specified via the commandline (e.g. if this is
 	 * 'dumpimage -l' w/o any further constraints), we accept any spl_info.
 	 */
-	if (params->imagename == NULL)
+	if (params->imagename == NULL || !strlen(params->imagename))
 		return 0;
 
 	/* Match the 'imagename' against the 'spl_hdr' found */

---
base-commit: 4b992573b34b1586e323e27b177680a6efec1c76
change-id: 20240606-rkcommon-dumpimage-mkimage-58610cf07340

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

