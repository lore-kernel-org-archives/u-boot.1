Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4927CCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23898323A;
	Wed, 22 Oct 2025 15:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Re3FaZRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C858334F; Wed, 22 Oct 2025 15:21:11 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D791A82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 72F4E1A15AF;
 Wed, 22 Oct 2025 13:21:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 47AB7606DC;
 Wed, 22 Oct 2025 13:21:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A1CD9102F2435; 
 Wed, 22 Oct 2025 15:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761139267; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=7/jZUDrsCQdPqkuYYHWfIIcZmdkhobCZnnjYRJguzqg=;
 b=Re3FaZRd9YCQGIzUaDxR15eV0GEGHK8eyK/yWURMafHIimZAEXLtAcesa+KmrC0xsIXjG1
 tmCab4eCTeoU5sYX+PhbuRwi3jZoeoTw+7vZYIJc4REXqPvBxbjlE7wz3C5JELzwPxWfHQ
 b+4mESYk9OaHIRwhIeXoubdgg2bgxUSBv/761NnZgNA9f3RQdg3PPe4X410G3MrzgGnVSC
 +4dYeKUNtbNbabYBwiWeOErg04MRgruBt5zoKM4Zpyuqb4wa8opFZ6E9xGvs8+APtUTOGe
 CiozNnHSBVVy9pDHGYtiXhOoGRlWm4iSo0HDUsxJ26AWBMO01SfRDXuNJYinAA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] doc: pytest: Complete dependencies list with missing packages
Date: Wed, 22 Oct 2025 15:20:52 +0200
Message-ID: <20251022132055.816662-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

Add missing dependencies to the pytest usage documentation and correct
the device tree compiler package name from 'dtc' to 'device-tree-compiler'.

This ensures users have the complete list of dependencies needed to run
the pytest test suite without errors.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 doc/develop/pytest/usage.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 779b2dbe24b..454877837ca 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -39,7 +39,7 @@ will be required. The following is an incomplete list:
 
 * gdisk
 * dfu-util
-* dtc
+* device-tree-compiler
 * openssl
 * e2fsprogs
 * util-linux
@@ -50,6 +50,11 @@ will be required. The following is an incomplete list:
 * mtools
 * sbsigntool
 * udisks2
+* swig
+* cgpt
+* libgnutls28-dev
+* vboot-kernel-utils
+* fdisk
 
 Please use the appropriate commands for your distribution to match these tools
 up with the package that provides them.
-- 
2.43.0

