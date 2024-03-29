Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACA7C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0E188212;
	Fri, 29 Mar 2024 13:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rjHo9YM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18C5881D0; Fri, 29 Mar 2024 13:00:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027C788219
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 37C333F077; 
 Fri, 29 Mar 2024 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711713653;
 bh=hlFpMpk9T33gv1f1O2fsp1wXpkfMZ4zaB4m3PaKHucU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rjHo9YM3sMu+C1YZ6w45D+AeFAq35uE+BQanx+vpEKEy4xrgqgov+VYwTm2vsmkZ7
 zoXoBFIDgIF3T9+jZsJn9iHT9C56t6HKYyILyGvwCMOn9DBy83x8okWlBcy4mVDZiL
 3rOH2begRVOWdMmAsY6klodHxchfBWsr5DElsd4PlgA2i4W0AqJ0ZECpBCWqRMZzGM
 AJbQ0/s3lgFFGPlu39WwVIIleYLXjz3r9N0nTws88jCDgq+HjkyhQKGfHvAveEl5hP
 HOVmYtQZsNvX5oC2kJr2n1Avb5jkSM716HPlKt2fCy3nEUlrF+8VI4u9zdfFjoMuAc
 HE6OgxVgd02bw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: improve description of FAT partition name generation
Date: Fri, 29 Mar 2024 13:01:00 +0100
Message-ID: <20240329120100.9335-1-heinrich.schuchardt@canonical.com>
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

List all prefix currently used for generating FAT partition names.
Describe which device class uses which prefix.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/partitions.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/usage/partitions.rst b/doc/usage/partitions.rst
index 628469bbec9..acf4573097d 100644
--- a/doc/usage/partitions.rst
+++ b/doc/usage/partitions.rst
@@ -44,9 +44,20 @@ partname
                 <devtype><devletter><partnum>
 
         devtype
-                A device type like ``mmcsd`` or ``hd``. See the
-                ``part_set_generic_name`` function in ``disk/part.c`` for a
-                complete list.
+                The devtype field is set in dependence of the device class:
+
+                ======= ===============
+                devtype device class
+                ======= ===============
+                hd      IDE or SATA
+                sd      SCSI
+                usbd    USB
+                mmcsd   eMMC or SD-card
+                xx      others
+                ======= ===============
+
+                See the ``part_set_generic_name`` function in ``disk/part.c``
+                for the complete list.
 
         devletter
                 The device number as an offset from ``a``. For example, device
-- 
2.43.0

