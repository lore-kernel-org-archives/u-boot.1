Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB61C78853
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 14:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FF288AA7;
	Fri, 20 Sep 2024 16:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cpl+D0Cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995C588AB6; Fri, 20 Sep 2024 16:56:49 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF3188A1C
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 16:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.perrot@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0380D1BF20B;
 Fri, 20 Sep 2024 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1726844207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=e4t0b7/8tWzIHKOP0xyHRMQYBpLBh4IdgHejS5anmD8=;
 b=cpl+D0Crdud57fXtgjQYM6Pu4hu3enW5WZsnPDX6Izm55+35hJSEOEykse9lqGTKKdH3XJ
 Ha1pMzFxurAZNlkSet/cqmtdavghUyM59Q2e2nsykslrLwMGC8/z3wPmGwfm2Ignn7zaKo
 FBVIQuW7k0ZIhsR0eEmtO/Gi5wcYnd/lZ07dZu3dA8t4K+AeMjD+03iFaFxfXdnD4Xjbb4
 MqN7epBtksfOHed/AO2wbntV5USBPyWv0hBFtdKAg053f1Wk5bQPgPl029K40iLv/qrBJZ
 oIT+9P8V9fH/0pYjKArY25YrAGe+MjSUqiMIiv1pTlZa3U5bfLJ/wLvikiWQ8w==
From: thomas.perrot@bootlin.com
To: u-boot@lists.denx.de
Cc: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [PATCH] doc: usage: cmd: ums: fix dependencies
Date: Fri, 20 Sep 2024 16:56:41 +0200
Message-ID: <20240920145641.716306-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com
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

From: Thomas Perrot <thomas.perrot@bootlin.com>

Replace CONFIG_USB_USB_GADGET by CONFIG_USB_GADGET.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 doc/usage/cmd/ums.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/ums.rst b/doc/usage/cmd/ums.rst
index 9d379e3c829e..3d344a55da8c 100644
--- a/doc/usage/cmd/ums.rst
+++ b/doc/usage/cmd/ums.rst
@@ -48,7 +48,7 @@ Configuration
 -------------
 
 The ums command is only available if CONFIG_CMD_USB_MASS_STORAGE=y
-and depends on CONFIG_USB_USB_GADGET and CONFIG_BLK.
+and depends on CONFIG_USB_GADGET and CONFIG_BLK.
 
 Return value
 ------------
-- 
2.46.0

