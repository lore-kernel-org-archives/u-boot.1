Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D188CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 14:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2128004F;
	Wed, 29 Oct 2025 15:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yLVB5/l7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C038006D; Wed, 29 Oct 2025 15:33:54 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA5F8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 15:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 91648C0DA83;
 Wed, 29 Oct 2025 14:33:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E212F606E8;
 Wed, 29 Oct 2025 14:33:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 757A4102F24F9; Wed, 29 Oct 2025 15:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761748430; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=lJNbGpaKEnVwZrLswNxTYjIKXCW9mz8cJmEDh+zxFiQ=;
 b=yLVB5/l7jE3l1JkHNN6IrOGqRP7yuTu9X+ADeNMyIV+zQkJVSLM0W5DWUBcjbXRi8yq5YT
 KMr8OkkEtw5E9AhCl7xk9CH4CvPlN3y9wJi9M64N/quzJKC5pcvbqfWfHUBz7beNAdMHeM
 FREbq/GFRmuUtNQ1QLlMc3wqRebv0G5/6zZl0VkPcE5Z2zNm8UwGzSXjOl6i8Fxul2A0DF
 M0nAqNc/Mnjq3Nvv7yT0HvBvA+6b/xyCnGm2BBXYchBMLWY8uCOuRMUrumRV8u+PiWB4Hg
 bxr5ZKGqcmoLw2sMMOXbJZk7PF7dO2M8uZkF6Q+E6w6sfOjiG9vcU6zkzu6hYA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] doc: pytest: Complete dependencies list with missing
 packages
Date: Wed, 29 Oct 2025 15:33:44 +0100
Message-ID: <20251029143346.1320868-1-kory.maincent@bootlin.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- Update the "incomplete" word for the list description.
---
 doc/develop/pytest/usage.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 779b2dbe24b..153e3c4091d 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -35,11 +35,11 @@ installed via the command
    pip install -r requirements.txt
 
 In order to execute certain tests on their supported platforms other tools
-will be required. The following is an incomplete list:
+will be required. The following tools may be needed:
 
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

