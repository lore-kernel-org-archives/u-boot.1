Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D724D10F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94F3840CF;
	Fri, 27 Mar 2026 17:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbc+k7b3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7815C83F14; Fri, 27 Mar 2026 14:51:57 +0100 (CET)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A25B83DA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-899a5db525cso16810856d6.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619514; x=1775224314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvxE5Hloqzcc5jpXeZ3mEbcBxJN7lUtsaReLiU2vHPA=;
 b=fbc+k7b3EHmXxZxRt30Y806EIJH5Gce0p7/RToPt7MD64xfKV5/o8ub0/OFFLfjdWW
 4fgKL9E8ck8ayzFFRDKK+jCw8iMz0aV+v/L3/zEFYanMtg6CSyzJrFKu5ukp3ku11Roc
 A5Clg3zoO5bdozSlOOCPyqqQLz3Sc8C3+7h+1ASVrBWSKy3UdR+7Kiy2p9F8ZGelvPxj
 1KqXBCuiy0kOheHxulzPcQjelor6rBYGJn9mBIKVyl4U4t+RxlqPeTis345qUUcGSdCD
 IkDrfPoJv+I4gOXVs1KOyI1H9jOoYONc367DdAgjZu8gyx9P6TCoaep51yL2k0HEd2bl
 foPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619514; x=1775224314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvxE5Hloqzcc5jpXeZ3mEbcBxJN7lUtsaReLiU2vHPA=;
 b=HuIYf5JG4DkB/yf6SUYkW7DqGyw3AbtXE50+plCrdkT/idVLpfT41Q+UoaAL72ZfVd
 SdB7ZufEzK19ZNRb4ywi6wwE6IFkjUfVd9ExC0nZVPoIiTeR7jmzCXjf/iKkQGvSTNTL
 2bFIGUQ/8E8bpsWZGtKWaGtRX1KU9Kezx6uYAEQveXtxTe2gbxE8+a3p92pww4c9ACMc
 7+G05wUrIK0D9WfpoHDss2ydRBuDopRtuo/11Z6EeJgipy79JC5XWF1h+OJmKwUOM54Q
 9BrP2+nlzfodIyIkwoahIEe5TFn/1B5bfogejhkJ4FuDujoAiOXqwQR8U8h/XOTiuLil
 6mMg==
X-Gm-Message-State: AOJu0Yw0xPBpGsYvCMwkyyNHvBTaIf7VSq9EvDMv39628xGwSs9lzHt3
 QcpIbHoGis4N1OJZNqh+rnVPZYr2i2cp4VnIxYCZEdtZ5It6EzqSj52U/MjdZG4z
X-Gm-Gg: ATEYQzyuVKj33W2v6nzZtHOgFcBFQfL14jjqQ72srwSN0a7jH2Ld2ostAXrIYnBN0xh
 R1PPgMEBFTFGCZe6bRnohLV7ZLbHeYfj0VXLioKmclEprAe7QapAvnsylXFgW3qAMs4YCygJvBK
 noV1nOIVq3UDpiZvKqpfjGSuVjkJjTMV9WyW+Xdi1RIo4s546ZvVuWDxQUMjwzq67HH09NLRrak
 VBxSwmDcUyoEZdy5o7nY8Uyo925C27UNdvS6wHH8ALhtk80ydOT8e+19zXbzwIvLiLGp+Zh4jij
 Yji7/iNPAFy0h/mYA8YV3LlyGcUYx8EWvGDFbv/OIWlxiVz5vBYvMA1SF1UL3toDUczMC2+RRaE
 xFuqjpbNldBQXJ/Wq07CkYvG7EP+20dwckGdpyhQ0E0etZ4n5WTZUfNEyYYKsq8zymwm19EhLa5
 br1Yzav45Ns9gL/JkHkwFHTXt/Gr1sm2RDaQ==
X-Received: by 2002:a05:6214:3a82:b0:89a:18c3:1e8a with SMTP id
 6a1803df08f44-89ce8ed05a9mr32463876d6.32.1774619513956; 
 Fri, 27 Mar 2026 06:51:53 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:53 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 09/13] mach-sc5xx: Update image load address
Date: Fri, 27 Mar 2026 09:49:24 -0400
Message-Id: <881f2cdb2783012dbbdf4ec15ce3a0ad966893b1.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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
index 14e875f2927..2ba58d05e0f 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index da64ebe093c..26edc67651a 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 2603d92c45a..181140adf53 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 7390fb5fd6f..68d6e2c1567 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 62d23e8637f..5dc82b46ddf 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 2fd2295e1e0..e983d9e40a6 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index e26601c3330..c935d91a210 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -5,7 +5,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
-- 
2.34.1

