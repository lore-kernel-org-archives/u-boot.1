Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA576D6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7380084150;
	Thu,  2 Apr 2026 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H18d7aZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5FE840ED; Thu,  2 Apr 2026 17:29:05 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCC6840AA
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso104806385a.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143742; x=1775748542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=H18d7aZdAlwjgkELlBRWc712BEmKiQmQ4yn2Pqs90Mbz+wy054HcqdWBRDqx45/dan
 4wQvpKi+jGHhXc7IAWP4DyipZ5dINiIC7W9tuZq0FFhaKV/4d81LAg6W/laoJnuw1Bao
 TNfJYyS8s0oh9FcXRDPBzlMGGuzGuihJwhqSMJuY7Ie0xUFaQrD+08fAsLllAw5cO0a5
 JHx78kanBpK923npy4IJha5zk/KYqu/sn+Y7kVTnhE0d1PMhJQBVKCzTMHUE36KOzM2g
 mT+dhIbvr7uaqb0UYDl9+0TkG5vNGj3OCvEvUqKznfL4iGBkg21NfkEq2ZfwX08Vgnyy
 Atpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143742; x=1775748542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=bQe8Rwvu1RTBoZ1L+HQhxygvT0ndbfP3LImpH6CPw3g1ZEidA2daL17Mfwmj5TSH/G
 h89Ua5Gs6fdKikD8s7lw06LF2qxnmYqEvKa5lXQRHWdAhIU+3eYrYQqpuDec0MXDgnff
 96wtFpBEW4y1Z47qnFnUdHfU/bHn9H6Gx3xoHWagpzRONHsrCXGWxmnuuYhQzO2s2vKr
 aQ/FODLKKRn/0xbKXhP3jI3alJfmUse8WY7/10vwR1/UU3DGU0xcPeCTwlaAhASgoavx
 18L2HA0RQwt4Ghf1Kiw4BABWwinu0ATeNBldFPmlu86yDVvjxyhu5mNzQH2CBMbx6dGz
 Glug==
X-Gm-Message-State: AOJu0YyiTpVzw6Twa1e3MqyamMDqlE+ym37Mf65vJ9XGRWm/m6NAY2MZ
 vZ3fwGhALH/4Phr1eS9kOoDVBmdV/mcNOlPgYKLQS6eEC3jcB9Rs/NTNgqd1dRID
X-Gm-Gg: ATEYQzzmo2qU9trE9tkyuTRi9clDXf6iVgPKx8IMSzVThwue9djs6K/vb5UIwi5H6fG
 iQ5xST6Z8RaLeWW2rlqtK9sVPaA1lL/g6NyPV1nVeQwewWGLJ1Hwk5jfHKQnt2DhzZSVOvkLcK9
 uAXI8mNGfNRI/YQl5GY5bYcFLp3/BjcjIwOEqIS1bQ4dvrAk6a1fAfKrTWQmZRL8ga9NAHeWRpp
 cY6GllEnMUwga+mpq00rlN4PqnzFKl1Ts9QrEvmPDxfhwAGVZW94W9EewuxfixxW0IrhKtKgHhD
 3bJgYamTteoV2AUo94xeCyyCIWTfEcAjuf1oWjGTYqoiVIhGJ6cbCVRNxe3YzTiS7VvQdOEvvO7
 hniv6+1bWv68M32iF6j7Z0BLlbXBpvg+9FTXhNG2ccNk1Xn3As1dHvO9VeObUgy9FlInfaWMXRv
 4MR4T/SmeiJRwW13u/ktdC7cuQXp7XU4OFiA==
X-Received: by 2002:a05:620a:199f:b0:8cd:c0b6:87f7 with SMTP id
 af79cd13be357-8d2ad952805mr545122985a.46.1775143741866; 
 Thu, 02 Apr 2026 08:29:01 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:29:01 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 09/13] mach-sc5xx: Update image load address
Date: Thu,  2 Apr 2026 11:28:32 -0400
Message-Id: <3d71a46e63280991ab58cfed3abfbea2e800f885.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Update the load address for the image in
each environment to match the updated partitions
in Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 2 +-
 board/adi/sc584-ezkit/sc584-ezkit.env           | 2 +-
 board/adi/sc589-ezkit/sc589-ezkit.env           | 2 +-
 board/adi/sc589-mini/sc589-mini.env             | 2 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 2 +-
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 2 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index 36bd207f410..4ee08deb1b3 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 6d4b20d70f6..20e5ee0eb76 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index a4a686158ca..6f314542ecc 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 2a322bc6761..c5ea555411e 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index a4c72f2e9c7..4d86eafe145 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index f915175e041..bfce3a9c9b0 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 754dcece976..cbc5a57c755 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
-- 
2.34.1

