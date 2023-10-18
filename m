Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C00CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DF186F79;
	Wed, 18 Oct 2023 15:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6290286F7E; Wed, 18 Oct 2023 15:42:07 +0200 (CEST)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id D89A98669A
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1.arvanta.net (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id A8F1D8B7A;
 Wed, 18 Oct 2023 15:41:57 +0200 (CEST)
From: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>
Subject: [PATCH v2]  cros_ec: spi: disable annoying key echo on console
Date: Wed, 18 Oct 2023 15:40:12 +0200
Message-ID: <20231018134030.27260-1-mps@arvanta.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

on Peach-pi console every key press is echoed with message
'cros_ec_command: Returned status 1'

this is not proper fix, just hack to disable this message

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
changed patch to use log_debug and added forgoten Signed-off-by and
and Reviewed-by Simon response mail

 drivers/misc/cros_ec_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
index 001f0a85ca..591ff30df8 100644
--- a/drivers/misc/cros_ec_spi.c
+++ b/drivers/misc/cros_ec_spi.c
@@ -151,7 +151,7 @@ int cros_ec_spi_command(struct udevice *udev, uint8_t cmd, int cmd_version,
 
 	/* Response code is first byte of message */
 	if (p[0] != EC_RES_SUCCESS) {
-		printf("%s: Returned status %d\n", __func__, p[0]);
+		log_debug("Returned status %d\n", p[0]);
 		return -(int)(p[0]);
 	}
 
-- 
2.42.0

