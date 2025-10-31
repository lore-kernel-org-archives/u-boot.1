Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61B5CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8389E83A3D;
	Fri, 31 Oct 2025 17:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="12H/eq5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B02983A1B; Fri, 31 Oct 2025 17:36:24 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359A083A2D
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E36481A17B8;
 Fri, 31 Oct 2025 16:36:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8F1E60704;
 Fri, 31 Oct 2025 16:36:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 296ED11818082; Fri, 31 Oct 2025 17:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761928581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UnpDOdQkM8a6BBRT2+oVik7jKyrLCQBVaIwS7xAW8WY=;
 b=12H/eq5G6JYhSlK9NoxSRTaSf8u93LC7OZBDlT5P7Y5JEWAvxCfr/N15E2SW+J6/zu5mKo
 ALw6RBovggsYJgR9TPcXqoeT30MvGrTctt0qYnJlkKScx81C9N942Rwpu4iqemoYhUgq/J
 9/BWRJKyQpVAdIW7Z3hRwNLuHfQdvbio63MjqkAke2RjaqT6h9VqVuouQby39aPxuraHr2
 B4y0q82UZX46Z8s2YOQErWS93yMM5tFhk2TIJC1Q44I2zJ737ero+sXdHV0ydsVFvwnAL8
 pxZEJoWe8zSGb3zRJmRXHFXU8L80+ZiMehyH62APzbVlq7FrT04UYDM1idumUw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 31 Oct 2025 17:36:03 +0100
Subject: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
In-Reply-To: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
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

Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid for block
devices") added support for the distro_boot_part_uuid environment variable
to allow using PARTUUID in the kernel command line.

However, the way it was written only supports the case where the boot files
and the rootfs are located in the same partition. There are many cases
where the boot partition and rootfs partition are separate.

Add a customizable find_distro_rootpart command to allow each board to
define its own logic for locating the rootfs partition. This provides
flexibility for boards with custom partition layouts while maintaining
backward compatibility for the default case where boot and rootfs share
the same partition.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 doc/develop/distro.rst          | 11 +++++++++++
 include/config_distro_bootcmd.h | 10 +++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 01efce40a29..4468cf7c95a 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -312,6 +312,17 @@ scriptaddr:
 
   A size of 1MB for extlinux.conf is more than adequate.
 
+find_distro_rootpart:
+  Optional. Sets the rootfs partition by applying distro boot enumeration logic,
+  allowing the boot partition environment variables (distro_bootpart, devtype,
+  devnum, etc.) to be reused for rootfs detection.
+
+  For example::
+
+    "find_distro_rootpart=" \
+        "setexpr distro_rootpart ${distro_bootpart} + 1 ;" \
+        "part uuid ${devtype} ${devnum}:${distro_rootpart} rootpart_uuid ;\0"
+
 For suggestions on memory locations for ARM systems, you must follow the
 guidelines specified in Documentation/arm/Booting in the Linux kernel tree.
 
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 7b6ac6eed9d..d0e125af6f8 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -549,9 +549,13 @@
 			"if fstype ${devtype} "                           \
 					"${devnum}:${distro_bootpart} "   \
 					"bootfstype; then "               \
-				"part uuid ${devtype} "                   \
-					"${devnum}:${distro_bootpart} "   \
-					"distro_bootpart_uuid ; "         \
+				"if test -n ${find_distro_rootpart}; then " \
+					"run find_distro_rootpart; "      \
+				"else "                                   \
+					"part uuid ${devtype} "           \
+						"${devnum}:${distro_bootpart} " \
+						"distro_bootpart_uuid ; " \
+				"fi; "                                    \
 				"run scan_dev_for_boot; "                 \
 			"fi; "                                            \
 		"done; "                                                  \

-- 
2.43.0

